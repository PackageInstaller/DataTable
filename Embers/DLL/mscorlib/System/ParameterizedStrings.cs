using System.Runtime.InteropServices;
using System.Text;

namespace System;

internal static class ParameterizedStrings
{
	public struct FormatParam
	{
		private readonly int _int32;

		private readonly string _string;

		public int Int32 => _int32;

		public string String => _string ?? string.Empty;

		public object Object => _string ?? ((object)_int32);

		public FormatParam(int value)
			: this(value, null)
		{
		}

		private FormatParam(int intValue, string stringValue)
		{
			_int32 = intValue;
			_string = stringValue;
		}

		public static implicit operator FormatParam(int value)
		{
			return new FormatParam(value);
		}
	}

	private sealed class LowLevelStack
	{
		private FormatParam[] _arr;

		private int _count;

		public LowLevelStack()
		{
			_arr = new FormatParam[4];
		}

		public FormatParam Pop()
		{
			if (_count == 0)
			{
				throw new InvalidOperationException("Terminfo: Invalid Stack");
			}
			FormatParam result = _arr[--_count];
			_arr[_count] = default(FormatParam);
			return result;
		}

		public void Push(FormatParam item)
		{
			if (_arr.Length == _count)
			{
				FormatParam[] array = new FormatParam[_arr.Length * 2];
				Array.Copy(_arr, 0, array, 0, _arr.Length);
				_arr = array;
			}
			_arr[_count++] = item;
		}

		public void Clear()
		{
			Array.Clear(_arr, 0, _count);
			_count = 0;
		}
	}

	[ThreadStatic]
	private static LowLevelStack _cachedStack;

