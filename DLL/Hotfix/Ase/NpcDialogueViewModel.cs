using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class NpcDialogueViewModel : ViewModelBase
{
	private DialogueViewModel dialogueViewModel;

	private string nameText;

	private string prologeText;

	private float prologeTextPrintProcess;

	private bool activeDirect;

	private string leftCharacterName;

	private string rightCharacterName;

	private float prologueTimeLength;

	private float prologueTime;

	private bool optionsShow;

	private bool initFinish;

	private SimpleCommand onNextButtonClickCommand;

	private SimpleCommand onQuickButtonClickCommand;

	private InteractionRequest onCharacterUpdateRequest;

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

	public string LeftCharacterName
	{
		get
		{
			return leftCharacterName;
		}
		set
		{
			Set(ref leftCharacterName, value, "LeftCharacterName");
		}
	}

	public string RightCharacterName
	{
		get
		{
			return rightCharacterName;
		}
		set
		{
			Set(ref rightCharacterName, value, "RightCharacterName");
		}
	}

	public bool ActiveDirect
	{
		get
		{
			return activeDirect;
		}
		set
		{
			Set<bool>(ref activeDirect, value, "ActiveDirect");
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

	public IInteractionRequest OnCharacterUpdateRequest => onCharacterUpdateRequest;

	public IInteractionRequest OnOptionButtonsUpdateRequest => onOptionButtonsUpdateRequest;

	public IInteractionRequest OnCloseDialogUI => dialogueViewModel.OnCloseDialogUI;

	public NpcDialogueViewModel()
	{
	}

	public NpcDialogueViewModel(DialogueViewModel dialogueViewModel)
	{
		this.dialogueViewModel = dialogueViewModel;
		onQuickButtonClickCommand = new SimpleCommand(OnQuickButtonClick);
		onNextButtonClickCommand = new SimpleCommand(ClickNextPrologueClick);
		onCharacterUpdateRequest = new InteractionRequest();
		onOptionButtonsUpdateRequest = new InteractionRequest<List<DialogChainComponent.DialogButton>>();
		PrologeTextPrintProcess = 0f;
		optionsShow = false;
	}

	private void OnQuickButtonClick()
	{
		prologueTime = prologueTimeLength;
	}

	private void ClickNextPrologueClick()
	{
		if (initFinish)
		{
			OnNextPrologueClick();
		}
	}

	private void ClickQuickButtonClick()
	{
		if (initFinish)
		{
			OnQuickButtonClick();
		}
	}

	private void OnNextPrologueClick()
	{
		if (optionsShow)
		{
			return;
		}
		if (dialogueViewModel.NextPrologueText(out var drDialogPrologue))
		{
			PrologeText = StoryUtility.ReplaceUsersName(drDialogPrologue.Prologue);
			NameText = StoryUtility.ReplaceUsersName(drDialogPrologue.Name);
			if (!string.IsNullOrEmpty(drDialogPrologue.LeftCharacterAssetName))
			{
				LeftCharacterName = StoryUtility.GetCharacterPortrait(drDialogPrologue.LeftCharacterAssetName);
			}
			else
			{
				RightCharacterName = "";
			}
			if (!string.IsNullOrEmpty(drDialogPrologue.RightCharacterAssetName))
			{
				RightCharacterName = StoryUtility.GetCharacterPortrait(drDialogPrologue.RightCharacterAssetName);
			}
			else
			{
				RightCharacterName = "";
			}
			ActiveDirect = drDialogPrologue.Direct == "LEFT";
			onCharacterUpdateRequest.Raise();
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

	private void ShowOptionButtons()
	{
		if (dialogueViewModel.DialogButtons.Count == 0 && dialogueViewModel.NoPrologueOption == 2)
		{
			dialogueViewModel.CloseDialog();
			optionsShow = false;
		}
		else if (dialogueViewModel.DialogButtons.Count == 0 && dialogueViewModel.NoPrologueOption == 1)
		{
			dialogueViewModel.ReturnFirst();
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

	public void DialogueInit()
	{
		StartDialogue();
		initFinish = true;
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
