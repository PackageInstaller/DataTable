using System;
using System.Collections.Generic;
using Bamboo.HeartBeat;

namespace Bamboo.Command;

public class Worker
{
	private const int MAX_STEP = 16;

	private readonly Beat _timeBeat;

	private readonly List<ISpawnAdapter> _adapters;

	private readonly List<BaseAssignment> _nowAssignments = new List<BaseAssignment>();

	private readonly List<BaseAssignment> _executeNowAssignments = new List<BaseAssignment>();

	private readonly Queue<BaseAssignment> _assignmentQueue = new Queue<BaseAssignment>();

	private BaseAssignment _executingAssignment;

	private bool _isActive;

	public BaseAssignment ExecutingAssignment => _executingAssignment;

	public Worker(Beat timeBeat)
	{
		_timeBeat = timeBeat;
		_adapters = new List<ISpawnAdapter>(1);
		_adapters.Add(AssignmentSpawn.DefaultAdapter);
	}

	public Worker(Beat timeBeat, bool includeDefault, params string[] adapterNames)
	{
		_timeBeat = timeBeat;
		int num = 0;
		if (includeDefault)
		{
			num++;
		}
		if (adapterNames != null)
		{
			num += adapterNames.Length;
		}
		_adapters = new List<ISpawnAdapter>(num);
		if (includeDefault)
		{
			_adapters.Add(AssignmentSpawn.DefaultAdapter);
		}
		if (adapterNames == null)
		{
			return;
		}
		foreach (string text in adapterNames)
		{
			ISpawnAdapter adapter = AssignmentSpawn.GetAdapter(text);
			if (adapter == null)
			{
				throw new Exception("adater is null. adapterName is " + text);
			}
			_adapters.Add(adapter);
		}
	}

	public void Active()
	{
		if (!_isActive)
		{
			_isActive = true;
			_timeBeat.Add(OnUpdate);
		}
	}

	public void Unactive()
	{
		if (_isActive)
		{
			_isActive = false;
			Stop();
			_timeBeat.Remove(OnUpdate);
		}
	}

	public void Accept(BaseAssignment assignment, bool nowExecute = false)
	{
		if (nowExecute)
		{
			if (assignment.State != AssignmentState.Unexecute)
			{
				throw new Exception("The initial state of assigment must be Unexecute.");
			}
			assignment.Execute();
			if (assignment.State == AssignmentState.Executing)
			{
				assignment.Update(0);
				if (assignment.State == AssignmentState.Executing)
				{
					_nowAssignments.Add(assignment);
					return;
				}
			}
			if (assignment.State != AssignmentState.Stopping)
			{
				throw new Exception("The current state of assigment must be Stopping or Executing.");
			}
			assignment.Stop();
		}
		else
		{
			_assignmentQueue.Enqueue(assignment);
		}
	}

	public void Accept(int assignmentID, bool nowExecute = false)
	{
		BaseAssignment baseAssignment = null;
		foreach (ISpawnAdapter adapter in _adapters)
		{
			if (adapter.Has(assignmentID))
			{
				baseAssignment = adapter.SpawnAssignment(assignmentID);
				break;
			}
		}
		if (baseAssignment == null)
		{
			throw new Exception("assignment is null. " + $"assignmentID is {assignmentID}.");
		}
		Accept(baseAssignment, nowExecute);
	}

	public void Accept<T>(int assignmentID, T arg, bool nowExecute = false)
	{
		BaseAssignment baseAssignment = null;
		foreach (ISpawnAdapter adapter in _adapters)
		{
			if (adapter.Has(assignmentID))
			{
				baseAssignment = adapter.SpawnAssignment(assignmentID, arg);
				break;
			}
		}
		if (baseAssignment == null)
		{
			throw new Exception("assignment is null. " + $"assignmentID is {assignmentID}, " + $"arg type is {typeof(T)}.");
		}
		Accept(baseAssignment, nowExecute);
	}

