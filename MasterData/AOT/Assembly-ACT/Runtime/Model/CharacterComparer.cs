using System.Collections.Generic;
using ACT.Game.Data;
using ACT.Model;

namespace Runtime.Model;

public class CharacterComparer : IComparer<Character>
{
	public int Compare(Character x, Character y)
	{
		int id = x.Id;
		int id2 = y.Id;
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(id);
		(int, int) characterFavorInfo2 = Model<LoungeModel>.Interface.GetCharacterFavorInfo(id2);
		int item = characterFavorInfo.Item1;
		int item2 = characterFavorInfo2.Item1;
		int item3 = characterFavorInfo.Item2;
		int item4 = characterFavorInfo2.Item2;
		LoungeInteractPointUseType characterStateInLounge = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(id);
		LoungeInteractPointUseType characterStateInLounge2 = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(id2);
		int statePriority = Model<InviteCharacterModel>.Interface.GetStatePriority(characterStateInLounge);
		int statePriority2 = Model<InviteCharacterModel>.Interface.GetStatePriority(characterStateInLounge2);
		if (statePriority != statePriority2)
		{
			return statePriority.CompareTo(statePriority2);
		}
		if (item != item2)
		{
			return item2.CompareTo(item);
		}
		if (item3 != item4)
		{
			return item4.CompareTo(item3);
		}
		return id.CompareTo(id2);
	}
}
