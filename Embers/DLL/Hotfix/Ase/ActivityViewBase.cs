#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ActivityViewBase : AnimationUIView
{
	[SerializeField]
	private TextMeshProUGUI activityName;

	[SerializeField]
	private GameObject activityTimeGo;

	[SerializeField]
	private TextMeshProUGUI activityTime;

	[SerializeField]
	protected bool blockActivityAchievementRedPoint;

	protected ActivityViewModelBase _viewModelBase;

	private string _viewName;

	public ActivityViewModelBase ViewModelBase => _viewModelBase;

	public virtual void Init(ActivityViewModelBase viewModel)
	{
		_viewModelBase = viewModel;
		_viewName = _viewModelBase.UiViewName;
		BindingSet<ActivityViewBase, ActivityViewModelBase> bindingSet = this.CreateBindingSet(_viewModelBase);
		if ((UnityEngine.Object)(object)activityName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(activityName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityViewModelBase vm) => vm.ActivityName);
		}
		if ((UnityEngine.Object)(object)activityTime != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(activityTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityViewModelBase vm) => vm.ActivityTimeText);
		}
		if (activityTimeGo != null)
		{
			bindingSet.Bind(activityTimeGo).For((GameObject v) => v.activeSelf).ToExpression((ActivityViewModelBase vm) => !string.IsNullOrEmpty(vm.ActivityTimeText));
		}
		bindingSet.Build();
	}

	public override void Show(bool ignoreAnimation = false, Action onStartAction = null)
	{
		SendViewTDAEvent(isOpen: true);
		base.Show(ignoreAnimation, onStartAction);
	}

	public override void Hide(bool ignoreAnimation = false, Action onEndAction = null)
	{
		SendViewTDAEvent(isOpen: false);
		base.Hide(ignoreAnimation, onEndAction);
	}

	public virtual void ToDestroy()
	{
		try
		{
			UnityEngine.Object.Destroy(base.gameObject);
			if (!string.IsNullOrEmpty(_viewName))
			{
				GameEntry.Resource.UnloadAsset(AssetUtility.GetUIFormAsset(_viewName));
			}
			_viewModelBase = null;
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private void SendViewTDAEvent(bool isOpen)
	{
		if (_viewModelBase != null)
		{
			if (isOpen)
			{
				TDAHandler.Instance.SendViewStart(_viewModelBase.ActivityTypeId, _viewModelBase.ActivityName, "OperatingActivityWindow");
			}
			else
			{
				TDAHandler.Instance.SendViewEnd(_viewModelBase.ActivityTypeId, _viewModelBase.ActivityName, "OperatingActivityWindow");
			}
		}
	}
}
