using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class IKLookAtBehaviour : PlayableBehaviour
{
	public LookAtComponent.EBoneType boneType;

	public ETargetType targetType;

	public ExposedReference<Transform> target;

	public AnimationCurve curve;

	public bool disableOnFinished;

	private Transform _targetTrans;

	private List<LookAtComponent> _comps;

	private void GetLookAtComponent(object playerData)
	{
		if (_comps != null)
		{
			return;
		}
		if (!(playerData is Animator animator))
		{
			Debug.LogError("IKLookAtNode.animator == null");
		}
		else
		{
			if (_comps != null)
			{
				return;
			}
			Transform transform = animator.transform.Find("Components");
			if (transform == null)
			{
				Debug.LogError("IKLookAtNode Components Transform == null");
				return;
			}
			LookAtComponent[] componentsInChildren = transform.GetComponentsInChildren<LookAtComponent>();
			if (componentsInChildren == null || componentsInChildren.Length == 0)
			{
				Debug.LogError("IKLookAtNode.LookAtComponent == null");
				return;
			}
			_comps = new List<LookAtComponent>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				if (componentsInChildren[i].eBoneType == boneType)
				{
					_comps.Add(componentsInChildren[i]);
				}
			}
		}
	}

	public override void OnGraphStart(Playable playable)
	{
		if (targetType == ETargetType.MainCamera)
		{
			_targetTrans = Camera.main.gameObject.transform;
		}
		else
		{
			_targetTrans = target.Resolve(playable.GetGraph().GetResolver());
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		base.OnPlayableDestroy(playable);
		_comps = null;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		GetLookAtComponent(playerData);
		if (_comps != null)
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			float time2 = (float)(time / duration);
			float headWeight = curve.Evaluate(time2);
			for (int i = 0; i < _comps.Count; i++)
			{
				_comps[i].headWeight = headWeight;
				_comps[i].target = _targetTrans;
				_comps[i].enabled = true;
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (_comps == null || !disableOnFinished)
		{
			return;
		}
		for (int i = 0; i < _comps.Count; i++)
		{
			if (null != _comps[i])
			{
				_comps[i].enabled = false;
			}
		}
	}
}
