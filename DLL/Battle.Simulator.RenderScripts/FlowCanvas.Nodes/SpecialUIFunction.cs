using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置特殊UI标记", 0)]
[Category("Render/UI")]
[Description("设置特殊UI标记,\n初始化：路径 和 父节点相对路径 和 实例名字 这三个参数\n设置指定icon：下标 和 是否激活 \n指定范围：下标 和 总数 和 激活数 \n指定范围唯一：下标 和 总数 和 激活数/唯一激活(看备注)，用于在一定范围内，指定第几个激活其他都关闭")]
public class SpecialUIFunction : FlowNode
{
	private SpecialUIIcon com;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径(预制体加载路径)");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点相对路径(相对于战斗面板)").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<string> nameInput = AddValueInput<string>("实例名字");
		ValueInput<int> indexInput = AddValueInput<int>("下标");
		ValueInput<bool> enableInput = AddValueInput<bool>("是否激活");
		ValueInput<int> rangeInput = AddValueInput<int>("总数", "range");
		ValueInput<int> enableCountInput = AddValueInput<int>("激活数/唯一激活(看备注)", "enableCount");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("初始化", delegate(Flow f)
		{
			Init();
			output.Call(f);
		});
		AddFlowInput("设置指定icon", delegate(Flow f)
		{
			Init();
			if (com == null)
			{
				Debug.LogError("设置特殊UI标记 没有初始化");
			}
			else
			{
				com.SetTargetIcon(indexInput.value, enableInput.value);
				output.Call(f);
			}
		});
		AddFlowInput("显示一个", delegate(Flow f)
		{
			Init();
			if (com == null)
			{
				Debug.LogError("设置特殊UI标记 没有初始化");
			}
			else
			{
				com.ChangeAIcon(isEnable: true);
				f.Call(output);
			}
		});
		AddFlowInput("隐藏一个", delegate(Flow f)
		{
			Init();
			if (com == null)
			{
				Debug.LogError("设置特殊UI标记 没有初始化");
			}
			else
			{
				com.ChangeAIcon(isEnable: false);
				f.Call(output);
			}
		});
		AddFlowInput("指定范围", delegate(Flow f)
		{
			Init();
			if (com == null)
			{
				Debug.LogError("设置特殊UI标记 没有初始化");
			}
			else
			{
				com.SetIconEnableOfRange(indexInput.value, rangeInput.value, enableCountInput.value);
				f.Call(output);
			}
		});
		AddFlowInput("指定范围唯一", "SetTargetIconInRange", delegate(Flow f)
		{
			Init();
			if (com == null)
			{
				Debug.LogError("设置特殊UI标记 没有初始化");
			}
			else
			{
				com.SetTargetIconInRange(indexInput.value, rangeInput.value, enableCountInput.value);
				f.Call(output);
			}
		});
		void Init()
		{
			if (com == null)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(parentPathInput.value);
				Transform transform2 = transform.Find(nameInput.value);
				if (transform2 == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(pathInput.value, transform);
					gameObject.name = nameInput.value;
					transform2 = gameObject.transform;
					com = transform2.GetComponent<SpecialUIIcon>();
					com.Clear(isEnable: false);
				}
				com = transform2.GetComponent<SpecialUIIcon>();
			}
		}
	}
}
