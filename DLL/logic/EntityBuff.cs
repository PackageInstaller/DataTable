using System.Collections.Generic;
using Entitas;

[IgnoreClone]
public class EntityBuff : IComponent, IComponentReset
{
	public List<int> mBuffID;

	public List<int> mBuffClassIDArray;

	public List<int> mBuffRuntime;

	public List<int> mBuffCasterArray;

	public List<int> mDuringArray;

	public List<int> mTickArray;

	public List<BuffParams> mBuffParamsArray;

	private List<int> mBuffPendingDeathArray;

	public List<int> mBuffConfigID;

	public List<int> mBuffFloor;

	public List<int> mBuffKeepTimeArray;

	public int Add(int casterID, int buffClassID, int delay, int during, int tick, BuffParams buffLife, int buffConfigID, int buffFloor, int buffkeepTime)
	{
		if (mBuffRuntime == null)
		{
			mBuffRuntime = FrameListPool<int>.Claim(10);
		}
		if (mBuffClassIDArray == null)
		{
			mBuffClassIDArray = FrameListPool<int>.Claim(10);
		}
		if (mBuffCasterArray == null)
		{
			mBuffCasterArray = FrameListPool<int>.Claim(10);
		}
		if (mDuringArray == null)
		{
			mDuringArray = FrameListPool<int>.Claim(10);
		}
		if (mTickArray == null)
		{
			mTickArray = FrameListPool<int>.Claim(10);
		}
		if (mBuffID == null)
		{
			mBuffID = FrameListPool<int>.Claim(10);
		}
		if (mBuffParamsArray == null)
		{
			mBuffParamsArray = FrameListPool<BuffParams>.Claim(10);
		}
		if (mBuffConfigID == null)
		{
			mBuffConfigID = FrameListPool<int>.Claim(10);
		}
		if (mBuffFloor == null)
		{
			mBuffFloor = FrameListPool<int>.Claim(10);
		}
		if (mBuffKeepTimeArray == null)
		{
			mBuffKeepTimeArray = FrameListPool<int>.Claim(10);
		}
		mBuffRuntime.Add(delay);
		mBuffClassIDArray.Add(buffClassID);
		mBuffCasterArray.Add(casterID);
		mDuringArray.Add(during);
		mTickArray.Add(tick);
		mBuffID.Add(BuffProcessor.IncreaseBuffID());
		mBuffParamsArray.Add(buffLife);
		mBuffFloor.Add(buffFloor);
		mBuffConfigID.Add(buffConfigID);
		mBuffKeepTimeArray.Add(buffkeepTime);
		return mBuffClassIDArray.Count - 1;
	}

	public void AddPendingRemoveArray(int buffID)
	{
		if (mBuffPendingDeathArray == null)
		{
			mBuffPendingDeathArray = FrameListPool<int>.Claim(10);
		}
		if (!mBuffPendingDeathArray.Contains(buffID))
		{
			mBuffPendingDeathArray.Add(buffID);
		}
	}

	public bool IsInPendingRemoveArray(int buffID)
	{
		if (mBuffPendingDeathArray == null)
		{
			return false;
		}
		return mBuffPendingDeathArray.Contains(buffID);
	}

	public void ReleasePendingRemoveArray()
	{
		if (mBuffPendingDeathArray != null)
		{
			for (int i = 0; i < mBuffPendingDeathArray.Count; i++)
			{
				int num = Remove(mBuffPendingDeathArray[i]);
			}
			mBuffPendingDeathArray.Clear();
		}
	}

