using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Rendering;
using Bamboo.AssetField;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.Timeline;

namespace ACT.UI;

public class CardDrawViewScene : BaseUIScene, IPointerDownHandler, IEventSystemHandler, IDragHandler, IPointerUpHandler
{
	private enum CardDrawTouchType
	{
		None,
		Rotate,
		Slide
	}

	public GameObject GoStartTimeLine;

	public GameObject GoCharacterLine;

	[Header("Camera")]
	[SerializeField]
	private CinemachineVirtualCamera MainCamera;

	[SerializeField]
	private CinemachineVirtualCamera CharacterCamera;

	[Header("CharacterTimeLineRoot")]
	[SerializeField]
	private Transform TfCharacterTimeLineRoot;

	[Header("GachaMachine")]
	[SerializeField]
	private GameObject GachaMachineRoot;

	[Header("Machine Rotate")]
	public Transform rotateButton;

	[SerializeField]
	private Collider rotateButtonCollider;

	[Header("旋转速率")]
	[SerializeField]
	private float rotateDragSensitivity = 2f;

	[Header("旋转上限角度")]
	[SerializeField]
	private float rotateButtonMaxYRotation = 360f;

	[Header("UIFollowRightButton")]
	public Transform StartHandle;

	[Header("UIFollowLeft")]
	public Transform LeftHandle;

	[Header("UIFollowMid")]
	public Transform MidHandle;

	[Header("Machine Slide")]
	public Transform slideHandle;

	[SerializeField]
	private Collider slideHandleCollider;

	[Header("滑动速率")]
	[SerializeField]
	private float slideDragSensitivity = 0.2f;

	[Header("滑动最小限制")]
	[SerializeField]
	private float slideHandleMinYRotation = -30f;

	[Header("滑动最大限制")]
	[SerializeField]
	private float slideHandleMaxYRotation = 30f;

	[Header("touch")]
	[SerializeField]
	private GameObject TouchObj;

	[Header("AmplitudeMin")]
	[SerializeField]
	private float WaveAmplitudeMinValue;

	[Header("AmplitudeMax")]
	[SerializeField]
	private float WaveAmplitudeMaxValue = 1f;

	[Header("FrequencyMin")]
	[SerializeField]
	private float WaveFrequencyMinValue = 0.5f;

	[Header("FrequencyMax")]
	[SerializeField]
	private float WaveFrequencyMaxValue = 10f;

	[Header("ImageRoot")]
	[SerializeField]
	private GameObject ImageRoot;

	[Header("IconQuality")]
	[SerializeField]
	private GameObject Qulity;

	[Header("IconProfession")]
	[SerializeField]
	private GameObject Profession;

	[Header("IconBackGround")]
	[SerializeField]
	private GameObject BackGround;

	[Header("Wave")]
	[SerializeField]
	private GameObject Wave;

	[SerializeField]
	private float waveAmplitudeResetValue;

	[SerializeField]
	private float waveFrequencyResetValue = 0.5f;

	[Header("Texture")]
	[SerializeField]
	private Texture QulityS;

	[SerializeField]
	private Texture QulityA;

	[Header("Tape")]
	[SerializeField]
	private List<GachaMachineTape> TapeList = new List<GachaMachineTape>();

	[Header("TfTapeEffect")]
	[SerializeField]
	private List<GachaMachineTape> TapeEffectList = new List<GachaMachineTape>();

	[Header("TfTape")]
	[SerializeField]
	private Transform TfTapeRoot;

	public GameObject SceneLight;

	private const float GamepadSlideSpeed = 60f;

	private const float GamepadStickDeadZone = 0.1f;

	private const float GamepadRotateMinMagnitude = 0.6f;

	private static readonly int WaveAmplitudeId = Shader.PropertyToID("_Amplitude");

	private static readonly int WaveAmpliduteId = Shader.PropertyToID("_Amplidute");

	private static readonly int WaveFrequencyId = Shader.PropertyToID("_Frequency");

	private static readonly int MaterialTextureId = Shader.PropertyToID("_Texture");

	private static readonly int MaterialMainTextureId = Shader.PropertyToID("_MainTex");

	private static readonly string[] StartTimelineQualityTrackNames = new string[3] { "Qulity1", "Qulity2", "Qulity3" };

	private static readonly string[] StartTimelineSoundQualityTrackNames = new string[2] { "Normal", "Gold" };

	private GameObject _startTimelineInstance;

	private PlayableDirector _startTimelineDirector;

	private GameObject _tapeInstance;

	private bool _startTimelineUseStationRelease;

	private bool _startTimelineHideOnRelease;

	private Action _onTimelinePlay;

	private Action _onTimelineFinish;

	private Action _onTimelineSkip;

	private CardDrawPhase _phase;

	private int _characterTimelineFlowId;

	private bool _skipRequested;

	private bool _skipFlowRequested;

	private bool _handlingSkipFlow;

	private List<GachaCardDrawItem> _results;

	private readonly List<CardDrawCharacterShowData> _skipPendingNewCharacters = new List<CardDrawCharacterShowData>();

	private readonly HashSet<int> _playedNewCharacterTimelineIds = new HashSet<int>();

	private List<AssetLoadHandle> _listTextrue = new List<AssetLoadHandle>();

	private CardDrawView _cardDrawView;

	private CardDrawTouchType _activeTouchType;

	private Material _waveMaterial;

	private float _waveAmplitudeValue;

	private float _waveFrequencyValue;

	private float _lastRotatePointerAngle;

	private bool _hasLastRotatePointerAngle;

	private uint _characterGoldId;

	private uint _characterPurpleId;

	private uint _rightSlideLoopSoundId;

	private uint _leftRotationLoopSoundId;

	private int _lastSlideDirection;

	private bool _slideAtBoundary;

	private bool _rotationAtBoundary;

	private int _gamepadSlideDriveFrame;

	private int _gamepadRotateDriveFrame;

	private float _lastNavigateAngle;

	private bool _hasLastNavigateAngle;

	private GameRenderScene.Scene _previousRenderScene;

	private bool _hasPreviousRenderScene;

	public CardDrawPhase Phase => _phase;

	public bool IsStartTimelinePlaying
	{
		get
		{
			if (_phase != CardDrawPhase.PlayingStart)
			{
				return _phase == CardDrawPhase.PlayingCharacter;
			}
			return true;
		}
	}

	public override void Open()
	{
		_previousRenderScene = GameRenderScene.Current;
		_hasPreviousRenderScene = true;
		GameRenderScene.Set(GameRenderScene.Scene.CardDraw);
		base.Open();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
		ResetWaveControls();
	}

	public override void Close()
	{
		StopRightSlideLoopSound();
		StopLeftRotationLoopSound();
		ResetFlowState();
		CleanupStartTimeline(restoreCardDrawView: false);
		DisableUISceneCameraSkipBase();
		RestorePreviousRenderScene();
		base.Close();
	}

