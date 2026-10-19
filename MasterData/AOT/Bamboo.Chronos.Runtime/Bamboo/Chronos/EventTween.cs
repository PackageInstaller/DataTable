using System;
using Bamboo.Collections;
using Bamboo.Pool;

namespace Bamboo.Chronos;

public class EventTween
{
	internal enum OperateType
	{
		Add,
		Remove,
		Pause,
		Resume
	}

	internal struct OperateItem
	{
		public OperateType OperateType;

		public int Index;

		public int Version;

		public Info Info;
	}

	internal sealed class Info : IRecycle
	{
		public int Duration;

		public int Elapsed;

		public bool IsPause;

		public BaseUpdateActionInfo UpdateActionInfo;

		public BaseCompleteActionInfo CompleteActionInfo;

		public bool IsRecycled { get; set; }

		public void Recycle()
		{
			Duration = 0;
			Elapsed = 0;
			IsPause = false;
			UpdateActionInfo = null;
			CompleteActionInfo = null;
		}
	}

	private const int MIN_LENGTH = 8;

	private readonly BArray<bool> _exists;

	private readonly BArray<int> _versions;

	private readonly BArray<Info> _infos;

	private readonly RecyclePool<Info> _infoPool;

	private readonly ActionInfoPools _actionInfoPools;

	private BArray<OperateItem> _operateItems;

	private bool _isPause;

	private int _count;

	private int _lastIndex;

	public EventTween()
	{
		_exists = BArrayPool<bool>.Default.Get(8);
		_versions = BArrayPool<int>.Default.Get(8);
		_infos = BArrayPool<Info>.Default.Get(8);
		_infoPool = new RecyclePool<Info>();
		_actionInfoPools = new ActionInfoPools();
		_isPause = false;
		_count = 0;
		_lastIndex = -1;
	}

	public Tweener Add(int duration, Action<int> onUpdate, Action<bool> onComplete)
	{
		Info info = _infoPool.Get();
		info.Duration = duration;
		info.IsPause = _isPause;
		UpdateActionInfo updateActionInfo = _actionInfoPools.Get<UpdateActionInfo>();
		updateActionInfo.Action = onUpdate;
		info.UpdateActionInfo = updateActionInfo;
		CompleteActionInfo completeActionInfo = _actionInfoPools.Get<CompleteActionInfo>();
		completeActionInfo.Action = onComplete;
		info.CompleteActionInfo = completeActionInfo;
		return InnerAdd(info);
	}

	public Tweener Add<T>(int duration, Action<T, int> onUpdate, Action<T, bool> onComplete, T arg)
	{
		Info info = _infoPool.Get();
		info.Duration = duration;
		info.IsPause = _isPause;
		UpdateActionInfo<T> updateActionInfo = _actionInfoPools.Get<UpdateActionInfo<T>>();
		updateActionInfo.Action = onUpdate;
		updateActionInfo.Arg = arg;
		info.UpdateActionInfo = updateActionInfo;
		CompleteActionInfo<T> completeActionInfo = _actionInfoPools.Get<CompleteActionInfo<T>>();
		completeActionInfo.Action = onComplete;
		completeActionInfo.Arg = arg;
		info.CompleteActionInfo = completeActionInfo;
		return InnerAdd(info);
	}

	public Tweener Add<T1, T2>(int duration, Action<T1, T2, int> onUpdate, Action<T1, T2, bool> onComplete, T1 arg1, T2 arg2)
	{
		Info info = _infoPool.Get();
		info.Duration = duration;
		info.IsPause = _isPause;
		UpdateActionInfo<T1, T2> updateActionInfo = _actionInfoPools.Get<UpdateActionInfo<T1, T2>>();
		updateActionInfo.Action = onUpdate;
		updateActionInfo.Arg1 = arg1;
		updateActionInfo.Arg2 = arg2;
		info.UpdateActionInfo = updateActionInfo;
		CompleteActionInfo<T1, T2> completeActionInfo = _actionInfoPools.Get<CompleteActionInfo<T1, T2>>();
		completeActionInfo.Action = onComplete;
		completeActionInfo.Arg1 = arg1;
		completeActionInfo.Arg2 = arg2;
		info.CompleteActionInfo = completeActionInfo;
		return InnerAdd(info);
	}

