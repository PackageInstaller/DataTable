using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置图片Fill Amount", 0)]
[Category("Render/UI")]
[Description("设置图片Fill Amount")]
[ExposeAsDefinition]
public class SetImageFillAmount : CallableActionNode<Image, int, int>
{
	public override void Invoke(Image image, int max, int current)
	{
		if (null == image)
		{
			Debug.LogError("Image Is Null");
		}
		else
		{
			image.fillAmount = (float)current / (float)max;
		}
	}
}
