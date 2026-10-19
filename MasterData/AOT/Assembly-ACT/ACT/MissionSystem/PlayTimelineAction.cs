using System;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Rendering;
using Cysharp.Threading.Tasks;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.MissionSystem;

public class PlayTimelineAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		GameRenderScene.Scene? previousRenderScene = null;
		DramaTimelineData timelineData;
		try
		{
			PlayTimelineActionParam playTimelineActionParam = Param as PlayTimelineActionParam;
			if (RuntimeConfigs.data.dramaTimelineDatas.TryGetValue(playTimelineActionParam.timelineId, out timelineData))
			{
				PlayableDirector timelineImmediately = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(timelineData.content);
				MonoTimelineConfig component = timelineImmediately.GetComponent<MonoTimelineConfig>();
				if (component.timelineConfig.useNewAssetsBindings)
				{
					TimelineTrackBinding.SetTrackBinding(timelineImmediately, component.timelineConfig.newAssetsBindings);
				}
				else
				{
					OldTimelineTrackBinding.SetTrackBinding(timelineImmediately, component.timelineConfig.assetsBindings);
				}
				previousRenderScene = GameRenderScene.Current;
				GameRenderScene.Set(GameRenderScene.Scene.SceneTimeline);
				timelineImmediately.stopped += OnTimelineStopped;
				timelineImmediately.Play();
			}
		}
		catch (Exception message)
		{
			if (previousRenderScene.HasValue && GameRenderScene.Current == GameRenderScene.Scene.SceneTimeline)
			{
				GameRenderScene.Set(previousRenderScene.Value);
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
		return UniTask.CompletedTask;
		void OnTimelineStopped(PlayableDirector director)
		{
			director.stopped -= OnTimelineStopped;
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(timelineData.content);
			if (GameRenderScene.Current == GameRenderScene.Scene.SceneTimeline)
			{
				GameRenderScene.Set(previousRenderScene.Value);
			}
		}
	}
}
