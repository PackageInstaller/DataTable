using System;
using ACT.Battle;
using ACT.Game;
using Bamboo.ECS;
using Cinemachine;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public class GetPlayerTrackObject : GetTrackObjectBase
{
	public override void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = null;
		if (!int.TryParse(trackData, out var result))
		{
			return;
		}
		Entity entity = default;
		if (result == 0)
		{
			entity = MonoECS.instance.mainEntity;
		}
		else
		{
			EntityHelper.TryGetBattleEntityByCharacter(G.localPlayer.GetCharacter(result), out entity);
		}
		if (entity.IsValid)
		{
			if (type == typeof(Animator))
			{
				SetAnimator(pd, entity.GetCompBehave().Animator, outputIndex, out trackObject);
			}
			else if (type == typeof(Transform))
			{
				trackObject = entity.GetRootTransform();
			}
			else if (type == typeof(GameObject))
			{
				trackObject = entity.GetModel();
			}
			else if (type == typeof(SignalReceiver))
			{
				trackObject = entity.GetRoot().GetComponentInChildren<SignalReceiver>();
			}
			else if (type == typeof(CinemachineBrain))
			{
				SetCinemachineBrain(pd, pb, entity.GetRootTransform());
			}
		}
	}
}
