using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationCrocodileCharacterSelect : T0InterationBaseData
{
	public string selectAnim;

	private T0WorldInteractionBehavior runBehaviour;

	public override bool isNeedSDK => true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private int GetRandomIndex()
	{
		int playCount = T0CrocodileGame.crocodileGame.context.playCount;
		int count = T0CrocodileGame.crocodileGame.context.itemList.Count;
		int num = UnityEngine.Random.Range(0, count - playCount);
		int num2 = 0;
		for (int i = 0; i < count; i++)
		{
			if (!T0CrocodileGame.crocodileGame.context.itemList[i].isPress)
			{
				if (num2 == num)
				{
					return i;
				}
				num2++;
			}
		}
		return 0;
	}

	private void PlaySelectAnim()
	{
		int randomIndex = GetRandomIndex();
		T0CrocodileGame.crocodileGame.PressTargetIndex(randomIndex);
		runBehaviour.PlayTimeline(selectAnim, out var _, out var _);
		base.IsFinish = true;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		runBehaviour = behaviour;
		PlaySelectAnim();
	}

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		if (!(T0CrocodileGame.crocodileGame == null))
		{
			string waitSelectSDKStr = T0CrocodileGame.crocodileGame.GetWaitSelectSDKStr();
			int currentPressIndex = T0CrocodileGame.crocodileGame.GetCurrentPressIndex();
			T0SDKData baseSDKData = GetBaseSDKData();
			baseSDKData.select_param = currentPressIndex.ToString();
			baseSDKData.select_list = waitSelectSDKStr;
			T0SDKSystem.SendSDKData(behaviour, baseSDKData);
		}
	}

	public new virtual void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		Dispose();
	}

	public new virtual void DisposeEvent()
	{
		Dispose();
	}

	private void Dispose()
	{
		runBehaviour = null;
	}
}
