using System;
using ACT.Game.Data;

namespace ACT.Game;

[Serializable]
public struct stackableItem
{
	public int id;

	public int count;

	public Item ToPB()
	{
		return new Item
		{
			Id = id,
			Count = count
		};
	}
}
