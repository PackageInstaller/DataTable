using System;
using System.Collections.Generic;

namespace ACT.Core;

public sealed class MulAddFormula : IPropertyFormula
{
	public static readonly MulAddFormula Instance = new MulAddFormula();

	public PropertyChannelMask SupportedChannels => PropertyChannelMask.All;

	public float Calculate(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, out float baseValue, out float addValue, out float mulValue)
	{
		baseValue = Sum(baseProviders);
		addValue = Sum(addProviders);
		mulValue = 1f + Sum(mulProviders);
		return baseValue * mulValue + addValue;
	}

	public float CalculateFiltered(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, Func<IPropertyProvider, bool> baseFilter, Func<IPropertyProvider, bool> addFilter, Func<IPropertyProvider, bool> mulFilter)
	{
		float num = SumFiltered(baseProviders, baseFilter);
		float num2 = SumFiltered(addProviders, addFilter);
		float num3 = 1f + SumFiltered(mulProviders, mulFilter);
		return num * num3 + num2;
	}

	public float CalculateBaseFiltered(List<IPropertyProvider> baseProviders, Func<IPropertyProvider, bool> filter)
	{
		return SumFiltered(baseProviders, filter);
	}

	private static float Sum(List<IPropertyProvider> list)
	{
		float num = 0f;
		for (int i = 0; i < list.Count; i++)
		{
			num += list[i].value();
		}
		return num;
	}

	private static float SumFiltered(List<IPropertyProvider> list, Func<IPropertyProvider, bool> filter)
	{
		float num = 0f;
		for (int i = 0; i < list.Count; i++)
		{
			if (filter == null || filter(list[i]))
			{
				num += list[i].value();
			}
		}
		return num;
	}
}
