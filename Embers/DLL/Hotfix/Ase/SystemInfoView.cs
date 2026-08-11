using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SystemInfoView : UGuiView
{
	public TextMeshProUGUI battleFPSText;

	public Color FPS_timeErrorColor;

	public Color FPS_timeWarningColor;

	public Color FPS_timePrefectColor;

	public Color timeWarningColor;

	public TextMeshProUGUI battlePingText;

	public List<Image> battlePingIcons;

	public Color batteryColor;

	public Color batteryWarningColor;

	public GameObject NetWorkObj;

	[SerializeField]
	private BattleTipFloatingWindow _battleTipFloatingWindow;

	public TextMeshProUGUI battleTimeText;

	public GameObject battleTimeRoot;

	public TextMeshProUGUI taskTimeText;

	public GameObject taskTimeRoot;

	public Button pauseBtn;

	public Button bagBtn;

	public GameObject bagRoot;

	public Button settingBtn;

	public Image img_menu;

	public Image img_menu_short;

	[SerializeField]
	private GameObject autoFightRoot;

	public Button autoFightOpenBtn;

	public Button autoFightCloseBtn;

	public Button autoFightBanOpenBtn;

	public Button autoFightBanCloseBtn;

	public List<Color> pingColors;

	private SystemInfoViewModel viewModel;

	private int _pingColorIndex;

	private int _battleFPS;

	private int _battleTime;

	public int PingColorIndex
	{
		private get
		{
			return _pingColorIndex;
		}
		set
		{
			battlePingIcons[_pingColorIndex].enabled = false;
			_pingColorIndex = Mathf.Clamp(value, 0, pingColors.Count);
			((Graphic)(object)battlePingText).color = pingColors[_pingColorIndex];
			battlePingIcons[_pingColorIndex].enabled = true;
		}
	}

	public int BattleFPS
	{
		private get
		{
			return _battleFPS;
		}
		set
		{
			_battleFPS = value;
			((TMP_Text)battleFPSText).SetText("FPS:{0}", (float)_battleFPS);
			((Graphic)(object)battleFPSText).color = ((_battleFPS >= 50) ? FPS_timePrefectColor : ((_battleFPS >= 20) ? FPS_timeWarningColor : FPS_timeErrorColor));
		}
	}

	public int BattleTime
	{
		private get
		{
			return _battleTime;
		}
		set
		{
			_battleTime = value;
			((TMP_Text)battleTimeText).SetText("{0:00}:{1:00}", (float)(_battleTime / 60 % 60), (float)(_battleTime % 60));
			((Graphic)(object)battleTimeText).color = ((_battleTime <= 60) ? timeWarningColor : Color.white);
			if (!viewModel.ShowBattleTime || !viewModel.reversalTime)
			{
				return;
			}
			if (value == viewModel.BattleTimeConfig / 2)
			{
				_battleTipFloatingWindow.Show(1.5f, "剩余时间还有一半");
				return;
			}
			switch (value)
			{
			case 60:
				_battleTipFloatingWindow.Show(1.5f, "剩余时间还有60秒");
				break;
			case 30:
				_battleTipFloatingWindow.Show(1.5f, "剩余时间还有30秒");
				break;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = (SystemInfoViewModel)userData;
		BindingSet<SystemInfoView, SystemInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(battlePingText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SystemInfoViewModel vm) => $"{vm.BattlePing}ms");
		bindingSet.Bind(((Component)(object)battlePingText).gameObject).For((GameObject v) => v.activeSelf).To((SystemInfoViewModel vm) => vm.ShowBattlePing);
		bindingSet.Bind(this).For((SystemInfoView v) => v.BattleFPS).To((SystemInfoViewModel vm) => vm.BattleFPS);
		bindingSet.Bind(this).For((SystemInfoView v) => v.PingColorIndex).To((SystemInfoViewModel vm) => vm.PingColorIdx);
		bindingSet.Bind(pauseBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.PauseTime);
		bindingSet.Bind(this).For((SystemInfoView v) => v.BattleTime).To((SystemInfoViewModel vm) => vm.BattleTime);
		bindingSet.Bind(battleTimeRoot).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => vm.ShowBattleTime && !vm.ShowMenuShort);
		bindingSet.Bind<TextMeshProUGUI>(taskTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SystemInfoViewModel vm) => $"{vm.TaskTime / 60 % 60:00}:{vm.TaskTime % 60:00}");
		bindingSet.Bind<TextMeshProUGUI>(taskTimeText).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((SystemInfoViewModel vm) => (vm.TaskTime <= 60) ? timeWarningColor : Color.white);
		bindingSet.Bind(taskTimeRoot).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => vm.ShowTaskTime);
		bindingSet.Bind(bagRoot).For((GameObject v) => v.activeSelf).To((SystemInfoViewModel vm) => vm.ShowBag);
		bindingSet.Bind(settingBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenSetting");
		bindingSet.Bind(bagBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenBag");
		bindingSet.Bind(bagBtn.gameObject).For((GameObject v) => v.activeSelf).To((SystemInfoViewModel vm) => vm.ShowBagIcon);
		bindingSet.Bind(img_menu.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => !vm.ShowMenuShort);
		bindingSet.Bind(img_menu_short.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => vm.ShowMenuShort);
		bindingSet.Bind(NetWorkObj).For((GameObject v) => v.activeSelf).To((SystemInfoViewModel vm) => vm.HaveRealPeople);
		bindingSet.Bind(autoFightRoot).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => (int)vm.AutoFightToogleEnum != 0);
		bindingSet.Bind(autoFightOpenBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => (int)vm.AutoFightToogleEnum == 2);
		bindingSet.Bind(autoFightCloseBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => (int)vm.AutoFightToogleEnum == 1);
		bindingSet.Bind(autoFightBanOpenBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => (int)vm.AutoFightToogleEnum == 3 || (int)vm.AutoFightToogleEnum == 5);
		bindingSet.Bind(autoFightBanCloseBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SystemInfoViewModel vm) => (int)vm.AutoFightToogleEnum == 4);
		bindingSet.Bind(autoFightOpenBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.OptCmd)
			.CommandParameter("AutoFightClose");
		bindingSet.Bind(autoFightCloseBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.OptCmd)
			.CommandParameter("AutoFightOpen");
		bindingSet.Bind(autoFightBanOpenBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.OptCmd)
			.CommandParameter("AutoFightBanOpen");
		bindingSet.Bind(autoFightBanCloseBtn).For((Button v) => v.onClick).To((SystemInfoViewModel vm) => vm.OptCmd)
			.CommandParameter("AutoFightBanClose");
		bindingSet.Build();
		pauseBtn.gameObject.SetActive(value: false);
		((Component)(object)battleFPSText).gameObject.SetActive(value: true);
		_battleTipFloatingWindow.Init();
	}
}
