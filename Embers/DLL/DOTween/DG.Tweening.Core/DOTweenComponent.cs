using System;
using System.Collections;
using System.Reflection;
using UnityEngine;

namespace DG.Tweening.Core;

[AddComponentMenu("")]
public class DOTweenComponent : MonoBehaviour, IDOTweenInit
{
	public int inspectorUpdater;

	private float _unscaledTime;

	private float _unscaledDeltaTime;

	private bool _paused;

	private float _pausedTime;

	private bool _isQuitting;

	private bool _duplicateToDestroy;

	private void Awake()
	{
		if ((Object)(object)DOTween.instance == (Object)null)
		{
			DOTween.instance = this;
			inspectorUpdater = 0;
			_unscaledTime = Time.realtimeSinceStartup;
			Type looseScriptType = DOTweenUtils.GetLooseScriptType("DG.Tweening.DOTweenModuleUtils");
			if ((object)looseScriptType == null)
			{
				Debugger.LogError("Couldn't load Modules system");
			}
			else
			{
				looseScriptType.GetMethod("Init", BindingFlags.Static | BindingFlags.Public).Invoke(null, null);
			}
		}
		else
		{
			if (Debugger.logPriority >= 1)
			{
				Debugger.LogWarning("Duplicate DOTweenComponent instance found in scene: destroying it");
			}
			Object.Destroy((Object)(object)((Component)this).gameObject);
		}
	}

	private void Start()
	{
		if ((Object)(object)DOTween.instance != (Object)(object)this)
		{
			_duplicateToDestroy = true;
			Object.Destroy((Object)(object)((Component)this).gameObject);
		}
	}

	private void Update()
	{
		_unscaledDeltaTime = Time.realtimeSinceStartup - _unscaledTime;
		if (DOTween.useSmoothDeltaTime && _unscaledDeltaTime > DOTween.maxSmoothUnscaledTime)
		{
			_unscaledDeltaTime = DOTween.maxSmoothUnscaledTime;
		}
		if (TweenManager.hasActiveDefaultTweens)
		{
			TweenManager.Update(UpdateType.Normal, (DOTween.useSmoothDeltaTime ? Time.smoothDeltaTime : Time.deltaTime) * DOTween.timeScale, _unscaledDeltaTime * DOTween.unscaledTimeScale * DOTween.timeScale);
		}
		_unscaledTime = Time.realtimeSinceStartup;
		if (!TweenManager.isUnityEditor)
		{
			return;
		}
		inspectorUpdater++;
		if (DOTween.showUnityEditorReport && TweenManager.hasActiveTweens)
		{
			if (TweenManager.totActiveTweeners > DOTween.maxActiveTweenersReached)
			{
				DOTween.maxActiveTweenersReached = TweenManager.totActiveTweeners;
			}
			if (TweenManager.totActiveSequences > DOTween.maxActiveSequencesReached)
			{
				DOTween.maxActiveSequencesReached = TweenManager.totActiveSequences;
			}
		}
	}

	private void LateUpdate()
	{
		if (TweenManager.hasActiveLateTweens)
		{
			TweenManager.Update(UpdateType.Late, (DOTween.useSmoothDeltaTime ? Time.smoothDeltaTime : Time.deltaTime) * DOTween.timeScale, _unscaledDeltaTime * DOTween.unscaledTimeScale * DOTween.timeScale);
		}
	}

	private void FixedUpdate()
	{
		if (TweenManager.hasActiveFixedTweens && Time.timeScale > 0f)
		{
			TweenManager.Update(UpdateType.Fixed, (DOTween.useSmoothDeltaTime ? Time.smoothDeltaTime : Time.deltaTime) * DOTween.timeScale, (DOTween.useSmoothDeltaTime ? Time.smoothDeltaTime : Time.deltaTime) / Time.timeScale * DOTween.unscaledTimeScale * DOTween.timeScale);
		}
	}

	private void OnDrawGizmos()
	{
		if (!DOTween.drawGizmos || !TweenManager.isUnityEditor)
		{
			return;
		}
		int count = DOTween.GizmosDelegates.Count;
		if (count != 0)
		{
			for (int i = 0; i < count; i++)
			{
				DOTween.GizmosDelegates[i]();
			}
		}
	}

