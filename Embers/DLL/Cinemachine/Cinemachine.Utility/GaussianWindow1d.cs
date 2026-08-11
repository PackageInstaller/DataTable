using System;
using UnityEngine;

namespace Cinemachine.Utility;

internal abstract class GaussianWindow1d<T>
{
	protected T[] mData;

	protected float[] mKernel;

	protected int mCurrentPos = -1;

	public float Sigma { get; private set; }

	public int KernelSize => mKernel.Length;

	public int BufferLength => mData.Length;

	private void GenerateKernel(float sigma, int maxKernelRadius)
	{
		int num = Math.Min(maxKernelRadius, Mathf.FloorToInt(Mathf.Abs(sigma) * 2.5f));
		mKernel = new float[2 * num + 1];
		if (num == 0)
		{
			mKernel[0] = 1f;
		}
		else
		{
			float num2 = 0f;
			for (int i = -num; i <= num; i++)
			{
				mKernel[i + num] = (float)(Math.Exp((float)(-(i * i)) / (2f * sigma * sigma)) / (Math.PI * 2.0 * (double)sigma * (double)sigma));
				num2 += mKernel[i + num];
			}
			for (int j = -num; j <= num; j++)
			{
				mKernel[j + num] /= num2;
			}
		}
		Sigma = sigma;
	}

	protected abstract T Compute(int windowPos);

	public GaussianWindow1d(float sigma, int maxKernelRadius = 10)
	{
		GenerateKernel(sigma, maxKernelRadius);
		mData = new T[KernelSize];
		mCurrentPos = -1;
	}

	public void Reset()
	{
		mCurrentPos = -1;
	}

	public bool IsEmpty()
	{
		return mCurrentPos < 0;
	}

	public void AddValue(T v)
	{
		if (mCurrentPos < 0)
		{
			for (int i = 0; i < KernelSize; i++)
			{
				mData[i] = v;
			}
			mCurrentPos = Mathf.Min(1, KernelSize - 1);
		}
		mData[mCurrentPos] = v;
		if (++mCurrentPos == KernelSize)
		{
			mCurrentPos = 0;
		}
	}

	public T Filter(T v)
	{
		if (KernelSize < 3)
		{
			return v;
		}
		AddValue(v);
		return Value();
	}

	public T Value()
	{
		return Compute(mCurrentPos);
	}

	public void SetBufferValue(int index, T value)
	{
		mData[index] = value;
	}

	public T GetBufferValue(int index)
	{
		return mData[index];
	}
}
