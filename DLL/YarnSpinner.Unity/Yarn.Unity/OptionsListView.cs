using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Yarn.Markup;

namespace Yarn.Unity;

public class OptionsListView : DialogueViewBase
{
	[SerializeField]
	private CanvasGroup canvasGroup;

	[SerializeField]
	private OptionView optionViewPrefab;

	[SerializeField]
	private MarkupPalette palette;

	[SerializeField]
	private float fadeTime = 0.1f;

	[SerializeField]
	private bool showUnavailableOptions;

	[SerializeField]
	[Header("Last Line Components")]
	private TextMeshProUGUI lastLineText;

	[SerializeField]
	private GameObject lastLineContainer;

	[SerializeField]
	private TextMeshProUGUI lastLineCharacterNameText;

	[SerializeField]
	private GameObject lastLineCharacterNameContainer;

	private List<OptionView> optionViews = new List<OptionView>();

	private Action<int> OnOptionSelected;

	private LocalizedLine lastSeenLine;

	public void Start()
	{
		canvasGroup.alpha = 0f;
		canvasGroup.interactable = false;
		canvasGroup.blocksRaycasts = false;
	}

	public void Reset()
	{
		canvasGroup = GetComponentInParent<CanvasGroup>();
	}

	public override void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		lastSeenLine = dialogueLine;
		onDialogueLineFinished();
	}

	public override void RunOptions(DialogueOption[] dialogueOptions, Action<int> onOptionSelected)
	{
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0135: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		while (dialogueOptions.Length > optionViews.Count)
		{
			CreateNewOptionView().gameObject.SetActive(value: false);
		}
		int num = 0;
		for (int i = 0; i < dialogueOptions.Length; i++)
		{
			OptionView optionView = optionViews[i];
			DialogueOption dialogueOption = dialogueOptions[i];
			if (dialogueOption.IsAvailable || showUnavailableOptions)
			{
				optionView.gameObject.SetActive(value: true);
				optionView.palette = palette;
				optionView.Option = dialogueOption;
				if (num == 0)
				{
					optionView.Select();
				}
				num++;
			}
		}
		if (lastLineContainer != null)
		{
			if (lastSeenLine != null)
			{
				MarkupParseResult val = lastSeenLine.Text;
				if (lastLineCharacterNameContainer != null)
				{
					if (string.IsNullOrWhiteSpace(lastSeenLine.CharacterName))
					{
						lastLineCharacterNameContainer.SetActive(value: false);
					}
					else
					{
						val = lastSeenLine.TextWithoutCharacterName;
						lastLineCharacterNameContainer.SetActive(value: true);
						((TMP_Text)lastLineCharacterNameText).text = lastSeenLine.CharacterName;
					}
				}
				if (palette != null)
				{
					((TMP_Text)lastLineText).text = LineView.PaletteMarkedUpText(val, palette);
				}
				else
				{
					((TMP_Text)lastLineText).text = val.Text;
				}
				lastLineContainer.SetActive(value: true);
			}
			else
			{
				lastLineContainer.SetActive(value: false);
			}
		}
		OnOptionSelected = onOptionSelected;
		Relayout();
		StartCoroutine(Effects.FadeAlpha(canvasGroup, 0f, 1f, fadeTime));
		OptionView CreateNewOptionView()
		{
			OptionView optionView2 = UnityEngine.Object.Instantiate(optionViewPrefab);
			optionView2.transform.SetParent(base.transform, worldPositionStays: false);
			optionView2.transform.SetAsLastSibling();
			optionView2.OnOptionSelected = OptionViewWasSelected;
			optionViews.Add(optionView2);
			return optionView2;
		}
		void OptionViewWasSelected(DialogueOption option)
		{
			StartCoroutine(OptionViewWasSelectedInternal(option));
		}
		IEnumerator OptionViewWasSelectedInternal(DialogueOption selectedOption)
		{
			yield return StartCoroutine(FadeAndDisableOptionViews(canvasGroup, 1f, 0f, fadeTime));
			OnOptionSelected(selectedOption.DialogueOptionID);
		}
	}

	public override void DialogueComplete()
	{
		if (!(canvasGroup.alpha > 0f))
		{
			return;
		}
		StopAllCoroutines();
		lastSeenLine = null;
		OnOptionSelected = null;
		canvasGroup.interactable = false;
		canvasGroup.blocksRaycasts = false;
		canvasGroup.alpha = 0f;
		foreach (OptionView optionView in optionViews)
		{
			optionView.gameObject.SetActive(value: false);
		}
	}

	private IEnumerator FadeAndDisableOptionViews(CanvasGroup canvasGroup, float from, float to, float fadeTime)
	{
		yield return Effects.FadeAlpha(canvasGroup, from, to, fadeTime);
		foreach (OptionView optionView in optionViews)
		{
			optionView.gameObject.SetActive(value: false);
		}
	}

	public void OnEnable()
	{
		Relayout();
	}

	private void Relayout()
	{
		LayoutGroup[] componentsInChildren = GetComponentsInChildren<LayoutGroup>();
		LayoutGroup[] array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(array[i].GetComponent<RectTransform>());
		}
		array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(array[i].GetComponent<RectTransform>());
		}
	}
}
