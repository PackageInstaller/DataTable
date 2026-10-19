using System;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;

namespace Com.ForbiddenByte.OSA.CustomParams;

[Serializable]
public abstract class BaseParamsWithPrefabAndLazyData<TData> : BaseParamsWithPrefab
{
	public LazyList<TData> Data { get; set; }

	public Func<int, TData> NewModelCreator { get; set; }

	public override void InitIfNeeded(IOSA iAdapter)
	{
		base.InitIfNeeded(iAdapter);
		if (Data == null)
		{
			Data = new LazyList<TData>(NewModelCreator, 0);
		}
	}
}
