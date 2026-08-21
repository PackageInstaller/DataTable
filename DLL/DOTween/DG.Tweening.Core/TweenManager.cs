using System;
using System.Collections.Generic;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Core;

internal static class TweenManager
{
	internal enum CapacityIncreaseMode
	{
		TweenersAndSequences,
		TweenersOnly,
		SequencesOnly
	}

	private const int _DefaultMaxTweeners = 200;

	private const int _DefaultMaxSequences = 50;

	private const string _MaxTweensReached = "Max Tweens reached: capacity has automatically been increased from #0 to #1. Use DOTween.SetTweensCapacity to set it manually at startup";

	private const float _EpsilonVsTimeCheck = 1E-06f;

	internal static bool isUnityEditor;

	internal static bool isDebugBuild;

	internal static int maxActive;

	internal static int maxTweeners;

	internal static int maxSequences;

	internal static bool hasActiveTweens;

	internal static bool hasActiveDefaultTweens;

	internal static bool hasActiveLateTweens;

	internal static bool hasActiveFixedTweens;

	internal static bool hasActiveManualTweens;

	internal static int totActiveTweens;

	internal static int totActiveDefaultTweens;

	internal static int totActiveLateTweens;

	internal static int totActiveFixedTweens;

	internal static int totActiveManualTweens;

	internal static int totActiveTweeners;

	internal static int totActiveSequences;

	internal static int totPooledTweeners;

	internal static int totPooledSequences;

	internal static int totTweeners;

	internal static int totSequences;

	internal static bool isUpdateLoop;

	internal static Tween[] _activeTweens;

	private static Tween[] _pooledTweeners;

	private static readonly Stack<Tween> _PooledSequences;

	private static readonly List<Tween> _KillList;

	private static readonly Dictionary<Tween, TweenLink> _TweenLinks;

	private static int _totTweenLinks;

	private static int _maxActiveLookupId;

	private static bool _requiresActiveReorganization;

	private static int _reorganizeFromId;

	private static int _minPooledTweenerId;

	private static int _maxPooledTweenerId;

	private static bool _despawnAllCalledFromUpdateLoopCallback;

	static TweenManager()
	{
		maxActive = 250;
		maxTweeners = 200;
		maxSequences = 50;
		_activeTweens = new Tween[250];
		_pooledTweeners = new Tween[200];
		_PooledSequences = new Stack<Tween>();
		_KillList = new List<Tween>(250);
		_TweenLinks = new Dictionary<Tween, TweenLink>(250);
		_maxActiveLookupId = -1;
		_reorganizeFromId = -1;
		_minPooledTweenerId = -1;
		_maxPooledTweenerId = -1;
		isUnityEditor = Application.isEditor;
	}

	internal static TweenerCore<T1, T2, TPlugOptions> GetTweener<T1, T2, TPlugOptions>() where TPlugOptions : struct, IPlugOptions
	{
		if (totPooledTweeners > 0)
		{
			Type typeFromHandle = typeof(T1);
			Type typeFromHandle2 = typeof(T2);
			Type typeFromHandle3 = typeof(TPlugOptions);
			for (int num = _maxPooledTweenerId; num > _minPooledTweenerId - 1; num--)
			{
				Tween tween = _pooledTweeners[num];
				if (tween != null && (object)tween.typeofT1 == typeFromHandle && (object)tween.typeofT2 == typeFromHandle2 && (object)tween.typeofTPlugOptions == typeFromHandle3)
				{
					TweenerCore<T1, T2, TPlugOptions> obj = (TweenerCore<T1, T2, TPlugOptions>)tween;
					AddActiveTween(obj);
					_pooledTweeners[num] = null;
					if (_maxPooledTweenerId != _minPooledTweenerId)
					{
						if (num == _maxPooledTweenerId)
						{
							_maxPooledTweenerId--;
						}
						else if (num == _minPooledTweenerId)
						{
							_minPooledTweenerId++;
						}
					}
					totPooledTweeners--;
					return obj;
				}
			}
			if (totTweeners >= maxTweeners)
			{
				_pooledTweeners[_maxPooledTweenerId] = null;
				_maxPooledTweenerId--;
				totPooledTweeners--;
				totTweeners--;
			}
		}
		else if (totTweeners >= maxTweeners - 1)
		{
			int num2 = maxTweeners;
			int num3 = maxSequences;
			IncreaseCapacities(CapacityIncreaseMode.TweenersOnly);
			if (Debugger.logPriority >= 1)
			{
				Debugger.LogWarning("Max Tweens reached: capacity has automatically been increased from #0 to #1. Use DOTween.SetTweensCapacity to set it manually at startup".Replace("#0", num2 + "/" + num3).Replace("#1", maxTweeners + "/" + maxSequences));
			}
		}
		TweenerCore<T1, T2, TPlugOptions> tweenerCore = new TweenerCore<T1, T2, TPlugOptions>();
		totTweeners++;
		AddActiveTween(tweenerCore);
		return tweenerCore;
	}

