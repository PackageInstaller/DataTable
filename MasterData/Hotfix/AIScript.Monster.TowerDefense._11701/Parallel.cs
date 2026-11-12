using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using TrueSync.Physics2D;

namespace AIScript.Monster.TowerDefense._11701;

public class Parallel : TowerCharacterParalletBase
{
	private const int perkId_1 = 1170101;

	private const int cdReducePercent_1 = 100;

	private const int perkId_2 = 1170102;

	private readonly FP linkCheckRange_2 = 5;

	private const int maxLinkTime_2 = 4;

	private const int hitDamageId_2 = 80117017;

	private const string hitFxPath_2 = "fx_11701_bullet_atk_1";

	private readonly FP linkHitInterval_2 = 0.35;

	private const int perkId_3 = 1170103;

	private static readonly int[] damageEnhanceBuff_3 = new int[3] { 1769104211, 1345221744, 1769173857 };

	private const int perkId_4 = 1170104;

	private const string areaEffect_4 = "Bullet_11701_B2P24_Skill_Boom";

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1170101] = 100 };

	private CoroutineNode _linkCoroutine;

	private List<LogicEntity> _ridList = new List<LogicEntity>();

	private int _linkTimes;

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref _linkCoroutine);
		_ridList.Clear();
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		if (GetPerk(1170102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, SkillScript_Skill.hitTag_Thunder))
		{
			ClearLink_2();
			ExtraHit_2(monster);
		}
		if (GetPerk(1170103) && CommonUtils.CheckHitByTag(evt.hitDamageTag, SkillScript_Skill.hitTag_Thunder))
		{
			int num = 0;
			int num2 = 0;
			int[] array = damageEnhanceBuff_3;
			foreach (int num3 in array)
			{
				num = _actor.buffComponent.GetBuffNumByID(801170070);
				if (num > 0)
				{
					num2 = num3;
					break;
				}
			}
			int num4 = MathUtils.Clamp(num + 1, 0, damageEnhanceBuff_3.Length - 1);
			int num5 = damageEnhanceBuff_3[num4];
			if (num5 == num2)
			{
				_actor.buffComponent.AddBuff(num5, _actor);
			}
			else
			{
				_actor.buffComponent.RemoveBuffByBuffId(num2);
				_actor.buffComponent.AddBuffNum(num5, num + 1, _actor);
			}
		}
		if (GetPerk(1170104) && CommonUtils.CheckHitByTag(evt.hitDamageTag, SkillScript_Skill.hitTag_Thunder))
		{
			TSVector2 position = monster.tsTransform.Position;
			ILRuntimeAPI.PlayAreaEffect(_actor, "Bullet_11701_B2P24_Skill_Boom", position);
		}
	}

	private void ExtraHit_2(LogicEntity target)
	{
		if (_linkTimes >= 4)
		{
			ClearLink_2();
			return;
		}
		_ridList.Add(target);
		ILRuntimeAPI.SearchByRange(target as AdventureActor, linkCheckRange_2, (List<LogicEntity> result) =>
		{
			for (int num = result.Count - 1; num >= 0; num--)
			{
				if (_ridList.Contains(result.get_Item(num)) || result.get_Item(num) is TowerDefenseCharacterActor || result.get_Item(num).IsSummoned(out var _, out var _))
				{
					result.RemoveAt(num);
				}
			}
			if (result.Count == 0)
			{
				ClearLink_2();
			}
			else
			{
				LogicEntity logicEntity = result.get_Item(0);
				ILRuntimeAPI.HitActor(_actor, logicEntity as AdventureActor, 80117017, null, "fx_11701_bullet_atk_1", attackFxPlayOnTarget: true);
				_linkTimes++;
				StartCoroutine(ref _linkCoroutine, WaitAndLink_2(logicEntity));
			}
		});
	}

	private IEnumerator WaitAndLink_2(LogicEntity target)
	{
		yield return _actor.WaitTime(linkHitInterval_2);
		ExtraHit_2(target);
	}

	private void ClearLink_2()
	{
		StopCoroutine(ref _linkCoroutine);
		_ridList.Clear();
		_linkTimes = 0;
	}
}
