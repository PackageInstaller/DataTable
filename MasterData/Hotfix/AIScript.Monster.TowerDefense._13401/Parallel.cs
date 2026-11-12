using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13401;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Normal = CommonHelper.StringToHash("NrmAtk");

	private int hitTag_Skill = CommonHelper.StringToHash("Skill");

	private const int perkId_1 = 1340101;

	private const string areaEffcct_1 = "Area_Fire_P1";

	private FP delayTime_1 = 0;

	private const int perkId_2 = 1340102;

	private int buffId_2 = 801340210;

	private const int perkId_4 = 1340104;

	private int buffId_4 = 801340110;

	private int once_4 = 811340001;

	private FP cd_4 = 0.03f;

	private long areaId;

	private AreaEffectEntity areaEffect;

	private CoroutineNode corDelay;

	private int buffNum;

	public override void OnEnable()
	{
		base.OnEnable();
		buffNum = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corDelay);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		if (GetPerk(1340101))
		{
			areaId = ILRuntimeAPI.PlayAreaEffect(_actor, "Area_Fire_P1", _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
			{
				areaEffect = entity;
			});
		}
		if (GetPerk(1340104))
		{
			buffNum = _actor.buffComponent.GetBuffNumByID(buffId_4);
			_actor.buffComponent.RemoveBuffByBuffId(buffId_4);
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerk(1340101))
			{
				StartCoroutine(ref corDelay, DelayEndArea());
			}
			if (GetPerk(1340102))
			{
				_actor.buffComponent.AddBuff(buffId_2, _actor);
			}
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		if ((GetPerk(1340104) & flag) && buffNum > 0)
		{
			AdventureActor.AddFromAttr(once_4, _actor, buffNum);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf)
		{
			bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
			if ((GetPerk(1340104) & flag) && CheckPerkCd(1340104L, cd_4))
			{
				_actor.buffComponent.AddBuff(buffId_4, _actor);
			}
		}
	}

	private IEnumerator DelayEndArea()
	{
		yield return _actor.WaitTime(delayTime_1);
		if (areaId != 0L)
		{
			ILRuntimeAPI.StopAreaEffect(areaId);
			areaId = 0L;
			areaEffect = null;
		}
	}
}
