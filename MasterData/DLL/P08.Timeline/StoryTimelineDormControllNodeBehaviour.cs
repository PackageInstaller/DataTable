using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineDormControllNodeBehaviour : PlayableBehaviour
{
	public bool isBeginStory;

	public int flag;

	public int[] actors;

	private bool m_hasNotify;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying && !m_hasNotify)
		{
			if (isBeginStory)
			{
				BeginStory();
			}
			else
			{
				FinishStory();
			}
			m_hasNotify = true;
		}
	}

	internal static void Notify(string notifyEvent, int value)
	{
		LuaHelper.GetFunc("Dorm.InvokeEvent")?.Call(notifyEvent, value);
	}

	public void BeginStory()
	{
		Notify("ON_BEGIN_STORY", flag);
	}

	public void FinishStory()
	{
		Notify("ON_FINISH_STORY", flag);
	}
}
