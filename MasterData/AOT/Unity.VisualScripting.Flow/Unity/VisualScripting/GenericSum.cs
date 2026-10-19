using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

[UnitTitle("Add")]
[UnitCategory("Math/Generic")]
public sealed class GenericSum : Sum<object>
{
	public override object Operation(object a, object b)
	{
		return OperatorUtility.Add(a, b);
	}

	public override object Operation(IEnumerable<object> values)
	{
		List<object> list = values.ToList();
		object obj = OperatorUtility.Add(list[0], list[1]);
		for (int i = 2; i < list.Count; i++)
		{
			obj = OperatorUtility.Add(obj, list[i]);
		}
		return obj;
	}
}
