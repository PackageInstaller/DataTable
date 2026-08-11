public class KeennessLayerPropertyObservable : PropertyObservable
{
	protected override void OnInitProperty()
	{
		propertyData = BaseEntity.GetPropertyData("KeennessLayer");
	}

	public override void OnRefresh()
	{
		if (propertyData != null)
		{
			float num = BaseEntity.GetProperty("KeennerssLayerRatio") - 1f;
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
			float num2 = BaseEntity.GetProperty("KeennerssLayerRatio") - 1f;
			BaseEntity.ChangeProperty("KeennessLayer", num * num2, isExecuteValueChanged: false);
		}
	}

	protected override void OnClear()
	{
	}
}
