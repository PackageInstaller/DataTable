using System;
using System.Collections;
using System.Collections.Generic;
using Live2D.Cubism.Framework.Motion;
using UnityEngine;

public class L2DAnimPlayer : MonoBehaviour
{
	[Serializable]
	public class L2DEvent
	{
		public float timeStamp;

		public string eventName;

		public int data;
	}

	[Serializable]
	public class L2DAnimEvents
	{
		public float animLen;

		public L2DEvent[] events;
	}

	public string preview = string.Empty;

	public CubismMotionController mc;

	public AnimationClip[] clips;

	public AnimationClip[] endClips;

	public bool bSkipL2DCGAnim;

	private bool bAutoIdle;

	private int nLen;

	private int nPlayingClipIndex = -1;

	private int nPlayingInstanceId = int.MinValue;

	private WaitForEndOfFrame wait_end_frame = new WaitForEndOfFrame();

	private Dictionary<string, string[]> dictFallbackOrder = new Dictionary<string, string[]>
	{
		["chat_b"] = new string[1] { "chat_a" },
		["chat_c"] = new string[1] { "chat_a" },
		["chat_d"] = new string[1] { "chat_a" },
		["presents_a"] = new string[1] { "chat_a" },
		["presents_b"] = new string[2] { "chat_b", "chat_a" },
		["shy_a"] = new string[1] { "chat_a" },
		["think_a"] = new string[2] { "chat_b", "chat_a" },
		["special_a"] = new string[1] { "chat_a" },
		["special_b"] = new string[2] { "chat_b", "chat_a" }
	};

	[SerializeField]
	public L2DAnimEvents[] animEvents;

	public bool UseTimerEvent = true;

	private Coroutine eventTimer;

	private float fElapsedTime;

	private float fTimeStamp;

	private L2DAnimEvents curAnimEvents;

	private int nEventLen;

	private int nEventIdx;

	private L2DEvent _event;

	private WaitForEndOfFrame wait = new WaitForEndOfFrame();

	private void LogInEditor(string sLog)
	{
	}

	private void OnDisable()
	{
		nPlayingClipIndex = -1;
		nPlayingInstanceId = int.MinValue;
	}

	private void OnDestroy()
	{
		CubismMotionController cubismMotionController = mc;
		cubismMotionController.AnimationEndHandler = (Action<int>)Delegate.Remove(cubismMotionController.AnimationEndHandler, new Action<int>(OnAnimEnd));
	}

	private void Awake()
	{
		bAutoIdle = false;
		nLen = clips.Length;
		nPlayingClipIndex = -1;
		nPlayingInstanceId = int.MinValue;
	}

	private void Start()
	{
		CubismMotionController cubismMotionController = mc;
		cubismMotionController.AnimationEndHandler = (Action<int>)Delegate.Combine(cubismMotionController.AnimationEndHandler, new Action<int>(OnAnimEnd));
	}

	private static int GetClipInstanceId(AnimationClip clip)
	{
		if (clip == null)
		{
			return int.MinValue;
		}
		AnimationEvent[] events = clip.events;
		for (int i = 0; i < events.Length; i++)
		{
			if (events[i].functionName == "InstanceId")
			{
				return events[i].intParameter;
			}
		}
		return int.MinValue;
	}

	private void OnAnimEnd(int nInstanceId)
	{
		if (nInstanceId != nPlayingInstanceId)
		{
			return;
		}
		if (!bAutoIdle)
		{
			LogInEditor($"[XIA]on anim end {nInstanceId}, {bAutoIdle}");
			return;
		}
		string text = "idle";
		if (endClips != null && endClips.Length == nLen && nPlayingClipIndex >= 0 && nPlayingClipIndex < nLen)
		{
			AnimationClip animationClip = endClips[nPlayingClipIndex];
			if (animationClip != null)
			{
				text = animationClip.name;
			}
		}
		LogInEditor($"[XIA]on anim end {nInstanceId}, {bAutoIdle}, {nPlayingClipIndex}, {nLen}, {text}");
		PlayAnim(text, bLoop: true, bToIdleOnEnd: false, bForcePlay: false);
	}

