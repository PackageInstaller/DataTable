using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("CD返还事件(实体类型ID)", 0)]
[Category("Logic/事件")]
[Description("技能被自我打断时的事件(本事件会在CD返还后触发)")]
public class OnAbilityInterruptBySelfWithRoleID : OnAbilityInterruptBySelf
{
	private ValueInput<int> _roleIDInput;

	protected override void OnTriggerAbilityInterruptBySelf(int simEntityID, int abilityID)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID == null)
		{
			Debug.LogError("无法找到实体通过" + simEntityID);
		}
		else if (entityWithEntityID.entityConfig.mId == _roleIDInput.value)
		{
			base.OnTriggerAbilityInterruptBySelf(simEntityID, abilityID);
		}
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
	}
}
