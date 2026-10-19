using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("触发溶解", "Action", new string[] { "trigger", "dissolve", "effect", "fx", "particle" })]
public class ActionTriggerDissolve : ConfigAction
{
	public bool isAppear = true;

	public bool canReplay = true;

	public AniPartControl.PartType part;

	[Range(0f, 5f)]
	public float duration;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		float d = duration;
		MonoEntity mono = memory.target.entity.GetMono();
		if (duration < 0f)
		{
			string text = ((memory.target.entity.GetCompMotion() != null) ? memory.target.entity.GetCompMotion().lastLayer0PeakConfig.name : string.Empty);
			Debug.LogError($"{memory.target.entity} {memory.ability} {text}ActionTriggerDissolve duration不能小于0,当前为{duration},请检查配置");
		}
		foreach (AniPartControl aniControl in mono.aniControls)
		{
			Impl(aniControl, d, memory.target.entity);
		}
		Impl(mono.aniControl, d, memory.target.entity);
	}

	private void Impl(AniPartControl script, float d, Entity entity)
	{
		AniPartControl.PartType partType = part;
		if (isAppear)
		{
			script.ForwardPlay(partType, d, entity, null, canReplay, needEntityLogicScale: true);
		}
		else
		{
			script.BackwardPlay(partType, d, entity, null, canReplay, needEntityLogicScale: true);
		}
	}
}