	public Tweener Add<T1, T2, T3>(int duration, Action<T1, T2, T3, int> onUpdate, Action<T1, T2, T3, bool> onComplete, T1 arg1, T2 arg2, T3 arg3)
	{
		Info info = _infoPool.Get();
		info.Duration = duration;
		info.IsPause = _isPause;
		UpdateActionInfo<T1, T2, T3> updateActionInfo = _actionInfoPools.Get<UpdateActionInfo<T1, T2, T3>>();
		updateActionInfo.Action = onUpdate;
		updateActionInfo.Arg1 = arg1;
		updateActionInfo.Arg2 = arg2;
		updateActionInfo.Arg3 = arg3;
		info.UpdateActionInfo = updateActionInfo;
		CompleteActionInfo<T1, T2, T3> completeActionInfo = _actionInfoPools.Get<CompleteActionInfo<T1, T2, T3>>();
		completeActionInfo.Action = onComplete;
		completeActionInfo.Arg1 = arg1;
		completeActionInfo.Arg2 = arg2;
		completeActionInfo.Arg3 = arg3;
		info.CompleteActionInfo = completeActionInfo;
		return InnerAdd(info);
	}

	public bool IsValid(int index, int version)
	{
		if (_exists[index])
		{
			return _versions[index] == version;
		}
		return false;
	}

	public void Cancel(int index, int version)
	{
		InnerRemoveToQueue(index, version);
	}

	public void Pause(int index, int version)
	{
		InnerPauseToQueue(index, version);
	}

	public void Resume(int index, int version)
	{
		InnerResumeToQueue(index, version);
	}

	public void CancelAll()
	{
		_count = 0;
		int length = _infos.Length;
		for (int i = 0; i < length; i++)
		{
			Info info = _infos[i];
			if (info != null)
			{
				_actionInfoPools.Recycle(info.UpdateActionInfo);
				_actionInfoPools.Recycle(info.CompleteActionInfo);
				_infoPool.Recycle(info);
				_infos[i] = null;
			}
		}
		length = _exists.Length;
		for (int j = 0; j < length; j++)
		{
			_exists[j] = false;
		}
		BArrayPool<OperateItem>.Default.Recycle(_operateItems);
		_operateItems = null;
	}

	public void PauseAll()
	{
		_isPause = true;
	}

	public void ResumeAll()
	{
		_isPause = false;
	}

	public void Update(int delta)
	{
		ExecuteOperateQueue();
		if (_isPause)
		{
			return;
		}
		int length = _infos.Length;
		for (int i = 0; i < length; i++)
		{
			Info info = _infos[i];
			if (info != null && !info.IsPause)
			{
				if (info.Elapsed >= info.Duration)
				{
					info.UpdateActionInfo.Execute(1000);
					info.CompleteActionInfo.Execute(isBreak: false);
					_actionInfoPools.Recycle(info.UpdateActionInfo);
					_actionInfoPools.Recycle(info.CompleteActionInfo);
					_infoPool.Recycle(info);
					_infos[i] = null;
					_exists[i] = false;
					BArray<int> versions = _versions;
					int index = i;
					int value = versions[index] + 1;
					versions[index] = value;
					_count--;
				}
				else
				{
					info.UpdateActionInfo.Execute(1000 * info.Elapsed / info.Duration);
					info.Elapsed += delta;
				}
			}
		}
	}

