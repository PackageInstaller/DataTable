using UnityEngine;

namespace ACT.DialogueSystem;

public abstract class DialogueFlowAsset : ScriptableObject
{
	public abstract DialogueFlow Data { get; }
}
public abstract class DialogueFlowAsset<T> : DialogueFlowAsset where T : DialogueFlow, new()
{
	public T data = new T();

	public override DialogueFlow Data => data;
}
