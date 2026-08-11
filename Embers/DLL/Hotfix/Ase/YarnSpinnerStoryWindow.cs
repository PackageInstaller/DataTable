#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class YarnSpinnerStoryWindow : UGuiWindow
{
	public StoryManager storyManager;

	public Button skipButton;

	public Image autoToggleIcon;

	public Toggle autoToggle;

	public Toggle fastToggle;

	public TextMeshProUGUI fastToggleText;

	public Button detailButton;

	public GameObject plotSummaryRoot;

	public TextMeshProUGUI skipPlotSummaryTitleText;

	public TextMeshProUGUI skipPlotSummaryText;

	[SerializeField]
	private CanvasGroup dialogueCanvasGroup;

	[SerializeField]
	private CanvasGroup detailButtonCanvasGroup;

	[SerializeField]
	private CanvasGroup buttonsSubCanvasGroup;

	[SerializeField]
	private CanvasGroup plotSummaryCanvasGroup;

	private bool autoStateTemp;

	private YarnSpinnerStoryViewModel viewModel;

	public StoryDialogueView storyDialogueView;

	private StoryDialogueViewModel dialogueViewModel;

	[SerializeField]
	private Animator detailButtonAnimator;

	private bool isOpenDetailView;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<YarnSpinnerStoryViewModel>();
		BindingSet<YarnSpinnerStoryWindow, YarnSpinnerStoryViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((YarnSpinnerStoryWindow v) => v.OpenUguiWindow).To((YarnSpinnerStoryViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((YarnSpinnerStoryWindow v) => v.OnSkip).To((YarnSpinnerStoryViewModel vm) => vm.SkipRequest)
			.OneWay();
		bindingSet.Bind(autoToggle).For((Toggle v) => v.isOn, (Toggle v) => v.onValueChanged).To((YarnSpinnerStoryViewModel vm) => vm.AutoState)
			.TwoWay();
		bindingSet.Bind(fastToggle).For((Toggle v) => v.isOn, (Toggle v) => v.onValueChanged).To((YarnSpinnerStoryViewModel vm) => vm.FastState)
			.TwoWay();
		dialogueViewModel = new StoryDialogueViewModel(storyManager.happenedDialogues);
		storyDialogueView.Init(dialogueViewModel);
		bindingSet.Build();
	}

	public void UpdateState(bool autoState, bool fastState)
	{
		viewModel.AutoState = autoState;
		viewModel.FastState = fastState;
		autoStateTemp = autoState;
	}

	protected override void OnHide()
	{
		base.OnHide();
		dialogueCanvasGroup.blocksRaycasts = true;
		dialogueCanvasGroup.alpha = 1f;
		detailButtonCanvasGroup.blocksRaycasts = true;
		detailButtonCanvasGroup.alpha = 1f;
		buttonsSubCanvasGroup.blocksRaycasts = true;
		buttonsSubCanvasGroup.alpha = 1f;
		plotSummaryCanvasGroup.blocksRaycasts = false;
		plotSummaryCanvasGroup.alpha = 0f;
		storyDialogueView.CanvasGroup.blocksRaycasts = false;
		storyDialogueView.CanvasGroup.alpha = 0f;
		detailButtonAnimator.SetInteger("OpenDetail", 0);
	}

	public async UniTask Play(DRStory storyConfig, StoryAssets storyAssets, string language)
	{
		storyManager.Play(storyConfig.Id.ToString(), storyAssets, language);
		((TMP_Text)skipPlotSummaryText).text = storyConfig.Summary;
		((TMP_Text)skipPlotSummaryTitleText).text = storyConfig.Title;
		await storyManager.WaitOnStoryPlay();
	}

	public async UniTask WaitOnStoryPlay()
	{
		await storyManager.WaitOnStoryPlay();
	}

	public async UniTask WaitOnStoryEnd()
	{
		await storyManager.WaitOnStoryEnd();
	}

	public async UniTask Stop()
	{
		if (storyManager.isActiveAndEnabled)
		{
			storyManager.Stop();
			await DoHide(ignoreAnimation: true);
		}
	}

	public void OnSkip(object sender, InteractionEventArgs args)
	{
		try
		{
			storyManager.Stop(StoryEndType.Skip);
			DoHide(ignoreAnimation: true);
		}
		catch (Exception)
		{
		}
	}

	public void OnCloseNetwork()
	{
		try
		{
			if (storyManager.isActiveAndEnabled)
			{
				storyManager.Stop(StoryEndType.Skip);
				DoHide(ignoreAnimation: true);
			}
		}
		catch (Exception)
		{
		}
	}

	public void OpenDialogueDetailWindow()
	{
		try
		{
			viewModel.AutoState = false;
			dialogueViewModel.RefreshData(storyManager.happenedDialogues);
			storyDialogueView.Refresh();
			storyDialogueView.CanvasGroup.blocksRaycasts = true;
			storyDialogueView.CanvasGroup.alpha = 1f;
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	public void OnFastStateChanged(bool isOn)
	{
		((TMP_Text)fastToggleText).text = (fastToggle.isOn ? "X2" : "X1");
		GameEntry.Setting.SetBool("剧情倍速", isOn);
		GameEntry.Setting.Save();
	}

	public void OnAutoStateChanged(bool isOn)
	{
		if (isOn)
		{
			autoToggleIcon.rectTransform.DORotate(new Vector3(0f, 0f, 360f), 3.33f, RotateMode.FastBeyond360).SetLoops(-1, LoopType.Restart).SetEase(Ease.Linear);
		}
		else
		{
			autoToggleIcon.rectTransform.DOKill();
			autoToggleIcon.rectTransform.rotation = Quaternion.identity;
		}
		GameEntry.Setting.SetBool("剧情自动", isOn);
		GameEntry.Setting.Save();
	}

	public void OnSkipButtonClick()
	{
		plotSummaryCanvasGroup.blocksRaycasts = true;
		DOTweenModuleUI.DOFade(plotSummaryCanvasGroup, 1f, 0.3f);
		autoStateTemp = viewModel.AutoState;
		viewModel.AutoState = false;
		HideAllUI();
	}

	public void OnSkipButtonCancelClick()
	{
		plotSummaryCanvasGroup.blocksRaycasts = false;
		DOTweenModuleUI.DOFade(plotSummaryCanvasGroup, 0f, 0.3f);
		ShowAllUI(delegate
		{
			viewModel.AutoState = autoStateTemp;
		});
	}

	public void OnHideUIButtonClick()
	{
		autoStateTemp = viewModel.AutoState;
		viewModel.AutoState = false;
		HideAllUI();
	}

	public void OnShowUIButtonCancelClick()
	{
		viewModel.AutoState = autoStateTemp;
		ShowAllUI(delegate
		{
			viewModel.AutoState = autoStateTemp;
		});
	}

	private void HideAllUI(Action callback = null)
	{
		detailButtonCanvasGroup.blocksRaycasts = false;
		DOTweenModuleUI.DOFade(detailButtonCanvasGroup, 0f, 0.3f);
		HideButtonsUI(callback);
	}

	private void ShowAllUI(Action callback = null)
	{
		ShowButtonsUI(callback);
		detailButtonCanvasGroup.blocksRaycasts = true;
		DOTweenModuleUI.DOFade(detailButtonCanvasGroup, 1f, 0.3f).OnComplete(delegate
		{
			detailButtonCanvasGroup.blocksRaycasts = true;
		});
	}

	private void HideButtonsUI(Action callback = null)
	{
		buttonsSubCanvasGroup.blocksRaycasts = false;
		DOTweenModuleUI.DOFade(buttonsSubCanvasGroup, 0f, 0.3f);
		dialogueCanvasGroup.blocksRaycasts = false;
		DOTweenModuleUI.DOFade(dialogueCanvasGroup, 0f, 0.3f).OnComplete(delegate
		{
			if (callback != null)
			{
				callback();
			}
		});
	}

	private void ShowButtonsUI(Action callback = null)
	{
		callback?.Invoke();
		DOTweenModuleUI.DOFade(buttonsSubCanvasGroup, 1f, 0.3f).OnComplete(delegate
		{
			buttonsSubCanvasGroup.blocksRaycasts = true;
		});
		DOTweenModuleUI.DOFade(dialogueCanvasGroup, 1f, 0.3f).OnComplete(delegate
		{
			dialogueCanvasGroup.blocksRaycasts = true;
		});
	}

	public void OnDetailButtonClick()
	{
		if (!isOpenDetailView)
		{
			isOpenDetailView = true;
			autoStateTemp = viewModel.AutoState;
			viewModel.AutoState = false;
			dialogueViewModel.RefreshData(storyManager.happenedDialogues);
			storyDialogueView.Refresh();
			detailButtonAnimator.SetInteger("OpenDetail", 2);
			HideButtonsUI();
			DOTweenModuleUI.DOFade(storyDialogueView.CanvasGroup, 1f, 0.3f).OnComplete(delegate
			{
				storyDialogueView.CanvasGroup.blocksRaycasts = true;
			});
		}
		else
		{
			detailButtonAnimator.SetInteger("OpenDetail", 1);
			storyDialogueView.CanvasGroup.blocksRaycasts = false;
			DOTweenModuleUI.DOFade(storyDialogueView.CanvasGroup, 0f, 0.3f);
			ShowButtonsUI(delegate
			{
				viewModel.AutoState = autoStateTemp;
				isOpenDetailView = false;
			});
		}
	}

	public void ResetState()
	{
		viewModel.AutoState = autoStateTemp;
	}

	public void StoryQuit()
	{
		if (storyManager != null && !storyManager.StoryEndFlag)
		{
			storyManager.StoryEnd();
		}
	}
}
