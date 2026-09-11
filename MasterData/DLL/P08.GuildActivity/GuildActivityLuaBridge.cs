using System;
using UnityEngine;

public class GuildActivityLuaBridge : MonoBehaviour
{
	public static void Launcher(GuildActivityDataForExchange musicDataForExchange, Action onStart, Action callback)
	{
		onStart?.Invoke();
		GuildActivitySceneLoader guildActivitySceneLoader = NScene.Load<GuildActivitySceneLoader>();
		guildActivitySceneLoader.SetGameConfig(musicDataForExchange);
		guildActivitySceneLoader.SetOnLoadSceneComplete(delegate
		{
			if (callback != null)
			{
				callback();
			}
		});
	}

	public static void StartGuildActivity(int enterNodeId)
	{
		(NScene.GetCurrentScene() as GuildActivitySceneLoader).StartGuildActivity(enterNodeId);
	}

	public static GuildActivityManager GetManager()
	{
		GuildActivitySceneLoader guildActivitySceneLoader = NScene.GetCurrentScene() as GuildActivitySceneLoader;
		if (guildActivitySceneLoader != null)
		{
			return guildActivitySceneLoader.GetManager();
		}
		return null;
	}
}
