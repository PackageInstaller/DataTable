using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BulletMorphGroup : IReference
{
	private bool isMorphing;

	private List<BulletMorphData> morphDataList;

	private bool isMorphEffect;

	private float duration;

	private List<float> curValues;

	private BulletMorphedData curMorphedData;

	private int morphIndex;

	private bool morphSuccess;

	public bool IsMorphing => isMorphing;

	public bool IsMorphEffect => isMorphEffect;

	public void Init(DRBullet config)
	{
		InitConfigData(config);
		if (isMorphing)
		{
			morphIndex = 0;
			duration = 0f;
			morphSuccess = false;
			isMorphEffect = config.MorphingEffect;
			curValues = config.PrimitiveParam;
			curMorphedData = ReferencePool.Acquire<BulletMorphedData>();
			curMorphedData.Init(Vector3.zero, 0f, config.PrimitiveParam);
		}
	}

	private void InitConfigData(DRBullet config)
	{
		isMorphing = false;
		if (config == null)
		{
			return;
		}
		List<List<float>> morphingSize = config.MorphingSize;
		List<List<float>> morphingTime = config.MorphingTime;
		if (morphingSize.IsNullOrEmpty() || morphingTime.IsNullOrEmpty() || morphingSize.Count != morphingTime.Count || config.PrimitiveEnum == PrimitiveEnum.NONE || config.PrimitiveEnum == PrimitiveEnum.CapsulePrimitive)
		{
			return;
		}
		morphDataList = CollectionPool<List<BulletMorphData>, BulletMorphData>.Get();
		List<List<float>> morphingTransform = config.MorphingTransform;
		for (int i = 0; i < morphingSize.Count; i++)
		{
			if (morphingSize[i].IsNullOrEmpty() || morphingTime[i].IsNullOrEmpty())
			{
				return;
			}
			BulletMorphData bulletMorphData = ReferencePool.Acquire<BulletMorphData>();
			bulletMorphData.Init((morphingTransform.Count > i) ? morphingTransform[i] : null, morphingSize[i], morphingTime[i][0], morphingTime[i][1]);
			morphDataList.Add(bulletMorphData);
		}
		isMorphing = true;
	}

	public void Update(float deltaTime)
	{
		duration += deltaTime;
	}

	public List<float> GetMorphedValues()
	{
		if (morphDataList == null || morphDataList.Count == 0)
		{
			return null;
		}
		if (morphSuccess)
		{
			return curValues;
		}
		while (morphIndex <= morphDataList.Count)
		{
			BulletMorphData bulletMorphData = morphDataList[morphIndex];
			if (bulletMorphData.CheckBeforeTime(duration))
			{
				return curValues;
			}
			if (bulletMorphData.CheckEnterTime(duration))
			{
				return bulletMorphData.GetMorphedValues(curValues, duration);
			}
			curValues = bulletMorphData.GetMorphedFinallyValues(curValues);
			morphIndex++;
			if (morphIndex == morphDataList.Count)
			{
				morphSuccess = true;
				return curValues;
			}
		}
		return curValues;
	}

	public BulletMorphedData GetMorphedData()
	{
		if (morphDataList == null || morphDataList.Count == 0)
		{
			return null;
		}
		if (morphSuccess)
		{
			return curMorphedData;
		}
		while (morphIndex <= morphDataList.Count)
		{
			BulletMorphData bulletMorphData = morphDataList[morphIndex];
			if (bulletMorphData.CheckBeforeTime(duration))
			{
				return curMorphedData;
			}
			if (bulletMorphData.CheckEnterTime(duration))
			{
				return bulletMorphData.GetMorphedData(curMorphedData, duration);
			}
			curMorphedData = bulletMorphData.GetMorphedFinallyData(curMorphedData);
			morphIndex++;
			if (morphIndex == morphDataList.Count)
			{
				morphSuccess = true;
				return curMorphedData;
			}
		}
		return curMorphedData;
	}

	public void Clear()
	{
		if (morphDataList != null)
		{
			for (int num = morphDataList.Count - 1; num >= 0; num--)
			{
				ReferencePool.Release(morphDataList[num]);
			}
			CollectionPool<List<BulletMorphData>, BulletMorphData>.Release(morphDataList);
			morphDataList = null;
		}
		curValues = null;
		if (curMorphedData != null)
		{
			ReferencePool.Release(curMorphedData);
			curMorphedData = null;
		}
	}
}