	public void RemoveAt(int index)
	{
		if (mBuffRuntime != null)
		{
			mBuffRuntime.RemoveAt(index);
		}
		if (mBuffClassIDArray != null)
		{
			mBuffClassIDArray.RemoveAt(index);
		}
		if (mBuffCasterArray != null)
		{
			mBuffCasterArray.RemoveAt(index);
		}
		if (mDuringArray != null)
		{
			mDuringArray.RemoveAt(index);
		}
		if (mTickArray != null)
		{
			mTickArray.RemoveAt(index);
		}
		if (mBuffID != null)
		{
			mBuffID.RemoveAt(index);
		}
		if (mBuffParamsArray != null)
		{
			mBuffParamsArray.RemoveAt(index);
		}
		if (mBuffFloor != null)
		{
			mBuffFloor.RemoveAt(index);
		}
		if (mBuffConfigID != null)
		{
			mBuffConfigID.RemoveAt(index);
		}
		if (mBuffKeepTimeArray != null)
		{
			mBuffKeepTimeArray.RemoveAt(index);
		}
	}

	public void RemoveClass(int buffClassID)
	{
		int num = -1;
		for (int i = 0; i < mBuffClassIDArray.Count; i++)
		{
			if (mBuffClassIDArray[i] == buffClassID)
			{
				num = i;
				break;
			}
		}
		if (num >= 0)
		{
			RemoveAt(num);
		}
	}

	public int Remove(int buffID)
	{
		int num = -1;
		for (int i = 0; i < mBuffID.Count; i++)
		{
			if (mBuffID[i] == buffID)
			{
				num = i;
				break;
			}
		}
		if (num >= 0)
		{
			RemoveAt(num);
		}
		return num;
	}

	public int GetBuffIDIndex(int buffID)
	{
		int result = -1;
		for (int i = 0; i < mBuffID.Count; i++)
		{
			if (mBuffID[i] == buffID)
			{
				result = i;
				break;
			}
		}
		return result;
	}

	public int GetBuffConfigIDIndex(int buffConfigID)
	{
		int result = -1;
		for (int i = 0; i < mBuffConfigID.Count; i++)
		{
			if (mBuffConfigID[i] == buffConfigID && !IsInPendingRemoveArray(mBuffID[i]))
			{
				result = i;
				break;
			}
		}
		return result;
	}

	public bool ModifyConfigIDBuffTime(int configID, int time)
	{
		for (int i = 0; i < mBuffConfigID.Count; i++)
		{
			if (mBuffConfigID[i] == configID && !IsInPendingRemoveArray(mBuffID[i]))
			{
				mBuffKeepTimeArray[i] = time;
				return true;
			}
		}
		return false;
	}

	public int GetBuffClassIDIndex(int buffClassID)
	{
		int result = -1;
		for (int i = 0; i < mBuffClassIDArray.Count; i++)
		{
			if (mBuffClassIDArray[i] == buffClassID && !IsInPendingRemoveArray(mBuffID[i]))
			{
				result = i;
				break;
			}
		}
		return result;
	}

	public bool Contain(int buffClassID)
	{
		int num = -1;
		for (int i = 0; i < mBuffClassIDArray.Count; i++)
		{
			if (mBuffClassIDArray[i] == buffClassID)
			{
				num = i;
				break;
			}
		}
		return num >= 0;
	}

	public void Reset(Entity entity)
	{
		if (mBuffRuntime != null)
		{
			FrameListPool<int>.Release(mBuffRuntime);
		}
		if (mBuffClassIDArray != null)
		{
			FrameListPool<int>.Release(mBuffClassIDArray);
		}
		if (mBuffCasterArray != null)
		{
			FrameListPool<int>.Release(mBuffCasterArray);
		}
		if (mDuringArray != null)
		{
			FrameListPool<int>.Release(mDuringArray);
		}
		if (mTickArray != null)
		{
			FrameListPool<int>.Release(mTickArray);
		}
		if (mBuffID != null)
		{
			FrameListPool<int>.Release(mBuffID);
		}
		if (mBuffParamsArray != null)
		{
			FrameListPool<BuffParams>.Release(mBuffParamsArray);
		}
		if (mBuffFloor != null)
		{
			FrameListPool<int>.Release(mBuffFloor);
		}
		if (mBuffConfigID != null)
		{
			FrameListPool<int>.Release(mBuffConfigID);
		}
		if (mBuffKeepTimeArray != null)
		{
			FrameListPool<int>.Release(mBuffKeepTimeArray);
		}
		mBuffRuntime = null;
		mBuffClassIDArray = null;
		mBuffCasterArray = null;
		mDuringArray = null;
		mTickArray = null;
		mBuffID = null;
		mBuffParamsArray = null;
		mBuffFloor = null;
		mBuffConfigID = null;
		mBuffKeepTimeArray = null;
	}

