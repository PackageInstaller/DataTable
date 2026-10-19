using System;
using System.Collections.Generic;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;

namespace DG.Tweening;

public sealed class Sequence : Tween
{
	internal readonly List<Tween> sequencedTweens = new List<Tween>();

	private readonly List<ABSSequentiable> _sequencedObjs = new List<ABSSequentiable>();

	internal float lastTweenInsertTime;

	internal Sequence()
	{
		tweenType = TweenType.Sequence;
		Reset();
	}

	internal static Sequence DoPrepend(Sequence inSequence, Tween t)
	{
		if (t.loops == -1)
		{
			t.loops = int.MaxValue;
			Debugger.LogWarning("Infinite loops aren't allowed inside a Sequence (only on the Sequence itself) and will be changed to int.MaxValue", t);
		}
		float num = t.delay + t.duration * (float)t.loops;
		inSequence.duration += num;
		int count = inSequence._sequencedObjs.Count;
		for (int i = 0; i < count; i++)
		{
			ABSSequentiable aBSSequentiable = inSequence._sequencedObjs[i];
			aBSSequentiable.sequencedPosition += num;
			aBSSequentiable.sequencedEndPosition += num;
		}
		return DoInsert(inSequence, t, 0f);
	}

	internal static Sequence DoInsert(Sequence inSequence, Tween t, float atPosition)
	{
		TweenManager.AddActiveTweenToSequence(t);
		atPosition += t.delay;
		inSequence.lastTweenInsertTime = atPosition;
		t.isSequenced = (t.creationLocked = true);
		t.sequenceParent = inSequence;
		if (t.loops == -1)
		{
			t.loops = int.MaxValue;
			Debugger.LogWarning("Infinite loops aren't allowed inside a Sequence (only on the Sequence itself) and will be changed to int.MaxValue", t);
		}
		float num = t.duration * (float)t.loops;
		t.autoKill = false;
		t.delay = (t.elapsedDelay = 0f);
		t.delayComplete = true;
		if (t.isSpeedBased)
		{
			t.isSpeedBased = false;
			Debugger.LogWarning("SpeedBased tweens are not allowed inside a Sequence: interpreting speed as duration", t);
		}
		t.sequencedPosition = atPosition;
		t.sequencedEndPosition = atPosition + num;
		if (t.sequencedEndPosition > inSequence.duration)
		{
			inSequence.duration = t.sequencedEndPosition;
		}
		inSequence._sequencedObjs.Add(t);
		inSequence.sequencedTweens.Add(t);
		return inSequence;
	}

	internal static Sequence DoAppendInterval(Sequence inSequence, float interval)
	{
		inSequence.lastTweenInsertTime = inSequence.duration;
		inSequence.duration += interval;
		return inSequence;
	}

	internal static Sequence DoPrependInterval(Sequence inSequence, float interval)
	{
		inSequence.lastTweenInsertTime = 0f;
		inSequence.duration += interval;
		int count = inSequence._sequencedObjs.Count;
		for (int i = 0; i < count; i++)
		{
			ABSSequentiable aBSSequentiable = inSequence._sequencedObjs[i];
			aBSSequentiable.sequencedPosition += interval;
			aBSSequentiable.sequencedEndPosition += interval;
		}
		return inSequence;
	}

	internal static Sequence DoInsertCallback(Sequence inSequence, TweenCallback callback, float atPosition)
	{
		inSequence.lastTweenInsertTime = atPosition;
		SequenceCallback sequenceCallback = new SequenceCallback(atPosition, callback);
		sequenceCallback.sequencedPosition = (sequenceCallback.sequencedEndPosition = atPosition);
		inSequence._sequencedObjs.Add(sequenceCallback);
		if (inSequence.duration < atPosition)
		{
			inSequence.duration = atPosition;
		}
		return inSequence;
	}

	internal override float UpdateDelay(float elapsed)
	{
		float num = delay;
		if (elapsed > num)
		{
			elapsedDelay = num;
			delayComplete = true;
			return elapsed - num;
		}
		elapsedDelay = elapsed;
		return 0f;
	}

