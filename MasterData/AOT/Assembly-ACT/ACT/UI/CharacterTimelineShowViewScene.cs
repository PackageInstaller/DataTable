using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Rendering;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.UI;

public class CharacterTimelineShowViewScene : BaseUIScene
{
	[SerializeField]
	private Transform timelineRoot;

	private AssetLoadHandle _timelineHandle;

	private GameObject _timelineInstance;

	private PlayableDirector _timelineDirector;

	private int _playSessionId;

	private GameRenderScene.Scene _previousRenderScene;

	private bool _hasPreviousRenderScene;

	private CommonAcquireCharacterShowView _commonAcquireCharacterShowView;

	public override void Open()
	{
		_commonAcquireCharacterShowView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW) as CommonAcquireCharacterShowView;
		_previousRenderScene = GameRenderScene.Current;
		_hasPreviousRenderScene = true;
		GameRenderScene.Set(GameRenderScene.Scene.CardDraw);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
		base.Open();
	}

	public override void Close()
	{
		StopCharacterTimeline();
		RestorePreviousRenderScene();
		base.Close();
	}

	public override void OnRelease()
	{
		StopCharacterTimeline();
		RestorePreviousRenderScene();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
		base.OnRelease();
	}

	private void RestorePreviousRenderScene()
	{
		if (_hasPreviousRenderScene)
		{
			GameRenderScene.Set(_previousRenderScene);
			_hasPreviousRenderScene = false;
		}
	}

	public async UniTask<bool> PlayCharacterTimelineAsync(int characterItemId, int quality)
	{
		StopCharacterTimeline();
		int sessionId = ++_playSessionId;
		string characterTimelinePath = GetCharacterTimelinePath(characterItemId);
		if (string.IsNullOrEmpty(characterTimelinePath) || timelineRoot == null)
		{
			return false;
		}
		AssetLoadHandle handle = (_timelineHandle = AssetStationManager.BattleStation.InstantiateAsync(characterTimelinePath, timelineRoot));
		await handle;
		if (sessionId != _playSessionId || this == null || !gameObject || !AssetLoadHandleExtensions.IsValid(handle))
		{
			if (AssetLoadHandleExtensions.IsValid(handle))
			{
				AssetStationManager.BattleStation.ReleaseInstance(handle);
			}
			return false;
		}
		_timelineInstance = handle.AsGameObject();
		_timelineDirector = ((_timelineInstance != null) ? _timelineInstance.GetComponent<PlayableDirector>() : null);
		if (_timelineInstance == null || _timelineDirector == null)
		{
			StopCharacterTimeline();
			return false;
		}
		_timelineInstance.SetActive(value: false);
		_timelineInstance.transform.SetParent(timelineRoot, worldPositionStays: false);
		BindTimeline(_timelineInstance, _timelineDirector);
		_timelineInstance.SetActive(value: true);
		_timelineDirector.time = 0.0;
		_commonAcquireCharacterShowView.GoBlack.SetActive(value: false);
		_timelineDirector.Play();
		_commonAcquireCharacterShowView?.PlayAcquireCharacterTimelineSound(quality);
		return true;
	}

	public void StopCharacterTimeline()
	{
		_commonAcquireCharacterShowView?.StopAcquireCharacterTimelineSound();
		_playSessionId++;
		_timelineDirector?.Stop();
		_timelineDirector = null;
		_timelineInstance = null;
		if (AssetLoadHandleExtensions.IsValid(_timelineHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_timelineHandle);
			_timelineHandle = default;
		}
	}

	private static string GetCharacterTimelinePath(int characterItemId)
	{
		ItemData data = CoreUtils.GetData(characterItemId, RuntimeConfigs.data.itemDatas);
		if (data == null || data.canBeTransited == null || data.canBeTransited.Count == 0)
		{
			return string.Empty;
		}
		EntityCharacterData data2 = CoreUtils.GetData(data.canBeTransited[0].id, RuntimeConfigs.data.entityCharacterDatas);
		if (data2 != null)
		{
			return data2.timelinePath;
		}
		return string.Empty;
	}

	private static void BindTimeline(GameObject timelineInstance, PlayableDirector director)
	{
		MonoTimelineConfig component = timelineInstance.GetComponent<MonoTimelineConfig>();
		if (!(component == null))
		{
			if (component.timelineConfig.useNewAssetsBindings)
			{
				TimelineTrackBinding.SetTrackBinding(director, component.timelineConfig.newAssetsBindings);
			}
			else
			{
				OldTimelineTrackBinding.SetTrackBinding(director, component.timelineConfig.assetsBindings);
			}
		}
	}
}
