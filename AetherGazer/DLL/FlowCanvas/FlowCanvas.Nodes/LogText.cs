using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utility")]
[Description("Log text in the console")]
public class LogText : CallableActionNode<string>
{
	public override void Invoke(string text)
	{
		Debug.Log(text);
	}
}
