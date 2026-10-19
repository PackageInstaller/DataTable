using System.Collections.Generic;
using System.Dynamic.Utils;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;

namespace System.Linq.Expressions.Interpreter;

internal class LightLambda
{
	private class DebugViewPrinter
	{
		private readonly Interpreter _interpreter;

		private readonly Dictionary<int, int> _tryStart = new Dictionary<int, int>();

		private readonly Dictionary<int, string> _handlerEnter = new Dictionary<int, string>();

		private readonly Dictionary<int, int> _handlerExit = new Dictionary<int, int>();

		private string _indent = "  ";

		public DebugViewPrinter(Interpreter interpreter)
		{
			_interpreter = interpreter;
			Analyze();
		}

		private void Analyze()
		{
			Instruction[] instructions = _interpreter.Instructions.Instructions;
			foreach (Instruction instruction in instructions)
			{
				if (instruction is EnterTryCatchFinallyInstruction { Handler: var handler })
				{
					AddTryStart(handler.TryStartIndex);
					AddHandlerExit(handler.TryEndIndex + 1);
					if (handler.IsFinallyBlockExist)
					{
						_handlerEnter.Add(handler.FinallyStartIndex, "finally");
						AddHandlerExit(handler.FinallyEndIndex);
					}
					if (handler.IsCatchBlockExist)
					{
						ExceptionHandler[] handlers = handler.Handlers;
						foreach (ExceptionHandler exceptionHandler in handlers)
						{
							_handlerEnter.Add(exceptionHandler.HandlerStartIndex - 1, exceptionHandler.ToString());
							AddHandlerExit(exceptionHandler.HandlerEndIndex);
							ExceptionFilter filter = exceptionHandler.Filter;
							if (filter != null)
							{
								_handlerEnter.Add(filter.StartIndex - 1, "filter");
								AddHandlerExit(filter.EndIndex);
							}
						}
					}
				}
				if (instruction is EnterTryFaultInstruction { Handler: var handler2 })
				{
					AddTryStart(handler2.TryStartIndex);
					AddHandlerExit(handler2.TryEndIndex + 1);
					_handlerEnter.Add(handler2.FinallyStartIndex, "fault");
					AddHandlerExit(handler2.FinallyEndIndex);
				}
			}
		}

		private void AddTryStart(int index)
		{
			if (!_tryStart.TryGetValue(index, out var value))
			{
				_tryStart.Add(index, 1);
			}
			else
			{
				_tryStart[index] = value + 1;
			}
		}

		private void AddHandlerExit(int index)
		{
			_handlerExit[index] = ((!_handlerExit.TryGetValue(index, out var value)) ? 1 : (value + 1));
		}

		private void Indent()
		{
			_indent = new string(' ', _indent.Length + 2);
		}

		private void Dedent()
		{
			_indent = new string(' ', _indent.Length - 2);
		}

		public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			string value = _interpreter.Name ?? "lambda_method";
			stringBuilder.Append("object ").Append(value).AppendLine("(object[])");
			stringBuilder.AppendLine("{");
			stringBuilder.Append("  .locals ").Append(_interpreter.LocalCount).AppendLine();
			stringBuilder.Append("  .maxstack ").Append(_interpreter.Instructions.MaxStackDepth).AppendLine();
			stringBuilder.Append("  .maxcontinuation ").Append(_interpreter.Instructions.MaxContinuationDepth).AppendLine();
			stringBuilder.AppendLine();
			Instruction[] instructions = _interpreter.Instructions.Instructions;
			InstructionList.DebugView.InstructionView[] instructionViews = new InstructionArray.DebugView(_interpreter.Instructions).GetInstructionViews();
			for (int i = 0; i < instructions.Length; i++)
			{
				EmitExits(stringBuilder, i);
				if (_tryStart.TryGetValue(i, out var value2))
				{
					for (int j = 0; j < value2; j++)
					{
						stringBuilder.Append(_indent).AppendLine(".try");
						stringBuilder.Append(_indent).AppendLine("{");
						Indent();
					}
				}
				if (_handlerEnter.TryGetValue(i, out var value3))
				{
					stringBuilder.Append(_indent).AppendLine(value3);
					stringBuilder.Append(_indent).AppendLine("{");
					Indent();
				}
				InstructionList.DebugView.InstructionView instructionView = instructionViews[i];
				stringBuilder.AppendFormat(CultureInfo.InvariantCulture, "{0}IP_{1}: {2}", _indent, i.ToString().PadLeft(4, '0'), instructionView.GetValue()).AppendLine();
			}
			EmitExits(stringBuilder, instructions.Length);
			stringBuilder.AppendLine("}");
			return stringBuilder.ToString();
		}

