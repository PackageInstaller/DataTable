using System;
using UnityEngine;

public class LTSeq
{
	public LTSeq previous;

	public LTSeq current;

	public LTDescr tween;

	public float totalDelay;

	public float timeScale;

	private int debugIter;

	public uint counter;

	public bool toggle;

	private uint _id;

	public int id => (int)(_id | (counter << 16));

	public void reset()
	{
		previous = null;
		tween = null;
		totalDelay = 0f;
	}

	public void init(uint id, uint global_counter)
	{
		reset();
		_id = id;
		counter = global_counter;
		current = this;
	}

	private LTSeq addOn()
	{
		current.toggle = true;
		LTSeq lTSeq = current;
		current = LeanTween.sequence();
		current.previous = lTSeq;
		lTSeq.toggle = false;
		current.totalDelay = lTSeq.totalDelay;
		current.debugIter = lTSeq.debugIter + 1;
		return current;
	}

	private float addPreviousDelays()
	{
		LTSeq lTSeq = current.previous;
		if (lTSeq != null && lTSeq.tween != null)
		{
			return current.totalDelay + lTSeq.tween.time;
		}
		return current.totalDelay;
	}

	public LTSeq append(float delay)
	{
		current.totalDelay += delay;
		return current;
	}

	public LTSeq append(Action callback)
	{
		LTDescr lTDescr = LeanTween.delayedCall(0f, callback);
		return append(lTDescr);
	}

	public LTSeq append(Action<object> callback, object obj)
	{
		append(LeanTween.delayedCall(0f, callback).setOnCompleteParam(obj));
		return addOn();
	}

	public LTSeq append(GameObject gameObject, Action callback)
	{
		append(LeanTween.delayedCall(gameObject, 0f, callback));
		return addOn();
	}

	public LTSeq append(GameObject gameObject, Action<object> callback, object obj)
	{
		append(LeanTween.delayedCall(gameObject, 0f, callback).setOnCompleteParam(obj));
		return addOn();
	}

	public LTSeq append(LTDescr tween)
	{
		current.tween = tween;
		current.totalDelay = addPreviousDelays();
		tween.setDelay(current.totalDelay);
		return addOn();
	}

	public LTSeq insert(LTDescr tween)
	{
		current.tween = tween;
		tween.setDelay(addPreviousDelays());
		return addOn();
	}

	public LTSeq setScale(float timeScale)
	{
		setScaleRecursive(current, timeScale, 500);
		return addOn();
	}

	private void setScaleRecursive(LTSeq seq, float timeScale, int count)
	{
		if (count <= 0)
		{
			return;
		}
		this.timeScale = timeScale;
		seq.totalDelay *= timeScale;
		if (seq.tween != null)
		{
			if (seq.tween.time != 0f)
			{
				seq.tween.setTime(seq.tween.time * timeScale);
			}
			seq.tween.setDelay(seq.tween.delay * timeScale);
		}
		if (seq.previous != null)
		{
			setScaleRecursive(seq.previous, timeScale, count - 1);
		}
	}

	public LTSeq reverse()
	{
		return addOn();
	}
}
