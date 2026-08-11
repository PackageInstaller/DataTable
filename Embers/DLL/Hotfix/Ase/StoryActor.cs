using System;
using System.Collections;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

[Serializable]
public class StoryActor
{
	public SkeletonGraphic actorSpine;

	public Color settingColor;

	public float actorScaleRatio = 1f;

	public Vector2 anchoredPosition;

	public Color ActorColor
	{
		get
		{
			if ((bool)(UnityEngine.Object)(object)actorSpine)
			{
				return ((Graphic)(object)actorSpine).color;
			}
			return Color.white;
		}
		set
		{
			if ((bool)(UnityEngine.Object)(object)actorSpine)
			{
				((Graphic)(object)actorSpine).color = value;
			}
		}
	}

	public RectTransform rectTransform
	{
		get
		{
			if ((bool)(UnityEngine.Object)(object)actorSpine)
			{
				return ((Graphic)(object)actorSpine).rectTransform;
			}
			return null;
		}
	}

	public GameObject gameObject
	{
		get
		{
			if ((bool)(UnityEngine.Object)(object)actorSpine)
			{
				return ((Component)(object)actorSpine).gameObject;
			}
			return null;
		}
	}

	public StoryActor(SkeletonGraphic actorSpine)
	{
		this.actorSpine = actorSpine;
	}

	public void Active()
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			((Component)(object)actorSpine).gameObject.SetActive(value: true);
		}
	}

	public void Inactive()
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			((Component)(object)actorSpine).gameObject.SetActive(value: false);
		}
	}

	public void Release()
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			UnityEngine.Object.Destroy(((Component)(object)actorSpine).gameObject);
		}
	}

	public void SetActorState(string stateName)
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			actorSpine.AnimationState.SetAnimation(0, stateName, loop: true);
		}
	}

	public void SetSkin(string skinName)
	{
		Skin skin = actorSpine.SkeletonData.FindSkin(skinName);
		if (skin != null)
		{
			actorSpine.Skeleton.SetSkin(skin);
			actorSpine.Skeleton.SetSlotsToSetupPose();
			actorSpine.AnimationState.Apply(actorSpine.Skeleton);
		}
	}

	public void SetSpeed(float speed)
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			actorSpine.timeScale = speed;
		}
	}

	public void SetSpine(SkeletonGraphic spineInstance)
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			UnityEngine.Object.Destroy(((Component)(object)actorSpine).gameObject);
		}
		actorSpine = spineInstance;
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			((Graphic)(object)actorSpine).rectTransform.anchoredPosition = anchoredPosition;
		}
	}

	public void SwitchActorState(int state)
	{
		if (!(UnityEngine.Object)(object)actorSpine)
		{
			return;
		}
		int childCount = ((Component)(object)actorSpine).transform.childCount;
		bool flag = state == 1;
		for (int i = 0; i < childCount; i++)
		{
			GameObject gameObject = ((Component)(object)actorSpine).transform.GetChild(i).gameObject;
			if (gameObject != null && gameObject.activeSelf != flag)
			{
				gameObject.SetActive(flag);
			}
		}
	}

	public void SwitchActorState(string stateName, int state)
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			bool flag = state == 1;
			GameObject gameObject = ((Component)(object)actorSpine).transform.Find(stateName).gameObject;
			if (gameObject != null && gameObject.activeSelf != flag)
			{
				gameObject.SetActive(flag);
			}
		}
	}

	public GameObject GetActorState(string stateName)
	{
		if ((bool)(UnityEngine.Object)(object)actorSpine)
		{
			return ((Component)(object)actorSpine).transform.Find(stateName).gameObject;
		}
		return null;
	}

	public void SetScaleRatio(float actorScaleRatio)
	{
		if ((UnityEngine.Object)(object)actorSpine != null)
		{
			((Component)(object)actorSpine).transform.localScale = ((Component)(object)actorSpine).transform.localScale / this.actorScaleRatio * actorScaleRatio;
		}
		this.actorScaleRatio = actorScaleRatio;
	}

	public IEnumerator SetScaleRatio(float actorScaleRatio, float scaleTime)
	{
		if ((UnityEngine.Object)(object)actorSpine != null)
		{
			Vector3 targetV = ((Component)(object)actorSpine).transform.localScale / this.actorScaleRatio * actorScaleRatio;
			this.actorScaleRatio = actorScaleRatio;
			IEnumerator<Vector3> dic = StoryUtility.Vector3Lerp(((Component)(object)actorSpine).transform.localScale, targetV, scaleTime);
			while (dic.MoveNext())
			{
				Vector3 current = dic.Current;
				((Component)(object)actorSpine).transform.localScale = current;
				yield return null;
			}
			dic.Dispose();
		}
	}
}
