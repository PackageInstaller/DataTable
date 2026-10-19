using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MapPointArrow : MonoBehaviour
{
	[Header("UI组件")]
	[SerializeField]
	protected GameObject arrow;

	[SerializeField]
	protected Transform steadyPosition;

	[SerializeField]
	protected TMP_Text distanceText;

	[SerializeField]
	protected LayoutGroup layoutGroup;

	[SerializeField]
	protected RectTransform distanceRoot;

	[SerializeField]
	protected BImage pointImage;

	[SerializeField]
	protected CanvasGroup canvasGroup;

	[Header("动画")]
	[SerializeField]
	protected BetterAnimation animation;

	[Header("配置")]
	[SerializeField]
	protected Vector3 inScreenOffset = new Vector3(0f, 50f, 0f);

	protected bool _inScreen;

	protected bool _inScreenLeft;

	private MapPointTraceInfo _traceInfo;

	private Vector3 _targetWorldPos;

	private int _spriteId;

	public bool IsInsideScreen => _inScreen;

	public bool IsShow
	{
		get
		{
			if (gameObject.activeSelf)
			{
				return canvasGroup.alpha > 0f;
			}
			return false;
		}
	}

	public void Init(MapPointTraceInfo traceInfo, Vector3 worldPos, int spriteId)
	{
		_traceInfo = traceInfo;
		_targetWorldPos = worldPos;
		_spriteId = spriteId;
		canvasGroup.alpha = 1f;
		distanceRoot.gameObject.SetActive(value: true);
		SetPointTypeImage(traceInfo.iconType, spriteId);
		_inScreen = false;
		SetInScreenImpl(inScreen: false);
		gameObject.SetActive(value: true);
	}

	public void UnInit()
	{
		_traceInfo = null;
		_targetWorldPos = Vector3.zero;
		_spriteId = 0;
	}

	public void UpdateTargetPosition(Vector3 worldPos)
	{
		_targetWorldPos = worldPos;
	}

	public Vector3 GetTargetWorldPos()
	{
		return _targetWorldPos;
	}

	public MapPointTraceInfo GetTraceInfo()
	{
		return _traceInfo;
	}

	public void HighLight()
	{
		animation?.GetSequence("HighLight")?.Play();
	}

	public void SetDistance(long preVal, long curVal)
	{
		distanceText.SetText(Mathf.Max(0f, curVal).FastToString());
		if (AlgorithmUtility.GetIntegerBitCount(curVal) - AlgorithmUtility.GetIntegerBitCount(preVal) != 0)
		{
			ReCalculateTextSize();
		}
	}

	public void SetPosInScreen(Vector3 missionPointWorldPos)
	{
		Camera uiCamera = GameUtility.uiCamera;
		Vector3 vector = GameUtility.mainCamera.WorldToScreenPoint(missionPointWorldPos);
		Vector3 normalized = (uiCamera.ScreenToWorldPoint(vector + inScreenOffset) - uiCamera.gameObject.transform.position).normalized;
		if (!(normalized.z < 0.001f))
		{
			Vector3 position = 100f / normalized.z * normalized;
			transform.position = position;
		}
	}

	public void SetPosOutScreen(Vector3 worldPos)
	{
		transform.position = worldPos;
	}

	public void SetRot(Quaternion rot)
	{
		transform.rotation = rot;
		if (steadyPosition != null)
		{
			steadyPosition.transform.rotation = Quaternion.identity;
		}
	}

	public void SetInScreen(bool inScreen)
	{
		if (_inScreen != inScreen)
		{
			_inScreen = inScreen;
			SetInScreenImpl(inScreen);
		}
	}

	public void SetInScreenLeft(bool inScreenLeft)
	{
		if (_inScreenLeft != inScreenLeft)
		{
			_inScreenLeft = inScreenLeft;
		}
	}

	public void NormalStyle()
	{
		Show();
		distanceRoot.gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		canvasGroup.alpha = 0f;
	}

	protected void SetPointTypeImage(MapIconType iconType, int spriteId)
	{
		if (pointImage != null)
		{
			switch (iconType)
			{
			case MapIconType.Npc:
				this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, spriteId, pointImage);
				break;
			case MapIconType.MonsterPoint:
			case MapIconType.WorldBoss:
				this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, spriteId, pointImage);
				break;
			default:
				this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, spriteId, pointImage);
				break;
			}
		}
	}

	protected void SetInScreenImpl(bool inScreen)
	{
		distanceRoot.gameObject.SetActive(!inScreen);
		if (arrow != null)
		{
			arrow.gameObject.SetActive(!inScreen);
		}
		ReCalculateTextSize();
	}

	private void ReCalculateTextSize()
	{
		if (layoutGroup != null && distanceRoot != null)
		{
			layoutGroup.enabled = false;
			LayoutRebuilder.ForceRebuildLayoutImmediate(distanceRoot);
			layoutGroup.enabled = true;
		}
	}

	private void Show()
	{
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		canvasGroup.alpha = 1f;
	}
}
