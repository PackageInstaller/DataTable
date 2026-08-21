using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MoneyView : UGuiView
{
	[SerializeField]
	private List<RoleMoneyEnum> displayMoneys = new List<RoleMoneyEnum>();

	[SerializeField]
	public List<MoneyUIConfig> moneyUiConfigs = new List<MoneyUIConfig>();

	[SerializeField]
	private RectTransform itemRoot;

	[SerializeField]
	private MoneyItem moneyItemTpl;

	private MoneyViewModel viewModel;

	private GameObjectPool moneyItemPool;

	private Action openWindowAction;

	private bool initialized;

	public void Init(MoneyViewModel viewModel)
	{
		if (!initialized)
		{
			this.viewModel = viewModel;
			moneyItemPool = new GameObjectPool(moneyItemTpl.gameObject, itemRoot);
			BindingSet<MoneyView, MoneyViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(this).For((MoneyView v) => v.OpenWindow).To((MoneyViewModel vm) => vm.OpenWindowRequest);
			bindingSet.Bind(this).For((MoneyView v) => v.OpenPropPopupRst).To((MoneyViewModel vm) => vm.OpenPropPopupRst);
			bindingSet.Build();
			moneyItemTpl.gameObject.SetActive(value: false);
			initialized = true;
			RefreshItems();
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		if (!initialized)
		{
			Init(GetUserData<MoneyViewModel>(userData));
		}
	}

	public void SetShow(RoleMoneyEnum moneyEnum)
	{
		if (!displayMoneys.Contains(moneyEnum))
		{
			displayMoneys.Add(moneyEnum);
			RefreshItems();
		}
	}

	public void SetShow(List<RoleMoneyEnum> moneyEnums)
	{
		if (moneyEnums == null)
		{
			return;
		}
		foreach (RoleMoneyEnum moneyEnum in moneyEnums)
		{
			if (!displayMoneys.Contains(moneyEnum))
			{
				displayMoneys.Add(moneyEnum);
			}
		}
		RefreshItems();
	}

	public void SetShow(int moneyId)
	{
		if (Enum.IsDefined(typeof(RoleMoneyEnum), moneyId))
		{
			SetShow((RoleMoneyEnum)moneyId);
		}
	}

	public void SetShow(List<int> moneyIds)
	{
		if (moneyIds == null)
		{
			return;
		}
		List<RoleMoneyEnum> list = new List<RoleMoneyEnum>();
		foreach (int moneyId in moneyIds)
		{
			if (Enum.IsDefined(typeof(RoleMoneyEnum), moneyId))
			{
				list.Add((RoleMoneyEnum)moneyId);
			}
		}
		SetShow(list);
	}

	public void HideAll()
	{
		displayMoneys.Clear();
		RefreshItems();
	}

	private void RefreshItems()
	{
		if (!initialized)
		{
			return;
		}
		moneyItemPool.RecycleAll();
		if (displayMoneys == null)
		{
			return;
		}
		List<DRMoney> list = new List<DRMoney>();
		foreach (RoleMoneyEnum displayMoney in displayMoneys)
		{
			DRMoney dataRow = GameEntry.DataTable.GetDataRow((DRMoney p) => p.PropId == (int)displayMoney);
			if (dataRow != null)
			{
				list.Add(dataRow);
			}
		}
		list.Sort((DRMoney a, DRMoney b) => a.DisplayOrder.CompareTo(b.DisplayOrder) * 10 + a.Id.CompareTo(b.Id));
		MoneyData moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		foreach (DRMoney drMoney in list)
		{
			MoneyItemData moneyItemData = null;
			if (Enum.IsDefined(typeof(MoneyEnum), drMoney.PropId))
			{
				moneyItemData = new MoneyItemData(viewModel, moneyData.GetMoney((MoneyEnum)drMoney.PropId));
			}
			else
			{
				KnapsackPropData prop = knapsackViewModel.GetProp(drMoney.PropId, emptyCreate: true);
				if (prop != null)
				{
					moneyItemData = new MoneyItemData(viewModel, prop);
				}
			}
			if (moneyItemData != null)
			{
				MoneyUIConfig moneyUIConfig = moneyUiConfigs?.Find((MoneyUIConfig p) => p.MoneyType == (RoleMoneyEnum)drMoney.PropId);
				if (moneyUIConfig != null)
				{
					moneyItemData.ResetUiConfig(moneyUIConfig);
				}
				MoneyItem component = moneyItemPool.Allocate(out var newCreate).GetComponent<MoneyItem>();
				if (newCreate)
				{
					component.Init(moneyItemData);
				}
				else
				{
					component.RefreshData(moneyItemData);
				}
				component.transform.SetSiblingIndex(itemRoot.childCount - 1);
			}
		}
	}

	public void AddOpenWindowAction(Action action)
	{
		openWindowAction = (Action)Delegate.Combine(openWindowAction, action);
	}

	private void OpenPropPopupRst(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context is KeyValuePair<RoleMoneyEnum, Vector3> keyValuePair)
		{
			OpenPropInfoWindow(keyValuePair.Key, keyValuePair.Value);
		}
	}

	private void OpenPropInfoWindow(RoleMoneyEnum moneyEnum, Vector3 iconWorldPos)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>((int)moneyEnum);
		if (dataRow != null)
		{
			Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), iconWorldPos);
			Vector2 pos = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(RectTransform, vector, UIUtilly.GetUICamera(), ref pos);
			openWindowAction?.Invoke();
			viewModel.OpenPropPopupWindow(dataRow, pos);
		}
	}

	private async void OpenWindow(object sender, InteractionEventArgs args)
	{
		Action callback = args.Callback;
		object context = args.Context;
		Window w = null;
		if (context is OpenViewArg openViewArg)
		{
			if (openViewArg.ViewName.Equals(typeof(EnergyExcWindow).FullName) && openViewArg.UserData is EnergyExcViewModel userData)
			{
				w = await GameEntry.UI.OpenWindow<EnergyExcWindow>("Role/EnergyExcView", userData);
			}
			else if (openViewArg.ViewName.Equals(typeof(PropExcView).FullName) && openViewArg.UserData is PropExcViewModel userData2)
			{
				w = await GameEntry.UI.OpenWindow<PropExcView>("Role/PropExcView", userData2);
			}
			else if (openViewArg.ViewName.Equals(typeof(PropPopupWindow).FullName) && openViewArg.UserData is PropWindowViewModel userData3)
			{
				w = await GameEntry.UI.OpenWindow<PropPopupWindow>("PopupView/PropPopupWindow", userData3);
			}
			if (openViewArg.CallBack != null)
			{
				callback = (Action)Delegate.Combine(callback, openViewArg.CallBack);
			}
		}
		if (w != null && callback != null)
		{
			w.OnDismissed += Handler;
		}
		void Handler(object window, EventArgs e)
		{
			w.OnDismissed -= Handler;
			callback();
		}
	}

	protected override void OnDestroy()
	{
		moneyItemPool?.Dispose();
		moneyItemPool = null;
		base.OnDestroy();
	}
}
