using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public class BehaviorSource : IVariableSource
{
	public string behaviorName = "Behavior";

	public string behaviorDescription = "";

	private int behaviorID = -1;

	private Task mEntryTask;

	private Task mRootTask;

	private List<Task> mDetachedTasks;

	private List<SharedVariable> mVariables;

	private Dictionary<string, int> mSharedVariableIndex;

	[NonSerialized]
	private bool mHasSerialized;

	[SerializeField]
	private TaskSerializationData mTaskData;

	[SerializeField]
	private IBehavior mOwner;

	public int BehaviorID
	{
		get
		{
			return behaviorID;
		}
		set
		{
			behaviorID = value;
		}
	}

	public Task EntryTask
	{
		get
		{
			return mEntryTask;
		}
		set
		{
			mEntryTask = value;
		}
	}

	public Task RootTask
	{
		get
		{
			return mRootTask;
		}
		set
		{
			mRootTask = value;
		}
	}

	public List<Task> DetachedTasks
	{
		get
		{
			return mDetachedTasks;
		}
		set
		{
			mDetachedTasks = value;
		}
	}

	public List<SharedVariable> Variables
	{
		get
		{
			return mVariables;
		}
		set
		{
			SetAllVariables(value);
		}
	}

	public bool HasSerialized
	{
		get
		{
			return mHasSerialized;
		}
		set
		{
			mHasSerialized = value;
		}
	}

	public TaskSerializationData TaskData
	{
		get
		{
			return mTaskData;
		}
		set
		{
			mTaskData = value;
		}
	}

	public IBehavior Owner
	{
		get
		{
			return mOwner;
		}
		set
		{
			mOwner = value;
		}
	}

	public BehaviorSource()
	{
	}

	public BehaviorSource(IBehavior owner)
	{
		Initialize(owner);
	}

	public void Initialize(IBehavior owner)
	{
		mOwner = owner;
	}

	public void Save(Task entryTask, Task rootTask, List<Task> detachedTasks)
	{
		mEntryTask = entryTask;
		mRootTask = rootTask;
		mDetachedTasks = detachedTasks;
	}

	public void Load(out Task entryTask, out Task rootTask, out List<Task> detachedTasks)
	{
		entryTask = mEntryTask;
		rootTask = mRootTask;
		detachedTasks = mDetachedTasks;
	}

	public bool CheckForSerialization(bool force, BehaviorSource behaviorSource = null, bool isPlaying = false)
	{
		if (mTaskData != null && (!HasSerialized | force))
		{
			if (behaviorSource != null)
			{
				behaviorSource.HasSerialized = true;
			}
			HasSerialized = true;
			if (!string.IsNullOrEmpty(mTaskData.JSONSerialization))
			{
				JSONDeserialization.Load(mTaskData, (behaviorSource == null) ? this : behaviorSource, isPlaying || behaviorSource == null);
			}
			else
			{
				BinaryDeserialization.Load(mTaskData, (behaviorSource == null) ? this : behaviorSource, isPlaying || behaviorSource == null);
			}
			return true;
		}
		return false;
	}

	public SharedVariable GetVariable(string name)
	{
		if (name == null)
		{
			return null;
		}
		CheckForSerialization(force: false);
		if (mVariables != null)
		{
			if (mSharedVariableIndex == null || mSharedVariableIndex.Count != mVariables.Count)
			{
				UpdateVariablesIndex();
			}
			if (mSharedVariableIndex.TryGetValue(name, out var value))
			{
				return mVariables[value];
			}
		}
		return null;
	}

	public List<SharedVariable> GetAllVariables()
	{
		CheckForSerialization(force: false);
		return mVariables;
	}

	public void SetVariable(string name, SharedVariable sharedVariable)
	{
		if (mVariables == null)
		{
			mVariables = new List<SharedVariable>();
		}
		else if (mSharedVariableIndex == null || mSharedVariableIndex.Count != mVariables.Count)
		{
			UpdateVariablesIndex();
		}
		sharedVariable.Name = name;
		if (mSharedVariableIndex != null && mSharedVariableIndex.TryGetValue(name, out var value))
		{
			SharedVariable sharedVariable2 = mVariables[value];
			if (!sharedVariable2.GetType().Equals(typeof(SharedVariable)) && !sharedVariable2.GetType().Equals(sharedVariable.GetType()))
			{
				Debug.LogError($"Error: Unable to set SharedVariable {name} - the variable type {sharedVariable2.GetType()} does not match the existing type {sharedVariable.GetType()}");
			}
			else if (!string.IsNullOrEmpty(sharedVariable.PropertyMapping))
			{
				sharedVariable2.PropertyMappingOwner = sharedVariable.PropertyMappingOwner;
				sharedVariable2.PropertyMapping = sharedVariable.PropertyMapping;
				sharedVariable2.InitializePropertyMapping(this);
			}
			else
			{
				sharedVariable2.SetValue(sharedVariable.GetValue());
			}
		}
		else if (!(Activator.CreateInstance(sharedVariable.GetType()) is SharedVariable sharedVariable3))
		{
			Debug.LogError("Failed to create instance of SharedVariable type " + sharedVariable.GetType().Name + ".");
		}
		else
		{
			sharedVariable3.Name = name;
			if (!string.IsNullOrEmpty(sharedVariable.PropertyMapping))
			{
				sharedVariable3.PropertyMappingOwner = sharedVariable.PropertyMappingOwner;
				sharedVariable3.PropertyMapping = sharedVariable.PropertyMapping;
				sharedVariable3.InitializePropertyMapping(this);
			}
			else
			{
				sharedVariable3.SetValue(sharedVariable.GetValue());
			}
			mVariables.Add(sharedVariable3);
			UpdateVariablesIndex();
		}
	}

	public void UpdateVariableName(SharedVariable sharedVariable, string name)
	{
		CheckForSerialization(force: false);
		sharedVariable.Name = name;
		UpdateVariablesIndex();
	}

	public void SetAllVariables(List<SharedVariable> variables)
	{
		mVariables = variables;
		UpdateVariablesIndex();
	}

	private void UpdateVariablesIndex()
	{
		if (mVariables == null)
		{
			if (mSharedVariableIndex != null)
			{
				mSharedVariableIndex = null;
			}
			return;
		}
		if (mSharedVariableIndex == null)
		{
			mSharedVariableIndex = new Dictionary<string, int>(mVariables.Count);
		}
		else
		{
			mSharedVariableIndex.Clear();
		}
		for (int i = 0; i < mVariables.Count; i++)
		{
			if (mVariables[i] != null && !mSharedVariableIndex.ContainsKey(mVariables[i].Name))
			{
				mSharedVariableIndex.Add(mVariables[i].Name, i);
			}
		}
	}

	public override string ToString()
	{
		if (mOwner == null || mOwner.GetObject() == null)
		{
			return behaviorName;
		}
		if (string.IsNullOrEmpty(behaviorName))
		{
			return Owner.GetOwnerName();
		}
		return $"{Owner.GetOwnerName()} - {behaviorName}";
	}
}
