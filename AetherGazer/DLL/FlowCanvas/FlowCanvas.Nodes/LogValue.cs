using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utility")]
[Description("Log input value on the console")]
public class LogValue : CallableActionNode<object>
{
	public override void Invoke(object obj)
	{
		Debug.Log(obj);
	}
}
