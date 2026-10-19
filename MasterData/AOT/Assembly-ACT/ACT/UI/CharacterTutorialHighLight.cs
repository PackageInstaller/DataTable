using System;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Runtime.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterTutorialHighLight : MonoBehaviour
{
	private enum CharacterTutorialHighlightTextPosType
	{
		Up,
		Down,
		Left,
		Right
	}

	[SerializeField]
	private RectTransform frame;

	[SerializeReference]
	private Material rectMaterial;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private RectTransform textRoot;

	[SerializeField]
	private TextMeshProUGUI textLocalize;

	[SerializeField]
	private RectTransform arrow;

	[SerializeField]
	private BetterAnimation betterAnimation;

	[SerializeField]
	private Image cdImage;

	private float countDownRootDefaultHeight = 110f;

	[SerializeField]
	private RectTransform textGroupRT;

	[SerializeField]
	private RectTransform countDownRootRT;

	[SerializeField]
	private RectTransform descRT;

	private Looper _looper;

	private Delayer _startDelayer;

	private int _countdownVersion;

	private Material _runtimeRectMaterial;

	private Material _runtimeLeftRectMaterial;

	private OperateBtnComp _operateBtnComp;

	private CharacterOperateBtnUIGroup _operateBtnGroup;

	private SpecialEnergyBar _specialEnergyBar;

	private EnergyBar _energyBar;

	private string[] _path;

	private Transform highLightAreaTransfrom;

	private Transform leftDescAreaTransfrom;

	private RectTransform leftDescAreaRectTransform;

	private RectTransform _battleMainViewControlTransform;

	[SerializeField]
	private GameObject leftFrameObj;

	[SerializeField]
	private RectTransform leftFrame;

	[SerializeField]
	private Image LeftBg;

	[SerializeReference]
	private Material leftRectMaterial;

	private NodeMessage configData;

	private GameObject _trainingGroup;

	private string[] pathArr;

	private Vector2 leftFrameSize;

	private bool _pausePushed;

	private bool _isDisposed;

	private float _time;

	private const int DefaultArrowDistance = 10;

	private const float ArrowSpacingAboveFrame = 20f;

	private const int TargetNumsTextPosIndex = 0;

	private const int TargetNumsTextOffsetIndex = 1;

	private const float TextGroupDefaultWidth = 600f;

	private const float TextGroupMinWidth = 360f;

	private const float TextGroupLeftPadding = 40f;

	private const float TextGroupRightPadding = 40f;

	private const float TextGroupVerticalPadding = 50f;

	private const float TextGroupVisualInset = 30f;

	private const float CountDownOffsetFromTextRight = 32f;

	private const float CountDownMinScale = 0.4f;

	private bool _useTextPosConfig;

	private CharacterTutorialHighlightTextPosType _textPosType;

	private int _textOffset;

	private Vector2 _textGroupDefaultAnchoredPosition;

	private bool _textGroupLayoutDriversDisabled;

	private Vector3[] frameWorldCorner = new Vector3[4];

	private Vector2 center;

	private float width;

	private float height;

	private Vector3[] leftframeWorldCorner = new Vector3[4];

	private Vector2 leftcenter;

	private float leftwidth;

	private float leftheight;

	private void Refresh()
	{
		if (_looper.IsValid())
		{
			return;
		}
		float timer = _time;
		int countdownVersion = _countdownVersion;
		_startDelayer = FixedUpdateTimer.Default.DelayMs(1000, () =>
		{
			_startDelayer = default;
			if (_countdownVersion == countdownVersion && CanUpdateHighLight())
			{
				_looper = FixedUpdateTimer.Default.LoopMs(1000, () =>
				{
					if (_countdownVersion != countdownVersion || !CanUpdateHighLight())
					{
						_looper.Cancel();
						_looper = default;
					}
					else
					{
						timer--;
						UpdateCdImage(timer);
						if (timer <= 0f)
						{
							CloseHighLightByTimeout();
						}
					}
				});
			}
		});
	}

	private void UpdateCdImage(float countdown)
	{
		if (countdown >= 0f)
		{
			cdImage.fillAmount = countdown / _time;
		}
	}

	public void Init(OperateBtnComp operateBtnComp, int nodeId, GameObject trainingGroup)
	{
		configData = CoreUtils.GetData(nodeId, RuntimeConfigs.data.nodeMessages);
		if (configData == null)
		{
			Model<CharacterTutorialModel>.Interface.CharacterTutorialShowHighLight = false;
			gameObject.SetActive(value: false);
		}
		else
		{
			InitInternal(operateBtnComp, trainingGroup, configData.secondEnergyText, configData.secondEnergyFrame, null);
		}
	}

	public void InitTeam(OperateBtnComp operateBtnComp, RectTransform battleMainViewControlTransform, int nodeId, GameObject trainingGroup)
	{
		TeamAtackRutorial data = CoreUtils.GetData(nodeId, RuntimeConfigs.data.teamAtackRutorials);
		if (data == null)
		{
			Model<CharacterTutorialModel>.Interface.CharacterTutorialShowHighLight = false;
			gameObject.SetActive(value: false);
		}
		else
		{
			InitInternal(operateBtnComp, trainingGroup, data.targetText, data.targetFrame, data.targetNums, battleMainViewControlTransform);
		}
	}

	private void InitInternal(OperateBtnComp operateBtnComp, GameObject trainingGroup, int textId, string[] framePath, int[] targetNums, RectTransform battleMainViewControlTransform = null)
	{
		CancelCountdownTimers();
		_isDisposed = false;
		gameObject.SetActive(value: true);
		_textGroupLayoutDriversDisabled = false;
		_operateBtnComp = operateBtnComp;
		_battleMainViewControlTransform = battleMainViewControlTransform;
		int num = (Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial ? Model<CharacterTutorialModel>.Interface.MainCharacterTutorialId : Model<CharacterTutorialModel>.Interface.CharacterTutorialId);
		Character curCharacterByCharacterId = CharacterDataHelper.GetCurCharacterByCharacterId(num);
		if (curCharacterByCharacterId == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到id为{num}的出战角色");
			}
			AbortInitialization();
			return;
		}
		if (!EntityHelper.TryGetBattleEntityByCharacter(curCharacterByCharacterId, out var entity) || !entity.IsAlive())
		{
			AbortInitialization();
			return;
		}
		_operateBtnGroup = _operateBtnComp.GetGroup(entity.Id);
		if (_operateBtnGroup == null)
		{
			AbortInitialization();
			return;
		}
		_specialEnergyBar = _operateBtnGroup.SpecialEnergyBar;
		_energyBar = _operateBtnGroup.EnergyBar;
		_trainingGroup = trainingGroup;
		leftDescAreaTransfrom = null;
		leftDescAreaRectTransform = null;
		if (framePath == null || framePath.Length == 0 || string.IsNullOrEmpty(framePath[0]))
		{
			AbortInitialization();
			return;
		}
		_path = framePath;
		_useTextPosConfig = TryGetTextPosType(targetNums, out _textPosType, out _textOffset);
		_textGroupDefaultAnchoredPosition = ((textGroupRT != null) ? textGroupRT.anchoredPosition : Vector2.zero);
		pathArr = _path[0].Split(",");
		highLightAreaTransfrom = Find(pathArr[0]);
		if (highLightAreaTransfrom == null)
		{
			AbortInitialization();
			return;
		}
		InitBg();
		if (!InitFrame(highLightAreaTransfrom))
		{
			AbortInitialization();
			return;
		}
		PushPauseSafe();
		if (pathArr.Length > 1 && _trainingGroup != null && leftFrameObj != null && leftFrame != null && LeftBg != null)
		{
			leftDescAreaTransfrom = _trainingGroup.transform;
			leftDescAreaRectTransform = leftDescAreaTransfrom as RectTransform;
			if (leftDescAreaRectTransform != null)
			{
				leftFrameSize = leftDescAreaRectTransform.sizeDelta;
				InitLeftHighLightBg();
				InitLeftFrame(leftDescAreaTransfrom);
			}
		}
		Model<CharacterTutorialModel>.Interface.HighLightCountDataDicAdd(isOpened: true);
		InitText(textId);
		_time = RuntimeConfigs.data.game.SubEnergyGuideTime;
		if (cdImage != null)
		{
			cdImage.fillAmount = 1f;
		}
		Refresh();
		betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			betterAnimation.GetSequence("Loop").Play().SetLoops(-1);
		}).Play();
	}

	private void Update()
	{
		if (pathArr != null && pathArr.Length > 1 && leftDescAreaTransfrom != null && leftDescAreaRectTransform != null && leftFrameObj != null && leftFrame != null && LeftBg != null)
		{
			Vector2 sizeDelta = leftDescAreaRectTransform.sizeDelta;
			if (!leftFrameSize.Equals(sizeDelta))
			{
				leftFrameSize = sizeDelta;
				InitLeftHighLightBg();
				InitLeftFrame(leftDescAreaTransfrom);
			}
		}
	}

	public Transform Find(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return null;
		}
		Transform transform = _specialEnergyBar.transform.Find(path);
		if (transform == null)
		{
			transform = _energyBar.transform.Find(path);
		}
		if (transform == null)
		{
			transform = ((_trainingGroup != null) ? _trainingGroup.transform.Find(path) : null);
		}
		if (transform == null && _trainingGroup != null)
		{
			transform = FindInChildren(_trainingGroup.transform, path);
		}
		if (transform == null && _battleMainViewControlTransform != null)
		{
			transform = _battleMainViewControlTransform.Find(path);
		}
		if (transform == null)
		{
			return null;
		}
		return transform;
	}

	private Transform FindInChildren(Transform root, string targetName)
	{
		if (root == null || string.IsNullOrEmpty(targetName))
		{
			return null;
		}
		for (int i = 0; i < root.childCount; i++)
		{
			Transform child = root.GetChild(i);
			if (child.name == targetName)
			{
				return child;
			}
			Transform transform = FindInChildren(child, targetName);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}

	private void InitBg()
	{
		if (_runtimeRectMaterial == null)
		{
			_runtimeRectMaterial = new Material(rectMaterial);
		}
		bg.material = _runtimeRectMaterial;
		RectTransform rectTransform = bg.rectTransform;
		rectTransform.pivot = 0.5f * Vector2.one;
		rectTransform.anchorMin = Vector2.zero;
		rectTransform.anchorMax = Vector2.one;
		rectTransform.offsetMin = new Vector2(-200f, -200f);
		rectTransform.offsetMax = new Vector2(200f, 200f);
		rectTransform.localScale = Vector3.one;
	}

	private void InitLeftHighLightBg()
	{
		leftFrameObj.SetActive(value: true);
		if (_runtimeLeftRectMaterial == null)
		{
			_runtimeLeftRectMaterial = new Material((leftRectMaterial != null) ? leftRectMaterial : rectMaterial);
		}
		LeftBg.material = _runtimeLeftRectMaterial;
		RectTransform rectTransform = LeftBg.rectTransform;
		rectTransform.pivot = 0.5f * Vector2.one;
		rectTransform.anchorMin = new Vector2(0.5f, 0.5f);
		rectTransform.anchorMax = new Vector2(0.5f, 0.5f);
		rectTransform.position = leftFrame.position;
		rectTransform.sizeDelta = leftFrame.sizeDelta;
		rectTransform.sizeDelta += new Vector2(20f, 20f);
	}

	private bool InitFrame(Transform t)
	{
		RectTransform rectTransform = t as RectTransform;
		if (rectTransform == null)
		{
			return false;
		}
		if (!rectTransform.gameObject.activeInHierarchy)
		{
			return false;
		}
		if (rectTransform.rect.width <= 0.001f || rectTransform.rect.height <= 0.001f)
		{
			return false;
		}
		Vector3 vector = GameUtility.uiCamera.WorldToScreenPoint(UIUtility.GetWorldPosIgnorePivot(rectTransform));
		if (!(vector.x >= 0f) || !(vector.x <= (float)Screen.width) || !(vector.y >= 0f) || !(vector.y <= (float)Screen.height))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		frame.position = UIUtility.GetWorldPosIgnorePivot(rectTransform);
		frame.sizeDelta = rectTransform.sizeDelta;
		Vector3[] worldCorners = UIUtility.GetWorldCorners(rectTransform);
		Vector3[] worldCorners2 = UIUtility.GetWorldCorners(frame);
		float num = worldCorners[2].x - worldCorners[0].x;
		float num2 = worldCorners2[2].x - worldCorners2[0].x;
		if (Mathf.Abs(num) <= 0.001f || Mathf.Abs(num2) <= 0.001f)
		{
			return false;
		}
		frame.sizeDelta *= num / num2;
		InitBgMaterialParam();
		return true;
	}

	private void InitLeftFrame(Transform t)
	{
		RectTransform rectTransform = t as RectTransform;
		leftFrame.position = UIUtility.GetWorldPosIgnorePivot(rectTransform);
		leftFrame.sizeDelta = rectTransform.sizeDelta;
		Vector3[] worldCorners = UIUtility.GetWorldCorners(rectTransform);
		Vector3[] worldCorners2 = UIUtility.GetWorldCorners(leftFrame);
		float num = worldCorners[2].x - worldCorners[0].x;
		float num2 = worldCorners2[2].x - worldCorners2[0].x;
		if (Mathf.Abs(num2) > 0.001f)
		{
			leftFrame.sizeDelta *= num / num2;
		}
		InitLeftBgMaterialParam();
	}

	private void InitBgMaterialParam()
	{
		frame.GetWorldCorners(frameWorldCorner);
		for (int i = 0; i < frameWorldCorner.Length; i++)
		{
			frameWorldCorner[i] = WorldToScreenPoint(GameUtility.uiCanvas, frameWorldCorner[i]);
		}
		center.x = frameWorldCorner[0].x + (frameWorldCorner[3].x - frameWorldCorner[0].x) / 2f;
		center.y = frameWorldCorner[0].y + (frameWorldCorner[1].y - frameWorldCorner[0].y) / 2f;
		width = (frameWorldCorner[3].x - frameWorldCorner[0].x) / 2f;
		height = (frameWorldCorner[1].y - frameWorldCorner[0].y) / 2f;
		_runtimeRectMaterial.SetVector("_Center", center);
		_runtimeRectMaterial.SetFloat("_SliderX", width);
		_runtimeRectMaterial.SetFloat("_SliderY", height);
	}

	private void InitLeftBgMaterialParam()
	{
		leftFrame.GetWorldCorners(leftframeWorldCorner);
		for (int i = 0; i < leftframeWorldCorner.Length; i++)
		{
			leftframeWorldCorner[i] = WorldToScreenPoint(GameUtility.uiCanvas, leftframeWorldCorner[i]);
		}
		leftcenter.x = leftframeWorldCorner[0].x + (leftframeWorldCorner[3].x - leftframeWorldCorner[0].x) / 2f;
		leftcenter.y = leftframeWorldCorner[0].y + (leftframeWorldCorner[1].y - leftframeWorldCorner[0].y) / 2f;
		leftwidth = (leftframeWorldCorner[3].x - leftframeWorldCorner[0].x) / 2f;
		leftheight = (leftframeWorldCorner[1].y - leftframeWorldCorner[0].y) / 2f;
		if (_runtimeLeftRectMaterial != null)
		{
			_runtimeLeftRectMaterial.SetVector("_Center", leftcenter);
			_runtimeLeftRectMaterial.SetFloat("_SliderX", 0f);
			_runtimeLeftRectMaterial.SetFloat("_SliderY", leftheight);
		}
	}

	private Vector2 WorldToScreenPoint(Canvas canvas, Vector3 world)
	{
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(canvas.worldCamera, world);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, screenPoint, canvas.worldCamera, out var localPoint);
		return localPoint;
	}

	private void InitText(int textId)
	{
		textLocalize.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, textId));
		DisableTextGroupLayoutDrivers();
		RefreshLayoutAsync(textGroupRT).Forget();
	}

	public async UniTask RefreshLayoutAsync(RectTransform rectTransform, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (rectTransform == null)
		{
			return;
		}
		try
		{
			await RefreshLayoutBasicAsync(rectTransform, cancellationToken);
		}
		catch (OperationCanceledException)
		{
			Debug.Log("布局刷新任务被取消");
		}
		catch (Exception ex2)
		{
			Debug.LogError("布局刷新失败: " + ex2.Message);
			throw;
		}
	}

	private async UniTask RefreshLayoutBasicAsync(RectTransform rectTransform, CancellationToken cancellationToken)
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		await UniTask.NextFrame(cancellationToken);
		if (CanUpdateHighLight())
		{
			Canvas.ForceUpdateCanvases();
			await UniTask.NextFrame(cancellationToken);
			if (CanUpdateHighLight())
			{
				CalculatePosition();
			}
		}
	}

	private void CalculatePosition()
	{
		ApplyTextArrow();
		RefreshTextGroupLayout();
		if (_useTextPosConfig)
		{
			ApplyTextRootConfigOffset();
		}
		else
		{
			AlignArrowAboveFrame();
		}
	}

	private void RefreshTextGroupLayout()
	{
		if (!(textGroupRT == null) && !(descRT == null) && !(textLocalize == null) && !(countDownRootRT == null))
		{
			DisableTextGroupLayoutDrivers();
			float maxTextGroupWidth = GetMaxTextGroupWidth();
			textLocalize.ForceMeshUpdate();
			float a = Mathf.Ceil(textLocalize.GetPreferredValues(textLocalize.text, 0f, 0f).x);
			float num = 0.4f;
			float num2 = countDownRootDefaultHeight * num;
			float num3 = 1f;
			float num4 = 0f;
			float num5 = 0f;
			for (int i = 0; i < 3; i++)
			{
				float maxDescWidth = GetMaxDescWidth(maxTextGroupWidth, num2);
				num3 = Mathf.Max(1f, Mathf.Min(a, maxDescWidth));
				num4 = Mathf.Ceil(textLocalize.GetPreferredValues(textLocalize.text, num3, 0f).y);
				num5 = Mathf.Max(num4 + 50f + 60f, countDownRootDefaultHeight * 0.4f + 60f);
				num = GetCountDownScale(num5);
				num2 = countDownRootDefaultHeight * num;
			}
			descRT.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, num4);
			descRT.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num3);
			descRT.anchorMin = new Vector2(0f, 1f);
			descRT.anchorMax = new Vector2(0f, 1f);
			descRT.pivot = new Vector2(0.5f, 0f);
			descRT.anchoredPosition = new Vector2(40f + num3 * 0.5f, (0f - (num5 + num4)) * 0.5f);
			float value = 40f + num3 + 32f + num2 + 40f + 30f;
			value = Mathf.Clamp(value, 360f, maxTextGroupWidth);
			textGroupRT.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, value);
			textGroupRT.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, num5);
			RefreshTextGroupPosition(value);
			RefreshCountDownTransform(num3, num5, num);
		}
	}

	private void DisableTextGroupLayoutDrivers()
	{
		if (!_textGroupLayoutDriversDisabled)
		{
			DisableLayoutDrivers(textGroupRT);
			DisableLayoutDrivers(descRT);
			_textGroupLayoutDriversDisabled = true;
		}
	}

	private void DisableLayoutDrivers(RectTransform rectTransform)
	{
		if (!(rectTransform == null))
		{
			ContentSizeFitter[] components = rectTransform.GetComponents<ContentSizeFitter>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].enabled = false;
			}
			LayoutGroup[] components2 = rectTransform.GetComponents<LayoutGroup>();
			for (int i = 0; i < components2.Length; i++)
			{
				components2[i].enabled = false;
			}
		}
	}

	private float GetMaxDescWidth(float maxGroupWidth, float countDownWidth)
	{
		return Mathf.Max(1f, maxGroupWidth - 30f - 40f - 40f - 32f - countDownWidth);
	}

	private float GetMaxTextGroupWidth()
	{
		if (!_useTextPosConfig || (_textPosType != CharacterTutorialHighlightTextPosType.Left && _textPosType != CharacterTutorialHighlightTextPosType.Right))
		{
			return 600f;
		}
		RectTransform rectTransform = ((GameUtility.uiCanvas != null) ? (GameUtility.uiCanvas.transform as RectTransform) : null);
		if (rectTransform == null || frame == null)
		{
			return 600f;
		}
		rectTransform.GetWorldCorners(frameWorldCorner);
		float x = WorldToScreenPoint(GameUtility.uiCanvas, frameWorldCorner[0]).x;
		float x2 = WorldToScreenPoint(GameUtility.uiCanvas, frameWorldCorner[2]).x;
		float x3 = WorldToScreenPoint(GameUtility.uiCanvas, textRoot.position).x;
		float b = ((_textPosType == CharacterTutorialHighlightTextPosType.Left) ? (x3 - x - 40f) : (x2 - x3 - 40f));
		return Mathf.Max(360f, b);
	}

	private void RefreshTextGroupPosition(float groupWidth)
	{
		if (!_useTextPosConfig)
		{
			textGroupRT.anchoredPosition = _textGroupDefaultAnchoredPosition;
			return;
		}
		switch (_textPosType)
		{
		case CharacterTutorialHighlightTextPosType.Left:
			textGroupRT.anchoredPosition = new Vector2((0f - groupWidth) * 0.5f, _textGroupDefaultAnchoredPosition.y);
			break;
		case CharacterTutorialHighlightTextPosType.Right:
			textGroupRT.anchoredPosition = new Vector2(groupWidth * 0.5f, _textGroupDefaultAnchoredPosition.y);
			break;
		default:
			textGroupRT.anchoredPosition = _textGroupDefaultAnchoredPosition;
			break;
		}
	}

	private float GetCountDownScale(float textGroupHeight)
	{
		return Mathf.Clamp(Mathf.Max(0f, textGroupHeight - 60f) / countDownRootDefaultHeight, 0.4f, 1f);
	}

	private void RefreshCountDownTransform(float descWidth, float textGroupHeight, float countDownScale)
	{
		float num = countDownScale;
		float num2 = countDownRootDefaultHeight * num * 0.5f;
		float num3 = (Mathf.Max(0f, textGroupRT.rect.width - 30f) - 40f - 40f - descWidth - 32f) / countDownRootDefaultHeight;
		if (num3 > 0f)
		{
			num = Mathf.Min(num, num3);
			num2 = countDownRootDefaultHeight * num * 0.5f;
		}
		countDownRootRT.localScale = new Vector3(num, num, 1f);
		countDownRootRT.anchorMin = new Vector2(0f, 1f);
		countDownRootRT.anchorMax = new Vector2(0f, 1f);
		countDownRootRT.pivot = new Vector2(0.5f, 0.5f);
		float x = 40f + descWidth + 32f + num2;
		float num4 = 30f + num2;
		float max = Mathf.Max(num4, textGroupHeight - 30f - num2);
		float y = 0f - Mathf.Clamp(textGroupHeight * 0.5f, num4, max);
		countDownRootRT.anchoredPosition = new Vector2(x, y);
	}

	private void ApplyTextArrow()
	{
		if (_useTextPosConfig && !(arrow == null))
		{
			switch (_textPosType)
			{
			case CharacterTutorialHighlightTextPosType.Up:
				arrow.anchorMin = new Vector2(0.5f, 0f);
				arrow.anchorMax = new Vector2(0.5f, 0f);
				arrow.anchoredPosition = new Vector2(0f, -10f);
				arrow.rotation = Quaternion.Euler(0f, 0f, 90f);
				break;
			case CharacterTutorialHighlightTextPosType.Left:
				arrow.anchorMin = new Vector2(1f, 0.5f);
				arrow.anchorMax = new Vector2(1f, 0.5f);
				arrow.anchoredPosition = new Vector2(10f, 0f);
				arrow.rotation = Quaternion.Euler(0f, 0f, 180f);
				break;
			case CharacterTutorialHighlightTextPosType.Right:
				arrow.anchorMin = new Vector2(0f, 0.5f);
				arrow.anchorMax = new Vector2(0f, 0.5f);
				arrow.anchoredPosition = new Vector2(-10f, 0f);
				arrow.rotation = Quaternion.Euler(0f, 0f, 0f);
				break;
			default:
				arrow.anchorMin = new Vector2(0.5f, 1f);
				arrow.anchorMax = new Vector2(0.5f, 1f);
				arrow.anchoredPosition = new Vector2(0f, 10f);
				arrow.rotation = Quaternion.Euler(0f, 0f, -90f);
				break;
			}
		}
	}

	private void AlignArrowAboveFrame()
	{
		if (textRoot == null || frame == null || arrow == null)
		{
			return;
		}
		RectTransform rectTransform = textRoot.parent as RectTransform;
		if (!(rectTransform == null))
		{
			Vector3[] array = new Vector3[4];
			Vector3[] array2 = new Vector3[4];
			frame.GetWorldCorners(array);
			arrow.GetWorldCorners(array2);
			Vector3 vector = (array[1] + array[2]) * 0.5f;
			Vector3 vector2 = (array[0] + array[2]) * 0.5f;
			Vector3 vector3 = array2[0];
			Vector3 vector4 = array2[0];
			for (int i = 1; i < array2.Length; i++)
			{
				vector3 = Vector3.Min(vector3, array2[i]);
				vector4 = Vector3.Max(vector4, array2[i]);
			}
			Vector3 lossyScale = rectTransform.lossyScale;
			float num = 20f * Mathf.Abs((lossyScale.y < 0.0001f) ? 1f : lossyScale.y);
			Vector3 vector5 = vector + rectTransform.up * num;
			Vector3 vector6 = (vector3 + vector4) * 0.5f;
			textRoot.position += new Vector3(vector2.x - vector6.x, vector5.y - vector3.y, 0f);
		}
	}

	private void ApplyTextRootConfigOffset()
	{
		if (!(textRoot == null) && !(frame == null))
		{
			Vector2 vector = _textPosType switch
			{
				CharacterTutorialHighlightTextPosType.Up => Vector2.up * _textOffset, 
				CharacterTutorialHighlightTextPosType.Left => Vector2.left * _textOffset, 
				CharacterTutorialHighlightTextPosType.Right => Vector2.right * _textOffset, 
				_ => Vector2.down * _textOffset, 
			};
			textRoot.anchoredPosition = frame.anchoredPosition + vector;
		}
	}

	private bool TryGetTextPosType(int[] targetNums, out CharacterTutorialHighlightTextPosType textPosType, out int textOffset)
	{
		textPosType = CharacterTutorialHighlightTextPosType.Down;
		textOffset = 0;
		if (targetNums == null || targetNums.Length <= 1)
		{
			return false;
		}
		int num = targetNums[0];
		if (!Enum.IsDefined(typeof(CharacterTutorialHighlightTextPosType), num))
		{
			return false;
		}
		textPosType = (CharacterTutorialHighlightTextPosType)num;
		textOffset = targetNums[1];
		return true;
	}

	private void OnDestroy()
	{
		_isDisposed = true;
		CancelCountdownTimers();
		if (_runtimeRectMaterial != null)
		{
			UnityEngine.Object.Destroy(_runtimeRectMaterial);
			_runtimeRectMaterial = null;
		}
		if (_runtimeLeftRectMaterial != null)
		{
			UnityEngine.Object.Destroy(_runtimeLeftRectMaterial);
			_runtimeLeftRectMaterial = null;
		}
		if (Model<CharacterTutorialModel>.HasInstance())
		{
			Model<CharacterTutorialModel>.Interface.CharacterTutorialShowHighLight = false;
		}
		PopPauseSafe();
	}

	private void OnDisable()
	{
		_isDisposed = true;
		CancelCountdownTimers();
		pathArr = null;
		if (leftFrameObj != null)
		{
			leftFrameObj.SetActive(value: false);
		}
		if (Model<CharacterTutorialModel>.HasInstance())
		{
			Model<CharacterTutorialModel>.Interface.CharacterTutorialShowHighLight = false;
		}
		PopPauseSafe();
	}

	private bool CanUpdateHighLight()
	{
		if (!_isDisposed && this != null && gameObject != null)
		{
			return gameObject.activeInHierarchy;
		}
		return false;
	}

	private void CloseHighLightByTimeout()
	{
		CancelCountdownTimers();
		if (cdImage != null)
		{
			cdImage.fillAmount = 1f;
		}
		pathArr = null;
		if (leftFrameObj != null)
		{
			leftFrameObj.SetActive(value: false);
		}
		if (Model<CharacterTutorialModel>.HasInstance())
		{
			CharacterTutorialModel characterTutorialModel = Model<CharacterTutorialModel>.Interface;
			characterTutorialModel.CharacterTutorialShowHighLight = false;
			characterTutorialModel.HighLightCountDataDicAdd(isOpened: false);
		}
		PopPauseSafe();
		if (this != null && gameObject != null)
		{
			gameObject.SetActive(value: false);
		}
	}

	private void CancelCountdownTimers()
	{
		_countdownVersion++;
		if (_startDelayer.IsValid())
		{
			_startDelayer.Cancel();
		}
		if (_looper.IsValid())
		{
			_looper.Cancel();
		}
		_startDelayer = default;
		_looper = default;
	}

	private void AbortInitialization()
	{
		CancelCountdownTimers();
		pathArr = null;
		if (leftFrameObj != null)
		{
			leftFrameObj.SetActive(value: false);
		}
		if (Model<CharacterTutorialModel>.HasInstance())
		{
			Model<CharacterTutorialModel>.Interface.CharacterTutorialShowHighLight = false;
		}
		PopPauseSafe();
		gameObject.SetActive(value: false);
	}

	private void PushPauseSafe()
	{
		if (!_pausePushed)
		{
			MonoECS.instance.PushPause();
			MonoECS.instance.PushPauseAllInput();
			_pausePushed = true;
		}
	}

	private void PopPauseSafe()
	{
		if (_pausePushed)
		{
			MonoECS.instance.PopPause();
			MonoECS.instance.PopPauseAllInput();
			_pausePushed = false;
		}
	}
}
