#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HammerActiveView : WeaponActiveView
{
	public class HammerViewBindData : WeaponViewBindDataBase
	{
		protected HammerActiveView hammerView;

		public int Reduce
		{
			get
			{
				return 0;
			}
			set
			{
				hammerView.Reduce = value;
			}
		}

		public int BarFillChange
		{
			get
			{
				return 0;
			}
			set
			{
				hammerView.BarFillChange = value;
			}
		}

		public HammerViewBindData(WeaponActiveView view)
			: base(view)
		{
			hammerView = view as HammerActiveView;
		}
	}

	[SerializeField]
	private Image barDeepYello;

	[SerializeField]
	private Image barLightYello;

	[SerializeField]
	private List<GameObject> marks;

	[SerializeField]
	private GameObject markItem;

	[SerializeField]
	private RectTransform reduceItem;

	[SerializeField]
	private RectTransform markBar;

	[SerializeField]
	private GameObject EffectGo;

	private int barFillChange;

	private int energyMax;

	private int energyEach;

	private int reduce;

	protected WeaponMechanismHammerViewModel hammerViewModel;

	protected HammerViewBindData hammerBindData;

	public int EnergyMax
	{
		get
		{
			return energyMax;
		}
		set
		{
			if (value != energyMax)
			{
				energyMax = value;
				InitMarks();
			}
		}
	}

	public int EnergyEach
	{
		get
		{
			return energyEach;
		}
		set
		{
			if (value != energyEach)
			{
				energyEach = value;
				InitMarks();
			}
		}
	}

	public int Reduce
	{
		get
		{
			return reduce;
		}
		set
		{
			reduce = value;
			if (value > 0)
			{
				PlayReduceAni(value);
			}
		}
	}

	public int BarFillChange
	{
		get
		{
			return barFillChange;
		}
		set
		{
			barFillChange = value;
			int num = (int)(math.max(hammerViewModel.HammerDeepYello, hammerViewModel.HammerLightYello) * (float)energyMax);
			float num2 = 0f;
			num2 = num / energyEach;
			for (int i = 0; i < marks.Count; i++)
			{
				marks[i].GetComponent<StateEnumItem>()?.SetCurState(((float)i < num2) ? StateEnumConfig.Open : StateEnumConfig.Lock);
			}
			if (hammerViewModel.HammerLightYello >= 1f)
			{
				WeaponAudio();
			}
			if (hammerViewModel.HammerDeepYello > hammerViewModel.HammerLightYello)
			{
				float num3 = hammerViewModel.HammerLightYello * (float)energyMax;
				float num4 = hammerViewModel.HammerDeepYello * (float)energyMax;
				int num5 = (int)(num3 / (float)energyEach);
				int num6 = (int)(num4 / (float)energyEach);
				for (int j = num5; j < num6; j++)
				{
					marks[j].GetComponent<StateEnumItem>()?.SetCurState(StateEnumConfig.Active);
				}
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		hammerBindData = new HammerViewBindData(this);
	}

	protected override void OnInitWeaponMechanism()
	{
		base.OnInitWeaponMechanism();
		hammerViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismHammerViewModel;
		energyMax = hammerViewModel.HammerEnergyMax;
		energyEach = hammerViewModel.HammerEnergyEach;
		InitMarks();
		BindingSet<HammerActiveView, WeaponMechanismHammerViewModel> bindingSet = this.CreateBindingSet(hammerViewModel);
		bindingSet.Bind(barDeepYello).For((Image v) => v.fillAmount).To((WeaponMechanismHammerViewModel vm) => vm.HammerDeepYello);
		bindingSet.Bind(EffectGo).For((GameObject v) => v.activeSelf).ToExpression((WeaponMechanismHammerViewModel vm) => vm.HammerLightYello > 0f);
		bindingSet.Bind(barLightYello).For((Image v) => v.fillAmount).To((WeaponMechanismHammerViewModel vm) => vm.HammerLightYello);
		bindingSet.Bind().For((HammerActiveView v) => v.EnergyMax).To((WeaponMechanismHammerViewModel vm) => vm.HammerEnergyMax);
		bindingSet.Bind().For((HammerActiveView v) => v.EnergyEach).To((WeaponMechanismHammerViewModel vm) => vm.HammerEnergyEach);
		bindingSet.Bind(hammerBindData).For((HammerViewBindData v) => v.BarFillChange).To((WeaponMechanismHammerViewModel vm) => vm.HammerDeepYello);
		bindingSet.Bind(hammerBindData).For((HammerViewBindData v) => v.BarFillChange).To((WeaponMechanismHammerViewModel vm) => vm.HammerLightYello);
		bindingSet.Bind(hammerBindData).For((HammerViewBindData v) => v.Reduce).To((WeaponMechanismHammerViewModel vm) => vm.HammerReduce);
		bindingSet.Bind(hammerBindData).For((HammerViewBindData v) => v.Reduce).To((WeaponMechanismHammerViewModel vm) => vm.HammerReduce);
		bindingSet.Build();
		AutoDispose component = reduceItem.GetComponent<AutoDispose>();
		if (component != null)
		{
			component.AddDisposeAction(delegate(GameObject v)
			{
				v.gameObject.SetActive(value: false);
			});
		}
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		hammerViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismHammerViewModel;
		energyMax = hammerViewModel.HammerEnergyMax;
		energyEach = hammerViewModel.HammerEnergyEach;
		this.SetDataContext(viewModel.HeroData.WeaponMechanismData);
	}

	private void PlayReduceAni(int reduceVal)
	{
		float num = (float)reduceVal * 1f / (float)energyMax;
		if (!(num < 0f))
		{
			float fillAmount = barLightYello.fillAmount;
			float x = num * markBar.sizeDelta.x;
			reduceItem.sizeDelta = new Vector2(x, reduceItem.sizeDelta.y);
			fillAmount = ((hammerViewModel.HammerDeepYello != hammerViewModel.HammerLightYello) ? math.max(fillAmount, hammerViewModel.HammerDeepYello - (float)reduceVal * 1f / (float)energyMax) : math.min(fillAmount, hammerViewModel.HammerDeepYello - (float)reduceVal * 1f / (float)energyMax));
			reduceItem.anchoredPosition = new Vector2(fillAmount * markBar.sizeDelta.x, 0f);
			reduceItem.gameObject.SetActive(value: true);
		}
	}

	public void InitMarks()
	{
		if (energyEach == 0)
		{
			Log.Error("锤斧间隔数据异常！");
			return;
		}
		int num = energyMax / energyEach;
		float x = markBar.sizeDelta.x;
		if (marks == null)
		{
			marks = new List<GameObject>();
		}
		for (int i = 0; i < marks.Count; i++)
		{
			if (i < num)
			{
				marks[i].gameObject.SetActive(value: true);
				marks[i].GetComponent<RectTransform>().anchoredPosition = new Vector2(x / (float)num * (float)(i + 1), 0f);
			}
			else
			{
				marks[i].gameObject.SetActive(value: false);
			}
		}
		for (int j = marks.Count; j < num; j++)
		{
			GameObject gameObject = Object.Instantiate(markItem.gameObject, markBar);
			if (gameObject == null)
			{
				Log.Error("锤斧UI,标记间隔预制体创建异常！");
				break;
			}
			gameObject.GetComponent<RectTransform>().anchoredPosition = new Vector2(x / (float)num * (float)(j + 1), 0f);
			marks.Add(gameObject);
			gameObject.SetActive(value: true);
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (marks != null && marks.Count > 0)
		{
			for (int i = 0; i < marks.Count; i++)
			{
				Object.Destroy(marks[i].gameObject);
				marks[i] = null;
			}
			marks.Clear();
		}
	}
}
