using System;
using System.Collections.Generic;

namespace MemoryPack.Formatters;

internal static class TupleFormatterTypes
{
	public static readonly Dictionary<Type, Type> TupleFormatters = new Dictionary<Type, Type>(16)
	{
		{
			typeof(Tuple<>),
			typeof(TupleFormatter<>)
		},
		{
			typeof(ValueTuple<>),
			typeof(ValueTupleFormatter<>)
		},
		{
			typeof(Tuple<, >),
			typeof(TupleFormatter<, >)
		},
		{
			typeof(ValueTuple<, >),
			typeof(ValueTupleFormatter<, >)
		},
		{
			typeof(Tuple<, , >),
			typeof(TupleFormatter<, , >)
		},
		{
			typeof(ValueTuple<, , >),
			typeof(ValueTupleFormatter<, , >)
		},
		{
			typeof(Tuple<, , , >),
			typeof(TupleFormatter<, , , >)
		},
		{
			typeof(ValueTuple<, , , >),
			typeof(ValueTupleFormatter<, , , >)
		},
		{
			typeof(Tuple<, , , , >),
			typeof(TupleFormatter<, , , , >)
		},
		{
			typeof(ValueTuple<, , , , >),
			typeof(ValueTupleFormatter<, , , , >)
		},
		{
			typeof(Tuple<, , , , , >),
			typeof(TupleFormatter<, , , , , >)
		},
		{
			typeof(ValueTuple<, , , , , >),
			typeof(ValueTupleFormatter<, , , , , >)
		},
		{
			typeof(Tuple<, , , , , , >),
			typeof(TupleFormatter<, , , , , , >)
		},
		{
			typeof(ValueTuple<, , , , , , >),
			typeof(ValueTupleFormatter<, , , , , , >)
		},
		{
			typeof(Tuple<, , , , , , , >),
			typeof(TupleFormatter<, , , , , , , >)
		},
		{
			typeof(ValueTuple<, , , , , , , >),
			typeof(ValueTupleFormatter<, , , , , , , >)
		}
	};
}
