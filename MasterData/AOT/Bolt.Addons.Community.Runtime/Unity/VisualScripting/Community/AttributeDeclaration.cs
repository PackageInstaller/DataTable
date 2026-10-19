using System;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting.Community.Libraries.CSharp;
using Unity.VisualScripting.Community.Utility;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[Inspectable]
[RenamedFrom("Bolt.Addons.Community.Code.AttributeDeclaration")]
public class AttributeDeclaration
{
	[SerializeField]
	[Serialize]
	[Inspectable]
	private SystemType attributeType = new SystemType();

	public List<TypeParam> parameters = new List<TypeParam>();

	public int constructor;

	public int selectedconstructor;

	private string serializedTypeName;

	public void SetType<T>() where T : Attribute
	{
		SetType(typeof(T));
	}

	public void SetType(Type type)
	{
		if (attributeType.type != type)
		{
			attributeType.type = type;
		}
	}

	public Type GetAttributeType()
	{
		return attributeType.type;
	}

	public void AddParameter(string name, Type type, object value)
	{
		TypeParam typeParam = parameters.FirstOrDefault((TypeParam param) => param.name == name);
		if (typeParam != null)
		{
			typeParam.defaultValue = value;
			return;
		}
		TypeParam item = new TypeParam
		{
			name = name,
			type = type,
			defaultValue = value
		};
		parameters.Add(item);
	}
}
