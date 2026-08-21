using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MapItemDialogueViewModel : ViewModelBase
{
	private DialogueViewModel dialogueViewModel;

	private string nameText;

	private string prologeText;

	private float prologeTextPrintProcess;

	private float prologueTimeLength;

	private float prologueTime;

	private bool optionsShow;

	private SimpleCommand onNextButtonClickCommand;

	private SimpleCommand onQuickButtonClickCommand;

	private InteractionRequest<List<DialogChainComponent.DialogButton>> onOptionButtonsUpdateRequest;

	public string NameText
	{
		get
		{
			return nameText;
		}
		set
		{
			Set(ref nameText, value, "NameText");
		}
	}

	public string PrologeText
	{
		get
		{
			return prologeText;
		}
		set
		{
			Set(ref prologeText, value, "PrologeText");
		}
	}

	public float PrologeTextPrintProcess
	{
		get
		{
			return prologeTextPrintProcess;
		}
		set
		{
			Set(ref prologeTextPrintProcess, value, "PrologeTextPrintProcess");
		}
	}

	public SimpleCommand OnNextButtonClickCommand => onNextButtonClickCommand;

	public SimpleCommand OnQuickButtonClickCommand => onQuickButtonClickCommand;

	public IInteractionRequest OnOptionButtonsUpdateRequest => onOptionButtonsUpdateRequest;

	public IInteractionRequest OnCloseDialogUI => dialogueViewModel.OnCloseDialogUI;

	public MapItemDialogueViewModel()
	{
	}

	public MapItemDialogueViewModel(DialogueViewModel dialogueViewModel)
	{
		this.dialogueViewModel = dialogueViewModel;
		onNextButtonClickCommand = new SimpleCommand(OnNextPrologueClick);
		onQuickButtonClickCommand = new SimpleCommand(OnQuickButtonClick);
		onOptionButtonsUpdateRequest = new InteractionRequest<List<DialogChainComponent.DialogButton>>();
		PrologeTextPrintProcess = 0f;
		optionsShow = false;
	}

	private void OnQuickButtonClick()
	{
		prologueTime = prologueTimeLength;
	}

	private void OnNextPrologueClick()
	{
		if (!optionsShow)
		{
			if (dialogueViewModel.NextPrologueText(out var drDialogPrologue))
			{
				PrologeText = StoryUtility.ReplaceUsersName(drDialogPrologue.Prologue);
				NameText = StoryUtility.ReplaceUsersName(drDialogPrologue.Name);
				prologueTimeLength = (float)PrologeText.Length / 40f;
				prologueTime = 0f;
				PrologeTextPrintProcess = 0f;
			}
			else
			{
				optionsShow = true;
				ShowOptionButtons();
			}
		}
	}

	private void ShowOptionButtons()
	{
		if (dialogueViewModel.DialogButtons.Count == 0)
		{
			dialogueViewModel.CloseDialog();
			optionsShow = false;
		}
		else
		{
			onOptionButtonsUpdateRequest.Raise(dialogueViewModel.DialogButtons);
		}
	}

	public void StartDialogue()
	{
		PrologeText = string.Empty;
		NameText = string.Empty;
		prologueTime = 0f;
		PrologeTextPrintProcess = 0f;
		optionsShow = false;
		OnNextPrologueClick();
	}

	public void NextDialogue()
	{
		PrologeTextPrintProcess = 0f;
		optionsShow = false;
		OnNextPrologueClick();
	}

	public void Update()
	{
		prologueTime += Time.deltaTime;
		if (prologueTime < prologueTimeLength)
		{
			PrologeTextPrintProcess = Mathf.Clamp01(prologueTime / prologueTimeLength);
		}
		else
		{
			PrologeTextPrintProcess = 1f;
		}
	}
}
