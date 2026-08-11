using System;
using System.Collections.Generic;

namespace Ase.ECS;

public class SummonedEntityPropertyData : EntityViewModel, IPropertyChanged
{
	private string _summonedName;

	private DRSummonedEntityConfig _drSummonedEntityConfig;

	private Dictionary<string, float> attributeRatioDic;

	public string Name
	{
		get
		{
			return _summonedName;
		}
		private set
		{
			Set(ref _summonedName, value, "Name");
		}
	}

	private SummonedEntityPropertyData()
	{
	}

	public static SummonedEntityPropertyData Create(BaseEntity baseEntity, DRSummonedEntityConfig drSummonedEntityConfig)
	{
		return new SummonedEntityPropertyData
		{
			_drSummonedEntityConfig = drSummonedEntityConfig,
			entity = baseEntity,
			Name = drSummonedEntityConfig.Name,
			level = 1
		};
	}

	protected override void InitEmptyProperty()
	{
		CopyCreatorProperty();
	}

	protected override void CalcPropertyLight()
	{
		if (entity.Parent is HeroEntity { BattleHeroData: not null } heroEntity)
		{
			_ = heroEntity.BattleHeroData.Attribute;
		}
	}

	protected virtual void CopyCreatorProperty()
	{
		if (entity == null || entity.Parent == null || entity.Parent.EntityViewModel == null)
		{
			return;
		}
		EntityViewModel entityViewModel = entity.Parent.EntityViewModel;
		Dictionary<string, float> propertyRatioDic = GetPropertyRatioDic(_drSummonedEntityConfig.BasicAttributeRatio);
		AddCreatorProperty(propertyRatioDic, "Attack", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "Defence", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "Hp", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "AttackRadio", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "FixAttack", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "DefenceRadio", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "FixDefence", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "HpRadio", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "FixHp", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "Crit", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "CritRadio", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "Energy", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "SpCharge", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "Speed", entityViewModel);
		AddCreatorProperty(propertyRatioDic, "RotateSpeed", entityViewModel);
		foreach (KeyValuePair<string, float> item in propertyRatioDic)
		{
			propertyList.Add(item.Key, entityViewModel.GetPropertyData(item.Key)?.Clone(item.Value) ?? PropertyData.Create(0f));
		}
		RegisterCreatorPropertyChanged(entityViewModel);
	}

	private void RegisterCreatorPropertyChanged(EntityViewModel creatorVM)
	{
		attributeRatioDic = GetPropertyRatioDic(_drSummonedEntityConfig.RealTimeAttributeRatio);
		foreach (string key in attributeRatioDic.Keys)
		{
			GetPropertyDataOrCreate(key);
			creatorVM.GetPropertyDataOrCreate(key).RegisterOnChangedCallback(this);
		}
	}

	private Dictionary<string, float> GetPropertyRatioDic(string propertyStr)
	{
		Dictionary<string, float> dictionary = new Dictionary<string, float>();
		string[] array = propertyStr.Split('|', StringSplitOptions.RemoveEmptyEntries);
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split(",", StringSplitOptions.RemoveEmptyEntries);
			if (array2 != null && array2.Length == 2 && float.TryParse(array2[1], out var result) && !dictionary.ContainsKey(array2[0]))
			{
				dictionary.Add(array2[0], result);
			}
		}
		return dictionary;
	}

	private void AddCreatorProperty(Dictionary<string, float> ratioDic, string propertyName, EntityViewModel creatorVM, bool isForce = true)
	{
		if (ratioDic.TryGetValue(propertyName, out var value))
		{
			propertyList.Add(propertyName, creatorVM.GetPropertyData(propertyName)?.Clone(value) ?? PropertyData.Create(0f));
			ratioDic.Remove(propertyName);
		}
		else if (isForce)
		{
			propertyList.Add(propertyName, creatorVM.GetPropertyData(propertyName)?.Clone() ?? PropertyData.Create(0f));
		}
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (attributeRatioDic != null && entity.Parent != null && attributeRatioDic.TryGetValue(propertyName, out var value) && entity.Parent.GetPropertyData(propertyName) != null)
		{
			PropertyData propertyDataOrCreate = GetPropertyDataOrCreate(propertyName);
			switch (changedEnum)
			{
			case PropertyChangedEnum.CurValue:
				propertyDataOrCreate.Addition(delta * value, isIgnoreMax: false);
				break;
			case PropertyChangedEnum.BuffValue:
				propertyDataOrCreate.AdditionBuff(delta * value, isIgnoreMax: false);
				break;
			case PropertyChangedEnum.MaxValue:
				propertyDataOrCreate.ResetMax(propertyDataOrCreate.MaxValue + delta * value);
				break;
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (entity != null && entity.Parent != null && entity.Parent.EntityViewModel != null)
		{
			EntityViewModel entityViewModel = entity.Parent.EntityViewModel;
			foreach (KeyValuePair<string, float> item in attributeRatioDic)
			{
				entityViewModel.GetPropertyData(item.Key)?.RemoveOnChangedCallback(this);
			}
		}
		base.Dispose(disposing);
	}

	public override string GetName()
	{
		return _summonedName;
	}
}
