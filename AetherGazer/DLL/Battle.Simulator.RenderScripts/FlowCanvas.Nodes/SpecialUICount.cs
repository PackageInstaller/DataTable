using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置特殊UI计数", 0)]
[Category("Render/UI")]
[Description("设置特殊UI计数,\n路径 和 父节点相对路径 和 实例名字 这三个参数只有在 初始化 的时候有用\n攒满的时候会自动切换状态, 也可以手动调用切换状态\n计数状态只有切换状态时有效")]
public class SpecialUICount : FlowNode
{
	private SpecialUICountDown com;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径(预制体加载路径)");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点相对路径(相对于战斗面板)").SetDefaultAndSerializedValue("BattlePop");
		ValueInput<string> nameInput = AddValueInput<string>("实例名字");
		FlowOutput output = AddFlowOutput("");
		ValueInput<float> timeInput = AddValueInput<float>("持续时长");
		ValueInput<bool> stateInput = AddValueInput<bool>("计数状态");
		ValueInput<float> deltatimeInput = AddValueInput<float>("deltaTime");
		AddFlowInput("初始化", delegate(Flow f)
		{
			Init();
			if (com != null)
			{
				com.timeMax = timeInput.value;
				if (com.imageCount != null)
				{
					com.imageCount.fillAmount = 0f;
				}
			}
			output.Call(f);
		});
		AddFlowInput("加一个", delegate(Flow f)
		{
			Init();
			if (com != null)
			{
				com.Add();
			}
			output.Call(f);
		});
		AddFlowInput("切换状态", delegate(Flow f)
		{
			Init();
			if (com != null)
			{
				com.UpdateState(com.timeMax, 0, stateInput.value);
			}
			output.Call(f);
		});
		AddFlowInput("更新时间", delegate(Flow f)
		{
			Init();
			if (com != null)
			{
				com.UpdateTime(deltatimeInput.value);
			}
			output.Call(f);
		});
		void Init()
		{
			if (com == null)
			{
				GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
				if (!(battlePanelGameObject == null))
				{
					Transform transform = battlePanelGameObject.transform.Find(parentPathInput.value);
					if (!(transform == null))
					{
						Transform transform2 = transform.Find(nameInput.value);
						if (transform2 == null)
						{
							GameObject gameObject = Asset.InstantiateWithoutCache(pathInput.value, transform);
							if (gameObject == null)
							{
								return;
							}
							gameObject.name = nameInput.value;
							transform2 = gameObject.transform;
							com = transform2.GetComponent<SpecialUICountDown>();
						}
						com = transform2.GetComponent<SpecialUICountDown>();
					}
				}
			}
		}
	}
}
