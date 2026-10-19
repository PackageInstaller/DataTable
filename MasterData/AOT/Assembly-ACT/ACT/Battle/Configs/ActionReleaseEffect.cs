using Bamboo.Precache;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Release特效", "Action", new string[] { "release", "effect", "fx", "particle" })]
public class ActionReleaseEffect : ConfigAction
{
	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		if (!memory.owner.IsValid || memory.ability.attachEffects.Count == 0)
		{
			return;
		}
		SystemEffect effectSystem = GameManager.effectSystem;
		for (int i = 0; i < memory.ability.attachEffects.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = memory.ability.attachEffects[i];
			effectSystem.CleanEffect(effectRuntimeItem);
			if (effectRuntimeItem.go != null)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(effectRuntimeItem.instanceHandle);
			}
		}
	}
}
