using System;
using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

namespace MusicGame;

public class MusicController : StateMachine
{
	public static ConstantContext constantContext;

	public List<Track> trackList;

	private MusicGameStruct gameData;

	public static MusicDataForExchange exchangeData;

	public Transform startPos;

	public Transform endPos;

	public static float nodeSpeed = 1f;

	public string fade_out_cueSheetName = "ui_battle";

	public string fade_out_cueName = "ui_battle_fadeoutbgm";

	public string fade_out_awbFile = "";

	private Slider slider;

	private int musicLength;

	public int trackNum;

	public Dictionary<int, bool> usePressList = new Dictionary<int, bool>();

	private List<KeyCode> trackKeyList;

	public MusicSpecialEffectMgr musicSpecialEffectMgr;

	private static List<MusicGameTiming> timingList;

	public MusicGameCriAtomSource player;

	private string cueSheetName;

	private int lastTime;

	private CriAtomExPlayback playback;

	public GameStatus gameStatus { get; set; }

	public static int spectralType => exchangeData?.spectralType ?? 0;

	public static bool isVertical => exchangeData?.isVertical ?? false;

	public static bool isConstant => exchangeData?.isConstant ?? false;

	public static int latency => exchangeData?.latency ?? 0;

	public static int judgeLatency => exchangeData?.judgeLatency ?? 0;

	public static int stayTime => exchangeData?.stayTime ?? 1000;

	public static int goodArea => exchangeData?.goodArea ?? 120;

	public static int perfectArea => exchangeData?.prefectArea ?? 50;

	public static int perfectPlusArea => exchangeData?.perfectPlusArea ?? 40;

	public static int longStartArea => exchangeData?.longStartArea ?? 120;

	public static int longEndArea => exchangeData?.longEndArea ?? 120;

	public static int interval => exchangeData?.interval ?? 1000;

	public static int preparationTime => exchangeData?.preparationTime ?? 2000;

	public static float mixRange => exchangeData?.mixRange ?? 0f;

	public static MusicGameTiming GetTiming(int time)
	{
		return timingList.FirstOrDefault((MusicGameTiming t) => t.startTime <= time && t.endTime > time);
	}

	public void InitConfig(MusicDataForExchange config)
	{
		if (constantContext == null)
		{
			constantContext = new ConstantContext();
		}
		constantContext.Init(config);
		exchangeData = config;
	}

	private void Awake()
	{
		ChangeState<IdleState>();
	}

	private void InitTrackKeySet()
	{
		if (trackKeyList != null)
		{
			trackKeyList.Clear();
		}
		trackKeyList = new List<KeyCode>();
		LuaTable luaTable = LuaHelper.CallFunction("MusicToLuaBridge.GetTrackKeySetData", trackNum)[0] as LuaTable;
		for (int i = 0; i < trackNum; i++)
		{
			if (Enum.TryParse<KeyCode>(luaTable[i + 1].ToString(), ignoreCase: true, out var result))
			{
				trackKeyList.Add(result);
			}
		}
	}

	public void AdaptionTrack()
	{
		trackNum = gameData.GetTrackNum();
	}

	public void ChangeSpecialTypeShow()
	{
		List<int> list = new List<int>();
		for (int i = 0; i < trackNum; i++)
		{
			if (spectralType == 1)
			{
				list.Add(trackNum - i - 1);
			}
			else
			{
				list.Add(i);
			}
		}
		if (spectralType == 2)
		{
			System.Random random = new System.Random();
			int num = trackNum + trackNum;
			for (int j = 0; j < num; j++)
			{
				int index = random.Next(0, trackNum);
				int index2 = random.Next(0, trackNum);
				int value = list[index];
				list[index] = list[index2];
				list[index2] = value;
			}
		}
		for (int k = 0; k < trackNum; k++)
		{
			if (!usePressList.ContainsKey(k))
			{
				usePressList.Add(k, value: false);
			}
			if (trackList[k] != null)
			{
				trackList[k].InitTrack(this, gameData.trackList[list[k]], k);
				trackList[k].InitTrackKey(trackKeyList[k]);
			}
		}
	}

	private void PressTrack(Vector3 pos)
	{
		if (Physics.Raycast(Camera.main.ScreenPointToRay(pos), out var hitInfo))
		{
			Track component = hitInfo.transform.GetComponent<Track>();
			component.PressButton(pressOrRelease: true);
			usePressList[component.trackIndex] = true;
		}
	}

	private void PhonePointer()
	{
		for (int i = 0; i < Input.touchCount; i++)
		{
			PressTrack(Input.GetTouch(i).position);
		}
	}

	private void PcPointer()
	{
		if (Input.GetMouseButton(0))
		{
			PressTrack(Input.mousePosition);
		}
	}

