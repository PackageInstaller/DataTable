using System;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public abstract class DialogueNodeProcessor
{
	private DialogueNode m_Data;

	private int m_Depth;

	private DialogueNodeContext m_NodeContext;

	public DialogueNode Data => m_Data;

	public long Id => m_Data.id;

	public int ChildrenCount => m_Data.children.Count;

	public int Index => m_NodeContext.Index;

	public DialogueFlowProcessor Flow => m_NodeContext.Flow;

	public DialogueNodeProcessor Parent => m_NodeContext.Parent;

	public DialogueNodeProcessor Previous => m_NodeContext.Previous;

	public DialogueNodeProcessor Next => m_NodeContext.Next;

	public void InitData(DialogueNode data, int depth)
	{
		m_Data = data;
		m_Depth = depth;
	}

	public void InitContext(DialogueNodeContext context)
	{
		m_NodeContext = context;
	}

	public void Init()
	{
		OnInit();
	}

	public UniTask<DialogueNodeResult> Execute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		return OnExecute(execution, context, token);
	}

	public UniTask<DialogueNodeResult> Jump(DialogueStartRoute startRoute, DialogueContext context, CancellationToken token)
	{
		startRoute = startRoute.MoveNext();
		if (startRoute.IsLast)
		{
			return Execute(startRoute.Execution, context, token);
		}
		return OnJumpChild(startRoute, context, token);
	}

	protected virtual void OnInit()
	{
	}

	protected virtual UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	protected virtual UniTask<DialogueNodeResult> OnJumpChild(DialogueStartRoute startRoute, DialogueContext context, CancellationToken token)
	{
		throw new InvalidOperationException("本节点(" + m_Data.GetType().Name + ")不支持跳转到子节点执行，跳转链中断");
	}

	public DialogueNodeProcessor GetChild(int index)
	{
		if (index >= Data.children.Count)
		{
			return null;
		}
		return Flow.GetNode(Data.children[index].id);
	}

	public DialogueNodeProcessor GetChildById(long id)
	{
		DialogueNodeProcessor node = Flow.GetNode(id);
		if (node == null)
		{
			return null;
		}
		if (node.Parent != this)
		{
			return null;
		}
		return node;
	}
}
public abstract class DialogueNodeProcessor<T> : DialogueNodeProcessor where T : DialogueNode
{
	public T TData => (T)Data;
}
