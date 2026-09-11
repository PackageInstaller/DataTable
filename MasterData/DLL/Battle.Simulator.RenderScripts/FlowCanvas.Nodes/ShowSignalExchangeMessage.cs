using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放队友信号", 0)]
[Category("Render/战斗喊话")]
[Description("播放队友信号")]
public class ShowSignalExchangeMessage : FlowNode
{
	private TalkButton talkButton;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		talkButton = null;
	}

	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> agentID = AddValueInput<int>("AgentID");
		ValueInput<int> contentID = AddValueInput<int>("喊话内容");
		ValueInput<string> pathInput = AddValueInput<string>("GameObject路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/TeamPanel_V/Button");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				if (talkButton == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform == null)
					{
						abnormalOut.Call(f);
						return;
					}
					talkButton = transform.GetComponent<TalkButton>();
				}
				if (talkButton == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					talkButton.OnSignalExchangeEvent(agentID.value, contentID.value);
					flowOut.Call(f);
				}
			}
		});
	}
}