	private void SimulatePointer()
	{
		for (int i = 0; i < trackNum; i++)
		{
			usePressList[i] = false;
		}
		if (Application.isMobilePlatform)
		{
			PhonePointer();
		}
		else
		{
			PcPointer();
		}
		for (int j = 0; j < trackNum; j++)
		{
			if (!usePressList[j] && trackList[j] != null)
			{
				trackList[j].PressButton(pressOrRelease: false);
			}
		}
	}

	private void CheckPressKey()
	{
		for (int i = 0; i < trackNum; i++)
		{
			if (!usePressList[i] && trackList[i] != null)
			{
				trackList[i].KeyPressCheck();
			}
		}
	}

	public void StartMusicGame(MusicGameStruct _gameData)
	{
		gameData = _gameData;
		AdaptionTrack();
		InitTrackKeySet();
		ChangeSpecialTypeShow();
		foreach (List<List<int>> track in gameData.trackList)
		{
			if (track != null && track.Count > 0)
			{
				List<int> list = track[track.Count - 1];
				musicLength = Math.Max(list[list.Count - 1], musicLength);
			}
		}
		List<List<double>> timing = gameData.timing;
		if (timing != null && 0 < timing.Count)
		{
			timing.Sort((List<double> a, List<double> b) => (a[0] > b[0]) ? 1 : (-1));
			timingList = new List<MusicGameTiming>();
			int count = timing.Count;
			int num = 0;
			double num2 = 0.0;
			double num3 = 1.0;
			for (int num4 = 0; num4 < count; num4++)
			{
				List<double> list2 = timing[num4];
				int num5 = Convert.ToInt32(list2[0]);
				double num6 = list2[1];
				timingList.Add(new MusicGameTiming
				{
					startTime = num,
					endTime = num5,
					speed = num3,
					constant = num2
				});
				int num7 = num5 - num;
				num2 += (double)num7 * num3;
				num = num5;
				num3 = num6;
			}
			timingList.Add(new MusicGameTiming
			{
				startTime = num,
				endTime = int.MaxValue,
				speed = num3,
				constant = num2
			});
		}
		else
		{
			timingList = null;
		}
		if (Camera.main != null)
		{
			Camera main = Camera.main;
			GameObject gameObject = GameObject.Find("Music/background/frame");
			Vector3 vector = main.transform.InverseTransformPoint(gameObject.transform.position);
			float num8 = Mathf.Tan(MathF.PI / 180f * main.fieldOfView * 0.5f);
			float f = (0f - main.transform.localEulerAngles.x) * (MathF.PI / 180f);
			float num9 = Mathf.Cos(f);
			float num10 = Mathf.Sin(f);
			float num11 = (float)stayTime / 1000f;
			nodeSpeed = (vector.z * num8 - vector.y) / num11 / (num9 - num10 * num8) / 1000f;
		}
		else
		{
			nodeSpeed = 1f;
		}
		musicSpecialEffectMgr.SetSpecialEffectData(_gameData);
		gameStatus = GameStatus.Undefine;
		ChangeState<PlayPreparationState>();
	}

	public void PauseMusicGame()
	{
		if (CurrentState is PlayState || CurrentState is PlayPreparationState)
		{
			ChangeState<PauseState>();
		}
	}

	public void ResumeMusicGame()
	{
		if (CurrentState is PauseState)
		{
			if (gameStatus == GameStatus.Play)
			{
				ChangeState<PlayState>();
			}
			else
			{
				ChangeState<PlayPreparationState>();
			}
		}
	}

	public void EndMusicGame()
	{
		ChangeState<ActiveExitState>();
	}

	public void ReStartMusicGame()
	{
		gameStatus = GameStatus.Undefine;
		musicSpecialEffectMgr.SetSpecialEffectData(gameData);
		ChangeState<PlayPreparationState>();
	}

	public CriAtomSource GetMusicPlay()
	{
		return player;
	}

	public void ResetTrack()
	{
		for (int i = 0; i < trackNum; i++)
		{
			if (trackList[i] != null)
			{
				trackList[i].ResetTrack();
			}
		}
	}

	public void Process()
	{
		for (int i = 0; i < trackNum; i++)
		{
			if (trackList[i] != null)
			{
				trackList[i].Process();
			}
		}
	}

	public bool CheckOver()
	{
		for (int i = 0; i < trackNum; i++)
		{
			if (trackList[i] != null && !trackList[i].CheckOver())
			{
				return false;
			}
		}
		return true;
	}

	public void SetClickEnable(bool value)
	{
		for (int i = 0; i < trackNum; i++)
		{
			if (trackList[i] != null)
			{
				trackList[i].SetClickEnable(value);
			}
		}
	}

