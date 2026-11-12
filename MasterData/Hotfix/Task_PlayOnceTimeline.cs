using UnityEngine;
using UnityEngine.Playables;

[AddComponentMenu("触发器结果/表现事件/播放一次性Timeline", 5)]
public class Task_PlayOnceTimeline : TaskCellBase
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

	public bool playFromStart;

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
		Play();
	}

	protected void Play()
	{
		_timelineDirector.gameObject.SetActive(value: true);
		if (_timelineDirector.timeUpdateMode != DirectorUpdateMode.GameTime)
		{
			_timelineDirector.timeUpdateMode = DirectorUpdateMode.GameTime;
		}
		if (playFromStart)
		{
			if (_timelineDirector.state == PlayState.Playing)
			{
				_timelineDirector.Pause();
			}
			_timelineDirector.initialTime = 0.0;
			_timelineDirector.time = 0.0;
		}
		_timelineDirector.Play();
		EndAction();
	}
}
