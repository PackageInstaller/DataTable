using System;
using System.Buffers;
using System.Collections.Generic;
using System.IO;
using Google.Protobuf;
using Google.Protobuf.WellKnownTypes;
using MessagePack;
using Nerdbank.Streams;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Framework;

[SpoofAOT]
public class Blackboard : MonoBehaviour, ISerializationCallbackReceiver, IBlackboard
{
	[SerializeField]
	private byte[] _serializedBinBlackboard;

	[SerializeField]
	private string _serializedBlackboard;

	[SerializeField]
	private List<UnityEngine.Object> _objectReferences;

	[NonSerialized]
	private BlackboardSource _blackboard = new BlackboardSource();

	[NonSerialized]
	private bool hasDeserialized;

	[NonSerialized]
	public ProtoBlackboardSource _blackboard2 = new ProtoBlackboardSource();

	[NonSerialized]
	public static bool mToggleBinary;

	public new string name
	{
		get
		{
			if (!string.IsNullOrEmpty(_blackboard.name))
			{
				return _blackboard.name;
			}
			return base.gameObject.name + "_BB";
		}
		set
		{
			if (string.IsNullOrEmpty(value))
			{
				value = base.gameObject.name + "_BB";
			}
			_blackboard.name = value;
		}
	}

	public object this[string varName]
	{
		get
		{
			return _blackboard[varName];
		}
		set
		{
			SetValue(varName, value);
		}
	}

	public Dictionary<string, Variable> variables
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

	public GameObject propertiesBindTarget => base.gameObject;

	public event Action<Variable> onVariableAdded;

