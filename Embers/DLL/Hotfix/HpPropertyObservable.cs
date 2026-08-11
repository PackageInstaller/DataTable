using Ase;

public class HpPropertyObservable : PropertyObservable
{
	protected override void OnInitProperty()
	{
		propertyData = BaseEntity.GetPropertyData("Hp");
	}

	public override void OnRefresh()
	{
		if (propertyData != null && propertyData != null)
		{
			float maxValue = propertyData.MaxValue;
			float specialPropertyAddition = BattleFormulaUtility.GetSpecialPropertyAddition(BaseEntity, "Hp");
			propertyData.ResetMax(specialPropertyAddition, isExecuteValueChanged: false);
			if (maxValue < specialPropertyAddition)
			{
				propertyData.Addition(specialPropertyAddition - maxValue, isIgnoreMax: false, isExecuteValueChanged: false);
			}
		}
	}

	public override void OnInfluencePropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
		OnRefresh();
	}

	public override void OnMonitorPropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
	}

	protected override void OnClear()
	{
	}
}
