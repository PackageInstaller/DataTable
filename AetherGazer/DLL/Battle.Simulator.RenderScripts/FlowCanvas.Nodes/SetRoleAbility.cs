using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("更新角色技能UI按钮(过时)", 0)]
[Category("Render/UI")]
[Description("更新角色技能UI按钮")]
public class SetRoleAbility : CallableActionNode<int, List<GameObject>, List<Image>, List<Text>, GameObject>
{
	public override void Invoke(int index, List<GameObject> cds, List<Image> cdImages, List<Text> cdText, GameObject abilityButton)
	{
		cds[index] = abilityButton;
		cdImages[index] = abilityButton.transform.Find("CDMask").GetComponent<Image>();
		cdText[index] = abilityButton.transform.Find("CDTime").GetComponent<Text>();
	}
}
