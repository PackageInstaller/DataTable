using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.TowerDefense._13501;

public class Parallel : TowerCharacterParalletBase
{
	private int summonId = 8013501;

	private int summonInherit = 100;

	private FP summonLeftTime = 8;

	private string bullet_summon = "Bullet_135_Skil_Main_Call_Bullt";

	private string bulletTag_Summon = "noTrace";

	private string areaEffect_base = "AreaEffect_135_GhostDoor";

	private string areaEffect_P04 = "AreaEffect_135_GhostDoor_T23";

	private FP offset = 3.72f;

	private FP interval_base = 0.5f;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private const int perkId_1 = 1350101;

	private const int interval_P01 = 1;

	private FP scale_P01 = 0.08;

	private FP maxScale_P01 = 1;

	private int maxBuffCount_P01 = 10;

	private const int perkId_2 = 1350102;

	private const int perkId_3 = 1350103;

	private FP interval_3 = 0.35;

	private const int perkId_4 = 1350104;

	private FP pullWeight_P04 = 3;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1350107] = 25 };

	private AreaEffectEntity areaEntity;

	private CoroutineNode corSummon;

	private CoroutineNode corAreaFollow;

	private SummonCfg summonCfg = new SummonCfg();

	private int _perk01Count;

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnSummonBulletFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnSummonBulletFinish);
		StopCoroutine(ref corSummon);
		StopCoroutine(ref corAreaFollow);
	}

	private void OnReceiveSelfCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent) || adventureActorCustomEvent.eventHashCode != summonEvt)
		{
			return;
		}
		if (areaEntity != null)
		{
			areaEntity.OnBeforeEnd = null;
			ILRuntimeAPI.StopAreaEffect(areaEntity.Id);
			areaEntity = null;
			StopCoroutine(ref corSummon);
		}
		TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * offset));
		string fxAlias = (GetPerk(1350104) ? areaEffect_P04 : areaEffect_base);
		long id = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, default, (AreaEffectEntity entity) =>
		{
			HandlePerkLogic(entity);
		});
		areaEntity = ILRuntimeAPI.GetAreaEffect(id);
		if (areaEntity != null)
		{
			areaEntity.OnBeforeEnd = () =>
			{
				StopCoroutine(ref corSummon);
			};
			StartCoroutine(ref corSummon, IntervalSummon());
		}
	}

	private void HandlePerkLogic(AreaEffectEntity entity)
	{
		AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
		AreaEffect_PullComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_PullComponent>();
		AreaEffect_FollowComponent logicComponent3 = entity.GetLogicComponent<AreaEffect_FollowComponent>();
		logicComponent.enabled = false;
		logicComponent.hitImmediately = false;
		logicComponent2.enabled = false;
		logicComponent3.enabled = false;
		if (GetPerk(1350102))
		{
			logicComponent.enabled = true;
			logicComponent3.enabled = true;
			logicComponent3.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
			logicComponent3.FollowTarget = _actor.attackTarget;
			logicComponent3.isSlowMove = true;
			StartCoroutine(ref corAreaFollow, UpdateFollow(entity));
		}
		if (GetPerk(1350104))
		{
			logicComponent2.enabled = true;
			logicComponent2.pullInterval = 0.1f;
			logicComponent2.pullSpeed = 3f;
			logicComponent2.pullLevel = 99;
			logicComponent2.strength = pullWeight_P04;
			logicComponent2.pullWithRadius = false;
			logicComponent2.changeTargetDirection = false;
		}
	}

	private IEnumerator UpdateFollow(AreaEffectEntity entity)
	{
		AreaEffect_FollowComponent followCom = entity.GetLogicComponent<AreaEffect_FollowComponent>();
		while (entity != null && followCom != null && followCom.enabled)
		{
			if (_actor.attackTarget != null)
			{
				followCom.FollowTarget = _actor.attackTarget;
			}
			yield return null;
		}
	}

	private IEnumerator IntervalSummon()
	{
		FP interval = interval_base;
		if (GetPerk(1350103))
		{
			interval = interval_base * (1 - interval_3);
		}
		bool p01 = GetPerk(1350101);
		_perk01Count = 0;
		FP curTime_summon = 0;
		FP curTime_scale = 0;
		while (true)
		{
			if (p01 && curTime_scale >= 1)
			{
				_perk01Count++;
				curTime_scale = 0;
			}
			if (curTime_summon >= interval && _actor.attackTarget != null)
			{
				ShootSummonBullet(_actor.attackTarget.tsTransform.Position);
				curTime_summon = 0;
			}
			yield return null;
			curTime_summon += _actor.LogicDeltaTime;
			curTime_scale += _actor.LogicDeltaTime;
		}
	}

	private void ShootSummonBullet(TSVector2 targetPos)
	{
		if (!(areaEntity == null))
		{
			AdventureBezierBullet adventureBezierBullet = ILRuntimeAPI.Shoot(bullet_summon, _actor, default, areaEntity.tsTransform.Position, 0, targetPos, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureBezierBullet;
			if (adventureBezierBullet != null)
			{
				adventureBezierBullet.isTraceable = false;
				adventureBezierBullet.bulletTag = bulletTag_Summon;
			}
		}
	}

	private void OnSummonBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (!(_actor == null) && !(adventureBulletFinishEvent.owner == null) && adventureBulletFinishEvent.owner.Id == _actor.Id && adventureBulletFinishEvent.tag.Equals(bulletTag_Summon) && adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill)
		{
			SummonActor(_perk01Count, adventureBulletFinishEvent.bulletPosition);
		}
	}

	private void SummonActor(int count, TSVector2 pos)
	{
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.Self;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = summonLeftTime;
		summonCfg.summonType = SummonType.Minion;
		ILRuntimeAPI.SummonMonster(_actor, 0, summonId, pos, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			if (GetPerk(1350101))
			{
				monster.ClearTag("buff_count");
				int num = Mathf.Min(count, maxBuffCount_P01);
				for (int i = 0; i < num; i++)
				{
					monster.AddTag("buff_count");
				}
				FP modelScale = monster.actorScaleInfo.modelScale;
				monster.actorScaleInfo.modelScale = modelScale + TSMath.Min(count * scale_P01, maxScale_P01);
			}
		});
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
	}
}
