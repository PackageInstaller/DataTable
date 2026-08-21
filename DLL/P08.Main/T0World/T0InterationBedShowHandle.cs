using System;
using Cinemachine;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationBedShowHandle : T0InterationBedSelectBase
{
	public string beginAni = string.Empty;

	private CinemachineBrain brain;

	public override bool isNeedSDK => true;

	public override T0BedClickType GetSelectType()
	{
		return T0BedClickType.SELECT_HANDLE;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
		T0BedGame.bedGame.PlayEnterHandleAni();
		beginAni = T0BedGame.bedGame.GetHandleBeginAni();
		T0BedGame.bedGame.SetModeUIType(BedSelectEnum.handle);
		if (brain == null)
		{
			brain = Camera.main.GetComponent<CinemachineBrain>();
		}
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		if (behaviour.executePlayable != null && behaviour.executePlayable.time > 0.10000000149011612 && !brain.IsBlending)
		{
			T0BedGame.bedGame.ShowHandleClickPoint();
			base.IsFinish = true;
		}
	}

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		if (!(beginAni == string.Empty))
		{
			T0SDKData baseSDKData = GetBaseSDKData();
			baseSDKData.select_param = beginAni;
			T0SDKSystem.SendSDKData(behaviour, baseSDKData);
		}
	}
}
