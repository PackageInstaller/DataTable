using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复制战斗UI位置及大小", 0)]
[Category("Render/UI")]
[Description("将A元素的位置与大小数据应用于B元素，二者必须处于同一父级元素下\n路径均从BattlePanel开始")]
public class ApplySizeAndLocationToBattleUIElement : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> vInPathA = AddValueInput<string>("源目标路径");
		ValueInput<string> vInPathB = AddValueInput<string>("应用目标路径");
		ValueInput<bool> vInIsComWithPC = AddValueInput<bool>("Notice限制Scale").SetDefaultAndSerializedValue(v: true);
		ValueInput<string> vInScaleName = AddValueInput<string>("限制功能Go名称").SetDefaultAndSerializedValue("BindingNotice");
		FlowOutput fOut = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				RectTransform rectTransform = battleScene.battlePanelGameObject.transform.Find(vInPathA.value) as RectTransform;
				RectTransform rectTransform2 = battleScene.battlePanelGameObject.transform.Find(vInPathB.value) as RectTransform;
				if (rectTransform != null && rectTransform2 != null)
				{
					rectTransform2.anchoredPosition = rectTransform.anchoredPosition;
					rectTransform2.position = rectTransform.position;
					rectTransform2.sizeDelta = rectTransform.sizeDelta;
					rectTransform2.localScale = rectTransform.localScale;
					if (vInIsComWithPC.value)
					{
						Transform transform = rectTransform2.Find(vInScaleName.value);
						if (transform != null && rectTransform.localScale.x != 0f && rectTransform.localScale.y != 0f && rectTransform.localScale.z != 0f)
						{
							transform.localScale = new Vector3(1f / rectTransform.localScale.x, 1f / rectTransform.localScale.y, 1f / rectTransform.localScale.z);
						}
					}
				}
			}
			fOut.Call(f);
		});
	}
}
