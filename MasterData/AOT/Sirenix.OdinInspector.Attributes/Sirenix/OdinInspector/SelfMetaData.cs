using System.Collections.Generic;

namespace Sirenix.OdinInspector;

public class SelfMetaData : List<SelfValidationResult.ResultItemMetaData>
{
	public void Add(string key, object value)
	{
		Add(new SelfValidationResult.ResultItemMetaData(key, value));
	}
}
