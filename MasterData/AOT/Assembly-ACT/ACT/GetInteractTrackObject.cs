using System;
using ACT.World.Asset;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public class GetInteractTrackObject : GetTrackObjectBase
{
	public override void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = null;
		if (string.IsNullOrEmpty(trackData) || !int.TryParse(trackData, out var result))
		{
			return;
		}
		GameObject gameObject = null;
		if (StateWorldAsset.TryGetWorldAssetBySwid(result, out var stateWorldAsset))
		{
			gameObject = stateWorldAsset.stateObjectBase.gameObject;
		}
		if (gameObject == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("没有找到名字为" + trackData + "的物体");
			}
		}
		else if (type == typeof(Animator))
		{
			SetAnimator(pd, gameObject.GetComponentInChildren<Animator>(), outputIndex, out trackObject);
		}
		else if (type == typeof(Transform))
		{
			trackObject = gameObject.transform;
		}
		else if (type == typeof(GameObject))
		{
			trackObject = gameObject;
		}
		else if (type == typeof(SignalReceiver))
		{
			trackObject = gameObject.GetComponentInChildren<SignalReceiver>();
		}
		else
		{
			trackObject = gameObject;
		}
	}
}
