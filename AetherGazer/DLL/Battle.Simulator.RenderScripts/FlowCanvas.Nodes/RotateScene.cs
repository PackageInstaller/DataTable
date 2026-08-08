using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("旋转场景", 0)]
[Category("Render/Agent")]
[Description("旋转场景, 不能出现在快速重新挑战的关卡里")]
public class RotateScene : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput outError = AddFlowOutput("error");
		ValueInput<float> angleInput = AddValueInput<float>("角度");
		ValueInput<float> timeInput = AddValueInput<float>("时长");
		ValueInput<AnimationCurve> curveInput = AddValueInput<AnimationCurve>("曲线");
		ValueInput<Vector3> axisInput = AddValueInput<Vector3>("旋转轴方向");
		ValueInput<Vector3> pointInput = AddValueInput<Vector3>("旋转点");
		ValueInput<string> pathInput = AddValueInput<string>("路径");
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
					RotateComponent rotateComponent = U3DUtil.Get<RotateComponent>(transform.gameObject);
					if (rotateComponent == null)
					{
						outError.Call(f);
					}
					else
					{
						rotateComponent.Init();
						rotateComponent.simpleSelfRotate = false;
						rotateComponent.loop = false;
						rotateComponent.angle = angleInput.value;
						rotateComponent.speed = curveInput.value;
						rotateComponent.totalTime = timeInput.value;
						rotateComponent.point = pointInput.value;
						rotateComponent.axis = axisInput.value;
						output.Call(f);
					}
				}
			}
		});
		AddFlowInput("重置所有场景旋转", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				outError.Call(f);
			}
			else
			{
				RotateComponent[] componentsInChildren = battleScene.sceneSetting.GetComponentsInChildren<RotateComponent>();
				if (componentsInChildren != null)
				{
					RotateComponent[] array = componentsInChildren;
					foreach (RotateComponent rotateComponent in array)
					{
						if (rotateComponent != null)
						{
							rotateComponent.Reset();
						}
					}
				}
				output.Call(f);
			}
		});
	}
}
