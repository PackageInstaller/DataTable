using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class DelayShow : MonoBehaviour
{
	private enum State
	{
		Idle,
		Prepared,
		Playing,
		Shown
	}

	private State state;

	private int version;

	private int index;

	private float baseDelay;

	private float interval;

	private int maxCount;

	public int Index => index;

	public bool HasPlayed => state == State.Shown;

	public void Prepare(int itemIndex)
	{
		version++;
		index = itemIndex;
		state = State.Prepared;
		HideSelf();
	}

	public void BeginOnce(float baseDelaySeconds, float intervalSeconds, int maxDelayShowCount)
	{
		if (state == State.Shown)
		{
			ShowSelf();
		}
		else if (state != State.Playing)
		{
			baseDelay = baseDelaySeconds;
			interval = intervalSeconds;
			maxCount = maxDelayShowCount;
			state = State.Playing;
			if (index <= 0 || index >= maxCount)
			{
				MarkShownAndShow();
			}
			else
			{
				StartCountdown();
			}
		}
	}

	public void SkipAndShow(int itemIndex)
	{
		version++;
		index = itemIndex;
		MarkShownAndShow();
	}

	private void StartCountdown()
	{
		version++;
		int v = version;
		float num = baseDelay + (float)index * interval;
		if (num < 0f)
		{
			num = 0f;
		}
		HideSelf();
		ShowAfterDelayAsync(num, v, this.GetCancellationTokenOnDestroy()).Forget();
	}

	private void MarkShownAndShow()
	{
		state = State.Shown;
		ShowSelf();
	}

	private void HideSelf()
	{
		if (base.gameObject.activeSelf)
		{
			base.gameObject.SetActive(value: false);
		}
	}

	private void ShowSelf()
	{
		if (!base.gameObject.activeSelf)
		{
			base.gameObject.SetActive(value: true);
		}
	}

	private async UniTaskVoid ShowAfterDelayAsync(float delaySeconds, int v, CancellationToken cancellationToken)
	{
		_ = 1;
		try
		{
			if (!(delaySeconds > 0f))
			{
				await UniTask.Yield(PlayerLoopTiming.Update, cancellationToken);
			}
			else
			{
				await UniTask.Delay(TimeSpan.FromSeconds(delaySeconds), ignoreTimeScale: false, PlayerLoopTiming.Update, cancellationToken);
			}
		}
		catch (OperationCanceledException)
		{
			return;
		}
		if (v == version && state == State.Playing)
		{
			MarkShownAndShow();
		}
	}
}
