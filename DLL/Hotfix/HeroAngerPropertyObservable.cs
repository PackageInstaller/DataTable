public class HeroAngerPropertyObservable : PropertyObservable
{
	protected override void OnInitProperty()
	{
		propertyData = BaseEntity.GetPropertyData("HeroAnger");
	}

	public override void OnRefresh()
	{
		if (propertyData != null)
		{
			float num = BaseEntity.GetProperty("HeroAngerRatio") - 1f;
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
			float num2 = BaseEntity.GetProperty("HeroAngerRatio") - 1f;
			BaseEntity.ChangeProperty("HeroAnger", num * num2, isExecuteValueChanged: false);
		}
	}

	protected override void OnClear()
	{
	}
}
