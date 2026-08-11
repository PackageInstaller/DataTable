using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildItem : UGuiView
{
	[SerializeField]
	private Button btnOpenReport;

	[SerializeField]
	protected Color textColorNormal;

	[SerializeField]
	protected Color textColorSelected;

	[SerializeField]
	protected GameObject bgNormal;

	[SerializeField]
	protected GameObject bgSelected;

	[SerializeField]
	protected Button btn;

	[SerializeField]
	protected Image icon;

	[SerializeField]
	protected Text guildName;

	[SerializeField]
	protected TextMeshProUGUI memberCount;

	[SerializeField]
	protected TextMeshProUGUI level;

	[SerializeField]
	protected TextMeshProUGUI cycleActivity;

	private GuildItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildItemData>(userData);
		_viewModel.SetTextColor(textColorNormal, textColorSelected);
		BindingSet<GuildItem, GuildItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (bgNormal != null)
		{
			bindingSet.Bind(bgNormal).For((GameObject v) => v.activeSelf).ToExpression((GuildItemData vm) => !vm.Selected);
		}
		if (bgSelected != null)
		{
			bindingSet.Bind(bgSelected).For((GameObject v) => v.activeSelf).To((GuildItemData vm) => vm.Selected);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((GuildItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (guildName != null)
		{
			bindingSet.Bind(guildName).For((Text v) => v.text).To((GuildItemData vm) => vm.Name);
		}
		if ((UnityEngine.Object)(object)memberCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(memberCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildItemData vm) => vm.MemberCount);
		}
		if ((UnityEngine.Object)(object)level != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildItemData vm) => vm.Level);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((GuildItemData vm) => vm.OnItemClick);
			bindingSet.Bind(btn).For((Button v) => v.enabled).To((GuildItemData vm) => vm.ClickEnable);
		}
		if ((UnityEngine.Object)(object)cycleActivity != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(cycleActivity).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildItemData vm) => vm.CycleActivity);
		}
		bindingSet.Build();
		if (btnOpenReport != null)
		{
			btnOpenReport.onClick.AddListener(delegate
			{
				_viewModel.OnReportBtnClick(btnOpenReport.transform);
			});
		}
	}

	public void RefreshData(GuildItemData newData)
	{
		_viewModel = newData;
		_viewModel.SetTextColor(textColorNormal, textColorSelected);
		this.SetDataContext(newData);
	}
}
