using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class DialogueFlowProcessor
{
	private DialogueFlow m_Data;

	private DialogueNodeProcessor m_Root;

	private Dictionary<long, DialogueNodeProcessor> m_NodeProcessors;

	public DialogueFlow Data => m_Data;

	public DialogueNodeProcessor Root => m_Root;

	public DialogueFlowProcessor(DialogueFlow data)
	{
		m_Data = data;
		m_NodeProcessors = new Dictionary<long, DialogueNodeProcessor>();
		m_Root = InitNodeProcessorsRecursive(data.root, 0);
		InitNodeContextsRecursive(data.root, 0);
		InitNodesRecursive(data.root);
	}

	private DialogueNodeProcessor InitNodeProcessorsRecursive(DialogueNode data, int depth)
	{
		DialogueNodeProcessor dialogueNodeProcessor = DialogueRegistry.GetNodeFactory(data.GetType()).Produce();
		dialogueNodeProcessor.InitData(data, depth);
		m_NodeProcessors.Add(dialogueNodeProcessor.Id, dialogueNodeProcessor);
		for (int num = data.children.Count - 1; num >= 0; num--)
		{
			InitNodeProcessorsRecursive(data.children[num], depth + 1);
		}
		return dialogueNodeProcessor;
	}

	private void InitNodeContextsRecursive(DialogueNode data, int index, DialogueNode parentData = null)
	{
		DialogueNodeProcessor node = GetNode(data.id);
		DialogueNodeProcessor dialogueNodeProcessor = ((parentData == null) ? null : GetNode(parentData.id));
		DialogueNodeContext context = new DialogueNodeContext
		{
			Flow = this,
			Parent = dialogueNodeProcessor,
			Index = index,
			Previous = ((dialogueNodeProcessor == null || index == 0) ? null : GetNode(parentData.children[index - 1].id)),
			Next = ((dialogueNodeProcessor == null || index == parentData.children.Count - 1) ? null : GetNode(parentData.children[index + 1].id))
		};
		node.InitContext(context);
		for (int num = data.children.Count - 1; num >= 0; num--)
		{
			InitNodeContextsRecursive(data.children[num], num, data);
		}
	}

	private void InitNodesRecursive(DialogueNode data)
	{
		GetNode(data.id).Init();
		for (int i = 0; i < data.children.Count; i++)
		{
			DialogueNode data2 = data.children[i];
			InitNodesRecursive(data2);
		}
	}

	public async UniTask Play(DialogueContext context, CancellationToken token)
	{
		await new DialogueFlowExecution(this, context, token).ExecuteRoot();
	}

	public DialogueNodeProcessor GetNode(long id)
	{
		m_NodeProcessors.TryGetValue(id, out var value);
		return value;
	}
}