	internal override void Reset()
	{
		base.Reset();
		sequencedTweens.Clear();
		_sequencedObjs.Clear();
		lastTweenInsertTime = 0f;
	}

	internal override bool Validate()
	{
		int count = sequencedTweens.Count;
		for (int i = 0; i < count; i++)
		{
			if (!sequencedTweens[i].Validate())
			{
				return false;
			}
		}
		return true;
	}

	internal override bool Startup()
	{
		return DoStartup(this);
	}

	internal override bool ApplyTween(float prevPosition, int prevCompletedLoops, int newCompletedSteps, bool useInversePosition, UpdateMode updateMode, UpdateNotice updateNotice)
	{
		return DoApplyTween(this, prevPosition, prevCompletedLoops, newCompletedSteps, useInversePosition, updateMode);
	}

	internal static void Setup(Sequence s)
	{
		s.autoKill = DOTween.defaultAutoKill;
		s.isRecyclable = DOTween.defaultRecyclable;
		s.isPlaying = DOTween.defaultAutoPlay == AutoPlay.All || DOTween.defaultAutoPlay == AutoPlay.AutoPlaySequences;
		s.loopType = DOTween.defaultLoopType;
		s.easeType = Ease.Linear;
		s.easeOvershootOrAmplitude = DOTween.defaultEaseOvershootOrAmplitude;
		s.easePeriod = DOTween.defaultEasePeriod;
	}

	internal static bool DoStartup(Sequence s)
	{
		int count = s._sequencedObjs.Count;
		if (s.sequencedTweens.Count == 0 && count == 0 && !IsAnyCallbackSet(s))
		{
			return false;
		}
		s.startupDone = true;
		s.fullDuration = ((s.loops > -1) ? (s.duration * (float)s.loops) : float.PositiveInfinity);
		StableSortSequencedObjs(s._sequencedObjs);
		if (s.isRelative)
		{
			int count2 = s.sequencedTweens.Count;
			for (int i = 0; i < count2; i++)
			{
				_ = s.sequencedTweens[i];
				if (!s.isBlendable)
				{
					s.sequencedTweens[i].isRelative = true;
				}
			}
		}
		if (s.isInverted)
		{
			for (int j = 0; j < count; j++)
			{
				ABSSequentiable aBSSequentiable = s._sequencedObjs[j];
				if (aBSSequentiable.tweenType == TweenType.Tweener)
				{
					Tween tween = (Tween)aBSSequentiable;
					TweenManager.Goto(tween, tween.duration * (float)tween.loops, andPlay: false, UpdateMode.IgnoreOnComplete);
					tween.isInverted = true;
				}
			}
		}
		return true;
	}

