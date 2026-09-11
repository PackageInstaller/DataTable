using System;
using System.Collections.Generic;

public class XStopwatch
{
	public struct Split
	{
		public readonly float Start;

		private float mStop;

		public float Stop
		{
			get
			{
				if (mStop != 0f)
				{
					return mStop;
				}
				return GetTime();
			}
		}

		public float Elapsed => Stop - Start;

		public bool IsRunning
		{
			get
			{
				if (Start != 0f)
				{
					return mStop == 0f;
				}
				return false;
			}
		}

		public Split(float start)
			: this(start, 0f)
		{
		}

		public Split(float start, float stop)
		{
			Start = start;
			mStop = stop;
		}

		internal Split StopNow()
		{
			mStop = GetTime();
			return this;
		}
	}

	private Split mCurrentSplit;

	private float mElapsed;

	public readonly IList<Split> Splits = new List<Split>();

	private static long sStartTicks = DateTime.Now.Ticks;

	public float Elapsed
	{
		get
		{
			if (IsRunning)
			{
				return mElapsed + mCurrentSplit.Elapsed;
			}
			return mElapsed;
		}
	}

	public Split FirstSplit
	{
		get
		{
			if (Splits.Count <= 0)
			{
				return default(Split);
			}
			return Splits[0];
		}
	}

	public bool IsRunning => mCurrentSplit.IsRunning;

	public Split LastSplit
	{
		get
		{
			if (Splits.Count <= 0)
			{
				return default(Split);
			}
			return Splits[Splits.Count - 1];
		}
	}

	public static float GetTime()
	{
		return (float)(DateTime.Now.Ticks - sStartTicks) / 10000000f;
	}

	public void Reset()
	{
		Stop();
		mElapsed = 0f;
		Splits.Clear();
	}

	public void Restart()
	{
		Reset();
		Start();
	}

	public void Start()
	{
		if (!IsRunning)
		{
			mCurrentSplit = new Split(GetTime());
			Splits.Add(mCurrentSplit);
		}
	}

	public static XStopwatch StartNew()
	{
		XStopwatch xStopwatch = new XStopwatch();
		xStopwatch.Start();
		return xStopwatch;
	}

	public void Stop()
	{
		if (IsRunning)
		{
			mCurrentSplit.StopNow();
			mElapsed += mCurrentSplit.Elapsed;
			Splits[Splits.Count - 1] = mCurrentSplit;
			mCurrentSplit = default(Split);
		}
	}
}
