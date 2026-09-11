using System;
using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTEnv : ValueWrapInterface
{
	public enum ExecutionsPerTickType
	{
		NoDuplicates,
		Count
	}

	private IRuntimeAIConfig mTree;

	private ExecutionsPerTickType executionsPerTick;

	[SerializeField]
	private int maxTaskExecutionsPerTick = 100;

	private int maxGlobalTaskExecutionsPerTick = 300;

	private int executionCount;

	public bool ResetValueOnRestart = true;

	private bool alreadyExecute;

	private readonly HashSet<string> paramBeforeRun = new HashSet<string>();

	private readonly Dictionary<string, object> dict = new Dictionary<string, object>();

	private List<BTNodeContext> nodeContext;

	private List<Stack<int>> activeStack;

	public ExecutionsPerTickType ExecutionsPerTick
	{
		get
		{
			return executionsPerTick;
		}
		set
		{
			executionsPerTick = value;
		}
	}

	public int MaxTaskExecutionsPerTick
	{
		get
		{
			return maxTaskExecutionsPerTick;
		}
		set
		{
			maxTaskExecutionsPerTick = value;
		}
	}

	public bool isRunning { get; private set; }

	public bool AlreadyExecute => alreadyExecute;

	public BTNodeContext GetContext(int index)
	{
		return nodeContext[index];
	}

	public void SetContext(int index, ref BTNodeContext ctx)
	{
		nodeContext[index] = ctx;
	}

	public static BTEnv Create(IRuntimeAIConfig btree)
	{
		BTEnv bTEnv = ObjectPool<BTEnv>.Get();
		bTEnv.InitEnv(btree);
		bTEnv.alreadyExecute = false;
		bTEnv.isRunning = true;
		return bTEnv;
	}

	public void EndAllTask()
	{
		for (int num = activeStack.Count - 1; num > -1; num--)
		{
			while (activeStack[num].Count > 0)
			{
				int count = activeStack[num].Count;
				BTNodeStatus status = BTNodeStatus.Success;
				PopTask(activeStack[num].Peek(), num, ref status);
				if (count == 1)
				{
					break;
				}
			}
		}
	}

	public void Dispose()
	{
		if (ContainKey("effectFx"))
		{
			GetObject<BilliardGameEffect>("effectFx").Die();
		}
		foreach (KeyValuePair<string, object> item in dict)
		{
			if (item.Value is ValueWrapInterface valueWrapInterface)
			{
				valueWrapInterface.Dispose();
			}
		}
		mTree = null;
		dict.Clear();
		nodeContext.Clear();
		for (int i = 0; i < activeStack.Count; i++)
		{
			activeStack[i].Clear();
		}
		paramBeforeRun.Clear();
		alreadyExecute = false;
		ObjectPool<BTEnv>.Release(this);
		isRunning = false;
	}

	public void Run()
	{
		if (isRunning)
		{
			alreadyExecute = true;
			if (activeStack[0].Count == 0)
			{
				executionCount = 0;
				RunTask(0, 0, BTNodeStatus.Inactive);
				CheckEnvDispose();
			}
			else
			{
				executionCount = 0;
				AfterRunTickOnce();
				CheckEnvDispose();
			}
		}
	}

	private void InitEnv(IRuntimeAIConfig btree)
	{
		mTree = btree;
		if (nodeContext == null)
		{
			nodeContext = new List<BTNodeContext>();
		}
		for (int i = 0; i < btree.Nodes.Count; i++)
		{
			nodeContext.Add(new BTNodeContext
			{
				index = i,
				Status = BTNodeStatus.Inactive
			});
		}
		if (activeStack == null)
		{
			activeStack = new List<Stack<int>>();
			activeStack.Add(new Stack<int>());
		}
	}

	private void AfterRunTickOnce()
	{
		if (!isRunning)
		{
			return;
		}
		for (int num = activeStack.Count - 1; num > -1; num--)
		{
			BTNodeStatus bTNodeStatus = BTNodeStatus.Inactive;
			int num2 = -1;
			int num3 = 0;
			while (bTNodeStatus != BTNodeStatus.Running && activeStack[num].Count > 0)
			{
				num3 = activeStack[num].Peek();
				if (activeStack[num].Count > 0 && num2 == activeStack[num].Peek())
				{
					break;
				}
				num2 = num3;
				bTNodeStatus = RunTask(num3, num, bTNodeStatus);
			}
		}
	}

	private void CheckEnvDispose()
	{
		if (ContainKey("WaitForDispose"))
		{
			Dispose();
		}
	}

	private BTNodeStatus RunTask(int nodeIndex, int stackIndex, BTNodeStatus previousStatus)
	{
		if (nodeIndex >= nodeContext.Count)
		{
			return previousStatus;
		}
		GetContext(nodeIndex);
		BTNodeStatus status = previousStatus;
		PushTask(nodeIndex, stackIndex);
		BNode bNode = mTree.Nodes[nodeIndex];
		if (bNode is BParentNode bParentNode)
		{
			status = RunParentTask(nodeIndex, ref stackIndex, status);
			status = bParentNode.OverrideStatus(status);
		}
		else
		{
			status = (bNode as BActionNode).Run(this);
		}
		if (status != BTNodeStatus.Running)
		{
			PopTask(nodeIndex, stackIndex, ref status);
		}
		return status;
	}

	private BTNodeStatus RunParentTask(int nodeIndex, ref int stackIndex, BTNodeStatus status)
	{
		BParentNode bParentNode = mTree.Nodes[nodeIndex] as BParentNode;
		_ = bParentNode.nextNodes;
		BTNodeStatus bTNodeStatus = BTNodeStatus.Inactive;
		int num = 0;
		int num2 = -1;
		while (bParentNode.CanExecute(this) && bTNodeStatus != BTNodeStatus.Running)
		{
			num = bParentNode.CurrentChildIndex(this);
			if ((executionsPerTick == ExecutionsPerTickType.NoDuplicates && num == num2) || (executionsPerTick == ExecutionsPerTickType.Count && executionCount >= maxTaskExecutionsPerTick) || executionCount >= maxGlobalTaskExecutionsPerTick)
			{
				status = BTNodeStatus.Running;
				break;
			}
			num2 = num;
			bParentNode.OnChildStarted(this);
			status = (bTNodeStatus = RunTask(bParentNode.nextNodes[num], stackIndex, status));
		}
		return status;
	}

	private void PushTask(int nodeIndex, int stackIndex)
	{
		Stack<int> stack = activeStack[stackIndex];
		if (stack.Count == 0 || stack.Peek() != nodeIndex)
		{
			executionCount++;
			stack.Push(nodeIndex);
			BTNodeContext ctx = GetContext(nodeIndex);
			ctx.pushTime = Time.realtimeSinceStartup;
			ctx.Status = BTNodeStatus.Running;
			SetContext(nodeIndex, ref ctx);
		}
	}

	private void PopTask(int nodeIndex, int stackIndex, ref BTNodeStatus status)
	{
		if (activeStack[stackIndex].Peek() != nodeIndex)
		{
			return;
		}
		activeStack[stackIndex].Pop();
		BTNodeContext ctx = GetContext(nodeIndex);
		ctx.pushTime = -1f;
		ctx.popTime = Time.realtimeSinceStartup;
		ctx.Status = status;
		SetContext(nodeIndex, ref ctx);
		mTree.Nodes[nodeIndex].OnEnd(this);
		int parentIdx = mTree.Nodes[nodeIndex].parentIdx;
		if (parentIdx != -1)
		{
			(mTree.Nodes[parentIdx] as BParentNode).OnChildExecuted(this, status);
		}
		if (activeStack.Count == 0)
		{
			if (stackIndex == 0)
			{
				status = BTNodeStatus.Inactive;
			}
			else
			{
				status = BTNodeStatus.Failure;
			}
		}
	}

	public BNode GetNode(int index)
	{
		return mTree.Nodes[index];
	}

	public void Restart()
	{
		BTNodeStatus status = BTNodeStatus.Success;
		for (int num = activeStack.Count - 1; num > -1; num--)
		{
			while (activeStack[num].Count > 0)
			{
				int count = activeStack[num].Count;
				PopTask(activeStack[num].Peek(), num, ref status);
				if (count == 1)
				{
					break;
				}
			}
		}
		foreach (BNode node in mTree.Nodes)
		{
			node.OnBehaviorRestart(this);
		}
		if (!ResetValueOnRestart)
		{
			return;
		}
		List<string> list = ObjectPool<List<string>>.Get();
		list.Clear();
		foreach (KeyValuePair<string, object> item in dict)
		{
			if (!paramBeforeRun.Contains(item.Key))
			{
				list.Add(item.Key);
			}
		}
		foreach (string item2 in list)
		{
			object obj = dict[item2];
			dict.Remove(item2);
			if (obj is ValueWrapInterface valueWrapInterface)
			{
				valueWrapInterface.Dispose();
			}
		}
	}

	public bool ContainKey(string key)
	{
		return dict.ContainsKey(key);
	}

	public T GetPlayer<T>(string key) where T : BilliardGameEntityBase
	{
		if (!dict.TryGetValue(key, out var value))
		{
			throw new Exception("btenv not found key: " + key + " " + typeof(T).FullName);
		}
		try
		{
			return ((ValueTypeWrap<T>)value).Value;
		}
		catch (InvalidCastException innerException)
		{
			throw new Exception($"不能把{value.GetType()}转换为{typeof(T)}", innerException);
		}
	}

	public void AddPlayer<T>(string key, T value, bool isPersistent = false) where T : BilliardGameEntityBase
	{
		if (isPersistent)
		{
			paramBeforeRun.Add(key);
		}
		ValueTypeWrap<T> value2 = ValueTypeWrap<T>.Create(value);
		dict[key] = value2;
	}

	public void AddStruct<T>(string key, T value, bool isPersistent = false) where T : struct
	{
		if (isPersistent)
		{
			paramBeforeRun.Add(key);
		}
		if (dict.TryGetValue(key, out var value2) && value2 is ValueWrapInterface valueWrapInterface)
		{
			valueWrapInterface.Dispose();
		}
		ValueTypeWrap<T> value3 = ValueTypeWrap<T>.Create(value);
		dict[key] = value3;
	}

	public T GetStruct<T>(string key)
	{
		if (!dict.TryGetValue(key, out var value))
		{
			throw new Exception("btenv not found key: " + key + " " + typeof(T).FullName);
		}
		try
		{
			return ((IValue<T>)value).Value;
		}
		catch (InvalidCastException innerException)
		{
			throw new Exception($"不能把{value.GetType()}转换为{typeof(T)}", innerException);
		}
	}

	public void AddLinkedStruct<T1, T2>(string key, T1 targetKey, T2 value) where T1 : struct where T2 : struct
	{
		ValueTypeWrap<T2> value2 = ValueTypeWrap<T2>.Create(value);
		if (dict.TryGetValue(key, out var value3))
		{
			Dictionary<T1, ValueTypeWrap<T2>> dictionary = value3 as Dictionary<T1, ValueTypeWrap<T2>>;
			dictionary.TryAdd(targetKey, value2);
			dict[key] = dictionary;
		}
		else
		{
			dict[key] = new Dictionary<T1, ValueTypeWrap<T2>> { { targetKey, value2 } };
		}
	}

	public Dictionary<T1, T2> GetLinkedStruct<T1, T2>(string key) where T1 : struct where T2 : struct
	{
		if (!dict.TryGetValue(key, out var value))
		{
			throw new Exception("btenv not found key: " + key);
		}
		Dictionary<T1, T2> dictionary = new Dictionary<T1, T2>();
		foreach (KeyValuePair<T1, ValueTypeWrap<T2>> item in value as Dictionary<T1, ValueTypeWrap<T2>>)
		{
			try
			{
				IValue<T2> value2 = item.Value;
				dictionary.Add(item.Key, value2.Value);
			}
			catch (InvalidCastException innerException)
			{
				throw new Exception($"不能把{item.Value.GetType()}转换为{typeof(T2)}", innerException);
			}
		}
		return dictionary;
	}

	public void AddObject<T>(string key, T value, bool isPersistent = false) where T : class
	{
		if (isPersistent)
		{
			paramBeforeRun.Add(key);
		}
		if (dict.TryGetValue(key, out var value2) && value2 is ValueWrapInterface valueWrapInterface && value2 != value)
		{
			valueWrapInterface.Dispose();
		}
		dict[key] = value;
	}

	public T GetObject<T>(string key) where T : class
	{
		if (!dict.TryGetValue(key, out var value))
		{
			throw new Exception("btenv not found key: " + key + " " + typeof(T).FullName);
		}
		try
		{
			return (T)value;
		}
		catch (InvalidCastException innerException)
		{
			throw new Exception($"不能把{value.GetType()}转换为{typeof(T)}", innerException);
		}
	}

	public bool Remove(string key, out object value)
	{
		if (!dict.TryGetValue(key, out value))
		{
			value = null;
		}
		return dict.Remove(key);
	}
}
