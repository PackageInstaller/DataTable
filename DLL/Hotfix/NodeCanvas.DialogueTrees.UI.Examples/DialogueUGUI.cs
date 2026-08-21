using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace NodeCanvas.DialogueTrees.UI.Examples;

public class DialogueUGUI : MonoBehaviour
{
	[Serializable]
	public class SubtitleDelays
	{
		public float characterDelay = 0.05f;

		public float sentenceDelay = 0.5f;

		public float commaDelay = 0.1f;

		public float finalDelay = 1.2f;
	}

	[Header("Input Options")]
	public bool skipOnInput;

	public bool waitForInput;

	[Header("Subtitles")]
	public RectTransform subtitlesGroup;

	public Text actorSpeech;

	public Text actorName;

	public Image actorPortrait;

	public RectTransform waitInputIndicator;

	public SubtitleDelays subtitleDelays = new SubtitleDelays();

	public List<AudioClip> typingSounds;

	private AudioSource playSource;

	[Header("Multiple Choice")]
	public RectTransform optionsGroup;

	public Button optionButton;

	private Dictionary<Button, int> cachedButtons;

	private Vector2 originalSubsPosition;

	private bool isWaitingChoice;

	private AudioSource _localSource;

	private AudioSource localSource
	{
		get
		{
			if (!((UnityEngine.Object)(object)_localSource != null))
			{
				return _localSource = base.gameObject.AddComponent<AudioSource>();
			}
			return _localSource;
		}
	}

	private bool anyKeyDown => Input.anyKeyDown;

	private void Awake()
	{
		Subscribe();
		Hide();
	}

	private void OnEnable()
	{
		UnSubscribe();
		Subscribe();
	}

	private void OnDisable()
	{
		UnSubscribe();
	}

	private void Subscribe()
	{
		DialogueTree.OnDialogueStarted += OnDialogueStarted;
		DialogueTree.OnDialoguePaused += OnDialoguePaused;
		DialogueTree.OnDialogueFinished += OnDialogueFinished;
		DialogueTree.OnSubtitlesRequest += OnSubtitlesRequest;
		DialogueTree.OnMultipleChoiceRequest += OnMultipleChoiceRequest;
	}

	private void UnSubscribe()
	{
		DialogueTree.OnDialogueStarted -= OnDialogueStarted;
		DialogueTree.OnDialoguePaused -= OnDialoguePaused;
		DialogueTree.OnDialogueFinished -= OnDialogueFinished;
		DialogueTree.OnSubtitlesRequest -= OnSubtitlesRequest;
		DialogueTree.OnMultipleChoiceRequest -= OnMultipleChoiceRequest;
	}

	private void Hide()
	{
		subtitlesGroup.gameObject.SetActive(value: false);
		optionsGroup.gameObject.SetActive(value: false);
		optionButton.gameObject.SetActive(value: false);
		waitInputIndicator.gameObject.SetActive(value: false);
		originalSubsPosition = subtitlesGroup.transform.position;
	}

	private void OnDialogueStarted(DialogueTree dlg)
	{
	}

	private void OnDialoguePaused(DialogueTree dlg)
	{
		subtitlesGroup.gameObject.SetActive(value: false);
		optionsGroup.gameObject.SetActive(value: false);
		StopAllCoroutines();
		if ((UnityEngine.Object)(object)playSource != null)
		{
			playSource.Stop();
		}
	}

	private void OnDialogueFinished(DialogueTree dlg)
	{
		subtitlesGroup.gameObject.SetActive(value: false);
		optionsGroup.gameObject.SetActive(value: false);
		if (cachedButtons != null)
		{
			foreach (Button key in cachedButtons.Keys)
			{
				if (key != null)
				{
					UnityEngine.Object.Destroy(key.gameObject);
				}
			}
			cachedButtons = null;
		}
		StopAllCoroutines();
		if ((UnityEngine.Object)(object)playSource != null)
		{
			playSource.Stop();
		}
	}

	private void OnSubtitlesRequest(SubtitlesRequestInfo info)
	{
		StartCoroutine(Internal_OnSubtitlesRequestInfo(info));
	}

