using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Libraries.CSharp.BinaryOperatorGenerator")]
public sealed class BinaryOperatorGenerator : ConstructGenerator
{
	[SerializeField]
	private Operator _operator;

	public Operator @operator
	{
		get
		{
			return _operator;
		}
		private set
		{
			_operator = value;
		}
	}

	private BinaryOperatorGenerator()
	{
	}

	public static BinaryOperatorGenerator BinaryOperator(Operator @operator)
	{
		return new BinaryOperatorGenerator
		{
			@operator = @operator
		};
	}

	public override string Generate(int indent)
	{
		string text = " ";
		switch (@operator)
		{
		case Operator.Add:
			text += "+";
			break;
		case Operator.And:
			text += "&&";
			break;
		case Operator.Divide:
			text += "/";
			break;
		case Operator.Equal:
			text += "==";
			break;
		case Operator.ExclusiveOr:
			text += "^";
			break;
		case Operator.Greater:
			text += ">";
			break;
		case Operator.GreaterOrEqual:
			text += ">=";
			break;
		case Operator.NotEqual:
			text += "!=";
			break;
		case Operator.LeftShift:
			text += "<<";
			break;
		case Operator.Less:
			text += "<";
			break;
		case Operator.LessOrEqual:
			text += "<=";
			break;
		case Operator.Modulo:
			text += "%";
			break;
		case Operator.Multiply:
			text += "*";
			break;
		case Operator.Or:
			text += "||";
			break;
		case Operator.RightShift:
			text += ">>";
			break;
		case Operator.Subtract:
			text += "-";
			break;
		}
		return text + " ";
	}

	public override List<string> Usings()
	{
		return new List<string>();
	}
}
