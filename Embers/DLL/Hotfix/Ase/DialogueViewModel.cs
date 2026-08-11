using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class DialogueViewModel : ViewModelBase
{
	private float speed = 10f;

	private List<DRDialogPrologue> drDialogPrologueList;

	private List<DialogChainComponent.DialogButton> dialogButtons;

	private int noPrologueOption;

	private Action closeDialogAction;

	private Action returnFirstAction;

	private int prologueIndex;

	private InteractionRequest onCloseDialogUI;

	public List<DRDialogPrologue> DialogPrologueList => drDialogPrologueList;

	public List<DialogChainComponent.DialogButton> DialogButtons => dialogButtons;

	public int NoPrologueOption => noPrologueOption;

	public IInteractionRequest OnCloseDialogUI => onCloseDialogUI;

	public DialogueViewModel(Action closeDialogAction = null, Action returnFirstAction = null)
	{
		this.closeDialogAction = closeDialogAction;
		this.returnFirstAction = returnFirstAction;
		onCloseDialogUI = new InteractionRequest();
	}

	public void UpdateData(List<DialogChainComponent.DialogButton> dialogButtons, List<DRDialogPrologue> drDialogPrologue, int noPrologueOption)
	{
		prologueIndex = -1;
		this.noPrologueOption = noPrologueOption;
		this.dialogButtons = dialogButtons;
		drDialogPrologueList = drDialogPrologue;
	}

	public bool NextPrologueText(out DRDialogPrologue drDialogPrologue)
	{
		prologueIndex++;
		if (prologueIndex >= drDialogPrologueList.Count || prologueIndex < 0)
		{
			drDialogPrologue = null;
			return false;
		}
		drDialogPrologue = drDialogPrologueList[prologueIndex];
		return true;
	}

	public void OnCloseDialogUIRequest()
	{
		onCloseDialogUI.Raise();
	}

	public void CloseDialog()
	{
		if (closeDialogAction != null)
		{
			closeDialogAction();
		}
	}

	public void ReturnFirst()
	{
		if (returnFirstAction != null)
		{
			returnFirstAction();
		}
	}
}
