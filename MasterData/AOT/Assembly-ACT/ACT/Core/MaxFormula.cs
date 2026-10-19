using System;
using System.Collections.Generic;

namespace ACT.Core;

public sealed class MaxFormula : IPropertyFormula
{
	public static readonly MaxFormula Instance = new MaxFormula();

	public PropertyChannelMask SupportedChannels => PropertyChannelMask.Max;

	public float Calculate(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, out float baseValue, out float addValue, out float mulValue)
	{
		addValue = 0f;
		mulValue = 0f;
		baseValue = 0f;
		for (int i = 0; i < baseProviders.Count; i++)
		{
			float num = baseProviders[i].value();
			if (num > baseValue)
			{
				baseValue = num;
			}
		}
		return baseValue;
	}

	public float CalculateFiltered(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, Func<IPropertyProvider, bool> baseFilter, Func<IPropertyProvider, bool> addFilter, Func<IPropertyProvider, bool> mulFilter)
	{
		float num = 0f;
		for (int i = 0; i < baseProviders.Count; i++)
		{
			if (baseFilter == null || baseFilter(baseProviders[i]))
			{
				float num2 = baseProviders[i].value();
				if (num2 > num)
				{
					num = num2;
				}
			}
		}
		return num;
	}

	public float CalculateBaseFiltered(List<IPropertyProvider> baseProviders, Func<IPropertyProvider, bool> filter)
	{
		return CalculateFiltered(baseProviders, null, null, filter, null, null);
	}
}
