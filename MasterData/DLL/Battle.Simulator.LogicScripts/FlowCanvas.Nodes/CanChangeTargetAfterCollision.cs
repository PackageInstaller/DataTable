using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物是否可以切换目标", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物在接触到目标后,检查是否可以切换新目标,用于在接触判定之后")]
public class CanChangeTargetAfterCollision : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput abnormal = AddFlowOutput("异常");
		FlowOutput nonCollisionInfo = AddFlowOutput("无配置");
		FlowOutput fail = AddFlowOutput("不可切换");
		FlowOutput success = AddFlowOutput("可以切换");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddFlowInput("In", delegate(Flow f)
		{
			if (thrownIDVar.value == 0)
			{
				abnormal.Call(f);
			}
			else
			{
				ThrownState thrownState = null;
				if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
				{
					abnormal.Call(f);
				}
				else
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
					if (config == null)
					{
						abnormal.Call(f);
					}
					else if (config.ThrownCollisionCheckInfoList.Count <= 0)
					{
						nonCollisionInfo.Call(f);
					}
					else
					{
						int mConllisionCheckIndex = thrownState.mConllisionCheckIndex;
						if (mConllisionCheckIndex < 0 || mConllisionCheckIndex >= config.ThrownCollisionCheckInfoList.Count)
						{
							fail.Call(f);
						}
						else
						{
							ThrownCollisionCheckInfo thrownCollisionCheckInfo = config.ThrownCollisionCheckInfoList.get_Item(mConllisionCheckIndex);
							if (thrownCollisionCheckInfo == null)
							{
								abnormal.Call(f);
							}
							else if ((thrownCollisionCheckInfo.ThrownBehaviourOnCollision & 8) != 8)
							{
								fail.Call(f);
							}
							else if (thrownCollisionCheckInfo.ChangeTargetCountLimit <= 0)
							{
								fail.Call(f);
							}
							else
							{
								List<int> histotryList = null;
								ThrownProcessor.TryGetThrownHitHistory(base.mSimContext, thrownState.mCreationIndex, out histotryList);
								if (histotryList != null && histotryList.Count > thrownCollisionCheckInfo.ChangeTargetCountLimit)
								{
									fail.Call(f);
								}
								else
								{
									success.Call(f);
								}
							}
						}
					}
				}
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
