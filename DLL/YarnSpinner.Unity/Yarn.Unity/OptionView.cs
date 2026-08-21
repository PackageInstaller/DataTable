using System;
using System.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;
using Yarn.Markup;

namespace Yarn.Unity;

public class OptionView : Selectable, ISubmitHandler, IEventSystemHandler, IPointerClickHandler, IPointerEnterHandler
{
	public float onClickDelayTime;

	public UnityEvent onRest = new UnityEvent();

	public UnityEvent onClick = new UnityEvent();

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private bool showCharacterName;

	public Action<DialogueOption> OnOptionSelected;

	public MarkupPalette palette;

	private DialogueOption _option;

	private bool hasSubmittedOptionSelection;

	private bool isProcessingClick;

	public DialogueOption Option
	{
		get
		{
			return _option;
		}
		set
		{
			//IL_0031: Unknown result type (might be due to invalid IL or missing references)
			//IL_0036: Unknown result type (might be due to invalid IL or missing references)
			//IL_0023: Unknown result type (might be due to invalid IL or missing references)
			//IL_0028: Unknown result type (might be due to invalid IL or missing references)
			//IL_0065: Unknown result type (might be due to invalid IL or missing references)
			//IL_004b: Unknown result type (might be due to invalid IL or missing references)
			_option = value;
			hasSubmittedOptionSelection = false;
			isProcessingClick = false;
			MarkupParseResult val = ((!showCharacterName) ? value.Line.TextWithoutCharacterName : value.Line.Text);
			if (palette != null)
			{
				((TMP_Text)text).text = LineView.PaletteMarkedUpText(val, palette, applyLineBreaks: false);
			}
			else
			{
				((TMP_Text)text).text = val.Text;
			}
			base.interactable = value.IsAvailable;
			onRest.Invoke();
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		InvokeOptionSelected();
	}

	public async void InvokeOptionSelected()
	{
		if (!IsInteractable() || isProcessingClick || hasSubmittedOptionSelection)
		{
			return;
		}
		try
		{
			isProcessingClick = true;
			onClick.Invoke();
			if (onClickDelayTime > 0f)
			{
				await Task.Delay(TimeSpan.FromSeconds(onClickDelayTime));
				if (!IsInteractable() || hasSubmittedOptionSelection)
				{
					return;
				}
			}
			OnOptionSelected?.Invoke(Option);
			hasSubmittedOptionSelection = true;
		}
		finally
		{
			isProcessingClick = false;
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		InvokeOptionSelected();
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		base.Select();
	}
}
