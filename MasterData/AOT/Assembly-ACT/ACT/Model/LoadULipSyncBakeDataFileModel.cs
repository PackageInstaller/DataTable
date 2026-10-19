using System;
using System.Threading;
using ACT.LipSync;
using ACT.Sound.Management;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Model;

public class LoadULipSyncBakeDataFileModel : Model<LoadULipSyncBakeDataFileModel>
{
	private string _eventName;

	private int _voiceIndex;

	private long _voiceId;

	private bool _isMainCharacter;

	private int _speakId;

	private ULipSyncBakeData _uLipsyncBakeData;

	public Action<ULipSyncBakeData, int> _updateULipsyncBakeDataFileEventHandler;

	private AssetLoadHandle _assetLoadHandle;

	private CancellationTokenSource _loadCts;

	private const string BakeDataRoot = "Assets/Res/ULipSyncBakeData/";

	public string EventName
	{
		get
		{
			return _eventName;
		}
		set
		{
			_eventName = value;
		}
	}

	public int VoiceIndex
	{
		get
		{
			return _voiceIndex;
		}
		set
		{
			_voiceIndex = value;
		}
	}

	public bool IsMainCharacter
	{
		get
		{
			return _isMainCharacter;
		}
		set
		{
			_isMainCharacter = value;
		}
	}

	public int SpeakId
	{
		get
		{
			return _speakId;
		}
		set
		{
			_speakId = value;
		}
	}

	public event Action<ULipSyncBakeData, int> OnUpdateULipsyncBakeDataFileEventHandler
	{
		add
		{
			_updateULipsyncBakeDataFileEventHandler = (Action<ULipSyncBakeData, int>)Delegate.Combine(_updateULipsyncBakeDataFileEventHandler, value);
		}
		remove
		{
			_updateULipsyncBakeDataFileEventHandler = (Action<ULipSyncBakeData, int>)Delegate.Remove(_updateULipsyncBakeDataFileEventHandler, value);
		}
	}

	protected override void Init()
	{
		Singleton<DramaVoiceManager>.instance.OnloadULipSyncBakeDataFileEventHandler += OnloadULipSyncBakeDataFile;
		Singleton<DramaVoiceManager>.instance.OnStopULipSyncEventHandler += OnStopULipSync;
		Singleton<DramaVoiceManager>.instance.OnVoicePausedChanged += OnVoicePausedChanged;
	}

	protected override void UnInit()
	{
		Singleton<DramaVoiceManager>.instance.OnloadULipSyncBakeDataFileEventHandler -= OnloadULipSyncBakeDataFile;
		Singleton<DramaVoiceManager>.instance.OnStopULipSyncEventHandler -= OnStopULipSync;
		Singleton<DramaVoiceManager>.instance.OnVoicePausedChanged -= OnVoicePausedChanged;
		CancelPendingLoad();
		UnLoadULipSyncBakeDataFile().Forget();
	}

	private void OnloadULipSyncBakeDataFile(string groupId, int voiceIndex, long voiceId)
	{
		CancelPendingLoad();
		_eventName = groupId;
		_voiceIndex = voiceIndex;
		_voiceId = voiceId;
		if (IsNeedLoadULipSyncBakeDataFile())
		{
			_loadCts = new CancellationTokenSource();
			LoadULipSyncBakeDataFileTask(_loadCts.Token).Forget();
		}
		else
		{
			Singleton<ULipSyncManager>.instance.StopULipSyncAnimation();
		}
	}

	private void OnStopULipSync()
	{
		CancelPendingLoad();
		Singleton<ULipSyncManager>.instance.StopULipSyncAnimation();
	}

	private void OnVoicePausedChanged(bool paused)
	{
		Singleton<ULipSyncManager>.instance.SetULipSyncPaused(paused);
	}

	private void CancelPendingLoad()
	{
		if (_loadCts != null)
		{
			try
			{
				_loadCts.Cancel();
				_loadCts.Dispose();
			}
			catch (Exception)
			{
			}
			_loadCts = null;
		}
	}

	private bool IsNeedLoadULipSyncBakeDataFile()
	{
		return true;
	}

	private async UniTask LoadULipSyncBakeDataFileTask(CancellationToken token)
	{
		string eventName = _eventName;
		int voiceIndex = _voiceIndex;
		long voiceId = _voiceId;
		if (!TryResolveBakeDataAddress(eventName, voiceIndex, voiceId, out var address))
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		try
		{
			if (token.IsCancellationRequested)
			{
				return;
			}
			_assetLoadHandle = AssetStationManager.BattleStation.LoadAsync<ULipSyncBakeData>(address);
			await _assetLoadHandle;
			if (!token.IsCancellationRequested)
			{
				_uLipsyncBakeData = _assetLoadHandle.As<ULipSyncBakeData>();
				if ((bool)_uLipsyncBakeData)
				{
					Singleton<ULipSyncManager>.instance.PlayULipSyncAnimation(_speakId, _uLipsyncBakeData);
				}
			}
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private static bool TryResolveBakeDataAddress(string groupId, int voiceIndex, long voiceId, out string address)
	{
		address = null;
		AssetStation battleStation = AssetStationManager.BattleStation;
		if (battleStation == null || string.IsNullOrEmpty(groupId))
		{
			return false;
		}
		string text = BuildBakeDataAddress(groupId, voiceIndex);
		if (BakeDataExists(battleStation, text))
		{
			address = text;
			return true;
		}
		if (!TryBuildVoiceIdAddress(groupId, voiceIndex, voiceId, out var address2))
		{
			return false;
		}
		if (!BakeDataExists(battleStation, address2))
		{
			return false;
		}
		address = address2;
		return true;
	}

	private static bool TryBuildVoiceIdAddress(string groupId, int voiceIndex, long voiceId, out string address)
	{
		address = null;
		if (voiceId <= 0 || voiceIndex <= 0)
		{
			return false;
		}
		long num = voiceId / 1000;
		if (num <= 0)
		{
			return false;
		}
		string text = num.ToString();
		if (string.Equals(text, groupId, StringComparison.Ordinal))
		{
			return false;
		}
		address = BuildBakeDataAddress(text, voiceIndex);
		return true;
	}

	private static bool BakeDataExists(AssetStation station, string address)
	{
		if (station == null || string.IsNullOrEmpty(address))
		{
			return false;
		}
		try
		{
			return station.AssetExists(address);
		}
		catch (Exception)
		{
			return false;
		}
	}

	private static string BuildBakeDataAddress(string groupId, int voiceIndex)
	{
		return "Assets/Res/ULipSyncBakeData/" + groupId + "/" + groupId + "_" + voiceIndex;
	}

	private async UniTaskVoid UnLoadULipSyncBakeDataFile()
	{
		if (AssetLoadHandleExtensions.IsValid(_assetLoadHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_assetLoadHandle);
		}
	}
}
