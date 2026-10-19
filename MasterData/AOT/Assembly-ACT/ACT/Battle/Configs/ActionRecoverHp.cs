using System;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("恢复生命值", "Action", new string[] { "recover", "hp", "heal" })]
public class ActionRecoverHp : ConfigAction
{
	public RecoverHpType recoverHpType;

	public DamageFormula value;

	public bool useConfigFunction;

	public ConfigFunction<float> valueFunction;

	public bool isCaster;

	[Obsolete]
	public Vector3 offset;

	public bool isAllRecover;

	public override void Do(ActionMemory memory)
	{
		Entity entity = (isCaster ? memory.caster : memory.target.entity);
		value.Cal(memory.ability, entity, entity, out var p, out var m, out var constValue, out var l);
		int recover = (int)(p * (m + (float)entity.GetCompAbility().level * l) + constValue);
		if (useConfigFunction)
		{
			recover = (int)valueFunction.Return(memory);
		}
		Entity entity2 = memory.target.entity;
		CompAbility compAbility = entity2.GetCompAbility();
		if (GameUtility.BloodBottleRecoverMax)
		{
			recover = compAbility.maxHP - compAbility.hp;
			BloodBottleRecoverMax evt = Singleton<GameManager>.instance.ecsManager.systemAbility.GetEvt<BloodBottleRecoverMax>(entity2, memory.ability);
			evt.bloodbottleRecoverMax = false;
			evt.mainEntity = entity2;
			Singleton<GameManager>.instance.ecsManager.systemAbility.FireEvt(evt);
			Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseEvt(evt);
		}
		compAbility.Recover(recover, checkAlive: false);
		if (isAllRecover)
		{
			Entity switchCharacter = MPPlayer.local.GetSwitchCharacter(0);
			Entity switchCharacter2 = MPPlayer.local.GetSwitchCharacter(1);
			if (switchCharacter.IsValid)
			{
				switchCharacter.GetCompAbility().Recover(recover, checkAlive: false);
			}
			if (switchCharacter2.IsValid)
			{
				switchCharacter2.GetCompAbility().Recover(recover, checkAlive: false);
			}
		}
	}
}
