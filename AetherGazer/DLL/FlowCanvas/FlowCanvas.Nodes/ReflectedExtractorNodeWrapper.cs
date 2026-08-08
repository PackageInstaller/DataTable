using System;
using System.Collections.Generic;
using System.Reflection;
using MessagePack;
using MessagePack.Formatters;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[DoNotList]
[Description("Chose and expose any number of fields or properties of the type. If you only require a single field / property, it's better to get that field / property directly without an Extractor.")]
[Icon("", false, "GetRuntimeIconType")]
public class ReflectedExtractorNodeWrapper<T> : FlowNode, IReflectedWrapper
{
	private static Dictionary<string, MemberInfo> _memberInfos;

	private static List<string> _instanceMemberNames;

	private static List<string> _staticMemberNames;

	[SerializeField]
	private bool _isStatic;

	[SerializeField]
	private string[] _selectedInstanceMembers;

	[SerializeField]
	private string[] _selectedStaticMembers;

	[NonSerialized]
	private BaseReflectedExtractorNode extractorNode;

	public override string name => $"Extract ({typeof(T).FriendlyName()})";

	MemberInfo IReflectedWrapper.GetMemberInfo()
	{
		return typeof(T);
	}

	private static void FillInfos()
	{
		if (_memberInfos != null)
		{
			return;
		}
		_memberInfos = new Dictionary<string, MemberInfo>(StringComparer.Ordinal);
		_instanceMemberNames = new List<string>();
		_staticMemberNames = new List<string>();
		Type typeFromHandle = typeof(T);
		FieldInfo[] array = typeFromHandle.RTGetFields();
		PropertyInfo[] array2 = typeFromHandle.RTGetProperties();
		FieldInfo[] array3 = array;
		foreach (FieldInfo fieldInfo in array3)
		{
			if (!(fieldInfo == null) && fieldInfo.IsPublic && !fieldInfo.IsObsolete())
			{
				_memberInfos[fieldInfo.Name] = fieldInfo;
				(fieldInfo.IsStatic ? _staticMemberNames : _instanceMemberNames).Add(fieldInfo.Name);
			}
		}
		PropertyInfo[] array4 = array2;
		foreach (PropertyInfo propertyInfo in array4)
		{
			if (!(propertyInfo == null) && !propertyInfo.IsIndexerProperty() && !propertyInfo.IsObsolete())
			{
				MethodInfo methodInfo = propertyInfo.RTGetGetMethod();
				if (!(methodInfo == null) && methodInfo.IsPublic)
				{
					_memberInfos[propertyInfo.Name] = methodInfo;
					(methodInfo.IsStatic ? _staticMemberNames : _instanceMemberNames).Add(propertyInfo.Name);
				}
			}
		}
	}

	public Type GetRuntimeIconType()
	{
		return typeof(T);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		writer.Write(_isStatic);
		IMessagePackFormatter<string[]> formatterWithVerify = options.Resolver.GetFormatterWithVerify<string[]>();
		formatterWithVerify.Serialize(ref writer, _selectedInstanceMembers, options);
		formatterWithVerify.Serialize(ref writer, _selectedStaticMembers, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		_isStatic = reader.ReadBoolean();
		IMessagePackFormatter<string[]> formatterWithVerify = options.Resolver.GetFormatterWithVerify<string[]>();
		_selectedInstanceMembers = formatterWithVerify.Deserialize(ref reader, options);
		_selectedStaticMembers = formatterWithVerify.Deserialize(ref reader, options);
	}

	public override void OnCreate(Graph assignedGraph)
	{
		_selectedInstanceMembers = new string[_instanceMemberNames.Count];
		GatherPorts();
	}

	private void CheckData()
	{
		FillInfos();
		if (_selectedInstanceMembers == null || _selectedInstanceMembers.Length != _instanceMemberNames.Count)
		{
			_selectedInstanceMembers = new string[_instanceMemberNames.Count];
		}
	}

	protected override void RegisterPorts()
	{
		CheckData();
		string[] array = (_isStatic ? _selectedStaticMembers : _selectedInstanceMembers);
		List<MemberInfo> list = new List<MemberInfo>();
		foreach (string text in array)
		{
			if (!string.IsNullOrEmpty(text))
			{
				_memberInfos.TryGetValue(text, out var value);
				if (value != null)
				{
					list.Add(value);
				}
			}
		}
		extractorNode = BaseReflectedExtractorNode.GetExtractorNode(typeof(T), _isStatic, list.ToArray());
		if (extractorNode != null)
		{
			extractorNode.RegisterPorts(this);
		}
	}
}
