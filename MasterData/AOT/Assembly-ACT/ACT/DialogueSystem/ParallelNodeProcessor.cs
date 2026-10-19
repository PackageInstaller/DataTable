using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine.Pool;

namespace ACT.DialogueSystem;

public class ParallelNodeProcessor : DialogueNodeProcessor<ParallelNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		List<UniTask<DialogueNodeResult>> tasks = CollectionPool<List<UniTask<DialogueNodeResult>>, UniTask<DialogueNodeResult>>.Get();
		try
		{
			for (int i = 0; i < ChildrenCount; i++)
			{
				UniTask<DialogueNodeResult> item = GetChild(i).Execute(execution, context, token);
				tasks.Add(item);
			}
			DialogueNodeResult result = DialogueNodeResult.Continue;
			DialogueNodeResult[] array = await UniTask.WhenAll(tasks);
			for (int j = 0; j < array.Length; j++)
			{
				if (array[j].Type > result.Type)
				{
					result = array[j];
				}
			}
			return result;
		}
		finally
		{
			CollectionPool<List<UniTask<DialogueNodeResult>>, UniTask<DialogueNodeResult>>.Release(tasks);
		}
	}
}