	public static string Evaluate(string format, params FormatParam[] args)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		if (args == null)
		{
			throw new ArgumentNullException("args");
		}
		LowLevelStack lowLevelStack = _cachedStack;
		if (lowLevelStack == null)
		{
			lowLevelStack = (_cachedStack = new LowLevelStack());
		}
		else
		{
			lowLevelStack.Clear();
		}
		FormatParam[] dynamicVars = null;
		FormatParam[] staticVars = null;
		int pos = 0;
		return EvaluateInternal(format, ref pos, args, lowLevelStack, ref dynamicVars, ref staticVars);
	}

	private static string EvaluateInternal(string format, ref int pos, FormatParam[] args, LowLevelStack stack, ref FormatParam[] dynamicVars, ref FormatParam[] staticVars)
	{
		StringBuilder stringBuilder = new StringBuilder(format.Length);
		bool flag = false;
		while (pos < format.Length)
		{
			if (format[pos] != '%')
			{
				stringBuilder.Append(format[pos]);
			}
			else
			{
				pos++;
				switch (format[pos])
				{
				case '%':
					stringBuilder.Append('%');
					break;
				case 'c':
					stringBuilder.Append((char)stack.Pop().Int32);
					break;
				case 's':
					stringBuilder.Append(stack.Pop().String);
					break;
				case 'd':
					stringBuilder.Append(stack.Pop().Int32);
					break;
				case '0':
				case '1':
				case '2':
				case '3':
				case '4':
				case '5':
				case '6':
				case '7':
				case '8':
				case '9':
				case ':':
				case 'X':
				case 'o':
				case 'x':
				{
					int i;
					for (i = pos; i < format.Length; i++)
					{
						char c = format[i];
						if (c == 'd' || c == 'o' || c == 'x' || c == 'X' || c == 's')
						{
							break;
						}
					}
					if (i >= format.Length)
					{
						throw new InvalidOperationException("Terminfo database contains invalid values");
					}
					string text = format.Substring(pos - 1, i - pos + 2);
					if (text.Length > 1 && text[1] == ':')
					{
						text = text.Remove(1, 1);
					}
					stringBuilder.Append(FormatPrintF(text, stack.Pop().Object));
					break;
				}
				case 'p':
					pos++;
					stack.Push(args[format[pos] - 49]);
					break;
				case 'l':
					stack.Push(stack.Pop().String.Length);
					break;
				case '{':
				{
					pos++;
					int num = 0;
					while (format[pos] != '}')
					{
						num = num * 10 + (format[pos] - 48);
						pos++;
					}
					stack.Push(num);
					break;
				}
				case '\'':
					stack.Push(format[pos + 1]);
					pos += 2;
					break;
				case 'P':
				{
					pos++;
					GetDynamicOrStaticVariables(format[pos], ref dynamicVars, ref staticVars, out var index)[index] = stack.Pop();
					break;
				}
				case 'g':
				{
					pos++;
					FormatParam[] dynamicOrStaticVariables = GetDynamicOrStaticVariables(format[pos], ref dynamicVars, ref staticVars, out var index2);
					stack.Push(dynamicOrStaticVariables[index2]);
					break;
				}
				case '&':
				case '*':
				case '+':
				case '-':
				case '/':
				case '<':
				case '=':
				case '>':
				case 'A':
				case 'O':
				case '^':
				case 'm':
				case '|':
				{
					int @int = stack.Pop().Int32;
					int int2 = stack.Pop().Int32;
					stack.Push(format[pos] switch
					{
						'+' => int2 + @int, 
						'-' => int2 - @int, 
						'*' => int2 * @int, 
						'/' => int2 / @int, 
						'm' => int2 % @int, 
						'^' => int2 ^ @int, 
						'&' => int2 & @int, 
						'|' => int2 | @int, 
						'=' => AsInt(int2 == @int), 
						'>' => AsInt(int2 > @int), 
						'<' => AsInt(int2 < @int), 
						'A' => AsInt(AsBool(int2) && AsBool(@int)), 
						'O' => AsInt(AsBool(int2) || AsBool(@int)), 
						_ => 0, 
					});
					break;
				}
				case '!':
				case '~':
				{
					int int3 = stack.Pop().Int32;
					stack.Push((format[pos] == '!') ? AsInt(!AsBool(int3)) : (~int3));
					break;
				}
				case 'i':
					args[0] = 1 + args[0].Int32;
					args[1] = 1 + args[1].Int32;
					break;
				case '?':
					flag = true;
					break;
				case 't':
				{
					bool flag2 = AsBool(stack.Pop().Int32);
					pos++;
					string value = EvaluateInternal(format, ref pos, args, stack, ref dynamicVars, ref staticVars);
					if (flag2)
					{
						stringBuilder.Append(value);
					}
					if (!AsBool(stack.Pop().Int32))
					{
						pos++;
						string value2 = EvaluateInternal(format, ref pos, args, stack, ref dynamicVars, ref staticVars);
						if (!flag2)
						{
							stringBuilder.Append(value2);
						}
						if (!AsBool(stack.Pop().Int32))
						{
							throw new InvalidOperationException("Terminfo database contains invalid values");
						}
					}
					if (!flag)
					{
						stack.Push(1);
						return stringBuilder.ToString();
					}
					flag = false;
					break;
				}
				case ';':
				case 'e':
					stack.Push(AsInt(format[pos] == ';'));
					return stringBuilder.ToString();
				default:
					throw new InvalidOperationException("Terminfo database contains invalid values");
				}
			}
			pos++;
		}
		stack.Push(1);
		return stringBuilder.ToString();
	}

	private static bool AsBool(int i)
	{
		return i != 0;
	}

	private static int AsInt(bool b)
	{
		if (!b)
		{
			return 0;
		}
		return 1;
	}

	private static string StringFromAsciiBytes(byte[] buffer, int offset, int length)
	{
		if (length == 0)
		{
			return string.Empty;
		}
		char[] array = new char[length];
		int num = 0;
		int num2 = offset;
		while (num < length)
		{
			array[num] = (char)buffer[num2];
			num++;
			num2++;
		}
		return new string(array);
	}

	[DllImport("libc")]
	private unsafe static extern int snprintf(byte* str, IntPtr size, string format, string arg1);

	[DllImport("libc")]
	private unsafe static extern int snprintf(byte* str, IntPtr size, string format, int arg1);

	private unsafe static string FormatPrintF(string format, object arg)
	{
		string text = arg as string;
		int num = ((text != null) ? snprintf(null, IntPtr.Zero, format, text) : snprintf(null, IntPtr.Zero, format, (int)arg));
		if (num == 0)
		{
			return string.Empty;
		}
		if (num < 0)
		{
			throw new InvalidOperationException("The printf operation failed");
		}
		byte[] array = new byte[num + 1];
		fixed (byte* str = array)
		{
			if (((text != null) ? snprintf(str, (IntPtr)array.Length, format, text) : snprintf(str, (IntPtr)array.Length, format, (int)arg)) != num)
			{
				throw new InvalidOperationException("Invalid printf operation");
			}
		}
		return StringFromAsciiBytes(array, 0, num);
	}

	private static FormatParam[] GetDynamicOrStaticVariables(char c, ref FormatParam[] dynamicVars, ref FormatParam[] staticVars, out int index)
	{
		if (c >= 'A' && c <= 'Z')
		{
			index = c - 65;
			return staticVars ?? (staticVars = new FormatParam[26]);
		}
		if (c >= 'a' && c <= 'z')
		{
			index = c - 97;
			return dynamicVars ?? (dynamicVars = new FormatParam[26]);
		}
		throw new InvalidOperationException("Terminfo database contains invalid values");
	}
}
