using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;
using System.Linq.Expressions.Interpreter;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

public abstract class Expression
{
	internal class BinaryExpressionProxy
	{
	}

	internal class BlockExpressionProxy
	{
	}

	internal class CatchBlockProxy
	{
	}

	internal class ConditionalExpressionProxy
	{
	}

	internal class ConstantExpressionProxy
	{
	}

	internal class DebugInfoExpressionProxy
	{
	}

	internal class DefaultExpressionProxy
	{
	}

	internal class GotoExpressionProxy
	{
	}

	internal class IndexExpressionProxy
	{
	}

	internal class InvocationExpressionProxy
	{
	}

	internal class LabelExpressionProxy
	{
	}

	internal class LambdaExpressionProxy
	{
	}

	internal class ListInitExpressionProxy
	{
	}

	internal class LoopExpressionProxy
	{
	}

	internal class MemberExpressionProxy
	{
	}

	internal class MemberInitExpressionProxy
	{
	}

	internal class MethodCallExpressionProxy
	{
	}

	internal class NewArrayExpressionProxy
	{
	}

	internal class NewExpressionProxy
	{
	}

	internal class ParameterExpressionProxy
	{
	}

	internal class RuntimeVariablesExpressionProxy
	{
	}

	internal class SwitchCaseProxy
	{
	}

	internal class SwitchExpressionProxy
	{
	}

	internal class TryExpressionProxy
	{
	}

	internal class TypeBinaryExpressionProxy
	{
	}

	internal class UnaryExpressionProxy
	{
	}

	private class ExtensionInfo
	{
		internal readonly ExpressionType NodeType;

		internal readonly Type Type;
	}

	private static readonly CacheDict<Type, MethodInfo> s_lambdaDelegateCache = new CacheDict<Type, MethodInfo>(40);

	private static volatile CacheDict<Type, Func<Expression, string, bool, ReadOnlyCollection<ParameterExpression>, LambdaExpression>> s_lambdaFactories;

	private static ConditionalWeakTable<Expression, ExtensionInfo> s_legacyCtorSupportTable;

	public virtual ExpressionType NodeType
	{
		get
		{
			if (s_legacyCtorSupportTable != null && s_legacyCtorSupportTable.TryGetValue(this, out var value))
			{
				return value.NodeType;
			}
			throw Error.ExtensionNodeMustOverrideProperty("Expression.NodeType");
		}
	}

	public virtual Type Type
	{
		get
		{
			if (s_legacyCtorSupportTable != null && s_legacyCtorSupportTable.TryGetValue(this, out var value))
			{
				return value.Type;
			}
			throw Error.ExtensionNodeMustOverrideProperty("Expression.Type");
		}
	}

	public virtual bool CanReduce => false;

	public static BinaryExpression Assign(Expression left, Expression right)
	{
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		TypeUtils.ValidateType(left.Type, "left", allowByRef: true, allowPointer: true);
		TypeUtils.ValidateType(right.Type, "right", allowByRef: true, allowPointer: true);
		if (!TypeUtils.AreReferenceAssignable(left.Type, right.Type))
		{
			throw Error.ExpressionTypeDoesNotMatchAssignment(right.Type, left.Type);
		}
		return new AssignBinaryExpression(left, right);
	}

	private static BinaryExpression GetUserDefinedBinaryOperator(ExpressionType binaryType, string name, Expression left, Expression right, bool liftToNull)
	{
		MethodInfo userDefinedBinaryOperator = GetUserDefinedBinaryOperator(binaryType, left.Type, right.Type, name);
		if (userDefinedBinaryOperator != null)
		{
			return new MethodBinaryExpression(binaryType, left, right, userDefinedBinaryOperator.ReturnType, userDefinedBinaryOperator);
		}
		if (left.Type.IsNullableType() && right.Type.IsNullableType())
		{
			Type nonNullableType = left.Type.GetNonNullableType();
			Type nonNullableType2 = right.Type.GetNonNullableType();
			userDefinedBinaryOperator = GetUserDefinedBinaryOperator(binaryType, nonNullableType, nonNullableType2, name);
			if (userDefinedBinaryOperator != null && userDefinedBinaryOperator.ReturnType.IsValueType && !userDefinedBinaryOperator.ReturnType.IsNullableType())
			{
				if ((userDefinedBinaryOperator.ReturnType != typeof(bool)) | liftToNull)
				{
					return new MethodBinaryExpression(binaryType, left, right, userDefinedBinaryOperator.ReturnType.GetNullableType(), userDefinedBinaryOperator);
				}
				return new MethodBinaryExpression(binaryType, left, right, typeof(bool), userDefinedBinaryOperator);
			}
		}
		return null;
	}

