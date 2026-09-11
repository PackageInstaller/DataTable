using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal abstract class NullableMethodCallInstruction : Instruction
{
	private sealed class HasValue : NullableMethodCallInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			frame.Push(obj != null);
			return 1;
		}
	}

	private sealed class GetValue : NullableMethodCallInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			if (frame.Peek() == null)
			{
				return ((int?)null).Value;
			}
			return 1;
		}
	}

	private sealed class GetValueOrDefault : NullableMethodCallInstruction
	{
		private readonly Type _defaultValueType;

		public GetValueOrDefault(MethodInfo mi)
		{
			_defaultValueType = mi.ReturnType;
		}

		public override int Run(InterpretedFrame frame)
		{
			if (frame.Peek() == null)
			{
				frame.Pop();
				frame.Push(Activator.CreateInstance(_defaultValueType));
			}
			return 1;
		}
	}

	private sealed class GetValueOrDefault1 : NullableMethodCallInstruction
	{
		public override int ConsumedStack => 2;

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			frame.Push(obj2 ?? obj);
			return 1;
		}
	}

	private sealed class EqualsClass : NullableMethodCallInstruction
	{
		public override int ConsumedStack => 2;

		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			object obj2 = frame.Pop();
			if (obj2 == null)
			{
				frame.Push(obj == null);
			}
			else if (obj == null)
			{
				frame.Push(Utils.BoxedFalse);
			}
			else
			{
				frame.Push(obj2.Equals(obj));
			}
			return 1;
		}
	}

	private sealed class ToStringClass : NullableMethodCallInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			object obj = frame.Pop();
			frame.Push((obj == null) ? "" : obj.ToString());
			return 1;
		}
	}

	private sealed class GetHashCodeClass : NullableMethodCallInstruction
	{
		public override int Run(InterpretedFrame frame)
		{
			frame.Push(frame.Pop()?.GetHashCode() ?? 0);
			return 1;
		}
	}

	private static NullableMethodCallInstruction s_hasValue;

	private static NullableMethodCallInstruction s_value;

	private static NullableMethodCallInstruction s_equals;

	private static NullableMethodCallInstruction s_getHashCode;

	private static NullableMethodCallInstruction s_getValueOrDefault1;

	private static NullableMethodCallInstruction s_toString;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "NullableMethod";

	private NullableMethodCallInstruction()
	{
	}

	public static Instruction Create(string method, int argCount, MethodInfo mi)
	{
		switch (method)
		{
		case "get_HasValue":
			return s_hasValue ?? (s_hasValue = new HasValue());
		case "get_Value":
			return s_value ?? (s_value = new GetValue());
		case "Equals":
			return s_equals ?? (s_equals = new EqualsClass());
		case "GetHashCode":
			return s_getHashCode ?? (s_getHashCode = new GetHashCodeClass());
		case "GetValueOrDefault":
			if (argCount == 0)
			{
				return new GetValueOrDefault(mi);
			}
			return s_getValueOrDefault1 ?? (s_getValueOrDefault1 = new GetValueOrDefault1());
		case "ToString":
			return s_toString ?? (s_toString = new ToStringClass());
		default:
			throw ContractUtils.Unreachable;
		}
	}

	public static Instruction CreateGetValue()
	{
		return s_value ?? (s_value = new GetValue());
	}
}
