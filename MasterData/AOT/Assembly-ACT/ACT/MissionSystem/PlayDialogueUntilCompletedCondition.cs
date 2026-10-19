using System;
using ACT.Battle;
using ACT.Drama;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class PlayDialogueUntilCompletedCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		_ = 1;
		try
		{
			PlayDialogueUntilCompletedConditionParam param = Param as PlayDialogueUntilCompletedConditionParam;
			if (param.waitIdle)
			{
				await WaitIdle();
				if (!IsActive)
				{
					return;
				}
			}
			AVGDialogueFromId.Options options = new AVGDialogueFromId.Options
			{
				BlackScreen = param.blackScreenIn,
				FadeInTime = param.blackScreenInTime,
				WaitIdle = param.waitIdle
			};
			if (await Singleton<ConversationManager>.instance.BeginConversation(param.storyGroupId, ConversationManager.ConversationTriggerSource.Mission, options))
			{
				MarkSuccess();
			}
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
	}

	private async UniTask WaitIdle()
	{
		while (IsActive)
		{
			if (!MonoECS.instance)
			{
				continue;
			}
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity == null)
			{
				await UniTask.Yield();
				continue;
			}
			CompMotion compMotion = mainEntity.GetCompMotion();
			CompPhysics compPhysics = mainEntity.GetCompPhysics();
			if (compMotion == null || compPhysics == null)
			{
				await UniTask.Yield();
				continue;
			}
			if (compPhysics.isGrounded)
			{
				break;
			}
			await UniTask.Yield();
		}
	}
}
