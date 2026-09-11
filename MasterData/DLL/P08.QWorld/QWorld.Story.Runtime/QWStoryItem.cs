using System;
using LuaInterface;
using UnityEngine;

namespace QWorld.Story.Runtime;

[DisallowMultipleComponent]
public class QWStoryItem : MonoBehaviour
{
	private GameObject root;

	private Animator anim;

	private QWAttachPointSetup attachPoint;

	private bool waitAnimEnd;

	private float animStartTime;

	internal string asset;

	private Action mOnAnimatorEnd;

	public Action OnAnimatorEnd
	{
		get
		{
			return mOnAnimatorEnd;
		}
		set
		{
			if (value == null)
			{
				mOnAnimatorEnd = null;
				return;
			}
			if (mOnAnimatorEnd != null && waitAnimEnd)
			{
				waitAnimEnd = false;
				Action action = mOnAnimatorEnd;
				mOnAnimatorEnd = null;
				action?.Invoke();
			}
			mOnAnimatorEnd = value;
		}
	}

	public void Init()
	{
		root = base.gameObject;
		anim = root.GetComponentInChildren<Animator>();
		attachPoint = U3DUtil.Get<QWAttachPointSetup>(root);
	}

	[NoToLua]
	public void Dispose()
	{
	}

	public void PlayAnimaton(string animName, float crossFadeTime, float time = 0f, Action callback = null)
	{
		if ((bool)anim)
		{
			anim.CrossFade(animName, crossFadeTime, 0, time);
			waitAnimEnd = true;
			animStartTime = Time.time;
			OnAnimatorEnd = callback;
		}
		else
		{
			callback?.Invoke();
		}
	}

	public void OnClear()
	{
		waitAnimEnd = false;
	}

	public void ClearOnNext()
	{
	}

	private void LateUpdate()
	{
		if ((bool)anim && waitAnimEnd)
		{
			float num = ((!anim.IsInTransition(0)) ? anim.GetCurrentAnimatorStateInfo(0).normalizedTime : anim.GetAnimatorTransitionInfo(0).normalizedTime);
			if ((double)num > 0.98)
			{
				InvokeWaitAnimEnd();
			}
		}
	}

	private void InvokeWaitAnimEnd()
	{
		waitAnimEnd = false;
		mOnAnimatorEnd?.Invoke();
		mOnAnimatorEnd = null;
	}

	public Transform GetAttachPoint(int id)
	{
		return attachPoint.GetAttachPoint((QW_BaseAttachPointType)id);
	}

	public Transform GetAttachPoint(string pointName)
	{
		return attachPoint.GetAttachPoint(pointName);
	}

	public void SetTransform(Transform trans)
	{
		base.transform.position = trans.position;
		base.transform.rotation = trans.rotation;
		base.transform.localScale = trans.localScale;
	}
}
