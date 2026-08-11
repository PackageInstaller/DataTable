public class HeroHeatPropertyObservable : PropertyObservable
{
	protected override void OnInitProperty()
	{
		propertyData = BaseEntity.GetPropertyData("HeroHeat");
	}

	public override void OnRefresh()
	{
		if (propertyData != null)
		{
			float num = BaseEntity.GetProperty("HeroHeatAdditionRatio") - 1f;
			num -= 1f - BaseEntity.GetProperty("HeroHeatReduceRatio");
			propertyData.Addition(propertyData.CurValue * num, isIgnoreMax: false);
		}
	}

	public override void OnInfluencePropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
	}

	public override void OnMonitorPropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
		if (laterChangedValue > beforeChangedValue)
		{
			float num = laterChangedValue - beforeChangedValue;
			float num2 = BaseEntity.GetProperty("HeroHeatAdditionRatio") - 1f;
			BaseEntity.ChangeProperty("HeroHeat", num * num2, isExecuteValueChanged: false);
		}
		else if (laterChangedValue < beforeChangedValue)
		{
			float num3 = beforeChangedValue - laterChangedValue;
			float num4 = 1f - BaseEntity.GetProperty("HeroHeatReduceRatio");
			BaseEntity.ChangeProperty("HeroHeat", num3 * num4, isExecuteValueChanged: false);
		}
	}

	protected override void OnClear()
	{
	}
}
