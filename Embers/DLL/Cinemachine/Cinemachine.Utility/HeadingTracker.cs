using UnityEngine;

namespace Cinemachine.Utility;

public class HeadingTracker
{
	private struct Item
	{
		public Vector3 velocity;

		public float weight;

		public float time;
	}

	private Item[] mHistory;

	private int mTop;

	private int mBottom;

	private int mCount;

	private Vector3 mHeadingSum;

	private float mWeightSum;

	private float mWeightTime;

	private Vector3 mLastGoodHeading = Vector3.zero;

	private static float mDecayExponent;

	public int FilterSize => mHistory.Length;

	public HeadingTracker(int filterSize)
	{
		mHistory = new Item[filterSize];
		float num = (float)filterSize / 5f;
		mDecayExponent = (0f - Mathf.Log(2f)) / num;
		ClearHistory();
	}

	private void ClearHistory()
	{
		mTop = (mBottom = (mCount = 0));
		mWeightSum = 0f;
		mHeadingSum = Vector3.zero;
	}

	private static float Decay(float time)
	{
		return Mathf.Exp(time * mDecayExponent);
	}

	public void Add(Vector3 velocity)
	{
		if (FilterSize == 0)
		{
			mLastGoodHeading = velocity;
			return;
		}
		float magnitude = velocity.magnitude;
		if (magnitude > 0.0001f)
		{
			Item item = new Item
			{
				velocity = velocity,
				weight = magnitude,
				time = CinemachineCore.CurrentTime
			};
			if (mCount == FilterSize)
			{
				PopBottom();
			}
			mCount++;
			mHistory[mTop] = item;
			if (++mTop == FilterSize)
			{
				mTop = 0;
			}
			mWeightSum *= Decay(item.time - mWeightTime);
			mWeightTime = item.time;
			mWeightSum += magnitude;
			mHeadingSum += item.velocity;
		}
	}

	private void PopBottom()
	{
		if (mCount > 0)
		{
			float currentTime = CinemachineCore.CurrentTime;
			Item item = mHistory[mBottom];
			if (++mBottom == FilterSize)
			{
				mBottom = 0;
			}
			mCount--;
			float num = Decay(currentTime - item.time);
			mWeightSum -= item.weight * num;
			mHeadingSum -= item.velocity * num;
			if (mWeightSum <= 0.0001f || mCount == 0)
			{
				ClearHistory();
			}
		}
	}

	public void DecayHistory()
	{
		float currentTime = CinemachineCore.CurrentTime;
		float num = Decay(currentTime - mWeightTime);
		mWeightSum *= num;
		mWeightTime = currentTime;
		if (mWeightSum < 0.0001f)
		{
			ClearHistory();
		}
		else
		{
			mHeadingSum *= num;
		}
	}

	public Vector3 GetReliableHeading()
	{
		if (mWeightSum > 0.0001f && (mCount == mHistory.Length || mLastGoodHeading.AlmostZero()))
		{
			Vector3 v = mHeadingSum / mWeightSum;
			if (!v.AlmostZero())
			{
				mLastGoodHeading = v.normalized;
			}
		}
		return mLastGoodHeading;
	}
}
