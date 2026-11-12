#define LOG_DEBUG
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_FallingStone : BaseFateCardTheme
{
	private const string bulletPath = "FateCard_FallingStone";

	private const int hitDamageId = 986161;

	private readonly FP cd = 3;

	private const string triggerFxPath = "fire_trigger_s";

	private const string bulletTag = "FallingStone";

	private readonly FP targetSearchRange = 10;

	private const int hitDamageId_1_enhance = 986162;

	private readonly int replaceCount = 2;

	private readonly string bulletPath_intensive1 = "FateCard_FallingStone_16";

	private const string bulletPath_instensive2_timeBoom = "FateCard_FallingStone_17";

	private const string shootCountKey = "fallingStoneShootCount";

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_FallingStone OnEnable");
		base.OnEnable();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_FallingStone OnTrigger");
		if (CheckTimeout(cd))
		{
			Shoot(986161, 986162);
			TriggerTheme();
		}
	}

	private void Shoot(int hitDamageId, int hitDamageIdEnhance)
	{
		LogicEntity shootTarget = GetShootTarget();
		if (!(shootTarget == null))
		{
			AddKey("fallingStoneShootCount");
			CommonUtils.PlayOneOffFx(_actor, "fire_trigger_s");
			(bool, string) tuple = GetBulletPath();
			bool item = tuple.Item1;
			string item2 = tuple.Item2;
			AdventureActor actor = _actor;
			TSVector2 position = shootTarget.tsTransform.Position;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(item2, actor, default, default, default, position, null, AimType.Position);
			adventureBulletBase.hitBox.hitDamageId = ((!item) ? hitDamageId : hitDamageIdEnhance);
			adventureBulletBase.useOwnerActorInfo = true;
		}
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		if (_evt != null && _evt.tag == "FallingStone" && CanExcuteB)
		{
			ILRuntimeAPI.Shoot("FateCard_FallingStone_17", _actor, default, _evt.bulletPosition, 1, _evt.bulletPosition, null, AimType.Position);
		}
	}

	private (bool, string) GetBulletPath()
	{
		bool item = false;
		string item2 = "FateCard_FallingStone";
		if (CanExcuteA && GetKeyCount("fallingStoneShootCount") == replaceCount + 1)
		{
			ClearKey("fallingStoneShootCount");
			item2 = bulletPath_intensive1;
			item = true;
		}
		return (item, item2);
	}

	private LogicEntity GetShootTarget()
	{
		if (_actor.attackTarget != null)
		{
			return _actor.attackTarget;
		}
		LogicEntity target = null;
		ILRuntimeAPI.SearchByRange(_actor, targetSearchRange, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.SearchEntitySortByDistance(result);
				target = result.get_Item(0);
			}
		}, isConfront: true);
		return target;
	}
}
