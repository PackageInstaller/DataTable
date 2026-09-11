using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Unity")]
[Description("Creates a new ScriptableObject instance")]
public class NewScriptableObject<T> : CallableFunctionNode<T> where T : ScriptableObject
{
	public override T Invoke()
	{
		return ScriptableObject.CreateInstance<T>();
	}
}
