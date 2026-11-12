public class AdventureAreaBlockBulletEvent : BaseAdventureEvent
{
	public AreaEffectEntity owner;

	public int clearCount;

	public static AdventureAreaBlockBulletEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureAreaBlockBulletEvent>("AREA_EFFECT_BLOCKBULLET");
	}

	public AdventureAreaBlockBulletEvent()
		: base("AREA_EFFECT_BLOCKBULLET")
	{
	}

	public override void Clear()
	{
		clearCount = 0;
		owner = null;
	}
}