	public void InitSound(string cueSheetName, string cueName, string awbFile, string aisacKey, float aisacValue)
	{
		this.cueSheetName = cueName;
		DisposeSound();
		bool flag = !string.IsNullOrEmpty(awbFile);
		if (CriAtom.GetCueSheet(cueSheetName) == null)
		{
			CriAtom.AddCueSheetAsync(cueSheetName, cueSheetName + ".acb", flag ? (cueSheetName + ".awb") : string.Empty, null, loadAwbOnMemory: true);
		}
		player.cueSheet = cueSheetName;
		player.cueName = cueName;
		if (!string.IsNullOrEmpty(aisacKey))
		{
			player.SetAisacControl(aisacKey, aisacValue);
		}
	}

	public void DisposeSound()
	{
		string text = cueSheetName;
		if (CriAtom.GetCueSheet(text) != null)
		{
			CriAtom.RemoveCueSheet(text);
		}
	}

	public void PlaySound()
	{
		lastTime = -1;
		playback = player.Play();
	}

	public void PauseSound()
	{
		player.Pause(sw: true);
		for (int i = 0; i < trackNum; i++)
		{
			if (trackList[i] != null)
			{
				trackList[i].OnPause();
			}
		}
	}

	public void ResumeSound()
	{
		player.Pause(sw: false);
	}

	public void StopSound()
	{
		lastTime = -1;
		player.Stop();
	}

	public int GetCurTime()
	{
		if (CurrentState is PlayPreparationState)
		{
			return ((PlayPreparationState)CurrentState).GetTime() - latency;
		}
		int num = (int)playback.timeSyncedWithAudio;
		if (num < lastTime)
		{
			return lastTime - latency;
		}
		lastTime = num;
		return num - latency;
	}

	public int GetMusicLength()
	{
		return musicLength;
	}

	public void SetProcessSlider(Slider slider)
	{
		this.slider = slider;
	}

	private void Update()
	{
		if (usePressList.Count != 0 && usePressList.Count >= trackNum)
		{
			CheckPressKey();
			SimulatePointer();
			if ((bool)slider && !slider.IsDestroyed())
			{
				int curTime = GetCurTime();
				float val = ((musicLength != 0 && 0 <= curTime) ? ((float)curTime / (float)musicLength) : 0f);
				val = Math.Min(1f, val);
				slider.value = val;
			}
			musicSpecialEffectMgr.TimeUpdate(GetCurTime());
		}
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause && CurrentState is PlayState)
		{
			ChangeState<PauseState>();
		}
	}

	protected override void OnDestroy()
	{
		if (trackKeyList != null)
		{
			trackKeyList.Clear();
		}
		trackKeyList = null;
		constantContext = null;
		base.OnDestroy();
	}

	public static float GetNewPositionConstant(int currentTime, int reachTime)
	{
		float positionConstant = constantContext.GetPositionConstant(currentTime, reachTime, out var isMeetConstant);
		if (!isMeetConstant)
		{
			return positionConstant;
		}
		float num = GetNodePosition(reachTime) - GetNodePosition(currentTime);
		_ = constantContext.tMin;
		return (1f - mixRange) * positionConstant + mixRange * num;
	}

	public static float GetPositionConstant(int currentTime, int reachTime)
	{
		MusicGameTiming timing = GetTiming(currentTime);
		MusicGameTiming timing2 = GetTiming(reachTime);
		float num = 45f;
		float num2 = 60f;
		float f = MathF.PI / 180f * num;
		float f2 = MathF.PI / 180f * (num2 / 2f);
		float num3 = Mathf.Cos(f);
		float num4 = Mathf.Sin(f);
		float num5 = Mathf.Tan(f2);
		float num6 = 2.25f * (float)stayTime - 1.25f;
		float num7 = -10.5358925f;
		float num8 = (float)(currentTime - timing.startTime) * (float)timing.speed + (float)timing.constant;
		float num9 = ((float)(reachTime - timing2.startTime) * (float)timing2.speed + (float)timing2.constant - num8) * 0.001f;
		float num10 = -0.53f;
		float num11 = 27.647875f * (num6 * num9 + num10) - num7 / num5;
		float num12 = -1f * num4 * (num6 * num9 + num10) + num3 / num5;
		return num11 / num12;
	}

	public static float GetNodePosition(int time)
	{
		if (timingList == null || timingList.Count == 0)
		{
			return (float)time * nodeSpeed;
		}
		if (0 >= time)
		{
			return (float)time * nodeSpeed;
		}
		foreach (MusicGameTiming timing in timingList)
		{
			if (time >= timing.startTime && time <= timing.endTime)
			{
				double num = (double)(time - timing.startTime) * timing.speed;
				return (float)(timing.constant + num) * nodeSpeed;
			}
		}
		Debug.LogError("can not find music node position by time : " + time);
		return 0f;
	}
}
