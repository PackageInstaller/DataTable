using System.Collections;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Monster._11000001DarkFs;

public class SkillScript_Death : SkillSimpleBase
{
	protected const string fx = "fx_11001_base_FenShen_Die";

	protected override IEnumerator DoMainLogic()
	{
		PlayerAdventureActor playerAdventureActor = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(playerAdventureActor.dataID, 511004, out var _))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_110_Main_FenShen_DieBoom", _actor.tsTransform.Position);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(playerAdventureActor.dataID, 511029, out var _))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_110_Support_FenShen_DieBoom", _actor.tsTransform.Position);
			}
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11001_base_FenShen_Die");
		if (gameObject != null)
		{
			AdventureFXPlayer.PlayFX(gameObject, (float)_actor.logicTimeScale, _actor.transform.position, Quaternion.identity);
		}
		_actor.PlayDeathAnim();
		yield return null;
	}
}
