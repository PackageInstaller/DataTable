using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("本地玩家技能执行事件(奥义)(后摇)(逻辑)", 0)]
[Category("Logic/事件/奥义")]
[Description("本地玩家在后摇段持续触发的奥义执行事件")]
public class UniqueSkillAbilityEventOfLocalPlayerInBackswing : LogicAbilityEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (!CommonProcessor.IsInUniqueSkillABility(simEntity, abilityID))
		{
			return false;
		}
		if (!simEntity.hasEntityRemotePlayer || !simEntity.entityRemotePlayer.mIsLocalPlayer)
		{
			return false;
		}
		if (!ConfigProcessor.IsRecover(simEntity))
		{
			return false;
		}
		return true;
	}
}
