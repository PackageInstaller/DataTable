#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Serialization;

namespace Ase;

public class CustomSignalReceiver : MonoBehaviour, INotificationReceiver
{
	[FormerlySerializedAs("timelineDataContainer")]
	public TimelineDataContainer storyDataContainer;

	private void OnValidate()
	{
		storyDataContainer = GetComponent<TimelineDataContainer>();
	}

	public void OnNotify(Playable origin, INotification notification, object context)
	{
		if ((Object)(object)storyDataContainer == null)
		{
			storyDataContainer = GetComponent<TimelineDataContainer>();
		}
		if ((Object)(object)storyDataContainer == null)
		{
			Log.Error("Timeline自定义信号,没有绑定事件对象");
		}
		else if (notification is EndStorySignalEmitter)
		{
			storyDataContainer.EndStory();
		}
		else if (notification is AudioControlSignalEmitter audioControlSignalEmitter)
		{
			audioControlSignalEmitter.DoExecute();
		}
		else if (notification is StoryPopupSignalEmitter storyPopupSignalEmitter)
		{
			storyPopupSignalEmitter.DoExecute();
		}
	}
}
