using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增益掉落执行逻辑封装(逻辑)", 0)]
[Category("Logic/增益掉落")]
[Description("增益掉落的执行逻辑封装")]
public class BuffItemExecute : FlowControlNode
{
	private ValueInput<int> m_thrownIDInput;

	private ValueInput<int> m_backTimeInput;

	private ValueInput<int> m_collisionRadiusAddValueInput;

	private FlowOutput m_nonInRange;

	private FlowOutput m_uncollision;

	private FlowOutput m_collided;

	private FlowOutput m_error;

	private int m_targetID;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownID");
		m_backTimeInput = AddValueInput<int>("返程耗时(毫秒)", "backTime").SetDefaultAndSerializedValue(800);
		m_collisionRadiusAddValueInput = AddValueInput<int>("接触半径增量(毫秒)", "collisionRadius").SetDefaultAndSerializedValue(500);
		m_nonInRange = AddFlowOutput("未在范围内", "nonInRang");
		m_uncollision = AddFlowOutput("未接触到", "m_dontCollision");
		m_collided = AddFlowOutput("接触到目标", "collided");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, m_thrownIDInput.GetValue(), out var thrownState))
			{
				m_error.Call(f);
			}
			else
			{
				m_targetID = 0;
				SimEntity simEntity;
				if (thrownState.mDontMovement)
				{
					if (CommonProcessor.IsMultiplePlayerGameMode(base.mSimContext))
					{
						Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
						while (enumerator.MoveNext())
						{
							if (CheckBuffItemInRange(base.mSimContext, enumerator.Current.Value.mEntityID, thrownState))
							{
								m_uncollision.Call(f);
								return;
							}
						}
					}
					else
					{
						int mLocalPlayerID = CommonProcessor.GetWorldState().mLocalPlayerID;
						if (CheckBuffItemInRange(base.mSimContext, mLocalPlayerID, thrownState))
						{
							m_uncollision.Call(f);
							return;
						}
					}
					m_nonInRange.Call(f);
				}
				else if (!CommonProcessor.TryGetAliveRole(base.mSimContext, thrownState.mTargetID, out simEntity))
				{
					ThrownProcessor.DestoryThrown(base.mSimContext, thrownState);
					m_error.Call(f);
				}
				else
				{
					m_targetID = thrownState.mTargetID;
					long num = MovementProcessor.SqrDistance(thrownState.mPosition, simEntity);
					RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(simEntity.ENTITY_CONFIG_ID);
					if (config != null && config.Radius.Count > 0)
					{
						int num2 = config.Radius.get_Item(0) + m_collisionRadiusAddValueInput.GetValue();
						if (num <= num2 * num2)
						{
							ThrownProcessor.DestoryThrown(base.mSimContext, thrownState);
							m_collided.Call(f);
							return;
						}
					}
					m_uncollision.Call(f);
				}
			}
		});
		AddValueOutput("目标实体ID", "targetEntityID", () => m_targetID);
	}

	private bool CheckBuffItemInRange(SimContext mSimContext, int mEntityID, ThrownState thrownState)
	{
		int itemPickUpRadius = -1;
		if (CommonProcessor.TryGetAliveRole(mSimContext, mEntityID, out var simEntity) && AttributeProcessor.TryGetItemPickUpRadius(mSimContext, mEntityID, out itemPickUpRadius) && MovementProcessor.SqrDistance(thrownState.mPosition, simEntity) <= itemPickUpRadius * itemPickUpRadius)
		{
			thrownState.mBackSpeed = m_backTimeInput.GetValue();
			thrownState.mBackTargetPosition = Int3.zero;
			thrownState.mTargetID = mEntityID;
			thrownState.mDontMovement = false;
			m_targetID = thrownState.mTargetID;
			mSimContext.PostEvent(BuffItemCloseToEntityEvent.Claim(thrownState.mCreationIndex, thrownState.mTargetID));
			return true;
		}
		return false;
	}
}
