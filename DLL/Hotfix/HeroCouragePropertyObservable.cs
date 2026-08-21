public class HeroCouragePropertyObservable : PropertyObservable
{
	protected override void OnInitProperty()
	{
		propertyData = BaseEntity.GetPropertyData("HeroCourage");
	}

	public override void OnRefresh()
	{
		if (propertyData != null)
		{
			float num = BaseEntity.GetProperty("HeroCourageRatio") - 1f;
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
			float num2 = BaseEntity.GetProperty("HeroCourageRatio") - 1f;
			BaseEntity.ChangeProperty("HeroCourage", num * num2, isExecuteValueChanged: false);
		}
	}

	protected override void OnClear()
	{
	}
}
