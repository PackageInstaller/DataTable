using System.Collections.Generic;
using System.Linq;

namespace ACT;

public class ListConvert
{
	public static List<TBase> ConvertToBase<TDerived, TBase>(List<TDerived> derivedList) where TDerived : class, TBase where TBase : class
	{
		return derivedList.Cast<TBase>().ToList();
	}
}
