using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.ElementTag;

public class ElementTag_Light : BaseElementTag
{
	public static readonly int LightTag1 = CommonHelper.StringToHash("LightTag1");

	private static readonly int lightBoomHit = CommonHelper.StringToHash("LightTagBoom");

	private readonly string lightAreaEffect_1 = "AreaEffect_117_B1_LightTag_Boom";

	protected override void OnBeHitTrigger(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		if ((!actorFilterDic.TryGetValue(evt.from.Id, out var value) || value == 117) && CommonUtils.CheckHitByTag(evt.hitDamageTag, lightBoomHit) && checkCanbeTrigger(_monster.buffComponent))
		{
			OnTriggerArea();
		}
	}

	protected override void OnEventTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}

	private void OnTriggerArea()
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, lightAreaEffect_1, _monster.tsTransform.Position, _actor.tsTransform.Rotation);
		PlayerElementMarkTriggerCompleteEvent playerElementMarkTriggerCompleteEvent = PlayerElementMarkTriggerCompleteEvent.Generate();
		playerElementMarkTriggerCompleteEvent.triggerActor = _actor;
		playerElementMarkTriggerCompleteEvent.markType = ElementMarkType.LightMark_1;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(playerElementMarkTriggerCompleteEvent);
	}

	private bool checkCanbeTrigger(BuffCom _bfCom)
	{
		if (_bfCom == null)
		{
			return false;
		}
		return _bfCom.CheckBuffByBuffTag(LightTag1);
	}
}
