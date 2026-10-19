using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Google.Protobuf.Reflection;

internal static class DescriptorUtil
{
	internal delegate TOutput IndexedConverter<TInput, TOutput>(TInput element, int index);

	internal static IList<TOutput> ConvertAndMakeReadOnly<TInput, TOutput>(IList<TInput> input, IndexedConverter<TInput, TOutput> converter)
	{
		TOutput[] array = new TOutput[input.Count];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = converter(input[i], i);
		}
		return new ReadOnlyCollection<TOutput>(array);
	}
}
