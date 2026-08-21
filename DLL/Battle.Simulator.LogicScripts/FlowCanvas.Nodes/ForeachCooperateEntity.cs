using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]遍历连携实体(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("Do : 先遍历连携实体,最后再走发起者")]
public class ForeachCooperateEntity : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<bool> _ConditionActiveInput;

	private ValueInput<int> _excludeInput;

	private FlowOutput _Do;

	private FlowOutput _Done;

	private FlowOutput _Error;

	private int _CooperateEntityID;

	private int _count;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("发起实体ID", "entityID");
		_ConditionActiveInput = AddValueInput<bool>("考虑连携启用状态", "ConditionActive").SetDefaultAndSerializedValue(v: true);
		_excludeInput = AddValueInput<int>("排除实体ID", "exclude");
		_Do = AddFlowOutput("Do", "do");
		_Done = AddFlowOutput("Done", "done");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_CooperateEntityID = 0;
			_count = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_Error.Call(f);
			}
			else
			{
				SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
				cooperate_unique_skill config;
				if (_ConditionActiveInput.value && simWorldState.m_cooperateUniqueSkillIsActive <= 0)
				{
					_Error.Call(f);
				}
				else if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(simWorldState.m_CooperateUniqueSkillID, out config))
				{
					_Error.Call(f);
				}
				else if (!config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
				{
					_Error.Call(f);
				}
				else
				{
					_count = config.CooperateRoleIds.Count;
					List<int> list = FrameListPool<int>.Claim();
					Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = simWorldState.mRoomMembers.GetEnumerator();
					while (enumerator.MoveNext())
					{
						int mEntityID = enumerator.Current.Value.mEntityID;
						SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mEntityID);
						if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && config.CooperateRoleIds.Contains(entityWithEntityID2.entityConfig.mId) && entityWithEntityID2.entityBlackboard.var.mHP > 0 && (_excludeInput.value == 0 || _excludeInput.value != mEntityID))
						{
							list.Add(mEntityID);
						}
					}
					for (int i = 0; i < list.Count; i++)
					{
						_CooperateEntityID = list[i];
						_Do.Call(f);
					}
					FrameListPool<int>.Release(list);
					_Done.Call(f);
				}
			}
		});
		AddValueOutput("参与实体ID(包含发起者)", "cooperateEntityID", () => _CooperateEntityID);
		AddValueOutput("发起实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("连携人数", "count", () => _count);
	}
}
