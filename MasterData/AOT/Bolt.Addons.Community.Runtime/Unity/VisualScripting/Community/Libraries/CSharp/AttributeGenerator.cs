using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.AttributeGenerator")]
public sealed class AttributeGenerator : ConstructGenerator
{
	public Type type;

	public List<object> parameterValues = new List<object>();

	public List<string> stringTypeParameterValues = new List<string>();

	public List<(string, object)> parameterValuesWithLabel = new List<(string, object)>();

	public override string Generate(int indent)
	{
		string text = string.Empty;
		for (int i = 0; i < parameterValues.Count; i++)
		{
			text += parameterValues[i].As().Code(isNew: false);
			if (i < parameterValues.Count - 1)
			{
				text += ", ";
			}
		}
		for (int j = 0; j < parameterValuesWithLabel.Count; j++)
		{
			text = text + parameterValuesWithLabel[j].Item1 + " = " + parameterValuesWithLabel[j].Item2.As().Code(isNew: false);
			if (j < parameterValuesWithLabel.Count - 1)
			{
				text += ", ";
			}
		}
		for (int k = 0; k < stringTypeParameterValues.Count; k++)
		{
			text = text + "typeof(" + stringTypeParameterValues[k] + ")";
			if (k < stringTypeParameterValues.Count - 1)
			{
				text += ", ";
			}
		}
		bool flag = stringTypeParameterValues.Count > 0 || parameterValuesWithLabel.Count > 0 || parameterValues.Count > 0;
		return CodeBuilder.Indent(indent) + "[" + type.Name.Replace("Attribute", string.Empty).TypeHighlight() + (flag ? ("(" + text + ")") : string.Empty) + "]";
	}

	private AttributeGenerator()
	{
	}

	public override List<string> Usings()
	{
		List<string> list = new List<string>();
		if (type == null)
		{
			return list;
		}
		if (!type.IsPrimitive)
		{
			list.Add(type.Namespace);
		}
		for (int i = 0; i < parameterValues.Count; i++)
		{
			if (parameterValues[i] != null && !(parameterValues[i].GetType() == null) && !string.IsNullOrEmpty(parameterValues[i].GetType().Namespace))
			{
				string item = parameterValues[i].GetType().Namespace;
				if (!list.Contains(item) && !parameterValues[i].GetType().Is().PrimitiveStringOrVoid())
				{
					list.Add(item);
				}
			}
		}
		for (int j = 0; j < parameterValuesWithLabel.Count; j++)
		{
			if (parameterValuesWithLabel[j].Item2 != null && !(parameterValuesWithLabel[j].Item2.GetType() == null) && !string.IsNullOrEmpty(parameterValuesWithLabel[j].Item2.GetType().Namespace))
			{
				string item2 = parameterValuesWithLabel[j].Item2.GetType().Namespace;
				if (!list.Contains(item2) && !parameterValuesWithLabel[j].Item2.GetType().Is().PrimitiveStringOrVoid())
				{
					list.Add(item2);
				}
			}
		}
		return list;
	}

	public static AttributeGenerator Attribute<T>() where T : Attribute
	{
		return new AttributeGenerator
		{
			type = typeof(T)
		};
	}

	public static AttributeGenerator Attribute(Type attributeType)
	{
		return new AttributeGenerator
		{
			type = attributeType
		};
	}

	public AttributeGenerator AddParameter(object value)
	{
		parameterValues.Add(value);
		return this;
	}

	public AttributeGenerator AddStringTypeParameter(string type)
	{
		stringTypeParameterValues.Add(type);
		return this;
	}

	public AttributeGenerator AddParameter(string name, object value)
	{
		parameterValuesWithLabel.Add((name, value));
		return this;
	}
}
