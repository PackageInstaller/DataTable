using System;
using System.Threading;
using ACT.Battle;
using ACT.Drama;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class PlayAVGAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		_ = 1;
		try
		{
			PlayAVGActionParam param = Param as PlayAVGActionParam;
			if (token.IsCancellationRequested)
			{
				return;
			}
			if (param.waitIdle)
			{
				await WaitIdle(token);
				if (token.IsCancellationRequested)
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
			await Singleton<ConversationManager>.instance.BeginConversation(param.storyGroupId, ConversationManager.ConversationTriggerSource.Mission, options);
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
	}

	private async UniTask WaitIdle(CancellationToken token)
	{
		while (!token.IsCancellationRequested)
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
