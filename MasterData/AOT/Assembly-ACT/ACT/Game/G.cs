using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Game;

public static class G
{
	public static IGameService service;

	public static Player localPlayer;

	public static DetailUserInfo detailUserInfo;

	public static long TryGetAttribute(int key)
	{
		return detailUserInfo.Attributes.GetValueOrDefault(key, 0L);
	}
}
