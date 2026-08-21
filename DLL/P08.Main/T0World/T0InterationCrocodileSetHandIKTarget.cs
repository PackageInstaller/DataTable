using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationCrocodileSetHandIKTarget : T0InterationBaseData
{
	public string targetNodeName = "X206a/scene/jh/104402_prop_shayuwanju/ikpos";

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0CharacterAgent t0CharacterAgent = behaviour.mAgent as T0CharacterAgent;
		if (t0CharacterAgent == null || t0CharacterAgent.CharacterBoard == null || t0CharacterAgent.CharacterBoard.ikBehavior == null)
		{
			base.IsFinish = true;
			return;
		}
		T0CharacterIkBehavior ikBehavior = t0CharacterAgent.CharacterBoard.ikBehavior;
		GameObject gameObject = GameObject.Find(targetNodeName);
		if (gameObject != null && T0CrocodileGame.crocodileGame != null)
		{
			int currentPressIndex = T0CrocodileGame.crocodileGame.GetCurrentPressIndex();
			if (currentPressIndex > 0 && currentPressIndex <= gameObject.transform.childCount)
			{
				Transform target = gameObject.transform.GetChild(currentPressIndex - 1);
				ikBehavior.bipedIk.solvers.rightHand.target = target;
			}
		}
		base.IsFinish = true;
	}
}
