#define LOG_DEBUG
#define LOG_ERROR
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_WindBlade : BaseFateCardTheme
{
	private const string windBladePath = "FateCard_windBlade";

	private const string triggerFxPath = "wind_trigger_s";

	private const int windBladeDefaultReboundCount = 3;

	private const int windBladeDefaultShootCount = 3;

	private readonly FP shootDelay = 0.4f;

	private readonly FP cd = 3;

	private const int hitDamageId = 986011;

	private const string whiteWindBladeBulltKey = "WindBladeWhite";

	private readonly FP whiteWindBladeBulltSearchTargetRadius = 15;

	private const string triggerFx_Pro = "wind_fengren_bird_end_14";

	private readonly string scatteringDartsPath_Pro = "FateCard_windBlade_White_3";

	private readonly FP rate_ProA = 0.3;

	private readonly FP rate_ProB = 0.3;

	private GameObject _scatteringDartsPrefab;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_WindBlade OnEnable");
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WINDBLADE_REBOUND", OnWindBladeRebound);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WINDBLADE_REBOUND", OnWindBladeRebound);
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_WindBlade OnTrigger");
		if (CheckTimeout(cd))
		{
			ShootWindBlade();
			TriggerTheme();
		}
	}

	private void ShootWindBlade()
	{
		CommonUtils.PlayOneOffFx(_actor, "wind_trigger_s");
		StartLogicCoroutine(CurShootWindBlade(3, 986011, 3));
	}

	private IEnumerator CurShootWindBlade(int shootCount, int hitDamageId, int reboundTime)
	{
		for (int i = 0; i < shootCount; i++)
		{
			TSVector2 dirction = _actor.tsTransform.Forward;
			if (_actor.attackTarget != null)
			{
				dirction = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			AdventureWindBlade adventureWindBlade = ILRuntimeAPI.Shoot("FateCard_windBlade", _actor, _actor.tsTransform.Position, dirction) as AdventureWindBlade;
			if (adventureWindBlade != null)
			{
				adventureWindBlade.hitDamageId = hitDamageId;
				adventureWindBlade.reboundCount = reboundTime;
				adventureWindBlade.damageImmuneDuration = -1;
				adventureWindBlade.reboundToPlayer = CanExcuteA;
			}
			else
			{
				NovaLogger.Error("释放的飞行道具非风刃");
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(shootDelay));
		}
	}

	private void OnWindBladeRebound(IEvent evt)
	{
		if (!(evt is WindBladeReboundEvent windBladeReboundEvent))
		{
			return;
		}
		if (CanExcuteA && windBladeReboundEvent.reboundWithPlayer && TSRandom.Range(FP.Zero, FP.One) <= rate_ProA)
		{
			CommonUtils.PlayOneOffFx(_actor, "wind_fengren_bird_end_14");
			if (_scatteringDartsPrefab == null)
			{
				_scatteringDartsPrefab = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, scatteringDartsPath_Pro, forceUseCommonConfig: true);
			}
			SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, _scatteringDartsPrefab, windBladeReboundEvent.windBlade.transform.position, Quaternion.identity);
		}
		if (CanExcuteB && !windBladeReboundEvent.reboundWithPlayer && TSRandom.Range(FP.Zero, FP.One) <= rate_ProB)
		{
			CommonUtils.PlayOneOffFx(_actor, "wind_fengren_bird_end_14");
			if (_scatteringDartsPrefab == null)
			{
				_scatteringDartsPrefab = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, scatteringDartsPath_Pro, forceUseCommonConfig: true);
			}
			SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, _scatteringDartsPrefab, windBladeReboundEvent.windBlade.transform.position, Quaternion.identity);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner is PlayerAdventureActor && adventureBulletBornEvent.tag.Equals("WindBladeWhite"))
		{
			AdventureBezierBullet adventureBezierBullet = adventureBulletBornEvent.sender as AdventureBezierBullet;
			if (adventureBezierBullet != null)
			{
				LogicEntity target = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, whiteWindBladeBulltSearchTargetRadius);
				adventureBezierBullet.target = target;
			}
		}
	}
}
