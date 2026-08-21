using System;
using System.Collections.Generic;
using UnityEngine;

namespace NodeCanvas.Framework;

[ExecuteInEditMode]
public class GlobalBlackboard : Blackboard, IGlobalBlackboard, IBlackboard
{
	public enum SingletonMode
	{
		DestroyComponentOnly,
		DestroyEntireGameObject
	}

	[SerializeField]
	private string _UID = Guid.NewGuid().ToString();

	[Tooltip("A *unique* identifier of this Global Blackboard")]
	[SerializeField]
	private string _identifier;

	[Tooltip("If a duplicate with the same identifier is encountered, destroy the previous Global Blackboard component only, or the previous Global Blackboard gameobject entirely?")]
	[SerializeField]
	private SingletonMode _singletonMode;

	[Tooltip("If true, the Global Blackboard will not be destroyed when another scene is loaded.")]
	[SerializeField]
	private bool _dontDestroyOnLoad = true;

	private static List<GlobalBlackboard> _allGlobals = new List<GlobalBlackboard>();

	public string identifier => _identifier;

	public string UID => _UID;

	public new string name => identifier;

	public static IEnumerable<GlobalBlackboard> GetAll()
	{
		return _allGlobals;
	}

	public static GlobalBlackboard Create()
	{
		GlobalBlackboard globalBlackboard = new GameObject("@GlobalBlackboard").AddComponent<GlobalBlackboard>();
		globalBlackboard._identifier = "Global";
		return globalBlackboard;
	}

	public static GlobalBlackboard Find(string name)
	{
		return _allGlobals.Find((GlobalBlackboard b) => b.identifier == name);
	}

	protected void OnEnable()
	{
		if (IsPrefabAsset())
		{
			return;
		}
		if (string.IsNullOrEmpty(_identifier))
		{
			_identifier = base.gameObject.name;
		}
		if (Application.isPlaying)
		{
			if (Find(identifier) != null)
			{
				if (_singletonMode == SingletonMode.DestroyComponentOnly)
				{
					UnityEngine.Object.Destroy(this);
				}
				if (_singletonMode == SingletonMode.DestroyEntireGameObject)
				{
					UnityEngine.Object.Destroy(base.gameObject);
				}
				return;
			}
			if (_dontDestroyOnLoad)
			{
				UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			}
			this.InitializePropertiesBinding(((IBlackboard)this).propertiesBindTarget, callSetter: false);
		}
		if (!_allGlobals.Contains(this))
		{
			_allGlobals.Add(this);
		}
	}

	protected void OnDisable()
	{
		if (!IsPrefabAsset())
		{
			_allGlobals.Remove(this);
		}
	}

	protected override void OnValidate()
	{
		base.OnValidate();
		if (!Application.isPlaying && !IsPrefabAsset())
		{
			if (!_allGlobals.Contains(this))
			{
				_allGlobals.Add(this);
			}
			if (string.IsNullOrEmpty(_identifier))
			{
				_identifier = base.gameObject.name;
			}
			GlobalBlackboard globalBlackboard = Find(identifier);
			if (globalBlackboard != this)
			{
				_ = globalBlackboard != null;
			}
		}
	}

	public override string ToString()
	{
		return identifier;
	}

	private bool IsPrefabAsset()
	{
		return false;
	}
}