	public override void OnRelease()
	{
		ResetFlowState();
		CleanupStartTimeline();
		DisableUISceneCameraSkipBase();
		ReleaseTexture();
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

	public void GetResult()
	{
		_cardDrawView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CARDDRAW) as CardDrawView;
		_results = ((_cardDrawView != null) ? _cardDrawView.GetGachaResults() : null);
		ResetWaveControls();
		CheckResultsListSetQualityTrack();
		SetCamera(isMain: true);
		TouchObj.SetActive(value: true);
		GoStartTimeLine.SetActive(value: false);
		GachaMachineRoot.SetActive(value: true);
		GoCharacterLine.SetActive(value: false);
		uiSceneCamera.GetComponent<CinemachineBrain>().enabled = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
	}

	private void SetCamera(bool isMain)
	{
		MainCamera.gameObject.SetActive(isMain);
		MainCamera.Priority = (isMain ? 310 : 0);
	}

	public void EnableUISceneCameraSkipBase()
	{
		SetUISceneCameraSkipBase(enable: true);
	}

	public void DisableUISceneCameraSkipBase()
	{
		SetUISceneCameraSkipBase(enable: false);
	}

	private void SetUISceneCameraSkipBase(bool enable)
	{
		UniversalRenderPipeline.SetBaseCameraSkip(enable);
	}

	public async UniTask StartCardDraw()
	{
		TouchObj.SetActive(value: false);
		ImageRoot.SetActive(value: false);
		SetCamera(isMain: false);
		if (_phase != CardDrawPhase.Idle)
		{
			return;
		}
		_skipRequested = false;
		if (_results == null || _results.Count == 0)
		{
			GoToRestoreMain();
			return;
		}
		RestAllTape();
		RefreshTapeByResults();
		int maxQuality = CheckResultsListSetQualityTrack();
		_cardDrawView.PlayGachaStartSound(maxQuality);
		ReleaseTapeInstance();
		uiSceneCamera.GetComponent<CinemachineBrain>().enabled = false;
		await RunStartTimelinePhase();
		if (!(await TryHandleSkipFlow()) && !(this == null) && (bool)gameObject)
		{
			_ = _phase;
			_ = 4;
		}
	}

	public void AfterStartShow()
	{
		_phase = CardDrawPhase.Idle;
	}

	private void RefreshTapeByResults()
	{
		if (_results.Count > 1)
		{
			for (int i = 0; i < _results.Count; i++)
			{
				TapeList[i].Refresh(_results[i].PoolItem.GetQuality());
				TapeEffectList[i].Refresh(_results[i].PoolItem.GetQuality());
				TapeList[i].gameObject.SetActive(value: true);
			}
			return;
		}
		for (int j = 0; j < TapeList.Count; j++)
		{
			TapeList[j].gameObject.SetActive(j == 2);
			if (j == 2)
			{
				TapeList[j].Refresh(_results[0].PoolItem.GetQuality());
				TapeEffectList[j].Refresh(_results[0].PoolItem.GetQuality());
			}
		}
	}

	private void RestAllTape()
	{
		RestAllTapeHide();
		RestAllTapeEffectHide();
	}

	private void RestAllTapeHide()
	{
		for (int i = 0; i < TapeList.Count; i++)
		{
			TapeList[i].gameObject.SetActive(value: false);
			TapeEffectList[i].RestALLHide();
		}
	}

	private void RestAllTapeEffectHide()
	{
		for (int i = 0; i < TapeList.Count; i++)
		{
			TapeEffectList[i].RestALLHide();
		}
	}

	private int CheckResultsListSetQualityTrack()
	{
		if (_results == null || _results.Count == 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < _results.Count; i++)
		{
			GachaCardDrawItem gachaCardDrawItem = _results[i];
			if (gachaCardDrawItem != null && gachaCardDrawItem.PoolItem != null)
			{
				ItemData data = CoreUtils.GetData(gachaCardDrawItem.PoolItem.Id, RuntimeConfigs.data.itemDatas);
				if (data != null)
				{
					num = Mathf.Max(num, data.quality);
				}
			}
		}
		if (num > 0)
		{
			SetStartTimelineQualityTrack(num);
		}
		return num;
	}

	private bool SetStartTimelineQualityTrack(int quality)
	{
		string startTimelineQualityTrackName = GetStartTimelineQualityTrackName(quality);
		string startTimelineSoundQualityTrackName = GetStartTimelineSoundQualityTrackName(quality);
		if (string.IsNullOrEmpty(startTimelineQualityTrackName))
		{
			return false;
		}
		bool result = SetStartTimelineQualityTrack(GoStartTimeLine, startTimelineQualityTrackName);
		SetStartTimelineSoundQualityTrack(GoStartTimeLine, startTimelineSoundQualityTrackName);
		return result;
	}

