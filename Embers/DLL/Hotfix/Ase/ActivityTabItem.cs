using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ActivityTabItem : TabItem
{
	private bool selectedState;

	[SerializeField]
	private List<GameObject> activityTimes;

	[SerializeField]
	private List<TextMeshProUGUI> activityTimeTexts;

	[SerializeField]
	private Animation animation;

	[SerializeField]
	private AnimationClip aniNormal;

	[SerializeField]
	private AnimationClip aniSelected;

	private ActivityTabItemData _viewModel;

	private bool initialized;

	private string aniKey = "";

	public bool Selected => selectedState;

	public void Init(ActivityTabItemData viewModel)
	{
		if (viewModel == null)
		{
			return;
		}
		Init((TabItemData)viewModel);
		_viewModel = viewModel;
		_viewModel.Item = this;
		BindingSet<ActivityTabItem, ActivityTabItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (activityTimes != null)
		{
			foreach (GameObject activityTime in activityTimes)
			{
				if (activityTime != null)
				{
					bindingSet.Bind(activityTime).For((GameObject v) => v.activeSelf).ToExpression((ActivityTabItemData vm) => !string.IsNullOrEmpty(vm.TimeText));
				}
			}
		}
		if (activityTimeTexts != null)
		{
			foreach (TextMeshProUGUI activityTimeText in activityTimeTexts)
			{
				if ((UnityEngine.Object)(object)activityTimeText != null)
				{
					bindingSet.Bind<TextMeshProUGUI>(activityTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTabItemData vm) => vm.TimeText);
				}
			}
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is ActivityTabItemData userData2)
		{
			_viewModel = userData2;
			_viewModel.Item = this;
			base.RefreshData((object)userData2);
		}
	}

	protected override void OnSelectChanged(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context is bool flag)
		{
			PlayAni(flag);
		}
	}

	public void PlayAni(bool selectedState)
	{
		this.selectedState = selectedState;
		if (!initialized)
		{
			aniKey = (selectedState ? "selected" : "normal");
			return;
		}
		animation.clip = (selectedState ? aniSelected : aniNormal);
		animation.Play();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		initialized = true;
		if (!string.IsNullOrEmpty(aniKey))
		{
			animation.clip = ((aniKey == "selected") ? aniSelected : aniNormal);
			animation.Play();
			aniKey = "";
		}
	}
}
