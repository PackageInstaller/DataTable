using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class GuildActivityCopyItemView : SelectItemView
{
	public string selectAniName;

	public string normalAniName;

	public GameObject finalColorGo;

	public GameObject normalColorGo;

	public GameObject completeGo;

	public GameObject rewardGo;

	public GameObject normalGo;

	public GameObject lockGo;

	public new TextMeshProUGUI name;

	public LoadUISprite icon;

	public TextMeshProUGUI beatCount;

	private GuildActivityCopyItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<GuildActivityCopyItemViewModel>(userData);
		BindingSet<GuildActivityCopyItemView, GuildActivityCopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildActivityCopyItemViewModel vm) => vm.Data.CopyData.Name);
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((GuildActivityCopyItemViewModel vm) => $"{vm.Data.CopyData.BossIconPath}/{vm.Data.CopyData.BossIcon}");
		bindingSet.Bind<TextMeshProUGUI>(beatCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildActivityCopyItemViewModel vm) => $"{vm.Data.CurBeatCount}/{vm.Data.MaxBeatCount}");
		bindingSet.Bind(((Component)(object)beatCount).gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => (int)vm.Data.CopyShowTypeEnum == 0);
		bindingSet.Bind(completeGo).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => vm.Data.IsReward && !vm.Data.IsLock && vm.Data.IsPass);
		bindingSet.Bind(rewardGo).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => vm.Data.IsPass && !vm.Data.IsReward && !vm.Data.IsLock);
		bindingSet.Bind(normalGo).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => !vm.Data.IsPass && !vm.Data.IsLock);
		bindingSet.Bind(normalColorGo).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => (int)vm.Data.CopyShowTypeEnum == 0);
		bindingSet.Bind(finalColorGo).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => (int)vm.Data.CopyShowTypeEnum == 1);
		bindingSet.Bind(lockGo).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityCopyItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Build();
		AddOnShow();
	}

	private async void AddOnShow()
	{
		await UniTask.WaitUntil(() => Visibility);
		OnSelectChanged(oldSel: false, viewModel.IsSelect);
	}

	protected override void OnSelectChanged(bool oldSel, bool newSel)
	{
		if ((!oldSel & newSel) || (oldSel && !newSel))
		{
			Animator component = GetComponent<Animator>();
			if (component != null)
			{
				component.Play(newSel ? selectAniName : normalAniName);
			}
		}
	}
}
