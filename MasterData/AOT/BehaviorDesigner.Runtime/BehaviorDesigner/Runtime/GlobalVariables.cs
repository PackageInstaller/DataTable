using System.Collections.Generic;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

public class GlobalVariables : ScriptableObject, IVariableSource
{
	private static GlobalVariables instance;

	[SerializeField]
	private List<SharedVariable> mVariables;

	private Dictionary<string, int> mSharedVariableIndex;

	[SerializeField]
	private VariableSerializationData mVariableData;

	[SerializeField]
	private string mVersion;

	public static GlobalVariables Instance
	{
		get
		{
			if (instance == null)
			{
				instance = Resources.Load("BehaviorDesignerGlobalVariables", typeof(GlobalVariables)) as GlobalVariables;
				if (instance != null)
				{
					instance.CheckForSerialization(force: false);
				}
			}
			return instance;
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
			mVariables = value;
			UpdateVariablesIndex();
		}
	}

	public VariableSerializationData VariableData
	{
		get
		{
			return mVariableData;
		}
		set
		{
			mVariableData = value;
		}
	}

	public string Version
	{
		get
		{
			return mVersion;
		}
		set
		{
			mVersion = value;
		}
	}

	public void CheckForSerialization(bool force)
	{
		if (force || mVariables == null || (mVariables.Count > 0 && mVariables[0] == null))
		{
			if (VariableData != null && !string.IsNullOrEmpty(VariableData.JSONSerialization))
			{
				JSONDeserialization.Load(VariableData.JSONSerialization, this, mVersion);
			}
			else
			{
				BinaryDeserialization.Load(this, mVersion);
			}
		}
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
		CheckForSerialization(force: false);
		if (mVariables == null)
		{
			mVariables = new List<SharedVariable>();
		}
		else if (mSharedVariableIndex == null)
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
			else
			{
				sharedVariable2.SetValue(sharedVariable.GetValue());
			}
		}
		else
		{
			mVariables.Add(sharedVariable);
			UpdateVariablesIndex();
		}
	}

	public void SetVariableValue(string name, object value)
	{
		GetVariable(name)?.SetValue(value);
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
			if (mVariables[i] != null)
			{
				mSharedVariableIndex.Add(mVariables[i].Name, i);
			}
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void DomainReset()
	{
		instance = null;
	}
}
