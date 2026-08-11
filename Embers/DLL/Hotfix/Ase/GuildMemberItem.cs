using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildMemberItem : PlayerItemBase
{
	[SerializeField]
	private Color offlineColor;

	[SerializeField]
	private Text memberName;

	[SerializeField]
	private TextMeshProUGUI memberLevel;

	[SerializeField]
	private TextMeshProUGUI positionText;

	[SerializeField]
	private TextMeshProUGUI weeklyActivePoint;

	[SerializeField]
	private TextMeshProUGUI totalActivePoint;

	[SerializeField]
	protected TextMeshProUGUI onlineState;

	[SerializeField]
	private Button btnOption;

	private GuildMemberItemData _viewModel;

	public Button BtnOption => btnOption;

	public GuildMemberItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildMemberItemData>(userData);
		BindingSet<GuildMemberItem, GuildMemberItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(memberName).For((Text v) => v.text).ToExpression((GuildMemberItemData vm) => (vm.StateNum == 4) ? $"<color=#{ColorUtility.ToHtmlStringRGB(offlineColor)}>{vm.Name}</color>" : vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(memberLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildMemberItemData vm) => (vm.StateNum == 4) ? $"<color=#{ColorUtility.ToHtmlStringRGB(offlineColor)}>{vm.Level}</color>" : $"{vm.Level}");
		bindingSet.Bind<TextMeshProUGUI>(positionText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildMemberItemData vm) => (vm.StateNum == 4) ? $"<color=#{ColorUtility.ToHtmlStringRGB(offlineColor)}>{vm.PositionText}</color>" : $"<color=#{ColorUtility.ToHtmlStringRGB(GuildDefinition.GetPositionColor(vm.Position))}>{vm.PositionText}</color>");
		bindingSet.Bind<TextMeshProUGUI>(weeklyActivePoint).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildMemberItemData vm) => (vm.StateNum == 4) ? $"<color=#{ColorUtility.ToHtmlStringRGB(offlineColor)}>{vm.WeeklyActivePoint}</color>" : $"{vm.WeeklyActivePoint}");
		bindingSet.Bind<TextMeshProUGUI>(totalActivePoint).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildMemberItemData vm) => (vm.StateNum == 4) ? $"<color=#{ColorUtility.ToHtmlStringRGB(offlineColor)}>{vm.TotalActivePoint}</color>" : $"{vm.TotalActivePoint}");
		bindingSet.Bind<TextMeshProUGUI>(onlineState).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildMemberItemData vm) => (vm.StateNum == 4) ? $"<color=#{ColorUtility.ToHtmlStringRGB(offlineColor)}>{vm.OnlineState}</color>" : $"{vm.OnlineState}");
		bindingSet.Bind(btnOption.gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildMemberItemData vm) => !vm.IsSelf);
		bindingSet.Build();
		btnOption.onClick.AddListener(delegate
		{
			_viewModel.OnOptionBtnClick(this);
		});
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is GuildMemberItemData guildMemberItemData)
		{
			_viewModel = guildMemberItemData;
			this.SetDataContext(guildMemberItemData);
		}
	}
}
