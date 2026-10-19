using System;
using UnityEngine;

namespace ACT.World.Asset;

public abstract class DataBaker : IDataBaker
{
	public object baker { get; set; }

	public abstract Type DataType { get; }

	public abstract IDataToBake LastBakedData { get; }
}
[Serializable]
public class DataBaker<T> : DataBaker where T : IDataToBake
{
	[SerializeField]
	public T configData = (T)Activator.CreateInstance(typeof(T));

	public sealed override Type DataType => typeof(T);

	public sealed override IDataToBake LastBakedData => configData;
}
