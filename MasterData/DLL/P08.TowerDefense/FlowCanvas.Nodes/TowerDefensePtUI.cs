using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[TD]PTUI", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("PTUI")]
public class TowerDefensePtUI : FlowNode
{
	public const string PTUI_PREFAB_PATH = "UI/MardukUI/snakeactive/Marduksnakeactive_choosebuff";

	public const string PTUI_PARENT_NAME = "ScreenAdjustContainer";

	public const string PTUI_INST_NAME = "PTUI";

	private TowerPTUI ui;

	private int _showed;

	private int _configID;

	public int GetTriggerID()
	{
		return _showed;
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ui = null;
		_showed = 0;
		_configID = 0;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ui = null;
		_showed = 0;
		_configID = 0;
	}

	public bool Init(string instPath, string instName, string prefabPath)
	{
		if (ui == null)
		{
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI != null)
			{
				Transform transform = battleUI.transform.Find(instPath);
				if (transform != null)
				{
					Transform transform2 = transform.Find(instName);
					if (transform2 != null)
					{
						ui = transform2.GetComponent<TowerPTUI>();
					}
					else
					{
						GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, transform);
						if (gameObject != null)
						{
							ui = gameObject.GetComponent<TowerPTUI>();
							gameObject.name = instName;
						}
					}
					if (ui != null)
					{
						ui.HideSelectPanel();
					}
				}
			}
		}
		return ui != null;
	}

	public static bool TryGetPTUI(out TowerPTUI ui)
	{
		ui = null;
		BattleUI battleUI = BattleUI.GetBattleUI();
		if (battleUI != null)
		{
			Transform transform = battleUI.transform.Find("ScreenAdjustContainer");
			if (transform != null)
			{
				Transform transform2 = transform.Find("PTUI");
				if (transform2 != null)
				{
					ui = transform2.GetComponent<TowerPTUI>();
				}
				if (ui != null)
				{
					ui.HideSelectPanel();
				}
			}
		}
		return ui != null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径").SetDefaultAndSerializedValue("UI/MardukUI/snakeactive/Marduksnakeactive_choosebuff");
		ValueInput<int> initPtInput = AddValueInput<int>("初始pt点数").SetDefaultAndSerializedValue(500);
		AddValueInput<int>("初始血量", "hp").SetDefaultAndSerializedValue(5);
		AddValueInput<int>("触发器ID").SetDefaultAndSerializedValue(0);
		AddValueOutput("触发器ID", () => _showed);
		AddValueOutput("配置ID", () => _configID);
		FlowOutput output = AddFlowOutput("初始化结束");
		AddFlowOutput("点击跳过");
		AddFlowOutput("隐藏跳过");
		AddFlowOutput("选择A");
		AddFlowOutput("选择B");
		AddFlowOutput("选项C");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("初始化", delegate(Flow f)
		{
			if (Init("ScreenAdjustContainer", "PTUI", prefabPathInput.value))
			{
				ui.SetPT(initPtInput.value);
				f.Call(output);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
