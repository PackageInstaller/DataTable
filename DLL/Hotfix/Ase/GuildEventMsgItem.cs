using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildEventMsgItem : UGuiView
{
	[SerializeField]
	private Text msgContent;

	[SerializeField]
	private TextMeshProUGUI ymdText;

	[SerializeField]
	private TextMeshProUGUI hmsText;

	[SerializeField]
	private Button btn;

	private GuildEventMsgItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildEventMsgItemData>(userData);
		BindingSet<GuildEventMsgItem, GuildEventMsgItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (msgContent != null)
		{
			bindingSet.Bind(msgContent).For((Text v) => v.text).To((GuildEventMsgItemData vm) => vm.Content);
		}
		if ((UnityEngine.Object)(object)ymdText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(ymdText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildEventMsgItemData vm) => vm.YmdText);
		}
		if ((UnityEngine.Object)(object)hmsText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(hmsText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildEventMsgItemData vm) => vm.HmsText);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((GuildEventMsgItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is GuildEventMsgItemData guildEventMsgItemData)
		{
			_viewModel = guildEventMsgItemData;
			this.SetDataContext(guildEventMsgItemData);
		}
	}
}
