using System.Collections.Generic;
using ACT.UI.DataProxy;

namespace ACT.Model;

public class GiftComparer : IComparer<ItemUnifierProxy>
{
	private int _characterId;

	public void SetCharacterId(int characterId)
	{
		_characterId = characterId;
	}

	public int Compare(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		GiftPreference giftPreference = Model<FavorabilityModel>.Interface.GetGiftPreference(x.Id, _characterId);
		GiftPreference giftPreference2 = Model<FavorabilityModel>.Interface.GetGiftPreference(y.Id, _characterId);
		if (giftPreference != giftPreference2)
		{
			return giftPreference2.CompareTo(giftPreference);
		}
		return y.Quality.CompareTo(x.Quality);
	}
}
