using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.ElementTag;

public class ElementTag_Wind : BaseElementTag
{
	public static readonly int windMaskTag1 = CommonHelper.StringToHash("WindTag1");

	public static readonly int windBuffId = 2011;

	public static readonly int windMaskTag2 = CommonHelper.StringToHash("WindTag2");

	private static readonly int windBoomHit = CommonHelper.StringToHash("WindTag1Boom");

	private readonly int windCdBuff = 2100;

	private readonly string windAreaEffect_1 = "AreaEffect_112_WindTag1_Boom";

	private readonly string windAreaEffect_2 = "AreaEffect_112_WindTag1_Boom";

	protected override void OnBeHitTrigger(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		if (!actorFilterDic.TryGetValue(evt.from.Id, out var value) || value == 112)
		{
			CommonUtils.CheckHitByTag(evt.hitDamageTag, windBoomHit);
		}
	}

	protected override void OnEventTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}

	private void OnWindBrust(ElementMarkType markType = ElementMarkType.WindCyclone)
	{
		bool flag = markType == ElementMarkType.WindCyclone;
		ILRuntimeAPI.PlayAreaEffect(_actor, flag ? windAreaEffect_2 : windAreaEffect_1, _monster.tsTransform.Position, _actor.tsTransform.Rotation);
		PlayerElementMarkTriggerCompleteEvent playerElementMarkTriggerCompleteEvent = PlayerElementMarkTriggerCompleteEvent.Generate();
		playerElementMarkTriggerCompleteEvent.triggerActor = _actor;
		playerElementMarkTriggerCompleteEvent.markType = ElementMarkType.Wind;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(playerElementMarkTriggerCompleteEvent);
	}

	private bool checkWindMaskCanbeTrigger(BuffCom _bfCom, ElementMarkType markType = ElementMarkType.WindCyclone)
	{
		if (_bfCom == null)
		{
			return false;
		}
		if (!_bfCom.CheckBuffByBuffID(windCdBuff))
		{
			return _bfCom.CheckBuffByBuffTag((markType == ElementMarkType.WindCyclone) ? windMaskTag2 : windMaskTag1);
		}
		return false;
	}
}
