using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;
using Yarn.Markup;

namespace Yarn.Unity;

public class LineView : DialogueViewBase
{
	public CanvasGroup canvasGroup;

	public bool useFadeEffect = true;

	[Min(0f)]
	public float fadeInTime = 0.25f;

	[Min(0f)]
	public float fadeOutTime = 0.05f;

	public TextMeshProUGUI lineText;

	[FormerlySerializedAs("showCharacterName")]
	public bool showCharacterNameInLineView = true;

	public TextMeshProUGUI characterNameText;

	public GameObject characterNameContainer;

	public bool useTypewriterEffect;

	public UnityEvent onCharacterTyped;

	public UnityEvent onPauseStarted;

	public UnityEvent onPauseEnded;

	[Min(0f)]
	public float typewriterEffectSpeed;

	public GameObject continueButton;

	[Min(0f)]
	public float holdTime = 1f;

	[Min(0f)]
	public int voiceTime = 1;

	public bool autoAdvance;

	public MarkupPalette palette;

	private LocalizedLine currentLine;

	private Effects.CoroutineInterruptToken currentStopToken = new Effects.CoroutineInterruptToken();

	private void Awake()
	{
		canvasGroup.alpha = 0f;
		canvasGroup.blocksRaycasts = false;
	}

	private void Reset()
	{
		canvasGroup = GetComponentInParent<CanvasGroup>();
	}

	public override void DismissLine(Action onDismissalComplete)
	{
		currentLine = null;
		StartCoroutine(DismissLineInternal(onDismissalComplete));
	}

	private IEnumerator DismissLineInternal(Action onDismissalComplete)
	{
		bool interactable = canvasGroup.interactable;
		canvasGroup.interactable = false;
		if (useFadeEffect)
		{
			yield return StartCoroutine(Effects.FadeAlpha(canvasGroup, 1f, 0f, fadeOutTime, currentStopToken));
			currentStopToken.Complete();
		}
		canvasGroup.alpha = 0f;
		canvasGroup.blocksRaycasts = false;
		canvasGroup.interactable = interactable;
		onDismissalComplete?.Invoke();
	}

	public override void InterruptLine(LocalizedLine dialogueLine, Action onInterruptLineFinished)
	{
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		currentLine = dialogueLine;
		StopAllCoroutines();
		((Component)(object)lineText).gameObject.SetActive(value: true);
		((Component)(object)canvasGroup).gameObject.SetActive(value: true);
		int length;
		if ((UnityEngine.Object)(object)characterNameText == null)
		{
			if (showCharacterNameInLineView)
			{
				((TMP_Text)lineText).text = dialogueLine.Text.Text;
				length = dialogueLine.Text.Text.Length;
			}
			else
			{
				((TMP_Text)lineText).text = dialogueLine.TextWithoutCharacterName.Text;
				length = dialogueLine.TextWithoutCharacterName.Text.Length;
			}
		}
		else
		{
			((TMP_Text)characterNameText).text = dialogueLine.CharacterName;
			((TMP_Text)lineText).text = dialogueLine.TextWithoutCharacterName.Text;
			length = dialogueLine.TextWithoutCharacterName.Text.Length;
		}
		((TMP_Text)lineText).maxVisibleCharacters = length;
		canvasGroup.alpha = 1f;
		canvasGroup.interactable = true;
		canvasGroup.blocksRaycasts = true;
		onInterruptLineFinished();
	}