	public void Accept<T1, T2>(int assignmentID, T1 arg1, T2 arg2, bool nowExecute = false)
	{
		BaseAssignment baseAssignment = null;
		foreach (ISpawnAdapter adapter in _adapters)
		{
			if (adapter.Has(assignmentID))
			{
				baseAssignment = adapter.SpawnAssignment(assignmentID, arg1, arg2);
				break;
			}
		}
		if (baseAssignment == null)
		{
			throw new Exception("assignment is null. " + $"assignmentID is {assignmentID}, " + $"arg1 type is {typeof(T1)}, " + $"arg2 type is {typeof(T2)}.");
		}
		Accept(baseAssignment, nowExecute);
	}

	public void Accept<T1, T2, T3>(int assignmentID, T1 arg1, T2 arg2, T3 arg3, bool nowExecute = false)
	{
		BaseAssignment baseAssignment = null;
		foreach (ISpawnAdapter adapter in _adapters)
		{
			if (adapter.Has(assignmentID))
			{
				baseAssignment = adapter.SpawnAssignment(assignmentID, arg1, arg2, arg3);
				break;
			}
		}
		if (baseAssignment == null)
		{
			throw new Exception("assignment is null. " + $"assignmentID is {assignmentID}, " + $"arg1 type is {typeof(T1)}, " + $"arg2 type is {typeof(T2)}, " + $"arg3 type is {typeof(T3)}.");
		}
		Accept(baseAssignment, nowExecute);
	}

	public void Stop()
	{
		StopNowAssignments();
		StopAssignmentQueue();
	}

	private void OnUpdate(int delta)
	{
		UpdateNowAssignments(delta);
		UpdateAssignmentQueue(delta);
	}

	private void UpdateNowAssignments(int delta)
	{
		_executeNowAssignments.Clear();
		foreach (BaseAssignment nowAssignment in _nowAssignments)
		{
			_executeNowAssignments.Add(nowAssignment);
		}
		foreach (BaseAssignment executeNowAssignment in _executeNowAssignments)
		{
			if (executeNowAssignment.State == AssignmentState.Unexecute)
			{
				throw new Exception("The current state of assigment must be Stopping or Executing.");
			}
			if (executeNowAssignment.State == AssignmentState.Executing)
			{
				executeNowAssignment.Update(delta);
			}
			if (executeNowAssignment.State == AssignmentState.Stopping)
			{
				executeNowAssignment.Stop();
			}
		}
		_executeNowAssignments.Clear();
		_nowAssignments.RemoveAll((BaseAssignment _) => _.State == AssignmentState.Stoped);
	}

	private void UpdateAssignmentQueue(int delta)
	{
		if (_executingAssignment == null)
		{
			if (_assignmentQueue.Count == 0)
			{
				return;
			}
			_executingAssignment = _assignmentQueue.Dequeue();
		}
		for (int i = 0; i < 16; i++)
		{
			if (_executingAssignment.State == AssignmentState.Unexecute)
			{
				_executingAssignment.Execute();
			}
			if (_executingAssignment.State == AssignmentState.Executing)
			{
				_executingAssignment.Update(delta);
				if (_executingAssignment.State == AssignmentState.Executing)
				{
					break;
				}
			}
			if (_executingAssignment.State == AssignmentState.Stopping)
			{
				_executingAssignment.Stop();
				if (_assignmentQueue.Count == 0)
				{
					_executingAssignment = null;
					break;
				}
				_executingAssignment = _assignmentQueue.Dequeue();
			}
		}
	}

	private void StopNowAssignments()
	{
		foreach (BaseAssignment nowAssignment in _nowAssignments)
		{
			if (nowAssignment.State == AssignmentState.Executing || nowAssignment.State == AssignmentState.Stopping)
			{
				nowAssignment.Stop();
			}
		}
		_nowAssignments.Clear();
	}

	private void StopAssignmentQueue()
	{
		if (_executingAssignment != null)
		{
			if (_executingAssignment.State == AssignmentState.Executing || _executingAssignment.State == AssignmentState.Stopping)
			{
				_executingAssignment.Stop();
			}
			_executingAssignment = null;
		}
		_assignmentQueue.Clear();
	}
}
