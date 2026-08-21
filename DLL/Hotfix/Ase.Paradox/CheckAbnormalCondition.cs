using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检测实体是否有该异常状态", 0)]
[Category("✫ DragonLost/State")]
[Description("检测指定实体是否具有特定的异常状态。")]
public class CheckAbnormalCondition : ConditionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要检测的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("异常状态ID", 0)]
	[Description("要检测的异常状态的ID。")]
	public BBParameter<int> stateId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return GetEntity(entityId.value, isSyncEntity: true)?.GetComponent<AbnormalStateComponent>().CheckAbnormalState(stateId.value) ?? false;
	}
}
