using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("双向ui进度条", 0)]
[Category("Render/UI")]
[Description("双向ui进度条, 在战斗界面上用的")]
public class SpUIProgress : FlowNode
{
	private HPSlowSliderEffect slider;

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
			slider = transform2.GetComponent<HPSlowSliderEffect>();
		}
		return slider != null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo/hp/Slider");
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径");
		ValueInput<string> instNameInput = AddValueInput<string>("实例名");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		ValueInput<float> maxInput = AddValueInput<float>("最大值");
		ValueInput<float> leftInput = AddValueInput<float>("左值");
		ValueInput<float> rightInput = AddValueInput<float>("右值");
		AddFlowInput("设置", delegate(Flow f)
		{
			if (!Init(parentPathInput.value, prefabPathInput.value, instNameInput.value))
			{
				errorOutput.Call(f);
			}
			else
			{
				float num = maxInput.value;
				if (num <= 0f)
				{
					num = 1f;
				}
				slider.SetDuration(leftInput.value / num, rightInput.value / num);
				f.Call(output);
			}
		});
	}
}
