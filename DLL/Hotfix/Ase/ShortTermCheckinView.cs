using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ShortTermCheckinView : ActivityViewBase
{
	[SerializeField]
	private List<ShortTermCheckinItem> items = new List<ShortTermCheckinItem>();

	[SerializeField]
	private OpActProgressTarget progressTarget;

	[SerializeField]
	private Image progressBar;

	[SerializeField]
	private TextMeshProUGUI progressText;

	[SerializeField]
	private Button jumpBtn;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	private ShortTermCheckinViewModel _viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		_viewModel = (ShortTermCheckinViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ShortTermCheckinView, ShortTermCheckinViewModel> bindingSet = this.CreateBindingSet((ShortTermCheckinViewModel)viewModel);
		if (progressBar != null)
		{
			bindingSet.Bind(progressBar).For((Image v) => v.fillAmount).To((ShortTermCheckinViewModel vm) => vm.Progress);
		}
		if ((UnityEngine.Object)(object)progressText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(progressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShortTermCheckinViewModel vm) => vm.ProgressText);
		}
		if (jumpBtn != null)
		{
			JumpWindowParams jumpWindowParams = new JumpWindowParams(jumpWindow, jumpParams);
			bindingSet.Bind(jumpBtn).For((Button v) => v.onClick).To((ShortTermCheckinViewModel vm) => vm.OpenWindowCmd)
				.CommandParameter(jumpWindowParams);
		}
		bindingSet.Build();
		InitRewards();
		if (progressBar != null || (UnityEngine.Object)(object)progressText != null)
		{
			_viewModel.InitProgressTarget(progressTarget);
		}
	}

	private void InitRewards()
	{
		if (items == null)
		{
			return;
		}
		items.RemoveAll((ShortTermCheckinItem p) => p == null);
		if (!items.Exists((ShortTermCheckinItem p) => (UnityEngine.Object)(object)p.day == null))
		{
			_viewModel.SortItemDataList();
		}
		for (int num = 0; num < items.Count; num++)
		{
			if (num >= _viewModel.ItemDataList.Count)
			{
				items[num].gameObject.SetActive(value: false);
			}
			else
			{
				items[num].Init(_viewModel.ItemDataList[num]);
			}
		}
	}
}
