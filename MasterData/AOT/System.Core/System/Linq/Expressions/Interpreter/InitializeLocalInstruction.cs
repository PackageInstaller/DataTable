using System.Dynamic.Utils;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal abstract class InitializeLocalInstruction : LocalAccessInstruction
{
	internal sealed class Reference : InitializeLocalInstruction, IBoxableInstruction
	{
		public override string InstructionName => "InitRef";

		internal Reference(int index)
			: base(index)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			frame.Data[_index] = null;
			return 1;
		}

		public Instruction BoxIfIndexMatches(int index)
		{
			if (index != _index)
			{
				return null;
			}
			return InstructionList.InitImmutableRefBox(index);
		}
	}

	internal sealed class ImmutableValue : InitializeLocalInstruction, IBoxableInstruction
	{
		private readonly object _defaultValue;

		public override string InstructionName => "InitImmutableValue";

		internal ImmutableValue(int index, object defaultValue)
			: base(index)
		{
			_defaultValue = defaultValue;
		}

		public override int Run(InterpretedFrame frame)
		{
			frame.Data[_index] = _defaultValue;
			return 1;
		}

		public Instruction BoxIfIndexMatches(int index)
		{
			if (index != _index)
			{
				return null;
			}
			return new ImmutableBox(index, _defaultValue);
		}
	}

	internal sealed class ImmutableBox : InitializeLocalInstruction
	{
		private readonly object _defaultValue;

		public override string InstructionName => "InitImmutableBox";

		internal ImmutableBox(int index, object defaultValue)
			: base(index)
		{
			_defaultValue = defaultValue;
		}

		public override int Run(InterpretedFrame frame)
		{
			frame.Data[_index] = new StrongBox<object>(_defaultValue);
			return 1;
		}
	}

	internal sealed class ImmutableRefBox : InitializeLocalInstruction
	{
		public override string InstructionName => "InitImmutableBox";

		internal ImmutableRefBox(int index)
			: base(index)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			frame.Data[_index] = new StrongBox<object>();
			return 1;
		}
	}

	internal sealed class ParameterBox : InitializeLocalInstruction
	{
		public override string InstructionName => "InitParameterBox";

		public ParameterBox(int index)
			: base(index)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			frame.Data[_index] = new StrongBox<object>(frame.Data[_index]);
			return 1;
		}
	}

	internal sealed class Parameter : InitializeLocalInstruction, IBoxableInstruction
	{
		public override string InstructionName => "InitParameter";

		internal Parameter(int index)
			: base(index)
		{
		}

		public override int Run(InterpretedFrame frame)
		{
			return 1;
		}

		public Instruction BoxIfIndexMatches(int index)
		{
			if (index == _index)
			{
				return InstructionList.ParameterBox(index);
			}
			return null;
		}
	}

	internal sealed class MutableValue : InitializeLocalInstruction, IBoxableInstruction
	{
		private readonly Type _type;

		public override string InstructionName => "InitMutableValue";

		internal MutableValue(int index, Type type)
			: base(index)
		{
			_type = type;
		}

		public override int Run(InterpretedFrame frame)
		{
			try
			{
				frame.Data[_index] = Activator.CreateInstance(_type);
			}
			catch (TargetInvocationException exception)
			{
				ExceptionHelpers.UnwrapAndRethrow(exception);
				throw ContractUtils.Unreachable;
			}
			return 1;
		}

		public Instruction BoxIfIndexMatches(int index)
		{
			if (index != _index)
			{
				return null;
			}
			return new MutableBox(index, _type);
		}
	}

	internal sealed class MutableBox : InitializeLocalInstruction
	{
		private readonly Type _type;

		public override string InstructionName => "InitMutableBox";

		internal MutableBox(int index, Type type)
			: base(index)
		{
			_type = type;
		}

		public override int Run(InterpretedFrame frame)
		{
			object value;
			try
			{
				value = Activator.CreateInstance(_type);
			}
			catch (TargetInvocationException exception)
			{
				ExceptionHelpers.UnwrapAndRethrow(exception);
				throw ContractUtils.Unreachable;
			}
			frame.Data[_index] = new StrongBox<object>(value);
			return 1;
		}
	}

	internal InitializeLocalInstruction(int index)
		: base(index)
	{
	}
}
