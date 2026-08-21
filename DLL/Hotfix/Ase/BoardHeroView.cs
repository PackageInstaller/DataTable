using FMOD.Studio;
using GameFramework.Runtime;
using Sirenix.Utilities;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BoardHeroView : UGuiView
{
	public float loginActionDelayDuration = 5f;

	public float standByDuration = 10f;

	public int frequentClickTime = 5;

	public float frequentClickTimeRange = 30f;

	public float voiceBubbleDelayHideTime = 2f;

	[SerializeField]
	private float scaleInit;

	[SerializeField]
	private RectTransform spineRoot;

	private string spineAssetPath;

	private DRBoardHeroList drHero;

	private SpineFusion _spineFusion;

	private BoardHeroViewModel _viewModel;

	private string assetTag = "BoardHeroView";

	public bool isOnShow;

	private bool _initialized;

	private bool isPlaying;

	private float loginDelayTimer;

	private float standByTimer;

	private ISubscription<AudioLanguageEnum> _languageChanged;

	private ISubscription<StreamerModeMsg> _streamerModeChanged;

	private BoardActionData _lastActionData;

	[SerializeField]
	private Animator bubbleAnimator;

	[SerializeField]
	private TextMeshProUGUI bubbleText;

	private bool bubbleVisible;

	private void Update()
	{
		if (!isOnShow)
		{
			return;
		}
		if (!_initialized && loginActionDelayDuration > 0f)
		{
			_spineFusion?.SetTouchEnable(enable: false);
			loginDelayTimer += Time.deltaTime;
			if (loginDelayTimer >= loginActionDelayDuration)
			{
				_viewModel.PlayLoginAction();
				_spineFusion?.SetTouchEnable(enable: true);
				_initialized = true;
			}
			return;
		}
		if (_viewModel.ClickTime > 0)
		{
			_viewModel.FrequentClickTimer += Time.deltaTime;
			if (_viewModel.FrequentClickTimer > frequentClickTimeRange)
			{
				_viewModel.FrequentClickTimer = 0f;
				_viewModel.ClickTime = 0;
			}
		}
		if (!isPlaying)
		{
			standByTimer += Time.deltaTime;
			if (standByTimer > standByDuration)
			{
				_viewModel.PlayStandbyAction();
				standByTimer = 0f;
			}
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (_viewModel != null)
		{
			SetSpine();
		}
		isOnShow = true;
	}

	protected override void OnDisable()
	{
		ResetSpineToIdle();
		isOnShow = false;
		base.OnDisable();
	}

	public void Init(BoardHeroViewModel viewModel)
	{
		_viewModel = viewModel;
		_viewModel.FrequentClickTime = frequentClickTime;
		BindingSet<BoardHeroView, BoardHeroViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((BoardHeroView v) => v.Refresh).To((BoardHeroViewModel vm) => vm.RefreshRequest);
		bindingSet.Bind().For((BoardHeroView v) => v.SetSpine).To((BoardHeroViewModel vm) => vm.ReturnSpineRst);
		bindingSet.Bind().For((BoardHeroView v) => v.PlayAction).To((BoardHeroViewModel vm) => vm.PlayActionRst);
		bindingSet.Build();
		_languageChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<AudioLanguageEnum>("AudioLanguageInfoChannel", OnAudioLanguageChanged);
		_streamerModeChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<StreamerModeMsg>(OnStreamerModeChanged);
		Refresh();
	}

	private void OnStreamerModeChanged(StreamerModeMsg msg)
	{
		if (!(_viewModel.HeroSpine == null))
		{
			StreamerMode.ApplySpineSkin(_viewModel.HeroSpine);
		}
	}

	private async void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		DisposeHeroSpine();
		ResetChatBubble();
		drHero = _viewModel.DrBoardHeroList;
		if (drHero != null)
		{
			Loading loading = await Loading.Show();
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(drHero.AssetPath)), spineRoot);
			loading?.Dispose();
			if (!(gameObject == null))
			{
				PlayerPrefs.GetFloat(PosterGirlAdjustView.GetBoardSpineScalePrefKey(drHero.Id), scaleInit);
				_viewModel.HeroSpine = gameObject;
				SetSpine();
				ResetToIdle();
				StreamerMode.ApplySpineSkin(gameObject);
			}
		}
	}

	private void SetSpine(object sender = null, InteractionEventArgs e = null)
	{
		if (e != null)
		{
			object context = e.Context;
			if (context is bool && (bool)context)
			{
				ResetToIdle();
			}
		}
		if (_viewModel.HeroSpine != null)
		{
			drHero = _viewModel.DrBoardHeroList;
			ApplySpineRootTransformFromConfigAndPrefs();
			_viewModel.HeroSpine.transform.SetParent(spineRoot, worldPositionStays: false);
			_viewModel.HeroSpine.transform.localPosition = Vector3.zero;
			_viewModel.HeroSpine.transform.localRotation = Quaternion.identity;
			_viewModel.HeroSpine.transform.localScale = Vector3.one;
			_spineFusion = _viewModel.HeroSpine.transform.GetComponentInChildren<SpineFusion>();
			if (!((Object)(object)_spineFusion == null) && !((Object)(object)_spineFusion.SkeletonGraphic == null))
			{
				((Behaviour)(object)_spineFusion).enabled = true;
				_spineFusion.Init(_viewModel.HandleBoardPartState);
				((Graphic)(object)_spineFusion.SkeletonGraphic).raycastTarget = true;
				_spineFusion.SkeletonGraphic.freeze = false;
				_spineFusion.AddAudioPlayAction(TryShowBubble);
				SpineHelper.SetSpineInteractivity(_viewModel.HeroSpine.transform, interactivity: true);
			}
		}
	}

	private void ApplySpineRootTransformFromConfigAndPrefs()
	{
		if (drHero == null)
		{
			return;
		}
		int id = drHero.Id;
		if (_viewModel != null && _viewModel.TryGetPreviewTransformData(id, out var data))
		{
			spineRoot.anchoredPosition = data.AnchoredPosition;
			spineRoot.localScale = data.LocalScale;
			spineRoot.localRotation = data.LocalRotation;
			return;
		}
		Vector2 anchoredPosition = new Vector2((drHero.Position.Count > 0) ? drHero.Position[0] : 0f, (drHero.Position.Count > 1) ? drHero.Position[1] : 0f);
		if (PosterGirlAdjustView.TryLoadBoardHeroSpineAnchoredPos(id, out var anchoredPos))
		{
			anchoredPosition = anchoredPos;
		}
		spineRoot.anchoredPosition = anchoredPosition;
		float num = PlayerPrefs.GetFloat(PosterGirlAdjustView.GetBoardSpineScalePrefKey(id), scaleInit);
		Vector3 vector = new Vector3((drHero.Scale.Count > 0) ? drHero.Scale[0] : 1f, (drHero.Scale.Count > 1) ? drHero.Scale[1] : 1f, (drHero.Scale.Count > 2) ? drHero.Scale[2] : 1f);
		float z = PlayerPrefs.GetFloat(PosterGirlAdjustView.GetBoardSpineRotationPrefKey(id), 0f);
		bool flag = PlayerPrefs.GetInt(PosterGirlAdjustView.GetBoardSpineFlipYPrefKey(id), 0) == 1;
		Vector3 localScale = vector * num;
		localScale.x = (flag ? (0f - Mathf.Abs(localScale.x)) : Mathf.Abs(localScale.x));
		spineRoot.localScale = localScale;
		spineRoot.localRotation = Quaternion.Euler(0f, 0f, z);
	}

	private void OnAudioLanguageChanged(AudioLanguageEnum arg)
	{
		if (!(_viewModel.HeroSpine == null))
		{
			Refresh();
		}
	}

	private void PlayAction(object sender, InteractionEventArgs e)
	{
		if ((Object)(object)_spineFusion == null)
		{
			return;
		}
		BoardActionData boardActionData = (_lastActionData = (BoardActionData)e.Context);
		if (_spineFusion.PlayAction(boardActionData.ActionIndex, boardActionData.PlayCommand, OnActionFinish))
		{
			standByTimer = 0f;
			isPlaying = true;
			if (!boardActionData.CanBreak)
			{
				_spineFusion.SetTouchEnable(enable: false);
			}
			_spineFusion.RecordAnimationPlayed(boardActionData.ActionIndex);
			e.Callback?.Invoke();
		}
	}

	private void TryShowBubble(int audioId, EventInstance eventInstance)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		DRAudio dataRow = GameEntry.DataTable.GetDataRow<DRAudio>(audioId);
		if (dataRow != null && dataRow.EventType == 1)
		{
			EventDescription val = default(EventDescription);
			((EventInstance)(ref eventInstance)).getDescription(ref val);
			int num = default(int);
			((EventDescription)(ref val)).getLength(ref num);
			CancelInvoke("HideBubble");
			if (!bubbleVisible)
			{
				ShowBubble();
			}
			((TMP_Text)bubbleText).text = dataRow.Content;
			Invoke("HideBubble", (float)(num / 1000) + voiceBubbleDelayHideTime);
		}
	}

	private void ShowBubble()
	{
		if (!bubbleVisible)
		{
			bubbleAnimator.SetTrigger("showBubble");
			bubbleVisible = true;
		}
	}

	private void HideBubble()
	{
		if (bubbleVisible)
		{
			bubbleAnimator.SetTrigger("hideBubble");
			bubbleVisible = false;
		}
	}

	public void ResetToIdle()
	{
		ResetSpineToIdle();
		ResetChatBubble();
		ResetAllState();
		OnActionFinish();
	}

	private void OnActionFinish()
	{
		isPlaying = false;
		if (!_lastActionData.CanBreak && !((Object)(object)_spineFusion).SafeIsUnityNull())
		{
			_spineFusion.SetTouchEnable(enable: true);
		}
	}

	private void ResetChatBubble()
	{
		CancelInvoke("HideBubble");
		HideBubble();
	}

	private void ResetSpineToIdle()
	{
		if (!((Object)(object)_spineFusion).SafeIsUnityNull())
		{
			_spineFusion.ResetToIdle();
		}
	}

	private void ResetAllState()
	{
		isPlaying = false;
		standByTimer = 0f;
	}

	protected override void OnDestroy()
	{
		CancelInvoke("HideBubble");
		DisposeHeroSpine();
		_languageChanged?.Dispose();
		_languageChanged = null;
		_streamerModeChanged?.Dispose();
		_streamerModeChanged = null;
		base.OnDestroy();
	}

	private void DisposeHeroSpine()
	{
		if (_viewModel.HeroSpine != null)
		{
			Object.DestroyImmediate(_viewModel.HeroSpine);
			_viewModel.HeroSpine = null;
		}
	}
}