	internal bool ReleaseBuffOnPossible()
	{
		for (int num = mDuringArray.Count - 1; num >= 0; num--)
		{
			if (mDuringArray[num] <= 0)
			{
				RemoveAt(num);
			}
		}
		return mBuffClassIDArray.Count == 0;
	}

	public void CopyBuffTo(List<int> buffClassID, List<int> buffRuntime, List<int> buffCaster, List<int> during, List<int> tick, List<BuffParams> buffParams, List<int> buffFloor, List<int> buffConfigID, List<int> buffKeepTimeArr)
	{
		for (int i = 0; i < mBuffID.Count; i++)
		{
			buffClassID.Add(mBuffClassIDArray[i]);
			buffRuntime.Add(mBuffRuntime[i]);
			buffCaster.Add(mBuffCasterArray[i]);
			during.Add(mDuringArray[i]);
			tick.Add(mTickArray[i]);
			buffParams.Add(mBuffParamsArray[i]);
			buffFloor.Add(mBuffFloor[i]);
			buffConfigID.Add(mBuffConfigID[i]);
			buffKeepTimeArr.Add(mBuffKeepTimeArray[i]);
		}
	}

	public void CopyBuffTo(EntityBuff buff)
	{
		if (buff.mBuffID == null)
		{
			buff.mBuffID = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffID.Clear();
		}
		buff.mBuffID.AddRange(mBuffID);
		if (buff.mBuffClassIDArray == null)
		{
			buff.mBuffClassIDArray = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffClassIDArray.Clear();
		}
		buff.mBuffClassIDArray.AddRange(mBuffClassIDArray);
		if (buff.mBuffRuntime == null)
		{
			buff.mBuffRuntime = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffRuntime.Clear();
		}
		buff.mBuffRuntime.AddRange(mBuffRuntime);
		if (buff.mBuffCasterArray == null)
		{
			buff.mBuffCasterArray = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffCasterArray.Clear();
		}
		buff.mBuffCasterArray.AddRange(mBuffCasterArray);
		if (buff.mDuringArray == null)
		{
			buff.mDuringArray = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mDuringArray.Clear();
		}
		buff.mDuringArray.AddRange(mDuringArray);
		if (buff.mTickArray == null)
		{
			buff.mTickArray = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mTickArray.Clear();
		}
		buff.mTickArray.AddRange(mTickArray);
		if (buff.mBuffParamsArray == null)
		{
			buff.mBuffParamsArray = FrameListPool<BuffParams>.Claim(10);
		}
		else
		{
			buff.mBuffParamsArray.Clear();
		}
		buff.mBuffParamsArray.AddRange(mBuffParamsArray);
		if (buff.mBuffConfigID == null)
		{
			buff.mBuffConfigID = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffConfigID.Clear();
		}
		buff.mBuffConfigID.AddRange(mBuffConfigID);
		if (buff.mBuffFloor == null)
		{
			buff.mBuffFloor = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffFloor.Clear();
		}
		buff.mBuffFloor.AddRange(mBuffFloor);
		if (buff.mBuffKeepTimeArray == null)
		{
			buff.mBuffKeepTimeArray = FrameListPool<int>.Claim(10);
		}
		else
		{
			buff.mBuffKeepTimeArray.Clear();
		}
		buff.mBuffKeepTimeArray.AddRange(mBuffKeepTimeArray);
	}
}
