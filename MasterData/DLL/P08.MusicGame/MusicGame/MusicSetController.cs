using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

namespace MusicGame;

public class MusicSetController : MonoBehaviour
{
	public class ConstantSetContext
	{
		private float theta = MathF.PI / 6f;

		private float distance = 27.647875f;

		private float y_zero = -10.5358925f;

		private float phi = MathF.PI / 6f;

		private float c = -0.53f;

		private float speed = 1f;

		private float cosTh;

		private float sinTh;

		private float tanPhi;

		private float cosThDividedByTanPhi;

		private float y_zeroDividedByTanPhi;

		public void InitValue()
		{
			Camera main = Camera.main;
			theta = (0f - main.transform.localEulerAngles.x) * (MathF.PI / 180f);
			phi = main.fieldOfView / 2f * (MathF.PI / 180f);
			GameObject.Find("UICamera/Canvas").GetComponent<RectTransform>();
			GameObject gameObject = GameObject.Find("V210MusicSet(Clone)/gameRoot/frame");
			c = main.WorldToViewportPoint(gameObject.transform.position).y * 2f - 1f;
			y_zero = main.transform.InverseTransformPoint(gameObject.transform.position).y;
			distance = main.transform.InverseTransformPoint(gameObject.transform.position).z;
		}

		public void Init()
		{
			InitValue();
			cosTh = Mathf.Cos(theta);
			sinTh = Mathf.Sin(theta);
			tanPhi = Mathf.Tan(phi);
			cosThDividedByTanPhi = cosTh / tanPhi;
			y_zeroDividedByTanPhi = y_zero / tanPhi;
		}

		public float GetPositionConstant(int currentTime, int reachTime)
		{
			float num = 1f - c;
			float constantNodeSpeed = MusicSetController.constantNodeSpeed;
			speed = num * constantNodeSpeed * constantNodeSpeed / 16f + num * constantNodeSpeed / 2f - num / 16f;
			MusicGameTiming musicGameTiming = MusicGameTiming.y_zero;
			MusicGameTiming musicGameTiming2 = MusicGameTiming.y_zero;
			float num2 = (float)(currentTime - musicGameTiming.startTime) * (float)musicGameTiming.speed + (float)musicGameTiming.constant;
			float num3 = ((float)(reachTime - musicGameTiming2.startTime) * (float)musicGameTiming2.speed + (float)musicGameTiming2.constant - num2) * 0.001f;
			float num4 = distance * (speed * num3 + c) - y_zeroDividedByTanPhi;
			float num5 = -1f * sinTh * (speed * num3 + c) + cosThDividedByTanPhi;
			return num4 / num5;
		}
	}

	public static int goodArea = 200;

	public static int latency = 0;

	public static int judgeLatency = 0;

	[NoToLua]
	public static float constantNodeSpeed;

	public static float nodeSpeed;

	public static float mixRange = 0.5f;

	[NoToLua]
	public static MusicTrackType trackType = MusicTrackType.Vertical;

	private int _constantStayTime;

	private int _stayTime;

	[NoToLua]
	public static ConstantSetContext context;

	public MusicGameCriAtomSource player;

	public string cueSheetName;

	public string cueName;

	public string awbFile;

	public int song_duration;

	public Transform startPos;

	public Transform endPos;

	public MusicSetTrack track;

	public MusicGameStruct gameData;

	public string musicPath;

	private CriAtomCueSheet sheet;

	internal bool isPlay;

	public bool autoClick;

	[NoToLua]
	public Transform effectContent;

	private CriAtomExPlayback playback;

	public int specifyTime;

	public int constantStayTime
	{
		get
		{
			return _constantStayTime;
		}
		set
		{
			_ = (float)value / 1000f;
			_constantStayTime = value;
			constantNodeSpeed = (float)value * 0.1f;
		}
	}

	public int stayTime
	{
		get
		{
			return _stayTime;
		}
		set
		{
			Camera main = Camera.main;
			GameObject gameObject = GameObject.Find("gameRoot/frame");
			Vector3 vector = main.transform.InverseTransformPoint(gameObject.transform.position);
			float num = Mathf.Tan(MathF.PI / 180f * main.fieldOfView * 0.5f);
			float f = (0f - main.transform.localEulerAngles.x) * (MathF.PI / 180f);
			float num2 = Mathf.Cos(f);
			float num3 = Mathf.Sin(f);
			float num4 = (float)value / 1000f;
			nodeSpeed = (vector.z * num - vector.y) / num4 / (num2 - num3 * num) / 1000f;
			_stayTime = value;
			if (trackType != MusicTrackType.Constant_Slope)
			{
				if (trackType == MusicTrackType.Vertical)
				{
					effectContent.localEulerAngles = Vector3.zero;
				}
				else if (trackType == MusicTrackType.Slope)
				{
					effectContent.localEulerAngles = new Vector3(0f, 10f, 0f);
				}
			}
		}
	}

	public void SetTrackType(int trackTypeData)
	{
		trackType = (MusicTrackType)trackTypeData;
		if (trackType == MusicTrackType.Constant_Slope)
		{
			constantNodeSpeed = (float)constantStayTime * 0.1f;
		}
	}

	public void Begain()
	{
		if (!isLoadingSheet())
		{
			playback = player.Play();
		}
		isPlay = true;
		track.ResetTrack();
		if (context == null)
		{
			context = new ConstantSetContext();
		}
		context.Init();
	}

	[NoToLua]
	public bool isLoadingSheet()
	{
		if (sheet != null)
		{
			return sheet.IsLoading;
		}
		return false;
	}

	public void End()
	{
		player.Stop();
		isPlay = false;
	}

	private void Awake()
	{
		gameData = MusicGameStruct.LoadFromFile(musicPath);
		List<List<int>> list = gameData.trackList[0];
		track.InitTrack(this, list);
		string text = cueSheetName;
		bool flag = !string.IsNullOrEmpty(awbFile);
		if (CriAtom.GetCueSheet(text) == null)
		{
			sheet = CriAtom.AddCueSheetAsync(text, text + ".acb", flag ? (text + ".awb") : string.Empty, null, loadAwbOnMemory: true);
		}
		player.cueSheet = cueSheetName;
		player.cueName = cueName;
	}

	public int GetCurTime()
	{
		if ((bool)player && player.status == CriAtomSourceBase.Status.Playing)
		{
			return (int)playback.timeSyncedWithAudio - latency;
		}
		return 0;
	}

	private void Update()
	{
		if (!isLoadingSheet() && isPlay)
		{
			if ((bool)player && player.status == CriAtomSourceBase.Status.Stop)
			{
				playback = player.Play();
			}
			if ((bool)player && player.status == CriAtomSourceBase.Status.PlayEnd)
			{
				player.Stop();
			}
			track.Process();
		}
	}
}
