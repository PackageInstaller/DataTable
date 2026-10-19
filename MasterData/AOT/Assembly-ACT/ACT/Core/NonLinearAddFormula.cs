using System;
using System.Collections.Generic;

namespace ACT.Core;

public sealed class NonLinearAddFormula : IPropertyFormula
{
	public static readonly NonLinearAddFormula Instance = new NonLinearAddFormula();

	public PropertyChannelMask SupportedChannels => PropertyChannelMask.Base;

	public float Calculate(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, out float baseValue, out float addValue, out float mulValue)
	{
		addValue = 0f;
		mulValue = 0f;
		baseValue = 0f;
		float num = 1f;
		for (int i = 0; i < baseProviders.Count; i++)
		{
			float num2 = baseProviders[i].value();
			baseValue += num * num2;
			num = 1f - baseValue;
		}
		return baseValue;
	}

	public float CalculateFiltered(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, Func<IPropertyProvider, bool> baseFilter, Func<IPropertyProvider, bool> addFilter, Func<IPropertyProvider, bool> mulFilter)
	{
		float num = 0f;
		float num2 = 1f;
		for (int i = 0; i < baseProviders.Count; i++)
		{
			if (baseFilter == null || baseFilter(baseProviders[i]))
			{
				float num3 = baseProviders[i].value();
				num += num2 * num3;
				num2 = 1f - num;
			}
		}
		return num;
	}

	public float CalculateBaseFiltered(List<IPropertyProvider> baseProviders, Func<IPropertyProvider, bool> filter)
	{
		return CalculateFiltered(baseProviders, null, null, filter, null, null);
	}
}