	private Tweener InnerAdd(Info info)
	{
		_count++;
		int num = _exists.Length;
		if (_count + (_count >> 1) > num)
		{
			num *= 2;
			_exists.ResetLength(num);
			_versions.ResetLength(num);
		}
		int num2 = _lastIndex + 1;
		for (int i = num2; i < num; i++)
		{
			if (!_exists[i])
			{
				_exists[i] = true;
				BArray<int> versions = _versions;
				int index = i;
				int value = versions[index] + 1;
				versions[index] = value;
				_lastIndex = i;
				InnerAddToQueue(i, _versions[i], info);
				return new Tweener(i, _versions[i], this);
			}
		}
		for (int j = 0; j < num2; j++)
		{
			if (!_exists[j])
			{
				_exists[j] = true;
				BArray<int> versions2 = _versions;
				int value = j;
				int index = versions2[value] + 1;
				versions2[value] = index;
				_lastIndex = j;
				InnerAddToQueue(j, _versions[j], info);
				return new Tweener(j, _versions[j], this);
			}
		}
		throw new Exception("Impossible Exception." + $" _count : {_count}" + $" _exists.Length : {_exists.Length}" + $" _exists.Capacity : {_exists.Capacity}" + $" _lastIndex : {_lastIndex}");
	}

	private void InnerAddToQueue(int index, int version, Info info)
	{
		if (_operateItems == null)
		{
			_operateItems = BArrayPool<OperateItem>.Default.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Add,
				Index = index,
				Version = version,
				Info = info
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Add,
				Index = index,
				Version = version,
				Info = info
			};
		}
	}

	private void InnerRemoveToQueue(int index, int version)
	{
		if (_operateItems == null)
		{
			_operateItems = BArrayPool<OperateItem>.Default.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Remove,
				Index = index,
				Version = version
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Remove,
				Index = index,
				Version = version
			};
		}
	}

	private void InnerPauseToQueue(int index, int version)
	{
		if (_operateItems == null)
		{
			_operateItems = BArrayPool<OperateItem>.Default.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Pause,
				Index = index,
				Version = version
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Pause,
				Index = index,
				Version = version
			};
		}
	}

	private void InnerResumeToQueue(int index, int version)
	{
		if (_operateItems == null)
		{
			_operateItems = BArrayPool<OperateItem>.Default.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Resume,
				Index = index,
				Version = version
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Resume,
				Index = index,
				Version = version
			};
		}
	}

	private void ExecuteOperateQueue()
	{
		if (_operateItems == null)
		{
			return;
		}
		int length = _operateItems.Length;
		for (int i = 0; i < length; i++)
		{
			OperateItem operateItem = _operateItems[i];
			int index = operateItem.Index;
			switch (operateItem.OperateType)
			{
			case OperateType.Add:
				if (_infos.Length < _exists.Length)
				{
					_infos.ResetLength(_exists.Length);
				}
				_infos[index] = operateItem.Info;
				break;
			case OperateType.Remove:
				if (_exists[index] && _versions[index] == operateItem.Version)
				{
					_infos[index].CompleteActionInfo.Execute(isBreak: true);
					_exists[index] = false;
					BArray<int> versions = _versions;
					int index2 = index;
					int value = versions[index2] + 1;
					versions[index2] = value;
					_actionInfoPools.Recycle(_infos[index].UpdateActionInfo);
					_actionInfoPools.Recycle(_infos[index].CompleteActionInfo);
					_infoPool.Recycle(_infos[index]);
					_infos[index] = null;
					_count--;
				}
				break;
			case OperateType.Pause:
				if (_exists[index] && _versions[index] == operateItem.Version)
				{
					_infos[index].IsPause = true;
				}
				break;
			case OperateType.Resume:
				if (_exists[index] && _versions[index] == operateItem.Version)
				{
					_infos[index].IsPause = false;
				}
				break;
			}
		}
		BArrayPool<OperateItem>.Default.Recycle(_operateItems);
		_operateItems = null;
	}
}
