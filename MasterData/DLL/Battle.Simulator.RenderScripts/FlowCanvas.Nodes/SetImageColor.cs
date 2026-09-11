using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置图片颜色", 0)]
[Category("Render/UI")]
[Description("设置图片颜色, 如果要用同一个节点设置不同的图片, 需要先调用Reset")]
public class SetImageColor : FlowNode
{
	private Image image;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		image = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject");
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		ValueInput<Color> colorInput = AddValueInput<Color>("颜色");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			if (image == null)
			{
				GameObject value = goInput.value;
				if (value == null)
				{
					errorOut.Call(f);
					return;
				}
				Transform transform = value.transform.Find(pathInput.value);
				if (transform == null)
				{
					errorOut.Call(f);
					return;
				}
				Image component = transform.GetComponent<Image>();
				if (component == null)
				{
					errorOut.Call(f);
					return;
				}
				image = component;
			}
			Color value2 = colorInput.value;
			if (image.color != value2)
			{
				image.color = value2;
			}
			output.Call(f);
		});
		AddFlowInput("Reset", delegate(Flow f)
		{
			image = null;
			output.Call(f);
		});
	}
}
