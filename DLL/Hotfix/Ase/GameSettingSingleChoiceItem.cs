using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameSettingSingleChoiceItem : GameSettingItem
{
	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private ToggleGroup toggleGroup;

	private Dictionary<double, TabToggle> toggleDic = new Dictionary<double, TabToggle>();

	public override void Init(GameSettingItemViewModel viewModel)
	{
		base.Init(viewModel);
		BindingSet<GameSettingSingleChoiceItem, GameSettingItemViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		if ((UnityEngine.Object)(object)name != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameSettingItemViewModel vm) => vm.Name);
		}
		if (toggleGroup != null)
		{
			bindingSet.Bind().For((GameSettingSingleChoiceItem v) => v.RefreshSingleChoice).To((GameSettingItemViewModel vm) => vm.ValueChanged);
		}
		bindingSet.Build();
	}

	protected override void Awake()
	{
		base.Awake();
		if (!(toggleGroup != null))
		{
			return;
		}
		toggleGroup.allowSwitchOff = false;
		for (int i = 0; i < toggleGroup.transform.childCount; i++)
		{
			TabToggle component = toggleGroup.transform.GetChild(i).GetComponent<TabToggle>();
			if (!toggleDic.ContainsKey(i))
			{
				toggleDic.Add(i, component);
				component.enumId = i;
				component.InitWhenStart = false;
				component.InitWhenAwake = true;
				component.PointerClickCheck = (Func<object, bool>)Delegate.Combine(component.PointerClickCheck, new Func<object, bool>(SecondConfirmCheck));
			}
		}
	}

	protected override void Start()
	{
		base.Start();
		foreach (TabToggle value in toggleDic.Values)
		{
			value.AddSelectedAction(OnToggleSelected);
		}
		RefreshSingleChoice();
	}

	private bool SecondConfirmCheck(object arg)
	{
		if (arg is int num)
		{
			TabToggle toggle = null;
			toggleDic.TryGetValue(num, out toggle);
			if (toggle == null || toggle.isOn)
			{
				return false;
			}
			string text = string.Empty;
			if (_viewModel.Name == "渲染精度")
			{
				text = "开启<color=#C38140>超高渲染精度</color>可能会<color=#C38140>加快手机耗电、发热、性能较低的手机可能会出现卡顿</color>，确定开启吗？";
			}
			else if (_viewModel.Name == "帧率")
			{
				text = "开启<color=#C38140>高帧率</color>后，会较大程度<color=#C38140>加快设备耗电、发热，降低手机续航</color>。如果发生过热、卡顿，可尝试降低渲染精度，降低画质预设。";
			}
			else if (_viewModel.Name == "画质预设")
			{
				text = "开启<color=#C38140>超清画质</color>后，会较大程度<color=#C38140>加快设备耗电、发热，降低手机续航</color>。如果发生过热、卡顿，可尝试降低画质预设。";
			}
			if (!string.IsNullOrEmpty(text) && int.TryParse($"{_viewModel.MaxValue}", out var result) && num == result)
			{
				IAsyncResult<int> result2 = AlertDialog.Show("提示", text, "确认", "取消");
				result2.Callbackable().OnCallback(delegate
				{
					if (result2.Result == -1 && toggle != null)
					{
						toggle.isOn = true;
					}
				});
				return false;
			}
		}
		return true;
	}

	private void OnToggleSelected(int index)
	{
		SetValue(index);
	}

	private void SetValue(int index)
	{
		if (_viewModel.SetValue(index))
		{
			_viewModel.Parent.ItemOnClick(new OptionArg(_viewModel, "Save"));
		}
	}

	private void RefreshSingleChoice(object sender = null, InteractionEventArgs e = null)
	{
		double key = _viewModel.Value;
		if (toggleDic.ContainsKey(key))
		{
			toggleDic[key].isOn = true;
		}
	}
}
