using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置拼刀UI", 0)]
[Category("Render/UI")]
[Description("设置拼刀UI, 修改参数只能改 拼刀槽衰减时间间隔 拼刀槽衰减速度 每次按键增长速率 按键内置CD 这四个")]
public class SetQuickClickQTESliderUI : FlowNode
{
	private QuickClickQTESlider com;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径(预制体加载路径)").SetDefaultAndSerializedValue("UI/BattlePanelEffect/QuickClickQTESlider");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点相对路径(相对于战斗面板)").SetDefaultAndSerializedValue("BattlePop");
		ValueInput<string> nameInput = AddValueInput<string>("实例名字").SetDefaultAndSerializedValue("QuickClickQTESlider");
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> idInput = AddValueInput<int>("拼刀ID");
		ValueInput<float> initValueInput = AddValueInput<float>("拼刀槽初始值").SetDefaultAndSerializedValue(500f);
		ValueInput<float> maxValueInput = AddValueInput<float>("拼刀槽上限").SetDefaultAndSerializedValue(1000f);
		ValueInput<float> consumeCDInput = AddValueInput<float>("拼刀槽衰减时间间隔").SetDefaultAndSerializedValue(0.1f);
		ValueInput<float> consumeValueInput = AddValueInput<float>("拼刀槽衰减速度").SetDefaultAndSerializedValue(5f);
		ValueInput<float> resumeValueInput = AddValueInput<float>("每次按键增长速率").SetDefaultAndSerializedValue(30f);
		ValueInput<float> resumeCDInput = AddValueInput<float>("按键内置CD").SetDefaultAndSerializedValue(0.2f);
		ValueInput<string> buttonPosParent = AddValueInput<string>("按键参考目标路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BattleButtons/Melee");
		ValueInput<Vector2> buttonPosOffset = AddValueInput<Vector2>("按键位置Offset");
		ValueInput<string> sliderPosParent = AddValueInput<string>("进度条参考目标路径").SetDefaultAndSerializedValue("");
		ValueInput<Vector2> sliderPosOffset = AddValueInput<Vector2>("进度条位置Offset");
		AddFlowInput("初始化", delegate(Flow f)
		{
			Init();
			if (com != null)
			{
				com.Init(idInput.value, initValueInput.value, maxValueInput.value, consumeCDInput.value, consumeValueInput.value, resumeValueInput.value, resumeCDInput.value);
				GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
				com.SetPos(battlePanelGameObject.transform.Find(buttonPosParent.value), buttonPosOffset.value, battlePanelGameObject.transform.Find(sliderPosParent.value), sliderPosOffset.value);
			}
			output.Call(f);
		});
		AddFlowInput("停止", delegate(Flow f)
		{
			if (com != null)
			{
				com.Release();
			}
			output.Call(f);
		});
		AddFlowInput("修改拼刀参数", delegate(Flow f)
		{
			Init();
			if (com != null && com.id == idInput.value)
			{
				com.ModifyParam(consumeCDInput.value, consumeValueInput.value, resumeValueInput.value, resumeCDInput.value);
			}
			output.Call(f);
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
					com = transform2.GetComponent<QuickClickQTESlider>();
				}
				com = transform2.GetComponent<QuickClickQTESlider>();
			}
		}
	}
}
