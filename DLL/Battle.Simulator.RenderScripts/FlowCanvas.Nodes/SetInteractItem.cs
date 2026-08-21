using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置交互物品", 0)]
[Category("Render/Camera")]
[Description("设置交互物品, 被交互后的行为, 相机的话, 默认有一个切换, 不能在这里设置, 其他的可以有一个默认播放动画, 再其他就自己拉图实现")]
public class SetInteractItem : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		ValueInput<GameObject> gameObjectInput = AddValueInput<GameObject>("物品GameObject");
		ValueInput<string> iconPathInput = AddValueInput<string>("图标路径");
		ValueInput<int> nameInput = AddValueInput<int>("名字");
		ValueInput<int> descInput = AddValueInput<int>("描述");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		FlowOutput foundOut = AddFlowOutput("被发现行为");
		FlowOutput closeOut = AddFlowOutput("交互行为");
		int res = 0;
		AddValueOutput("触发器ID", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			GameObject value = gameObjectInput.value;
			if (value == null)
			{
				errorOut.Call(f);
			}
			else
			{
				CameraInteractItem cameraInteractItem = value.GetComponent(typeof(CameraInteractItem)) as CameraInteractItem;
				if (cameraInteractItem == null)
				{
					errorOut.Call(f);
				}
				else
				{
					res = triggerIDInput.value;
					cameraInteractItem.Init(triggerIDInput.value, delegate(int triggerID)
					{
						res = triggerID;
						closeOut.Call(f);
					}, delegate(int triggerID)
					{
						res = triggerID;
						foundOut.Call(f);
					});
					cameraInteractItem.iconPath = iconPathInput.value;
					cameraInteractItem.nameBattleTips = nameInput.value;
					cameraInteractItem.desBattleTips = descInput.value;
					output.Call(f);
				}
			}
		});
	}
}
