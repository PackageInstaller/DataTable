using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("初始化交流信号", 0)]
[Category("Render/战斗喊话")]
[Description("初始化交流信号")]
public class InitSignalExchangeMessage : FlowNode
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
		ValueInput<string> pathInput = AddValueInput<string>("GameObject路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/TeamPanel_V/Button");
		ValueInput<List<int>> contentIDs = AddValueInput<List<int>>("内容");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.battlePanelGameObject == null)
			{
				abnormalOut.Call(f);
				Debug.LogError("bs.battlePanelGameObject");
			}
			else
			{
				if (talkButton == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform == null)
					{
						abnormalOut.Call(f);
						Debug.LogError("bs.transform.Find(pathInput.value)");
						return;
					}
					talkButton = transform.GetComponent<TalkButton>();
				}
				if (talkButton == null)
				{
					abnormalOut.Call(f);
					Debug.LogError("GetComponent<TalkButton>()");
				}
				else
				{
					talkButton.Init(contentIDs.value);
					flowOut.Call(f);
				}
			}
		});
	}
}
