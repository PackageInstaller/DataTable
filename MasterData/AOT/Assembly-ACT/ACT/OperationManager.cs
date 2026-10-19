using System.Collections.Generic;

namespace ACT;

internal static class OperationManager
{
	private static readonly List<OperationBase> _operations = new List<OperationBase>(1000);

	private static readonly List<OperationBase> _newList = new List<OperationBase>(1000);

	public static void Update()
	{
		if (_operations.Count == 0 && _newList.Count == 0)
		{
			return;
		}
		for (int num = _operations.Count - 1; num >= 0; num--)
		{
			if (_operations[num].IsDone)
			{
				_operations.RemoveAt(num);
			}
		}
		if (_newList.Count > 0)
		{
			_operations.AddRange(_newList);
			_newList.Clear();
		}
		for (int i = 0; i < _operations.Count; i++)
		{
			OperationBase operationBase = _operations[i];
			if (!operationBase.IsDone)
			{
				operationBase.OnUpdate();
			}
		}
	}

	internal static void DestroyAll()
	{
		_operations.Clear();
		_newList.Clear();
	}

	internal static void StartOperation(OperationBase operation)
	{
		_newList.Add(operation);
		operation.State = OptionState.Processing;
		operation.OnStart();
	}
}