	internal static bool DoApplyTween(Sequence s, float prevPosition, int prevCompletedLoops, int newCompletedSteps, bool useInversePosition, UpdateMode updateMode)
	{
		float num = prevPosition;
		float num2 = s.position;
		if (s.isInverted)
		{
			useInversePosition = !useInversePosition;
		}
		if (s.easeType != Ease.Linear)
		{
			num = s.duration * EaseManager.Evaluate(s.easeType, s.customEase, num, s.duration, s.easeOvershootOrAmplitude, s.easePeriod);
			num2 = s.duration * EaseManager.Evaluate(s.easeType, s.customEase, num2, s.duration, s.easeOvershootOrAmplitude, s.easePeriod);
		}
		float num3 = 0f;
		bool flag = (s.loops == -1 || s.loops > 1) && s.loopType == LoopType.Yoyo && ((num < s.duration) ? (prevCompletedLoops % 2 != 0) : (prevCompletedLoops % 2 == 0));
		if (s.isBackwards)
		{
			flag = !flag;
		}
		if (s.isInverted)
		{
			flag = !flag;
		}
		float num8;
		if (newCompletedSteps > 0)
		{
			int num4 = s.completedLoops;
			float num5 = s.position;
			int num6 = newCompletedSteps;
			int num7 = 0;
			num8 = num;
			if (updateMode == UpdateMode.Update)
			{
				while (num7 < num6)
				{
					if (num7 > 0)
					{
						num8 = num3;
					}
					else if (flag && !s.isBackwards)
					{
						num8 = s.duration - num8;
					}
					num3 = (flag ? 0f : s.duration);
					if (ApplyInternalCycle(s, num8, num3, updateMode, useInversePosition, flag, multiCycleStep: true))
					{
						return true;
					}
					num7++;
					if (s.hasLoops && s.loopType == LoopType.Yoyo)
					{
						flag = !flag;
					}
				}
				if (num4 != s.completedLoops || Math.Abs(num5 - s.position) > float.Epsilon)
				{
					return !s.active;
				}
			}
			else
			{
				if (s.hasLoops && s.loopType == LoopType.Yoyo && newCompletedSteps % 2 != 0)
				{
					flag = !flag;
					num = s.duration - num;
				}
				newCompletedSteps = 0;
			}
		}
		if (newCompletedSteps == 1 && s.isComplete)
		{
			return false;
		}
		if (newCompletedSteps > 0 && !s.isComplete)
		{
			num8 = (useInversePosition ? s.duration : 0f);
			if (s.loopType == LoopType.Restart && num3 > 0f)
			{
				ApplyInternalCycle(s, s.duration, 0f, UpdateMode.Goto, useInverse: false, prevPosIsInverse: false);
			}
		}
		else
		{
			num8 = (useInversePosition ? (s.duration - num) : num);
		}
		return ApplyInternalCycle(s, num8, useInversePosition ? (s.duration - num2) : num2, updateMode, useInversePosition, flag);
	}

