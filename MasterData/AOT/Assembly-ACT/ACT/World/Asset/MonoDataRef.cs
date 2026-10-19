using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MonoDataRef<TMonoBaker, TData> : IDataToBake where TMonoBaker : MonoDataBaker where TData : IDataToBake
{
	[SerializeField]
	public TData data;
}
