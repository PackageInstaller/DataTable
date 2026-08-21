using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace Ase;

public class KeySettingView : UGuiView
{
	[SerializeField]
	private KeySettingItem itemTpl;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private Button btnResetAll;

	[SerializeField]
	private GameObject mask;

	[SerializeField]
	private InputActionAsset actions;

	public Guid curActionMapId;

	private Dictionary<Guid, KeySettingItem> _items = new Dictionary<Guid, KeySettingItem>();

	private KeySettingViewModel _viewModel;

	private IMessenger _messenger;

	public void Init(KeySettingViewModel viewModel)
	{
		_messenger = Context.GetApplicationContext().GetService<IMessenger>();
		LoadActionData();
		_viewModel = viewModel;
		_viewModel.SetInputActionAsset(actions);
		BindingSet<KeySettingView, KeySettingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(mask).For((GameObject v) => v.activeSelf).To((KeySettingViewModel vm) => vm.InputMode);
		bindingSet.Bind().For((KeySettingView v) => v.UpdateItemDisplay).To((KeySettingViewModel vm) => vm.UpdateDisplayRst);
		bindingSet.Bind().For((KeySettingView v) => v.SaveActionData).To((KeySettingViewModel vm) => vm.SaveInputSystemDataRst);
		bindingSet.Build();
		btnResetAll.onClick.AddListener(ResetToDefault);
		InitItems();
	}

	private void InitItems()
	{
		_items.Clear();
		for (int i = 0; i < scrollRect.content.childCount; i++)
		{
			KeySettingItem component = scrollRect.content.GetChild(i).GetComponent<KeySettingItem>();
			if (!(component == null) && component.GetInputBinding(out var binding))
			{
				component.Init(new KeySettingItemData(_viewModel, _viewModel.InBattle));
				component.Visibility = true;
				_items.Add(binding.id, component);
			}
		}
		scrollRect.content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, itemTpl.RectTransform.sizeDelta.y * (float)scrollRect.content.childCount + 100f);
	}

	private void ResetToDefault()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否将当前页恢复成默认配置", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				if (_items != null)
				{
					foreach (KeySettingItem value in _items.Values)
					{
						value.ResetToDefault();
					}
					SaveActionData();
					_viewModel.UpdateInputSystemData();
				}
				Toast.ShowInfo("已恢复默认设置");
			}
		});
	}

	public void LoadActionData()
	{
		string text = PlayerPrefs.GetString("Setting.ActionData");
		if (!string.IsNullOrEmpty(text))
		{
			actions.LoadBindingOverridesFromJson(text);
		}
	}

	public void SaveActionData(object sender = null, InteractionEventArgs e = null)
	{
		string text = actions.SaveBindingOverridesAsJson();
		PlayerPrefs.SetString("Setting.ActionData", text);
		_messenger?.Publish("Setting.SettingMessage", text);
	}

	private void UpdateItemDisplay(object sender, InteractionEventArgs e)
	{
		InputBinding inputBinding = (InputBinding)e.Context;
		if (_items.TryGetValue(inputBinding.id, out var value))
		{
			value.UpdateBindingDisplay();
		}
	}

	protected override void OnDestroy()
	{
		_messenger = null;
		base.OnDestroy();
	}
}
