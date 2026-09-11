using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置场景物件坐标(移动场景)", 0)]
[Category("Render/Agent")]
[Description("移动场景, 不能出现在快速重新挑战的关卡里")]
public class MoveScene : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput outError = AddFlowOutput("error");
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		ValueInput<float> timeInput = AddValueInput<float>("时长", "time");
		ValueInput<AnimationCurve> curveInput = AddValueInput<AnimationCurve>("速度比例曲线", "curve");
		ValueInput<Vector3> startPosInput = AddValueInput<Vector3>("起点坐标", "startPos");
		ValueInput<Vector3> endPosInput = AddValueInput<Vector3>("终点坐标", "endPos");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				outError.Call(f);
			}
			else
			{
				string value = pathInput.value;
				Transform transform = battleScene.sceneSetting.transform;
				if (!string.IsNullOrEmpty(value))
				{
					transform = battleScene.sceneSetting.transform.Find(value);
				}
				if (transform == null)
				{
					outError.Call(f);
				}
				else
				{
					MoveSceneComponent moveSceneComponent = U3DUtil.Get<MoveSceneComponent>(transform.gameObject);
					if (moveSceneComponent == null)
					{
						outError.Call(f);
					}
					else
					{
						if (timeInput.value != 0f)
						{
							moveSceneComponent.speed = Vector3.Distance(endPosInput.value, startPosInput.value) / timeInput.value;
						}
						else
						{
							moveSceneComponent.speed = Vector3.Distance(endPosInput.value, startPosInput.value);
						}
						moveSceneComponent.Init(startPosInput.value);
						moveSceneComponent.totalTime = timeInput.value;
						moveSceneComponent.curve = curveInput.value;
						moveSceneComponent.end = endPosInput.value;
						output.Call(f);
					}
				}
			}
		});
		AddFlowInput("重置所有场景移动", "ResetMove", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				outError.Call(f);
			}
			else
			{
				MoveSceneComponent[] componentsInChildren = battleScene.sceneSetting.GetComponentsInChildren<MoveSceneComponent>();
				if (componentsInChildren != null)
				{
					MoveSceneComponent[] array = componentsInChildren;
					foreach (MoveSceneComponent moveSceneComponent in array)
					{
						if (moveSceneComponent != null)
						{
							moveSceneComponent.ResetMove();
						}
					}
				}
				output.Call(f);
			}
		});
		AddFlowInput("重置所有场景坐标", "ResetPos", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				outError.Call(f);
			}
			else
			{
				MoveSceneComponent[] componentsInChildren = battleScene.sceneSetting.GetComponentsInChildren<MoveSceneComponent>();
				if (componentsInChildren != null)
				{
					MoveSceneComponent[] array = componentsInChildren;
					foreach (MoveSceneComponent moveSceneComponent in array)
					{
						if (moveSceneComponent != null)
						{
							moveSceneComponent.ResetPos();
						}
					}
				}
				output.Call(f);
			}
		});
	}
}
