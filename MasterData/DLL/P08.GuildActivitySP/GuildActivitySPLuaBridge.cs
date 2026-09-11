using System;
using UnityEngine;

public class GuildActivitySPLuaBridge : MonoBehaviour
{
	public static void Launcher(GuildActivitySPDataForExchange musicSpDataForExchange, Action onStart, Action callback)
	{
		onStart?.Invoke();
		GuildActivitySPSceneLoader guildActivitySPSceneLoader = NScene.Load<GuildActivitySPSceneLoader>();
		guildActivitySPSceneLoader.SetGameConfig(musicSpDataForExchange);
		guildActivitySPSceneLoader.SetOnLoadSceneComplete(delegate
		{
			if (callback != null)
			{
				callback();
			}
		});
	}

	public static void MoveCameraAimAtNode(int nodeID, float time = 0.2f, float offset = 0.2f, Action onComplete = null)
	{
		GetManager().MoveCameraToNode(nodeID, time, offset, onComplete);
	}

	public static void PlayNodeAnimation(int nodeID, int action = 1, Action onComplete = null, float time = 2f)
	{
		GuildActivitySPManager manager = GetManager();
		GuildActivitySPWarFieldNode node = manager.GetNode(nodeID);
		if (node != null)
		{
			GuildActivityNodeAnim component = node.GetComponent<GuildActivityNodeAnim>();
			if ((bool)component)
			{
				component.Play(manager.luaData.curNode, action, onComplete, time);
			}
			else
			{
				onComplete?.Invoke();
			}
		}
		else
		{
			onComplete?.Invoke();
		}
	}

	public static void StartGuildActivity(int enterNodeId)
	{
		(NScene.GetCurrentScene() as GuildActivitySPSceneLoader).StartGuildActivity(enterNodeId);
	}

	public static GuildActivitySPManager GetManager()
	{
		GuildActivitySPSceneLoader guildActivitySPSceneLoader = NScene.GetCurrentScene() as GuildActivitySPSceneLoader;
		if (guildActivitySPSceneLoader != null)
		{
			return guildActivitySPSceneLoader.GetManager();
		}
		return null;
	}
}
