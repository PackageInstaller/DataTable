using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._14001;

public class Parallel : TowerCharacterParalletBase
{
	private const int perkId_3 = 1400103;

	private int damageTag_P03 = CommonHelper.StringToHash("140_P01");

	private int buffId_AttachCrystal = 801400010;

	private int maxAttachCount = 6;

	private int buffId_Crystallization = 801400020;

	private int buffId_Stun = 801400030;

	private int hitDamageId_P03 = 80140025;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1400107] = 20 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf || !GetPerk(1400103))
		{
			return;
		}
		if (monster.buffComponent.CheckBuffByBuffID(buffId_Crystallization) && evt.hitDamageId != hitDamageId_P03)
		{
			ILRuntimeAPI.HitActor(_actor, monster, hitDamageId_P03, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, damageTag_P03))
		{
			monster.buffComponent.AddBuff(buffId_AttachCrystal, _actor);
			if (monster.buffComponent.GetBuffNumByID(buffId_AttachCrystal) >= maxAttachCount)
			{
				monster.buffComponent.RemoveBuffByBuffId(buffId_AttachCrystal);
				monster.buffComponent.AddBuff(buffId_Crystallization, _actor);
				monster.buffComponent.AddBuff(buffId_Stun, _actor);
				ILRuntimeAPI.HitActor(_actor, monster, hitDamageId_P03, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			}
		}
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
	}
}
