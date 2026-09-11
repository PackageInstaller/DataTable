using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物返程", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物返程")]
public class ThrownMoveInBack : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				output.Call(f);
			}
			else if (thrownState.mDontMovement)
			{
				output.Call(f);
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
				if (config.ThrownBackActionInfoList.Count <= 0 || thrownState.mBackIndex >= config.ThrownBackActionInfoList.Count)
				{
					if (thrownState.mBackSpeed > 0)
					{
						MoveBackAction(base.mSimContext, thrownState, Int3.zero, CommonProcessor.GetConfigInterval());
					}
					output.Call(f);
				}
				else
				{
					int mLogicTime = thrownState.mLogicTime;
					ThrownBackActionInfo thrownBackActionInfo = config.ThrownBackActionInfoList.get_Item(thrownState.mBackIndex);
					if (mLogicTime >= thrownBackActionInfo.Start)
					{
						if (mLogicTime < thrownBackActionInfo.Start + thrownBackActionInfo.Duration && thrownState.mBackSpeed != int.MaxValue)
						{
							if (thrownState.mBackSpeed == 0)
							{
								thrownState.mBackSpeed = thrownBackActionInfo.Duration;
							}
							if (thrownBackActionInfo.OnceCalc)
							{
								MoveBackAction(base.mSimContext, thrownState, thrownState.mEarliestPosition, CommonProcessor.GetConfigInterval());
							}
							else
							{
								if (thrownState.mTargetID != thrownState.mCasterID)
								{
									thrownState.mTargetID = thrownState.mCasterID;
								}
								MoveBackAction(base.mSimContext, thrownState, Int3.zero, CommonProcessor.GetConfigInterval());
							}
						}
						else
						{
							thrownState.mBackIndex++;
							thrownState.mBackSpeed = 0;
						}
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}

	public void MoveBackAction(SimContext simContext, ThrownState thrownState, Int3 targetPos, int delta)
	{
		if (thrownState.mBackSpeed <= 0)
		{
			return;
		}
		VFactor vFactor = new VFactor(delta, thrownState.mBackSpeed);
		thrownState.mBackSpeed -= delta;
		if (targetPos == Int3.zero)
		{
			if (!CommonProcessor.TryGetAliveRole(simContext, thrownState.mTargetID, out var simEntity))
			{
				return;
			}
			targetPos = simEntity.entityPositon.mPosition;
		}
		Int3 @int = targetPos - thrownState.mPosition;
		Int3 int2 = @int * vFactor;
		thrownState.mForward = @int.NormalizeTo(1000);
		thrownState.mLastPosition = thrownState.mPosition;
		thrownState.mPosition += int2;
	}
}
