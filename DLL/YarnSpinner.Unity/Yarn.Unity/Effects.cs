using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace Yarn.Unity;

public static class Effects
{
	public class CoroutineInterruptToken
	{
		private enum State
		{
			NotRunning,
			Running,
			Interrupted
		}

		private State state;

		public bool CanInterrupt => state == State.Running;

		public bool WasInterrupted => state == State.Interrupted;

		public void Start()
		{
			state = State.Running;
		}

		public void Interrupt()
		{
			if (!CanInterrupt)
			{
				throw new InvalidOperationException(string.Format("Cannot stop {0}; state is {1} (and not {2}", "CoroutineInterruptToken", state, "Running"));
			}
			state = State.Interrupted;
		}

		public void Complete()
		{
			state = State.NotRunning;
		}
	}

	public static IEnumerator FadeAlpha(CanvasGroup canvasGroup, float from, float to, float fadeTime, CoroutineInterruptToken stopToken = null)
	{
		stopToken?.Start();
		canvasGroup.alpha = from;
		float timeElapsed = 0f;
		while (timeElapsed < fadeTime)
		{
			if (stopToken?.WasInterrupted ?? false)
			{
				yield break;
			}
			float t = timeElapsed / fadeTime;
			timeElapsed += Time.deltaTime * DialogueGlobals.Speed;
			float alpha = Mathf.Lerp(from, to, t);
			canvasGroup.alpha = alpha;
			yield return null;
		}
		canvasGroup.alpha = to;
		if (to == 0f)
		{
			canvasGroup.interactable = false;
			canvasGroup.blocksRaycasts = false;
		}
		else
		{
			canvasGroup.interactable = true;
			canvasGroup.blocksRaycasts = true;
		}
		stopToken?.Complete();
	}

	public static IEnumerator Typewriter(TextMeshProUGUI text, float lettersPerSecond, Action onCharacterTyped, CoroutineInterruptToken stopToken = null)
	{
		yield return PausableTypewriter(text, lettersPerSecond, onCharacterTyped, null, null, null, stopToken);
	}

	private static IEnumerator InterruptableWait(float duration, CoroutineInterruptToken stopToken = null)
	{
		for (float accumulator = 0f; accumulator < duration; accumulator += Time.deltaTime * DialogueGlobals.Speed)
		{
			if (stopToken?.WasInterrupted ?? false)
			{
				break;
			}
			yield return null;
		}
	}

	public static IEnumerator PausableTypewriter(TextMeshProUGUI text, float lettersPerSecond, Action onCharacterTyped, Action onPauseStarted, Action onPauseEnded, Stack<(int position, float duration)> pausePositions, CoroutineInterruptToken stopToken = null)
	{
		stopToken?.Start();
		((TMP_Text)text).maxVisibleCharacters = 0;
		yield return null;
		int characterCount = ((TMP_Text)text).textInfo.characterCount;
		if (lettersPerSecond <= 0f || characterCount == 0)
		{
			((TMP_Text)text).maxVisibleCharacters = characterCount;
			stopToken?.Complete();
			yield break;
		}
		float secondsPerLetter = 1f / lettersPerSecond;
		float accumulator = Time.deltaTime * DialogueGlobals.Speed;
		while (((TMP_Text)text).maxVisibleCharacters < characterCount)
		{
			if (stopToken?.WasInterrupted ?? false)
			{
				yield break;
			}
			while (accumulator >= secondsPerLetter)
			{
				if (pausePositions != null && pausePositions.Count != 0 && ((TMP_Text)text).maxVisibleCharacters == pausePositions.Peek().position)
				{
					(int, float) tuple = pausePositions.Pop();
					onPauseStarted?.Invoke();
					yield return InterruptableWait(tuple.Item2, stopToken);
					onPauseEnded?.Invoke();
					accumulator = Time.deltaTime * DialogueGlobals.Speed;
				}
				((TMP_Text)text).maxVisibleCharacters = ((TMP_Text)text).maxVisibleCharacters + 1;
				onCharacterTyped?.Invoke();
				accumulator -= secondsPerLetter;
			}
			accumulator += Time.deltaTime * DialogueGlobals.Speed;
			yield return null;
		}
		((TMP_Text)text).maxVisibleCharacters = characterCount;
		stopToken?.Complete();
	}
}
