using Ase.ECS;

namespace Ase;

public class WaterEntityInfo : IPropertyChanged
{
	public BaseEntity entity;

	public float time;

	public MultiWaterAttribute.WaterState state;

	public Ase.ECS.PropertyData propertyData;

	public MultiWaterAttribute waterAttribute;

	public void OnInit(MultiWaterAttribute waterAttribute)
	{
		this.waterAttribute = waterAttribute;
		propertyData = entity.EntityViewModel.GetPropertyData("Hp");
		if (propertyData != null)
		{
			propertyData.RegisterOnChangedCallback(this);
		}
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "Hp")
		{
			waterAttribute?.OnEntityHpChanged(this);
		}
	}
}
