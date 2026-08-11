using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GlovesActiveView : WeaponActiveView
{
	public class GlovesViewBindData : WeaponViewBindDataBase
	{
		protected GlovesActiveView glovesView;

		public GlovesViewBindData(WeaponActiveView view)
			: base(view)
		{
			glovesView = view as GlovesActiveView;
		}
	}

	[SerializeField]
	private GlovesItem glovesItem;

	private float heroAnger;

	[SerializeField]
	private Image slider;

	[SerializeField]
	private GameObject maxGo;

	[SerializeField]
	private int maxLayer;

	private int curValue;

	public List<Color> colorChange;

	private WeaponMechanismGlovesViewModel glovesViewModel;

	public float HeroAnger
	{
		get
		{
			return heroAnger;
		}
		set
		{
			if (value > heroAnger)
			{
				heroAnger = value;
				glovesViewModel.OnHeroAngerChanged();
			}
			else
			{
				heroAnger = value;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
	}

	protected override void OnInitWeaponMechanism()
	{
		base.OnInitWeaponMechanism();
		glovesViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismGlovesViewModel;
		this.CreateBindingSet(glovesViewModel).Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		glovesViewModel = viewModel.HeroData.WeaponMechanismData as WeaponMechanismGlovesViewModel;
		this.SetDataContext(viewModel.HeroData.WeaponMechanismData);
	}

	protected void LateUpdate()
	{
		if (glovesViewModel == null)
		{
			return;
		}
		if (glovesViewModel.Property.ContainsKey("HeroAnger"))
		{
			Ase.ECS.PropertyData propertyData = glovesViewModel.Property["HeroAnger"];
			float angerCur = propertyData.CurValue / propertyData.MaxValue;
			if (!angerCur.Equals(glovesItem.AngerCur))
			{
				glovesItem.AngerCur = angerCur;
			}
			HeroAnger = propertyData.CurValue;
		}
		if (glovesViewModel.Property.ContainsKey("HeroEnergy"))
		{
			Ase.ECS.PropertyData propertyData2 = glovesViewModel.Property["HeroEnergy"];
			float eachEnergyLayerMax = glovesViewModel.EachEnergyLayerMax;
			int num = ((eachEnergyLayerMax == 0f) ? 1 : ((int)(propertyData2.MaxValue / eachEnergyLayerMax)));
			if (glovesItem.EnergyBarCount != num)
			{
				glovesItem.EnergyBarCount = num;
			}
			if (glovesItem.EnergyCur != propertyData2.CurValue)
			{
				glovesItem.EnergyCur = propertyData2.CurValue;
			}
		}
		int num2 = (int)glovesViewModel.EachEnergyLayerMax;
		if (glovesItem.EnergyEach != num2)
		{
			glovesItem.EnergyEach = num2;
		}
	}
}
