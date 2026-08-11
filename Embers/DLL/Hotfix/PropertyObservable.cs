using Ase.ECS;
using GameFramework;

public abstract class PropertyObservable : IReference
{
	protected BaseEntity BaseEntity;

	protected PropertyData propertyData;

	public void Init(BaseEntity baseEntity)
	{
		BaseEntity = baseEntity;
		OnInitProperty();
	}

	public void Clear()
	{
		OnClear();
		BaseEntity = null;
		propertyData = null;
	}

	protected abstract void OnInitProperty();

	public abstract void OnRefresh();

	public abstract void OnInfluencePropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum);

	public abstract void OnMonitorPropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum);

	protected abstract void OnClear();

	public static PropertyObservable CreateObservable(string propertyKey)
	{
		return propertyKey switch
		{
			"Hp" => new HpPropertyObservable(), 
			"HeroChargedEnergy" => new HeroChargedEnergyPropertyObservable(), 
			"XpEnergy" => new XpEnergyPropertyObservable(), 
			"HeroAnger" => new HeroAngerPropertyObservable(), 
			"HeroHeat" => new HeroHeatPropertyObservable(), 
			"KeennessLayer" => new KeennessLayerPropertyObservable(), 
			"HeroCourage" => new HeroCouragePropertyObservable(), 
			_ => null, 
		};
	}
}
