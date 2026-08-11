using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatBubbleItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI bubbleName;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject activeMask;

	[SerializeField]
	private GameObject haveTimeLimit;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI content;

	[SerializeField]
	private GameObject appliedTag;

	[SerializeField]
	protected Button btn;

	public string itemSizeType = "Large";

	private ChatBubbleItemData _viewModel;

	public ChatBubbleItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ChatBubbleItemData>(userData);
		BindingSet<ChatBubbleItem, ChatBubbleItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if ((UnityEngine.Object)(object)bubbleName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(bubbleName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleItemData vm) => vm.BubbleName);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((ChatBubbleItemData vm) => vm.Selected);
		}
		if (activeMask != null)
		{
			bindingSet.Bind(activeMask).For((GameObject v) => v.activeSelf).To((ChatBubbleItemData vm) => vm.ActiveMask);
		}
		if (haveTimeLimit != null)
		{
			bindingSet.Bind(haveTimeLimit).For((GameObject v) => v.activeSelf).To((ChatBubbleItemData vm) => vm.HaveTimeLimit);
		}
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((ChatBubbleItemData vm) => $"RarityBG_{itemSizeType}_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((ChatBubbleItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		if (appliedTag != null)
		{
			bindingSet.Bind(appliedTag).For((GameObject v) => v.activeSelf).To((ChatBubbleItemData vm) => vm.Applied);
		}
		if ((UnityEngine.Object)(object)content != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(content).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleItemData vm) => vm.Content);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((ChatBubbleItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is ChatBubbleItemData chatBubbleItemData)
		{
			_viewModel = chatBubbleItemData;
			this.SetDataContext(chatBubbleItemData);
		}
	}
}