	private IEnumerator Internal_OnSubtitlesRequestInfo(SubtitlesRequestInfo info)
	{
		string text = info.statement.text;
		AudioClip audio = info.statement.audio;
		IDialogueActor actor = info.actor;
		subtitlesGroup.gameObject.SetActive(value: true);
		actorSpeech.text = "";
		actorName.text = actor.name;
		actorSpeech.color = actor.dialogueColor;
		actorPortrait.gameObject.SetActive(actor.portraitSprite != null);
		actorPortrait.sprite = actor.portraitSprite;
		if ((UnityEngine.Object)(object)audio != null)
		{
			AudioSource val = ((actor.transform != null) ? actor.transform.GetComponent<AudioSource>() : null);
			playSource = (((UnityEngine.Object)(object)val != null) ? val : localSource);
			playSource.clip = audio;
			playSource.Play();
			actorSpeech.text = text;
			float timer = 0f;
			while (timer < audio.length)
			{
				if (skipOnInput && anyKeyDown)
				{
					playSource.Stop();
					break;
				}
				timer += Time.deltaTime;
				yield return null;
			}
		}
		if ((UnityEngine.Object)(object)audio == null)
		{
			string tempText = "";
			bool inputDown = false;
			if (skipOnInput)
			{
				StartCoroutine(CheckInput(delegate
				{
					inputDown = true;
				}));
			}
			for (int i = 0; i < text.Length; i++)
			{
				if (skipOnInput & inputDown)
				{
					actorSpeech.text = text;
					yield return null;
					break;
				}
				if (!subtitlesGroup.gameObject.activeSelf)
				{
					yield break;
				}
				char c = text[i];
				tempText += c;
				yield return StartCoroutine(DelayPrint(subtitleDelays.characterDelay));
				PlayTypeSound();
				if (c == '.' || c == '!' || c == '?')
				{
					yield return StartCoroutine(DelayPrint(subtitleDelays.sentenceDelay));
					PlayTypeSound();
				}
				if (c == ',')
				{
					yield return StartCoroutine(DelayPrint(subtitleDelays.commaDelay));
					PlayTypeSound();
				}
				actorSpeech.text = tempText;
			}
			if (!waitForInput)
			{
				yield return StartCoroutine(DelayPrint(subtitleDelays.finalDelay));
			}
		}
		if (waitForInput)
		{
			waitInputIndicator.gameObject.SetActive(value: true);
			while (!anyKeyDown)
			{
				yield return null;
			}
			waitInputIndicator.gameObject.SetActive(value: false);
		}
		yield return null;
		subtitlesGroup.gameObject.SetActive(value: false);
		info.Continue();
	}

	private void PlayTypeSound()
	{
		if (typingSounds.Count > 0)
		{
			AudioClip val = typingSounds[UnityEngine.Random.Range(0, typingSounds.Count)];
			if ((UnityEngine.Object)(object)val != null)
			{
				localSource.PlayOneShot(val, UnityEngine.Random.Range(0.6f, 1f));
			}
		}
	}

	private IEnumerator CheckInput(Action Do)
	{
		while (!anyKeyDown)
		{
			yield return null;
		}
		Do();
	}

	private IEnumerator DelayPrint(float time)
	{
		float timer = 0f;
		while (timer < time)
		{
			timer += Time.deltaTime;
			yield return null;
		}
	}

	private void OnMultipleChoiceRequest(MultipleChoiceRequestInfo info)
	{
		optionsGroup.gameObject.SetActive(value: true);
		float height = optionButton.GetComponent<RectTransform>().rect.height;
		optionsGroup.sizeDelta = new Vector2(optionsGroup.sizeDelta.x, (float)info.options.Values.Count * height + 20f);
		cachedButtons = new Dictionary<Button, int>();
		int num = 0;
		foreach (KeyValuePair<IStatement, int> option in info.options)
		{
			Button btn = UnityEngine.Object.Instantiate(optionButton);
			btn.gameObject.SetActive(value: true);
			btn.transform.SetParent(optionsGroup.transform, worldPositionStays: false);
			btn.transform.localPosition = optionButton.transform.localPosition - new Vector3(0f, height * (float)num, 0f);
			btn.GetComponentInChildren<Text>().text = option.Key.text;
			cachedButtons.Add(btn, option.Value);
			btn.onClick.AddListener(delegate
			{
				Finalize(info, cachedButtons[btn]);
			});
			num++;
		}
		if (info.showLastStatement)
		{
			subtitlesGroup.gameObject.SetActive(value: true);
			float y = optionsGroup.position.y + optionsGroup.sizeDelta.y + 1f;
			subtitlesGroup.position = new Vector3(subtitlesGroup.position.x, y, subtitlesGroup.position.z);
		}
		if (info.availableTime > 0f)
		{
			StartCoroutine(CountDown(info));
		}
	}

	private IEnumerator CountDown(MultipleChoiceRequestInfo info)
	{
		isWaitingChoice = true;
		float timer = 0f;
		while (timer < info.availableTime)
		{
			if (!isWaitingChoice)
			{
				yield break;
			}
			timer += Time.deltaTime;
			SetMassAlpha(optionsGroup, Mathf.Lerp(1f, 0f, timer / info.availableTime));
			yield return null;
		}
		if (isWaitingChoice)
		{
			Finalize(info, info.options.Values.Last());
		}
	}

	private void Finalize(MultipleChoiceRequestInfo info, int index)
	{
		isWaitingChoice = false;
		SetMassAlpha(optionsGroup, 1f);
		optionsGroup.gameObject.SetActive(value: false);
		if (info.showLastStatement)
		{
			subtitlesGroup.gameObject.SetActive(value: false);
			subtitlesGroup.transform.position = originalSubsPosition;
		}
		foreach (Button key in cachedButtons.Keys)
		{
			UnityEngine.Object.Destroy(key.gameObject);
		}
		info.SelectOption(index);
	}

	private void SetMassAlpha(RectTransform root, float alpha)
	{
		CanvasRenderer[] componentsInChildren = root.GetComponentsInChildren<CanvasRenderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].SetAlpha(alpha);
		}
	}
}
