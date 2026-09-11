using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物向目标点移动", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物使用配置的速度,向目标点移动,直到到达目标点")]
public class ThrownMoveByTargetPosition : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput arrive = AddFlowOutput("到达");
		FlowOutput dontMovement = AddFlowOutput("不移动");
		FlowOutput abnormal = AddFlowOutput("异常");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		Int3 targetPosition = Int3.up;
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else
			{
				targetPosition = thrownState.mTargetPosition;
				if (thrownState.mPosition == thrownState.mTargetPosition && !thrownState.mIsInLock)
				{
					arrive.Call(f);
				}
				else if (thrownState.mDontMovement)
				{
					dontMovement.Call(f);
				}
				else
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
					if (thrownState.mCurFrame < config.MoveActionTimelineNode.Duration)
					{
						Int3 mPosition = thrownState.mPosition;
						Int3 zero = Int3.zero;
						Int3 @int = thrownState.mTargetPosition - mPosition;
						if (thrownState.mIsInLock && thrownState.mCurLockIndex > 0 && thrownState.mCurLockIndex < config.ThrownLockActionInfoList.Count)
						{
							ThrownLockActionInfo thrownLockActionInfo = config.ThrownLockActionInfoList.get_Item(thrownState.mCurLockIndex);
							if (@int.sqrMagnitude <= (float)(thrownLockActionInfo.FollowThreshold * thrownLockActionInfo.FollowThreshold))
							{
								output.Call(f);
								return;
							}
						}
						VectorInt3 vectorInt = config.MoveActionTimelineNode.AverageSpeed;
						if (!config.MoveActionTimelineNode.UseUniformMotion)
						{
							vectorInt = config.MoveActionTimelineNode.AnimationMove.get_Item((int)thrownState.mCurFrame);
						}
						int z = vectorInt.Z;
						if (@int.sqrMagnitude <= (float)(z * z))
						{
							mPosition = thrownState.mTargetPosition;
						}
						else
						{
							zero = @int.NormalizeTo(1000) * new VFactor(z, 1000L);
							mPosition = thrownState.mPosition + zero;
						}
						if (config.IsUseConfigY)
						{
							int y = vectorInt.Y;
							thrownState.mHeight += y;
						}
						thrownState.mLastPosition = thrownState.mPosition;
						thrownState.mPosition = mPosition;
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
		AddValueOutput("目标点", () => targetPosition);
	}
}
