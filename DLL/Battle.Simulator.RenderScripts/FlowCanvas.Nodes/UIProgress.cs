using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("ui进度条", 0)]
[Category("Render/UI")]
[Description("一个比较单纯的, 通用的控制ui上进度条的节点\n只有第一次设置的时候会去查找或者创建预制体")]
public class UIProgress : FlowNode
{
	private Slider slider;

	public override void OnGraphStarted()
	{
		slider = null;
	}

	public override void OnGraphStoped()
	{
		slider = null;
	}

	private bool Init(string parentPath, string prefabPath, string instName)
	{
		if (slider == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				return false;
			}
			GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
			if (battlePanelGameObject == null)
			{
				return false;
			}
			Transform transform = battlePanelGameObject.transform.Find(parentPath);
			if (transform == null)
			{
				return false;
			}
			Transform transform2 = transform.Find(instName);
			if (transform2 == null)
			{
				GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, transform);
				if (gameObject != null)
				{
					gameObject.name = instName;
					transform2 = gameObject.transform;
				}
			}
			if (transform2 == null)
			{
				return false;
			}
			slider = transform2.GetComponent<Slider>();
		}
		return slider != null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点路径").SetDefaultAndSerializedValue("ScreenAdjustContainer");
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径");
		ValueInput<string> instNameInput = AddValueInput<string>("实例名");
		ValueInput<float> rightInput = AddValueInput<float>("当前值");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("设置进度", delegate(Flow f)
		{
			if (!Init(parentPathInput.value, prefabPathInput.value, instNameInput.value))
			{
				errorOutput.Call(f);
			}
			else
			{
				slider.value = rightInput.value;
				f.Call(output);
			}
		});
	}
}