	private static bool ApplyInternalCycle(Sequence s, float fromPos, float toPos, UpdateMode updateMode, bool useInverse, bool prevPosIsInverse, bool multiCycleStep = false)
	{
		bool flag = s.isPlaying;
		if (toPos < fromPos)
		{
			int num = s._sequencedObjs.Count - 1;
			for (int num2 = num; num2 > -1; num2--)
			{
				if (!s.active)
				{
					return true;
				}
				if (!s.isPlaying & flag)
				{
					return false;
				}
				ABSSequentiable aBSSequentiable = s._sequencedObjs[num2];
				if (!(aBSSequentiable.sequencedEndPosition < toPos) && !(aBSSequentiable.sequencedPosition > fromPos))
				{
					if (aBSSequentiable.tweenType == TweenType.Callback)
					{
						if ((updateMode == UpdateMode.Update) & prevPosIsInverse)
						{
							Tween.OnTweenCallback(aBSSequentiable.onStart, s);
						}
					}
					else
					{
						float num3 = toPos - aBSSequentiable.sequencedPosition;
						if (num3 < 0f)
						{
							num3 = 0f;
						}
						Tween tween = (Tween)aBSSequentiable;
						if (tween.startupDone)
						{
							tween.isBackwards = true;
							if (s.isInverted)
							{
								num3 = tween.fullDuration - num3;
							}
							if (TweenManager.Goto(tween, num3, andPlay: false, updateMode))
							{
								if (DOTween.nestedTweenFailureBehaviour == NestedTweenFailureBehaviour.KillWholeSequence)
								{
									return true;
								}
								if (s.sequencedTweens.Count == 1 && s._sequencedObjs.Count == 1 && !IsAnyCallbackSet(s))
								{
									return true;
								}
								TweenManager.Despawn(tween, modifyActiveLists: false);
								s._sequencedObjs.RemoveAt(num2);
								s.sequencedTweens.Remove(tween);
								num2--;
								num--;
							}
							else if (multiCycleStep && tween.tweenType == TweenType.Sequence)
							{
								if (s.position <= 0f && s.completedLoops == 0)
								{
									tween.position = 0f;
								}
								else
								{
									bool flag2 = s.completedLoops == 0 || (s.isBackwards && (s.completedLoops < s.loops || s.loops == -1));
									if (tween.isBackwards)
									{
										flag2 = !flag2;
									}
									if (useInverse)
									{
										flag2 = !flag2;
									}
									if (s.isBackwards && !useInverse && !prevPosIsInverse)
									{
										flag2 = !flag2;
									}
									tween.position = (flag2 ? 0f : tween.duration);
								}
							}
						}
					}
				}
			}
		}
		else
		{
			int num4 = s._sequencedObjs.Count;
			for (int i = 0; i < num4; i++)
			{
				if (!s.active)
				{
					return true;
				}
				if (!s.isPlaying & flag)
				{
					return false;
				}
				ABSSequentiable aBSSequentiable2 = s._sequencedObjs[i];
				if (aBSSequentiable2.sequencedPosition > toPos || (aBSSequentiable2.sequencedPosition > 0f && aBSSequentiable2.sequencedEndPosition <= fromPos) || (aBSSequentiable2.sequencedPosition <= 0f && aBSSequentiable2.sequencedEndPosition < fromPos))
				{
					continue;
				}
				if (aBSSequentiable2.tweenType == TweenType.Callback)
				{
					if (updateMode == UpdateMode.Update && ((!s.isBackwards && !useInverse && !prevPosIsInverse) || ((s.isBackwards & useInverse) && !prevPosIsInverse)))
					{
						Tween.OnTweenCallback(aBSSequentiable2.onStart, s);
					}
					continue;
				}
				float num5 = toPos - aBSSequentiable2.sequencedPosition;
				if (num5 < 0f)
				{
					num5 = 0f;
				}
				Tween tween2 = (Tween)aBSSequentiable2;
				if (toPos >= aBSSequentiable2.sequencedEndPosition)
				{
					if (!tween2.startupDone)
					{
						TweenManager.ForceInit(tween2, isSequenced: true);
					}
					if (num5 < tween2.fullDuration)
					{
						num5 = tween2.fullDuration;
					}
				}
				tween2.isBackwards = false;
				if (s.isInverted)
				{
					num5 = tween2.fullDuration - num5;
				}
				if (TweenManager.Goto(tween2, num5, andPlay: false, updateMode))
				{
					if (DOTween.nestedTweenFailureBehaviour == NestedTweenFailureBehaviour.KillWholeSequence)
					{
						return true;
					}
					if (s.sequencedTweens.Count == 1 && s._sequencedObjs.Count == 1 && !IsAnyCallbackSet(s))
					{
						return true;
					}
					TweenManager.Despawn(tween2, modifyActiveLists: false);
					s._sequencedObjs.RemoveAt(i);
					s.sequencedTweens.Remove(tween2);
					i--;
					num4--;
				}
				else
				{
					if (!multiCycleStep || tween2.tweenType != TweenType.Sequence)
					{
						continue;
					}
					if (s.position <= 0f && s.completedLoops == 0)
					{
						tween2.position = 0f;
						continue;
					}
					bool flag3 = s.completedLoops == 0 || (!s.isBackwards && (s.completedLoops < s.loops || s.loops == -1));
					if (tween2.isBackwards)
					{
						flag3 = !flag3;
					}
					if (useInverse)
					{
						flag3 = !flag3;
					}
					if (s.isBackwards && !useInverse && !prevPosIsInverse)
					{
						flag3 = !flag3;
					}
					tween2.position = (flag3 ? 0f : tween2.duration);
				}
			}
		}
		return false;
	}

	private static void StableSortSequencedObjs(List<ABSSequentiable> list)
	{
		int count = list.Count;
		for (int i = 1; i < count; i++)
		{
			int num = i;
			ABSSequentiable aBSSequentiable = list[i];
			while (num > 0 && list[num - 1].sequencedPosition > aBSSequentiable.sequencedPosition)
			{
				list[num] = list[num - 1];
				num--;
			}
			list[num] = aBSSequentiable;
		}
	}

	private static bool IsAnyCallbackSet(Sequence s)
	{
		if (s.onComplete == null && s.onKill == null && s.onPause == null && s.onPlay == null && s.onRewind == null && s.onStart == null && s.onStepComplete == null)
		{
			return s.onUpdate != null;
		}
		return true;
	}
}
