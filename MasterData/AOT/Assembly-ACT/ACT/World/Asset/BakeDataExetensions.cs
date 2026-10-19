using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace ACT.World.Asset;

public static class BakeDataExetensions
{
	public static void Bake<T>(this IEnumerable<T> bakeDatas, object baker) where T : IDataToBake
	{
	}

	public static JArray ToArrayToken<T>(this IEnumerable<T> bakeDatas) where T : IDataToBake
	{
		return new JArray();
	}

	public static JObject RefArrayToObjectToken<TMonoBaker, TData>(this IEnumerable<MonoDataRef<TMonoBaker, TData>> bakeDatas) where TMonoBaker : MonoDataBaker where TData : IDataToBake
	{
		return new JObject();
	}
}
