using System;
using System.Collections;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Game.Data;
using ACT.Model;
using ACT.World;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Rendering.Universal;

namespace ACT.UI;

public class MonoLoaderView : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation uiEffectAnimation;

	[Header("正常Loading")]
	[SerializeField]
	private GameObject normalLoadingRoot;

	[SerializeField]
	private BImage centerIcon;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float progressFactor = 0.25f;

	[SerializeField]
	private int progressMinStep = 1;

	[SerializeField]
	private int progressMaxStep = 10;

	[SerializeField]
	private LocalizeStringEvent tipsTitle;

	[SerializeField]
	private LocalizeStringEvent tipsContent;

	[SerializeField]
	private TextMeshProUGUI progressText;

	[Header("黑屏Loading")]
	[SerializeField]
	private GameObject blackLoadingRoot;

	private LoaderViewData _loaderViewData;

	private bool _isBlack;

	private StringBuilder _sb;

	private float _currentProgressPercent;

	private float _targetProgressPercent;

	private bool _finalApproachActive;

	private float _finalApproachElapsed;

	private float _finalApproachStart;

	private float _finalApproachDuration;

	private Coroutine _progressCoroutine;

	private bool _closing;

	public Action OnLoadEnd;

	public LoaderViewData DataContext
	{
		get
		{
			return _loaderViewData;
		}
		set
		{
			_loaderViewData = value;
			if (isActiveAndEnabled)
			{
				RefreshDisplay();
			}
		}
	}

	public bool IsBlack
	{
		get
		{
			return _isBlack;
		}
		set
		{
			_isBlack = value;
			if (normalLoadingRoot != null)
			{
				normalLoadingRoot.SetActive(!_isBlack);
			}
			if (blackLoadingRoot != null)
			{
				blackLoadingRoot.SetActive(_isBlack);
			}
		}
	}

	public Action OnComplete { get; set; }

	public float ProgressPercent => _currentProgressPercent;

	public bool IsClosing => _closing;

	public bool IsOpenAnimationPlaying { get; private set; }

	private void Awake()
	{
		_sb = new StringBuilder();
	}

	private void OnEnable()
	{
		try
		{
			ResetProgressState();
			RefreshDisplay();
			PlayOpenAnimation();
			if (centerIcon != null && centerIcon.icon != null)
			{
				Color color = centerIcon.icon.color;
				centerIcon.icon.color = new Color(color.r, color.g, color.b, 0.5f);
			}
			TryStartProgressCoroutine();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		finally
		{
			MonoECS.instance.PushPause();
			MonoECS.instance.PushPauseAllInput();
		}
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Loading, active: true);
	}

	private void OnDisable()
	{
		try
		{
			DataContext = null;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		finally
		{
			IsOpenAnimationPlaying = false;
			SetLoadingBaseCameraSkip(skip: false);
			MonoECS.instance.PopPauseAllInput();
			MonoECS.instance.PopPause();
		}
		Singleton<LoadManager>.instance.ReleaseLoadHandle();
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Loading, active: false);
		try
		{
			OnLoadEnd?.Invoke();
		}
		catch (Exception exception2)
		{
			Debug.LogException(exception2);
		}
		finally
		{
			OnLoadEnd = null;
		}
	}

	private static void SetLoadingBaseCameraSkip(bool skip)
	{
		UniversalRenderPipeline.SetBaseCameraSkip(skip);
	}

	private void PlayOpenAnimation()
	{
		_closing = false;
		IsOpenAnimationPlaying = true;
		try
		{
			uiEffectAnimation.GetSequence("UniversalShow_Legacy").OnComplete((AnimationBuilder x) =>
			{
				IsOpenAnimationPlaying = false;
				SetLoadingBaseCameraSkip(skip: true);
				Singleton<LoadManager>.instance.NotifyLoadingViewOpened();
			}).Play();
		}
		catch (Exception exception)
		{
			IsOpenAnimationPlaying = false;
			SetLoadingBaseCameraSkip(skip: true);
			Singleton<LoadManager>.instance.NotifyLoadingViewOpened();
			Debug.LogException(exception);
		}
	}

	private async void PlayCloseAnimation()
	{
		try
		{
			uiEffectAnimation.GetSequence("UniversalHide_Legacy").OnComplete((AnimationBuilder _) =>
			{
				if (_closing)
				{
					gameObject.SetActive(value: false);
				}
			}).Play();
		}
		catch (Exception exception)
		{
			await UniTask.Delay(1);
			if (_closing)
			{
				gameObject.SetActive(value: false);
			}
			Debug.LogException(exception);
		}
	}

	private void ResetProgressState()
	{
		_targetProgressPercent = 0f;
		_currentProgressPercent = 0f;
		_finalApproachActive = false;
		_finalApproachElapsed = 0f;
		_finalApproachStart = 0f;
		_finalApproachDuration = 0f;
		_sb.Clear();
		UpdateProgressText();
	}

	private void TryStartProgressCoroutine()
	{
		if (_progressCoroutine == null && gameObject != null && gameObject.activeInHierarchy)
		{
			_progressCoroutine = StartCoroutine(SmoothProgressUpdate());
		}
	}

	private IEnumerator SmoothProgressUpdate()
	{
		while (_currentProgressPercent < 100f)
		{
			float unscaledDeltaTime = Time.unscaledDeltaTime;
			float num = Mathf.Clamp(unscaledDeltaTime * 60f, 0f, 4f);
			float num2 = Mathf.Clamp(Singleton<LoadManager>.instance.LoadProgress * 100f, 0f, 100f);
			if (num2 >= 99.99f)
			{
				num2 = 100f;
			}
			_targetProgressPercent = Mathf.Max(num2, _targetProgressPercent);
			if (_targetProgressPercent >= 100f)
			{
				if (!_finalApproachActive)
				{
					_finalApproachActive = true;
					_finalApproachElapsed = 0f;
					_finalApproachStart = _currentProgressPercent;
					float num3 = Mathf.Max(100f - _currentProgressPercent, 1f);
					_finalApproachDuration = 0.22f + num3 * 0.012f;
				}
				_finalApproachElapsed += unscaledDeltaTime;
				float num4 = Mathf.Clamp01(_finalApproachElapsed / _finalApproachDuration);
				float a = ((num4 >= 1f) ? 100f : Mathf.Lerp(_finalApproachStart, 100f, num4 * num4));
				a = Mathf.Min(a, _currentProgressPercent + 3f);
				_currentProgressPercent = Mathf.Min(a, 100f);
			}
			else
			{
				_finalApproachActive = false;
				float num5 = _targetProgressPercent - _currentProgressPercent;
				if (num5 > 0f)
				{
					float num6 = Mathf.Clamp(num5 * 0.3f * num, 0f, 6f);
					_currentProgressPercent = Mathf.Min(_currentProgressPercent + num6, _targetProgressPercent);
				}
			}
			UpdateProgressText();
			yield return null;
		}
		if (_progressCoroutine != null)
		{
			StopCoroutine(_progressCoroutine);
			_progressCoroutine = null;
			OnComplete?.Invoke();
			OnComplete = null;
		}
	}

	private void UpdateProgressText()
	{
		_sb.Clear();
		if (!(progressText == null))
		{
			int value = Mathf.Clamp(Mathf.RoundToInt(_currentProgressPercent), 0, 100);
			progressText.SetText(_sb.Append(value).Append("%"));
		}
	}

	private void RefreshDisplay()
	{
		if (!Model<LoadingModel>.HasInstance())
		{
			Model<LoadingModel>.CreateModel();
		}
		if (_loaderViewData == null)
		{
			TipsDetailMessageData tipsDetailMessageData = Model<LoadingModel>.Interface?.RandomGetTipsFormTipsGroup(ACT.World.MapArea.Aurum, SceneStatus.Main);
			if (tipsDetailMessageData != null)
			{
				UpdateDisplay(tipsDetailMessageData, ACT.World.MapArea.Aurum);
			}
		}
		else
		{
			TipsDetailMessageData tipsDetailMessageData2 = Model<LoadingModel>.Interface.RandomGetTipsFormTipsGroup(_loaderViewData.TargetMapArea, _loaderViewData.TargetSceneStatus);
			if (tipsDetailMessageData2 != null)
			{
				UpdateDisplay(tipsDetailMessageData2, _loaderViewData.TargetMapArea);
			}
		}
	}

	private void UpdateDisplay(TipsDetailMessageData tipData, ACT.World.MapArea targetMapArea)
	{
		if (tipsTitle != null)
		{
			tipsTitle.StringReference.TableEntryReference = tipData.tipsTitle;
		}
		if (tipsContent != null)
		{
			tipsContent.StringReference.TableEntryReference = tipData.tipDescLocal;
		}
		TextMeshProUGUI textMeshProUGUI = tipsContent?.GetComponent<TextMeshProUGUI>();
		if (textMeshProUGUI != null)
		{
			textMeshProUGUI.enableWordWrapping = true;
		}
		int iconAddress = Model<LoadingModel>.Interface.GetTipsGroupData(targetMapArea, _loaderViewData?.TargetSceneStatus ?? SceneStatus.Main).iconAddress;
		ImageManager.instance.Root.LoadImageAsync(162, iconAddress, centerIcon).Forget();
	}

	public void CancelCloseAndReopen()
	{
		ResetProgressState();
		PlayOpenAnimation();
		TryStartProgressCoroutine();
	}

	public void CloseLoaderView()
	{
		_closing = true;
		SetLoadingBaseCameraSkip(skip: false);
		if (_progressCoroutine != null)
		{
			StopCoroutine(_progressCoroutine);
			_progressCoroutine = null;
		}
		_currentProgressPercent = 100f;
		UpdateProgressText();
		PlayCloseAnimation();
	}
}
