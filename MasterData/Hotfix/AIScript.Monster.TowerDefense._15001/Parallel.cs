using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15001;

public class Parallel : TowerCharacterParalletBase
{
	private const int perkId_4 = 1500104;

	private const int buffId_Shock_P4 = 801170070;

	private const string areaEffectKey_Explosion_P4 = "AreaEffect_150_Main_Skill_P02_Boom_Small";

	private const int maxShockCount_P4 = 5;

	private static readonly FP shockImmuneDuration_P4 = 1;

	private readonly Dictionary<long, FP> _shockImmuneExpireTimeDict = new Dictionary<long, FP>();

	public override void OnDisable()
	{
		base.OnDisable();
		_shockImmuneExpireTimeDict.Clear();
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && GetPerk(1500104) && !(monster == null) && !IsShockImmune(monster))
		{
			monster.buffComponent.AddBuff(801170070, _actor);
			if (monster.buffComponent.GetBuffNumByID(801170070) >= 5)
			{
				monster.buffComponent.RemoveBuffByBuffId(801170070);
				_shockImmuneExpireTimeDict.set_Item(monster.Id, _actor.LogicTime + shockImmuneDuration_P4);
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Main_Skill_P02_Boom_Small", monster.tsTransform.Position);
			}
		}
	}

	private bool IsShockImmune(MonsterAdventureActor monster)
	{
		if (!_shockImmuneExpireTimeDict.TryGetValue(monster.Id, out var value))
		{
			return false;
		}
		if (_actor.LogicTime < value)
		{
			return true;
		}
		_shockImmuneExpireTimeDict.Remove(monster.Id);
		return false;
	}
}
