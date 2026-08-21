using Ase.ECS;

namespace Ase;

public class PropertyRes : HeroInDependentData
{
	private string propertyName;

	public override void CalculateFillAmount()
	{
		if (OwnBaseEntity == null)
		{
			base.ResFillAmount = 0f;
			return;
		}
		float propertyMax = OwnBaseEntity.GetPropertyMax(propertyName);
		if (propertyMax == 0f)
		{
			base.ResFillAmount = 1f;
		}
		else
		{
			base.ResFillAmount = OwnBaseEntity.GetPropertyData(propertyName).CurValue / propertyMax;
		}
	}

	public static PropertyRes Create(BaseEntity entity, string propertyName)
	{
		return new PropertyRes
		{
			OwnBaseEntity = entity,
			propertyName = propertyName
		};
	}
}