	private void PlayAnim(string sClipName, bool bLoop, bool bToIdleOnEnd, bool bForcePlay, bool forceNoFadeIn = false)
	{
		if (string.IsNullOrEmpty(sClipName))
		{
			return;
		}
		string text = FallbackAnimClipName(sClipName);
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		LogInEditor($"[XIA]play, name:{sClipName}, fallback:{text}, loop:{bLoop}, toIdleOnEnd:{bToIdleOnEnd}, force:{bForcePlay}, noFadeIn:{forceNoFadeIn}");
		if (text != sClipName && text == "idle")
		{
			bLoop = true;
			forceNoFadeIn = true;
		}
		sClipName = text;
		bAutoIdle = !bLoop && bToIdleOnEnd;
		if (nPlayingClipIndex >= 0 && nPlayingClipIndex < nLen)
		{
			AnimationClip animationClip = clips[nPlayingClipIndex];
			if (animationClip != null && string.Equals(animationClip.name, sClipName) && (!bForcePlay || sClipName == "idle"))
			{
				return;
			}
		}
		for (int i = 0; i < nLen; i++)
		{
			AnimationClip animationClip = clips[i];
			if (animationClip != null && animationClip.name == sClipName)
			{
				nPlayingClipIndex = i;
				nPlayingInstanceId = GetClipInstanceId(animationClip);
				ProcL2DAnimEvent(nPlayingClipIndex, sClipName);
				LogInEditor($"[XIA]play!! name:{animationClip.name}, loop:{bLoop}");
				mc.PlayAnimation(animationClip, 0, 3, bLoop, 1f, forceNoFadeIn);
				break;
			}
		}
	}

	private IEnumerator StopAnimInTimeline()
	{
		yield return wait_end_frame;
		mc.StopAnimation(0);
	}

	private string CheckAnimExist(string name)
	{
		for (int i = 0; i < nLen; i++)
		{
			AnimationClip animationClip = clips[i];
			if (animationClip != null && animationClip.name == name)
			{
				return name;
			}
		}
		return string.Empty;
	}

	private string FallbackAnimClipName(string name)
	{
		if (!string.IsNullOrEmpty(CheckAnimExist(name)))
		{
			return name;
		}
		if (name.StartsWith("vo_cgstory_"))
		{
			name = name.Substring(0, name.Length - 2) + "cn";
			return name;
		}
		return SpecifyFallbackAnim(name);
	}

	private string SpecifyFallbackAnim(string name)
	{
		Dictionary<string, string[]> dictL2DFallbackOrder = NovaCoreAPI.dictL2DFallbackOrder;
		if (dictL2DFallbackOrder.Count <= 0)
		{
			dictL2DFallbackOrder = dictFallbackOrder;
		}
		if (dictL2DFallbackOrder.TryGetValue(name, out var value) && value != null && value.Length != 0)
		{
			foreach (string result in value)
			{
				if (!string.IsNullOrEmpty(CheckAnimExist(result)))
				{
					return result;
				}
			}
		}
		return "idle";
	}

	public void PlayAnimInTimeline(string sClipName, bool bLoop, bool bPreHold)
	{
		if (bPreHold)
		{
			StartCoroutine("StopAnimInTimeline");
		}
		if (bSkipL2DCGAnim)
		{
			PlayAnim(sClipName, bLoop, bToIdleOnEnd: false, bForcePlay: true, forceNoFadeIn: true);
			bSkipL2DCGAnim = false;
		}
		else
		{
			PlayAnim(sClipName, bLoop, bToIdleOnEnd: false, bForcePlay: true);
		}
	}

	public void PlayAnimInUI(string sClipName, bool bLoop, bool bForcePlay)
	{
		PlayAnim(sClipName, bLoop, bToIdleOnEnd: true, bForcePlay);
	}

