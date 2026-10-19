using System;

namespace ACT.UI;

public abstract class BookViewBaseModel
{
	public Type CachedType { get; private set; }

	public bool Unlock { get; set; }

	public int PrefabIndex { get; }

	public int Id { get; }

	protected BookViewBaseModel(int id, int index)
	{
		CachedType = GetType();
		PrefabIndex = index;
		Id = id;
	}
}
