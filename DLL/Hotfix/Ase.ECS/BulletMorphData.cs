using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class BulletMorphData : IReference
{
	protected Vector3 position;

	protected float angle;

	protected List<float> values;

	protected float startTime;

	protected float endTime;

	protected bool isMorphTransform;

	public void Init(List<float> transformList, List<float> targetValues, float startTime, float endTime)
	{
		if (!transformList.IsNullOrEmpty())
		{
			if (transformList.Count >= 3)
			{
				position = new Vector3(transformList[0], transformList[1], transformList[2]);
			}
			if (transformList.Count >= 4)
			{
				angle = transformList[3];
			}
			isMorphTransform = true;
		}
		else
		{
			isMorphTransform = false;
		}
		if (targetValues != null && !(startTime < 0f) && !(endTime < startTime))
		{
			this.startTime = startTime;
			this.endTime = endTime;
			values = targetValues;
			OnInit(targetValues);
		}
	}

	protected virtual void OnInit(List<float> targetValues)
	{
	}

	public bool CheckEnterTime(float duration)
	{
		if (startTime < duration)
		{
			return duration <= endTime;
		}
		return false;
	}

	public bool CheckBeforeTime(float duration)
	{
		return duration <= startTime;
	}

	public List<float> GetMorphedFinallyValues(List<float> curValues)
	{
		return OnGetMorphedValues(curValues, 1f);
	}

	public List<float> GetMorphedValues(List<float> curValues, float duration)
	{
		float timeScale = ((duration - startTime) / (endTime - startTime)).Round2();
		return OnGetMorphedValues(curValues, timeScale);
	}

	protected virtual List<float> OnGetMorphedValues(List<float> curValues, float timeScale)
	{
		if (curValues == null || values == null || curValues.Count != values.Count)
		{
			return null;
		}
		List<float> list = new List<float>();
		for (int i = 0; i < curValues.Count; i++)
		{
			float item = curValues[i] + (values[i] - curValues[i]) * timeScale;
			list.Add(item);
		}
		return list;
	}

	public BulletMorphedData GetMorphedFinallyData(BulletMorphedData morphedData)
	{
		return GetMorphedDataByTimeScale(morphedData, 1f);
	}

	public BulletMorphedData GetMorphedData(BulletMorphedData morphedData, float duration)
	{
		float timeScale = ((duration - startTime) / (endTime - startTime)).Round2();
		return GetMorphedDataByTimeScale(morphedData, timeScale);
	}

	private BulletMorphedData GetMorphedDataByTimeScale(BulletMorphedData morphedData, float timeScale)
	{
		if (morphedData == null || morphedData.values == null)
		{
			return null;
		}
		BulletMorphedData bulletMorphedData = ReferencePool.Acquire<BulletMorphedData>();
		bulletMorphedData.position = OnGetMorphedPosition(morphedData.position, timeScale);
		bulletMorphedData.angle = OnGetMorphedAngle(morphedData.angle, timeScale);
		bulletMorphedData.values = OnGetMorphedValues(morphedData.values, timeScale);
		return bulletMorphedData;
	}

	private Vector3 OnGetMorphedPosition(Vector3 curPosition, float timeScale)
	{
		if (!isMorphTransform)
		{
			return curPosition;
		}
		return Vector3.Lerp(curPosition, position, timeScale);
	}

	private float OnGetMorphedAngle(float curAngle, float timeScale)
	{
		if (!isMorphTransform)
		{
			return curAngle;
		}
		return curAngle + (angle - curAngle) * timeScale;
	}

	public void Clear()
	{
	}
}