	internal static Sequence GetSequence()
	{
		if (totPooledSequences > 0)
		{
			Sequence obj = (Sequence)_PooledSequences.Pop();
			AddActiveTween(obj);
			totPooledSequences--;
			return obj;
		}
		if (totSequences >= maxSequences - 1)
		{
			int num = maxTweeners;
			int num2 = maxSequences;
			IncreaseCapacities(CapacityIncreaseMode.SequencesOnly);
			if (Debugger.logPriority >= 1)
			{
				Debugger.LogWarning("Max Tweens reached: capacity has automatically been increased from #0 to #1. Use DOTween.SetTweensCapacity to set it manually at startup".Replace("#0", num + "/" + num2).Replace("#1", maxTweeners + "/" + maxSequences));
			}
		}
		Sequence sequence = new Sequence();
		totSequences++;
		AddActiveTween(sequence);
		return sequence;
	}

	internal static void SetUpdateType(Tween t, UpdateType updateType, bool isIndependentUpdate)
	{
		if (!t.active || t.updateType == updateType)
		{
			t.updateType = updateType;
			t.isIndependentUpdate = isIndependentUpdate;
			return;
		}
		if (t.updateType == UpdateType.Normal)
		{
			totActiveDefaultTweens--;
			hasActiveDefaultTweens = totActiveDefaultTweens > 0;
		}
		else
		{
			switch (t.updateType)
			{
			case UpdateType.Fixed:
				totActiveFixedTweens--;
				hasActiveFixedTweens = totActiveFixedTweens > 0;
				break;
			case UpdateType.Late:
				totActiveLateTweens--;
				hasActiveLateTweens = totActiveLateTweens > 0;
				break;
			default:
				totActiveManualTweens--;
				hasActiveManualTweens = totActiveManualTweens > 0;
				break;
			}
		}
		t.updateType = updateType;
		t.isIndependentUpdate = isIndependentUpdate;
		switch (updateType)
		{
		case UpdateType.Normal:
			totActiveDefaultTweens++;
			hasActiveDefaultTweens = true;
			break;
		case UpdateType.Fixed:
			totActiveFixedTweens++;
			hasActiveFixedTweens = true;
			break;
		case UpdateType.Late:
			totActiveLateTweens++;
			hasActiveLateTweens = true;
			break;
		default:
			totActiveManualTweens++;
			hasActiveManualTweens = true;
			break;
		}
	}

	internal static void AddActiveTweenToSequence(Tween t)
	{
		RemoveActiveTween(t);
	}

