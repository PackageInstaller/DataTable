using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新按键教学UI", 0)]
[Category("Render/UI")]
[Description("更新按键教学UI, 要传一个当前状态列表(0未完成; 1已完成; 2失败; 3Miss), 只能用int数组, 不能新增枚举类型, 否则会导致无法强更")]
public class UpdateTeachSkillUI : FlowNode
{
	public string targetPath = "ScreenAdjustContainer/TeachSkills";

	public string instName = "TeachSkills";

	public string prefabPath = "UI/TeachSkills";

	public string parentPath = "ScreenAdjustContainer";

	private TeachSkills com;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(targetPath);
		writer.Write(instName);
		writer.Write(prefabPath);
		writer.Write(parentPath);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		targetPath = reader.ReadString();
		instName = reader.ReadString();
		prefabPath = reader.ReadString();
		parentPath = reader.ReadString();
	}

	private void SetActive(GameObject go, bool flag)
	{
		if (go.activeSelf != flag)
		{
			go.SetActive(flag);
		}
	}

	private void GetTeachSkillsCom()
	{
		Transform transform = ((com != null) ? com.transform : null);
		if (transform == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform2 = battleScene.battlePanelGameObject.transform;
				transform = transform2.Find(targetPath);
				if (transform == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, transform2.Find(parentPath));
					gameObject.name = instName;
					transform = gameObject.transform;
				}
			}
		}
		if (transform == null)
		{
			Debug.LogError("显示按键教学UI 节点, 找不到对应预制体");
			return;
		}
		SetActive(transform.gameObject, flag: true);
		if (com == null)
		{
			com = transform.GetComponent<TeachSkills>();
		}
		if (com == null)
		{
			Debug.LogError(prefabPath + ", 找不到对应TeachSkills组件");
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<List<int>> bufflogicIDInput = AddValueInput<List<int>>("长按的buff处理逻辑ID");
		ValueInput<List<bool>> clickTypeInput = AddValueInput<List<bool>>("是否长按");
		ValueInput<string> atlsNameInput = AddValueInput<string>("图集名");
		ValueInput<List<string>> atlsNamesInput = AddValueInput<List<string>>("图集名列表(要用多个图集的时候用)");
		ValueInput<List<string>> spritesNameInput = AddValueInput<List<string>>("图片名");
		ValueInput<List<int>> skillsNameInput = AddValueInput<List<int>>("技能名");
		ValueInput<bool> useLoopInput = AddValueInput<bool>("图片是否闪烁").SetDefaultAndSerializedValue(v: true);
		ValueInput<List<int>> stateInput = AddValueInput<List<int>>("当前状态");
		FlowOutput output = AddFlowOutput("初始化完成");
		FlowOutput updateOutput = AddFlowOutput("更新完成");
		int countS = 0;
		AddValueOutput("本次处理成功数量", () => countS);
		int countF = 0;
		AddValueOutput("本次处理失败数量", () => countF);
		int countM = 0;
		AddValueOutput("本次处理MISS数量", () => countM);
		AddFlowInput("初始化", delegate(Flow f)
		{
			GetTeachSkillsCom();
			if (com == null)
			{
				Debug.LogError(prefabPath + ", 找不到对应TeachSkills组件");
			}
			else
			{
				List<int> value = bufflogicIDInput.value;
				List<bool> value2 = clickTypeInput.value;
				List<string> value3 = spritesNameInput.value;
				string atlasName = atlsNameInput.value;
				List<int> value4 = skillsNameInput.value;
				List<string> value5 = atlsNamesInput.value;
				if (value == null || value2 == null || value.Count != value2.Count)
				{
					Debug.LogError("显示按键教学UI 节点, 列表为空");
				}
				else if (value3 == null || value.Count != value3.Count)
				{
					Debug.LogError("显示按键教学UI 节点, 图片名列表有问题");
				}
				else
				{
					com.Init();
					com.useLoop = useLoopInput.value;
					for (int i = 0; i < value.Count; i++)
					{
						TeachSkillItem teachSkillItem = com.AddSkillItem();
						if (value5 != null && value5.Count > i)
						{
							atlasName = value5[i];
						}
						Sprite sprite = AtlasManager.GetSprite(atlasName, value3[i]);
						string text = "";
						if (value4 != null && i < value4.Count)
						{
							text = WorldStateManager.GetTipsContent(value4[i]);
						}
						teachSkillItem.Init(sprite, value2[i], value[i], text);
					}
					output.Call(f);
				}
			}
		});
		AddFlowInput("更新进度", delegate(Flow f)
		{
			GetTeachSkillsCom();
			if (com == null)
			{
				Debug.LogError("显示按键教学UI 没有初始化");
			}
			else
			{
				int currentIndex = com.GetCurrentIndex();
				List<int> value = stateInput.value;
				if (value == null)
				{
					Debug.LogError("更新按键教学UI 状态为空");
				}
				else
				{
					countS = 0;
					countF = 0;
					countM = 0;
					for (int i = currentIndex; i < value.Count; i++)
					{
						int num = value[i];
						switch (num)
						{
						case 1:
							com.FinishCurrent(success: true);
							countS++;
							break;
						case 2:
							com.FinishCurrent(success: false);
							countF++;
							break;
						case 3:
							com.FinishCurrent(success: false, miss: true);
							countM++;
							break;
						}
						if (num == 0)
						{
							break;
						}
					}
					updateOutput.Call(f);
				}
			}
		});
	}
}
