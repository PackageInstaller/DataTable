using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace NodeCanvas.Framework;

[ExecuteInEditMode]
public class GlobalBlackboard : Blackboard
{
	public static List<GlobalBlackboard> allGlobals = new List<GlobalBlackboard>();

	public bool dontDestroy = true;

	public new string name
	{
		get
		{
			return base.name;
		}
		set
		{
			if (base.name != value)
			{
				base.name = value;
				if (!IsUnique())
				{
					Debug.LogError("Another Blackboard has the same name. Please rename either.", base.gameObject);
				}
			}
		}
	}

	public static GlobalBlackboard Create()
	{
		GlobalBlackboard globalBlackboard = new GameObject("@GlobalBlackboard").AddComponent<GlobalBlackboard>();
		globalBlackboard.name = "Global";
		return globalBlackboard;
	}

	public static GlobalBlackboard Find(string name)
	{
		if (!Application.isPlaying)
		{
			return (from b in Object.FindObjectsOfType<GlobalBlackboard>()
				where b.name == name
				select b).FirstOrDefault();
		}
		GlobalBlackboard globalBlackboard = allGlobals.Find((GlobalBlackboard b) => b.name == name);
		if (globalBlackboard == null)
		{
			globalBlackboard = (from b in Object.FindObjectsOfType<GlobalBlackboard>()
				where b.name == name
				select b).FirstOrDefault();
			if (globalBlackboard != null)
			{
				allGlobals.Add(globalBlackboard);
			}
		}
		return globalBlackboard;
	}

	protected override void Awake()
	{
		base.Awake();
		if (!allGlobals.Contains(this))
		{
			allGlobals.Add(this);
		}
		if (Application.isPlaying)
		{
			if (IsUnique())
			{
				if (dontDestroy)
				{
					Object.DontDestroyOnLoad(base.gameObject);
				}
			}
			else
			{
				Debug.Log($"There exist more than one Global Blackboards with same name '{name}'. The old one will be destroyed and replaced with the new one.");
				Object.Destroy(base.gameObject);
			}
		}
		if (!Application.isPlaying && !IsUnique())
		{
			Debug.LogError($"There is a duplicate <b>GlobalBlackboard</b> named '{name}' in the scene. Please rename it.", this);
		}
	}

	private void OnDestroy()
	{
		allGlobals.Remove(this);
	}

	private bool IsUnique()
	{
		return allGlobals.Find((GlobalBlackboard b) => b.name == name && b != this) == null;
	}
}
