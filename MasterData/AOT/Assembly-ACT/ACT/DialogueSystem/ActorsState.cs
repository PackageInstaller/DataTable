using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class ActorsState : DialogueState
{
	private int m_StageMode;

	public StageActorState[] m_StageActorStates = new StageActorState[4];

	private UniTask ApplyImmediate(CancellationToken token)
	{
		UIConversationScene instance = UIConversationScene.Instance;
		if (!instance)
		{
			return UniTask.CompletedTask;
		}
		return instance.ActorsTask(m_StageMode, m_StageActorStates, token);
	}

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		return ApplyImmediate(token);
	}

	public UniTask ApplyChange(int newStageMode, StageActorState[] newStageActorStates, CancellationToken token, bool skipping)
	{
		if (newStageMode > 0)
		{
			m_StageMode = newStageMode;
		}
		for (int i = 0; i < m_StageActorStates.Length; i++)
		{
			if (i >= newStageActorStates.Length)
			{
				m_StageActorStates[i] = default;
				continue;
			}
			StageActorState stageActorState = newStageActorStates[i];
			UIConversationScene.StageActorLookAtType lookAtType = stageActorState.lookAtType;
			if (lookAtType == UIConversationScene.StageActorLookAtType.Keep)
			{
				lookAtType = m_StageActorStates[i].lookAtType;
			}
			m_StageActorStates[i] = new StageActorState
			{
				actor = stageActorState.actor,
				actorAnimName = stageActorState.actorAnimName,
				actorFaceName = stageActorState.actorFaceName,
				emoji = stageActorState.emoji,
				lookAtType = lookAtType,
				positionOffset = stageActorState.positionOffset,
				rotationYOffset = stageActorState.rotationYOffset,
				scaleOffset = stageActorState.scaleOffset
			};
		}
		if (!skipping)
		{
			return ApplyImmediate(token);
		}
		return UniTask.CompletedTask;
	}
}
