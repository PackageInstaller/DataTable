using System;
using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.CustomParams;

[Serializable]
public class BaseParamsWithPrefabAndData<TData> : BaseParamsWithPrefab
{
	private List<TData> _Data = new List<TData>();

	public List<TData> Data
	{
		get
		{
			return _Data;
		}
		set
		{
			_Data = value;
		}
	}
}
