using System;

namespace Newtonsoft.Json.Linq;

public class JsonMergeSettings
{
	private MergeArrayHandling _mergeArrayHandling;

	private MergeNullValueHandling _mergeNullValueHandling;

	private StringComparison _propertyNameComparison;

	public MergeArrayHandling MergeArrayHandling => _mergeArrayHandling;

	public MergeNullValueHandling MergeNullValueHandling => _mergeNullValueHandling;

	public StringComparison PropertyNameComparison => _propertyNameComparison;
}
