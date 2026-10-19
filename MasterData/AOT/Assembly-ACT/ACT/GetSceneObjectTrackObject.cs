using System;
using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public class GetSceneObjectTrackObject : GetTrackObjectBase
{
	public override void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = null;
		if (string.IsNullOrEmpty(trackData))
		{
			return;
		}
		GameObject gameObject = GameObject.Find(trackData);
		if (gameObject == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("没有找到名字为" + trackData + "的物体");
			}
		}
		else if (type == typeof(Animator))
		{
			Animator animator = gameObject.GetComponent<Animator>();
			if (animator == null)
			{
				animator = gameObject.AddComponent<Animator>();
			}
			SetAnimator(pd, animator, outputIndex, out trackObject);
		}
		else if (type == typeof(Transform))
		{
			trackObject = gameObject.transform;
		}
		else if (type == typeof(SignalReceiver))
		{
			trackObject = gameObject.GetComponentInChildren<SignalReceiver>();
		}
		else if (type == typeof(CinemachineBrain))
		{
			SetCinemachineBrain(pd, pb, gameObject.transform);
		}
		else
		{
			trackObject = gameObject;
		}
	}
}
