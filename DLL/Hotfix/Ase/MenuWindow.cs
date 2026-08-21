using FMODUnity;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MenuWindow : UGuiWindow
{
	public Button outerBtn;

	public Button battleTestBtn;

	public Button effectTestBtn;

	public TMP_InputField webUrlInput;

	private MenuViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<MenuViewModel>();
		BindingSet<MenuWindow, MenuViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((MenuWindow v) => v.OnDismissRequest).To((MenuViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(outerBtn).For((Button v) => v.onClick).To((MenuViewModel vm) => vm.OpenLoginWindowCmd);
		bindingSet.Bind(battleTestBtn).For((Button v) => v.onClick).To((MenuViewModel vm) => vm.OnBattleTest);
		bindingSet.Bind(effectTestBtn).For((Button v) => v.onClick).To((MenuViewModel vm) => vm.OnEffectBtn);
		bindingSet.Bind(this).For((MenuWindow v) => v.OpenUguiWindow).To((MenuViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
	}

	protected override void OnDismiss()
	{
		base.OnDismiss();
		this.ClearAllBindings();
		this.SetDataContext(null);
		viewModel = null;
	}

	public unsafe void OpenWeb()
	{
		RuntimeManager.MuteAllEvents(true);
		Debug.Log("关闭游戏音乐");
		GameEntry.Web.OpenWebViewWithUid(webUrlInput.text, ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: false, delegate(UniWebViewMessage message)
		{
			if (((object)(*(UniWebViewMessage*)(&message))/*cast due to constrained. prefix*/).Equals((object)"close"))
			{
				RuntimeManager.MuteAllEvents(false);
				Debug.Log("收到关闭webview消息，恢复游戏音乐");
			}
			Debug.Log("webview message:" + ((object)(*(UniWebViewMessage*)(&message))/*cast due to constrained. prefix*/).ToString());
		}, delegate(int i, string s, UniWebViewNativeResultPayload arg3)
		{
			Debug.Log("webview closed:" + i + "," + s);
		});
	}
}
