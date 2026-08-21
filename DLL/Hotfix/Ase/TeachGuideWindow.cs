using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TeachGuideWindow : UGuiWindow
{
	private TeachGuideViewModel _viewModel;

	[SerializeField]
	private float closeUITime = 0.2f;

	public GameObject EmptyClick;

	private float guideStartTime;

	[SerializeField]
	private TeachGuideFrameBaseView _teachGuideFrameView1;

	[SerializeField]
	private TeachGuideImageVideoView _teachGuideImageVideoView2;

	[SerializeField]
	private TeachGuideFrameBaseView _teachGuideFrameView3;

	[SerializeField]
	private TeachGuideImageVideoView _teachGuideImageVideoView4;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeachGuideViewModel>();
		if (_viewModel == null || _viewModel.IsCloseView)
		{
			Close();
			return;
		}
		BindingSet<TeachGuideWindow, TeachGuideViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((TeachGuideWindow v) => v.OnDismissRequest).To((TeachGuideViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TeachGuideWindow v) => v.CloseUI).To((TeachGuideViewModel vm) => vm.CloseUIRequest);
		bindingSet.Build();
		_teachGuideFrameView1.Init(_viewModel);
		_teachGuideImageVideoView2.Init(_viewModel);
		_teachGuideFrameView3.Init(_viewModel);
		_teachGuideImageVideoView4.Init(_viewModel);
	}

	protected override void OnShow()
	{
		base.OnShow();
		ShowContent();
		_viewModel.ShowAction();
	}

	public async void ShowContent()
	{
		guideStartTime = Time.realtimeSinceStartup;
		_teachGuideFrameView1.SetMask();
		CanvasGroup.alpha = 0f;
		for (int i = 0; i < _viewModel.TeachConfig.HideUIIndex.Count; i++)
		{
			_viewModel.ShowSkillBtnAction?.Invoke(_viewModel.TeachConfig.HideUIIndex[i], arg2: true);
		}
		for (int j = 0; j < _viewModel.TeachConfig.ShowUIIndex.Count; j++)
		{
			_viewModel.ShowSkillBtnAction?.Invoke(_viewModel.TeachConfig.ShowUIIndex[j], arg2: false);
		}
		await UniTask.WaitForSeconds(_viewModel.TeachConfig.DelayShowTime);
		if (!CanExcute())
		{
			return;
		}
		CanvasGroup.alpha = 1f;
		if (_viewModel.TeachConfig.Pause && Singleton<GameSystem>.Instance != null)
		{
			_viewModel.GamePause?.Invoke();
			_viewModel.IsPause = true;
		}
		if (_viewModel.TeachConfig.Manual && Singleton<NetworkSystem>.Instance.Connected())
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().SetManualOpenState(4, _viewModel.TeachConfig.Id);
		}
		_teachGuideFrameView1.ShowContent();
		_teachGuideImageVideoView2.ShowContent();
		_teachGuideFrameView3.ShowContent();
		_teachGuideImageVideoView4.ShowContent();
		await UniTask.WaitForSeconds(_viewModel.TeachConfig.TimeDelay);
		if (!CanExcute())
		{
			return;
		}
		EmptyClick.SetActive(value: false);
		if (_viewModel.TeachConfig.TimeAutoComplete > 0f)
		{
			await UniTask.WaitForSeconds(_viewModel.TeachConfig.TimeAutoComplete);
			if (CanExcute())
			{
				CloseUI(null, null);
			}
		}
	}

	public void ForceCloseUI()
	{
		if (CanExcute())
		{
			EmptyClick.SetActive(value: true);
			_viewModel.ReResume();
			_viewModel.SaveTeachGuide();
			Close();
			_viewModel.CloseTeachGuideAction?.Invoke(_viewModel.TeachConfig.NextGuideId, _viewModel.TeachConfig.NextGuideDelayTime);
		}
	}

	private bool CanExcute()
	{
		if (_viewModel == null || this == null)
		{
			return false;
		}
		return true;
	}

	private void CloseUI(object o, InteractionEventArgs args)
	{
		TDAHandler.Instance?.LevelGuideStepReport(Time.realtimeSinceStartup - guideStartTime, _viewModel.TeachConfig.Id);
		if (_viewModel.GuidanceType == 2 || _viewModel.GuidanceType == 4)
		{
			EmptyClick.SetActive(value: true);
			DOTweenModuleUI.DOFade(CanvasGroup, 0f, closeUITime).OnComplete(delegate
			{
				_viewModel.ReResume();
				_viewModel.SaveTeachGuide();
				Close();
				_viewModel.CloseTeachGuideAction?.Invoke(_viewModel.TeachConfig.NextGuideId, _viewModel.TeachConfig.NextGuideDelayTime);
			});
		}
		else
		{
			ForceCloseUI();
		}
	}
}
