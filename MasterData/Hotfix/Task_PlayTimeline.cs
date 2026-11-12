using UnityEngine;
using UnityEngine.Playables;

[AddComponentMenu("触发器结果/表现事件/播放过场动画", 5)]
public class Task_PlayTimeline : TaskCellBase
{
	public enum PlayableType
	{
		[InspectorName("动画引用")]
		instance,
		[InspectorName("动画路径")]
		path
	}

	public PlayableType playableType;

	public PlayableDirector timelineDirector;

	public string timelineDirectorPath;

	public bool waitUntilFinish;

	private PlayableDirector _timelineDirector;

	protected override void OnExecute()
	{
		switch (playableType)
		{
		case PlayableType.instance:
			if (timelineDirector == null)
			{
				LogWarning("未配置");
				EndAction(success: false);
				return;
			}
			_timelineDirector = timelineDirector;
			break;
		case PlayableType.path:
			if (string.IsNullOrEmpty(timelineDirectorPath))
			{
				LogWarning("未配置");
				EndAction(success: false);
				return;
			}
			_timelineDirector = GameObject.Find(timelineDirectorPath)?.GetComponent<PlayableDirector>();
			if (_timelineDirector == null)
			{
				LogWarning("未配置");
				EndAction(success: false);
				return;
			}
			break;
		}
		SceneSingleton<PerformManager>.Instance.PlayTimelinePerform(_timelineDirector.gameObject, OnTimelineStop);
	}

	protected override void LogicUpdate()
	{
		if (!waitUntilFinish)
		{
			EndAction();
		}
	}

	protected void OnTimelineStop(bool success)
	{
		EndAction();
	}
}