	public event Action<Variable> onVariableRemoved;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (!hasDeserialized || !JSONSerializer.applicationPlaying)
		{
			hasDeserialized = true;
			if (mToggleBinary)
			{
				BinDeserialize();
			}
			else
			{
				_blackboard = JSONSerializer.Deserialize<BlackboardSource>(_serializedBlackboard, _objectReferences);
			}
			if (_blackboard == null)
			{
				_blackboard = new BlackboardSource();
			}
		}
	}

	public void RestartBlackboard()
	{
		if (mToggleBinary)
		{
			BinDeserialize();
		}
		else if (!string.IsNullOrEmpty(_serializedBlackboard))
		{
			_blackboard = JSONSerializer.Deserialize<BlackboardSource>(_serializedBlackboard, _objectReferences);
		}
		else
		{
			BinDeserialize();
		}
		if (_blackboard == null)
		{
			_blackboard = new BlackboardSource();
		}
	}

	public byte[] BinSerialize()
	{
		using Sequence<byte> sequence = new Sequence<byte>();
		MessagePackWriter writer = new MessagePackWriter(sequence);
		fsBlackboardFormatter obj = (fsBlackboardFormatter)Graph.sGraphDefaultOpition.Resolver.GetFormatterWithVerify<BlackboardSource>();
		fsSerializationContext.mUnityReferences = _objectReferences;
		obj.Serialize(ref writer, _blackboard, Graph.sGraphDefaultOpition);
		writer.Flush();
		_serializedBinBlackboard = sequence.AsReadOnlySequence.ToArray<byte>();
		return _serializedBinBlackboard;
	}

	public void BinDeserialize()
	{
		MessagePackReader reader = new MessagePackReader(_serializedBinBlackboard);
		fsBlackboardFormatter fsBlackboardFormatter2 = (fsBlackboardFormatter)Graph.sGraphDefaultOpition.Resolver.GetFormatterWithVerify<BlackboardSource>();
		fsSerializationContext.mUnityReferences = _objectReferences;
		_blackboard = fsBlackboardFormatter2.Deserialize(ref reader, Graph.sGraphDefaultOpition);
	}

	public void BinDeserialize(byte[] content)
	{
		_serializedBinBlackboard = content;
		MessagePackReader reader = new MessagePackReader(content);
		fsBlackboardFormatter fsBlackboardFormatter2 = (fsBlackboardFormatter)Graph.sGraphDefaultOpition.Resolver.GetFormatterWithVerify<BlackboardSource>();
		fsSerializationContext.mUnityReferences = _objectReferences;
		_blackboard = fsBlackboardFormatter2.Deserialize(ref reader, Graph.sGraphDefaultOpition);
	}

	protected virtual void Awake()
	{
		_blackboard.InitializePropertiesBinding(propertiesBindTarget, callSetter: false);
	}

	public Variable AddVariable(string name, System.Type type)
	{
		Variable variable = _blackboard.AddVariable(name, type);
		if (onVariableAdded != null)
		{
			onVariableAdded(variable);
		}
		return variable;
	}

	public Variable AddVariable(string name, object value)
	{
		Variable variable = _blackboard.AddVariable(name, value);
		if (onVariableAdded != null)
		{
			onVariableAdded(variable);
		}
		return variable;
	}

	public Variable RemoveVariable(string name)
	{
		Variable variable = _blackboard.RemoveVariable(name);
		if (onVariableRemoved != null)
		{
			onVariableRemoved(variable);
		}
		return variable;
	}

	public Variable GetVariable(string name, System.Type ofType = null)
	{
		return _blackboard.GetVariable(name, ofType);
	}

	public Variable GetVariableByID(string ID)
	{
		return _blackboard.GetVariableByID(ID);
	}

	public Variable<T> GetVariable<T>(string name)
	{
		return _blackboard.GetVariable<T>(name);
	}

	public T GetValue<T>(string name)
	{
		return _blackboard.GetValue<T>(name);
	}

	public Variable SetValue(string name, object value)
	{
		return _blackboard.SetValue(name, value);
	}

	public string[] GetVariableNames()
	{
		return _blackboard.GetVariableNames();
	}

	public string[] GetVariableNames(System.Type ofType)
	{
		return _blackboard.GetVariableNames(ofType);
	}

	public string Save()
	{
		return Save(name);
	}

	public string Save(string saveKey)
	{
		string text = Serialize();
		PlayerPrefs.SetString(saveKey, text);
		return text;
	}

	public bool Load()
	{
		return Load(name);
	}

	public bool Load(string saveKey)
	{
		string text = PlayerPrefs.GetString(saveKey);
		if (string.IsNullOrEmpty(text))
		{
			Debug.Log("No data to load blackboard variables from key " + saveKey);
			return false;
		}
		return Deserialize(text);
	}

	public void AddProtoMapItem(string key, System.Type type, object value = null)
	{
		if (value == null)
		{
			return;
		}
		Any any = null;
		if (type == typeof(int))
		{
			any = Any.Pack(new ProtoInt
			{
				Value = (int)value
			});
		}
		else if (type == typeof(string))
		{
			any = Any.Pack(new ProtoString
			{
				S = (string)value
			});
		}
		else if (type == typeof(List<int>))
		{
			ProtoIntList protoIntList = new ProtoIntList();
			foreach (int item in (List<int>)value)
			{
				protoIntList.List.Add(item);
			}
			any = Any.Pack(protoIntList);
		}
		else if (type == typeof(List<string>))
		{
			ProtoStringList protoStringList = new ProtoStringList();
			foreach (string item2 in (List<string>)value)
			{
				protoStringList.List.Add(item2);
			}
			any = Any.Pack(protoStringList);
		}
		else if (type == typeof(bool))
		{
			any = Any.Pack(new ProtoBool
			{
				Value = (bool)value
			});
		}
		else if (type == typeof(List<bool>))
		{
			ProtoBoolList protoBoolList = new ProtoBoolList();
			foreach (bool item3 in (List<bool>)value)
			{
				protoBoolList.List.Add(item3);
			}
			any = Any.Pack(protoBoolList);
		}
		else if (type == typeof(Int3))
		{
			ProtoInt3 protoInt = new ProtoInt3();
			Int3 @int = (Int3)value;
			protoInt.X = @int.x;
			protoInt.Y = @int.y;
			protoInt.Z = @int.z;
			any = Any.Pack(protoInt);
		}
		else if (type == typeof(List<Int3>))
		{
			ProtoInt3List protoInt3List = new ProtoInt3List();
			foreach (Int3 item4 in (List<Int3>)value)
			{
				ProtoInt3 protoInt2 = new ProtoInt3();
				protoInt2.X = item4.x;
				protoInt2.Y = item4.y;
				protoInt2.Z = item4.z;
				protoInt3List.List.Add(protoInt2);
			}
			any = Any.Pack(protoInt3List);
		}
		if (any != null)
		{
			if (!_blackboard2.Map.ContainsKey(key))
			{
				_blackboard2.Map.Add(key, any);
			}
			else
			{
				_blackboard2.Map.set_Item(key, any);
			}
		}
	}

	public string Serialize()
	{
		return Serialize(_objectReferences);
	}

	public string Serialize(List<UnityEngine.Object> storedObjectReferences)
	{
		return JSONSerializer.Serialize(typeof(BlackboardSource), _blackboard, pretyJson: false, storedObjectReferences);
	}

	public void MySerialize(string path)
	{
		_blackboard2.Map.Clear();
		foreach (KeyValuePair<string, Variable> variable in _blackboard.variables)
		{
			AddProtoMapItem(variable.Value.name, variable.Value.varType, variable.Value.value);
		}
		using FileStream output = File.Create(path);
		_blackboard2.WriteTo(output);
	}

	public ProtoBlackboardSource MySerialize()
	{
		_blackboard2.Map.Clear();
		foreach (KeyValuePair<string, Variable> variable in _blackboard.variables)
		{
			AddProtoMapItem(variable.Value.name, variable.Value.varType, variable.Value.value);
		}
		return _blackboard2;
	}

	public void MyDeserialize(string path)
	{
		using (FileStream input = File.OpenRead(path))
		{
			_blackboard2.MergeFrom(input);
		}
		_blackboard.variables.Clear();
		foreach (KeyValuePair<string, Any> item2 in _blackboard2.Map)
		{
			string key = item2.Key;
			Any value = item2.Value;
			if (value.TypeUrl == "type.googleapis.com/ProtoInt")
			{
				_blackboard.AddVariable(key, value.Unpack<ProtoInt>().Value);
			}
			else if (value.TypeUrl == "type.googleapis.com/ProtoString")
			{
				_blackboard.AddVariable(key, value.Unpack<ProtoString>().S);
			}
			else if (value.TypeUrl == "type.googleapis.com/ProtoIntList")
			{
				List<int> list = new List<int>();
				foreach (int item3 in value.Unpack<ProtoIntList>().List)
				{
					list.Add(item3);
				}
				_blackboard.AddVariable(key, list);
			}
			else if (value.TypeUrl == "type.googleapis.com/ProtoStringList")
			{
				List<string> list2 = new List<string>();
				foreach (string item4 in value.Unpack<ProtoStringList>().List)
				{
					list2.Add(item4);
				}
				_blackboard.AddVariable(key, list2);
			}
			else if (value.TypeUrl == "type.googleapis.com/ProtoBool")
			{
				_blackboard.AddVariable(key, value.Unpack<ProtoBool>().Value);
			}
			else if (value.TypeUrl == "type.googleapis.com/ProtoBoolList")
			{
				List<bool> list3 = new List<bool>();
				foreach (bool item5 in value.Unpack<ProtoBoolList>().List)
				{
					list3.Add(item5);
				}
				_blackboard.AddVariable(key, list3);
			}
			else if (value.TypeUrl == "type.googleapis.com/ProtoInt3")
			{
				ProtoInt3 protoInt = value.Unpack<ProtoInt3>();
				Int3 value2 = new Int3(protoInt.X, protoInt.Y, protoInt.Z);
				_blackboard.AddVariable(key, value2);
			}
			else
			{
				if (!(value.TypeUrl == "type.googleapis.com/ProtoInt3List"))
				{
					continue;
				}
				value.Unpack<ProtoInt3List>();
				List<Int3> list4 = new List<Int3>();
				foreach (ProtoInt3 item6 in value.Unpack<ProtoInt3List>().List)
				{
					Int3 item = new Int3(item6.X, item6.Y, item6.Z);
					list4.Add(item);
				}
				_blackboard.AddVariable(key, list4);
			}
		}
	}

	public bool Deserialize(string json)
	{
		return Deserialize(json, _objectReferences);
	}

	public bool Deserialize(string json, List<UnityEngine.Object> storedObjectReferences, bool removeMissing = true)
	{
		BlackboardSource blackboardSource = JSONSerializer.Deserialize<BlackboardSource>(json, storedObjectReferences);
		if (blackboardSource == null)
		{
			return false;
		}
		foreach (KeyValuePair<string, Variable> variable in blackboardSource.variables)
		{
			if (_blackboard.variables.ContainsKey(variable.Key))
			{
				_blackboard.SetValue(variable.Key, variable.Value.value);
			}
			else
			{
				_blackboard.variables[variable.Key] = variable.Value;
			}
		}
		if (removeMissing)
		{
			foreach (string item in new List<string>(_blackboard.variables.Keys))
			{
				if (!blackboardSource.variables.ContainsKey(item))
				{
					_blackboard.variables.Remove(item);
				}
			}
		}
		_blackboard.InitializePropertiesBinding(propertiesBindTarget, callSetter: true);
		return true;
	}
}
