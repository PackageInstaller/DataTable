using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏战斗UI(有返回)", 0)]
[Category("Render/UI")]
[Description("隐藏战斗UI,返回battlepanel的transform")]
public class DisableBattleUIWithReturnTF : CallableFunctionNode<Transform, List<string>>
{
	public override Transform Invoke(List<string> exceptions)
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain");
		if (gameObject == null)
		{
			return null;
		}
		Transform transform = gameObject.transform.Find("BattlePanel");
		if (transform == null)
		{
			return null;
		}
		int childCount = transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (exceptions == null || !exceptions.Contains(child.name))
			{
				IBattleUIElement component = child.gameObject.GetComponent<IBattleUIElement>();
				if (component != null)
				{
					component.SetActive(isActive: false, BattleUIElementActiveChangeReason.FlowNode);
				}
				else
				{
					child.gameObject.SetActive(value: false);
				}
			}
		}
		return transform;
	}
}
