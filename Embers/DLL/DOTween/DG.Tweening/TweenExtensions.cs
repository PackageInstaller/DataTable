using DG.Tweening.Core;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core.PathCore;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening;

public static class TweenExtensions
{
	public static void Complete(this Tween t)
	{
		t.Complete(withCallbacks: false);
	}

	public static void Complete(this Tween t, bool withCallbacks)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.Complete(t, modifyActiveLists: true, (!withCallbacks) ? UpdateMode.Goto : UpdateMode.Update);
		}
	}

	public static void Flip(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.Flip(t);
		}
	}

	public static void ForceInit(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.ForceInit(t);
		}
	}

	public static void Goto(this Tween t, float to, bool andPlay = false)
	{
		DoGoto(t, to, andPlay, withCallbacks: false);
	}

	public static void GotoWithCallbacks(this Tween t, float to, bool andPlay = false)
	{
		DoGoto(t, to, andPlay, withCallbacks: true);
	}

	private static void DoGoto(Tween t, float to, bool andPlay, bool withCallbacks)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return;
		}
		if (to < 0f)
		{
			to = 0f;
		}
		if (!t.startupDone)
		{
			TweenManager.ForceInit(t);
		}
		TweenManager.Goto(t, to, andPlay, (!withCallbacks) ? UpdateMode.Goto : UpdateMode.Update);
	}

	public static void Kill(this Tween t, bool complete = false)
	{
		if (!DOTween.initialized || t == null || !t.active)
		{
			return;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return;
		}
		if (complete)
		{
			TweenManager.Complete(t);
			if (t.autoKill && t.loops >= 0)
			{
				return;
			}
		}
		if (TweenManager.isUpdateLoop)
		{
			t.active = false;
		}
		else
		{
			TweenManager.Despawn(t);
		}
	}

	public static void ManualUpdate(this Tween t, float deltaTime, float unscaledDeltaTime)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.Update(t, deltaTime, unscaledDeltaTime, isSingleTweenManualUpdate: true);
		}
	}

	public static T Pause<T>(this T t) where T : Tween
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return t;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return t;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return t;
		}
		TweenManager.Pause(t);
		return t;
	}

	public static T Play<T>(this T t) where T : Tween
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return t;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return t;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return t;
		}
		TweenManager.Play(t);
		return t;
	}

	public static void PlayBackwards(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.PlayBackwards(t);
		}
	}

	public static void PlayForward(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.PlayForward(t);
		}
	}

	public static void Restart(this Tween t, bool includeDelay = true, float changeDelayTo = -1f)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.Restart(t, includeDelay, changeDelayTo);
		}
	}

	public static void Rewind(this Tween t, bool includeDelay = true)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.Rewind(t, includeDelay);
		}
	}

	public static void SmoothRewind(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.SmoothRewind(t);
		}
	}

	public static void TogglePause(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
		}
		else if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
		}
		else if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
		}
		else
		{
			TweenManager.TogglePause(t);
		}
	}

	public static void GotoWaypoint(this Tween t, int waypointIndex, bool andPlay = false)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return;
		}
		if (!(t is TweenerCore<Vector3, Path, PathOptions> tweenerCore))
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNonPathTween(t);
			}
			return;
		}
		if (!t.startupDone)
		{
			TweenManager.ForceInit(t);
		}
		if (waypointIndex < 0)
		{
			waypointIndex = 0;
		}
		else if (waypointIndex > tweenerCore.changeValue.wps.Length - 1)
		{
			waypointIndex = tweenerCore.changeValue.wps.Length - 1;
		}
		float num = 0f;
		for (int i = 0; i < waypointIndex + 1; i++)
		{
			num += tweenerCore.changeValue.wpLengths[i];
		}
		float num2 = num / tweenerCore.changeValue.length;
		if (t.hasLoops && t.loopType == LoopType.Yoyo && ((t.position < t.duration) ? ((byte)(t.completedLoops % 2) != 0) : (t.completedLoops % 2 == 0)))
		{
			num2 = 1f - num2;
		}
		float to = (float)(t.isComplete ? (t.completedLoops - 1) : t.completedLoops) * t.duration + num2 * t.duration;
		TweenManager.Goto(t, to, andPlay);
	}

	public static YieldInstruction WaitForCompletion(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		return (YieldInstruction)(object)((MonoBehaviour)DOTween.instance).StartCoroutine(DOTween.instance.WaitForCompletion(t));
	}

	public static YieldInstruction WaitForRewind(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		return (YieldInstruction)(object)((MonoBehaviour)DOTween.instance).StartCoroutine(DOTween.instance.WaitForRewind(t));
	}

	public static YieldInstruction WaitForKill(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		return (YieldInstruction)(object)((MonoBehaviour)DOTween.instance).StartCoroutine(DOTween.instance.WaitForKill(t));
	}

	public static YieldInstruction WaitForElapsedLoops(this Tween t, int elapsedLoops)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		return (YieldInstruction)(object)((MonoBehaviour)DOTween.instance).StartCoroutine(DOTween.instance.WaitForElapsedLoops(t, elapsedLoops));
	}

	public static YieldInstruction WaitForPosition(this Tween t, float position)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		return (YieldInstruction)(object)((MonoBehaviour)DOTween.instance).StartCoroutine(DOTween.instance.WaitForPosition(t, position));
	}

	public static Coroutine WaitForStart(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		return ((MonoBehaviour)DOTween.instance).StartCoroutine(DOTween.instance.WaitForStart(t));
	}

	public static int CompletedLoops(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0;
		}
		return t.completedLoops;
	}

	public static float Delay(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0f;
		}
		return t.delay;
	}

	public static float ElapsedDelay(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0f;
		}
		return t.elapsedDelay;
	}

	public static float Duration(this Tween t, bool includeLoops = true)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0f;
		}
		if (includeLoops)
		{
			if (t.loops != -1)
			{
				return t.duration * (float)t.loops;
			}
			return float.PositiveInfinity;
		}
		return t.duration;
	}

	public static float Elapsed(this Tween t, bool includeLoops = true)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0f;
		}
		if (includeLoops)
		{
			return (float)((t.position >= t.duration) ? (t.completedLoops - 1) : t.completedLoops) * t.duration + t.position;
		}
		return t.position;
	}

	public static float ElapsedPercentage(this Tween t, bool includeLoops = true)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0f;
		}
		if (includeLoops)
		{
			if (t.fullDuration <= 0f)
			{
				return 0f;
			}
			return ((float)((t.position >= t.duration) ? (t.completedLoops - 1) : t.completedLoops) * t.duration + t.position) / t.fullDuration;
		}
		return t.position / t.duration;
	}

	public static float ElapsedDirectionalPercentage(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0f;
		}
		float num = t.position / t.duration;
		if (t.completedLoops <= 0 || !t.hasLoops || t.loopType != LoopType.Yoyo || ((t.isComplete || t.completedLoops % 2 == 0) && (!t.isComplete || t.completedLoops % 2 != 0)))
		{
			return num;
		}
		return 1f - num;
	}

	public static bool IsActive(this Tween t)
	{
		return t?.active ?? false;
	}

	public static bool IsBackwards(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return false;
		}
		return t.isBackwards;
	}

	public static bool IsLoopingOrExecutingBackwards(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return false;
		}
		if (t.isBackwards)
		{
			if (t.completedLoops >= 1 && t.loopType == LoopType.Yoyo)
			{
				return t.completedLoops % 2 == 0;
			}
			return true;
		}
		if (t.completedLoops >= 1 && t.loopType == LoopType.Yoyo)
		{
			return t.completedLoops % 2 != 0;
		}
		return false;
	}

	public static bool IsComplete(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return false;
		}
		return t.isComplete;
	}

	public static bool IsInitialized(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return false;
		}
		return t.startupDone;
	}

	public static bool IsPlaying(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return false;
		}
		return t.isPlaying;
	}

	public static int Loops(this Tween t)
	{
		if (!t.active)
		{
			if (Debugger.logPriority > 0)
			{
				Debugger.LogInvalidTween(t);
			}
			return 0;
		}
		return t.loops;
	}

	public static Vector3 PathGetPoint(this Tween t, float pathPercentage)
	{
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ad: Unknown result type (might be due to invalid IL or missing references)
		if (pathPercentage > 1f)
		{
			pathPercentage = 1f;
		}
		else if (pathPercentage < 0f)
		{
			pathPercentage = 0f;
		}
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return Vector3.zero;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return Vector3.zero;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return Vector3.zero;
		}
		if (!(t is TweenerCore<Vector3, Path, PathOptions> tweenerCore))
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNonPathTween(t);
			}
			return Vector3.zero;
		}
		if (!tweenerCore.endValue.isFinalized)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogWarning("The path is not finalized yet", t);
			}
			return Vector3.zero;
		}
		return tweenerCore.endValue.GetPoint(pathPercentage, convertToConstantPerc: true);
	}

	public static Vector3[] PathGetDrawPoints(this Tween t, int subdivisionsXSegment = 10)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return null;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return null;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return null;
		}
		if (!(t is TweenerCore<Vector3, Path, PathOptions> tweenerCore))
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNonPathTween(t);
			}
			return null;
		}
		if (!tweenerCore.endValue.isFinalized)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogWarning("The path is not finalized yet", t);
			}
			return null;
		}
		return Path.GetDrawPoints(tweenerCore.endValue, subdivisionsXSegment);
	}

	public static float PathLength(this Tween t)
	{
		if (t == null)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNullTween(t);
			}
			return -1f;
		}
		if (!t.active)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogInvalidTween(t);
			}
			return -1f;
		}
		if (t.isSequenced)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNestedTween(t);
			}
			return -1f;
		}
		if (!(t is TweenerCore<Vector3, Path, PathOptions> tweenerCore))
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogNonPathTween(t);
			}
			return -1f;
		}
		if (!tweenerCore.endValue.isFinalized)
		{
			if (Debugger.logPriority > 1)
			{
				Debugger.LogWarning("The path is not finalized yet", t);
			}
			return -1f;
		}
		return tweenerCore.endValue.length;
	}
}
