using System;
using System.Collections.Generic;

namespace AIScript.Character._13301;

public class SkillScript_Support : SkillAdvancedBase
{
	private readonly string attack_tag = "133_B2";

	private readonly string attack_tag_t23 = "133_B2P23";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	private void ClearFlowerByChildTag(int tag)
	{
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.areaEffects.FindAll((LogicEntity areaEffect) => ((AreaEffectEntity)areaEffect).CheckChildTag(tag));
		for (int num = 0; num < list.Count; num++)
		{
			AreaEffectEntity areaEffectEntity = list.get_Item(num) as AreaEffectEntity;
			SceneSingleton<AreaEffectManager>.Instance.StopAreaEffect(areaEffectEntity.Id);
		}
	}

	public void OnStart()
	{
		Parallel.time_To23 = -1;
		ClearFlowerByChildTag(Parallel.flowerEffectTag);
		string text = attack_tag;
		if (GetPerk(Parallel.perk_23))
		{
			text = attack_tag_t23;
		}
		string actionTag = text;
		Action onComboFinish = onFinishOrInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onInterrupt = onFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		if (GetPerk(513321))
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null && activedPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
			{
				Parallel.iSupoortSkillNum = 3;
			}
		}
	}

	protected void OnCustomEvent(string evt)
	{
		if (string.Equals(evt, Parallel.time_event))
		{
			Parallel.time_To23 = Parallel.time_23;
		}
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}
}
