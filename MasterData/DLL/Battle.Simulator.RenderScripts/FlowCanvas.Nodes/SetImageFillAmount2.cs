using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置图片Fill Amount(百分比)", 0)]
[Category("Render/UI")]
[Description("设置图片Fill Amount")]
[ExposeAsDefinition]
public class SetImageFillAmount2 : CallableActionNode<Image, float>
{
	public override void Invoke(Image image, float rate)
	{
		if (null == image)
		{
			Debug.LogError("Image Is Null");
		}
		else
		{
			image.fillAmount = rate.clamp01();
		}
	}
}
