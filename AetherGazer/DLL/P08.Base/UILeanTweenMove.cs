using System;
using UnityEngine;

public class UILeanTweenMove : MonoBehaviour
{
	public RectTransform RectTransform;

	public Vector2 StartPos;

	public Vector2 EndPos;

	public float DelayTime;

	public float MoveTime;

	public bool PlayOnAwake = true;

	public bool DefaultStartToEnd = true;

	private void Start()
	{
		if (PlayOnAwake)
		{
			Play();
		}
	}

	public void Play(bool setToStart = true, Action onStartCallFunc = null, Action onComponentCallFunc = null)
	{
		if (!(RectTransform == null))
		{
			if (DefaultStartToEnd)
			{
				ToEnd(setToStart, onStartCallFunc, onComponentCallFunc);
			}
			else
			{
				ToStart(setToStart, onStartCallFunc, onComponentCallFunc);
			}
		}
	}

	public void ReversePlay(bool setToStart = true, Action onStartCallFunc = null, Action onComponentCallFunc = null)
	{
		if (!(RectTransform == null))
		{
			if (DefaultStartToEnd)
			{
				ToStart(setToStart, onStartCallFunc, onComponentCallFunc);
			}
			else
			{
				ToEnd(setToStart, onStartCallFunc, onComponentCallFunc);
			}
		}
	}

	public void SetToStartPos()
	{
		RectTransform.anchoredPosition = StartPos;
	}

	public void SetToEndPos()
	{
		RectTransform.anchoredPosition = EndPos;
	}

	public void ToEnd(bool setToStart = true, Action onStartCallFunc = null, Action onComponentCallFunc = null)
	{
		if (setToStart)
		{
			SetToStartPos();
		}
		LTDescr lTDescr = LeanTween.move(RectTransform, EndPos, MoveTime);
		if (DelayTime > 0f)
		{
			lTDescr.setDelay(DelayTime);
		}
		if (onStartCallFunc != null)
		{
			lTDescr.setOnStart(onStartCallFunc);
		}
		if (onComponentCallFunc != null)
		{
			lTDescr.setOnComplete(onComponentCallFunc);
		}
	}

	public void ToStart(bool setToEnd = true, Action onStartCallFunc = null, Action callfunc = null)
	{
		if (setToEnd)
		{
			SetToEndPos();
		}
		LTDescr lTDescr = LeanTween.move(RectTransform, StartPos, MoveTime);
		if (DelayTime > 0f)
		{
			lTDescr.setDelay(DelayTime);
		}
		if (onStartCallFunc != null)
		{
			lTDescr.setOnStart(onStartCallFunc);
		}
		if (callfunc != null)
		{
			lTDescr.setOnComplete(callfunc);
		}
	}

	public void Stop()
	{
		LeanTween.pause(RectTransform.gameObject);
	}
}
