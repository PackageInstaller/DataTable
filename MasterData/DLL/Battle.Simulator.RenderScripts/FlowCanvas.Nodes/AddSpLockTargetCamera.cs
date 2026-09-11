using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特殊的锁定相机", 0)]
[Category("Render/Camera")]
[Description("创建特殊的锁定相机, 不会在里面判断是不是主控角色")]
public class AddSpLockTargetCamera : FlowNode, IPreloadAsset
{
	private ValueInput<string> pathInput;

	private SpLockTargetCamera camera;

	public string GetAssetPath()
	{
		return pathInput.value;
	}

	public int GetCacheCount()
	{
		return 1;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		camera = null;
	}

	protected override void RegisterPorts()
	{
		pathInput = AddValueInput<string>("路径").SetDefaultAndSerializedValue("Camera/SpLockTargetCamera");
		ValueInput<int> entityIDInput = AddValueInput<int>("跟随实体ID");
		AddValueOutput("跟随实体ID", () => entityIDInput.value);
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		AddValueOutput("目标实体ID", () => targetIDInput.value);
		GameObject res = null;
		AddValueOutput("对象", () => res);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("失败");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(entityIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					NAgent agent2 = agentManager.GetAgent(targetIDInput.value);
					if (agent2 == null)
					{
						errorOut.Call(f);
					}
					else
					{
						if (camera == null)
						{
							res = Asset.Instantiate(pathInput.value);
							if (res == null)
							{
								errorOut.Call(f);
								return;
							}
							camera = res.GetComponent<SpLockTargetCamera>();
						}
						if (camera == null)
						{
							errorOut.Call(f);
						}
						else
						{
							camera.SetPlayer(agent.gameObject);
							camera.SetTarget(agent2.gameObject);
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
