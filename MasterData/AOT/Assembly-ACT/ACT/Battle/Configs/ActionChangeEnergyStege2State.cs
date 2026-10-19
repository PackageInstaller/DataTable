using ACT.Event;
using ACT.UI;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改能量阶段2状态", "Action", new string[] { "change", "energy", "stege2", "state" })]
public class ActionChangeEnergyStege2State : ConfigAction
{
	public bool autoNext;

	public int state;

	public override void Do(ActionMemory memory)
	{
		if (autoNext)
		{
			int energyStageState = OperateBtnUtility.GetEnergyStageState(memory.owner.GetCompCharacter().characterSource.Id());
			FireEvent(memory, energyStageState + 1);
		}
		else
		{
			FireEvent(memory, state);
		}
	}

	private void FireEvent(ActionMemory memory, int stateLevel)
	{
		EnergyStage2StateChangeEvt evt = Singleton<EventManager>.instance.GetEvt<EnergyStage2StateChangeEvt>();
		evt.state = stateLevel;
		evt.entityId = memory.target.entity.Id;
		evt.customUICompType = CustomUICompType.EnergyBar;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtn_EnergyStage2, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
