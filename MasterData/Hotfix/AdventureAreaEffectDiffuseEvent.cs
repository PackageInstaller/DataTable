using TrueSync;
using UnityEngine;

public class AdventureAreaEffectDiffuseEvent : BaseAdventureEvent
{
	public long entityID;

	public AdventureActor owner;

	public bool iDiffuseMax;

	public Vector3 pos;

	public FP hitBoxRadius;

	public static AdventureAreaEffectDiffuseEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureAreaEffectDiffuseEvent>("AREA_EFFECT_DIFFUSE");
	}

	public AdventureAreaEffectDiffuseEvent()
		: base("AREA_EFFECT_DIFFUSE")
	{
	}

	public override void Clear()
	{
		entityID = 0L;
		iDiffuseMax = false;
		owner = null;
	}
}
