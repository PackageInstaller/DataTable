using System;
using System.Collections.Generic;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas.Framework;

[CreateAssetMenu(menuName = "ParadoxNotion/CanvasCore/Blackboard Asset")]
public class AssetBlackboard : ScriptableObject, ISerializationCallbackReceiver, IGlobalBlackboard, IBlackboard
{
	[SerializeField]
	private GraphByteData _graphByteData = new GraphByteData();

	[SerializeField]
	private string _serializedBlackboard;

	[SerializeField]
	private List<UnityEngine.Object> _objectReferences;

	[SerializeField]
	private string _UID = Guid.NewGuid().ToString();

	[NonSerialized]
	private string _identifier;

	[NonSerialized]
	private BlackboardSource _blackboard = new BlackboardSource();

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

	UnityEngine.Object IBlackboard.unityContextObject => this;

	IBlackboard IBlackboard.parent => null;

	Component IBlackboard.propertiesBindTarget => null;

	string IBlackboard.independantVariablesFieldName => null;

	public string identifier => _identifier;

	public string UID => _UID;

	public event Action<Variable> onVariableAdded;

	public event Action<Variable> onVariableRemoved;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		SelfSerialize();
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		SelfDeserialize();
	}

	private void SelfSerialize()
	{
		_objectReferences = new List<UnityEngine.Object>();
		_serializedBlackboard = JSONSerializer.Serialize(typeof(BlackboardSource), _blackboard, _graphByteData, _objectReferences);
	}

	private void SelfDeserialize()
	{
		_blackboard = JSONSerializer.Deserialize<BlackboardSource>(_serializedBlackboard, _graphByteData, _objectReferences);
		if (_blackboard == null)
		{
			_blackboard = new BlackboardSource();
		}
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
	}

	[ContextMenu("Show Json")]
	private void ShowJson()
	{
		JSONSerializer.ShowData(_graphByteData, base.name);
	}

	public override string ToString()
	{
		return identifier;
	}

	private void OnValidate()
	{
		_identifier = base.name;
	}

	private void OnEnable()
	{
		if (Threader.applicationIsPlaying)
		{
			this.InitializePropertiesBinding(null, callSetter: false);
		}
	}
}
