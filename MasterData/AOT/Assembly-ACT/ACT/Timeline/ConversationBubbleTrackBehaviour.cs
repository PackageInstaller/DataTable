using ACT.UI;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ConversationBubbleTrackBehaviour : PlayableBehaviour
{
	public Vector3 offset;

	public MonoConversationBubbles.BubbleController bubble;

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			Playable input = playable.GetInput(i);
			if (input.GetPlayableType() == typeof(ConversationBubbleBehaviour))
			{
				((ScriptPlayable<ConversationBubbleBehaviour>)input).GetBehaviour().track = this;
			}
			else if (input.GetPlayableType() == typeof(ConversationBubbleHideBehaviour))
			{
				((ScriptPlayable<ConversationBubbleHideBehaviour>)input).GetBehaviour().track = this;
			}
		}
		MonoConversationBubbles monoConversationBubbles = (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) as MonoConversationView)?.bubbles;
		if (monoConversationBubbles != null)
		{
			bubble = monoConversationBubbles.SpawnBubble();
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		bubble.Release();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (bubble.IsValid())
		{
			GameObject gameObject = playerData as GameObject;
			if (gameObject != null)
			{
				bubble.UpdateTargetPosition(gameObject.transform.position + offset);
			}
		}
	}
}
