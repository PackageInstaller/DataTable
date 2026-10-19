using ACT.Core;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("直接恢复装备瓶使用数量", "Action", new string[] { "direct", "recover", "equip", "bottle", "use", "count", "heal", "hp" })]
public class DirectRecoverEquipBottleUseCount : ConfigAction
{
	public bool useConfigFunction;

	public int recoverCount;

	public ConfigFunction<float> configFunction;

	public override void Do(ActionMemory memory)
	{
		if (memory.owner.GetCompAbility().characterDamageType == CharacterDamageType.AssistStriker)
		{
			RecoverEquipBottleUseCountWithoutPropertyEvt evt = Singleton<EventManager>.instance.GetEvt<RecoverEquipBottleUseCountWithoutPropertyEvt>();
			evt.recoverCount = (useConfigFunction ? ((int)configFunction.Return(memory)) : recoverCount);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RecoverBottleUseCountDirect, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
