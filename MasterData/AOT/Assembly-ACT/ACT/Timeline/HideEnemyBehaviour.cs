using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class HideEnemyBehaviour : PlayableBehaviour
{
	public static List<Renderer> renderers = new List<Renderer>();

	public Dictionary<Renderer, bool> record = new Dictionary<Renderer, bool>();

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		record.Clear();
		Singleton<GameManager>.instance.ecsManager.ForEachEntities((Entity entity) =>
		{
			EntityType entityType = entity.GetEntityType();
			if ((uint)(entityType - 2) <= 1u || entityType == EntityType.Elite)
			{
				entity.GetMono().GetComponentsInChildren(includeInactive: true, renderers);
				foreach (Renderer renderer in renderers)
				{
					if (renderer.enabled)
					{
						record[renderer] = renderer.enabled;
						renderer.enabled = false;
					}
				}
				renderers.Clear();
			}
		});
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		foreach (KeyValuePair<Renderer, bool> item in record)
		{
			if ((bool)item.Key)
			{
				item.Key.enabled = true;
			}
		}
		record.Clear();
	}
}