	private bool SetCharacterTimelineQualityTrack(int itemId)
	{
		int quality = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas).quality;
		string startTimelineQualityTrackName = GetStartTimelineQualityTrackName(quality);
		string startTimelineSoundQualityTrackName = GetStartTimelineSoundQualityTrackName(quality, ischaracter: true);
		if (string.IsNullOrEmpty(startTimelineQualityTrackName))
		{
			return false;
		}
		bool result = SetStartTimelineQualityTrack(GoCharacterLine, startTimelineQualityTrackName);
		SetStartTimelineSoundQualityTrack(GoCharacterLine, startTimelineSoundQualityTrackName);
		return result;
	}

	private static string GetStartTimelineQualityTrackName(int quality)
	{
		return quality switch
		{
			3 => "Qulity1", 
			4 => "Qulity2", 
			5 => "Qulity3", 
			_ => string.Empty, 
		};
	}

	private static string GetStartTimelineSoundQualityTrackName(int quality, bool ischaracter = false)
	{
		switch (quality)
		{
		case 3:
			if (!ischaracter)
			{
				return "Normal";
			}
			return string.Empty;
		case 4:
			return "Normal";
		case 5:
			return "Gold";
		default:
			return string.Empty;
		}
	}

	private static bool SetStartTimelineQualityTrack(GameObject timelineObject, string targetTrackName)
	{
		if (timelineObject == null)
		{
			return false;
		}
		PlayableDirector component = timelineObject.GetComponent<PlayableDirector>();
		TimelineAsset timelineAsset = ((component != null) ? (component.playableAsset as TimelineAsset) : null);
		if (timelineAsset == null)
		{
			return false;
		}
		bool flag = false;
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (outputTrack.name == targetTrackName)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			return false;
		}
		bool flag2 = false;
		foreach (TrackAsset outputTrack2 in timelineAsset.GetOutputTracks())
		{
			if (IsStartTimelineQualityTrack(outputTrack2.name))
			{
				bool flag3 = outputTrack2.name != targetTrackName;
				if (outputTrack2.muted != flag3)
				{
					outputTrack2.muted = flag3;
					flag2 = true;
				}
			}
		}
		if (flag2)
		{
			component.RebuildGraph();
		}
		return true;
	}

	private static bool SetStartTimelineSoundQualityTrack(GameObject timelineObject, string targetTrackName)
	{
		if (timelineObject == null)
		{
			return false;
		}
		PlayableDirector component = timelineObject.GetComponent<PlayableDirector>();
		TimelineAsset timelineAsset = ((component != null) ? (component.playableAsset as TimelineAsset) : null);
		if (timelineAsset == null)
		{
			return false;
		}
		bool flag = false;
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (outputTrack.name == targetTrackName)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			return false;
		}
		bool flag2 = false;
		foreach (TrackAsset outputTrack2 in timelineAsset.GetOutputTracks())
		{
			if (IsStartTimelineSoundQualityTrack(outputTrack2.name))
			{
				bool flag3 = outputTrack2.name != targetTrackName;
				if (outputTrack2.muted != flag3)
				{
					outputTrack2.muted = flag3;
					flag2 = true;
				}
			}
		}
		if (flag2)
		{
			component.RebuildGraph();
		}
		return true;
	}

	private static bool MuteStartTimelineQualityTracks(GameObject timelineObject)
	{
		if (timelineObject == null)
		{
			return false;
		}
		PlayableDirector component = timelineObject.GetComponent<PlayableDirector>();
		TimelineAsset timelineAsset = ((component != null) ? (component.playableAsset as TimelineAsset) : null);
		if (timelineAsset == null)
		{
			return false;
		}
		bool flag = false;
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if ((IsStartTimelineQualityTrack(outputTrack.name) || IsStartTimelineSoundQualityTrack(outputTrack.name)) && !outputTrack.muted)
			{
				outputTrack.muted = true;
				flag = true;
			}
		}
		if (flag)
		{
			component.RebuildGraph();
		}
		return true;
	}

	private static bool IsStartTimelineQualityTrack(string trackName)
	{
		for (int i = 0; i < StartTimelineQualityTrackNames.Length; i++)
		{
			if (StartTimelineQualityTrackNames[i] == trackName)
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsStartTimelineSoundQualityTrack(string trackName)
	{
		for (int i = 0; i < StartTimelineSoundQualityTrackNames.Length; i++)
		{
			if (StartTimelineSoundQualityTrackNames[i] == trackName)
			{
				return true;
			}
		}
		return false;
	}

	private async UniTask RunStartTimelinePhase()
	{
		_phase = CardDrawPhase.PlayingStart;
		if (!(GoStartTimeLine == null))
		{
			uiSceneCamera.GetComponent<CinemachineBrain>().enabled = false;
			await PlayTimeLine(GoStartTimeLine, null, null, null, useExistingInstance: false, hideInstanceOnRelease: true);
			MuteStartTimelineQualityTracks(GoStartTimeLine);
		}
	}

	public async UniTask PlayCharacterTimelineBeforeShow(CardDrawCharacterShowData item)
	{
		if (item == null || !item.isCharacter)
		{
			return;
		}
		int flowId = ++_characterTimelineFlowId;
		_phase = CardDrawPhase.PlayingCharacter;
		uiSceneCamera.GetComponent<CinemachineBrain>().enabled = false;
		RestAllTape();
		SetMaterialTextrue(item.Id);
		LoadCharacterTapeAsync(item);
		SetCharacterTimelineQualityTrack(item.Id);
		ItemData data = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			_cardDrawView.PlayGachaCharacterSound(data.quality);
		}
		GachaMachineRoot.SetActive(value: true);
		SceneLight.SetActive(value: true);
		await PlayTimeLine(GoCharacterLine, null, null, ReleaseTapeInstance, useExistingInstance: false, hideInstanceOnRelease: true);
		MuteStartTimelineQualityTracks(GoCharacterLine);
		if (await TryHandleSkipFlow() || this == null || !gameObject || _phase == CardDrawPhase.ShowingSettle)
		{
			return;
		}
		GameObject timelinePrefab = await ResolveCharacterTimelineInstanceAsync(item);
		uiSceneCamera.GetComponent<CinemachineBrain>().enabled = true;
		SceneLight.SetActive(value: false);
		GachaMachineRoot.SetActive(value: false);
		ItemData data2 = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas);
		if (data2 != null)
		{
			if (data2.quality == 5)
			{
				_characterGoldId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Character_Presentation_Gold");
			}
			else
			{
				_characterPurpleId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Character_Presentation");
			}
		}
		if (item.IsNew)
		{
			_playedNewCharacterTimelineIds.Add(item.Id);
		}
		await PlayTimeLine(timelinePrefab, null, null, () =>
		{
			SceneLight.SetActive(value: true);
		}, useExistingInstance: true);
		if (flowId == _characterTimelineFlowId)
		{
			CleanupStartTimeline(restoreCardDrawView: false);
			if (_characterGoldId != 9)
			{
				Singleton<GameManager>.instance.audioManager.Stop(_characterGoldId);
				_characterGoldId = 0u;
			}
			if (_characterPurpleId != 9)
			{
				Singleton<GameManager>.instance.audioManager.Stop(_characterPurpleId);
				_characterPurpleId = 0u;
			}
			SceneLight.SetActive(value: true);
			if (!(this == null) && (bool)gameObject && _phase != CardDrawPhase.ShowingSettle && !(await TryHandleSkipFlow()) && !(this == null) && (bool)gameObject && _phase != CardDrawPhase.ShowingSettle)
			{
				_phase = CardDrawPhase.ShowingCharacter;
			}
		}
	}

	public void StopCharacterTimeline()
	{
		if (_phase == CardDrawPhase.PlayingCharacter)
		{
			SceneLight.SetActive(value: true);
			_cardDrawView?.CheckCharacterSound();
			if (_characterGoldId != 9)
			{
				Singleton<GameManager>.instance.audioManager.Stop(_characterGoldId);
				_characterGoldId = 0u;
			}
			if (_characterPurpleId != 9)
			{
				Singleton<GameManager>.instance.audioManager.Stop(_characterPurpleId);
				_characterPurpleId = 0u;
			}
		}
		if (_startTimelineInstance != null)
		{
			StopStartTimeline(skipped: false);
		}
	}

	public void SkipCardDrawTimeline()
	{
		if (MainCamera.gameObject.activeSelf)
		{
			SetCamera(isMain: false);
		}
		if (_phase == CardDrawPhase.ShowingSettle || _skipFlowRequested || _handlingSkipFlow)
		{
			return;
		}
		if (TouchObj.activeSelf)
		{
			TouchObj.SetActive(value: false);
		}
		if ((object)_cardDrawView == null)
		{
			_cardDrawView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CARDDRAW) as CardDrawView;
		}
		CollectPendingNewCharactersForSkip();
		_skipFlowRequested = true;
		if (IsStartTimelinePlaying)
		{
			_skipRequested = true;
			StopCurrentTimelineDirector();
			return;
		}
		if (_phase == CardDrawPhase.ShowingCharacter)
		{
			_cardDrawView?.CharacterShowRoot?.SetActive(value: false);
		}
		TryHandleSkipFlow().Forget();
	}

	public void GoToCharacterShow()
	{
		_phase = CardDrawPhase.ShowingCharacter;
		_cardDrawView?.ToCharacterShow();
	}

	private async UniTask<bool> TryHandleSkipFlow()
	{
		if (!_skipFlowRequested)
		{
			return false;
		}
		if (_handlingSkipFlow)
		{
			return true;
		}
		_handlingSkipFlow = true;
		_skipFlowRequested = false;
		try
		{
			if ((object)_cardDrawView == null)
			{
				_cardDrawView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CARDDRAW) as CardDrawView;
			}
			if (this == null || !gameObject)
			{
				return true;
			}
			if (_skipPendingNewCharacters.Count > 0)
			{
				_phase = CardDrawPhase.ShowingCharacter;
				_cardDrawView?.CharacterShowRoot?.SetActive(value: false);
				_cardDrawView?.ToCharacterShow(new List<CardDrawCharacterShowData>(_skipPendingNewCharacters), isSkip: true);
			}
			else
			{
				_phase = CardDrawPhase.ShowingSettle;
				_cardDrawView?.ToCardDrawSettle();
			}
			return true;
		}
		finally
		{
			_skipPendingNewCharacters.Clear();
			_handlingSkipFlow = false;
		}
	}

	private void CollectPendingNewCharactersForSkip()
	{
		_skipPendingNewCharacters.Clear();
		if (_results == null)
		{
			return;
		}
		for (int i = 0; i < _results.Count; i++)
		{
			GachaCardDrawItem gachaCardDrawItem = _results[i];
			if (IsNewCharacterResult(gachaCardDrawItem) && !_playedNewCharacterTimelineIds.Contains(gachaCardDrawItem.PoolItem.Id))
			{
				CardDrawCharacterShowData cardDrawCharacterShowData = BuildCardDrawCharacterShowData(gachaCardDrawItem);
				if (cardDrawCharacterShowData != null)
				{
					_skipPendingNewCharacters.Add(cardDrawCharacterShowData);
				}
			}
		}
	}

	private bool IsNewCharacterResult(GachaCardDrawItem item)
	{
		if (item != null && item.PoolItem != null && item.PoolItem.IsNew)
		{
			return item.PoolItem.itemType == 5;
		}
		return false;
	}

	private CardDrawCharacterShowData BuildCardDrawCharacterShowData(GachaCardDrawItem item)
	{
		if (item == null || item.PoolItem == null)
		{
			return null;
		}
		CardDrawCharacterShowData cardDrawCharacterShowData = new CardDrawCharacterShowData
		{
			IsNew = item.PoolItem.IsNew,
			Id = item.PoolItem.Id,
			CharacterMaxConstellation = item.CharacterMaxConstellation,
			isCharacter = (item.PoolItem.itemType == 5),
			ExtraItem = new List<CardDrawCharacterShowExtraData>()
		};
		for (int i = 0; i < item.ExtraItem.Count; i++)
		{
			cardDrawCharacterShowData.ExtraItem.Add(new CardDrawCharacterShowExtraData
			{
				Id = item.ExtraItem[i].Id,
				Count = item.ExtraItem[i].Count
			});
		}
		return cardDrawCharacterShowData;
	}

	private async UniTask<GameObject> ResolveCharacterTimelineInstanceAsync(CardDrawCharacterShowData item)
	{
		return await LoadCharacterTimelineAsync(item);
	}

	public void NotifyCharacterShowComplete()
	{
		if (_phase == CardDrawPhase.ShowingCharacter)
		{
			_phase = CardDrawPhase.ShowingSettle;
		}
		CleanupStartTimeline();
	}

	public void NotifySettleClosed()
	{
		GoToRestoreMain();
	}

	private void GoToRestoreMain()
	{
		RestoreCardDrawView();
		ResetFlowState();
	}

	private void ResetFlowState()
	{
		_phase = CardDrawPhase.Idle;
		_skipRequested = false;
		_skipFlowRequested = false;
		_handlingSkipFlow = false;
		_results = null;
		_skipPendingNewCharacters.Clear();
		_playedNewCharacterTimelineIds.Clear();
	}

	public virtual string GetCharacterTimelinePath(CardDrawCharacterShowData item)
	{
		ItemData data = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas);
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

	protected virtual async UniTask<GameObject> LoadCharacterTimelineAsync(CardDrawCharacterShowData item)
	{
		string characterTimelinePath = GetCharacterTimelinePath(item);
		if (string.IsNullOrEmpty(characterTimelinePath))
		{
			return null;
		}
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(characterTimelinePath, transform);
		await handle;
		if (this == null || !base.gameObject)
		{
			GameObject gameObject = handle.AsGameObject();
			if (gameObject != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(gameObject);
			}
			return null;
		}
		GameObject gameObject2 = handle.AsGameObject();
		if (gameObject2 != null)
		{
			gameObject2.SetActive(value: false);
		}
		return gameObject2;
	}

	public virtual string GetCharacterTapePath(CardDrawCharacterShowData item)
	{
		ItemData data = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return string.Empty;
		}
		EntityCharacterData data2 = CoreUtils.GetData(data.canBeTransited[0].id, RuntimeConfigs.data.entityCharacterDatas);
		if (data2 != null)
		{
			return data2.tapePath;
		}
		return string.Empty;
	}

	protected virtual async UniTask<GameObject> LoadCharacterTapeAsync(CardDrawCharacterShowData item)
	{
		string characterTapePath = GetCharacterTapePath(item);
		if (string.IsNullOrEmpty(characterTapePath) || TfTapeRoot == null)
		{
			return null;
		}
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(characterTapePath, TfTapeRoot);
		await handle;
		if (this == null || !base.gameObject)
		{
			GameObject gameObject = handle.AsGameObject();
			if (gameObject != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(gameObject);
			}
			return null;
		}
		ReleaseTapeInstance();
		GameObject gameObject2 = handle.AsGameObject();
		if (gameObject2 != null)
		{
			gameObject2.transform.SetParent(TfTapeRoot, worldPositionStays: false);
			gameObject2.transform.localPosition = Vector3.zero;
			gameObject2.transform.localRotation = Quaternion.identity;
			gameObject2.SetActive(value: true);
		}
		_tapeInstance = gameObject2;
		return gameObject2;
	}

	private void ReleaseTapeInstance()
	{
		if (!(_tapeInstance == null))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_tapeInstance);
			_tapeInstance = null;
		}
	}

	public async UniTask PlayTimeLine(GameObject timelinePrefab, Action onPlay = null, Action onFinish = null, Action onSkip = null, bool useExistingInstance = false, bool hideInstanceOnRelease = false)
	{
		_onTimelinePlay = onPlay;
		_onTimelineFinish = onFinish;
		_onTimelineSkip = onSkip;
		if (timelinePrefab == null)
		{
			InvokeTimelineFinish();
			return;
		}
		await LoadStartTimeline(timelinePrefab, useExistingInstance, hideInstanceOnRelease);
		timelinePrefab.SetActive(value: false);
		if (_startTimelineInstance == null)
		{
			InvokeTimelineFinish();
			return;
		}
		_startTimelineDirector = _startTimelineInstance.GetComponent<PlayableDirector>();
		if (_startTimelineDirector == null)
		{
			CleanupStartTimeline();
			return;
		}
		_startTimelineInstance.SetActive(value: true);
		BindTimeline();
		_onTimelinePlay?.Invoke();
		PlayableDirector director = _startTimelineDirector;
		bool hasStartedPlaying = false;
		director.time = 0.0;
		director.Play();
		await UniTask.WaitUntil(() =>
		{
			if (_startTimelineDirector == null || _startTimelineDirector != director)
			{
				return true;
			}
			if (!director.playableGraph.IsValid())
			{
				return true;
			}
			if (director.playableGraph.IsPlaying())
			{
				hasStartedPlaying = true;
				return false;
			}
			return hasStartedPlaying;
		}, PlayerLoopTiming.Update, gameObject.GetCancellationTokenOnDestroy()).SuppressCancellationThrow();
		if (!(_startTimelineDirector != null) && !(this == null) && (bool)gameObject)
		{
			StopStartTimeline(_skipRequested);
		}
	}

	private void StopCurrentTimelineDirector()
	{
		if (_startTimelineDirector != null)
		{
			_startTimelineDirector.Stop();
		}
	}

	public void RotateButtonClockwise()
	{
		RotateButtonByStep(1f);
	}

	public void RotateButtonCounterClockwise()
	{
		RotateButtonByStep(-1f);
	}

	public void RotateButtonByStep(float direction)
	{
		if (!IsStartTimelinePlaying)
		{
			_ = rotateButton == null;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (eventData != null && !IsStartTimelinePlaying)
		{
			EnsureInteractionInitialized();
			_activeTouchType = ResolveTouchTypeByCollider(eventData.position);
			_hasLastRotatePointerAngle = _activeTouchType == CardDrawTouchType.Rotate && TryGetScreenAngleAroundTarget(rotateButton, eventData.position, out _lastRotatePointerAngle);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (eventData == null || IsStartTimelinePlaying)
		{
			return;
		}
		switch (_activeTouchType)
		{
		case CardDrawTouchType.Rotate:
		{
			if (TryGetRotatePointerDeltaAngle(eventData.position, out var deltaAngle))
			{
				float num2 = RotateTransformByY(rotateButton, (0f - deltaAngle) * rotateDragSensitivity, 0f, GetRotateButtonMaxYRotation());
				if (Mathf.Abs(num2) > Mathf.Epsilon)
				{
					StartLeftRotationLoopSound();
				}
				ApplyWaveFrequencyDelta(num2);
			}
			break;
		}
		case CardDrawTouchType.Slide:
			if (Mathf.Abs(eventData.delta.y) > Mathf.Epsilon)
			{
				float num = RotateTransformByY(slideHandle, eventData.delta.y * slideDragSensitivity, slideHandleMinYRotation, slideHandleMaxYRotation);
				if (Mathf.Abs(num) > Mathf.Epsilon)
				{
					StartRightSlideLoopSound();
				}
				ApplyWaveAmplitudeDelta(num);
			}
			break;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_activeTouchType = CardDrawTouchType.None;
		_hasLastRotatePointerAngle = false;
		StopRightSlideLoopSound();
		StopLeftRotationLoopSound();
	}

	public void OnGamepadRotate(float deltaAngle)
	{
		if (!IsStartTimelinePlaying && !(rotateButton == null) && !Mathf.Approximately(deltaAngle, 0f))
		{
			EnsureInteractionInitialized();
			StartLeftRotationLoopSound();
			_gamepadRotateDriveFrame = Time.frameCount;
			float appliedYRotation = RotateTransformByY(rotateButton, (0f - deltaAngle) * rotateDragSensitivity, 0f, GetRotateButtonMaxYRotation());
			ApplyWaveFrequencyDelta(appliedYRotation);
		}
	}

	public void OnGamepadSlide(float value)
	{
		if (!IsStartTimelinePlaying && !(slideHandle == null) && !Mathf.Approximately(value, 0f))
		{
			EnsureInteractionInitialized();
			StartRightSlideLoopSound();
			_gamepadSlideDriveFrame = Time.frameCount;
			float appliedYRotation = RotateTransformByY(slideHandle, value * 60f * Time.deltaTime, slideHandleMinYRotation, slideHandleMaxYRotation);
			ApplyWaveAmplitudeDelta(appliedYRotation);
		}
	}

	private void Update()
	{
		if (IsStartTimelinePlaying || MonoECS.instance == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad || Singleton<GameInputActionManager>.instance == null)
		{
			return;
		}
		float num = ((slideHandle != null) ? Singleton<GameInputActionManager>.instance.ReadActionValue<float>("UI/RSUpDownSelect", out var phase) : 0f);
		float num2 = 0f;
		if (rotateButton != null)
		{
			Vector2 vector = Singleton<GameInputActionManager>.instance.ReadActionValue<Vector2>("UI/GamePadNavigate", out phase);
			if (vector.sqrMagnitude >= 0.36f)
			{
				float num3 = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
				if (_hasLastNavigateAngle)
				{
					num2 = Mathf.DeltaAngle(_lastNavigateAngle, num3);
				}
				_lastNavigateAngle = num3;
				_hasLastNavigateAngle = true;
			}
			else
			{
				_hasLastNavigateAngle = false;
			}
		}
		bool flag = Mathf.Abs(num) >= 0.1f;
		bool flag2 = !Mathf.Approximately(num2, 0f);
		if (flag | flag2)
		{
			if ((object)_cardDrawView == null)
			{
				_cardDrawView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CARDDRAW) as CardDrawView;
			}
			if (_cardDrawView != null)
			{
				if (flag)
				{
					_cardDrawView.OnGamepadSlide(num);
				}
				if (flag2)
				{
					_cardDrawView.OnGamepadRotate(num2);
				}
			}
		}
		if (_rightSlideLoopSoundId != 0 && _gamepadSlideDriveFrame != Time.frameCount)
		{
			StopRightSlideLoopSound();
		}
		if (_leftRotationLoopSoundId != 0 && _gamepadRotateDriveFrame != Time.frameCount)
		{
			StopLeftRotationLoopSound();
		}
	}

	private void StopStartTimeline(bool skipped)
	{
		_startTimelineDirector = null;
		ReleaseTimelineInstance();
		if (skipped)
		{
			InvokeTimelineSkip();
		}
		else
		{
			InvokeTimelineFinish();
		}
		_skipRequested = false;
	}

	private UniTask LoadStartTimeline(GameObject timelinePrefab, bool useExistingInstance = false, bool hideInstanceOnRelease = false)
	{
		CleanupStartTimeline(restoreCardDrawView: false, clearCallbacks: false);
		_startTimelineHideOnRelease = hideInstanceOnRelease;
		_startTimelineInstance = timelinePrefab;
		_startTimelineUseStationRelease = useExistingInstance;
		if (useExistingInstance && _startTimelineInstance != null && !hideInstanceOnRelease)
		{
			_startTimelineInstance.transform.SetParent(TfCharacterTimeLineRoot, worldPositionStays: false);
		}
		_startTimelineInstance.SetActive(value: false);
		return UniTask.CompletedTask;
	}

	private void BindTimeline()
	{
		MonoTimelineConfig component = _startTimelineInstance.GetComponent<MonoTimelineConfig>();
		if (!(component == null))
		{
			if (component.timelineConfig.useNewAssetsBindings)
			{
				TimelineTrackBinding.SetTrackBinding(_startTimelineDirector, component.timelineConfig.newAssetsBindings);
			}
			else
			{
				OldTimelineTrackBinding.SetTrackBinding(_startTimelineDirector, component.timelineConfig.assetsBindings);
			}
		}
	}

	private void RestoreCardDrawView()
	{
		CardDrawView obj = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CARDDRAW) as CardDrawView;
		obj?.ChangeGaChaViewRoot(isshow: true);
		obj?.BtnSkip.gameObject.SetActive(value: false);
		obj?.GachaMachineRoot.gameObject.SetActive(value: false);
	}

	private void CleanupStartTimeline(bool restoreCardDrawView = true, bool clearCallbacks = true)
	{
		_startTimelineDirector = null;
		ReleaseTimelineInstance();
		if (restoreCardDrawView)
		{
			RestoreCardDrawView();
		}
		if (clearCallbacks)
		{
			_onTimelinePlay = null;
			_onTimelineFinish = null;
			_onTimelineSkip = null;
		}
	}

	private void ReleaseTimelineInstance()
	{
		if (_startTimelineInstance == null)
		{
			_startTimelineUseStationRelease = false;
			_startTimelineHideOnRelease = false;
			return;
		}
		if (_startTimelineHideOnRelease)
		{
			_startTimelineInstance.SetActive(value: false);
		}
		if (_startTimelineUseStationRelease)
		{
			AssetStationManager.BattleStation.ReleaseInstance(_startTimelineInstance);
		}
		_startTimelineInstance = null;
		_startTimelineUseStationRelease = false;
		_startTimelineHideOnRelease = false;
	}

	private void InvokeTimelineFinish()
	{
		uiSceneCamera.GetComponent<CinemachineBrain>().enabled = false;
		Action onTimelineFinish = _onTimelineFinish;
		_onTimelineFinish = null;
		_onTimelineSkip = null;
		onTimelineFinish?.Invoke();
	}

	private void InvokeTimelineSkip()
	{
		uiSceneCamera.GetComponent<CinemachineBrain>().enabled = false;
		Action onTimelineSkip = _onTimelineSkip;
		_onTimelineSkip = null;
		_onTimelineFinish = null;
		onTimelineSkip?.Invoke();
	}

	private void EnsureInteractionInitialized()
	{
		if (rotateButtonCollider == null && rotateButton != null)
		{
			rotateButtonCollider = rotateButton.GetComponent<Collider>();
			if ((object)rotateButtonCollider == null)
			{
				rotateButtonCollider = rotateButton.GetComponentInChildren<Collider>();
			}
		}
		if (slideHandleCollider == null && slideHandle != null)
		{
			slideHandleCollider = slideHandle.GetComponent<Collider>();
			if ((object)slideHandleCollider == null)
			{
				slideHandleCollider = slideHandle.GetComponentInChildren<Collider>();
			}
		}
	}

	private void ResetWaveControls()
	{
		_waveAmplitudeValue = Mathf.Clamp(waveAmplitudeResetValue, WaveAmplitudeMinValue, WaveAmplitudeMaxValue);
		_waveFrequencyValue = Mathf.Clamp(waveFrequencyResetValue, WaveFrequencyMinValue, WaveFrequencyMaxValue);
		ResetTransformYRotation(rotateButton, GetRotateButtonYRotationByFrequency(_waveFrequencyValue));
		ResetTransformYRotation(slideHandle, GetSlideHandleYRotationByAmplitude(_waveAmplitudeValue));
		SetWaveAmplitude(_waveAmplitudeValue);
		SetWaveMaterialFloat(WaveFrequencyId, _waveFrequencyValue);
	}

	public void ResetIdleSound()
	{
		_cardDrawView?.SetIdleSound("Music_DrawCard_dB", _waveAmplitudeValue);
		_cardDrawView?.SetIdleSound("Music_DrawCard_EQ", Mathf.InverseLerp(WaveFrequencyMinValue, WaveFrequencyMaxValue, _waveFrequencyValue));
	}

	private bool TryGetRotatePointerDeltaAngle(Vector2 screenPosition, out float deltaAngle)
	{
		deltaAngle = 0f;
		if (!TryGetScreenAngleAroundTarget(rotateButton, screenPosition, out var angle))
		{
			return false;
		}
		if (!_hasLastRotatePointerAngle)
		{
			_lastRotatePointerAngle = angle;
			_hasLastRotatePointerAngle = true;
			return false;
		}
		deltaAngle = Mathf.DeltaAngle(_lastRotatePointerAngle, angle);
		_lastRotatePointerAngle = angle;
		return Mathf.Abs(deltaAngle) > Mathf.Epsilon;
	}

	private void ApplyWaveAmplitudeDelta(float appliedYRotation)
	{
		if (!(Mathf.Abs(appliedYRotation) <= Mathf.Epsilon))
		{
			float num = slideHandleMaxYRotation - slideHandleMinYRotation;
			if (!Mathf.Approximately(num, 0f))
			{
				float num2 = WaveAmplitudeMaxValue - WaveAmplitudeMinValue;
				_waveAmplitudeValue = ApplyClampedValueDelta(_waveAmplitudeValue, appliedYRotation / num * num2, WaveAmplitudeMinValue, WaveAmplitudeMaxValue);
				SetWaveAmplitude(_waveAmplitudeValue);
				_cardDrawView.SetIdleSound("Music_DrawCard_dB", _waveAmplitudeValue);
				HandleSlideDirectionSound(appliedYRotation);
				HandleBoundarySound(_waveAmplitudeValue, WaveAmplitudeMinValue, WaveAmplitudeMaxValue, ref _slideAtBoundary, "event:/UI/Interface/DrawCard/Machine/Slide_Up_Ontop");
			}
		}
	}

	private void ApplyWaveFrequencyDelta(float appliedYRotation)
	{
		if (!(Mathf.Abs(appliedYRotation) <= Mathf.Epsilon))
		{
			float num = GetRotateButtonMaxYRotation();
			if (!Mathf.Approximately(num, 0f))
			{
				float num2 = WaveFrequencyMaxValue - WaveFrequencyMinValue;
				_waveFrequencyValue = ApplyClampedValueDelta(_waveFrequencyValue, appliedYRotation / num * num2, WaveFrequencyMinValue, WaveFrequencyMaxValue);
				SetWaveMaterialFloat(WaveFrequencyId, _waveFrequencyValue);
				float vaule = Mathf.InverseLerp(WaveFrequencyMinValue, WaveFrequencyMaxValue, _waveFrequencyValue);
				_cardDrawView.SetIdleSound("Music_DrawCard_EQ", vaule);
				HandleBoundarySound(_waveFrequencyValue, WaveFrequencyMinValue, WaveFrequencyMaxValue, ref _rotationAtBoundary, "event:/UI/Interface/DrawCard/Machine/Rotate_Ontop");
			}
		}
	}

	private static float ApplyClampedValueDelta(float currentValue, float deltaValue, float minValue, float maxValue)
	{
		return Mathf.Clamp(currentValue + deltaValue, minValue, maxValue);
	}

	private void StartRightSlideLoopSound()
	{
		if (_rightSlideLoopSoundId == 0)
		{
			_rightSlideLoopSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Slide_Loop");
		}
	}

	private void StopRightSlideLoopSound()
	{
		if (_rightSlideLoopSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_rightSlideLoopSoundId);
			_rightSlideLoopSoundId = 0u;
		}
		_lastSlideDirection = 0;
		_slideAtBoundary = false;
	}

	private void StartLeftRotationLoopSound()
	{
		if (_leftRotationLoopSoundId == 0)
		{
			_leftRotationLoopSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Rotate_Loop");
		}
	}

	private void StopLeftRotationLoopSound()
	{
		if (_leftRotationLoopSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_leftRotationLoopSoundId);
			_leftRotationLoopSoundId = 0u;
		}
		_rotationAtBoundary = false;
	}

	private void HandleSlideDirectionSound(float appliedYRotation)
	{
		int num = ((appliedYRotation > 0f) ? 1 : ((appliedYRotation < 0f) ? (-1) : 0));
		if (num != 0 && num != _lastSlideDirection)
		{
			_lastSlideDirection = num;
			Singleton<GameManager>.instance.audioManager.PlaySound((num > 0) ? "event:/UI/Interface/DrawCard/Machine/Slide_Up_Stop" : "event:/UI/Interface/DrawCard/Machine/Slide_Down_Stop");
		}
	}

	private void HandleBoundarySound(float value, float minValue, float maxValue, ref bool atBoundary, string soundPath)
	{
		bool flag = value <= minValue + Mathf.Epsilon || value >= maxValue - Mathf.Epsilon;
		if (flag && !atBoundary)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(soundPath);
		}
		atBoundary = flag;
	}

	private float GetRotateButtonYRotationByFrequency(float frequency)
	{
		return Mathf.InverseLerp(WaveFrequencyMinValue, WaveFrequencyMaxValue, frequency) * GetRotateButtonMaxYRotation();
	}

	private float GetSlideHandleYRotationByAmplitude(float amplitude)
	{
		float t = Mathf.InverseLerp(WaveAmplitudeMinValue, WaveAmplitudeMaxValue, amplitude);
		return Mathf.Lerp(slideHandleMinYRotation, slideHandleMaxYRotation, t);
	}

	private float GetRotateButtonMaxYRotation()
	{
		return Mathf.Clamp(rotateButtonMaxYRotation, 0f, 359.999f);
	}

	private void SetWaveAmplitude(float value)
	{
		Material waveMaterial = GetWaveMaterial();
		if (!(waveMaterial == null))
		{
			if (waveMaterial.HasProperty(WaveAmplitudeId))
			{
				waveMaterial.SetFloat(WaveAmplitudeId, value);
			}
			if (waveMaterial.HasProperty(WaveAmpliduteId))
			{
				waveMaterial.SetFloat(WaveAmpliduteId, value);
			}
		}
	}

	private void SetWaveMaterialFloat(int shaderPropertyId, float value)
	{
		Material waveMaterial = GetWaveMaterial();
		if (!(waveMaterial == null) && waveMaterial.HasProperty(shaderPropertyId))
		{
			waveMaterial.SetFloat(shaderPropertyId, value);
		}
	}

	private Material GetWaveMaterial()
	{
		if (_waveMaterial != null)
		{
			return _waveMaterial;
		}
		if (Wave == null)
		{
			return null;
		}
		Renderer renderer = Wave.GetComponent<Renderer>();
		if ((object)renderer == null)
		{
			renderer = Wave.GetComponentInChildren<Renderer>();
		}
		if (renderer == null)
		{
			return null;
		}
		_waveMaterial = renderer.material;
		return _waveMaterial;
	}

	private static void ResetTransformYRotation(Transform target, float yRotation)
	{
		if (!(target == null))
		{
			Vector3 localEulerAngles = target.localEulerAngles;
			localEulerAngles.y = yRotation;
			target.localEulerAngles = localEulerAngles;
		}
	}

	private bool TryGetScreenAngleAroundTarget(Transform target, Vector2 screenPosition, out float angle)
	{
		angle = 0f;
		if (target == null || uiSceneCamera == null)
		{
			return false;
		}
		Vector2 vector = uiSceneCamera.WorldToScreenPoint(target.position);
		Vector2 vector2 = screenPosition - vector;
		if (vector2.sqrMagnitude <= Mathf.Epsilon)
		{
			return false;
		}
		angle = Mathf.Atan2(vector2.y, vector2.x) * 57.29578f;
		return true;
	}

	private float RotateTransformByY(Transform target, float deltaYRotation, float? minYRotation = null, float? maxYRotation = null)
	{
		if (target == null)
		{
			return 0f;
		}
		Vector3 localEulerAngles = target.localEulerAngles;
		float currentYRotation = GetCurrentYRotation(localEulerAngles.y, minYRotation, maxYRotation);
		float num = currentYRotation + deltaYRotation;
		if (minYRotation.HasValue && maxYRotation.HasValue)
		{
			num = Mathf.Clamp(num, minYRotation.Value, maxYRotation.Value);
		}
		localEulerAngles.y = num;
		target.localEulerAngles = localEulerAngles;
		return num - currentYRotation;
	}

	private static float GetCurrentYRotation(float eulerY, float? minYRotation, float? maxYRotation)
	{
		if (minYRotation.HasValue && maxYRotation.HasValue && minYRotation.Value >= 0f)
		{
			return Mathf.Repeat(eulerY, 360f);
		}
		return NormalizeAngle(eulerY);
	}

	private static float NormalizeAngle(float angle)
	{
		return Mathf.DeltaAngle(0f, angle);
	}

	private CardDrawTouchType ResolveTouchTypeByCollider(Vector2 screenPosition)
	{
		Collider collider = RaycastButtonCollider(screenPosition);
		if (collider == null)
		{
			return CardDrawTouchType.None;
		}
		if (IsHitTargetTransform(collider, rotateButton))
		{
			return CardDrawTouchType.Rotate;
		}
		if (IsHitTargetTransform(collider, slideHandle))
		{
			return CardDrawTouchType.Slide;
		}
		return CardDrawTouchType.None;
	}

	private Collider RaycastButtonCollider(Vector2 screenPosition)
	{
		if (uiSceneCamera == null)
		{
			return null;
		}
		Ray ray = uiSceneCamera.ScreenPointToRay(screenPosition);
		float maxDistance = ((uiSceneCamera.farClipPlane > 0f) ? uiSceneCamera.farClipPlane : 1000f);
		Collider collider = null;
		float num = float.MaxValue;
		if (TryRaycastTargetCollider(rotateButtonCollider, ray, maxDistance, out var hit) && hit.distance < num)
		{
			collider = rotateButtonCollider;
			num = hit.distance;
		}
		if (TryRaycastTargetCollider(slideHandleCollider, ray, maxDistance, out var hit2) && hit2.distance < num)
		{
			collider = slideHandleCollider;
			num = hit2.distance;
		}
		if (collider != null)
		{
			return collider;
		}
		RaycastHit[] array = Physics.RaycastAll(ray, maxDistance, -1, QueryTriggerInteraction.Collide);
		if (array == null || array.Length == 0)
		{
			return null;
		}
		Array.Sort(array, (RaycastHit left, RaycastHit right) => left.distance.CompareTo(right.distance));
		for (int num2 = 0; num2 < array.Length; num2++)
		{
			Collider collider2 = array[num2].collider;
			if (IsHitTargetTransform(collider2, rotateButton) || IsHitTargetTransform(collider2, slideHandle))
			{
				return collider2;
			}
		}
		return null;
	}

	private static bool TryRaycastTargetCollider(Collider targetCollider, Ray ray, float maxDistance, out RaycastHit hit)
	{
		hit = default;
		if (targetCollider == null || !targetCollider.enabled || !targetCollider.gameObject.activeInHierarchy)
		{
			return false;
		}
		return targetCollider.Raycast(ray, out hit, maxDistance);
	}

	private static bool IsHitTargetTransform(Collider hitCollider, Transform target)
	{
		if (hitCollider == null || target == null)
		{
			return false;
		}
		Transform transform = hitCollider.transform;
		if (!(transform == target) && !transform.IsChildOf(target))
		{
			return target.IsChildOf(transform);
		}
		return true;
	}

	public Vector2 WorldToScreenPoint(Vector3 worldPosition)
	{
		if (uiSceneCamera == null)
		{
			return Vector2.zero;
		}
		return RectTransformUtility.WorldToScreenPoint(uiSceneCamera, worldPosition);
	}

	public Vector2 WorldToScreenPoint(Transform worldTarget)
	{
		if (!(worldTarget == null))
		{
			return WorldToScreenPoint(worldTarget.position);
		}
		return Vector2.zero;
	}

	public bool UpdateUIFollowWorldPosition(Vector3 worldPosition, RectTransform uiTarget)
	{
		if (uiTarget == null || !(uiTarget.parent is RectTransform rect))
		{
			return false;
		}
		Vector2 screenPoint = WorldToScreenPoint(worldPosition);
		Canvas componentInParent = uiTarget.GetComponentInParent<Canvas>();
		Camera cam = ((componentInParent != null && componentInParent.renderMode != RenderMode.ScreenSpaceOverlay) ? componentInParent.worldCamera : null);
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, screenPoint, cam, out var localPoint))
		{
			return false;
		}
		uiTarget.anchoredPosition = localPoint;
		return true;
	}

	public bool UpdateUIFollowWorldPosition(Transform worldTarget, RectTransform uiTarget)
	{
		if (worldTarget != null)
		{
			return UpdateUIFollowWorldPosition(worldTarget.position, uiTarget);
		}
		return false;
	}

	private void SetMaterialTextrue(int Id)
	{
		ItemData data = CoreUtils.GetData(Id, RuntimeConfigs.data.itemDatas);
		if (data == null || data.canBeTransited == null || data.canBeTransited.Count == 0)
		{
			return;
		}
		EntityCharacterData data2 = CoreUtils.GetData(data.canBeTransited[0].id, RuntimeConfigs.data.entityCharacterDatas);
		if (data2 != null)
		{
			Material material = GetMaterial(Qulity);
			if (material != null)
			{
				SetMaterialTexture(material, (data.quality >= 5) ? QulityS : QulityA);
			}
			ChangeMaterialTextrue(GetMaterial(Profession), 216, data2.characterDamageType * 10 + data2.mannerType, isRawImage: true);
			ImageRoot.SetActive(value: true);
		}
	}

	public void ChangeMaterialTextrue(Material material, int configId, int id, bool isRawImage)
	{
		if (!(material == null))
		{
			SetMaterialTexture(material, LoadTexture(configId, id, isRawImage));
		}
	}

	private Material GetMaterial(GameObject target)
	{
		if (target == null)
		{
			return null;
		}
		Renderer renderer = target.GetComponent<Renderer>();
		if ((object)renderer == null)
		{
			renderer = target.GetComponentInChildren<Renderer>();
		}
		if (!(renderer != null))
		{
			return null;
		}
		return renderer.material;
	}

	private void SetMaterialTexture(Material material, Texture texture)
	{
		if (!(material == null))
		{
			if (material.HasProperty(MaterialTextureId))
			{
				material.SetTexture(MaterialTextureId, texture);
			}
			if (material.HasProperty(MaterialMainTextureId))
			{
				material.SetTexture(MaterialMainTextureId, texture);
			}
		}
	}

	private Texture LoadTexture(int configId, int id, bool isRawImage)
	{
		AssetLoadHandle item = _cardDrawView.Station.LoadResource(configId, id, isRawImage);
		_listTextrue.Add(item);
		return item.As<Texture>();
	}

	private void ReleaseTexture()
	{
		for (int i = 0; i < _listTextrue.Count; i++)
		{
			_cardDrawView.Station.Release(_listTextrue[i]);
		}
		_listTextrue.Clear();
	}
}
