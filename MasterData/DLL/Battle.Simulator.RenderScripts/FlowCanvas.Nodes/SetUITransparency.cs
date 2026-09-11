using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置UI透明度(渲染)", 0)]
[Category("Render/UI")]
[Description("预制体路径从 battlePanel 下开始,例如要控制已经在默认战斗子路径生成了的 1133_2/icon01 ,则填写 ScreenAdjustContainer/PlayerInfo/1133_2/icon01")]
public class SetUITransparency : FlowNode
{
	private GameObject _effectInstance;

	protected override void RegisterPorts()
	{
		FlowOutput _TrueOut = AddFlowOutput("True", "true");
		FlowOutput _Error = AddFlowOutput("Error", "error");
		ValueInput<string> _effectPathInput = AddValueInput<string>("预制体路径", "effectPath");
		ValueInput<Color> colorInput = AddValueInput<Color>("指定颜色", "color");
		ValueInput<float> timeInput = AddValueInput<float>("变化所需时间(毫秒)", "time").SetDefaultAndSerializedValue(1000f);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(_effectPathInput.GetValue()))
			{
				Debug.LogError("图" + base.graph.name + "下的设置UI透明度(渲染)节点的预制体路径为空！！");
				_Error.Call(f);
			}
			else
			{
				if (_effectInstance == null)
				{
					Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(_effectPathInput.value);
					if (transform == null)
					{
						Debug.LogError("图" + base.graph.name + "下的设置UI透明度(渲染)节点的预制体路径找不到对应预制体！！");
						_Error.Call(f);
						return;
					}
					_effectInstance = transform.gameObject;
				}
				if (_effectInstance == null)
				{
					_Error.Call(f);
				}
				else if (_effectInstance != null)
				{
					LeanTween.color(_effectInstance.transform as RectTransform, colorInput.value, timeInput.value / 1000f);
					_TrueOut.Call(f);
				}
			}
		});
	}
}
