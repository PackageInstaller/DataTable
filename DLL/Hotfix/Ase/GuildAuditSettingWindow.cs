using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildAuditSettingWindow : UGuiWindow
{
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
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnChange;

	private GuildAuditSettingViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildAuditSettingViewModel>();
		BindingSet<GuildAuditSettingWindow, GuildAuditSettingViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildAuditSettingWindow v) => v.OnDismissRequest).To((GuildAuditSettingViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((GuildAuditSettingViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((GuildAuditSettingViewModel vm) => vm.Close);
		bindingSet.Bind(btnLevelRed).For((Button v) => v.onClick).To((GuildAuditSettingViewModel vm) => vm.OnBtnLevelRedClick);
		bindingSet.Bind(btnLevelInc).For((Button v) => v.onClick).To((GuildAuditSettingViewModel vm) => vm.OnBtnLevelIncClick);
		bindingSet.Bind(btnLevelRedMask).For((GameObject v) => v.activeSelf).ToExpression((GuildAuditSettingViewModel vm) => vm.ApplyLevelThreshold <= vm.ApplyLevelMin);
		bindingSet.Bind(btnLevelIncMask).For((GameObject v) => v.activeSelf).ToExpression((GuildAuditSettingViewModel vm) => vm.ApplyLevelThreshold >= vm.ApplyLevelMax);
		bindingSet.Bind().For((GuildAuditSettingWindow v) => v.OnApplyLevelThresholdChanged).To((GuildAuditSettingViewModel vm) => vm.OnApplyLevelThresholdChanged);
		bindingSet.Bind(btnChange).For((Button v) => v.onClick).To((GuildAuditSettingViewModel vm) => vm.ChangeSettingCmd);
		bindingSet.Build();
		if (auditTypes != null)
		{
			for (int num = 1; num <= auditTypes.Count; num++)
			{
				if (Enum.IsDefined(typeof(GuildDefinition.AuditType), num))
				{
					GuildDefinition.AuditType auditType = (GuildDefinition.AuditType)num;
					if (auditType == _viewModel.AuditType)
					{
						auditTypes[num - 1].SetIsOnWithoutNotify(value: true);
					}
					auditTypes[num - 1].onValueChanged.AddListener(delegate(bool isOn)
					{
						if (isOn)
						{
							_viewModel.OnAuditTypeClick(auditType);
						}
					});
				}
				else
				{
					auditTypes[num - 1].gameObject.SetActive(value: false);
				}
			}
		}
		applyLevelInput.text = _viewModel.ApplyLevelThreshold.ToString();
		applyLevelInput.onEndEdit.AddListener(_viewModel.OnApplyLevelInputEndEdit);
	}

	private void OnApplyLevelThresholdChanged(object sender, InteractionEventArgs e)
	{
		applyLevelInput.text = _viewModel.ApplyLevelThreshold.ToString();
	}
}
