using System;
using TMPro;

namespace Cysharp.Text;

public static class TextMeshProExtensions
{
	public static void SetText<T>(this TMP_Text text, T arg0)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.Append(arg0);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0>(this TMP_Text text, string format, T0 arg0)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1>(this TMP_Text text, string format, T0 arg0, T1 arg1)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetTextFormat<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(this TMP_Text text, string format, T0 arg0, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
	{
		using Utf16ValueStringBuilder utf16ValueStringBuilder = new Utf16ValueStringBuilder(disposeImmediately: true);
		utf16ValueStringBuilder.AppendFormat(format, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
		ArraySegment<char> arraySegment = utf16ValueStringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}

	public static void SetText(this TMP_Text text, Utf16ValueStringBuilder stringBuilder)
	{
		ArraySegment<char> arraySegment = stringBuilder.AsArraySegment();
		text.SetCharArray(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
	}
}