	private static BinaryExpression GetMethodBasedBinaryOperator(ExpressionType binaryType, Expression left, Expression right, MethodInfo method, bool liftToNull)
	{
		ValidateOperator(method);
		ParameterInfo[] parametersCached = method.GetParametersCached();
		if (parametersCached.Length != 2)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(method, "method");
		}
		if (ParameterIsAssignable(parametersCached[0], left.Type) && ParameterIsAssignable(parametersCached[1], right.Type))
		{
			ValidateParamswithOperandsOrThrow(parametersCached[0].ParameterType, left.Type, binaryType, method.Name);
			ValidateParamswithOperandsOrThrow(parametersCached[1].ParameterType, right.Type, binaryType, method.Name);
			return new MethodBinaryExpression(binaryType, left, right, method.ReturnType, method);
		}
		if (left.Type.IsNullableType() && right.Type.IsNullableType() && ParameterIsAssignable(parametersCached[0], left.Type.GetNonNullableType()) && ParameterIsAssignable(parametersCached[1], right.Type.GetNonNullableType()) && method.ReturnType.IsValueType && !method.ReturnType.IsNullableType())
		{
			if ((method.ReturnType != typeof(bool)) | liftToNull)
			{
				return new MethodBinaryExpression(binaryType, left, right, method.ReturnType.GetNullableType(), method);
			}
			return new MethodBinaryExpression(binaryType, left, right, typeof(bool), method);
		}
		throw Error.OperandTypesDoNotMatchParameters(binaryType, method.Name);
	}

	private static BinaryExpression GetMethodBasedAssignOperator(ExpressionType binaryType, Expression left, Expression right, MethodInfo method, LambdaExpression conversion, bool liftToNull)
	{
		BinaryExpression binaryExpression = GetMethodBasedBinaryOperator(binaryType, left, right, method, liftToNull);
		if (conversion == null)
		{
			if (!TypeUtils.AreReferenceAssignable(left.Type, binaryExpression.Type))
			{
				throw Error.UserDefinedOpMustHaveValidReturnType(binaryType, binaryExpression.Method.Name);
			}
		}
		else
		{
			ValidateOpAssignConversionLambda(conversion, binaryExpression.Left, binaryExpression.Method, binaryExpression.NodeType);
			binaryExpression = new OpAssignMethodConversionBinaryExpression(binaryExpression.NodeType, binaryExpression.Left, binaryExpression.Right, binaryExpression.Left.Type, binaryExpression.Method, conversion);
		}
		return binaryExpression;
	}

	private static BinaryExpression GetUserDefinedBinaryOperatorOrThrow(ExpressionType binaryType, string name, Expression left, Expression right, bool liftToNull)
	{
		BinaryExpression userDefinedBinaryOperator = GetUserDefinedBinaryOperator(binaryType, name, left, right, liftToNull);
		if (userDefinedBinaryOperator != null)
		{
			ParameterInfo[] parametersCached = userDefinedBinaryOperator.Method.GetParametersCached();
			ValidateParamswithOperandsOrThrow(parametersCached[0].ParameterType, left.Type, binaryType, name);
			ValidateParamswithOperandsOrThrow(parametersCached[1].ParameterType, right.Type, binaryType, name);
			return userDefinedBinaryOperator;
		}
		throw Error.BinaryOperatorNotDefined(binaryType, left.Type, right.Type);
	}

	private static BinaryExpression GetUserDefinedAssignOperatorOrThrow(ExpressionType binaryType, string name, Expression left, Expression right, LambdaExpression conversion, bool liftToNull)
	{
		BinaryExpression binaryExpression = GetUserDefinedBinaryOperatorOrThrow(binaryType, name, left, right, liftToNull);
		if (conversion == null)
		{
			if (!TypeUtils.AreReferenceAssignable(left.Type, binaryExpression.Type))
			{
				throw Error.UserDefinedOpMustHaveValidReturnType(binaryType, binaryExpression.Method.Name);
			}
		}
		else
		{
			ValidateOpAssignConversionLambda(conversion, binaryExpression.Left, binaryExpression.Method, binaryExpression.NodeType);
			binaryExpression = new OpAssignMethodConversionBinaryExpression(binaryExpression.NodeType, binaryExpression.Left, binaryExpression.Right, binaryExpression.Left.Type, binaryExpression.Method, conversion);
		}
		return binaryExpression;
	}

	private static MethodInfo GetUserDefinedBinaryOperator(ExpressionType binaryType, Type leftType, Type rightType, string name)
	{
		Type[] types = new Type[2] { leftType, rightType };
		Type nonNullableType = leftType.GetNonNullableType();
		Type nonNullableType2 = rightType.GetNonNullableType();
		MethodInfo methodInfo = nonNullableType.GetAnyStaticMethodValidated(name, types);
		if (methodInfo == null && !TypeUtils.AreEquivalent(leftType, rightType))
		{
			methodInfo = nonNullableType2.GetAnyStaticMethodValidated(name, types);
		}
		if (IsLiftingConditionalLogicalOperator(leftType, rightType, methodInfo, binaryType))
		{
			methodInfo = GetUserDefinedBinaryOperator(binaryType, nonNullableType, nonNullableType2, name);
		}
		return methodInfo;
	}

	private static bool IsLiftingConditionalLogicalOperator(Type left, Type right, MethodInfo method, ExpressionType binaryType)
	{
		if (right.IsNullableType() && left.IsNullableType() && method == null)
		{
			if (binaryType != ExpressionType.AndAlso)
			{
				return binaryType == ExpressionType.OrElse;
			}
			return true;
		}
		return false;
	}

	internal static bool ParameterIsAssignable(ParameterInfo pi, Type argType)
	{
		Type type = pi.ParameterType;
		if (type.IsByRef)
		{
			type = type.GetElementType();
		}
		return TypeUtils.AreReferenceAssignable(type, argType);
	}

	private static void ValidateParamswithOperandsOrThrow(Type paramType, Type operandType, ExpressionType exprType, string name)
	{
		if (paramType.IsNullableType() && !operandType.IsNullableType())
		{
			throw Error.OperandTypesDoNotMatchParameters(exprType, name);
		}
	}

	private static void ValidateOperator(MethodInfo method)
	{
		ValidateMethodInfo(method, "method");
		if (!method.IsStatic)
		{
			throw Error.UserDefinedOperatorMustBeStatic(method, "method");
		}
		if (method.ReturnType == typeof(void))
		{
			throw Error.UserDefinedOperatorMustNotBeVoid(method, "method");
		}
	}

	private static void ValidateMethodInfo(MethodInfo method, string paramName)
	{
		if (method.ContainsGenericParameters)
		{
			throw method.IsGenericMethodDefinition ? Error.MethodIsGeneric(method, paramName) : Error.MethodContainsGenericParameters(method, paramName);
		}
	}

	private static bool IsNullComparison(Expression left, Expression right)
	{
		if (!IsNullConstant(left))
		{
			if (IsNullConstant(right))
			{
				return left.Type.IsNullableType();
			}
			return false;
		}
		if (!IsNullConstant(right))
		{
			return right.Type.IsNullableType();
		}
		return false;
	}

	private static bool IsNullConstant(Expression e)
	{
		if (e is ConstantExpression constantExpression)
		{
			return constantExpression.Value == null;
		}
		return false;
	}

	private static void ValidateUserDefinedConditionalLogicOperator(ExpressionType nodeType, Type left, Type right, MethodInfo method)
	{
		ValidateOperator(method);
		ParameterInfo[] parametersCached = method.GetParametersCached();
		if (parametersCached.Length != 2)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(method, "method");
		}
		if (!ParameterIsAssignable(parametersCached[0], left) && (!left.IsNullableType() || !ParameterIsAssignable(parametersCached[0], left.GetNonNullableType())))
		{
			throw Error.OperandTypesDoNotMatchParameters(nodeType, method.Name);
		}
		if (!ParameterIsAssignable(parametersCached[1], right) && (!right.IsNullableType() || !ParameterIsAssignable(parametersCached[1], right.GetNonNullableType())))
		{
			throw Error.OperandTypesDoNotMatchParameters(nodeType, method.Name);
		}
		if (parametersCached[0].ParameterType != parametersCached[1].ParameterType)
		{
			throw Error.UserDefinedOpMustHaveConsistentTypes(nodeType, method.Name);
		}
		if (method.ReturnType != parametersCached[0].ParameterType)
		{
			throw Error.UserDefinedOpMustHaveConsistentTypes(nodeType, method.Name);
		}
		if (IsValidLiftedConditionalLogicalOperator(left, right, parametersCached))
		{
			left = left.GetNonNullableType();
		}
		Type declaringType = method.DeclaringType;
		if (declaringType == null)
		{
			throw Error.LogicalOperatorMustHaveBooleanOperators(nodeType, method.Name);
		}
		MethodInfo booleanOperator = TypeUtils.GetBooleanOperator(declaringType, "op_True");
		MethodInfo booleanOperator2 = TypeUtils.GetBooleanOperator(declaringType, "op_False");
		if (booleanOperator == null || booleanOperator.ReturnType != typeof(bool) || booleanOperator2 == null || booleanOperator2.ReturnType != typeof(bool))
		{
			throw Error.LogicalOperatorMustHaveBooleanOperators(nodeType, method.Name);
		}
		VerifyOpTrueFalse(nodeType, left, booleanOperator2, "method");
		VerifyOpTrueFalse(nodeType, left, booleanOperator, "method");
	}

	private static void VerifyOpTrueFalse(ExpressionType nodeType, Type left, MethodInfo opTrue, string paramName)
	{
		ParameterInfo[] parametersCached = opTrue.GetParametersCached();
		if (parametersCached.Length != 1)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(opTrue, paramName);
		}
		if (!ParameterIsAssignable(parametersCached[0], left) && (!left.IsNullableType() || !ParameterIsAssignable(parametersCached[0], left.GetNonNullableType())))
		{
			throw Error.OperandTypesDoNotMatchParameters(nodeType, opTrue.Name);
		}
	}

	private static bool IsValidLiftedConditionalLogicalOperator(Type left, Type right, ParameterInfo[] pms)
	{
		if (TypeUtils.AreEquivalent(left, right) && right.IsNullableType())
		{
			return TypeUtils.AreEquivalent(pms[1].ParameterType, right.GetNonNullableType());
		}
		return false;
	}

	public static BinaryExpression MakeBinary(ExpressionType binaryType, Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		return MakeBinary(binaryType, left, right, liftToNull, method, null);
	}

	public static BinaryExpression MakeBinary(ExpressionType binaryType, Expression left, Expression right, bool liftToNull, MethodInfo method, LambdaExpression conversion)
	{
		return binaryType switch
		{
			ExpressionType.Add => Add(left, right, method), 
			ExpressionType.AddChecked => AddChecked(left, right, method), 
			ExpressionType.Subtract => Subtract(left, right, method), 
			ExpressionType.SubtractChecked => SubtractChecked(left, right, method), 
			ExpressionType.Multiply => Multiply(left, right, method), 
			ExpressionType.MultiplyChecked => MultiplyChecked(left, right, method), 
			ExpressionType.Divide => Divide(left, right, method), 
			ExpressionType.Modulo => Modulo(left, right, method), 
			ExpressionType.Power => Power(left, right, method), 
			ExpressionType.And => And(left, right, method), 
			ExpressionType.AndAlso => AndAlso(left, right, method), 
			ExpressionType.Or => Or(left, right, method), 
			ExpressionType.OrElse => OrElse(left, right, method), 
			ExpressionType.LessThan => LessThan(left, right, liftToNull, method), 
			ExpressionType.LessThanOrEqual => LessThanOrEqual(left, right, liftToNull, method), 
			ExpressionType.GreaterThan => GreaterThan(left, right, liftToNull, method), 
			ExpressionType.GreaterThanOrEqual => GreaterThanOrEqual(left, right, liftToNull, method), 
			ExpressionType.Equal => Equal(left, right, liftToNull, method), 
			ExpressionType.NotEqual => NotEqual(left, right, liftToNull, method), 
			ExpressionType.ExclusiveOr => ExclusiveOr(left, right, method), 
			ExpressionType.Coalesce => Coalesce(left, right, conversion), 
			ExpressionType.ArrayIndex => ArrayIndex(left, right), 
			ExpressionType.RightShift => RightShift(left, right, method), 
			ExpressionType.LeftShift => LeftShift(left, right, method), 
			ExpressionType.Assign => Assign(left, right), 
			ExpressionType.AddAssign => AddAssign(left, right, method, conversion), 
			ExpressionType.AndAssign => AndAssign(left, right, method, conversion), 
			ExpressionType.DivideAssign => DivideAssign(left, right, method, conversion), 
			ExpressionType.ExclusiveOrAssign => ExclusiveOrAssign(left, right, method, conversion), 
			ExpressionType.LeftShiftAssign => LeftShiftAssign(left, right, method, conversion), 
			ExpressionType.ModuloAssign => ModuloAssign(left, right, method, conversion), 
			ExpressionType.MultiplyAssign => MultiplyAssign(left, right, method, conversion), 
			ExpressionType.OrAssign => OrAssign(left, right, method, conversion), 
			ExpressionType.PowerAssign => PowerAssign(left, right, method, conversion), 
			ExpressionType.RightShiftAssign => RightShiftAssign(left, right, method, conversion), 
			ExpressionType.SubtractAssign => SubtractAssign(left, right, method, conversion), 
			ExpressionType.AddAssignChecked => AddAssignChecked(left, right, method, conversion), 
			ExpressionType.SubtractAssignChecked => SubtractAssignChecked(left, right, method, conversion), 
			ExpressionType.MultiplyAssignChecked => MultiplyAssignChecked(left, right, method, conversion), 
			_ => throw Error.UnhandledBinary(binaryType, "binaryType"), 
		};
	}

	public static BinaryExpression Equal(Expression left, Expression right)
	{
		return Equal(left, right, liftToNull: false, null);
	}

	public static BinaryExpression Equal(Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			return GetEqualityComparisonOperator(ExpressionType.Equal, "op_Equality", left, right, liftToNull);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Equal, left, right, method, liftToNull);
	}

	public static BinaryExpression ReferenceEqual(Expression left, Expression right)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (TypeUtils.HasReferenceEquality(left.Type, right.Type))
		{
			return new LogicalBinaryExpression(ExpressionType.Equal, left, right);
		}
		throw Error.ReferenceEqualityNotDefined(left.Type, right.Type);
	}

	public static BinaryExpression NotEqual(Expression left, Expression right)
	{
		return NotEqual(left, right, liftToNull: false, null);
	}

	public static BinaryExpression NotEqual(Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			return GetEqualityComparisonOperator(ExpressionType.NotEqual, "op_Inequality", left, right, liftToNull);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.NotEqual, left, right, method, liftToNull);
	}

	public static BinaryExpression ReferenceNotEqual(Expression left, Expression right)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (TypeUtils.HasReferenceEquality(left.Type, right.Type))
		{
			return new LogicalBinaryExpression(ExpressionType.NotEqual, left, right);
		}
		throw Error.ReferenceEqualityNotDefined(left.Type, right.Type);
	}

	private static BinaryExpression GetEqualityComparisonOperator(ExpressionType binaryType, string opName, Expression left, Expression right, bool liftToNull)
	{
		if (left.Type == right.Type && (left.Type.IsNumeric() || left.Type == typeof(object) || left.Type.IsBool() || left.Type.GetNonNullableType().IsEnum))
		{
			if (left.Type.IsNullableType() & liftToNull)
			{
				return new SimpleBinaryExpression(binaryType, left, right, typeof(bool?));
			}
			return new LogicalBinaryExpression(binaryType, left, right);
		}
		BinaryExpression userDefinedBinaryOperator = GetUserDefinedBinaryOperator(binaryType, opName, left, right, liftToNull);
		if (userDefinedBinaryOperator != null)
		{
			return userDefinedBinaryOperator;
		}
		if (TypeUtils.HasBuiltInEqualityOperator(left.Type, right.Type) || IsNullComparison(left, right))
		{
			if (left.Type.IsNullableType() & liftToNull)
			{
				return new SimpleBinaryExpression(binaryType, left, right, typeof(bool?));
			}
			return new LogicalBinaryExpression(binaryType, left, right);
		}
		throw Error.BinaryOperatorNotDefined(binaryType, left.Type, right.Type);
	}

	public static BinaryExpression GreaterThan(Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			return GetComparisonOperator(ExpressionType.GreaterThan, "op_GreaterThan", left, right, liftToNull);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.GreaterThan, left, right, method, liftToNull);
	}

	public static BinaryExpression LessThan(Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			return GetComparisonOperator(ExpressionType.LessThan, "op_LessThan", left, right, liftToNull);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.LessThan, left, right, method, liftToNull);
	}

	public static BinaryExpression GreaterThanOrEqual(Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			return GetComparisonOperator(ExpressionType.GreaterThanOrEqual, "op_GreaterThanOrEqual", left, right, liftToNull);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.GreaterThanOrEqual, left, right, method, liftToNull);
	}

	public static BinaryExpression LessThanOrEqual(Expression left, Expression right, bool liftToNull, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			return GetComparisonOperator(ExpressionType.LessThanOrEqual, "op_LessThanOrEqual", left, right, liftToNull);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.LessThanOrEqual, left, right, method, liftToNull);
	}

	private static BinaryExpression GetComparisonOperator(ExpressionType binaryType, string opName, Expression left, Expression right, bool liftToNull)
	{
		if (left.Type == right.Type && left.Type.IsNumeric())
		{
			if (left.Type.IsNullableType() & liftToNull)
			{
				return new SimpleBinaryExpression(binaryType, left, right, typeof(bool?));
			}
			return new LogicalBinaryExpression(binaryType, left, right);
		}
		return GetUserDefinedBinaryOperatorOrThrow(binaryType, opName, left, right, liftToNull);
	}

	public static BinaryExpression AndAlso(Expression left, Expression right)
	{
		return AndAlso(left, right, null);
	}

	public static BinaryExpression AndAlso(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		Type type;
		if (method == null)
		{
			if (left.Type == right.Type)
			{
				if (left.Type == typeof(bool))
				{
					return new LogicalBinaryExpression(ExpressionType.AndAlso, left, right);
				}
				if (left.Type == typeof(bool?))
				{
					return new SimpleBinaryExpression(ExpressionType.AndAlso, left, right, left.Type);
				}
			}
			method = GetUserDefinedBinaryOperator(ExpressionType.AndAlso, left.Type, right.Type, "op_BitwiseAnd");
			if (method != null)
			{
				ValidateUserDefinedConditionalLogicOperator(ExpressionType.AndAlso, left.Type, right.Type, method);
				type = ((left.Type.IsNullableType() && TypeUtils.AreEquivalent(method.ReturnType, left.Type.GetNonNullableType())) ? left.Type : method.ReturnType);
				return new MethodBinaryExpression(ExpressionType.AndAlso, left, right, type, method);
			}
			throw Error.BinaryOperatorNotDefined(ExpressionType.AndAlso, left.Type, right.Type);
		}
		ValidateUserDefinedConditionalLogicOperator(ExpressionType.AndAlso, left.Type, right.Type, method);
		type = ((left.Type.IsNullableType() && TypeUtils.AreEquivalent(method.ReturnType, left.Type.GetNonNullableType())) ? left.Type : method.ReturnType);
		return new MethodBinaryExpression(ExpressionType.AndAlso, left, right, type, method);
	}

	public static BinaryExpression OrElse(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		Type type;
		if (method == null)
		{
			if (left.Type == right.Type)
			{
				if (left.Type == typeof(bool))
				{
					return new LogicalBinaryExpression(ExpressionType.OrElse, left, right);
				}
				if (left.Type == typeof(bool?))
				{
					return new SimpleBinaryExpression(ExpressionType.OrElse, left, right, left.Type);
				}
			}
			method = GetUserDefinedBinaryOperator(ExpressionType.OrElse, left.Type, right.Type, "op_BitwiseOr");
			if (method != null)
			{
				ValidateUserDefinedConditionalLogicOperator(ExpressionType.OrElse, left.Type, right.Type, method);
				type = ((left.Type.IsNullableType() && method.ReturnType == left.Type.GetNonNullableType()) ? left.Type : method.ReturnType);
				return new MethodBinaryExpression(ExpressionType.OrElse, left, right, type, method);
			}
			throw Error.BinaryOperatorNotDefined(ExpressionType.OrElse, left.Type, right.Type);
		}
		ValidateUserDefinedConditionalLogicOperator(ExpressionType.OrElse, left.Type, right.Type, method);
		type = ((left.Type.IsNullableType() && method.ReturnType == left.Type.GetNonNullableType()) ? left.Type : method.ReturnType);
		return new MethodBinaryExpression(ExpressionType.OrElse, left, right, type, method);
	}

	public static BinaryExpression Coalesce(Expression left, Expression right, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (conversion == null)
		{
			Type type = ValidateCoalesceArgTypes(left.Type, right.Type);
			return new SimpleBinaryExpression(ExpressionType.Coalesce, left, right, type);
		}
		if (left.Type.IsValueType && !left.Type.IsNullableType())
		{
			throw Error.CoalesceUsedOnNonNullType();
		}
		MethodInfo invokeMethod = conversion.Type.GetInvokeMethod();
		if (invokeMethod.ReturnType == typeof(void))
		{
			throw Error.UserDefinedOperatorMustNotBeVoid(conversion, "conversion");
		}
		ParameterInfo[] parametersCached = invokeMethod.GetParametersCached();
		if (parametersCached.Length != 1)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(conversion, "conversion");
		}
		if (!TypeUtils.AreEquivalent(invokeMethod.ReturnType, right.Type))
		{
			throw Error.OperandTypesDoNotMatchParameters(ExpressionType.Coalesce, conversion.ToString());
		}
		if (!ParameterIsAssignable(parametersCached[0], left.Type.GetNonNullableType()) && !ParameterIsAssignable(parametersCached[0], left.Type))
		{
			throw Error.OperandTypesDoNotMatchParameters(ExpressionType.Coalesce, conversion.ToString());
		}
		return new CoalesceConversionBinaryExpression(left, right, conversion);
	}

	private static Type ValidateCoalesceArgTypes(Type left, Type right)
	{
		Type nonNullableType = left.GetNonNullableType();
		if (left.IsValueType && !left.IsNullableType())
		{
			throw Error.CoalesceUsedOnNonNullType();
		}
		if (left.IsNullableType() && right.IsImplicitlyConvertibleTo(nonNullableType))
		{
			return nonNullableType;
		}
		if (right.IsImplicitlyConvertibleTo(left))
		{
			return left;
		}
		if (nonNullableType.IsImplicitlyConvertibleTo(right))
		{
			return right;
		}
		throw Error.ArgumentTypesMustMatch();
	}

	public static BinaryExpression Add(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.Add, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.Add, "op_Addition", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Add, left, right, method, liftToNull: true);
	}

	public static BinaryExpression AddAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.AddAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.AddAssign, "op_Addition", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.AddAssign, left, right, method, conversion, liftToNull: true);
	}

	private static void ValidateOpAssignConversionLambda(LambdaExpression conversion, Expression left, MethodInfo method, ExpressionType nodeType)
	{
		MethodInfo invokeMethod = conversion.Type.GetInvokeMethod();
		ParameterInfo[] parametersCached = invokeMethod.GetParametersCached();
		if (parametersCached.Length != 1)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(conversion, "conversion");
		}
		if (!TypeUtils.AreEquivalent(invokeMethod.ReturnType, left.Type))
		{
			throw Error.OperandTypesDoNotMatchParameters(nodeType, conversion.ToString());
		}
		if (!TypeUtils.AreEquivalent(parametersCached[0].ParameterType, method.ReturnType))
		{
			throw Error.OverloadOperatorTypeDoesNotMatchConversionType(nodeType, conversion.ToString());
		}
	}

	public static BinaryExpression AddAssignChecked(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.AddAssignChecked, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.AddAssignChecked, "op_Addition", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.AddAssignChecked, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression AddChecked(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.AddChecked, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.AddChecked, "op_Addition", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.AddChecked, left, right, method, liftToNull: true);
	}

	public static BinaryExpression Subtract(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.Subtract, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.Subtract, "op_Subtraction", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Subtract, left, right, method, liftToNull: true);
	}

	public static BinaryExpression SubtractAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.SubtractAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.SubtractAssign, "op_Subtraction", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.SubtractAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression SubtractAssignChecked(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.SubtractAssignChecked, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.SubtractAssignChecked, "op_Subtraction", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.SubtractAssignChecked, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression SubtractChecked(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.SubtractChecked, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.SubtractChecked, "op_Subtraction", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.SubtractChecked, left, right, method, liftToNull: true);
	}

	public static BinaryExpression Divide(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.Divide, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.Divide, "op_Division", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Divide, left, right, method, liftToNull: true);
	}

	public static BinaryExpression DivideAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.DivideAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.DivideAssign, "op_Division", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.DivideAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression Modulo(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.Modulo, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.Modulo, "op_Modulus", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Modulo, left, right, method, liftToNull: true);
	}

	public static BinaryExpression ModuloAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.ModuloAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.ModuloAssign, "op_Modulus", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.ModuloAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression Multiply(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.Multiply, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.Multiply, "op_Multiply", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Multiply, left, right, method, liftToNull: true);
	}

	public static BinaryExpression MultiplyAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.MultiplyAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.MultiplyAssign, "op_Multiply", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.MultiplyAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression MultiplyAssignChecked(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.MultiplyAssignChecked, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.MultiplyAssignChecked, "op_Multiply", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.MultiplyAssignChecked, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression MultiplyChecked(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsArithmetic())
			{
				return new SimpleBinaryExpression(ExpressionType.MultiplyChecked, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.MultiplyChecked, "op_Multiply", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.MultiplyChecked, left, right, method, liftToNull: true);
	}

	private static bool IsSimpleShift(Type left, Type right)
	{
		if (left.IsInteger())
		{
			return right.GetNonNullableType() == typeof(int);
		}
		return false;
	}

	private static Type GetResultTypeOfShift(Type left, Type right)
	{
		if (!left.IsNullableType() && right.IsNullableType())
		{
			return typeof(Nullable<>).MakeGenericType(left);
		}
		return left;
	}

	public static BinaryExpression LeftShift(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (IsSimpleShift(left.Type, right.Type))
			{
				Type resultTypeOfShift = GetResultTypeOfShift(left.Type, right.Type);
				return new SimpleBinaryExpression(ExpressionType.LeftShift, left, right, resultTypeOfShift);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.LeftShift, "op_LeftShift", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.LeftShift, left, right, method, liftToNull: true);
	}

	public static BinaryExpression LeftShiftAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (IsSimpleShift(left.Type, right.Type))
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				Type resultTypeOfShift = GetResultTypeOfShift(left.Type, right.Type);
				return new SimpleBinaryExpression(ExpressionType.LeftShiftAssign, left, right, resultTypeOfShift);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.LeftShiftAssign, "op_LeftShift", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.LeftShiftAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression RightShift(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (IsSimpleShift(left.Type, right.Type))
			{
				Type resultTypeOfShift = GetResultTypeOfShift(left.Type, right.Type);
				return new SimpleBinaryExpression(ExpressionType.RightShift, left, right, resultTypeOfShift);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.RightShift, "op_RightShift", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.RightShift, left, right, method, liftToNull: true);
	}

	public static BinaryExpression RightShiftAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (IsSimpleShift(left.Type, right.Type))
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				Type resultTypeOfShift = GetResultTypeOfShift(left.Type, right.Type);
				return new SimpleBinaryExpression(ExpressionType.RightShiftAssign, left, right, resultTypeOfShift);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.RightShiftAssign, "op_RightShift", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.RightShiftAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression And(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsIntegerOrBool())
			{
				return new SimpleBinaryExpression(ExpressionType.And, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.And, "op_BitwiseAnd", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.And, left, right, method, liftToNull: true);
	}

	public static BinaryExpression AndAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsIntegerOrBool())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.AndAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.AndAssign, "op_BitwiseAnd", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.AndAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression Or(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsIntegerOrBool())
			{
				return new SimpleBinaryExpression(ExpressionType.Or, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.Or, "op_BitwiseOr", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Or, left, right, method, liftToNull: true);
	}

	public static BinaryExpression OrAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsIntegerOrBool())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.OrAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.OrAssign, "op_BitwiseOr", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.OrAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression ExclusiveOr(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsIntegerOrBool())
			{
				return new SimpleBinaryExpression(ExpressionType.ExclusiveOr, left, right, left.Type);
			}
			return GetUserDefinedBinaryOperatorOrThrow(ExpressionType.ExclusiveOr, "op_ExclusiveOr", left, right, liftToNull: true);
		}
		return GetMethodBasedBinaryOperator(ExpressionType.ExclusiveOr, left, right, method, liftToNull: true);
	}

	public static BinaryExpression ExclusiveOrAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (left.Type == right.Type && left.Type.IsIntegerOrBool())
			{
				if (conversion != null)
				{
					throw Error.ConversionIsNotSupportedForArithmeticTypes();
				}
				return new SimpleBinaryExpression(ExpressionType.ExclusiveOrAssign, left, right, left.Type);
			}
			return GetUserDefinedAssignOperatorOrThrow(ExpressionType.ExclusiveOrAssign, "op_ExclusiveOr", left, right, conversion, liftToNull: true);
		}
		return GetMethodBasedAssignOperator(ExpressionType.ExclusiveOrAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression Power(Expression left, Expression right, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			if (!(left.Type == right.Type) || !left.Type.IsArithmetic())
			{
				string name = "op_Exponent";
				BinaryExpression userDefinedBinaryOperator = GetUserDefinedBinaryOperator(ExpressionType.Power, name, left, right, liftToNull: true);
				if (userDefinedBinaryOperator == null)
				{
					name = "op_Exponentiation";
					userDefinedBinaryOperator = GetUserDefinedBinaryOperator(ExpressionType.Power, name, left, right, liftToNull: true);
					if (userDefinedBinaryOperator == null)
					{
						throw Error.BinaryOperatorNotDefined(ExpressionType.Power, left.Type, right.Type);
					}
				}
				ParameterInfo[] parametersCached = userDefinedBinaryOperator.Method.GetParametersCached();
				ValidateParamswithOperandsOrThrow(parametersCached[0].ParameterType, left.Type, ExpressionType.Power, name);
				ValidateParamswithOperandsOrThrow(parametersCached[1].ParameterType, right.Type, ExpressionType.Power, name);
				return userDefinedBinaryOperator;
			}
			method = CachedReflectionInfo.Math_Pow_Double_Double;
		}
		return GetMethodBasedBinaryOperator(ExpressionType.Power, left, right, method, liftToNull: true);
	}

	public static BinaryExpression PowerAssign(Expression left, Expression right, MethodInfo method, LambdaExpression conversion)
	{
		ExpressionUtils.RequiresCanRead(left, "left");
		RequiresCanWrite(left, "left");
		ExpressionUtils.RequiresCanRead(right, "right");
		if (method == null)
		{
			method = CachedReflectionInfo.Math_Pow_Double_Double;
			if (method == null)
			{
				throw Error.BinaryOperatorNotDefined(ExpressionType.PowerAssign, left.Type, right.Type);
			}
		}
		return GetMethodBasedAssignOperator(ExpressionType.PowerAssign, left, right, method, conversion, liftToNull: true);
	}

	public static BinaryExpression ArrayIndex(Expression array, Expression index)
	{
		ExpressionUtils.RequiresCanRead(array, "array");
		ExpressionUtils.RequiresCanRead(index, "index");
		if (index.Type != typeof(int))
		{
			throw Error.ArgumentMustBeArrayIndexType("index");
		}
		Type type = array.Type;
		if (!type.IsArray)
		{
			throw Error.ArgumentMustBeArray("array");
		}
		if (type.GetArrayRank() != 1)
		{
			throw Error.IncorrectNumberOfIndexes();
		}
		return new SimpleBinaryExpression(ExpressionType.ArrayIndex, array, index, type.GetElementType());
	}

	public static BlockExpression Block(Expression arg0, Expression arg1)
	{
		ExpressionUtils.RequiresCanRead(arg0, "arg0");
		ExpressionUtils.RequiresCanRead(arg1, "arg1");
		return new Block2(arg0, arg1);
	}

	public static BlockExpression Block(Expression arg0, Expression arg1, Expression arg2)
	{
		ExpressionUtils.RequiresCanRead(arg0, "arg0");
		ExpressionUtils.RequiresCanRead(arg1, "arg1");
		ExpressionUtils.RequiresCanRead(arg2, "arg2");
		return new Block3(arg0, arg1, arg2);
	}

	public static BlockExpression Block(Expression arg0, Expression arg1, Expression arg2, Expression arg3)
	{
		ExpressionUtils.RequiresCanRead(arg0, "arg0");
		ExpressionUtils.RequiresCanRead(arg1, "arg1");
		ExpressionUtils.RequiresCanRead(arg2, "arg2");
		ExpressionUtils.RequiresCanRead(arg3, "arg3");
		return new Block4(arg0, arg1, arg2, arg3);
	}

	public static BlockExpression Block(Expression arg0, Expression arg1, Expression arg2, Expression arg3, Expression arg4)
	{
		ExpressionUtils.RequiresCanRead(arg0, "arg0");
		ExpressionUtils.RequiresCanRead(arg1, "arg1");
		ExpressionUtils.RequiresCanRead(arg2, "arg2");
		ExpressionUtils.RequiresCanRead(arg3, "arg3");
		ExpressionUtils.RequiresCanRead(arg4, "arg4");
		return new Block5(arg0, arg1, arg2, arg3, arg4);
	}

	public static BlockExpression Block(IEnumerable<Expression> expressions)
	{
		return Block(EmptyReadOnlyCollection<ParameterExpression>.Instance, expressions);
	}

	public static BlockExpression Block(Type type, params Expression[] expressions)
	{
		ContractUtils.RequiresNotNull(expressions, "expressions");
		return Block(type, (IEnumerable<Expression>)expressions);
	}

	public static BlockExpression Block(Type type, IEnumerable<Expression> expressions)
	{
		return Block(type, EmptyReadOnlyCollection<ParameterExpression>.Instance, expressions);
	}

	public static BlockExpression Block(IEnumerable<ParameterExpression> variables, params Expression[] expressions)
	{
		return Block(variables, (IEnumerable<Expression>)expressions);
	}

	public static BlockExpression Block(Type type, IEnumerable<ParameterExpression> variables, params Expression[] expressions)
	{
		return Block(type, variables, (IEnumerable<Expression>)expressions);
	}

	public static BlockExpression Block(IEnumerable<ParameterExpression> variables, IEnumerable<Expression> expressions)
	{
		ContractUtils.RequiresNotNull(expressions, "expressions");
		ReadOnlyCollection<ParameterExpression> readOnlyCollection = variables.ToReadOnly();
		if (readOnlyCollection.Count == 0)
		{
			IReadOnlyList<Expression> obj = (expressions as IReadOnlyList<Expression>) ?? expressions.ToReadOnly();
			RequiresCanRead(obj, "expressions");
			return GetOptimizedBlockExpression(obj);
		}
		ReadOnlyCollection<Expression> readOnlyCollection2 = expressions.ToReadOnly();
		RequiresCanRead(readOnlyCollection2, "expressions");
		return BlockCore(null, readOnlyCollection, readOnlyCollection2);
	}

	public static BlockExpression Block(Type type, IEnumerable<ParameterExpression> variables, IEnumerable<Expression> expressions)
	{
		ContractUtils.RequiresNotNull(type, "type");
		ContractUtils.RequiresNotNull(expressions, "expressions");
		ReadOnlyCollection<Expression> readOnlyCollection = expressions.ToReadOnly();
		RequiresCanRead(readOnlyCollection, "expressions");
		ReadOnlyCollection<ParameterExpression> readOnlyCollection2 = variables.ToReadOnly();
		if (readOnlyCollection2.Count == 0 && readOnlyCollection.Count != 0)
		{
			int count = readOnlyCollection.Count;
			if (count != 0 && readOnlyCollection[count - 1].Type == type)
			{
				return GetOptimizedBlockExpression(readOnlyCollection);
			}
		}
		return BlockCore(type, readOnlyCollection2, readOnlyCollection);
	}

	private static BlockExpression BlockCore(Type type, ReadOnlyCollection<ParameterExpression> variables, ReadOnlyCollection<Expression> expressions)
	{
		ValidateVariables(variables, "variables");
		if (type != null)
		{
			if (expressions.Count == 0)
			{
				if (type != typeof(void))
				{
					throw Error.ArgumentTypesMustMatch();
				}
				return new ScopeWithType(variables, expressions, type);
			}
			Expression expression = expressions.Last();
			if (type != typeof(void) && !TypeUtils.AreReferenceAssignable(type, expression.Type))
			{
				throw Error.ArgumentTypesMustMatch();
			}
			if (!TypeUtils.AreEquivalent(type, expression.Type))
			{
				return new ScopeWithType(variables, expressions, type);
			}
		}
		return expressions.Count switch
		{
			0 => (BlockExpression)new ScopeWithType(variables, expressions, typeof(void)), 
			1 => new Scope1(variables, expressions[0]), 
			_ => new ScopeN(variables, expressions), 
		};
	}

	internal static void ValidateVariables(ReadOnlyCollection<ParameterExpression> varList, string collectionName)
	{
		int count = varList.Count;
		if (count == 0)
		{
			return;
		}
		HashSet<ParameterExpression> hashSet = new HashSet<ParameterExpression>();
		for (int i = 0; i < count; i++)
		{
			ParameterExpression parameterExpression = varList[i];
			ContractUtils.RequiresNotNull(parameterExpression, collectionName, i);
			if (parameterExpression.IsByRef)
			{
				throw Error.VariableMustNotBeByRef(parameterExpression, parameterExpression.Type, collectionName, i);
			}
			if (!hashSet.Add(parameterExpression))
			{
				throw Error.DuplicateVariable(parameterExpression, collectionName, i);
			}
		}
	}

	private static BlockExpression GetOptimizedBlockExpression(IReadOnlyList<Expression> expressions)
	{
		switch (expressions.Count)
		{
		case 0:
			return BlockCore(typeof(void), EmptyReadOnlyCollection<ParameterExpression>.Instance, EmptyReadOnlyCollection<Expression>.Instance);
		case 2:
			return new Block2(expressions[0], expressions[1]);
		case 3:
			return new Block3(expressions[0], expressions[1], expressions[2]);
		case 4:
			return new Block4(expressions[0], expressions[1], expressions[2], expressions[3]);
		case 5:
			return new Block5(expressions[0], expressions[1], expressions[2], expressions[3], expressions[4]);
		default:
		{
			IReadOnlyList<Expression> readOnlyList = expressions as ReadOnlyCollection<Expression>;
			return new BlockN(readOnlyList ?? expressions.ToArray());
		}
		}
	}

	public static CatchBlock MakeCatchBlock(Type type, ParameterExpression variable, Expression body, Expression filter)
	{
		ContractUtils.RequiresNotNull(type, "type");
		ContractUtils.Requires(variable == null || TypeUtils.AreEquivalent(variable.Type, type), "variable");
		if (variable == null)
		{
			TypeUtils.ValidateType(type, "type");
		}
		else if (variable.IsByRef)
		{
			throw Error.VariableMustNotBeByRef(variable, variable.Type, "variable");
		}
		ExpressionUtils.RequiresCanRead(body, "body");
		if (filter != null)
		{
			ExpressionUtils.RequiresCanRead(filter, "filter");
			if (filter.Type != typeof(bool))
			{
				throw Error.ArgumentMustBeBoolean("filter");
			}
		}
		return new CatchBlock(type, variable, body, filter);
	}

	public static ConditionalExpression Condition(Expression test, Expression ifTrue, Expression ifFalse)
	{
		ExpressionUtils.RequiresCanRead(test, "test");
		ExpressionUtils.RequiresCanRead(ifTrue, "ifTrue");
		ExpressionUtils.RequiresCanRead(ifFalse, "ifFalse");
		if (test.Type != typeof(bool))
		{
			throw Error.ArgumentMustBeBoolean("test");
		}
		if (!TypeUtils.AreEquivalent(ifTrue.Type, ifFalse.Type))
		{
			throw Error.ArgumentTypesMustMatch();
		}
		return ConditionalExpression.Make(test, ifTrue, ifFalse, ifTrue.Type);
	}

	public static ConditionalExpression Condition(Expression test, Expression ifTrue, Expression ifFalse, Type type)
	{
		ExpressionUtils.RequiresCanRead(test, "test");
		ExpressionUtils.RequiresCanRead(ifTrue, "ifTrue");
		ExpressionUtils.RequiresCanRead(ifFalse, "ifFalse");
		ContractUtils.RequiresNotNull(type, "type");
		if (test.Type != typeof(bool))
		{
			throw Error.ArgumentMustBeBoolean("test");
		}
		if (type != typeof(void) && (!TypeUtils.AreReferenceAssignable(type, ifTrue.Type) || !TypeUtils.AreReferenceAssignable(type, ifFalse.Type)))
		{
			throw Error.ArgumentTypesMustMatch();
		}
		return ConditionalExpression.Make(test, ifTrue, ifFalse, type);
	}

	public static ConditionalExpression IfThen(Expression test, Expression ifTrue)
	{
		return Condition(test, ifTrue, Empty(), typeof(void));
	}

	public static ConstantExpression Constant(object value)
	{
		return new ConstantExpression(value);
	}

	public static ConstantExpression Constant(object value, Type type)
	{
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		if (value == null)
		{
			if (type == typeof(object))
			{
				return new ConstantExpression(null);
			}
			if (!type.IsValueType || type.IsNullableType())
			{
				return new TypedConstantExpression(null, type);
			}
		}
		else
		{
			Type type2 = value.GetType();
			if (type == type2)
			{
				return new ConstantExpression(value);
			}
			if (type.IsAssignableFrom(type2))
			{
				return new TypedConstantExpression(value, type);
			}
		}
		throw Error.ArgumentTypesMustMatch();
	}

	public static DefaultExpression Empty()
	{
		return new DefaultExpression(typeof(void));
	}

	public static DefaultExpression Default(Type type)
	{
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		return new DefaultExpression(type);
	}

	public virtual Expression Reduce()
	{
		if (CanReduce)
		{
			throw Error.ReducibleMustOverrideReduce();
		}
		return this;
	}

	protected internal virtual Expression VisitChildren(ExpressionVisitor visitor)
	{
		if (!CanReduce)
		{
			throw Error.MustBeReducible();
		}
		return visitor.Visit(ReduceAndCheck());
	}

	protected internal virtual Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitExtension(this);
	}

	public Expression ReduceAndCheck()
	{
		if (!CanReduce)
		{
			throw Error.MustBeReducible();
		}
		Expression expression = Reduce();
		if (expression == null || expression == this)
		{
			throw Error.MustReduceToDifferent();
		}
		if (!TypeUtils.AreReferenceAssignable(Type, expression.Type))
		{
			throw Error.ReducedNotCompatible();
		}
		return expression;
	}

	public override string ToString()
	{
		return ExpressionStringBuilder.ExpressionToString(this);
	}

	private static void RequiresCanRead(IReadOnlyList<Expression> items, string paramName)
	{
		int i = 0;
		for (int count = items.Count; i < count; i++)
		{
			ExpressionUtils.RequiresCanRead(items[i], paramName, i);
		}
	}

	private static void RequiresCanWrite(Expression expression, string paramName)
	{
		if (expression == null)
		{
			throw new ArgumentNullException(paramName);
		}
		switch (expression.NodeType)
		{
		case ExpressionType.Index:
		{
			PropertyInfo indexer = ((IndexExpression)expression).Indexer;
			if (indexer == null || indexer.CanWrite)
			{
				return;
			}
			break;
		}
		case ExpressionType.MemberAccess:
		{
			MemberInfo member = ((MemberExpression)expression).Member;
			PropertyInfo propertyInfo = member as PropertyInfo;
			if (propertyInfo != null)
			{
				if (propertyInfo.CanWrite)
				{
					return;
				}
				break;
			}
			FieldInfo fieldInfo = (FieldInfo)member;
			if (!fieldInfo.IsInitOnly && !fieldInfo.IsLiteral)
			{
				return;
			}
			break;
		}
		case ExpressionType.Parameter:
			return;
		}
		throw Error.ExpressionMustBeWriteable(paramName);
	}

	public static GotoExpression Break(LabelTarget target)
	{
		return MakeGoto(GotoExpressionKind.Break, target, null, typeof(void));
	}

	public static GotoExpression Return(LabelTarget target)
	{
		return MakeGoto(GotoExpressionKind.Return, target, null, typeof(void));
	}

	public static GotoExpression Return(LabelTarget target, Expression value)
	{
		return MakeGoto(GotoExpressionKind.Return, target, value, typeof(void));
	}

	public static GotoExpression Goto(LabelTarget target, Type type)
	{
		return MakeGoto(GotoExpressionKind.Goto, target, null, type);
	}

	public static GotoExpression Goto(LabelTarget target, Expression value)
	{
		return MakeGoto(GotoExpressionKind.Goto, target, value, typeof(void));
	}

	public static GotoExpression MakeGoto(GotoExpressionKind kind, LabelTarget target, Expression value, Type type)
	{
		ValidateGoto(target, ref value, "target", "value", type);
		return new GotoExpression(kind, target, value, type);
	}

	private static void ValidateGoto(LabelTarget target, ref Expression value, string targetParameter, string valueParameter, Type type)
	{
		ContractUtils.RequiresNotNull(target, targetParameter);
		if (value == null)
		{
			if (target.Type != typeof(void))
			{
				throw Error.LabelMustBeVoidOrHaveExpression("target");
			}
			if (type != null)
			{
				TypeUtils.ValidateType(type, "type");
			}
		}
		else
		{
			ValidateGotoType(target.Type, ref value, valueParameter);
		}
	}

	private static void ValidateGotoType(Type expectedType, ref Expression value, string paramName)
	{
		ExpressionUtils.RequiresCanRead(value, paramName);
		if (expectedType != typeof(void) && !TypeUtils.AreReferenceAssignable(expectedType, value.Type) && !TryQuote(expectedType, ref value))
		{
			throw Error.ExpressionTypeDoesNotMatchLabel(value.Type, expectedType);
		}
	}

	public static IndexExpression MakeIndex(Expression instance, PropertyInfo indexer, IEnumerable<Expression> arguments)
	{
		if (indexer != null)
		{
			return Property(instance, indexer, arguments);
		}
		return ArrayAccess(instance, arguments);
	}

	public static IndexExpression ArrayAccess(Expression array, params Expression[] indexes)
	{
		return ArrayAccess(array, (IEnumerable<Expression>)indexes);
	}

	public static IndexExpression ArrayAccess(Expression array, IEnumerable<Expression> indexes)
	{
		ExpressionUtils.RequiresCanRead(array, "array");
		Type type = array.Type;
		if (!type.IsArray)
		{
			throw Error.ArgumentMustBeArray("array");
		}
		ReadOnlyCollection<Expression> readOnlyCollection = indexes.ToReadOnly();
		if (type.GetArrayRank() != readOnlyCollection.Count)
		{
			throw Error.IncorrectNumberOfIndexes();
		}
		foreach (Expression item in readOnlyCollection)
		{
			ExpressionUtils.RequiresCanRead(item, "indexes");
			if (item.Type != typeof(int))
			{
				throw Error.ArgumentMustBeArrayIndexType("indexes");
			}
		}
		return new IndexExpression(array, null, readOnlyCollection);
	}

	public static IndexExpression Property(Expression instance, PropertyInfo indexer, IEnumerable<Expression> arguments)
	{
		return MakeIndexProperty(instance, indexer, "indexer", arguments.ToReadOnly());
	}

	private static IndexExpression MakeIndexProperty(Expression instance, PropertyInfo indexer, string paramName, ReadOnlyCollection<Expression> argList)
	{
		ValidateIndexedProperty(instance, indexer, paramName, ref argList);
		return new IndexExpression(instance, indexer, argList);
	}

	private static void ValidateIndexedProperty(Expression instance, PropertyInfo indexer, string paramName, ref ReadOnlyCollection<Expression> argList)
	{
		ContractUtils.RequiresNotNull(indexer, paramName);
		if (indexer.PropertyType.IsByRef)
		{
			throw Error.PropertyCannotHaveRefType(paramName);
		}
		if (indexer.PropertyType == typeof(void))
		{
			throw Error.PropertyTypeCannotBeVoid(paramName);
		}
		ParameterInfo[] array = null;
		MethodInfo getMethod = indexer.GetGetMethod(nonPublic: true);
		if (getMethod != null)
		{
			if (getMethod.ReturnType != indexer.PropertyType)
			{
				throw Error.PropertyTypeMustMatchGetter(paramName);
			}
			array = getMethod.GetParametersCached();
			ValidateAccessor(instance, getMethod, array, ref argList, paramName);
		}
		MethodInfo setMethod = indexer.GetSetMethod(nonPublic: true);
		if (setMethod != null)
		{
			ParameterInfo[] parametersCached = setMethod.GetParametersCached();
			if (parametersCached.Length == 0)
			{
				throw Error.SetterHasNoParams(paramName);
			}
			Type parameterType = parametersCached[parametersCached.Length - 1].ParameterType;
			if (parameterType.IsByRef)
			{
				throw Error.PropertyCannotHaveRefType(paramName);
			}
			if (setMethod.ReturnType != typeof(void))
			{
				throw Error.SetterMustBeVoid(paramName);
			}
			if (indexer.PropertyType != parameterType)
			{
				throw Error.PropertyTypeMustMatchSetter(paramName);
			}
			if (getMethod != null)
			{
				if (getMethod.IsStatic ^ setMethod.IsStatic)
				{
					throw Error.BothAccessorsMustBeStatic(paramName);
				}
				if (array.Length != parametersCached.Length - 1)
				{
					throw Error.IndexesOfSetGetMustMatch(paramName);
				}
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i].ParameterType != parametersCached[i].ParameterType)
					{
						throw Error.IndexesOfSetGetMustMatch(paramName);
					}
				}
			}
			else
			{
				ValidateAccessor(instance, setMethod, parametersCached.RemoveLast(), ref argList, paramName);
			}
		}
		else if (getMethod == null)
		{
			throw Error.PropertyDoesNotHaveAccessor(indexer, paramName);
		}
	}

	private static void ValidateAccessor(Expression instance, MethodInfo method, ParameterInfo[] indexes, ref ReadOnlyCollection<Expression> arguments, string paramName)
	{
		ContractUtils.RequiresNotNull(arguments, "arguments");
		ValidateMethodInfo(method, "method");
		if ((method.CallingConvention & CallingConventions.VarArgs) != 0)
		{
			throw Error.AccessorsCannotHaveVarArgs(paramName);
		}
		if (method.IsStatic)
		{
			if (instance != null)
			{
				throw Error.OnlyStaticPropertiesHaveNullInstance("instance");
			}
		}
		else
		{
			if (instance == null)
			{
				throw Error.OnlyStaticPropertiesHaveNullInstance("instance");
			}
			ExpressionUtils.RequiresCanRead(instance, "instance");
			ValidateCallInstanceType(instance.Type, method);
		}
		ValidateAccessorArgumentTypes(method, indexes, ref arguments, paramName);
	}

	private static void ValidateAccessorArgumentTypes(MethodInfo method, ParameterInfo[] indexes, ref ReadOnlyCollection<Expression> arguments, string paramName)
	{
		if (indexes.Length != 0)
		{
			if (indexes.Length != arguments.Count)
			{
				throw Error.IncorrectNumberOfMethodCallArguments(method, paramName);
			}
			Expression[] array = null;
			int i = 0;
			for (int num = indexes.Length; i < num; i++)
			{
				Expression argument = arguments[i];
				ParameterInfo obj = indexes[i];
				ExpressionUtils.RequiresCanRead(argument, "arguments", i);
				Type parameterType = obj.ParameterType;
				if (parameterType.IsByRef)
				{
					throw Error.AccessorsCannotHaveByRefArgs("indexes", i);
				}
				TypeUtils.ValidateType(parameterType, "indexes", i);
				if (!TypeUtils.AreReferenceAssignable(parameterType, argument.Type) && !TryQuote(parameterType, ref argument))
				{
					throw Error.ExpressionTypeDoesNotMatchMethodParameter(argument.Type, parameterType, method, "arguments", i);
				}
				if (array == null && argument != arguments[i])
				{
					array = new Expression[arguments.Count];
					for (int j = 0; j < i; j++)
					{
						array[j] = arguments[j];
					}
				}
				if (array != null)
				{
					array[i] = argument;
				}
			}
			if (array != null)
			{
				arguments = new TrueReadOnlyCollection<Expression>(array);
			}
		}
		else if (arguments.Count > 0)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(method, paramName);
		}
	}

	internal static InvocationExpression Invoke(Expression expression)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		MethodInfo invokeMethod = GetInvokeMethod(expression);
		ParameterInfo[] parametersForValidation = GetParametersForValidation(invokeMethod, ExpressionType.Invoke);
		ValidateArgumentCount(invokeMethod, ExpressionType.Invoke, 0, parametersForValidation);
		return new InvocationExpression0(expression, invokeMethod.ReturnType);
	}

	internal static InvocationExpression Invoke(Expression expression, Expression arg0)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		MethodInfo invokeMethod = GetInvokeMethod(expression);
		ParameterInfo[] parametersForValidation = GetParametersForValidation(invokeMethod, ExpressionType.Invoke);
		ValidateArgumentCount(invokeMethod, ExpressionType.Invoke, 1, parametersForValidation);
		arg0 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg0, parametersForValidation[0], "expression", "arg0");
		return new InvocationExpression1(expression, invokeMethod.ReturnType, arg0);
	}

	internal static InvocationExpression Invoke(Expression expression, Expression arg0, Expression arg1)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		MethodInfo invokeMethod = GetInvokeMethod(expression);
		ParameterInfo[] parametersForValidation = GetParametersForValidation(invokeMethod, ExpressionType.Invoke);
		ValidateArgumentCount(invokeMethod, ExpressionType.Invoke, 2, parametersForValidation);
		arg0 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg0, parametersForValidation[0], "expression", "arg0");
		arg1 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg1, parametersForValidation[1], "expression", "arg1");
		return new InvocationExpression2(expression, invokeMethod.ReturnType, arg0, arg1);
	}

	internal static InvocationExpression Invoke(Expression expression, Expression arg0, Expression arg1, Expression arg2)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		MethodInfo invokeMethod = GetInvokeMethod(expression);
		ParameterInfo[] parametersForValidation = GetParametersForValidation(invokeMethod, ExpressionType.Invoke);
		ValidateArgumentCount(invokeMethod, ExpressionType.Invoke, 3, parametersForValidation);
		arg0 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg0, parametersForValidation[0], "expression", "arg0");
		arg1 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg1, parametersForValidation[1], "expression", "arg1");
		arg2 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg2, parametersForValidation[2], "expression", "arg2");
		return new InvocationExpression3(expression, invokeMethod.ReturnType, arg0, arg1, arg2);
	}

	internal static InvocationExpression Invoke(Expression expression, Expression arg0, Expression arg1, Expression arg2, Expression arg3)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		MethodInfo invokeMethod = GetInvokeMethod(expression);
		ParameterInfo[] parametersForValidation = GetParametersForValidation(invokeMethod, ExpressionType.Invoke);
		ValidateArgumentCount(invokeMethod, ExpressionType.Invoke, 4, parametersForValidation);
		arg0 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg0, parametersForValidation[0], "expression", "arg0");
		arg1 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg1, parametersForValidation[1], "expression", "arg1");
		arg2 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg2, parametersForValidation[2], "expression", "arg2");
		arg3 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg3, parametersForValidation[3], "expression", "arg3");
		return new InvocationExpression4(expression, invokeMethod.ReturnType, arg0, arg1, arg2, arg3);
	}

	internal static InvocationExpression Invoke(Expression expression, Expression arg0, Expression arg1, Expression arg2, Expression arg3, Expression arg4)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		MethodInfo invokeMethod = GetInvokeMethod(expression);
		ParameterInfo[] parametersForValidation = GetParametersForValidation(invokeMethod, ExpressionType.Invoke);
		ValidateArgumentCount(invokeMethod, ExpressionType.Invoke, 5, parametersForValidation);
		arg0 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg0, parametersForValidation[0], "expression", "arg0");
		arg1 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg1, parametersForValidation[1], "expression", "arg1");
		arg2 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg2, parametersForValidation[2], "expression", "arg2");
		arg3 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg3, parametersForValidation[3], "expression", "arg3");
		arg4 = ValidateOneArgument(invokeMethod, ExpressionType.Invoke, arg4, parametersForValidation[4], "expression", "arg4");
		return new InvocationExpression5(expression, invokeMethod.ReturnType, arg0, arg1, arg2, arg3, arg4);
	}

	public static InvocationExpression Invoke(Expression expression, IEnumerable<Expression> arguments)
	{
		IReadOnlyList<Expression> readOnlyList = (arguments as IReadOnlyList<Expression>) ?? arguments.ToReadOnly();
		switch (readOnlyList.Count)
		{
		case 0:
			return Invoke(expression);
		case 1:
			return Invoke(expression, readOnlyList[0]);
		case 2:
			return Invoke(expression, readOnlyList[0], readOnlyList[1]);
		case 3:
			return Invoke(expression, readOnlyList[0], readOnlyList[1], readOnlyList[2]);
		case 4:
			return Invoke(expression, readOnlyList[0], readOnlyList[1], readOnlyList[2], readOnlyList[3]);
		case 5:
			return Invoke(expression, readOnlyList[0], readOnlyList[1], readOnlyList[2], readOnlyList[3], readOnlyList[4]);
		default:
		{
			ExpressionUtils.RequiresCanRead(expression, "expression");
			ReadOnlyCollection<Expression> arguments2 = readOnlyList.ToReadOnly();
			MethodInfo invokeMethod = GetInvokeMethod(expression);
			ValidateArgumentTypes(invokeMethod, ExpressionType.Invoke, ref arguments2, "expression");
			return new InvocationExpressionN(expression, arguments2, invokeMethod.ReturnType);
		}
		}
	}

	internal static MethodInfo GetInvokeMethod(Expression expression)
	{
		Type delegateType = expression.Type;
		if (!expression.Type.IsSubclassOf(typeof(MulticastDelegate)))
		{
			Type type = TypeUtils.FindGenericType(typeof(Expression<>), expression.Type);
			if (type == null)
			{
				throw Error.ExpressionTypeNotInvocable(expression.Type, "expression");
			}
			delegateType = type.GetGenericArguments()[0];
		}
		return delegateType.GetInvokeMethod();
	}

	public static LabelExpression Label(LabelTarget target)
	{
		return Label(target, null);
	}

	public static LabelExpression Label(LabelTarget target, Expression defaultValue)
	{
		ValidateGoto(target, ref defaultValue, "target", "defaultValue", null);
		return new LabelExpression(target, defaultValue);
	}

	public static LabelTarget Label()
	{
		return Label(typeof(void), null);
	}

	public static LabelTarget Label(string name)
	{
		return Label(typeof(void), name);
	}

	public static LabelTarget Label(Type type)
	{
		return Label(type, null);
	}

	public static LabelTarget Label(Type type, string name)
	{
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		return new LabelTarget(type, name);
	}

	internal static LambdaExpression CreateLambda(Type delegateType, Expression body, string name, bool tailCall, ReadOnlyCollection<ParameterExpression> parameters)
	{
		CacheDict<Type, Func<Expression, string, bool, ReadOnlyCollection<ParameterExpression>, LambdaExpression>> cacheDict = s_lambdaFactories;
		if (cacheDict == null)
		{
			cacheDict = (s_lambdaFactories = new CacheDict<Type, Func<Expression, string, bool, ReadOnlyCollection<ParameterExpression>, LambdaExpression>>(50));
		}
		if (!cacheDict.TryGetValue(delegateType, out var value))
		{
			MethodInfo method = typeof(ExpressionCreator<>).MakeGenericType(delegateType).GetMethod("CreateExpressionFunc", BindingFlags.Static | BindingFlags.Public);
			if (delegateType.IsCollectible)
			{
				return (LambdaExpression)method.Invoke(null, new object[4] { body, name, tailCall, parameters });
			}
			value = (cacheDict[delegateType] = (Func<Expression, string, bool, ReadOnlyCollection<ParameterExpression>, LambdaExpression>)method.CreateDelegate(typeof(Func<Expression, string, bool, ReadOnlyCollection<ParameterExpression>, LambdaExpression>)));
		}
		return value(body, name, tailCall, parameters);
	}

	public static Expression<TDelegate> Lambda<TDelegate>(Expression body, params ParameterExpression[] parameters)
	{
		return Lambda<TDelegate>(body, tailCall: false, parameters);
	}

	public static Expression<TDelegate> Lambda<TDelegate>(Expression body, IEnumerable<ParameterExpression> parameters)
	{
		return Lambda<TDelegate>(body, null, tailCall: false, parameters);
	}

	public static Expression<TDelegate> Lambda<TDelegate>(Expression body, bool tailCall, IEnumerable<ParameterExpression> parameters)
	{
		return Lambda<TDelegate>(body, null, tailCall, parameters);
	}

	public static Expression<TDelegate> Lambda<TDelegate>(Expression body, string name, bool tailCall, IEnumerable<ParameterExpression> parameters)
	{
		ReadOnlyCollection<ParameterExpression> parameters2 = parameters.ToReadOnly();
		ValidateLambdaArgs(typeof(TDelegate), ref body, parameters2, "TDelegate");
		return (Expression<TDelegate>)CreateLambda(typeof(TDelegate), body, name, tailCall, parameters2);
	}

	public static LambdaExpression Lambda(Type delegateType, Expression body, params ParameterExpression[] parameters)
	{
		return Lambda(delegateType, body, null, tailCall: false, parameters);
	}

	public static LambdaExpression Lambda(Type delegateType, Expression body, string name, bool tailCall, IEnumerable<ParameterExpression> parameters)
	{
		ReadOnlyCollection<ParameterExpression> parameters2 = parameters.ToReadOnly();
		ValidateLambdaArgs(delegateType, ref body, parameters2, "delegateType");
		return CreateLambda(delegateType, body, name, tailCall, parameters2);
	}

	private static void ValidateLambdaArgs(Type delegateType, ref Expression body, ReadOnlyCollection<ParameterExpression> parameters, string paramName)
	{
		ContractUtils.RequiresNotNull(delegateType, "delegateType");
		ExpressionUtils.RequiresCanRead(body, "body");
		if (!typeof(MulticastDelegate).IsAssignableFrom(delegateType) || delegateType == typeof(MulticastDelegate))
		{
			throw Error.LambdaTypeMustBeDerivedFromSystemDelegate(paramName);
		}
		TypeUtils.ValidateType(delegateType, "delegateType", allowByRef: true, allowPointer: true);
		CacheDict<Type, MethodInfo> cacheDict = s_lambdaDelegateCache;
		if (!cacheDict.TryGetValue(delegateType, out var value))
		{
			value = delegateType.GetInvokeMethod();
			if (!delegateType.IsCollectible)
			{
				cacheDict[delegateType] = value;
			}
		}
		ParameterInfo[] parametersCached = value.GetParametersCached();
		if (parametersCached.Length != 0)
		{
			if (parametersCached.Length != parameters.Count)
			{
				throw Error.IncorrectNumberOfLambdaDeclarationParameters();
			}
			HashSet<ParameterExpression> hashSet = new HashSet<ParameterExpression>();
			int i = 0;
			for (int num = parametersCached.Length; i < num; i++)
			{
				ParameterExpression parameterExpression = parameters[i];
				ParameterInfo obj = parametersCached[i];
				ExpressionUtils.RequiresCanRead(parameterExpression, "parameters", i);
				Type type = obj.ParameterType;
				if (parameterExpression.IsByRef)
				{
					if (!type.IsByRef)
					{
						throw Error.ParameterExpressionNotValidAsDelegate(parameterExpression.Type.MakeByRefType(), type);
					}
					type = type.GetElementType();
				}
				if (!TypeUtils.AreReferenceAssignable(parameterExpression.Type, type))
				{
					throw Error.ParameterExpressionNotValidAsDelegate(parameterExpression.Type, type);
				}
				if (!hashSet.Add(parameterExpression))
				{
					throw Error.DuplicateVariable(parameterExpression, "parameters", i);
				}
			}
		}
		else if (parameters.Count > 0)
		{
			throw Error.IncorrectNumberOfLambdaDeclarationParameters();
		}
		if (value.ReturnType != typeof(void) && !TypeUtils.AreReferenceAssignable(value.ReturnType, body.Type) && !TryQuote(value.ReturnType, ref body))
		{
			throw Error.ExpressionTypeDoesNotMatchReturn(body.Type, value.ReturnType);
		}
	}

	public static LoopExpression Loop(Expression body, LabelTarget @break, LabelTarget @continue)
	{
		ExpressionUtils.RequiresCanRead(body, "body");
		if (@continue != null && @continue.Type != typeof(void))
		{
			throw Error.LabelTypeMustBeVoid("continue");
		}
		return new LoopExpression(body, @break, @continue);
	}

	public static MemberExpression Field(Expression expression, FieldInfo field)
	{
		ContractUtils.RequiresNotNull(field, "field");
		if (field.IsStatic)
		{
			if (expression != null)
			{
				throw Error.OnlyStaticFieldsHaveNullInstance("expression");
			}
		}
		else
		{
			if (expression == null)
			{
				throw Error.OnlyStaticFieldsHaveNullInstance("field");
			}
			ExpressionUtils.RequiresCanRead(expression, "expression");
			if (!TypeUtils.AreReferenceAssignable(field.DeclaringType, expression.Type))
			{
				throw Error.FieldInfoNotDefinedForType(field.DeclaringType, field.Name, expression.Type);
			}
		}
		return MemberExpression.Make(expression, field);
	}

	public static MemberExpression Field(Expression expression, string fieldName)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(fieldName, "fieldName");
		FieldInfo fieldInfo = expression.Type.GetField(fieldName, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public | BindingFlags.FlattenHierarchy) ?? expression.Type.GetField(fieldName, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
		if (fieldInfo == null)
		{
			throw Error.InstanceFieldNotDefinedForType(fieldName, expression.Type);
		}
		return Field(expression, fieldInfo);
	}

	public static MemberExpression Property(Expression expression, string propertyName)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(propertyName, "propertyName");
		PropertyInfo propertyInfo = expression.Type.GetProperty(propertyName, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public | BindingFlags.FlattenHierarchy) ?? expression.Type.GetProperty(propertyName, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
		if (propertyInfo == null)
		{
			throw Error.InstancePropertyNotDefinedForType(propertyName, expression.Type, "propertyName");
		}
		return Property(expression, propertyInfo);
	}

	public static MemberExpression Property(Expression expression, PropertyInfo property)
	{
		ContractUtils.RequiresNotNull(property, "property");
		MethodInfo methodInfo = property.GetGetMethod(nonPublic: true);
		if (methodInfo == null)
		{
			methodInfo = property.GetSetMethod(nonPublic: true);
			if (methodInfo == null)
			{
				throw Error.PropertyDoesNotHaveAccessor(property, "property");
			}
			if (methodInfo.GetParametersCached().Length != 1)
			{
				throw Error.IncorrectNumberOfMethodCallArguments(methodInfo, "property");
			}
		}
		else if (methodInfo.GetParametersCached().Length != 0)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(methodInfo, "property");
		}
		if (methodInfo.IsStatic)
		{
			if (expression != null)
			{
				throw Error.OnlyStaticPropertiesHaveNullInstance("expression");
			}
		}
		else
		{
			if (expression == null)
			{
				throw Error.OnlyStaticPropertiesHaveNullInstance("property");
			}
			ExpressionUtils.RequiresCanRead(expression, "expression");
			if (!TypeUtils.IsValidInstanceType(property, expression.Type))
			{
				throw Error.PropertyNotDefinedForType(property, expression.Type, "property");
			}
		}
		ValidateMethodInfo(methodInfo, "property");
		return MemberExpression.Make(expression, property);
	}

	public static MemberExpression MakeMemberAccess(Expression expression, MemberInfo member)
	{
		ContractUtils.RequiresNotNull(member, "member");
		FieldInfo fieldInfo = member as FieldInfo;
		if (fieldInfo != null)
		{
			return Field(expression, fieldInfo);
		}
		PropertyInfo propertyInfo = member as PropertyInfo;
		if (propertyInfo != null)
		{
			return Property(expression, propertyInfo);
		}
		throw Error.MemberNotFieldOrProperty(member, "member");
	}

	internal static MethodCallExpression Call(MethodInfo method)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ParameterInfo[] pis = ValidateMethodAndGetParameters(null, method);
		ValidateArgumentCount(method, ExpressionType.Call, 0, pis);
		return new MethodCallExpression0(method);
	}

	public static MethodCallExpression Call(MethodInfo method, Expression arg0)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ParameterInfo[] array = ValidateMethodAndGetParameters(null, method);
		ValidateArgumentCount(method, ExpressionType.Call, 1, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		return new MethodCallExpression1(method, arg0);
	}

	public static MethodCallExpression Call(MethodInfo method, Expression arg0, Expression arg1)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ContractUtils.RequiresNotNull(arg1, "arg1");
		ParameterInfo[] array = ValidateMethodAndGetParameters(null, method);
		ValidateArgumentCount(method, ExpressionType.Call, 2, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		arg1 = ValidateOneArgument(method, ExpressionType.Call, arg1, array[1], "method", "arg1");
		return new MethodCallExpression2(method, arg0, arg1);
	}

	public static MethodCallExpression Call(MethodInfo method, Expression arg0, Expression arg1, Expression arg2)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ContractUtils.RequiresNotNull(arg1, "arg1");
		ContractUtils.RequiresNotNull(arg2, "arg2");
		ParameterInfo[] array = ValidateMethodAndGetParameters(null, method);
		ValidateArgumentCount(method, ExpressionType.Call, 3, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		arg1 = ValidateOneArgument(method, ExpressionType.Call, arg1, array[1], "method", "arg1");
		arg2 = ValidateOneArgument(method, ExpressionType.Call, arg2, array[2], "method", "arg2");
		return new MethodCallExpression3(method, arg0, arg1, arg2);
	}

	public static MethodCallExpression Call(MethodInfo method, Expression arg0, Expression arg1, Expression arg2, Expression arg3)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ContractUtils.RequiresNotNull(arg1, "arg1");
		ContractUtils.RequiresNotNull(arg2, "arg2");
		ContractUtils.RequiresNotNull(arg3, "arg3");
		ParameterInfo[] array = ValidateMethodAndGetParameters(null, method);
		ValidateArgumentCount(method, ExpressionType.Call, 4, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		arg1 = ValidateOneArgument(method, ExpressionType.Call, arg1, array[1], "method", "arg1");
		arg2 = ValidateOneArgument(method, ExpressionType.Call, arg2, array[2], "method", "arg2");
		arg3 = ValidateOneArgument(method, ExpressionType.Call, arg3, array[3], "method", "arg3");
		return new MethodCallExpression4(method, arg0, arg1, arg2, arg3);
	}

	public static MethodCallExpression Call(MethodInfo method, Expression arg0, Expression arg1, Expression arg2, Expression arg3, Expression arg4)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ContractUtils.RequiresNotNull(arg1, "arg1");
		ContractUtils.RequiresNotNull(arg2, "arg2");
		ContractUtils.RequiresNotNull(arg3, "arg3");
		ContractUtils.RequiresNotNull(arg4, "arg4");
		ParameterInfo[] array = ValidateMethodAndGetParameters(null, method);
		ValidateArgumentCount(method, ExpressionType.Call, 5, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		arg1 = ValidateOneArgument(method, ExpressionType.Call, arg1, array[1], "method", "arg1");
		arg2 = ValidateOneArgument(method, ExpressionType.Call, arg2, array[2], "method", "arg2");
		arg3 = ValidateOneArgument(method, ExpressionType.Call, arg3, array[3], "method", "arg3");
		arg4 = ValidateOneArgument(method, ExpressionType.Call, arg4, array[4], "method", "arg4");
		return new MethodCallExpression5(method, arg0, arg1, arg2, arg3, arg4);
	}

	public static MethodCallExpression Call(MethodInfo method, params Expression[] arguments)
	{
		return Call(null, method, arguments);
	}

	public static MethodCallExpression Call(MethodInfo method, IEnumerable<Expression> arguments)
	{
		return Call(null, method, arguments);
	}

	public static MethodCallExpression Call(Expression instance, MethodInfo method)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ParameterInfo[] pis = ValidateMethodAndGetParameters(instance, method);
		ValidateArgumentCount(method, ExpressionType.Call, 0, pis);
		if (instance != null)
		{
			return new InstanceMethodCallExpression0(method, instance);
		}
		return new MethodCallExpression0(method);
	}

	public static MethodCallExpression Call(Expression instance, MethodInfo method, params Expression[] arguments)
	{
		return Call(instance, method, (IEnumerable<Expression>)arguments);
	}

	internal static MethodCallExpression Call(Expression instance, MethodInfo method, Expression arg0)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ParameterInfo[] array = ValidateMethodAndGetParameters(instance, method);
		ValidateArgumentCount(method, ExpressionType.Call, 1, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		if (instance != null)
		{
			return new InstanceMethodCallExpression1(method, instance, arg0);
		}
		return new MethodCallExpression1(method, arg0);
	}

	public static MethodCallExpression Call(Expression instance, MethodInfo method, Expression arg0, Expression arg1)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ContractUtils.RequiresNotNull(arg1, "arg1");
		ParameterInfo[] array = ValidateMethodAndGetParameters(instance, method);
		ValidateArgumentCount(method, ExpressionType.Call, 2, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		arg1 = ValidateOneArgument(method, ExpressionType.Call, arg1, array[1], "method", "arg1");
		if (instance != null)
		{
			return new InstanceMethodCallExpression2(method, instance, arg0, arg1);
		}
		return new MethodCallExpression2(method, arg0, arg1);
	}

	public static MethodCallExpression Call(Expression instance, MethodInfo method, Expression arg0, Expression arg1, Expression arg2)
	{
		ContractUtils.RequiresNotNull(method, "method");
		ContractUtils.RequiresNotNull(arg0, "arg0");
		ContractUtils.RequiresNotNull(arg1, "arg1");
		ContractUtils.RequiresNotNull(arg2, "arg2");
		ParameterInfo[] array = ValidateMethodAndGetParameters(instance, method);
		ValidateArgumentCount(method, ExpressionType.Call, 3, array);
		arg0 = ValidateOneArgument(method, ExpressionType.Call, arg0, array[0], "method", "arg0");
		arg1 = ValidateOneArgument(method, ExpressionType.Call, arg1, array[1], "method", "arg1");
		arg2 = ValidateOneArgument(method, ExpressionType.Call, arg2, array[2], "method", "arg2");
		if (instance != null)
		{
			return new InstanceMethodCallExpression3(method, instance, arg0, arg1, arg2);
		}
		return new MethodCallExpression3(method, arg0, arg1, arg2);
	}

	public static MethodCallExpression Call(Expression instance, string methodName, Type[] typeArguments, params Expression[] arguments)
	{
		ContractUtils.RequiresNotNull(instance, "instance");
		ContractUtils.RequiresNotNull(methodName, "methodName");
		if (arguments == null)
		{
			arguments = Array.Empty<Expression>();
		}
		BindingFlags flags = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy;
		return Call(instance, FindMethod(instance.Type, methodName, typeArguments, arguments, flags), arguments);
	}

	public static MethodCallExpression Call(Expression instance, MethodInfo method, IEnumerable<Expression> arguments)
	{
		IReadOnlyList<Expression> readOnlyList = (arguments as IReadOnlyList<Expression>) ?? arguments.ToReadOnly();
		int count = readOnlyList.Count;
		switch (count)
		{
		case 0:
			return Call(instance, method);
		case 1:
			return Call(instance, method, readOnlyList[0]);
		case 2:
			return Call(instance, method, readOnlyList[0], readOnlyList[1]);
		case 3:
			return Call(instance, method, readOnlyList[0], readOnlyList[1], readOnlyList[2]);
		default:
		{
			if (instance == null)
			{
				switch (count)
				{
				case 4:
					return Call(method, readOnlyList[0], readOnlyList[1], readOnlyList[2], readOnlyList[3]);
				case 5:
					return Call(method, readOnlyList[0], readOnlyList[1], readOnlyList[2], readOnlyList[3], readOnlyList[4]);
				}
			}
			ContractUtils.RequiresNotNull(method, "method");
			ReadOnlyCollection<Expression> arguments2 = readOnlyList.ToReadOnly();
			ValidateMethodInfo(method, "method");
			ValidateStaticOrInstanceMethod(instance, method);
			ValidateArgumentTypes(method, ExpressionType.Call, ref arguments2, "method");
			if (instance == null)
			{
				return new MethodCallExpressionN(method, arguments2);
			}
			return new InstanceMethodCallExpressionN(method, instance, arguments2);
		}
		}
	}

	private static ParameterInfo[] ValidateMethodAndGetParameters(Expression instance, MethodInfo method)
	{
		ValidateMethodInfo(method, "method");
		ValidateStaticOrInstanceMethod(instance, method);
		return GetParametersForValidation(method, ExpressionType.Call);
	}

	private static void ValidateStaticOrInstanceMethod(Expression instance, MethodInfo method)
	{
		if (method.IsStatic)
		{
			if (instance != null)
			{
				throw Error.OnlyStaticMethodsHaveNullInstance();
			}
			return;
		}
		if (instance == null)
		{
			throw Error.OnlyStaticMethodsHaveNullInstance();
		}
		ExpressionUtils.RequiresCanRead(instance, "instance");
		ValidateCallInstanceType(instance.Type, method);
	}

	private static void ValidateCallInstanceType(Type instanceType, MethodInfo method)
	{
		if (!TypeUtils.IsValidInstanceType(method, instanceType))
		{
			throw Error.InstanceAndMethodTypeMismatch(method, method.DeclaringType, instanceType);
		}
	}

	private static void ValidateArgumentTypes(MethodBase method, ExpressionType nodeKind, ref ReadOnlyCollection<Expression> arguments, string methodParamName)
	{
		ExpressionUtils.ValidateArgumentTypes(method, nodeKind, ref arguments, methodParamName);
	}

	private static ParameterInfo[] GetParametersForValidation(MethodBase method, ExpressionType nodeKind)
	{
		return ExpressionUtils.GetParametersForValidation(method, nodeKind);
	}

	private static void ValidateArgumentCount(MethodBase method, ExpressionType nodeKind, int count, ParameterInfo[] pis)
	{
		ExpressionUtils.ValidateArgumentCount(method, nodeKind, count, pis);
	}

	private static Expression ValidateOneArgument(MethodBase method, ExpressionType nodeKind, Expression arg, ParameterInfo pi, string methodParamName, string argumentParamName)
	{
		return ExpressionUtils.ValidateOneArgument(method, nodeKind, arg, pi, methodParamName, argumentParamName);
	}

	private static bool TryQuote(Type parameterType, ref Expression argument)
	{
		return ExpressionUtils.TryQuote(parameterType, ref argument);
	}

	private static MethodInfo FindMethod(Type type, string methodName, Type[] typeArgs, Expression[] args, BindingFlags flags)
	{
		int num = 0;
		MethodInfo methodInfo = null;
		MethodInfo[] methods = type.GetMethods(flags);
		foreach (MethodInfo methodInfo2 in methods)
		{
			if (!methodInfo2.Name.Equals(methodName, StringComparison.OrdinalIgnoreCase))
			{
				continue;
			}
			MethodInfo methodInfo3 = ApplyTypeArgs(methodInfo2, typeArgs);
			if (methodInfo3 != null && IsCompatible(methodInfo3, args))
			{
				if (methodInfo == null || (!methodInfo.IsPublic && methodInfo3.IsPublic))
				{
					methodInfo = methodInfo3;
					num = 1;
				}
				else if (methodInfo.IsPublic == methodInfo3.IsPublic)
				{
					num++;
				}
			}
		}
		if (num == 0)
		{
			if (typeArgs != null && typeArgs.Length != 0)
			{
				throw Error.GenericMethodWithArgsDoesNotExistOnType(methodName, type);
			}
			throw Error.MethodWithArgsDoesNotExistOnType(methodName, type);
		}
		if (num > 1)
		{
			throw Error.MethodWithMoreThanOneMatch(methodName, type);
		}
		return methodInfo;
	}

	private static bool IsCompatible(MethodBase m, Expression[] arguments)
	{
		ParameterInfo[] parametersCached = m.GetParametersCached();
		if (parametersCached.Length != arguments.Length)
		{
			return false;
		}
		for (int i = 0; i < arguments.Length; i++)
		{
			Expression expression = arguments[i];
			ContractUtils.RequiresNotNull(expression, "arguments");
			Type type = expression.Type;
			Type type2 = parametersCached[i].ParameterType;
			if (type2.IsByRef)
			{
				type2 = type2.GetElementType();
			}
			if (!TypeUtils.AreReferenceAssignable(type2, type) && (!TypeUtils.IsSameOrSubclass(typeof(LambdaExpression), type2) || !type2.IsAssignableFrom(expression.GetType())))
			{
				return false;
			}
		}
		return true;
	}

	private static MethodInfo ApplyTypeArgs(MethodInfo m, Type[] typeArgs)
	{
		if (typeArgs == null || typeArgs.Length == 0)
		{
			if (!m.IsGenericMethodDefinition)
			{
				return m;
			}
		}
		else if (m.IsGenericMethodDefinition && m.GetGenericArguments().Length == typeArgs.Length)
		{
			return m.MakeGenericMethod(typeArgs);
		}
		return null;
	}

	public static NewArrayExpression NewArrayInit(Type type, params Expression[] initializers)
	{
		return NewArrayInit(type, (IEnumerable<Expression>)initializers);
	}

	public static NewArrayExpression NewArrayInit(Type type, IEnumerable<Expression> initializers)
	{
		ContractUtils.RequiresNotNull(type, "type");
		ContractUtils.RequiresNotNull(initializers, "initializers");
		if (type == typeof(void))
		{
			throw Error.ArgumentCannotBeOfTypeVoid("type");
		}
		TypeUtils.ValidateType(type, "type");
		ReadOnlyCollection<Expression> readOnlyCollection = initializers.ToReadOnly();
		Expression[] array = null;
		int i = 0;
		for (int count = readOnlyCollection.Count; i < count; i++)
		{
			Expression argument = readOnlyCollection[i];
			ExpressionUtils.RequiresCanRead(argument, "initializers", i);
			if (!TypeUtils.AreReferenceAssignable(type, argument.Type))
			{
				if (!TryQuote(type, ref argument))
				{
					throw Error.ExpressionTypeCannotInitializeArrayType(argument.Type, type);
				}
				if (array == null)
				{
					array = new Expression[readOnlyCollection.Count];
					for (int j = 0; j < i; j++)
					{
						array[j] = readOnlyCollection[j];
					}
				}
			}
			if (array != null)
			{
				array[i] = argument;
			}
		}
		if (array != null)
		{
			readOnlyCollection = new TrueReadOnlyCollection<Expression>(array);
		}
		return NewArrayExpression.Make(ExpressionType.NewArrayInit, type.MakeArrayType(), readOnlyCollection);
	}

	public static NewArrayExpression NewArrayBounds(Type type, IEnumerable<Expression> bounds)
	{
		ContractUtils.RequiresNotNull(type, "type");
		ContractUtils.RequiresNotNull(bounds, "bounds");
		if (type == typeof(void))
		{
			throw Error.ArgumentCannotBeOfTypeVoid("type");
		}
		TypeUtils.ValidateType(type, "type");
		ReadOnlyCollection<Expression> readOnlyCollection = bounds.ToReadOnly();
		int count = readOnlyCollection.Count;
		if (count <= 0)
		{
			throw Error.BoundsCannotBeLessThanOne("bounds");
		}
		for (int i = 0; i < count; i++)
		{
			Expression expression = readOnlyCollection[i];
			ExpressionUtils.RequiresCanRead(expression, "bounds", i);
			if (!expression.Type.IsInteger())
			{
				throw Error.ArgumentMustBeInteger("bounds", i);
			}
		}
		Type type2 = ((count != 1) ? type.MakeArrayType(count) : type.MakeArrayType());
		return NewArrayExpression.Make(ExpressionType.NewArrayBounds, type2, readOnlyCollection);
	}

	public static ParameterExpression Parameter(Type type)
	{
		return Parameter(type, null);
	}

	public static ParameterExpression Parameter(Type type, string name)
	{
		Validate(type, allowByRef: true);
		bool isByRef = type.IsByRef;
		if (isByRef)
		{
			type = type.GetElementType();
		}
		return ParameterExpression.Make(type, name, isByRef);
	}

	public static ParameterExpression Variable(Type type, string name)
	{
		Validate(type, allowByRef: false);
		return ParameterExpression.Make(type, name, isByRef: false);
	}

	private static void Validate(Type type, bool allowByRef)
	{
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type", allowByRef, allowPointer: false);
		if (type == typeof(void))
		{
			throw Error.ArgumentCannotBeOfTypeVoid("type");
		}
	}

	public static TryExpression TryFinally(Expression body, Expression @finally)
	{
		return MakeTry(null, body, @finally, null, null);
	}

	public static TryExpression MakeTry(Type type, Expression body, Expression @finally, Expression fault, IEnumerable<CatchBlock> handlers)
	{
		ExpressionUtils.RequiresCanRead(body, "body");
		ReadOnlyCollection<CatchBlock> readOnlyCollection = handlers.ToReadOnly();
		ContractUtils.RequiresNotNullItems(readOnlyCollection, "handlers");
		ValidateTryAndCatchHaveSameType(type, body, readOnlyCollection);
		if (fault != null)
		{
			if (@finally != null || readOnlyCollection.Count > 0)
			{
				throw Error.FaultCannotHaveCatchOrFinally("fault");
			}
			ExpressionUtils.RequiresCanRead(fault, "fault");
		}
		else if (@finally != null)
		{
			ExpressionUtils.RequiresCanRead(@finally, "finally");
		}
		else if (readOnlyCollection.Count == 0)
		{
			throw Error.TryMustHaveCatchFinallyOrFault();
		}
		return new TryExpression(type ?? body.Type, body, @finally, fault, readOnlyCollection);
	}

	private static void ValidateTryAndCatchHaveSameType(Type type, Expression tryBody, ReadOnlyCollection<CatchBlock> handlers)
	{
		if (type != null)
		{
			if (!(type != typeof(void)))
			{
				return;
			}
			if (!TypeUtils.AreReferenceAssignable(type, tryBody.Type))
			{
				throw Error.ArgumentTypesMustMatch();
			}
			{
				foreach (CatchBlock handler in handlers)
				{
					if (!TypeUtils.AreReferenceAssignable(type, handler.Body.Type))
					{
						throw Error.ArgumentTypesMustMatch();
					}
				}
				return;
			}
		}
		if (tryBody.Type == typeof(void))
		{
			foreach (CatchBlock handler2 in handlers)
			{
				if (handler2.Body.Type != typeof(void))
				{
					throw Error.BodyOfCatchMustHaveSameTypeAsBodyOfTry();
				}
			}
			return;
		}
		type = tryBody.Type;
		foreach (CatchBlock handler3 in handlers)
		{
			if (!TypeUtils.AreEquivalent(handler3.Body.Type, type))
			{
				throw Error.BodyOfCatchMustHaveSameTypeAsBodyOfTry();
			}
		}
	}

	public static TypeBinaryExpression TypeIs(Expression expression, Type type)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(type, "type");
		if (type.IsByRef)
		{
			throw Error.TypeMustNotBeByRef("type");
		}
		return new TypeBinaryExpression(expression, type, ExpressionType.TypeIs);
	}

	public static TypeBinaryExpression TypeEqual(Expression expression, Type type)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(type, "type");
		if (type.IsByRef)
		{
			throw Error.TypeMustNotBeByRef("type");
		}
		return new TypeBinaryExpression(expression, type, ExpressionType.TypeEqual);
	}

	public static UnaryExpression MakeUnary(ExpressionType unaryType, Expression operand, Type type, MethodInfo method)
	{
		return unaryType switch
		{
			ExpressionType.Negate => Negate(operand, method), 
			ExpressionType.NegateChecked => NegateChecked(operand, method), 
			ExpressionType.Not => Not(operand, method), 
			ExpressionType.IsFalse => IsFalse(operand, method), 
			ExpressionType.IsTrue => IsTrue(operand, method), 
			ExpressionType.OnesComplement => OnesComplement(operand, method), 
			ExpressionType.ArrayLength => ArrayLength(operand), 
			ExpressionType.Convert => Convert(operand, type, method), 
			ExpressionType.ConvertChecked => ConvertChecked(operand, type, method), 
			ExpressionType.Throw => Throw(operand, type), 
			ExpressionType.TypeAs => TypeAs(operand, type), 
			ExpressionType.Quote => Quote(operand), 
			ExpressionType.UnaryPlus => UnaryPlus(operand, method), 
			ExpressionType.Unbox => Unbox(operand, type), 
			ExpressionType.Increment => Increment(operand, method), 
			ExpressionType.Decrement => Decrement(operand, method), 
			ExpressionType.PreIncrementAssign => PreIncrementAssign(operand, method), 
			ExpressionType.PostIncrementAssign => PostIncrementAssign(operand, method), 
			ExpressionType.PreDecrementAssign => PreDecrementAssign(operand, method), 
			ExpressionType.PostDecrementAssign => PostDecrementAssign(operand, method), 
			_ => throw Error.UnhandledUnary(unaryType, "unaryType"), 
		};
	}

	private static UnaryExpression GetUserDefinedUnaryOperatorOrThrow(ExpressionType unaryType, string name, Expression operand)
	{
		UnaryExpression userDefinedUnaryOperator = GetUserDefinedUnaryOperator(unaryType, name, operand);
		if (userDefinedUnaryOperator != null)
		{
			ValidateParamswithOperandsOrThrow(userDefinedUnaryOperator.Method.GetParametersCached()[0].ParameterType, operand.Type, unaryType, name);
			return userDefinedUnaryOperator;
		}
		throw Error.UnaryOperatorNotDefined(unaryType, operand.Type);
	}

	private static UnaryExpression GetUserDefinedUnaryOperator(ExpressionType unaryType, string name, Expression operand)
	{
		Type type = operand.Type;
		Type[] array = new Type[1] { type };
		Type nonNullableType = type.GetNonNullableType();
		MethodInfo anyStaticMethodValidated = nonNullableType.GetAnyStaticMethodValidated(name, array);
		if (anyStaticMethodValidated != null)
		{
			return new UnaryExpression(unaryType, operand, anyStaticMethodValidated.ReturnType, anyStaticMethodValidated);
		}
		if (type.IsNullableType())
		{
			array[0] = nonNullableType;
			anyStaticMethodValidated = nonNullableType.GetAnyStaticMethodValidated(name, array);
			if (anyStaticMethodValidated != null && anyStaticMethodValidated.ReturnType.IsValueType && !anyStaticMethodValidated.ReturnType.IsNullableType())
			{
				return new UnaryExpression(unaryType, operand, anyStaticMethodValidated.ReturnType.GetNullableType(), anyStaticMethodValidated);
			}
		}
		return null;
	}

	private static UnaryExpression GetMethodBasedUnaryOperator(ExpressionType unaryType, Expression operand, MethodInfo method)
	{
		ValidateOperator(method);
		ParameterInfo[] parametersCached = method.GetParametersCached();
		if (parametersCached.Length != 1)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(method, "method");
		}
		if (ParameterIsAssignable(parametersCached[0], operand.Type))
		{
			ValidateParamswithOperandsOrThrow(parametersCached[0].ParameterType, operand.Type, unaryType, method.Name);
			return new UnaryExpression(unaryType, operand, method.ReturnType, method);
		}
		if (operand.Type.IsNullableType() && ParameterIsAssignable(parametersCached[0], operand.Type.GetNonNullableType()) && method.ReturnType.IsValueType && !method.ReturnType.IsNullableType())
		{
			return new UnaryExpression(unaryType, operand, method.ReturnType.GetNullableType(), method);
		}
		throw Error.OperandTypesDoNotMatchParameters(unaryType, method.Name);
	}

	private static UnaryExpression GetUserDefinedCoercionOrThrow(ExpressionType coercionType, Expression expression, Type convertToType)
	{
		UnaryExpression userDefinedCoercion = GetUserDefinedCoercion(coercionType, expression, convertToType);
		if (userDefinedCoercion != null)
		{
			return userDefinedCoercion;
		}
		throw Error.CoercionOperatorNotDefined(expression.Type, convertToType);
	}

	private static UnaryExpression GetUserDefinedCoercion(ExpressionType coercionType, Expression expression, Type convertToType)
	{
		MethodInfo userDefinedCoercionMethod = TypeUtils.GetUserDefinedCoercionMethod(expression.Type, convertToType);
		if (userDefinedCoercionMethod != null)
		{
			return new UnaryExpression(coercionType, expression, convertToType, userDefinedCoercionMethod);
		}
		return null;
	}

	private static UnaryExpression GetMethodBasedCoercionOperator(ExpressionType unaryType, Expression operand, Type convertToType, MethodInfo method)
	{
		ValidateOperator(method);
		ParameterInfo[] parametersCached = method.GetParametersCached();
		if (parametersCached.Length != 1)
		{
			throw Error.IncorrectNumberOfMethodCallArguments(method, "method");
		}
		if (ParameterIsAssignable(parametersCached[0], operand.Type) && TypeUtils.AreEquivalent(method.ReturnType, convertToType))
		{
			return new UnaryExpression(unaryType, operand, method.ReturnType, method);
		}
		if ((operand.Type.IsNullableType() || convertToType.IsNullableType()) && ParameterIsAssignable(parametersCached[0], operand.Type.GetNonNullableType()) && (TypeUtils.AreEquivalent(method.ReturnType, convertToType.GetNonNullableType()) || TypeUtils.AreEquivalent(method.ReturnType, convertToType)))
		{
			return new UnaryExpression(unaryType, operand, convertToType, method);
		}
		throw Error.OperandTypesDoNotMatchParameters(unaryType, method.Name);
	}

	public static UnaryExpression Negate(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsArithmetic() && !expression.Type.IsUnsignedInt())
			{
				return new UnaryExpression(ExpressionType.Negate, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.Negate, "op_UnaryNegation", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.Negate, expression, method);
	}

	public static UnaryExpression UnaryPlus(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsArithmetic())
			{
				return new UnaryExpression(ExpressionType.UnaryPlus, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.UnaryPlus, "op_UnaryPlus", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.UnaryPlus, expression, method);
	}

	public static UnaryExpression NegateChecked(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsArithmetic() && !expression.Type.IsUnsignedInt())
			{
				return new UnaryExpression(ExpressionType.NegateChecked, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.NegateChecked, "op_UnaryNegation", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.NegateChecked, expression, method);
	}

	public static UnaryExpression Not(Expression expression)
	{
		return Not(expression, null);
	}

	public static UnaryExpression Not(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsIntegerOrBool())
			{
				return new UnaryExpression(ExpressionType.Not, expression, expression.Type, null);
			}
			UnaryExpression userDefinedUnaryOperator = GetUserDefinedUnaryOperator(ExpressionType.Not, "op_LogicalNot", expression);
			if (userDefinedUnaryOperator != null)
			{
				return userDefinedUnaryOperator;
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.Not, "op_OnesComplement", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.Not, expression, method);
	}

	public static UnaryExpression IsFalse(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsBool())
			{
				return new UnaryExpression(ExpressionType.IsFalse, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.IsFalse, "op_False", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.IsFalse, expression, method);
	}

	public static UnaryExpression IsTrue(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsBool())
			{
				return new UnaryExpression(ExpressionType.IsTrue, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.IsTrue, "op_True", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.IsTrue, expression, method);
	}

	public static UnaryExpression OnesComplement(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsInteger())
			{
				return new UnaryExpression(ExpressionType.OnesComplement, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.OnesComplement, "op_OnesComplement", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.OnesComplement, expression, method);
	}

	public static UnaryExpression TypeAs(Expression expression, Type type)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		if (type.IsValueType && !type.IsNullableType())
		{
			throw Error.IncorrectTypeForTypeAs(type, "type");
		}
		return new UnaryExpression(ExpressionType.TypeAs, expression, type, null);
	}

	public static UnaryExpression Unbox(Expression expression, Type type)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(type, "type");
		if (!expression.Type.IsInterface && expression.Type != typeof(object))
		{
			throw Error.InvalidUnboxType("expression");
		}
		if (!type.IsValueType)
		{
			throw Error.InvalidUnboxType("type");
		}
		TypeUtils.ValidateType(type, "type");
		return new UnaryExpression(ExpressionType.Unbox, expression, type, null);
	}

	public static UnaryExpression Convert(Expression expression, Type type)
	{
		return Convert(expression, type, null);
	}

	public static UnaryExpression Convert(Expression expression, Type type, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		if (method == null)
		{
			if (expression.Type.HasIdentityPrimitiveOrNullableConversionTo(type) || expression.Type.HasReferenceConversionTo(type))
			{
				return new UnaryExpression(ExpressionType.Convert, expression, type, null);
			}
			return GetUserDefinedCoercionOrThrow(ExpressionType.Convert, expression, type);
		}
		return GetMethodBasedCoercionOperator(ExpressionType.Convert, expression, type, method);
	}

	public static UnaryExpression ConvertChecked(Expression expression, Type type, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		if (method == null)
		{
			if (expression.Type.HasIdentityPrimitiveOrNullableConversionTo(type))
			{
				return new UnaryExpression(ExpressionType.ConvertChecked, expression, type, null);
			}
			if (expression.Type.HasReferenceConversionTo(type))
			{
				return new UnaryExpression(ExpressionType.Convert, expression, type, null);
			}
			return GetUserDefinedCoercionOrThrow(ExpressionType.ConvertChecked, expression, type);
		}
		return GetMethodBasedCoercionOperator(ExpressionType.ConvertChecked, expression, type, method);
	}

	public static UnaryExpression ArrayLength(Expression array)
	{
		ExpressionUtils.RequiresCanRead(array, "array");
		if (!array.Type.IsSZArray)
		{
			if (!array.Type.IsArray || !typeof(Array).IsAssignableFrom(array.Type))
			{
				throw Error.ArgumentMustBeArray("array");
			}
			throw Error.ArgumentMustBeSingleDimensionalArrayType("array");
		}
		return new UnaryExpression(ExpressionType.ArrayLength, array, typeof(int), null);
	}

	public static UnaryExpression Quote(Expression expression)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (!(expression is LambdaExpression lambdaExpression))
		{
			throw Error.QuotedExpressionMustBeLambda("expression");
		}
		return new UnaryExpression(ExpressionType.Quote, lambdaExpression, lambdaExpression.PublicType, null);
	}

	public static UnaryExpression Throw(Expression value, Type type)
	{
		ContractUtils.RequiresNotNull(type, "type");
		TypeUtils.ValidateType(type, "type");
		if (value != null)
		{
			ExpressionUtils.RequiresCanRead(value, "value");
			if (value.Type.IsValueType)
			{
				throw Error.ArgumentMustNotHaveValueType("value");
			}
		}
		return new UnaryExpression(ExpressionType.Throw, value, type, null);
	}

	public static UnaryExpression Increment(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsArithmetic())
			{
				return new UnaryExpression(ExpressionType.Increment, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.Increment, "op_Increment", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.Increment, expression, method);
	}

	public static UnaryExpression Decrement(Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		if (method == null)
		{
			if (expression.Type.IsArithmetic())
			{
				return new UnaryExpression(ExpressionType.Decrement, expression, expression.Type, null);
			}
			return GetUserDefinedUnaryOperatorOrThrow(ExpressionType.Decrement, "op_Decrement", expression);
		}
		return GetMethodBasedUnaryOperator(ExpressionType.Decrement, expression, method);
	}

	public static UnaryExpression PreIncrementAssign(Expression expression)
	{
		return MakeOpAssignUnary(ExpressionType.PreIncrementAssign, expression, null);
	}

	public static UnaryExpression PreIncrementAssign(Expression expression, MethodInfo method)
	{
		return MakeOpAssignUnary(ExpressionType.PreIncrementAssign, expression, method);
	}

	public static UnaryExpression PreDecrementAssign(Expression expression, MethodInfo method)
	{
		return MakeOpAssignUnary(ExpressionType.PreDecrementAssign, expression, method);
	}

	public static UnaryExpression PostIncrementAssign(Expression expression, MethodInfo method)
	{
		return MakeOpAssignUnary(ExpressionType.PostIncrementAssign, expression, method);
	}

	public static UnaryExpression PostDecrementAssign(Expression expression, MethodInfo method)
	{
		return MakeOpAssignUnary(ExpressionType.PostDecrementAssign, expression, method);
	}

	private static UnaryExpression MakeOpAssignUnary(ExpressionType kind, Expression expression, MethodInfo method)
	{
		ExpressionUtils.RequiresCanRead(expression, "expression");
		RequiresCanWrite(expression, "expression");
		UnaryExpression unaryExpression;
		if (method == null)
		{
			if (expression.Type.IsArithmetic())
			{
				return new UnaryExpression(kind, expression, expression.Type, null);
			}
			string name = ((kind != ExpressionType.PreIncrementAssign && kind != ExpressionType.PostIncrementAssign) ? "op_Decrement" : "op_Increment");
			unaryExpression = GetUserDefinedUnaryOperatorOrThrow(kind, name, expression);
		}
		else
		{
			unaryExpression = GetMethodBasedUnaryOperator(kind, expression, method);
		}
		if (!TypeUtils.AreReferenceAssignable(expression.Type, unaryExpression.Type))
		{
			throw Error.UserDefinedOpMustHaveValidReturnType(kind, method.Name);
		}
		return unaryExpression;
	}
}
public class Expression<TDelegate> : LambdaExpression
{
	internal sealed override Type TypeCore => typeof(TDelegate);

	internal override Type PublicType => typeof(Expression<TDelegate>);

	internal Expression(Expression body)
		: base(body)
	{
	}

	public TDelegate Compile()
	{
		return Compile(preferInterpretation: false);
	}

	public TDelegate Compile(bool preferInterpretation)
	{
		return (TDelegate)(object)new LightCompiler().CompileTop(this).CreateDelegate();
	}

	[ExcludeFromCodeCoverage]
	internal virtual Expression<TDelegate> Rewrite(Expression body, ParameterExpression[] parameters)
	{
		throw ContractUtils.Unreachable;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitLambda(this);
	}
}
