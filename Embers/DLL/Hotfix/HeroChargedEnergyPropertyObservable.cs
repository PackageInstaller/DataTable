public class HeroChargedEnergyPropertyObservable : PropertyObservable
{
	protected override void OnInitProperty()
	{
		propertyData = BaseEntity.GetPropertyData("HeroChargedEnergy");
	}

	public override void OnRefresh()
	{
		if (propertyData != null)
		{
			float property = BaseEntity.GetProperty("HeroChargedEnergyScale");
			propertyData.Addition(propertyData.CurValue * property, isIgnoreMax: false);
		}
	}

	public override void OnInfluencePropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
	}

	public override void OnMonitorPropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
		if (laterChangedValue >= beforeChangedValue)
		{
			float num = laterChangedValue - beforeChangedValue;
			float property = BaseEntity.GetProperty("HeroChargedEnergyScale");
			BaseEntity.ChangeProperty("HeroChargedEnergy", num * property, isExecuteValueChanged: false);
		}
	}

	protected override void OnClear()
	{
	}
}
