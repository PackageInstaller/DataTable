using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[新多维额外按钮]设置CD", 0)]
[Category("Render/UI")]
[Description("设置CD")]
public class NewMatrixButtonSetCD : FlowNode
{
	private NewMatrixExButton button;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		button = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> agentIDInput = AddValueInput<int>("持有者实体");
		ValueInput<GameObject> go = AddValueInput<GameObject>("按钮预制体");
		ValueInput<string> pathInput = AddValueInput<string>("相对路径");
		FlowOutput outPut = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				if (button == null)
				{
					GameObject gameObject = go.value;
					if (gameObject == null)
					{
						Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
						gameObject = ((transform != null) ? transform.gameObject : null);
					}
					if (gameObject == null)
					{
						errorOutput.Call(f);
						return;
					}
					button = gameObject.GetComponent<NewMatrixExButton>();
					if (button == null)
					{
						errorOutput.Call(f);
						return;
					}
				}
				int cur = 0;
				int max = 1;
				if (battleScene.GetBuffManager().TryGetBuffByAgentIDAndBuffID(agentIDInput.value, buffIDInput.value, out var buffState))
				{
					cur = buffState.mDuring;
					max = buffState.mBuffKeepTime;
				}
				button.SetCD(cur, max);
				outPut.Call(f);
			}
		});
	}
}