		private void EmitExits(StringBuilder sb, int index)
		{
			if (_handlerExit.TryGetValue(index, out var value))
			{
				for (int i = 0; i < value; i++)
				{
					Dedent();
					sb.Append(_indent).AppendLine("}");
				}
			}
		}
	}

	private readonly IStrongBox[] _closure;

	private readonly Interpreter _interpreter;

	private static readonly CacheDict<Type, Func<LightLambda, Delegate>> _runCache = new CacheDict<Type, Func<LightLambda, Delegate>>(100);

	private readonly LightDelegateCreator _delegateCreator;

	internal string DebugView => new DebugViewPrinter(_interpreter).ToString();

	internal TRet Run0<TRet>()
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid0()
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun0<TRet>(LightLambda lambda)
	{
		return new Func<TRet>(lambda.Run0<TRet>);
	}

	internal static Delegate MakeRunVoid0(LightLambda lambda)
	{
		return new Action(lambda.RunVoid0);
	}

	internal TRet Run1<T0, TRet>(T0 arg0)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid1<T0>(T0 arg0)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun1<T0, TRet>(LightLambda lambda)
	{
		return new Func<T0, TRet>(lambda.Run1<T0, TRet>);
	}

	internal static Delegate MakeRunVoid1<T0>(LightLambda lambda)
	{
		return new Action<T0>(lambda.RunVoid1);
	}

	internal TRet Run2<T0, T1, TRet>(T0 arg0, T1 arg1)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid2<T0, T1>(T0 arg0, T1 arg1)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun2<T0, T1, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, TRet>(lambda.Run2<T0, T1, TRet>);
	}

	internal static Delegate MakeRunVoid2<T0, T1>(LightLambda lambda)
	{
		return new Action<T0, T1>(lambda.RunVoid2);
	}

	internal TRet Run3<T0, T1, T2, TRet>(T0 arg0, T1 arg1, T2 arg2)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid3<T0, T1, T2>(T0 arg0, T1 arg1, T2 arg2)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun3<T0, T1, T2, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, TRet>(lambda.Run3<T0, T1, T2, TRet>);
	}

	internal static Delegate MakeRunVoid3<T0, T1, T2>(LightLambda lambda)
	{
		return new Action<T0, T1, T2>(lambda.RunVoid3);
	}

	internal TRet Run4<T0, T1, T2, T3, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid4<T0, T1, T2, T3>(T0 arg0, T1 arg1, T2 arg2, T3 arg3)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun4<T0, T1, T2, T3, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, TRet>(lambda.Run4<T0, T1, T2, T3, TRet>);
	}

	internal static Delegate MakeRunVoid4<T0, T1, T2, T3>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3>(lambda.RunVoid4);
	}

	internal TRet Run5<T0, T1, T2, T3, T4, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid5<T0, T1, T2, T3, T4>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun5<T0, T1, T2, T3, T4, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, TRet>(lambda.Run5<T0, T1, T2, T3, T4, TRet>);
	}

	internal static Delegate MakeRunVoid5<T0, T1, T2, T3, T4>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4>(lambda.RunVoid5);
	}

	internal TRet Run6<T0, T1, T2, T3, T4, T5, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid6<T0, T1, T2, T3, T4, T5>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun6<T0, T1, T2, T3, T4, T5, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, TRet>(lambda.Run6<T0, T1, T2, T3, T4, T5, TRet>);
	}

	internal static Delegate MakeRunVoid6<T0, T1, T2, T3, T4, T5>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5>(lambda.RunVoid6);
	}

	internal TRet Run7<T0, T1, T2, T3, T4, T5, T6, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid7<T0, T1, T2, T3, T4, T5, T6>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun7<T0, T1, T2, T3, T4, T5, T6, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, TRet>(lambda.Run7<T0, T1, T2, T3, T4, T5, T6, TRet>);
	}

	internal static Delegate MakeRunVoid7<T0, T1, T2, T3, T4, T5, T6>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6>(lambda.RunVoid7);
	}

	internal TRet Run8<T0, T1, T2, T3, T4, T5, T6, T7, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid8<T0, T1, T2, T3, T4, T5, T6, T7>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun8<T0, T1, T2, T3, T4, T5, T6, T7, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, TRet>(lambda.Run8<T0, T1, T2, T3, T4, T5, T6, T7, TRet>);
	}

	internal static Delegate MakeRunVoid8<T0, T1, T2, T3, T4, T5, T6, T7>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7>(lambda.RunVoid8);
	}

	internal TRet Run9<T0, T1, T2, T3, T4, T5, T6, T7, T8, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid9<T0, T1, T2, T3, T4, T5, T6, T7, T8>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun9<T0, T1, T2, T3, T4, T5, T6, T7, T8, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, TRet>(lambda.Run9<T0, T1, T2, T3, T4, T5, T6, T7, T8, TRet>);
	}

	internal static Delegate MakeRunVoid9<T0, T1, T2, T3, T4, T5, T6, T7, T8>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8>(lambda.RunVoid9);
	}

	internal TRet Run10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, TRet>(lambda.Run10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, TRet>);
	}

	internal static Delegate MakeRunVoid10<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(lambda.RunVoid10);
	}

	internal TRet Run11<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid11<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun11<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TRet>(lambda.Run11<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TRet>);
	}

	internal static Delegate MakeRunVoid11<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(lambda.RunVoid11);
	}

	internal TRet Run12<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid12<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun12<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TRet>(lambda.Run12<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, TRet>);
	}

	internal static Delegate MakeRunVoid12<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(lambda.RunVoid12);
	}

	internal TRet Run13<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		interpretedFrame.Data[12] = arg12;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid13<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		interpretedFrame.Data[12] = arg12;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun13<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TRet>(lambda.Run13<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, TRet>);
	}

	internal static Delegate MakeRunVoid13<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(lambda.RunVoid13);
	}

	internal TRet Run14<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		interpretedFrame.Data[12] = arg12;
		interpretedFrame.Data[13] = arg13;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid14<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		interpretedFrame.Data[12] = arg12;
		interpretedFrame.Data[13] = arg13;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun14<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TRet>(lambda.Run14<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, TRet>);
	}

	internal static Delegate MakeRunVoid14<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(lambda.RunVoid14);
	}

	internal TRet Run15<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TRet>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		interpretedFrame.Data[12] = arg12;
		interpretedFrame.Data[13] = arg13;
		interpretedFrame.Data[14] = arg14;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
		return (TRet)interpretedFrame.Pop();
	}

	internal void RunVoid15<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		interpretedFrame.Data[2] = arg2;
		interpretedFrame.Data[3] = arg3;
		interpretedFrame.Data[4] = arg4;
		interpretedFrame.Data[5] = arg5;
		interpretedFrame.Data[6] = arg6;
		interpretedFrame.Data[7] = arg7;
		interpretedFrame.Data[8] = arg8;
		interpretedFrame.Data[9] = arg9;
		interpretedFrame.Data[10] = arg10;
		interpretedFrame.Data[11] = arg11;
		interpretedFrame.Data[12] = arg12;
		interpretedFrame.Data[13] = arg13;
		interpretedFrame.Data[14] = arg14;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
		}
	}

	internal static Delegate MakeRun15<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TRet>(LightLambda lambda)
	{
		return new Func<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TRet>(lambda.Run15<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, TRet>);
	}

	internal static Delegate MakeRunVoid15<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(LightLambda lambda)
	{
		return new Action<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(lambda.RunVoid15);
	}

	internal LightLambda(LightDelegateCreator delegateCreator, IStrongBox[] closure)
	{
		_delegateCreator = delegateCreator;
		_closure = closure;
		_interpreter = delegateCreator.Interpreter;
	}

	private static Func<LightLambda, Delegate> GetRunDelegateCtor(Type delegateType)
	{
		lock (_runCache)
		{
			if (_runCache.TryGetValue(delegateType, out var value))
			{
				return value;
			}
			return MakeRunDelegateCtor(delegateType);
		}
	}

	private static Func<LightLambda, Delegate> MakeRunDelegateCtor(Type delegateType)
	{
		MethodInfo invokeMethod = delegateType.GetInvokeMethod();
		ParameterInfo[] parametersCached = invokeMethod.GetParametersCached();
		string text = "Run";
		if (parametersCached.Length >= 16)
		{
			return null;
		}
		Type[] array;
		if (invokeMethod.ReturnType == typeof(void))
		{
			text += "Void";
			array = new Type[parametersCached.Length];
		}
		else
		{
			array = new Type[parametersCached.Length + 1];
			array[array.Length - 1] = invokeMethod.ReturnType;
		}
		MethodInfo method;
		if (invokeMethod.ReturnType == typeof(void) && array.Length == 2 && parametersCached[0].ParameterType.IsByRef && parametersCached[1].ParameterType.IsByRef)
		{
			method = typeof(LightLambda).GetMethod("RunVoidRef2", BindingFlags.Instance | BindingFlags.NonPublic);
			array[0] = parametersCached[0].ParameterType.GetElementType();
			array[1] = parametersCached[1].ParameterType.GetElementType();
		}
		else if (invokeMethod.ReturnType == typeof(void) && array.Length == 0)
		{
			method = typeof(LightLambda).GetMethod("RunVoid0", BindingFlags.Instance | BindingFlags.NonPublic);
		}
		else
		{
			for (int i = 0; i < parametersCached.Length; i++)
			{
				array[i] = parametersCached[i].ParameterType;
				if (array[i].IsByRef)
				{
					return null;
				}
			}
			if (DelegateHelpers.MakeDelegate(array) == delegateType)
			{
				text = "Make" + text + parametersCached.Length;
				MethodInfo methodInfo = typeof(LightLambda).GetMethod(text, BindingFlags.Static | BindingFlags.NonPublic).MakeGenericMethod(array);
				return _runCache[delegateType] = (Func<LightLambda, Delegate>)methodInfo.CreateDelegate(typeof(Func<LightLambda, Delegate>));
			}
			method = typeof(LightLambda).GetMethod(text + parametersCached.Length, BindingFlags.Instance | BindingFlags.NonPublic);
		}
		MethodInfo targetMethod = (method.IsGenericMethodDefinition ? method.MakeGenericMethod(array) : method);
		return _runCache[delegateType] = (LightLambda lambda) => targetMethod.CreateDelegate(delegateType, lambda);
	}

	private Delegate CreateCustomDelegate(Type delegateType)
	{
		MethodInfo invokeMethod = delegateType.GetInvokeMethod();
		ParameterInfo[] parametersCached = invokeMethod.GetParametersCached();
		ParameterExpression[] array = new ParameterExpression[parametersCached.Length];
		Expression[] array2 = new Expression[parametersCached.Length];
		bool flag = false;
		for (int i = 0; i < parametersCached.Length; i++)
		{
			ParameterExpression parameterExpression = Expression.Parameter(parametersCached[i].ParameterType, parametersCached[i].Name);
			flag = flag || parametersCached[i].ParameterType.IsByRef;
			array[i] = parameterExpression;
			array2[i] = Expression.Convert(parameterExpression, typeof(object));
		}
		NewArrayExpression right = Expression.NewArrayInit(typeof(object), array2);
		ConstantExpression expression = Expression.Constant(new Func<object[], object>(Run));
		ParameterExpression parameterExpression2 = Expression.Parameter(typeof(object[]), "$args");
		Expression expression2 = ((!(invokeMethod.ReturnType == typeof(void))) ? ((Expression)Expression.Convert(Expression.Invoke(expression, parameterExpression2), invokeMethod.ReturnType)) : ((Expression)Expression.Block(typeof(void), Expression.Invoke(expression, parameterExpression2))));
		if (flag)
		{
			List<Expression> list = new List<Expression>();
			for (int j = 0; j < parametersCached.Length; j++)
			{
				if (parametersCached[j].ParameterType.IsByRef)
				{
					list.Add(Expression.Assign(array[j], Expression.Convert(Expression.ArrayAccess(parameterExpression2, Expression.Constant(j)), parametersCached[j].ParameterType.GetElementType())));
				}
			}
			expression2 = Expression.TryFinally(expression2, Expression.Block(typeof(void), list));
		}
		expression2 = Expression.Block(invokeMethod.ReturnType, new ParameterExpression[1] { parameterExpression2 }, Expression.Assign(parameterExpression2, right), expression2);
		Expression.Lambda(delegateType, expression2, array);
		throw new NotImplementedException("byref delegate");
	}

	internal Delegate MakeDelegate(Type delegateType)
	{
		Func<LightLambda, Delegate> runDelegateCtor = GetRunDelegateCtor(delegateType);
		if (runDelegateCtor != null)
		{
			return runDelegateCtor(this);
		}
		return CreateCustomDelegate(delegateType);
	}

	private InterpretedFrame MakeFrame()
	{
		return new InterpretedFrame(_interpreter, _closure);
	}

	internal void RunVoidRef2<T0, T1>(ref T0 arg0, ref T1 arg1)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		interpretedFrame.Data[0] = arg0;
		interpretedFrame.Data[1] = arg1;
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			interpretedFrame.Leave(prevFrame);
			arg0 = (T0)interpretedFrame.Data[0];
			arg1 = (T1)interpretedFrame.Data[1];
		}
	}

	public object Run(params object[] arguments)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		for (int i = 0; i < arguments.Length; i++)
		{
			interpretedFrame.Data[i] = arguments[i];
		}
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			for (int j = 0; j < arguments.Length; j++)
			{
				arguments[j] = interpretedFrame.Data[j];
			}
			interpretedFrame.Leave(prevFrame);
		}
		return interpretedFrame.Pop();
	}

	public object RunVoid(params object[] arguments)
	{
		InterpretedFrame interpretedFrame = MakeFrame();
		for (int i = 0; i < arguments.Length; i++)
		{
			interpretedFrame.Data[i] = arguments[i];
		}
		InterpretedFrame prevFrame = interpretedFrame.Enter();
		try
		{
			_interpreter.Run(interpretedFrame);
		}
		finally
		{
			for (int j = 0; j < arguments.Length; j++)
			{
				arguments[j] = interpretedFrame.Data[j];
			}
			interpretedFrame.Leave(prevFrame);
		}
		return null;
	}
}
