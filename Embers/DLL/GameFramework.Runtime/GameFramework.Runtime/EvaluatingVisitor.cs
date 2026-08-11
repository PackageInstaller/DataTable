using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace GameFramework.Runtime;

internal class EvaluatingVisitor : ExpressionVisitor
{
	private Scope values = new Scope();

	private object BinaryOperate(ExpressionType exprType, TypeCode typeCode, object left, object right)
	{
		switch (exprType)
		{
		case ExpressionType.Add:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left + (sbyte)right;
			case TypeCode.Byte:
				return (byte)left + (byte)right;
			case TypeCode.Int16:
				return (short)left + (short)right;
			case TypeCode.UInt16:
				return (ushort)left + (ushort)right;
			case TypeCode.Int32:
				return (int)left + (int)right;
			case TypeCode.UInt32:
				return (uint)left + (uint)right;
			case TypeCode.Int64:
				return (long)left + (long)right;
			case TypeCode.UInt64:
				return (ulong)left + (ulong)right;
			case TypeCode.Char:
				return (char)left + (char)right;
			case TypeCode.Single:
				return (float)left + (float)right;
			case TypeCode.Double:
				return (double)left + (double)right;
			case TypeCode.Decimal:
				return (decimal)left + (decimal)right;
			}
			break;
		case ExpressionType.AddChecked:
			checked
			{
				switch (typeCode)
				{
				case TypeCode.SByte:
					return (sbyte)left + (sbyte)right;
				case TypeCode.Byte:
					return (byte)left + (byte)right;
				case TypeCode.Int16:
					return (short)left + (short)right;
				case TypeCode.UInt16:
					return (ushort)left + (ushort)right;
				case TypeCode.Int32:
					return (int)left + (int)right;
				case TypeCode.UInt32:
					return (uint)left + (uint)right;
				case TypeCode.Int64:
					return (long)left + (long)right;
				case TypeCode.UInt64:
					return (ulong)left + (ulong)right;
				case TypeCode.Char:
					return (char)left + (char)right;
				case TypeCode.Single:
					return (float)left + (float)right;
				case TypeCode.Double:
					return (double)left + (double)right;
				case TypeCode.Decimal:
					return (decimal)left + (decimal)right;
				}
				break;
			}
		case ExpressionType.Subtract:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left - (sbyte)right;
			case TypeCode.Byte:
				return (byte)left - (byte)right;
			case TypeCode.Int16:
				return (short)left - (short)right;
			case TypeCode.UInt16:
				return (ushort)left - (ushort)right;
			case TypeCode.Int32:
				return (int)left - (int)right;
			case TypeCode.UInt32:
				return (uint)left - (uint)right;
			case TypeCode.Int64:
				return (long)left - (long)right;
			case TypeCode.UInt64:
				return (ulong)left - (ulong)right;
			case TypeCode.Char:
				return (char)left - (char)right;
			case TypeCode.Single:
				return (float)left - (float)right;
			case TypeCode.Double:
				return (double)left - (double)right;
			case TypeCode.Decimal:
				return (decimal)left - (decimal)right;
			}
			break;
		case ExpressionType.SubtractChecked:
			checked
			{
				switch (typeCode)
				{
				case TypeCode.SByte:
					return (sbyte)left - (sbyte)right;
				case TypeCode.Byte:
					return (byte)left - (byte)right;
				case TypeCode.Int16:
					return (short)left - (short)right;
				case TypeCode.UInt16:
					return (ushort)left - (ushort)right;
				case TypeCode.Int32:
					return (int)left - (int)right;
				case TypeCode.UInt32:
					return (uint)left - (uint)right;
				case TypeCode.Int64:
					return (long)left - (long)right;
				case TypeCode.UInt64:
					return (ulong)left - (ulong)right;
				case TypeCode.Char:
					return (char)left - (char)right;
				case TypeCode.Single:
					return (float)left - (float)right;
				case TypeCode.Double:
					return (double)left - (double)right;
				case TypeCode.Decimal:
					return (decimal)left - (decimal)right;
				}
				break;
			}
		case ExpressionType.Multiply:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left * (sbyte)right;
			case TypeCode.Byte:
				return (byte)left * (byte)right;
			case TypeCode.Int16:
				return (short)left * (short)right;
			case TypeCode.UInt16:
				return (ushort)left * (ushort)right;
			case TypeCode.Int32:
				return (int)left * (int)right;
			case TypeCode.UInt32:
				return (uint)left * (uint)right;
			case TypeCode.Int64:
				return (long)left * (long)right;
			case TypeCode.UInt64:
				return (ulong)left * (ulong)right;
			case TypeCode.Char:
				return (char)left * (char)right;
			case TypeCode.Single:
				return (float)left * (float)right;
			case TypeCode.Double:
				return (double)left * (double)right;
			case TypeCode.Decimal:
				return (decimal)left * (decimal)right;
			}
			break;
		case ExpressionType.MultiplyChecked:
			checked
			{
				switch (typeCode)
				{
				case TypeCode.SByte:
					return (sbyte)left * (sbyte)right;
				case TypeCode.Byte:
					return (byte)left * (byte)right;
				case TypeCode.Int16:
					return (short)left * (short)right;
				case TypeCode.UInt16:
					return (ushort)left * (ushort)right;
				case TypeCode.Int32:
					return (int)left * (int)right;
				case TypeCode.UInt32:
					return (uint)left * (uint)right;
				case TypeCode.Int64:
					return (long)left * (long)right;
				case TypeCode.UInt64:
					return (ulong)left * (ulong)right;
				case TypeCode.Char:
					return (char)left * (char)right;
				case TypeCode.Single:
					return (float)left * (float)right;
				case TypeCode.Double:
					return (double)left * (double)right;
				case TypeCode.Decimal:
					return (decimal)left * (decimal)right;
				}
				break;
			}
		case ExpressionType.Divide:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left / (sbyte)right;
			case TypeCode.Byte:
				return (byte)left / (byte)right;
			case TypeCode.Int16:
				return (short)left / (short)right;
			case TypeCode.UInt16:
				return (ushort)left / (ushort)right;
			case TypeCode.Int32:
				return (int)left / (int)right;
			case TypeCode.UInt32:
				return (uint)left / (uint)right;
			case TypeCode.Int64:
				return (long)left / (long)right;
			case TypeCode.UInt64:
				return (ulong)left / (ulong)right;
			case TypeCode.Char:
				return (char)left / (char)right;
			case TypeCode.Single:
				return (float)left / (float)right;
			case TypeCode.Double:
				return (double)left / (double)right;
			case TypeCode.Decimal:
				return (decimal)left / (decimal)right;
			}
			break;
		case ExpressionType.Modulo:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left % (sbyte)right;
			case TypeCode.Byte:
				return (byte)left % (byte)right;
			case TypeCode.Int16:
				return (short)left % (short)right;
			case TypeCode.UInt16:
				return (ushort)left % (ushort)right;
			case TypeCode.Int32:
				return (int)left % (int)right;
			case TypeCode.UInt32:
				return (uint)left % (uint)right;
			case TypeCode.Int64:
				return (long)left % (long)right;
			case TypeCode.UInt64:
				return (ulong)left % (ulong)right;
			case TypeCode.Char:
				return (char)left % (char)right;
			case TypeCode.Single:
				return (float)left % (float)right;
			case TypeCode.Double:
				return (double)left % (double)right;
			case TypeCode.Decimal:
				return (decimal)left % (decimal)right;
			}
			break;
		case ExpressionType.And:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left & (sbyte)right;
			case TypeCode.Byte:
				return (byte)left & (byte)right;
			case TypeCode.Int16:
				return (short)left & (short)right;
			case TypeCode.UInt16:
				return (ushort)left & (ushort)right;
			case TypeCode.Int32:
				return (int)left & (int)right;
			case TypeCode.UInt32:
				return (uint)left & (uint)right;
			case TypeCode.Int64:
				return (long)left & (long)right;
			case TypeCode.UInt64:
				return (ulong)left & (ulong)right;
			case TypeCode.Char:
				return (char)left & (char)right;
			case TypeCode.Boolean:
				return (bool)left & (bool)right;
			}
			break;
		case ExpressionType.Or:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return Convert.ToByte(left) | Convert.ToByte(right);
			case TypeCode.Byte:
				return (byte)left | (byte)right;
			case TypeCode.Int16:
				return (short)left | (short)right;
			case TypeCode.UInt16:
				return (ushort)left | (ushort)right;
			case TypeCode.Int32:
				return (int)left | (int)right;
			case TypeCode.UInt32:
				return (uint)left | (uint)right;
			case TypeCode.Int64:
				return (long)left | (long)right;
			case TypeCode.UInt64:
				return (ulong)left | (ulong)right;
			case TypeCode.Char:
				return (char)left | (char)right;
			case TypeCode.Boolean:
				return (bool)left | (bool)right;
			}
			break;
		case ExpressionType.ExclusiveOr:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left ^ (sbyte)right;
			case TypeCode.Byte:
				return (byte)left ^ (byte)right;
			case TypeCode.Int16:
				return (short)left ^ (short)right;
			case TypeCode.UInt16:
				return (ushort)left ^ (ushort)right;
			case TypeCode.Int32:
				return (int)left ^ (int)right;
			case TypeCode.UInt32:
				return (uint)left ^ (uint)right;
			case TypeCode.Int64:
				return (long)left ^ (long)right;
			case TypeCode.UInt64:
				return (ulong)left ^ (ulong)right;
			case TypeCode.Char:
				return (char)left ^ (char)right;
			case TypeCode.Boolean:
				return (bool)left ^ (bool)right;
			}
			break;
		case ExpressionType.AndAlso:
			if (typeCode != TypeCode.Boolean)
			{
				break;
			}
			return (bool)left && (bool)right;
		case ExpressionType.OrElse:
			if (typeCode != TypeCode.Boolean)
			{
				break;
			}
			return (bool)left || (bool)right;
		case ExpressionType.Equal:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left == (sbyte)right;
			case TypeCode.Byte:
				return (byte)left == (byte)right;
			case TypeCode.Int16:
				return (short)left == (short)right;
			case TypeCode.UInt16:
				return (ushort)left == (ushort)right;
			case TypeCode.Int32:
				return (int)left == (int)right;
			case TypeCode.UInt32:
				return (uint)left == (uint)right;
			case TypeCode.Int64:
				return (long)left == (long)right;
			case TypeCode.UInt64:
				return (ulong)left == (ulong)right;
			case TypeCode.Char:
				return (char)left == (char)right;
			case TypeCode.Single:
				return (float)left == (float)right;
			case TypeCode.Double:
				return (double)left == (double)right;
			case TypeCode.Decimal:
				return (decimal)left == (decimal)right;
			case TypeCode.Boolean:
				return (bool)left == (bool)right;
			}
			break;
		case ExpressionType.NotEqual:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left != (sbyte)right;
			case TypeCode.Byte:
				return (byte)left != (byte)right;
			case TypeCode.Int16:
				return (short)left != (short)right;
			case TypeCode.UInt16:
				return (ushort)left != (ushort)right;
			case TypeCode.Int32:
				return (int)left != (int)right;
			case TypeCode.UInt32:
				return (uint)left != (uint)right;
			case TypeCode.Int64:
				return (long)left != (long)right;
			case TypeCode.UInt64:
				return (ulong)left != (ulong)right;
			case TypeCode.Char:
				return (char)left != (char)right;
			case TypeCode.Single:
				return (float)left != (float)right;
			case TypeCode.Double:
				return (double)left != (double)right;
			case TypeCode.Decimal:
				return (decimal)left != (decimal)right;
			case TypeCode.Boolean:
				return (bool)left != (bool)right;
			}
			break;
		case ExpressionType.LessThan:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left < (sbyte)right;
			case TypeCode.Byte:
				return (byte)left < (byte)right;
			case TypeCode.Int16:
				return (short)left < (short)right;
			case TypeCode.UInt16:
				return (ushort)left < (ushort)right;
			case TypeCode.Int32:
				return (int)left < (int)right;
			case TypeCode.UInt32:
				return (uint)left < (uint)right;
			case TypeCode.Int64:
				return (long)left < (long)right;
			case TypeCode.UInt64:
				return (ulong)left < (ulong)right;
			case TypeCode.Char:
				return (char)left < (char)right;
			case TypeCode.Single:
				return (float)left < (float)right;
			case TypeCode.Double:
				return (double)left < (double)right;
			case TypeCode.Decimal:
				return (decimal)left < (decimal)right;
			}
			break;
		case ExpressionType.LessThanOrEqual:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left <= (sbyte)right;
			case TypeCode.Byte:
				return (byte)left <= (byte)right;
			case TypeCode.Int16:
				return (short)left <= (short)right;
			case TypeCode.UInt16:
				return (ushort)left <= (ushort)right;
			case TypeCode.Int32:
				return (int)left <= (int)right;
			case TypeCode.UInt32:
				return (uint)left <= (uint)right;
			case TypeCode.Int64:
				return (long)left <= (long)right;
			case TypeCode.UInt64:
				return (ulong)left <= (ulong)right;
			case TypeCode.Char:
				return (char)left <= (char)right;
			case TypeCode.Single:
				return (float)left <= (float)right;
			case TypeCode.Double:
				return (double)left <= (double)right;
			case TypeCode.Decimal:
				return (decimal)left <= (decimal)right;
			}
			break;
		case ExpressionType.GreaterThan:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left > (sbyte)right;
			case TypeCode.Byte:
				return (byte)left > (byte)right;
			case TypeCode.Int16:
				return (short)left > (short)right;
			case TypeCode.UInt16:
				return (ushort)left > (ushort)right;
			case TypeCode.Int32:
				return (int)left > (int)right;
			case TypeCode.UInt32:
				return (uint)left > (uint)right;
			case TypeCode.Int64:
				return (long)left > (long)right;
			case TypeCode.UInt64:
				return (ulong)left > (ulong)right;
			case TypeCode.Char:
				return (char)left > (char)right;
			case TypeCode.Single:
				return (float)left > (float)right;
			case TypeCode.Double:
				return (double)left > (double)right;
			case TypeCode.Decimal:
				return (decimal)left > (decimal)right;
			}
			break;
		case ExpressionType.GreaterThanOrEqual:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left >= (sbyte)right;
			case TypeCode.Byte:
				return (byte)left >= (byte)right;
			case TypeCode.Int16:
				return (short)left >= (short)right;
			case TypeCode.UInt16:
				return (ushort)left >= (ushort)right;
			case TypeCode.Int32:
				return (int)left >= (int)right;
			case TypeCode.UInt32:
				return (uint)left >= (uint)right;
			case TypeCode.Int64:
				return (long)left >= (long)right;
			case TypeCode.UInt64:
				return (ulong)left >= (ulong)right;
			case TypeCode.Char:
				return (char)left >= (char)right;
			case TypeCode.Single:
				return (float)left >= (float)right;
			case TypeCode.Double:
				return (double)left >= (double)right;
			case TypeCode.Decimal:
				return (decimal)left >= (decimal)right;
			}
			break;
		case ExpressionType.RightShift:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left >> (int)right;
			case TypeCode.Byte:
				return (byte)left >> (int)right;
			case TypeCode.Int16:
				return (short)left >> (int)right;
			case TypeCode.UInt16:
				return (ushort)left >> (int)right;
			case TypeCode.Int32:
				return (int)left >> (int)right;
			case TypeCode.UInt32:
				return (uint)left >> (int)right;
			case TypeCode.Int64:
				return (long)left >> (int)right;
			case TypeCode.UInt64:
				return (ulong)left >> (int)right;
			case TypeCode.Char:
				return (int)(char)left >> (int)right;
			}
			break;
		case ExpressionType.LeftShift:
			switch (typeCode)
			{
			case TypeCode.SByte:
				return (sbyte)left << (int)right;
			case TypeCode.Byte:
				return (byte)left << (int)right;
			case TypeCode.Int16:
				return (short)left << (int)right;
			case TypeCode.UInt16:
				return (ushort)left << (int)right;
			case TypeCode.Int32:
				return (int)left << (int)right;
			case TypeCode.UInt32:
				return (uint)left << (int)right;
			case TypeCode.Int64:
				return (long)left << (int)right;
			case TypeCode.UInt64:
				return (ulong)left << (int)right;
			case TypeCode.Char:
				return (int)((uint)(char)left << (int)right);
			}
			break;
		}
		throw new NotSupportedException("Expressions of type " + exprType.ToString() + " failed.");
	}

	protected override Expression VisitBinary(BinaryExpression expr)
	{
		object value = ((ConstantExpression)Visit(expr.Left)).Value;
		object value2 = ((ConstantExpression)Visit(expr.Right)).Value;
		Type type = Unlift(expr.Left.Type);
		Type o = Unlift(expr.Right.Type);
		if (type.IsEnum && type.Equals(o))
		{
			Type underlyingType = Enum.GetUnderlyingType(type);
			Type type2 = typeof(Nullable<>).MakeGenericType(underlyingType);
			return Visit(Expression.Convert(Expression.MakeBinary(expr.NodeType, Expression.Convert(expr.Left, type2), Expression.Convert(expr.Right, type2), expr.IsLiftedToNull, expr.Method, expr.Conversion), expr.Type));
		}
		object obj = null;
		if (!type.IsPrimitive && (expr.NodeType == ExpressionType.AndAlso || expr.NodeType == ExpressionType.OrElse))
		{
			MethodInfo method = type.GetMethod((expr.NodeType == ExpressionType.AndAlso) ? "op_False" : "op_True", new Type[1] { type });
			if (method != null && (bool)method.Invoke(null, new object[1] { value }))
			{
				return Expression.Constant(value, expr.Type);
			}
			if (expr.IsLiftedToNull && value2 == null)
			{
				return Expression.Constant(null, expr.Type);
			}
			if (expr.Method != null)
			{
				return Expression.Constant(expr.Method.Invoke(null, new object[2] { value, value2 }), expr.Type);
			}
		}
		if (expr.IsLiftedToNull && (expr.Left.Type.Equals(typeof(bool?)) || expr.Left.Type.Equals(typeof(bool))) && (expr.Right.Type.Equals(typeof(bool?)) || expr.Right.Type.Equals(typeof(bool))) && expr.Type.Equals(typeof(bool?)) && (expr.NodeType == ExpressionType.And || expr.NodeType == ExpressionType.Or))
		{
			Func<bool?, bool?, bool?> func = null;
			switch (expr.NodeType)
			{
			case ExpressionType.And:
				func = (bool? l, bool? r) => l & r;
				break;
			case ExpressionType.Or:
				func = (bool? l, bool? r) => l | r;
				break;
			}
			return Expression.Constant(func.DynamicInvoke(value, value2), expr.Type);
		}
		if (expr.IsLiftedToNull)
		{
			if ((expr.Left.Type.Equals(typeof(bool?)) || expr.Left.Type.Equals(typeof(bool))) && (expr.Right.Type.Equals(typeof(bool?)) || expr.Right.Type.Equals(typeof(bool))))
			{
				if (expr.NodeType == ExpressionType.AndAlso && false.Equals(value))
				{
					return Expression.Constant(false, expr.Type);
				}
				if (expr.NodeType == ExpressionType.OrElse && true.Equals(value))
				{
					return Expression.Constant(true, expr.Type);
				}
			}
			if (value == null || value2 == null)
			{
				return Expression.Constant(null, expr.Type);
			}
		}
		if (expr.IsLifted)
		{
			switch (expr.NodeType)
			{
			case ExpressionType.GreaterThan:
			case ExpressionType.GreaterThanOrEqual:
			case ExpressionType.LessThan:
			case ExpressionType.LessThanOrEqual:
				if (value == null || value2 == null)
				{
					return Expression.Constant(false, expr.Type);
				}
				break;
			case ExpressionType.Equal:
				if (value == null || value2 == null)
				{
					return Expression.Constant(value == value2, expr.Type);
				}
				break;
			case ExpressionType.NotEqual:
				if (value == null || value2 == null)
				{
					return Expression.Constant(value != value2, expr.Type);
				}
				break;
			}
		}
		if (expr.Method != null)
		{
			obj = expr.Method.Invoke(null, new object[2] { value, value2 });
		}
		else if (expr.NodeType == ExpressionType.Coalesce || expr.NodeType == ExpressionType.ArrayIndex)
		{
			switch (expr.NodeType)
			{
			case ExpressionType.Coalesce:
				if (value != null)
				{
					obj = value;
					if (expr.Conversion != null)
					{
						obj = Evaluate(expr.Conversion, values, obj);
					}
				}
				else
				{
					obj = value2;
				}
				break;
			case ExpressionType.ArrayIndex:
				obj = ((!expr.Right.Type.Equals(typeof(int))) ? ((Array)value).GetValue((long)value2) : ((Array)value).GetValue((int)value2));
				break;
			}
		}
		else
		{
			TypeCode typeCode = Type.GetTypeCode(type);
			obj = Convert.ChangeType(BinaryOperate(expr.NodeType, typeCode, value, value2), Unlift(expr.Type));
		}
		return Expression.Constant(obj, expr.Type);
	}

	protected override Expression VisitMember(MemberExpression expr)
	{
		object root = null;
		if (expr.Expression != null)
		{
			root = ((ConstantExpression)Visit(expr.Expression)).Value;
			if (IsNullable(expr.Expression.Type))
			{
				return Expression.Constant(PerformOnNullable(root, expr.Member, new Expression[0]), expr.Type);
			}
		}
		return Expression.Constant(expr.Member.Get(root));
	}

	private bool IsNullable(Type t)
	{
		return t.IsGenericType && t.GetGenericTypeDefinition().Equals(typeof(Nullable<>));
	}

	private Type Unlift(Type t)
	{
		if (IsNullable(t))
		{
			return t.GetGenericArguments()[0];
		}
		return t;
	}

	protected override Expression VisitUnary(UnaryExpression expr)
	{
		if (expr.NodeType == ExpressionType.Quote)
		{
			return Expression.Constant(new ParameterReplacer(values).Visit(expr.Operand), expr.Type);
		}
		object value = ((ConstantExpression)Visit(expr.Operand)).Value;
		if (expr.IsLiftedToNull && value == null)
		{
			return Expression.Constant(null, expr.Type);
		}
		if (expr.Method != null)
		{
			Type parameterType = expr.Method.GetParameters()[0].ParameterType;
			if (value == null && parameterType.IsValueType && !IsNullable(parameterType))
			{
				throw new InvalidOperationException("Cannot pass null into a conversion expecting a value type.");
			}
			return Expression.Constant(expr.Method.Invoke(null, new object[1] { value }), expr.Type);
		}
		Type type;
		Type type2;
		if (expr.IsLifted)
		{
			type = Unlift(expr.Operand.Type);
			type2 = Unlift(expr.Type);
		}
		else
		{
			type = expr.Operand.Type;
			type2 = expr.Type;
		}
		TypeCode typeCode = Type.GetTypeCode(type);
		object obj = null;
		switch (expr.NodeType)
		{
		case ExpressionType.TypeAs:
			return Expression.Constant(expr.Type.IsInstanceOfType(value) ? value : null, expr.Type);
		case ExpressionType.Convert:
			return Expression.Constant(Convert.ChangeType(value, type2), expr.Type);
		case ExpressionType.ConvertChecked:
		{
			MethodInfo method = typeof(Convert).GetMethod("To" + type2.Name, new Type[1] { value.GetType() });
			return Expression.Constant(method.Invoke(null, new object[1] { value }), expr.Type);
		}
		case ExpressionType.ArrayLength:
			return Expression.Constant(((Array)value).Length, expr.Type);
		case ExpressionType.Negate:
			switch (typeCode)
			{
			case TypeCode.SByte:
				obj = -(sbyte)value;
				break;
			case TypeCode.Byte:
				obj = -(byte)value;
				break;
			case TypeCode.Int16:
				obj = -(short)value;
				break;
			case TypeCode.UInt16:
				obj = -(ushort)value;
				break;
			case TypeCode.Int32:
				obj = -(int)value;
				break;
			case TypeCode.UInt32:
				obj = 0L - (long)(uint)value;
				break;
			case TypeCode.Int64:
				obj = -(long)value;
				break;
			case TypeCode.Char:
				obj = 0 - (char)value;
				break;
			case TypeCode.Single:
				obj = 0f - (float)value;
				break;
			case TypeCode.Double:
				obj = 0.0 - (double)value;
				break;
			case TypeCode.Decimal:
				obj = -(decimal)value;
				break;
			}
			break;
		case ExpressionType.NegateChecked:
			checked
			{
				switch (typeCode)
				{
				case TypeCode.SByte:
					obj = -(sbyte)value;
					break;
				case TypeCode.Byte:
					obj = -(byte)value;
					break;
				case TypeCode.Int16:
					obj = -(short)value;
					break;
				case TypeCode.UInt16:
					obj = -(ushort)value;
					break;
				case TypeCode.Int32:
					obj = -(int)value;
					break;
				case TypeCode.UInt32:
					obj = 0L - unchecked((long)(uint)value);
					break;
				case TypeCode.Int64:
					obj = -(long)value;
					break;
				case TypeCode.Char:
					obj = 0 - (char)value;
					break;
				case TypeCode.Single:
					obj = 0f - (float)value;
					break;
				case TypeCode.Double:
					obj = 0.0 - (double)value;
					break;
				case TypeCode.Decimal:
					obj = -(decimal)value;
					break;
				}
				break;
			}
		case ExpressionType.UnaryPlus:
			switch (typeCode)
			{
			case TypeCode.SByte:
				obj = (int)(sbyte)value;
				break;
			case TypeCode.Byte:
				obj = (int)(byte)value;
				break;
			case TypeCode.Int16:
				obj = (int)(short)value;
				break;
			case TypeCode.UInt16:
				obj = (int)(ushort)value;
				break;
			case TypeCode.Int32:
				obj = (int)value;
				break;
			case TypeCode.UInt32:
				obj = (uint)value;
				break;
			case TypeCode.Int64:
				obj = (long)value;
				break;
			case TypeCode.Char:
				obj = (int)(char)value;
				break;
			case TypeCode.Single:
				obj = (float)value;
				break;
			case TypeCode.Double:
				obj = (double)value;
				break;
			case TypeCode.Decimal:
				obj = (decimal)value;
				break;
			}
			break;
		case ExpressionType.Not:
			switch (typeCode)
			{
			case TypeCode.SByte:
				obj = ~(sbyte)value;
				break;
			case TypeCode.Byte:
				obj = ~(byte)value;
				break;
			case TypeCode.Int16:
				obj = ~(short)value;
				break;
			case TypeCode.UInt16:
				obj = ~(ushort)value;
				break;
			case TypeCode.Int32:
				obj = ~(int)value;
				break;
			case TypeCode.UInt32:
				obj = ~(uint)value;
				break;
			case TypeCode.Int64:
				obj = ~(long)value;
				break;
			case TypeCode.Char:
				obj = ~(int)(char)value;
				break;
			case TypeCode.Boolean:
				obj = !(bool)value;
				break;
			}
			break;
		}
		if (obj != null)
		{
			return Expression.Constant(obj, expr.Type);
		}
		throw new NotSupportedException("Bad unary operation: " + expr);
	}

	private object InvokeMethod(Func<object[], object> invoke, IEnumerable<Expression> arguments)
	{
		object[] arg = arguments.Select((Expression a) => ((ConstantExpression)Visit(a)).Value).ToArray();
		return invoke(arg);
	}

	private object PerformOnNullable(object root, MemberInfo member, IEnumerable<Expression> arguments)
	{
		object[] array = arguments.Select((Expression a) => ((ConstantExpression)Visit(a)).Value).ToArray();
		if (member.Name.Equals("HasValue"))
		{
			return root != null;
		}
		if (member.Name.Equals("Value"))
		{
			if (root == null)
			{
				throw new InvalidOperationException("Nullable object must have a value.");
			}
			return root;
		}
		if (member.Name.Equals("ToString"))
		{
			if (root == null)
			{
				return string.Empty;
			}
			return root.ToString();
		}
		if (member.Name.Equals("Equals"))
		{
			return object.Equals(root, array[0]);
		}
		if (member.Name.Equals("GetHashCode"))
		{
			if (root == null)
			{
				return 0;
			}
			return root.GetHashCode();
		}
		if (member.Name.Equals("GetValueOrDefault"))
		{
			if (root == null)
			{
				return array.FirstOrDefault();
			}
			return root;
		}
		throw new NotSupportedException("Cannot call on Nullable");
	}

	protected override Expression VisitMethodCall(MethodCallExpression expr)
	{
		object root;
		if (expr.Method.IsStatic)
		{
			root = null;
		}
		else
		{
			root = ((ConstantExpression)Visit(expr.Object)).Value;
			if (IsNullable(expr.Object.Type))
			{
				return Expression.Constant(PerformOnNullable(root, expr.Method, expr.Arguments), expr.Type);
			}
		}
		return Expression.Constant(InvokeMethod((object[] args) => expr.Method.Invoke(root, args), expr.Arguments), expr.Type.Equals(typeof(void)) ? typeof(object) : expr.Type);
	}

	protected override Expression VisitConditional(ConditionalExpression expr)
	{
		return ((bool)((ConstantExpression)Visit(expr.Test)).Value) ? Visit(expr.IfTrue) : Visit(expr.IfFalse);
	}

	protected override Expression VisitTypeBinary(TypeBinaryExpression expr)
	{
		return Expression.Constant(expr.TypeOperand.IsInstanceOfType(((ConstantExpression)Visit(expr.Expression)).Value), expr.Type);
	}

	protected override Expression VisitParameter(ParameterExpression expr)
	{
		return Expression.Constant(values[expr], expr.Type);
	}

	protected override Expression VisitLambda(LambdaExpression expr)
	{
		Func<object[], object> value = (object[] args) => Evaluate(expr, values, args);
		return Expression.Constant(value, typeof(Func<object[], object>));
	}

	protected override Expression VisitInvocation(InvocationExpression expr)
	{
		Delegate toInvoke = (Delegate)((ConstantExpression)Visit(expr.Expression)).Value;
		object value = InvokeMethod((object[] args) => toInvoke.DynamicInvoke(args), expr.Arguments);
		return Expression.Constant(value, expr.Type.Equals(typeof(void)) ? typeof(object) : expr.Type);
	}

	protected override Expression VisitNewArrayInit(NewArrayExpression expr)
	{
		ReadOnlyCollection<Expression> expressions = expr.Expressions;
		int num = expressions?.Count ?? 0;
		Array array = (Array)Activator.CreateInstance(expr.Type, num);
		for (int i = 0; i < num; i++)
		{
			Expression expression = Visit(expressions[i]);
			if (expression is ConstantExpression constantExpression)
			{
				array.SetValue(constantExpression.Value, i);
			}
		}
		return Expression.Constant(array, expr.Type);
	}

	internal static object Evaluate(LambdaExpression expr, Scope scope, params object[] args)
	{
		EvaluatingVisitor evaluatingVisitor = new EvaluatingVisitor();
		evaluatingVisitor.values = new Scope(scope);
		IEnumerator<ParameterExpression> enumerator = expr.Parameters.GetEnumerator();
		IEnumerator enumerator2 = args?.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator2.MoveNext())
			{
				evaluatingVisitor.values.Register(enumerator.Current, enumerator2.Current);
			}
		}
		Expression expression = evaluatingVisitor.Visit(expr.Body);
		return ((ConstantExpression)expression).Value;
	}
}
