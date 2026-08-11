using System;
using Ase.ECS;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleUserView : UGuiView
{
	[Header("基础属性")]
	public CanvasGroup root;

	public TweenRoleHP hpBar;

	[Header("重生")]
	public GameObject rebornRoot;

	public TextMeshProUGUI rebornTimeText;

	public StateItem rebornState;

	[Header("倒地进度条")]
	public Image deadFill;

	public GameObject deadFillRoot;

	[Header("Buff")]
	public LoopGridView buffList;

	public RectTransform descRect;

	protected BattleUserViewModel viewModel;

	protected bool isInit;

	protected float deadFillVal;

	protected bool isDead;

	private float hpModify;

	protected bool enableModifyEffect = true;

	public float DeadFillVal
	{
		get
		{
			return deadFillVal;
		}
		set
		{
			deadFillVal = value;
			deadFillRoot.gameObject.SetActive(!viewModel.HeroData.IsDead && viewModel.HeroData.Property["NearDeathSchedule"].MaxValue > deadFillVal);
			deadFill.fillAmount = ((viewModel.HeroData.Property["NearDeathSchedule"].MaxValue != 0f) ? (deadFillVal * 1f / viewModel.HeroData.Property["NearDeathSchedule"].MaxValue) : 0f);
		}
	}

	public bool IsDead
	{
		get
		{
			return isDead;
		}
		set
		{
			isDead = value;
			if (isDead)
			{
				deadFillRoot.gameObject.SetActive(value: false);
			}
		}
	}

	public bool IsInit => isInit;

	protected virtual void LateUpdate()
	{
		if (viewModel == null)
		{
			return;
		}
		ObservableDictionary<string, Ase.ECS.PropertyData> property = viewModel.HeroData.Property;
		if (hpBar != null)
		{
			if (property.ContainsKey("Shield"))
			{
				int num = (int)property["Shield"].CurValue;
				if (num != hpBar.ShieldValue)
				{
					hpBar.ShieldValue = num;
				}
			}
			if (property.ContainsKey("Hp"))
			{
				float curValue = property["Hp"].CurValue;
				float maxValue = property["Hp"].MaxValue;
				if (hpBar.HpMaxValue != maxValue)
				{
					hpBar.HpMaxValue = maxValue;
				}
				if (hpBar.HpCurValue != curValue)
				{
					hpBar.HpCurValue = curValue;
				}
			}
			if (property.ContainsKey("VirtualHp"))
			{
				float curValue2 = property["VirtualHp"].CurValue;
				if (curValue2 != hpBar.VirtualValueTemp)
				{
					hpBar.VirtualValueTemp = curValue2;
				}
			}
		}
		if (property.ContainsKey("NearDeathSchedule"))
		{
			float curValue3 = property["NearDeathSchedule"].CurValue;
			if (DeadFillVal != curValue3)
			{
				DeadFillVal = curValue3;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<BattleUserViewModel>(userData);
		BindingSet<BattleUserView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(rebornRoot).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.RevivedTime > 0f);
		bindingSet.Bind(rebornState).For((StateItem v) => v.CurState).ToExpression((BattleUserViewModel vm) => vm.HeroData.CantRevived ? 0 : 1);
		bindingSet.Bind(this).For((BattleUserView v) => v.IsDead).ToExpression((BattleUserViewModel vm) => vm.HeroData.IsDead);
		bindingSet.Build();
		deadFillRoot.SetActive(value: false);
		viewModel.AddBuffDescRect(descRect);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		OnBuffListChanged(null, null);
	}

	public void InitBuffDescConfig()
	{
		viewModel.AddBuffDescRect(descRect);
	}

	protected virtual void OnBuffListChanged(object sender, InteractionEventArgs e)
	{
		if (viewModel != null && viewModel.HeroData != null && viewModel.HeroData.BuffList != null)
		{
			if (!buffList.MListViewInited)
			{
				buffList.InitGridView((viewModel.HeroData?.BuffList?.Count).GetValueOrDefault(), OnGetBuffItemByIndex);
				return;
			}
			buffList.SetListItemCount(viewModel.HeroData.BuffList.Count);
			buffList.RefreshAllShownItem();
		}
	}

	protected virtual LoopGridViewItem OnGetBuffItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.HeroData.BuffList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BuffItemView");
		if (loopGridViewItem != null)
		{
			BuffItemView component = loopGridViewItem.GetComponent<BuffItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroData.BuffList[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroData.BuffList[index]);
			}
		}
		return loopGridViewItem;
	}

	public override void RefreshData(object userData)
	{
	}

	protected virtual void UpdateHpSlider(BattleUserViewModel battleUserViewModel)
	{
		if (battleUserViewModel.HeroData.Entity == null)
		{
			return;
		}
		try
		{
			hpBar.ChangeEntity("切换烬天使", Mathf.CeilToInt(battleUserViewModel.HeroData.Property["Hp"].CurValue), Mathf.CeilToInt(battleUserViewModel.HeroData.Property["Hp"].MaxValue), 0, Mathf.CeilToInt(battleUserViewModel.HeroData.Property["VirtualHp"].CurValue));
		}
		catch (Exception)
		{
		}
	}
}
