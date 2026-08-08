using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class BlendTwoTimelines : MonoBehaviour
{
	public PlayableDirector directorA;

	public PlayableDirector directorB;

	public GameObject tpose_Object;

	public Animator animator;

	public bool isOpen;

	public bool isOnLaterUpdate;

	private List<SkinnedMeshRenderer> skinMesh = new List<SkinnedMeshRenderer>();

	private Dictionary<string, EmotionWeightData> blendParamsDic = new Dictionary<string, EmotionWeightData>();

	public float lerpDuration = 1f;

	public float lastUpdateTime;

	public Action callBack;

	private void Update()
	{
		GetmationParam();
	}

	private void LateUpdate()
	{
		StartLerpByLateUpdate();
	}

	public void GetmationParam()
	{
		if (tpose_Object == null)
		{
			return;
		}
		blendParamsDic.Clear();
		SkinnedMeshRenderer[] componentsInChildren = tpose_Object.GetComponentsInChildren<SkinnedMeshRenderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			Mesh sharedMesh = componentsInChildren[i].sharedMesh;
			for (int j = 0; j < sharedMesh.blendShapeCount; j++)
			{
				string blendShapeName = sharedMesh.GetBlendShapeName(j);
				float blendShapeWeight = componentsInChildren[i].GetBlendShapeWeight(j);
				if (!blendParamsDic.ContainsKey(blendShapeName))
				{
					EmotionWeightData emotionWeightData = new EmotionWeightData();
					emotionWeightData.weightData = blendShapeWeight;
					emotionWeightData.mesh = componentsInChildren[i];
					blendParamsDic.Add(blendShapeName, emotionWeightData);
				}
			}
		}
	}

	public void startLerp()
	{
		lastUpdateTime = 0f;
		isOnLaterUpdate = true;
		if (isOpen)
		{
			if (directorB != null)
			{
				directorB.gameObject.SetActive(value: false);
			}
			if (directorA != null)
			{
				directorA.gameObject.SetActive(value: false);
			}
		}
	}

	public void StartLerpByLateUpdate()
	{
		if (!(lastUpdateTime < lerpDuration) || !isOnLaterUpdate)
		{
			return;
		}
		foreach (KeyValuePair<string, EmotionWeightData> item in blendParamsDic)
		{
			string key = item.Key;
			EmotionWeightData value = item.Value;
			float weightData = value.weightData;
			SkinnedMeshRenderer mesh = value.mesh;
			int blendShapeIndex = mesh.sharedMesh.GetBlendShapeIndex(key);
			if (blendShapeIndex != -1)
			{
				float b = 0f;
				float value2 = Mathf.Lerp(weightData, b, lastUpdateTime / lerpDuration);
				mesh.SetBlendShapeWeight(blendShapeIndex, value2);
			}
		}
		lastUpdateTime += Time.deltaTime;
		if (lastUpdateTime > lerpDuration)
		{
			isOnLaterUpdate = false;
			if (isOpen && directorB != null)
			{
				directorB.gameObject.SetActive(value: true);
			}
			if (callBack != null)
			{
				callBack();
			}
		}
	}

	public void Dispose()
	{
		skinMesh.Clear();
		blendParamsDic.Clear();
		callBack = null;
	}
}
