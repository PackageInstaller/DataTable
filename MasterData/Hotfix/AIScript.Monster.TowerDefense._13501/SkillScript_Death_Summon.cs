using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._13501;

public class SkillScript_Death_Summon : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Die";

	private string evt_DieBoom = "DieBoom";

	private string areaEffect = "AreaEffect_135_Support_DieBoom";

	private List<int> hitId = new List<int> { 80135021, 80135023, 80135024, 80135025, 80135026, 80135027, 80135028, 80135029, 80135030, 80135031 };

	private int perkId_1 = 1350101;

	private AdventureActor summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PauseMovementAgent();
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.EnableMovementAgent();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCustomEvent(evt_DieBoom);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			int index = 0;
			if (GetPerk(perkId_1))
			{
				index = _actor.GetTagCount("buff_count");
			}
			AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent != null)
			{
				logicComponent.hitDamageId = hitId.get_Item(index);
			}
		});
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private bool GetPerk(int perkId)
	{
		int perkLevel;
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out perkLevel);
	}
}
