using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildCreateView : UGuiView
{
	[SerializeField]
	private InputField guildNameInput;

	[SerializeField]
	private InputField guildDescInput;

	[SerializeField]
	private List<TabItem> guildFlags;

	[SerializeField]
	private InputField applyLevelInput;

	[SerializeField]
	private Button btnLevelRed;

	[SerializeField]
	private GameObject btnLevelRedMask;

	[SerializeField]
	private Button btnLevelInc;

	[SerializeField]
	private GameObject btnLevelIncMask;

	[SerializeField]
	private List<Toggle> auditTypes;

	[SerializeField]
	private Image consumeIcon;

	[SerializeField]
	private TextMeshProUGUI consumeCount;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private Button btnCreate;

	private GuildCreateViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildCreateViewModel>(userData);
		BindingSet<GuildCreateView, GuildCreateViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(guildNameInput).For((InputField v) => v.text, (InputField v) => v.onEndEdit).To((GuildCreateViewModel vm) => vm.GuildName)
			.TwoWay();
		bindingSet.Bind(guildDescInput).For((InputField v) => v.text, (InputField v) => v.onEndEdit).To((GuildCreateViewModel vm) => vm.GuildDesc)
			.TwoWay();
		bindingSet.Bind().For((GuildCreateView v) => v.OnApplyLevelThresholdChanged).To((GuildCreateViewModel vm) => vm.OnApplyLevelThresholdChanged);
		bindingSet.Bind(btnLevelRed).For((Button v) => v.onClick).To((GuildCreateViewModel vm) => vm.OnBtnLevelRedClick);
		bindingSet.Bind(btnLevelInc).For((Button v) => v.onClick).To((GuildCreateViewModel vm) => vm.OnBtnLevelIncClick);
		bindingSet.Bind(btnLevelRedMask).For((GameObject v) => v.activeSelf).ToExpression((GuildCreateViewModel vm) => vm.ApplyLevelThreshold <= vm.ApplyLevelMin);
		bindingSet.Bind(btnLevelIncMask).For((GameObject v) => v.activeSelf).ToExpression((GuildCreateViewModel vm) => vm.ApplyLevelThreshold >= vm.ApplyLevelMax);
		bindingSet.Bind(consumeIcon).For((Image v) => v.sprite).To((GuildCreateViewModel vm) => vm.ConsumeIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(consumeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildCreateViewModel vm) => vm.ConsumeCountText);
		bindingSet.Bind(btnCreate).For((Button v) => v.onClick).To((GuildCreateViewModel vm) => vm.CreateCmd);
		bindingSet.Build();
		Init();
		moneyView.Init(new MoneyViewModel(_viewModel.Parent));
		moneyView.HideAll();
		moneyView.SetShow(RoleMoneyEnum.Diamond);
	}

	private void Init()
	{
		if (guildFlags != null)
		{
			for (int i = 1; i <= guildFlags.Count; i++)
			{
				if (Enum.IsDefined(typeof(GuildDefinition.Flag), i))
				{
					guildFlags[i - 1].Init(new TabItemData(_viewModel, i));
					if (i == (int)_viewModel.GuildFlag)
					{
						guildFlags[i - 1].ViewModel.TabOnClick();
					}
				}
			}
		}
		applyLevelInput.text = $"{_viewModel.ApplyLevelThreshold}";
		applyLevelInput.onEndEdit.AddListener(_viewModel.OnApplyLevelInputEndEdit);
		if (auditTypes == null)
		{
			return;
		}
		for (int j = 1; j <= auditTypes.Count; j++)
		{
			if (Enum.IsDefined(typeof(GuildDefinition.AuditType), j))
			{
				GuildDefinition.AuditType auditType = (GuildDefinition.AuditType)j;
				if (auditType == _viewModel.AuditType)
				{
					auditTypes[j - 1].SetIsOnWithoutNotify(value: true);
				}
				auditTypes[j - 1].onValueChanged.AddListener(delegate(bool isOn)
				{
					if (isOn)
					{
						_viewModel.OnAuditTypeClick(auditType);
					}
				});
			}
			else
			{
				auditTypes[j - 1].gameObject.SetActive(value: false);
			}
		}
	}

	private void OnApplyLevelThresholdChanged(object sender, InteractionEventArgs e)
	{
		applyLevelInput.text = _viewModel.ApplyLevelThreshold.ToString();
	}
}
