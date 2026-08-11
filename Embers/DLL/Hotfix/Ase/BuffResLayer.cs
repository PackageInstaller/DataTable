using Ase.ECS;

namespace Ase;

public class BuffResLayer : HeroInDependentData
{
	private int buffId;

	public override void CalculateFillAmount()
	{
		Buff buff = OwnBaseEntity.GetSystem<BuffSystem>()?.FindEntityBuff(OwnBaseEntity.Id, buffId);
		if (buff == null)
		{
			if (base.CurrentFill != 0)
			{
				base.CurrentFill = 0;
			}
			base.ResFillAmount = 0f;
			return;
		}
		if (base.MaxFill != buff.Config.MaxLayer)
		{
			base.MaxFill = buff.Config.MaxLayer;
		}
		if (base.CurrentFill != buff.GetLayer())
		{
			base.CurrentFill = buff.GetLayer();
		}
		if (buff.MaxLifeTime > 0f)
		{
			base.ResFillAmount = 1f - buff.CurLifeTime / buff.MaxLifeTime;
		}
	}

	public static BuffResLayer Create(BaseEntity entity, int buffId)
	{
		return new BuffResLayer
		{
			OwnBaseEntity = entity,
			buffId = buffId,
			IsEmpty = false
		};
	}
}
