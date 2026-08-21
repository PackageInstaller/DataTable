using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示立绘图片", 0)]
[Category("Render/UI")]
[Description("显示立绘图片; 指定图片为空时, 从agent上读皮肤id")]
public class SpecialUIPortrait : FlowNode
{
	private BattleUIPortrait _com;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		_com = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		_com = null;
	}

	private void Init(string path)
	{
		if (_com == null)
		{
			Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(path);
			if (!(transform == null))
			{
				_com = transform.GetComponent("BattleUIPortrait") as BattleUIPortrait;
			}
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> parentPathInput = AddValueInput<string>("相对路径(相对于战斗面板)").SetDefaultAndSerializedValue("BattlePop/QTE_Portrait");
		ValueInput<string> texNameInput = AddValueInput<string>("指定图片");
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID(指定图片为空时有效)");
		ValueInput<string> pathInput = AddValueInput<string>("图片路径(指定图片为空时有效)").SetDefaultAndSerializedValue("TextureConfig/Character/Icon/");
		ValueInput<float> timeInput = AddValueInput<float>("时长");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			Init(parentPathInput.value);
			if (_com == null)
			{
				Debug.LogError("设置UI的Controller组件 没有控制器");
				errorOut.Call(f);
			}
			else
			{
				string text = texNameInput.value;
				if (string.IsNullOrEmpty(text))
				{
					NAgent nAgent = AgentManager.GetAgentManager()?.GetAgent(agentIDInput.value);
					if (nAgent == null)
					{
						errorOut.Call(f);
						return;
					}
					text = pathInput.value + nAgent.AgentSkinID;
				}
				_com.Play(text, timeInput.value);
				output.Call(f);
			}
		});
	}
}
