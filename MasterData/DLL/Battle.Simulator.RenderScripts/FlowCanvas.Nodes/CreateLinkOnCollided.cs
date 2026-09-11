using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("抛掷物闪电链", 0)]
[Category("Render/抛掷物")]
[Description("在抛掷物接触到实体后,将接触的实体进行连线")]
[ExposeAsDefinition]
public class CreateLinkOnCollided : FlowControlNode
{
	protected override void RegisterPorts()
	{
		AddFlowOutput("Out");
		FlowOutput abnormal = AddFlowOutput("异常退出");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<int> colliedIDVar = AddValueInput<int>("接触实体ID");
		ValueInput<int> timelineIDVar = AddValueInput<int>("TimelineID");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else
			{
				TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(timelineIDVar.value);
				if (timelineInfo == null)
				{
					abnormal.Call(f);
				}
				else if (timelineInfo.thrownCollisionCheckClips.Count <= 0)
				{
					abnormal.Call(f);
				}
				else
				{
					int mConllisionCheckIndex = thrownState.mConllisionCheckIndex;
					if (mConllisionCheckIndex < 0 || mConllisionCheckIndex >= timelineInfo.thrownCollisionCheckClips.Count)
					{
						abnormal.Call(f);
					}
					else
					{
						ThrownCollisionCheckClip thrownCollisionCheckClip = timelineInfo.thrownCollisionCheckClips[mConllisionCheckIndex];
						if (!string.IsNullOrEmpty(thrownCollisionCheckClip.LinkMainEffectPath) || !string.IsNullOrEmpty(thrownCollisionCheckClip.LinkOtherEffectPath))
						{
							List<int> histotryList = null;
							ThrownProcessor.TryGetThrownHitHistory(base.mSimContext, thrownIDVar.GetValue(), out histotryList);
							if (histotryList != null && histotryList.Count > 0)
							{
								string text = thrownCollisionCheckClip.LinkMainEffectPath;
								for (int num = histotryList.Count - 1; num >= 0; num--)
								{
									if (histotryList[num] == colliedIDVar.value)
									{
										if (num == 0)
										{
											if (string.IsNullOrEmpty(text))
											{
												break;
											}
										}
										else if (!string.IsNullOrEmpty(thrownCollisionCheckClip.LinkOtherEffectPath))
										{
											text = thrownCollisionCheckClip.LinkOtherEffectPath;
										}
										if (!string.IsNullOrEmpty(text) && (NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager.TryGetThrownTimelinePlayer(thrownIDVar.value, out var player))
										{
											NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(histotryList[num]);
											NAgent nAgent = ((num == 0) ? (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent() : (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(histotryList[num - 1]));
											if (agent != null && nAgent != null)
											{
												Transform transform = agent.transform;
												Transform transform2 = nAgent.transform;
												if (transform2 != null && transform != null)
												{
													player.PlayCommonLine(text, transform2, transform, 0.3f);
												}
											}
										}
										break;
									}
								}
							}
						}
					}
				}
			}
		});
	}
}
