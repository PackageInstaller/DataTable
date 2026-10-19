using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("判定当前是否有buff，有buff返还success，没有buff返还failure")]
public class BTCheckGroupVariable : Conditional
{
	public enum LogicMode
	{
		or,
		and
	}

	[Tooltip("检测group内所有成员")]
	public bool forAllChildren;

	public LogicMode logicMode;

	[Tooltip("变量名")]
	public string checkVariableName;

	[SharedRequired]
	public SharedVariable variable;

	[SharedRequired]
	[Tooltip("The target entity")]
	public SharedEntity targetEntity;

	public override TaskStatus OnUpdate()
	{
		if (variable == null)
		{
			return TaskStatus.Failure;
		}
		bool flag = false;
		bool flag2 = true;
		if (forAllChildren)
		{
			ActBehaviorTree actBehaviorTree = Owner as ActBehaviorTree;
			if (Singleton<GroupAIManager>.instance.GetGroupAI(actBehaviorTree.Entity.GetCompGroupAI().id, out var entity) && entity.IsValid)
			{
				foreach (Entity item in entity.GetCompGroupAI().GetChildrenEntity())
				{
					CompAI compAI = item.GetCompAI();
					if (compAI == null)
					{
						continue;
					}
					ActBehaviorTree actBehaviorTree2 = compAI.ActBehaviorTree;
					if ((object)actBehaviorTree2 != null)
					{
						if (flag2)
						{
							flag = actBehaviorTree2.GetVariable(checkVariableName).GetValue().Equals(variable.GetValue());
							flag2 = false;
						}
						else
						{
							flag = ((logicMode != LogicMode.or) ? (flag && actBehaviorTree2.GetVariable(checkVariableName).GetValue().Equals(variable.GetValue())) : (flag || actBehaviorTree2.GetVariable(checkVariableName).GetValue().Equals(variable.GetValue())));
						}
					}
				}
			}
		}
		else
		{
			SharedEntity sharedEntity = targetEntity;
			if (sharedEntity != null)
			{
				Entity value = sharedEntity.Value;
				if (value.TryGetCompAI(out CompAI component))
				{
					ActBehaviorTree actBehaviorTree3 = component.ActBehaviorTree;
					if ((object)actBehaviorTree3 != null)
					{
						SharedVariable sharedVariable = actBehaviorTree3.GetVariable(checkVariableName);
						if (sharedVariable != null)
						{
							flag = sharedVariable.GetValue().Equals(variable.GetValue());
						}
					}
				}
			}
		}
		if (!flag)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