	internal static int DespawnAll()
	{
		int result = totActiveTweens;
		for (int i = 0; i < _maxActiveLookupId + 1; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween != null)
			{
				Despawn(tween, modifyActiveLists: false);
			}
		}
		ClearTweenArray(_activeTweens);
		hasActiveTweens = (hasActiveDefaultTweens = (hasActiveLateTweens = (hasActiveFixedTweens = (hasActiveManualTweens = false))));
		totActiveTweens = (totActiveDefaultTweens = (totActiveLateTweens = (totActiveFixedTweens = (totActiveManualTweens = 0))));
		totActiveTweeners = (totActiveSequences = 0);
		_maxActiveLookupId = (_reorganizeFromId = -1);
		_requiresActiveReorganization = false;
		_TweenLinks.Clear();
		_totTweenLinks = 0;
		if (isUpdateLoop)
		{
			_despawnAllCalledFromUpdateLoopCallback = true;
		}
		return result;
	}

	internal static void Despawn(Tween t, bool modifyActiveLists = true)
	{
		if (t.onKill != null)
		{
			Tween.OnTweenCallback(t.onKill, t);
		}
		if (modifyActiveLists)
		{
			RemoveActiveTween(t);
		}
		if (t.isRecyclable)
		{
			switch (t.tweenType)
			{
			case TweenType.Sequence:
			{
				_PooledSequences.Push(t);
				totPooledSequences++;
				Sequence sequence = (Sequence)t;
				int count = sequence.sequencedTweens.Count;
				for (int i = 0; i < count; i++)
				{
					Despawn(sequence.sequencedTweens[i], modifyActiveLists: false);
				}
				break;
			}
			case TweenType.Tweener:
				if (_maxPooledTweenerId == -1)
				{
					_maxPooledTweenerId = maxTweeners - 1;
					_minPooledTweenerId = maxTweeners - 1;
				}
				if (_maxPooledTweenerId < maxTweeners - 1)
				{
					_pooledTweeners[_maxPooledTweenerId + 1] = t;
					_maxPooledTweenerId++;
					if (_minPooledTweenerId > _maxPooledTweenerId)
					{
						_minPooledTweenerId = _maxPooledTweenerId;
					}
				}
				else
				{
					for (int num = _maxPooledTweenerId; num > -1; num--)
					{
						if (_pooledTweeners[num] == null)
						{
							_pooledTweeners[num] = t;
							if (num < _minPooledTweenerId)
							{
								_minPooledTweenerId = num;
							}
							if (_maxPooledTweenerId < _minPooledTweenerId)
							{
								_maxPooledTweenerId = _minPooledTweenerId;
							}
							break;
						}
					}
				}
				totPooledTweeners++;
				break;
			}
		}
		else
		{
			switch (t.tweenType)
			{
			case TweenType.Sequence:
			{
				totSequences--;
				Sequence sequence2 = (Sequence)t;
				int count2 = sequence2.sequencedTweens.Count;
				for (int j = 0; j < count2; j++)
				{
					Despawn(sequence2.sequencedTweens[j], modifyActiveLists: false);
				}
				break;
			}
			case TweenType.Tweener:
				totTweeners--;
				break;
			}
		}
		t.active = false;
		t.Reset();
	}

	internal static void PurgeAll(bool isApplicationQuitting)
	{
		if (!isApplicationQuitting)
		{
			for (int i = 0; i < maxActive; i++)
			{
				Tween tween = _activeTweens[i];
				if (tween != null && tween.active)
				{
					tween.active = false;
					if (tween.onKill != null)
					{
						Tween.OnTweenCallback(tween.onKill, tween);
					}
				}
			}
		}
		ClearTweenArray(_activeTweens);
		hasActiveTweens = (hasActiveDefaultTweens = (hasActiveLateTweens = (hasActiveFixedTweens = (hasActiveManualTweens = false))));
		totActiveTweens = (totActiveDefaultTweens = (totActiveLateTweens = (totActiveFixedTweens = (totActiveManualTweens = 0))));
		totActiveTweeners = (totActiveSequences = 0);
		_maxActiveLookupId = (_reorganizeFromId = -1);
		_requiresActiveReorganization = false;
		PurgePools();
		ResetCapacities();
		totTweeners = (totSequences = 0);
	}

	internal static void PurgePools()
	{
		totTweeners -= totPooledTweeners;
		totSequences -= totPooledSequences;
		ClearTweenArray(_pooledTweeners);
		_PooledSequences.Clear();
		totPooledTweeners = (totPooledSequences = 0);
		_minPooledTweenerId = (_maxPooledTweenerId = -1);
	}

	internal static void AddTweenLink(Tween t, TweenLink tweenLink)
	{
		_totTweenLinks++;
		if (_TweenLinks.ContainsKey(t))
		{
			_TweenLinks[t] = tweenLink;
		}
		else
		{
			_TweenLinks.Add(t, tweenLink);
		}
		if (tweenLink.lastSeenActive)
		{
			LinkBehaviour behaviour = tweenLink.behaviour;
			if ((uint)(behaviour - 1) <= 3u)
			{
				Play(t);
			}
		}
		else
		{
			LinkBehaviour behaviour = tweenLink.behaviour;
			if ((uint)behaviour <= 2u)
			{
				Pause(t);
			}
		}
	}

	private static void RemoveTweenLink(Tween t)
	{
		if (_TweenLinks.ContainsKey(t))
		{
			_TweenLinks.Remove(t);
			_totTweenLinks--;
		}
	}

	internal static void ResetCapacities()
	{
		SetCapacities(200, 50);
	}

	internal static void SetCapacities(int tweenersCapacity, int sequencesCapacity)
	{
		if (tweenersCapacity < sequencesCapacity)
		{
			tweenersCapacity = sequencesCapacity;
		}
		maxActive = tweenersCapacity + sequencesCapacity;
		maxTweeners = tweenersCapacity;
		maxSequences = sequencesCapacity;
		Array.Resize(ref _activeTweens, maxActive);
		Array.Resize(ref _pooledTweeners, tweenersCapacity);
		_KillList.Capacity = maxActive;
	}

	internal static int Validate()
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		int num = 0;
		for (int i = 0; i < _maxActiveLookupId + 1; i++)
		{
			Tween tween = _activeTweens[i];
			if (!tween.Validate())
			{
				num++;
				MarkForKilling(tween);
			}
		}
		if (num > 0)
		{
			DespawnActiveTweens(_KillList);
			_KillList.Clear();
		}
		return num;
	}

	internal static void Update(UpdateType updateType, float deltaTime, float independentTime)
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		isUpdateLoop = true;
		bool flag = false;
		int num = _maxActiveLookupId + 1;
		for (int i = 0; i < num; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween != null && tween.updateType == updateType && Update(tween, deltaTime, independentTime, isSingleTweenManualUpdate: false))
			{
				flag = true;
			}
		}
		if (flag)
		{
			if (_despawnAllCalledFromUpdateLoopCallback)
			{
				_despawnAllCalledFromUpdateLoopCallback = false;
			}
			else
			{
				DespawnActiveTweens(_KillList);
			}
			_KillList.Clear();
		}
		isUpdateLoop = false;
	}

	internal static bool Update(Tween t, float deltaTime, float independentTime, bool isSingleTweenManualUpdate)
	{
		if (_totTweenLinks > 0)
		{
			EvaluateTweenLink(t);
		}
		if (!t.active)
		{
			MarkForKilling(t, isSingleTweenManualUpdate);
			return true;
		}
		if (!t.isPlaying)
		{
			return false;
		}
		t.creationLocked = true;
		float num = (t.isIndependentUpdate ? independentTime : deltaTime) * t.timeScale;
		if (num < 1E-06f && num > -1E-06f)
		{
			return false;
		}
		if (!t.delayComplete)
		{
			num = t.UpdateDelay(t.elapsedDelay + num);
			if (num <= -1f)
			{
				MarkForKilling(t, isSingleTweenManualUpdate);
				return true;
			}
			if (num <= 0f)
			{
				return false;
			}
			if (t.playedOnce && t.onPlay != null)
			{
				Tween.OnTweenCallback(t.onPlay, t);
			}
		}
		if (!t.startupDone && !t.Startup())
		{
			MarkForKilling(t, isSingleTweenManualUpdate);
			return true;
		}
		float position = t.position;
		bool flag = position >= t.duration;
		int num2 = t.completedLoops;
		if (t.duration <= 0f)
		{
			position = 0f;
			num2 = ((t.loops == -1) ? (t.completedLoops + 1) : t.loops);
		}
		else
		{
			if (t.isBackwards)
			{
				position -= num;
				while (position < 0f && num2 > -1)
				{
					position += t.duration;
					num2--;
				}
				if (num2 < 0 || (flag && num2 < 1))
				{
					position = 0f;
					num2 = (flag ? 1 : 0);
				}
			}
			else
			{
				position += num;
				while (position >= t.duration && (t.loops == -1 || num2 < t.loops))
				{
					position -= t.duration;
					num2++;
				}
			}
			if (flag)
			{
				num2--;
			}
			if (t.loops != -1 && num2 >= t.loops)
			{
				position = t.duration;
			}
		}
		if (Tween.DoGoto(t, position, num2, UpdateMode.Update))
		{
			MarkForKilling(t, isSingleTweenManualUpdate);
			return true;
		}
		return false;
	}

	internal static int FilteredOperation(OperationType operationType, FilterType filterType, object id, bool optionalBool, float optionalFloat, object optionalObj = null, object[] optionalArray = null)
	{
		int num = 0;
		bool flag = false;
		int num2 = ((optionalArray != null) ? optionalArray.Length : 0);
		bool flag2 = false;
		string text = null;
		bool flag3 = false;
		int num3 = 0;
		if ((uint)(filterType - 1) <= 1u)
		{
			if (id is string)
			{
				flag2 = true;
				text = (string)id;
			}
			else if (id is int)
			{
				flag3 = true;
				num3 = (int)id;
			}
		}
		for (int num4 = _maxActiveLookupId; num4 > -1; num4--)
		{
			Tween tween = _activeTweens[num4];
			if (tween != null && tween.active)
			{
				bool flag4 = false;
				switch (filterType)
				{
				case FilterType.All:
					flag4 = true;
					break;
				case FilterType.TargetOrId:
					flag4 = ((!flag2) ? ((!flag3) ? ((tween.id != null && id.Equals(tween.id)) || (tween.target != null && id.Equals(tween.target))) : (tween.intId == num3)) : (tween.stringId != null && tween.stringId == text));
					break;
				case FilterType.TargetAndId:
					flag4 = ((!flag2) ? ((!flag3) ? (tween.id != null && tween.target != null && optionalObj != null && id.Equals(tween.id) && optionalObj.Equals(tween.target)) : (tween.target != null && tween.intId == num3 && optionalObj != null && optionalObj.Equals(tween.target))) : (tween.target != null && tween.stringId == text && optionalObj != null && optionalObj.Equals(tween.target)));
					break;
				case FilterType.AllExceptTargetsOrIds:
				{
					flag4 = true;
					for (int i = 0; i < num2; i++)
					{
						object obj = optionalArray[i];
						if (obj is string)
						{
							flag2 = true;
							text = (string)obj;
						}
						else if (obj is int)
						{
							flag3 = true;
							num3 = (int)obj;
						}
						if (flag2 && tween.stringId == text)
						{
							flag4 = false;
							break;
						}
						if (flag3 && tween.intId == num3)
						{
							flag4 = false;
							break;
						}
						if ((tween.id != null && obj.Equals(tween.id)) || (tween.target != null && obj.Equals(tween.target)))
						{
							flag4 = false;
							break;
						}
					}
					break;
				}
				}
				if (flag4)
				{
					switch (operationType)
					{
					case OperationType.Despawn:
						num++;
						tween.active = false;
						if (!isUpdateLoop)
						{
							Despawn(tween, modifyActiveLists: false);
							flag = true;
							_KillList.Add(tween);
						}
						break;
					case OperationType.Complete:
					{
						bool autoKill = tween.autoKill;
						if (!tween.startupDone)
						{
							ForceInit(tween);
						}
						if (!Complete(tween, modifyActiveLists: false, (!(optionalFloat > 0f)) ? UpdateMode.Goto : UpdateMode.Update))
						{
							break;
						}
						num += ((!optionalBool) ? 1 : (autoKill ? 1 : 0));
						if (autoKill)
						{
							if (isUpdateLoop)
							{
								tween.active = false;
								break;
							}
							flag = true;
							_KillList.Add(tween);
						}
						break;
					}
					case OperationType.Flip:
						if (Flip(tween))
						{
							num++;
						}
						break;
					case OperationType.Goto:
						if (!tween.startupDone)
						{
							ForceInit(tween);
						}
						Goto(tween, optionalFloat, optionalBool);
						num++;
						break;
					case OperationType.Pause:
						if (Pause(tween))
						{
							num++;
						}
						break;
					case OperationType.Play:
						if (Play(tween))
						{
							num++;
						}
						break;
					case OperationType.PlayBackwards:
						if (PlayBackwards(tween))
						{
							num++;
						}
						break;
					case OperationType.PlayForward:
						if (PlayForward(tween))
						{
							num++;
						}
						break;
					case OperationType.Restart:
						if (Restart(tween, optionalBool, optionalFloat))
						{
							num++;
						}
						break;
					case OperationType.Rewind:
						if (Rewind(tween, optionalBool))
						{
							num++;
						}
						break;
					case OperationType.SmoothRewind:
						if (SmoothRewind(tween))
						{
							num++;
						}
						break;
					case OperationType.TogglePause:
						if (TogglePause(tween))
						{
							num++;
						}
						break;
					case OperationType.IsTweening:
						if ((!tween.isComplete || !tween.autoKill) && (!optionalBool || tween.isPlaying))
						{
							num++;
						}
						break;
					}
				}
			}
		}
		if (flag)
		{
			for (int num5 = _KillList.Count - 1; num5 > -1; num5--)
			{
				Tween tween2 = _KillList[num5];
				if (tween2.activeId != -1)
				{
					RemoveActiveTween(tween2);
				}
			}
			_KillList.Clear();
		}
		return num;
	}

	internal static bool Complete(Tween t, bool modifyActiveLists = true, UpdateMode updateMode = UpdateMode.Goto)
	{
		if (t.loops == -1)
		{
			return false;
		}
		if (!t.isComplete)
		{
			Tween.DoGoto(t, t.duration, t.loops, updateMode);
			t.isPlaying = false;
			if (t.autoKill && t.active)
			{
				if (isUpdateLoop)
				{
					t.active = false;
				}
				else
				{
					Despawn(t, modifyActiveLists);
				}
			}
			return true;
		}
		return false;
	}

	internal static bool Flip(Tween t)
	{
		t.isBackwards = !t.isBackwards;
		return true;
	}

	internal static void ForceInit(Tween t, bool isSequenced = false)
	{
		if (!t.startupDone && !t.Startup() && !isSequenced)
		{
			if (isUpdateLoop)
			{
				t.active = false;
			}
			else
			{
				RemoveActiveTween(t);
			}
		}
	}

	internal static bool Goto(Tween t, float to, bool andPlay = false, UpdateMode updateMode = UpdateMode.Goto)
	{
		bool isPlaying = t.isPlaying;
		t.isPlaying = andPlay;
		t.delayComplete = true;
		t.elapsedDelay = t.delay;
		int num = ((t.duration <= 0f) ? 1 : Mathf.FloorToInt(to / t.duration));
		float num2 = to % t.duration;
		if (t.loops != -1 && num >= t.loops)
		{
			num = t.loops;
			num2 = t.duration;
		}
		else if (num2 >= t.duration)
		{
			num2 = 0f;
		}
		bool flag = Tween.DoGoto(t, num2, num, updateMode);
		if ((!andPlay & isPlaying) && !flag && t.onPause != null)
		{
			Tween.OnTweenCallback(t.onPause, t);
		}
		return flag;
	}

	internal static bool Pause(Tween t)
	{
		if (t.isPlaying)
		{
			t.isPlaying = false;
			if (t.onPause != null)
			{
				Tween.OnTweenCallback(t.onPause, t);
			}
			return true;
		}
		return false;
	}

	internal static bool Play(Tween t)
	{
		if (!t.isPlaying && ((!t.isBackwards && !t.isComplete) || (t.isBackwards && (t.completedLoops > 0 || t.position > 0f))))
		{
			t.isPlaying = true;
			if (t.playedOnce && t.delayComplete && t.onPlay != null)
			{
				Tween.OnTweenCallback(t.onPlay, t);
			}
			return true;
		}
		return false;
	}

	internal static bool PlayBackwards(Tween t)
	{
		if (t.completedLoops == 0 && t.position <= 0f)
		{
			ManageOnRewindCallbackWhenAlreadyRewinded(t, isPlayBackwardsOrSmoothRewind: true);
			t.isBackwards = true;
			t.isPlaying = false;
			return false;
		}
		if (!t.isBackwards)
		{
			t.isBackwards = true;
			Play(t);
			return true;
		}
		return Play(t);
	}

	internal static bool PlayForward(Tween t)
	{
		if (t.isComplete)
		{
			t.isBackwards = false;
			t.isPlaying = false;
			return false;
		}
		if (t.isBackwards)
		{
			t.isBackwards = false;
			Play(t);
			return true;
		}
		return Play(t);
	}

	internal static bool Restart(Tween t, bool includeDelay = true, float changeDelayTo = -1f)
	{
		bool num = !t.isPlaying;
		t.isBackwards = false;
		if (changeDelayTo >= 0f && t.tweenType == TweenType.Tweener)
		{
			t.delay = changeDelayTo;
		}
		Rewind(t, includeDelay);
		t.isPlaying = true;
		if (num && t.playedOnce && t.delayComplete && t.onPlay != null)
		{
			Tween.OnTweenCallback(t.onPlay, t);
		}
		return true;
	}

	internal static bool Rewind(Tween t, bool includeDelay = true)
	{
		bool isPlaying = t.isPlaying;
		t.isPlaying = false;
		bool result = false;
		if (t.delay > 0f)
		{
			if (includeDelay)
			{
				result = t.delay > 0f && t.elapsedDelay > 0f;
				t.elapsedDelay = 0f;
				t.delayComplete = false;
			}
			else
			{
				result = t.elapsedDelay < t.delay;
				t.elapsedDelay = t.delay;
				t.delayComplete = true;
			}
		}
		if (t.position > 0f || t.completedLoops > 0 || !t.startupDone)
		{
			result = true;
			if ((!Tween.DoGoto(t, 0f, 0, UpdateMode.Goto) & isPlaying) && t.onPause != null)
			{
				Tween.OnTweenCallback(t.onPause, t);
			}
		}
		else
		{
			ManageOnRewindCallbackWhenAlreadyRewinded(t, isPlayBackwardsOrSmoothRewind: false);
		}
		return result;
	}

	internal static bool SmoothRewind(Tween t)
	{
		bool result = false;
		if (t.delay > 0f)
		{
			result = t.elapsedDelay < t.delay;
			t.elapsedDelay = t.delay;
			t.delayComplete = true;
		}
		if (t.position > 0f || t.completedLoops > 0 || !t.startupDone)
		{
			result = true;
			if (t.loopType == LoopType.Incremental)
			{
				t.PlayBackwards();
			}
			else
			{
				t.Goto(t.ElapsedDirectionalPercentage() * t.duration);
				t.PlayBackwards();
			}
		}
		else
		{
			t.isPlaying = false;
			ManageOnRewindCallbackWhenAlreadyRewinded(t, isPlayBackwardsOrSmoothRewind: true);
		}
		return result;
	}

	internal static bool TogglePause(Tween t)
	{
		if (t.isPlaying)
		{
			return Pause(t);
		}
		return Play(t);
	}

	internal static int TotalPooledTweens()
	{
		return totPooledTweeners + totPooledSequences;
	}

	internal static int TotalPlayingTweens()
	{
		if (!hasActiveTweens)
		{
			return 0;
		}
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		int num = 0;
		for (int i = 0; i < _maxActiveLookupId + 1; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween != null && tween.isPlaying)
			{
				num++;
			}
		}
		return num;
	}

	internal static int TotalTweensById(object id, bool playingOnly)
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		if (totActiveTweens <= 0)
		{
			return 0;
		}
		return DoGetTweensById(id, playingOnly, addToList: false, null);
	}

	internal static List<Tween> GetActiveTweens(bool playing, List<Tween> fillableList = null)
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		if (totActiveTweens <= 0)
		{
			return null;
		}
		int num = totActiveTweens;
		if (fillableList == null)
		{
			fillableList = new List<Tween>(num);
		}
		for (int i = 0; i < num; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween.isPlaying == playing)
			{
				fillableList.Add(tween);
			}
		}
		if (fillableList.Count > 0)
		{
			return fillableList;
		}
		return null;
	}

	internal static List<Tween> GetTweensById(object id, bool playingOnly, List<Tween> fillableList = null)
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		if (totActiveTweens <= 0)
		{
			return null;
		}
		if (fillableList == null)
		{
			fillableList = new List<Tween>(totActiveTweens);
		}
		DoGetTweensById(id, playingOnly, addToList: true, fillableList);
		if (fillableList.Count <= 0)
		{
			return null;
		}
		return fillableList;
	}

	private static int DoGetTweensById(object id, bool playingOnly, bool addToList, List<Tween> fillableList)
	{
		int num = 0;
		bool flag = false;
		string text = null;
		bool flag2 = false;
		int num2 = 0;
		if (id is string)
		{
			flag = true;
			text = (string)id;
		}
		else if (id is int)
		{
			flag2 = true;
			num2 = (int)id;
		}
		int num3 = totActiveTweens;
		for (int i = 0; i < num3; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween == null)
			{
				continue;
			}
			if (flag)
			{
				if (tween.stringId == null || tween.stringId != text)
				{
					continue;
				}
			}
			else if (flag2)
			{
				if (tween.intId != num2)
				{
					continue;
				}
			}
			else if (tween.id == null || !object.Equals(id, tween.id))
			{
				continue;
			}
			if (!playingOnly || tween.isPlaying)
			{
				num++;
				if (addToList)
				{
					fillableList.Add(tween);
				}
			}
		}
		return num;
	}

	internal static List<Tween> GetTweensByTarget(object target, bool playingOnly, List<Tween> fillableList = null)
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		if (totActiveTweens <= 0)
		{
			return null;
		}
		int num = totActiveTweens;
		if (fillableList == null)
		{
			fillableList = new List<Tween>(num);
		}
		for (int i = 0; i < num; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween.target == target && (!playingOnly || tween.isPlaying))
			{
				fillableList.Add(tween);
			}
		}
		if (fillableList.Count > 0)
		{
			return fillableList;
		}
		return null;
	}

	private static void MarkForKilling(Tween t, bool isSingleTweenManualUpdate = false)
	{
		if (isSingleTweenManualUpdate && !isUpdateLoop)
		{
			Despawn(t);
			return;
		}
		t.active = false;
		_KillList.Add(t);
	}

	private static void EvaluateTweenLink(Tween t)
	{
		if (!_TweenLinks.TryGetValue(t, out var value))
		{
			return;
		}
		if ((Object)(object)value.target == (Object)null)
		{
			t.active = false;
			return;
		}
		bool activeInHierarchy = value.target.activeInHierarchy;
		bool flag = !value.lastSeenActive & activeInHierarchy;
		bool flag2 = value.lastSeenActive && !activeInHierarchy;
		value.lastSeenActive = activeInHierarchy;
		switch (value.behaviour)
		{
		case LinkBehaviour.KillOnDisable:
			if (!activeInHierarchy)
			{
				t.active = false;
			}
			break;
		case LinkBehaviour.CompleteAndKillOnDisable:
			if (!activeInHierarchy)
			{
				if (!t.isComplete)
				{
					t.Complete();
				}
				t.active = false;
			}
			break;
		case LinkBehaviour.RewindAndKillOnDisable:
			if (!activeInHierarchy)
			{
				t.Rewind(includeDelay: false);
				t.active = false;
			}
			break;
		case LinkBehaviour.CompleteOnDisable:
			if (flag2 && !t.isComplete)
			{
				t.Complete();
			}
			break;
		case LinkBehaviour.RewindOnDisable:
			if (flag2)
			{
				t.Rewind(includeDelay: false);
			}
			break;
		case LinkBehaviour.PauseOnDisable:
			if (flag2 && t.isPlaying)
			{
				Pause(t);
			}
			break;
		case LinkBehaviour.PauseOnDisablePlayOnEnable:
			if (flag2)
			{
				Pause(t);
			}
			else if (flag)
			{
				Play(t);
			}
			break;
		case LinkBehaviour.PauseOnDisableRestartOnEnable:
			if (flag2)
			{
				Pause(t);
			}
			else if (flag)
			{
				Restart(t);
			}
			break;
		case LinkBehaviour.PlayOnEnable:
			if (flag)
			{
				Play(t);
			}
			break;
		case LinkBehaviour.RestartOnEnable:
			if (flag)
			{
				Restart(t);
			}
			break;
		case LinkBehaviour.KillOnDestroy:
			break;
		}
	}

	private static void AddActiveTween(Tween t)
	{
		if (_requiresActiveReorganization)
		{
			ReorganizeActiveTweens();
		}
		if (totActiveTweens < 0)
		{
			Debugger.LogAddActiveTweenError("totActiveTweens < 0", t);
			totActiveTweens = 0;
		}
		t.active = true;
		t.updateType = DOTween.defaultUpdateType;
		t.isIndependentUpdate = DOTween.defaultTimeScaleIndependent;
		t.activeId = (_maxActiveLookupId = totActiveTweens);
		_activeTweens[totActiveTweens] = t;
		if (t.updateType == UpdateType.Normal)
		{
			totActiveDefaultTweens++;
			hasActiveDefaultTweens = true;
		}
		else
		{
			switch (t.updateType)
			{
			case UpdateType.Fixed:
				totActiveFixedTweens++;
				hasActiveFixedTweens = true;
				break;
			case UpdateType.Late:
				totActiveLateTweens++;
				hasActiveLateTweens = true;
				break;
			default:
				totActiveManualTweens++;
				hasActiveManualTweens = true;
				break;
			}
		}
		totActiveTweens++;
		if (t.tweenType == TweenType.Tweener)
		{
			totActiveTweeners++;
		}
		else
		{
			totActiveSequences++;
		}
		hasActiveTweens = true;
	}

	private static void ReorganizeActiveTweens()
	{
		if (totActiveTweens <= 0)
		{
			_maxActiveLookupId = -1;
			_requiresActiveReorganization = false;
			_reorganizeFromId = -1;
			return;
		}
		if (_reorganizeFromId == _maxActiveLookupId)
		{
			_maxActiveLookupId--;
			_requiresActiveReorganization = false;
			_reorganizeFromId = -1;
			return;
		}
		int num = 1;
		int num2 = _maxActiveLookupId + 1;
		_maxActiveLookupId = _reorganizeFromId - 1;
		for (int i = _reorganizeFromId + 1; i < num2; i++)
		{
			Tween tween = _activeTweens[i];
			if (tween == null)
			{
				num++;
				continue;
			}
			tween.activeId = (_maxActiveLookupId = i - num);
			_activeTweens[i - num] = tween;
			_activeTweens[i] = null;
		}
		_requiresActiveReorganization = false;
		_reorganizeFromId = -1;
	}

	private static void DespawnActiveTweens(List<Tween> tweens)
	{
		for (int num = tweens.Count - 1; num > -1; num--)
		{
			Despawn(tweens[num]);
		}
	}

	private static void RemoveActiveTween(Tween t)
	{
		int activeId = t.activeId;
		if (_totTweenLinks > 0)
		{
			RemoveTweenLink(t);
		}
		t.activeId = -1;
		_requiresActiveReorganization = true;
		if (_reorganizeFromId == -1 || _reorganizeFromId > activeId)
		{
			_reorganizeFromId = activeId;
		}
		_activeTweens[activeId] = null;
		if (t.updateType == UpdateType.Normal)
		{
			if (totActiveDefaultTweens > 0)
			{
				totActiveDefaultTweens--;
				hasActiveDefaultTweens = totActiveDefaultTweens > 0;
			}
			else
			{
				Debugger.LogRemoveActiveTweenError("totActiveDefaultTweens < 0", t);
			}
		}
		else
		{
			switch (t.updateType)
			{
			case UpdateType.Fixed:
				if (totActiveFixedTweens > 0)
				{
					totActiveFixedTweens--;
					hasActiveFixedTweens = totActiveFixedTweens > 0;
				}
				else
				{
					Debugger.LogRemoveActiveTweenError("totActiveFixedTweens < 0", t);
				}
				break;
			case UpdateType.Late:
				if (totActiveLateTweens > 0)
				{
					totActiveLateTweens--;
					hasActiveLateTweens = totActiveLateTweens > 0;
				}
				else
				{
					Debugger.LogRemoveActiveTweenError("totActiveLateTweens < 0", t);
				}
				break;
			default:
				if (totActiveManualTweens > 0)
				{
					totActiveManualTweens--;
					hasActiveManualTweens = totActiveManualTweens > 0;
				}
				else
				{
					Debugger.LogRemoveActiveTweenError("totActiveManualTweens < 0", t);
				}
				break;
			}
		}
		totActiveTweens--;
		hasActiveTweens = totActiveTweens > 0;
		if (t.tweenType == TweenType.Tweener)
		{
			totActiveTweeners--;
		}
		else
		{
			totActiveSequences--;
		}
		if (totActiveTweens < 0)
		{
			totActiveTweens = 0;
			Debugger.LogRemoveActiveTweenError("totActiveTweens < 0", t);
		}
		if (totActiveTweeners < 0)
		{
			totActiveTweeners = 0;
			Debugger.LogRemoveActiveTweenError("totActiveTweeners < 0", t);
		}
		if (totActiveSequences < 0)
		{
			totActiveSequences = 0;
			Debugger.LogRemoveActiveTweenError("totActiveSequences < 0", t);
		}
	}

	private static void ClearTweenArray(Tween[] tweens)
	{
		int num = tweens.Length;
		for (int i = 0; i < num; i++)
		{
			tweens[i] = null;
		}
	}

	private static void IncreaseCapacities(CapacityIncreaseMode increaseMode)
	{
		int num = 0;
		int num2 = Mathf.Max((int)((float)maxTweeners * 1.5f), 200);
		int num3 = Mathf.Max((int)((float)maxSequences * 1.5f), 50);
		switch (increaseMode)
		{
		case CapacityIncreaseMode.TweenersOnly:
			num += num2;
			maxTweeners += num2;
			Array.Resize(ref _pooledTweeners, maxTweeners);
			break;
		case CapacityIncreaseMode.SequencesOnly:
			num += num3;
			maxSequences += num3;
			break;
		default:
			num += num2 + num3;
			maxTweeners += num2;
			maxSequences += num3;
			Array.Resize(ref _pooledTweeners, maxTweeners);
			break;
		}
		maxActive = maxTweeners + maxSequences;
		Array.Resize(ref _activeTweens, maxActive);
		if (num > 0)
		{
			_KillList.Capacity += num;
		}
	}

	private static void ManageOnRewindCallbackWhenAlreadyRewinded(Tween t, bool isPlayBackwardsOrSmoothRewind)
	{
		if (t.onRewind == null)
		{
			return;
		}
		if (isPlayBackwardsOrSmoothRewind)
		{
			if (DOTween.rewindCallbackMode == RewindCallbackMode.FireAlways)
			{
				t.onRewind();
			}
		}
		else if (DOTween.rewindCallbackMode != RewindCallbackMode.FireIfPositionChanged)
		{
			t.onRewind();
		}
	}
}
