using System;
using System.Collections.Generic;
using System.Reflection;

namespace Unity.VisualScripting;

public abstract class BinaryOperatorHandler(string name, string verb, string symbol, string customMethodName) : OperatorHandler(name, verb, symbol, customMethodName)
{
	private struct OperatorQuery(Type leftType, Type rightType) : IEquatable<OperatorQuery>
	{
		public readonly Type leftType = leftType;

		public readonly Type rightType = rightType;

		public bool Equals(OperatorQuery other)
		{
			if (leftType == other.leftType)
			{
				return rightType == other.rightType;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (!(obj is OperatorQuery))
			{
				return false;
			}
			return Equals((OperatorQuery)obj);
		}

		public override int GetHashCode()
		{
			return HashUtility.GetHashCode(leftType, rightType);
		}
	}

	private readonly Dictionary<OperatorQuery, Func<object, object, object>> handlers = new Dictionary<OperatorQuery, Func<object, object, object>>();

	private readonly Dictionary<OperatorQuery, IOptimizedInvoker> userDefinedOperators = new Dictionary<OperatorQuery, IOptimizedInvoker>();

	private readonly Dictionary<OperatorQuery, OperatorQuery> userDefinedOperandTypes = new Dictionary<OperatorQuery, OperatorQuery>();

	public virtual object Operate(object leftOperand, object rightOperand)
	{
		Type type = leftOperand?.GetType();
		Type type2 = rightOperand?.GetType();
		OperatorQuery key;
		if (type != null && type2 != null)
		{
			key = new OperatorQuery(type, type2);
		}
		else if (type != null && type.IsNullable())
		{
			key = new OperatorQuery(type, type);
		}
		else
		{
			if (!(type2 != null) || !type2.IsNullable())
			{
				if (type == null && type2 == null)
				{
					return BothNullHandling();
				}
				return SingleNullHandling();
			}
			key = new OperatorQuery(type2, type2);
		}
		if (handlers.ContainsKey(key))
		{
			return handlers[key](leftOperand, rightOperand);
		}
		if (customMethodName != null)
		{
			if (!userDefinedOperators.ContainsKey(key))
			{
				MethodInfo method = key.leftType.GetMethod(customMethodName, BindingFlags.Static | BindingFlags.Public, null, new Type[2] { key.leftType, key.rightType }, null);
				if (key.leftType != key.rightType)
				{
					MethodInfo method2 = key.rightType.GetMethod(customMethodName, BindingFlags.Static | BindingFlags.Public, null, new Type[2] { key.leftType, key.rightType }, null);
					if (method != null && method2 != null)
					{
						throw new AmbiguousOperatorException(symbol, key.leftType, key.rightType);
					}
					MethodInfo methodInfo = method ?? method2;
					if (methodInfo != null)
					{
						userDefinedOperandTypes.Add(key, ResolveUserDefinedOperandTypes(methodInfo));
					}
					userDefinedOperators.Add(key, methodInfo?.Prewarm());
				}
				else
				{
					if (method != null)
					{
						userDefinedOperandTypes.Add(key, ResolveUserDefinedOperandTypes(method));
					}
					userDefinedOperators.Add(key, method?.Prewarm());
				}
			}
			if (userDefinedOperators[key] != null)
			{
				leftOperand = ConversionUtility.Convert(leftOperand, userDefinedOperandTypes[key].leftType);
				rightOperand = ConversionUtility.Convert(rightOperand, userDefinedOperandTypes[key].rightType);
				return userDefinedOperators[key].Invoke(null, leftOperand, rightOperand);
			}
		}
		return CustomHandling(leftOperand, rightOperand);
	}

	protected virtual object CustomHandling(object leftOperand, object rightOperand)
	{
		throw new InvalidOperatorException(symbol, leftOperand?.GetType(), rightOperand?.GetType());
	}

	protected virtual object BothNullHandling()
	{
		throw new InvalidOperatorException(symbol, null, null);
	}

	protected virtual object SingleNullHandling()
	{
		throw new InvalidOperatorException(symbol, null, null);
	}

	protected void Handle<TLeft, TRight>(Func<TLeft, TRight, object> handler, bool reverse = false)
	{
		OperatorQuery key = new OperatorQuery(typeof(TLeft), typeof(TRight));
		if (handlers.ContainsKey(key))
		{
			throw new ArgumentException($"A handler is already registered for '{typeof(TLeft)} {symbol} {typeof(TRight)}'.");
		}
		handlers.Add(key, (object left, object right) => handler((TLeft)left, (TRight)right));
		if (!reverse || !(typeof(TLeft) != typeof(TRight)))
		{
			return;
		}
		OperatorQuery key2 = new OperatorQuery(typeof(TRight), typeof(TLeft));
		if (!handlers.ContainsKey(key2))
		{
			handlers.Add(key2, (object left, object right) => handler((TLeft)left, (TRight)right));
		}
	}

	private static OperatorQuery ResolveUserDefinedOperandTypes(MethodInfo userDefinedOperator)
	{
		ParameterInfo[] parameters = userDefinedOperator.GetParameters();
		return new OperatorQuery(parameters[0].ParameterType, parameters[1].ParameterType);
	}
}