	private void ProcL2DAnimEvent(int nAnimIndex, string sAnimClipName)
	{
		if (!sAnimClipName.StartsWith("vo_cgstory_"))
		{
			return;
		}
		if (eventTimer != null)
		{
			StopCoroutine(eventTimer);
			eventTimer = null;
			for (int i = nEventIdx; i < nEventLen; i++)
			{
				FireEvent(curAnimEvents.events[i]);
			}
		}
		fElapsedTime = 0f;
		fTimeStamp = Time.realtimeSinceStartup;
		curAnimEvents = animEvents[nAnimIndex];
		nEventLen = curAnimEvents.events.Length;
		nEventIdx = 0;
		_event = curAnimEvents.events[nEventIdx];
		eventTimer = StartCoroutine(EventTimer());
	}

	private IEnumerator EventTimer()
	{
		yield return wait;
		while (nEventIdx < nEventLen)
		{
			fElapsedTime = Time.realtimeSinceStartup - fTimeStamp;
			if (fElapsedTime >= _event.timeStamp)
			{
				FireEvent(_event);
				_event = ((++nEventIdx < nEventLen) ? curAnimEvents.events[nEventIdx] : null);
			}
			yield return null;
		}
		eventTimer = null;
		fElapsedTime = (fTimeStamp = 0f);
		curAnimEvents = null;
		L2DAnimPlayer l2DAnimPlayer = this;
		L2DAnimPlayer l2DAnimPlayer2 = this;
		int num = 0;
		l2DAnimPlayer2.nEventIdx = 0;
		l2DAnimPlayer.nEventLen = num;
		_event = null;
	}

	private void FireEvent(L2DEvent e)
	{
		if (!string.IsNullOrEmpty(e.eventName))
		{
			LogInEditor("trigger L2D anim event by timer:" + e.eventName);
			MonoSingleton<LuaManager>.Instance?.FireEvent(e.eventName, e.data);
		}
	}

	public void OnL2DAnimEvent(string sParam)
	{
		if (!UseTimerEvent)
		{
			LogInEditor("trigger L2D anim event by anim:" + sParam);
			MonoSingleton<LuaManager>.Instance?.FireEvent(sParam);
		}
	}

	public void OnL2DAnimEvent_CGFX(int n)
	{
		if (!UseTimerEvent)
		{
			LogInEditor("trigger L2D anim event by anim: cgfx, n:" + n);
			MonoSingleton<LuaManager>.Instance?.FireEvent("cgfx", n);
		}
	}

	public void OnL2DAnimEvent_LCGFX_ON(int n)
	{
		if (!UseTimerEvent)
		{
			LogInEditor("trigger L2D anim event by anim: lcgfx_on, n:" + n);
			MonoSingleton<LuaManager>.Instance?.FireEvent("lcgfx_on", n);
		}
	}

	public void OnL2DAnimEvent_LCGFX_OFF(int n)
	{
		if (!UseTimerEvent)
		{
			LogInEditor("trigger L2D anim event by anim: lcgfx_off, n:" + n);
			MonoSingleton<LuaManager>.Instance?.FireEvent("lcgfx_off", n);
		}
	}

	public int CheckL2DAnimEventCount(string sAnimName)
	{
		int num = clips.Length;
		int num2 = animEvents.Length;
		if (num != num2)
		{
			return 0;
		}
		for (int i = 0; i < num2; i++)
		{
			if (!(clips[i].name == sAnimName))
			{
				continue;
			}
			L2DEvent[] events = animEvents[i].events;
			List<int> list = new List<int>();
			list.Add(0);
			list.Add(0);
			list.Add(0);
			list.Add(0);
			int num3 = events.Length;
			for (int j = 0; j < num3; j++)
			{
				switch (events[j].eventName)
				{
				case "start":
					list.get_Item(0)++;
					break;
				case "next":
					list.get_Item(1)++;
					break;
				case "end":
					list.get_Item(2)++;
					break;
				case "done":
					list.get_Item(3)++;
					break;
				}
			}
			return list.get_Item(1);
		}
		return 0;
	}
}
