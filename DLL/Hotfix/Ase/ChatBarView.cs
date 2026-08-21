using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatBarView : UGuiView
{
	public List<ChatChannel> openChatChannels;

	public ChatChannel defaultChannel;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject chatNewMsg;

	[SerializeField]
	private Text chatName;

	[SerializeField]
	private Text chatMsg;

	private ChatBarViewModel viewModel;

	public void Init(ChatBarViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.viewModel.InitChatBarChannel(defaultChannel, openChatChannels);
		BindingSet<ChatBarView, ChatBarViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		if (chatNewMsg != null)
		{
			bindingSet.Bind(chatNewMsg).For((GameObject v) => v.activeSelf).ToExpression((ChatBarViewModel vm) => vm.IsNew);
		}
		bindingSet.Bind(chatName).For((Text v) => v.text).ToExpression((ChatBarViewModel vm) => vm.MsgName);
		bindingSet.Bind(chatMsg).For((Text v) => v.text).ToExpression((ChatBarViewModel vm) => vm.MsgContent);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((ChatBarViewModel vm) => vm.OpenChatCmd);
		bindingSet.Build();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		viewModel.Dispose();
	}
}
