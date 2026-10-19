using System;
using System.Collections.Generic;

namespace ACT.Core;

public interface IPropertyFormula
{
	PropertyChannelMask SupportedChannels { get; }

	float Calculate(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, out float baseValue, out float addValue, out float mulValue);

	float CalculateFiltered(List<IPropertyProvider> baseProviders, List<IPropertyProvider> addProviders, List<IPropertyProvider> mulProviders, Func<IPropertyProvider, bool> baseFilter, Func<IPropertyProvider, bool> addFilter, Func<IPropertyProvider, bool> mulFilter);

	float CalculateBaseFiltered(List<IPropertyProvider> baseProviders, Func<IPropertyProvider, bool> filter);
}
