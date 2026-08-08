using ControllerExSpace;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置UI的Controller组件", 0)]
[Category("Render/UI")]
[Description("设置UI的Controller组件\n必须要先创建出来已经有了才能控制, 找不到的话, 走error\n一个节点只能控制一个路径下的组件, 中途不能换")]
public class ControllerExFlowNode : FlowNode
{
	private ControllerExCollection _com;

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

	protected override void RegisterPorts()
	{
		ValueInput<string> parentPathInput = AddValueInput<string>("相对路径(相对于战斗面板)").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<string> nameInput = AddValueInput<string>("控制器名字");
		ValueInput<int> indexInput = AddValueInput<int>("要切换到的状态下标");
		ValueInput<bool> immediatelyInput = AddValueInput<bool>("immediately");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			Init();
			if (_com == null)
			{
				Debug.LogError("设置UI的Controller组件 没有控制器");
				errorOut.Call(f);
			}
			else
			{
				ControllerEx controller = _com.GetController(nameInput.value);
				if (controller == null)
				{
					Debug.LogError("设置UI的Controller组件 没有控制器");
					errorOut.Call(f);
				}
				else
				{
					controller.SetSelectedIndex(indexInput.value, immediatelyInput.value);
					output.Call(f);
				}
			}
		});
		void Init()
		{
			if (_com == null)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(parentPathInput.value);
				if (!(transform == null))
				{
					_com = transform.GetComponent<ControllerExCollection>();
				}
			}
		}
	}
}
