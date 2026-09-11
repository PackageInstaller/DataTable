using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("控制场景循环脚本", 0)]
[Category("Render/Agent")]
[Description("控制场景循环脚本")]
public class SceneLoopingNode : FlowNode
{
	public SceneLooping GetSceneLooping(string path)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null || battleScene.sceneSetting == null)
		{
			return null;
		}
		Transform transform = battleScene.sceneSetting.transform;
		if (!string.IsNullOrEmpty(path))
		{
			transform = battleScene.sceneSetting.transform.Find(path);
		}
		if (transform == null)
		{
			return null;
		}
		SceneLooping sceneLooping = transform.GetComponent("SceneLooping") as SceneLooping;
		if (sceneLooping == null)
		{
			return null;
		}
		return sceneLooping;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput outError = AddFlowOutput("error");
		AddFlowInput("enable", delegate(Flow f)
		{
			SceneLooping sceneLooping = GetSceneLooping(pathInput.value);
			if (sceneLooping == null)
			{
				outError.Call(f);
			}
			else
			{
				sceneLooping.enabled = true;
				output.Call(f);
			}
		});
		AddFlowInput("disable", delegate(Flow f)
		{
			SceneLooping sceneLooping = GetSceneLooping(pathInput.value);
			if (sceneLooping == null)
			{
				outError.Call(f);
			}
			else
			{
				sceneLooping.enabled = false;
				output.Call(f);
			}
		});
		AddFlowInput("reset", delegate(Flow f)
		{
			SceneLooping sceneLooping = GetSceneLooping(pathInput.value);
			if (sceneLooping == null)
			{
				outError.Call(f);
			}
			else
			{
				if (sceneLooping.useWorldPos)
				{
					sceneLooping.transform.position = sceneLooping.intervalMin;
				}
				else
				{
					sceneLooping.transform.localPosition = sceneLooping.localPosMin;
				}
				output.Call(f);
			}
		});
	}
}