	public override void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		StopAllCoroutines();
		StartCoroutine(RunLineInternal(dialogueLine, onDialogueLineFinished));
	}

	private IEnumerator RunLineInternal(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		Task voiceTask = Task.Delay(voiceTime);
		currentLine = dialogueLine;
		yield return StartCoroutine(PresentLine());
		while (!voiceTask.IsCompleted && !currentStopToken.WasInterrupted)
		{
			yield return null;
		}
		currentStopToken.Complete();
		((TMP_Text)lineText).maxVisibleCharacters = int.MaxValue;
		canvasGroup.alpha = 1f;
		canvasGroup.blocksRaycasts = true;
		if (continueButton != null)
		{
			continueButton.SetActive(value: true);
		}
		if (holdTime > 0f)
		{
			yield return new WaitForSeconds(holdTime / DialogueGlobals.Speed);
		}
		if (autoAdvance)
		{
			onDialogueLineFinished();
		}
		IEnumerator PresentLine()
		{
			((Component)(object)lineText).gameObject.SetActive(value: true);
			((Component)(object)canvasGroup).gameObject.SetActive(value: true);
			if (continueButton != null)
			{
				continueButton.SetActive(value: false);
			}
			MarkupParseResult text = dialogueLine.TextWithoutCharacterName;
			if (characterNameContainer != null && (UnityEngine.Object)(object)characterNameText != null)
			{
				if (string.IsNullOrWhiteSpace(dialogueLine.CharacterName))
				{
					characterNameContainer.SetActive(value: false);
				}
				else
				{
					string characterName = dialogueLine.CharacterName;
					characterName = Regex.Replace(characterName, "([A-Za-z\\u4e00-\\u9fa5]+)-([A-Za-z\\u4e00-\\u9fa5]+)", "$1 <color=#b27e69><size=35>$2</size></color>", RegexOptions.IgnoreCase);
					((TMP_Text)characterNameText).text = characterName;
					characterNameContainer.SetActive(value: true);
				}
			}
			else if (showCharacterNameInLineView)
			{
				text = dialogueLine.Text;
			}
			if (palette != null)
			{
				((TMP_Text)lineText).text = PaletteMarkedUpText(text, palette);
			}
			else
			{
				((TMP_Text)lineText).text = AddLineBreaks(text);
			}
			if (useTypewriterEffect)
			{
				((TMP_Text)lineText).maxVisibleCharacters = 0;
			}
			else
			{
				((TMP_Text)lineText).maxVisibleCharacters = int.MaxValue;
			}
			if (useFadeEffect)
			{
				yield return StartCoroutine(Effects.FadeAlpha(canvasGroup, 0f, 1f, fadeInTime, currentStopToken));
				if (currentStopToken.WasInterrupted)
				{
					yield break;
				}
			}
			if (useTypewriterEffect)
			{
				Stack<(int, float)> pauseDurationsInsideLine = GetPauseDurationsInsideLine(text);
				canvasGroup.alpha = 1f;
				canvasGroup.interactable = true;
				canvasGroup.blocksRaycasts = true;
				yield return StartCoroutine(Effects.PausableTypewriter(lineText, typewriterEffectSpeed * (1f + DialogueGlobals.TypeSpeedRatio), delegate
				{
					onCharacterTyped.Invoke();
				}, delegate
				{
					onPauseStarted.Invoke();
				}, delegate
				{
					onPauseEnded.Invoke();
				}, pauseDurationsInsideLine, currentStopToken));
				_ = currentStopToken.WasInterrupted;
			}
		}
	}

	public override void UserRequestedViewAdvancement()
	{
		if (currentLine != null)
		{
			if (currentStopToken.CanInterrupt)
			{
				currentStopToken.Interrupt();
			}
			else
			{
				requestInterrupt?.Invoke();
			}
		}
	}

	public void OnContinueClicked()
	{
		UserRequestedViewAdvancement();
	}

	public override void DialogueComplete()
	{
		if (currentLine != null)
		{
			currentLine = null;
			StopAllCoroutines();
			StartCoroutine(DismissLineInternal(null));
		}
	}

	public static string PaletteMarkedUpText(MarkupParseResult line, MarkupPalette palette, bool applyLineBreaks = true)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		string text = line.Text;
		line.Attributes.Sort((MarkupAttribute a, MarkupAttribute b) => ((MarkupAttribute)(ref b)).Position.CompareTo(((MarkupAttribute)(ref a)).Position));
		foreach (MarkupAttribute attribute in line.Attributes)
		{
			MarkupAttribute current = attribute;
			if (palette.ColorForMarker(((MarkupAttribute)(ref current)).Name, out var colour))
			{
				text = text.Insert(((MarkupAttribute)(ref current)).Position + ((MarkupAttribute)(ref current)).Length, "</color>");
				text = text.Insert(((MarkupAttribute)(ref current)).Position, "<color=#" + ColorUtility.ToHtmlStringRGB(colour) + ">");
			}
			if (applyLineBreaks && ((MarkupAttribute)(ref current)).Name == "br")
			{
				text = text.Insert(((MarkupAttribute)(ref current)).Position, "<br>");
			}
		}
		return text;
	}

	public static string AddLineBreaks(MarkupParseResult line)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		string text = line.Text;
		line.Attributes.Sort((MarkupAttribute a, MarkupAttribute b) => ((MarkupAttribute)(ref b)).Position.CompareTo(((MarkupAttribute)(ref a)).Position));
		foreach (MarkupAttribute item in line.Attributes.Where((MarkupAttribute a) => ((MarkupAttribute)(ref a)).Name == "br"))
		{
			MarkupAttribute current = item;
			text = text.Insert(((MarkupAttribute)(ref current)).Position, "<br>");
		}
		return text;
	}

	public static Stack<(int position, float duration)> GetPauseDurationsInsideLine(MarkupParseResult line)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Invalid comparison between Unknown and I4
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		Stack<(int, float)> stack = new Stack<(int, float)>();
		string text = "pause";
		line.Attributes.Sort((MarkupAttribute a, MarkupAttribute b) => ((MarkupAttribute)(ref b)).Position.CompareTo(((MarkupAttribute)(ref a)).Position));
		foreach (MarkupAttribute attribute in line.Attributes)
		{
			MarkupAttribute current = attribute;
			if (((MarkupAttribute)(ref current)).Name != text)
			{
				continue;
			}
			if (((MarkupAttribute)(ref current)).Properties.TryGetValue(text, out var value))
			{
				MarkupValueType type = ((MarkupValue)(ref value)).Type;
				if ((int)type != 0)
				{
					if ((int)type == 1)
					{
						stack.Push((((MarkupAttribute)(ref current)).Position, ((MarkupValue)(ref value)).FloatValue / 1000f));
						continue;
					}
					Debug.LogWarning($"Pause property is of type {((MarkupValue)(ref value)).Type}, which is not allowed. Defaulting to one second.");
					stack.Push((((MarkupAttribute)(ref current)).Position, 1f));
				}
				else
				{
					float num = ((MarkupValue)(ref value)).IntegerValue;
					stack.Push((((MarkupAttribute)(ref current)).Position, num / 1000f));
				}
			}
			else
			{
				stack.Push((((MarkupAttribute)(ref current)).Position, 1f));
			}
		}
		return stack;
	}

	public void SetAutoState(bool state)
	{
		autoAdvance = state;
		if (autoAdvance && continueButton.activeInHierarchy)
		{
			UserRequestedViewAdvancement();
		}
	}

	public void RestState()
	{
		autoAdvance = false;
	}
}
