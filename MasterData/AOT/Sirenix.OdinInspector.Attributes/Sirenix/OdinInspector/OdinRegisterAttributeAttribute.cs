using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class OdinRegisterAttributeAttribute : Attribute
{
	public Type AttributeType;

	public string Categories;

	public string Description;

	public string DocumentationUrl;

	public bool IsEnterprise;

	public OdinRegisterAttributeAttribute(Type attributeType, string category, string description, bool isEnterprise)
	{
		AttributeType = attributeType;
		Categories = category;
		Description = description;
		IsEnterprise = isEnterprise;
	}

	public OdinRegisterAttributeAttribute(Type attributeType, string category, string description, bool isEnterprise, string url)
	{
		AttributeType = attributeType;
		Categories = category;
		Description = description;
		IsEnterprise = isEnterprise;
		DocumentationUrl = url;
	}
}