	private void OnDestroy()
	{
		if (_duplicateToDestroy)
		{
			return;
		}
		if (DOTween.showUnityEditorReport)
		{
			Debugger.LogReport("Max overall simultaneous active Tweeners/Sequences: " + DOTween.maxActiveTweenersReached + "/" + DOTween.maxActiveSequencesReached);
		}
		if (DOTween.useSafeMode)
		{
			int totErrors = DOTween.safeModeReport.GetTotErrors();
			if (totErrors > 0)
			{
				string text = $"DOTween's safe mode captured {totErrors} errors. This is usually ok (it's what safe mode is there for) but if your game is encountering issues you should set Log Behaviour to Default in DOTween Utility Panel in order to get detailed warnings when an error is captured (consider that these errors are always on the user side).";
				if (DOTween.safeModeReport.totMissingTargetOrFieldErrors > 0)
				{
					text = text + "\n- " + DOTween.safeModeReport.totMissingTargetOrFieldErrors + " missing target or field errors";
				}
				if (DOTween.safeModeReport.totStartupErrors > 0)
				{
					text = text + "\n- " + DOTween.safeModeReport.totStartupErrors + " startup errors";
				}
				if (DOTween.safeModeReport.totCallbackErrors > 0)
				{
					text = text + "\n- " + DOTween.safeModeReport.totCallbackErrors + " errors inside callbacks (these might be important)";
				}
				if (DOTween.safeModeReport.totUnsetErrors > 0)
				{
					text = text + "\n- " + DOTween.safeModeReport.totUnsetErrors + " undetermined errors (these might be important)";
				}
				Debugger.LogSafeModeReport(text);
			}
		}
		if ((Object)(object)DOTween.instance == (Object)(object)this)
		{
			DOTween.instance = null;
		}
		DOTween.Clear(destroy: true, _isQuitting);
	}

	public void OnApplicationPause(bool pauseStatus)
	{
		if (pauseStatus)
		{
			_paused = true;
			_pausedTime = Time.realtimeSinceStartup;
		}
		else if (_paused)
		{
			_paused = false;
			_unscaledTime += Time.realtimeSinceStartup - _pausedTime;
		}
	}

	private void OnApplicationQuit()
	{
		_isQuitting = true;
		DOTween.isQuitting = true;
	}

	public IDOTweenInit SetCapacity(int tweenersCapacity, int sequencesCapacity)
	{
		TweenManager.SetCapacities(tweenersCapacity, sequencesCapacity);
		return this;
	}

	internal IEnumerator WaitForCompletion(Tween t)
	{
		while (t.active && !t.isComplete)
		{
			yield return null;
		}
	}

	internal IEnumerator WaitForRewind(Tween t)
	{
		while (t.active && (!t.playedOnce || t.position * (float)(t.completedLoops + 1) > 0f))
		{
			yield return null;
		}
	}

	internal IEnumerator WaitForKill(Tween t)
	{
		while (t.active)
		{
			yield return null;
		}
	}

	internal IEnumerator WaitForElapsedLoops(Tween t, int elapsedLoops)
	{
		while (t.active && t.completedLoops < elapsedLoops)
		{
			yield return null;
		}
	}

	internal IEnumerator WaitForPosition(Tween t, float position)
	{
		while (t.active && t.position * (float)(t.completedLoops + 1) < position)
		{
			yield return null;
		}
	}

	internal IEnumerator WaitForStart(Tween t)
	{
		while (t.active && !t.playedOnce)
		{
			yield return null;
		}
	}

	internal static void Create()
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Expected O, but got Unknown
		if (!((Object)(object)DOTween.instance != (Object)null))
		{
			GameObject val = new GameObject("[DOTween]");
			Object.DontDestroyOnLoad((Object)val);
			DOTween.instance = val.AddComponent<DOTweenComponent>();
		}
	}

	internal static void DestroyInstance()
	{
		if ((Object)(object)DOTween.instance != (Object)null)
		{
			Object.Destroy((Object)(object)((Component)DOTween.instance).gameObject);
		}
		DOTween.instance = null;
	}
}
