using System;
using ACT.Battle.ECS.System.SystemNPC;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public class GetNpcTrackObject : GetTrackObjectBase
{
	public override void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = null;
		if (!int.TryParse(trackData, out var result))
		{
			return;
		}
		Entity entity = default;
		if (Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.ContainsKey(result))
		{
			entity = Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary[result];
		}
		if (entity.IsValid)
		{
			if (type == typeof(Animator))
			{
				SetAnimator(pd, entity.GetCompNpc().Animator, outputIndex, out trackObject);
			}
			else if (type == typeof(Transform))
			{
				trackObject = entity.GetRootTransform();
			}
			else if (type == typeof(GameObject))
			{
				trackObject = entity.GetRoot();
			}
			else if (type == typeof(SignalReceiver))
			{
				trackObject = entity.GetRoot().GetComponentInChildren<SignalReceiver>();
			}
		}
	}
}
