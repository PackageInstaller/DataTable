using System;
using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[SpoofAOT]
[Preserve]
public class Blackboard : MonoBehaviour, ISerializationCallbackReceiver, IBlackboard
{
	[Tooltip("An optional Parent Blackboard Asset to 'inherit' variables from.")]
	[SerializeField]
	private AssetBlackboard _parentBlackboard;

	[SerializeField]
	private GraphByteData _graphByteData = new GraphByteData();

	[SerializeField]
	private string _serializedBlackboard;

	[SerializeField]
	private List<UnityEngine.Object> _objectReferences;

	[SerializeField]
	private SerializationPair[] _serializedVariables;

	[NonSerialized]
	private BlackboardSource _blackboard = new BlackboardSource();

	[NonSerialized]
	private bool haltForUndo;

	[NonSerialized]
	private string _identifier;

	[NonSerialized]
	private Dictionary<string, object> _copyVariables = new Dictionary<string, object>();

	string IBlackboard.identifier => _identifier;

	Dictionary<string, Variable> IBlackboard.variables
	{
		get
		{
			return _blackboard.variables;
		}
		set
		{
			_blackboard.variables = value;
		}
	}

	Component IBlackboard.propertiesBindTarget => this;

	UnityEngine.Object IBlackboard.unityContextObject => this;

	IBlackboard IBlackboard.parent => _parentBlackboard;

	string IBlackboard.independantVariablesFieldName => "_serializedVariables";

	public event Action<Variable> onVariableAdded;

	public event Action<Variable> onVariableRemoved;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		SelfDeserialize();
	}

	public void SelfSerialize()
	{
		if (haltForUndo)
		{
			return;
		}
		List<UnityEngine.Object> list = new List<UnityEngine.Object>();
		List<byte> list2 = new List<byte>();
		list2.AddRange(_graphByteData.ByteGraph);
		JSONSerializer.Serialize(typeof(BlackboardSource), _blackboard, _graphByteData, list);
		if (!list2.SequenceEqual(_graphByteData.ByteGraph) || !list.SequenceEqual(_objectReferences) || _serializedVariables == null || _serializedVariables.Length != _blackboard.variables.Count)
		{
			haltForUndo = true;
			haltForUndo = false;
			_serializedVariables = new SerializationPair[_blackboard.variables.Count];
			for (int i = 0; i < _blackboard.variables.Count; i++)
			{
				SerializationPair serializationPair = new SerializationPair();
				JSONSerializer.ByteSerialize(typeof(Variable), _blackboard.variables.ElementAt(i).Value, serializationPair.graphByteData, serializationPair._references);
				_serializedVariables[i] = serializationPair;
			}
			_objectReferences = list;
			_serializedBlackboard = null;
		}
	}

	public void SelfDeserialize()
	{
		_blackboard = new BlackboardSource();
		JSONSerializer.ByteDeserialize(_blackboard, _graphByteData, _objectReferences);
		if (_serializedVariables.Length == 0)
		{
			return;
		}
		_blackboard.variables.Clear();
		for (int i = 0; i < _serializedVariables.Length; i++)
		{
			Variable variable = JSONSerializer.ByteDeserialize<Variable>(_serializedVariables[i].graphByteData, _serializedVariables[i]._references);
			if (variable != null)
			{
				_blackboard.copyVariables[variable.name] = variable;
				_blackboard.variables[variable.name] = variable;
			}
		}
	}

	public string Serialize()
	{
		return JSONSerializer.Serialize(typeof(BlackboardSource), _blackboard);
	}

	public bool Deserialize(string json, bool removeMissingVariables = true)
	{
		BlackboardSource blackboardSource = JSONSerializer.JsonDeserialize<BlackboardSource>(json);
		if (blackboardSource == null)
		{
			return false;
		}
		this.OverwriteFrom(blackboardSource, removeMissingVariables);
		this.InitializePropertiesBinding(((IBlackboard)this).propertiesBindTarget, callSetter: true);
		return true;
	}

	void IBlackboard.TryInvokeOnVariableAdded(Variable variable)
	{
		if (onVariableAdded != null)
		{
			onVariableAdded(variable);
		}
	}

	void IBlackboard.TryInvokeOnVariableRemoved(Variable variable)
	{
		if (onVariableRemoved != null)
		{
			onVariableRemoved(variable);
		}
	}

	public void RefreshVariables()
	{
		foreach (string key in _blackboard.variables.Keys)
		{
			if (_copyVariables.TryGetValue(key, out var value) && key != "BaseEntity")
			{
				_blackboard.variables[key].value = value;
			}
		}
	}

	protected virtual void Awake()
	{
		_identifier = base.gameObject.name;
		this.InitializePropertiesBinding(((IBlackboard)this).propertiesBindTarget, callSetter: false);
		foreach (string key in _blackboard.variables.Keys)
		{
			_copyVariables.Add(key, _blackboard.variables[key].value);
		}
	}

	public Variable AddVariable(string name, Type type)
	{
		return IBlackboardExtensions.AddVariable(this, name, type);
	}

	public Variable AddVariable(string name, object value)
	{
		return IBlackboardExtensions.AddVariable(this, name, value);
	}

	public Variable RemoveVariable(string name)
	{
		return IBlackboardExtensions.RemoveVariable(this, name);
	}

	public Variable GetVariable(string name, Type ofType = null)
	{
		return IBlackboardExtensions.GetVariable(this, name, ofType);
	}

	public Variable GetVariableByID(string ID)
	{
		return IBlackboardExtensions.GetVariableByID(this, ID);
	}

	public Variable<T> GetVariable<T>(string name)
	{
		return IBlackboardExtensions.GetVariable<T>(this, name);
	}

	public T GetVariableValue<T>(string name)
	{
		return IBlackboardExtensions.GetVariableValue<T>(this, name);
	}

	public Variable SetVariableValue(string name, object value)
	{
		return IBlackboardExtensions.SetVariableValue(this, name, value);
	}

	[Obsolete("Use GetVariableValue")]
	public T GetValue<T>(string name)
	{
		return GetVariableValue<T>(name);
	}

	[Obsolete("Use SetVariableValue")]
	public Variable SetValue(string name, object value)
	{
		return SetVariableValue(name, value);
	}

	[ContextMenu("Show Json")]
	private void ShowJson()
	{
		JSONSerializer.ShowData(_graphByteData, base.name);
	}

	public string Save()
	{
		return Save(base.name);
	}

	public string Save(string saveKey)
	{
		string text = Serialize();
		PlayerPrefs.SetString(saveKey, text);
		return text;
	}

	public bool Load()
	{
		return Load(base.name);
	}

	public bool Load(string saveKey)
	{
		string text = PlayerPrefs.GetString(saveKey);
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		return Deserialize(text);
	}

	protected virtual void OnValidate()
	{
		_identifier = base.gameObject.name;
	}

	public override string ToString()
	{
		return _identifier;
	}
}
