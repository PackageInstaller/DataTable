using System;
using System.Collections;
using UnityEngine;

namespace Yarn.Unity;

public class VoiceOverView : DialogueViewBase
{
	public float fadeOutTimeOnLineFinish = 0.05f;

	public float waitTimeBeforeLineStart;

	public float waitTimeAfterLineComplete;

	[SerializeField]
	public AudioSource audioSource;

	private Coroutine playbackCoroutine;

	private Effects.CoroutineInterruptToken interruptToken = new Effects.CoroutineInterruptToken();

	private Action completionHandler;

	private void Awake()
	{
		if ((UnityEngine.Object)(object)audioSource == null)
		{
			audioSource = base.gameObject.AddComponent<AudioSource>();
			audioSource.spatialBlend = 0f;
		}
	}

	public override void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		if (playbackCoroutine != null)
		{
			StopCoroutine(playbackCoroutine);
			audioSource.Stop();
			playbackCoroutine = null;
		}
		completionHandler = onDialogueLineFinished;
		playbackCoroutine = StartCoroutine(DoRunLine(dialogueLine));
	}

	private IEnumerator DoRunLine(LocalizedLine dialogueLine)
	{
		UnityEngine.Object asset = dialogueLine.Asset;
		AudioClip voiceOverClip = (AudioClip)(object)((asset is AudioClip) ? asset : null);
		if ((UnityEngine.Object)(object)voiceOverClip == null)
		{
			Debug.LogError("Playing voice over failed because the localised line " + dialogueLine.TextID + " either didn't have an asset, or its asset was not an AudioClip.", base.gameObject);
			completionHandler?.Invoke();
			yield break;
		}
		if (audioSource.isPlaying)
		{
			audioSource.Stop();
		}
		interruptToken.Start();
		if (waitTimeBeforeLineStart > 0f)
		{
			for (float elaspedTime = 0f; elaspedTime < waitTimeBeforeLineStart; elaspedTime += Time.deltaTime * DialogueGlobals.Speed)
			{
				if (interruptToken.WasInterrupted)
				{
					completionHandler?.Invoke();
					yield break;
				}
				yield return null;
			}
		}
		audioSource.PlayOneShot(voiceOverClip);
		while (audioSource.isPlaying && !interruptToken.WasInterrupted)
		{
			yield return null;
		}
		if (interruptToken.WasInterrupted)
		{
			float elaspedTime = 0f;
			float volumeFadeStart = audioSource.volume;
			while (audioSource.volume != 0f)
			{
				elaspedTime += Time.unscaledDeltaTime / fadeOutTimeOnLineFinish;
				audioSource.volume = Mathf.Lerp(volumeFadeStart, 0f, elaspedTime);
				yield return null;
			}
			audioSource.volume = volumeFadeStart;
		}
		audioSource.Stop();
		if (!interruptToken.WasInterrupted && waitTimeAfterLineComplete > 0f)
		{
			for (float volumeFadeStart = 0f; volumeFadeStart < waitTimeAfterLineComplete; volumeFadeStart += Time.deltaTime * DialogueGlobals.Speed)
			{
				if (interruptToken.WasInterrupted)
				{
					break;
				}
				yield return null;
			}
		}
		completionHandler?.Invoke();
		interruptToken.Complete();
	}

	public override void InterruptLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		if (interruptToken.CanInterrupt)
		{
			completionHandler = onDialogueLineFinished;
			interruptToken.Interrupt();
		}
		else
		{
			onDialogueLineFinished();
		}
	}

	public override void DismissLine(Action onDismissalComplete)
	{
		audioSource.Stop();
		onDismissalComplete();
	}

	public override void UserRequestedViewAdvancement()
	{
		if (audioSource.isPlaying && interruptToken.CanInterrupt)
		{
			requestInterrupt?.Invoke();
		}
	}

	public override void DialogueComplete()
	{
		audioSource.Stop();
	}
}
