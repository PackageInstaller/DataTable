using System;

namespace RogueCard;

public static class RogueCardEvent
{
	public static event Action<int> SelectCard;

	public static void CallSelectCard(int index)
	{
		SelectCard?.Invoke(index);
	}
}
