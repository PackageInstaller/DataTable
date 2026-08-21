using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("4039机制UI", 0)]
[Category("Render/UI")]
[Description("4039机制UI, 5个血条的话要用5个节点单独控制")]
public class Sp4039HpNode : FlowNode
{
	private Controller controller;

	private HPSlowSliderEffect slider;

	private HPSlowSliderEffect slider2;

	public override void OnGraphStarted()
	{
		controller = null;
		slider = null;
		slider2 = null;
	}

	public override void OnGraphStoped()
	{
		controller = null;
		slider = null;
		slider2 = null;
	}

	private bool init(string controllerPath, string sliderPath, string sliderPath2)
	{
		bool flag = !string.IsNullOrEmpty(sliderPath2);
		if (controller == null || slider == null || (flag && slider2 == null))
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
			Transform transform = battlePanelGameObject.transform.Find(controllerPath);
			if (transform == null)
			{
				return false;
			}
			controller = transform.GetComponent<Controller>();
			transform = battlePanelGameObject.transform.Find(sliderPath);
			if (transform == null)
			{
				return false;
			}
			slider = transform.GetComponent<HPSlowSliderEffect>();
			slider.SetDuration(0f, 1f);
			if (flag)
			{
				transform = battlePanelGameObject.transform.Find(sliderPath2);
				if (transform == null)
				{
					return false;
				}
				slider2 = transform.GetComponent<HPSlowSliderEffect>();
				slider2.SetDuration(0f, 1f);
			}
		}
		if (controller != null && slider != null)
		{
			if (!flag)
			{
				return true;
			}
			return slider2 != null;
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> controllerPathInput = AddValueInput<string>("controller路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BossInfo/crow_hp/blood4");
		ValueInput<string> sliderPathInput = AddValueInput<string>("slider路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BossInfo/crow_hp/blood4/blood");
		ValueInput<string> slider2PathInput = AddValueInput<string>("slider路径2");
		ValueInput<string> stateValueInput = AddValueInput<string>("状态值");
		ValueInput<float> progressValInput = AddValueInput<float>("进度值");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("切换状态", delegate(Flow f)
		{
			if (!init(controllerPathInput.value, sliderPathInput.value, slider2PathInput.value))
			{
				errorOutput.Call(f);
			}
			else
			{
				controller.SetSelectedState(stateValueInput.value);
				f.Call(output);
			}
		});
		AddFlowInput("修改进度", delegate(Flow f)
		{
			if (!init(controllerPathInput.value, sliderPathInput.value, slider2PathInput.value))
			{
				errorOutput.Call(f);
			}
			else
			{
				slider.SetDuration(0f, progressValInput.value);
				if (slider2 != null)
				{
					slider2.SetDuration(0f, progressValInput.value);
				}
				f.Call(output);
			}
		});
	}
}
