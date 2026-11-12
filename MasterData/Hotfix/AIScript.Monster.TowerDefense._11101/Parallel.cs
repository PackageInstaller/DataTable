using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11101;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Skill = CommonHelper.StringToHash("Skill");

	private int buffId_Cold = 801110210;

	private int buffId_Cold_P2 = 801110220;

	private int buffId_Freezing = 801110230;

	private int maxCount_ColdBuff_P2 = 5;

	private int buffTag_Cold = CommonHelper.StringToHash("Cold");

	private const int perkId_2 = 1110102;

	private const int perkId_4 = 1110104;

	private const string aoe_3 = "AreaEffect_8011101_Skill_IceWave_StunArea";

	private FP delayTime_3 = 1;

	private CoroutineNode corDelay;

	private int evt_CastArea = CommonHelper.StringToHash("CastArea");

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1110106] = 25 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corDelay);
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			int buffID = (GetPerk(1110102) ? buffId_Cold_P2 : buffId_Cold);
			monster.buffComponent.AddBuff(buffID, _actor);
			if (GetPerk(1110102) && monster.buffComponent.GetBuffNum(0, 0, buffTag_Cold) >= maxCount_ColdBuff_P2)
			{
				monster.buffComponent.RemoveBuffByBuffId(buffID);
				monster.buffComponent.AddBuff(buffId_Freezing, _actor);
			}
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == evt_CastArea)
		{
			TSVector2 pos = evt.tsVector2ParamList.get_Item(0);
			StartCoroutine(ref corDelay, DoCastAreaEffect(pos));
		}
	}

	private IEnumerator DoCastAreaEffect(TSVector2 pos)
	{
		yield return _actor.WaitTime(delayTime_3);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_8011101_Skill_IceWave_StunArea", pos, _actor.tsTransform.Rotation);
	}
}
