using System.Threading;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Drama;

public class BackgroundTimelineManager : Singleton<BackgroundTimelineManager>
{
	private CancellationTokenSource _cts;

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		_cts = new CancellationTokenSource();
	}

	public override void UnInit()
	{
		_cts.Cancel();
		_cts.Dispose();
		_cts = null;
	}

	public async UniTask PlayBackgroundTimeline(int id, PlayTimelineConfig? config = null)
	{
		string content = RuntimeConfigs.data.dramaTimelineDatas[id].content;
		if (!string.IsNullOrEmpty(content))
		{
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(content);
			await handle;
			GameObject gameObject = handle.AsGameObject();
			gameObject.SetActive(value: true);
			MonoTimelineConfig component = gameObject.GetComponent<MonoTimelineConfig>();
			PlayableDirector component2 = gameObject.GetComponent<PlayableDirector>();
			if (component.timelineConfig.useNewAssetsBindings)
			{
				TimelineTrackBinding.SetTrackBinding(component2, component.timelineConfig.newAssetsBindings);
			}
			else
			{
				OldTimelineTrackBinding.SetTrackBinding(component2, component.timelineConfig.assetsBindings);
			}
			bool stop = false;
			component2.Play();
			component2.stopped += (PlayableDirector director) =>
			{
				stop = true;
			};
			await UniTask.WaitUntil(() => stop, PlayerLoopTiming.Update, _cts.Token);
			AssetStationManager.BattleStation.ReleaseInstance(handle);
		}
	}
}
