using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[庚辰]战斗机制UI", 0)]
[Category("Render/UI")]
[Description("")]
public class CustomUI1076 : FlowControlNodeOfRender
{
	[MinValue(1)]
	[GatherPortsCallback]
	[DelayedField]
	public int Count = 1;

	private ValueInput<int>[] vIn;

	private SpecialUIIcon com;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		Count = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(Count);
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径(预制体加载路径)", "path");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点相对路径(相对于战斗面板)", "parentPath").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<string> nameInput = AddValueInput<string>("实例名字", "name");
		ValueInput<List<int>> yuIcon1ListInput = AddValueInput<List<int>>("状态1下标数组", "yuIcon1List");
		ValueInput<List<int>> yuIcon2ListInput = AddValueInput<List<int>>("状态2下标数组", "yuIcon2List");
		vIn = new ValueInput<int>[Count];
		for (int i = 0; i < Count; i++)
		{
			vIn[i] = AddValueInput<int>("状态值" + i);
		}
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("初始化", delegate(Flow f)
		{
			Init();
			output.Call(f);
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			Init();
			if (com == null)
			{
				Debug.LogError("设置特殊UI标记 没有初始化");
			}
			else
			{
				for (int j = 0; j < vIn.Length; j++)
				{
					if (vIn[j].value == 1)
					{
						com.SetTargetIcon(yuIcon1ListInput.value[j], isEnable: true);
						com.SetTargetIcon(yuIcon2ListInput.value[j], isEnable: false);
					}
					else if (vIn[j].value == -1)
					{
						com.SetTargetIcon(yuIcon1ListInput.value[j], isEnable: false);
						com.SetTargetIcon(yuIcon2ListInput.value[j], isEnable: true);
					}
					else
					{
						com.SetTargetIcon(yuIcon1ListInput.value[j], isEnable: false);
						com.SetTargetIcon(yuIcon2ListInput.value[j], isEnable: false);
					}
				}
				output.Call(f);
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
