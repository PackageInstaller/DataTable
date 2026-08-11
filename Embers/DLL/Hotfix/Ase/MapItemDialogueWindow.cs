using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Ase.ECS;
using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapItemDialogueWindow : UGuiWindow
{
	private MapItemDialogueViewModel viewModel;

	public GameObject arrowGo;

	public GameObject prologueGo;

	public TextMeshProUGUI nameText;

	public TextMeshProUGUI contentText;

	public GameObject nextPrologueButton;

	public GameObject quickPrologueButton;

	public Transform buttonOptionsRoot;

	public MapItemDialogueButton dialogueButtonPrefab;

	private List<MapItemDialogueButton> dialogueButtons = new List<MapItemDialogueButton>();

	private float printProcess;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<MapItemDialogueViewModel>();
		Button orAddComponent = quickPrologueButton.GetOrAddComponent<Button>();
		Button orAddComponent2 = nextPrologueButton.GetOrAddComponent<Button>();
		BindingSet<MapItemDialogueWindow, MapItemDialogueViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapItemDialogueViewModel vm) => vm.NameText);
		bindingSet.Bind<TextMeshProUGUI>(contentText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapItemDialogueViewModel vm) => vm.PrologeText);
		bindingSet.Bind().For((MapItemDialogueWindow v) => v.printProcess).ToExpression((MapItemDialogueViewModel vm) => vm.PrologeTextPrintProcess);
		bindingSet.Bind(prologueGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MapItemDialogueViewModel vm) => !string.IsNullOrEmpty(vm.PrologeText));
		bindingSet.Bind(arrowGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MapItemDialogueViewModel vm) => vm.PrologeTextPrintProcess == 1f);
		bindingSet.Bind(quickPrologueButton).For((GameObject v) => v.activeSelf).ToExpression((MapItemDialogueViewModel vm) => vm.PrologeTextPrintProcess != 1f);
		bindingSet.Bind(orAddComponent).For((Button v) => v.onClick).To((MapItemDialogueViewModel vm) => vm.OnQuickButtonClickCommand);
		bindingSet.Bind(nextPrologueButton).For((GameObject v) => v.activeSelf).ToExpression((MapItemDialogueViewModel vm) => vm.PrologeTextPrintProcess == 1f);
		bindingSet.Bind(orAddComponent2).For((Button v) => v.onClick).To((MapItemDialogueViewModel vm) => vm.OnNextButtonClickCommand);
		bindingSet.Bind().For((MapItemDialogueWindow v) => v.OnCloseDialogUI).To((MapItemDialogueViewModel vm) => vm.OnCloseDialogUI);
		bindingSet.Bind().For((MapItemDialogueWindow v) => v.OnOptionButtonsUpdateRequest).To((MapItemDialogueViewModel vm) => vm.OnOptionButtonsUpdateRequest);
		bindingSet.Build();
	}

	private void OnCloseDialogUI(object sender, InteractionEventArgs e)
	{
		DoDismiss();
	}

	private async Task ClearOptionButtons()
	{
		if (dialogueButtons.Count > 0)
		{
			Sequence sequence = DOTween.Sequence();
			for (int num = dialogueButtons.Count - 1; num >= 0; num--)
			{
				dialogueButtons[num].DoHide(sequence);
			}
			await DOTweenModuleUnityVersion.AsyncWaitForCompletion((Tween)sequence);
		}
		dialogueButtons.Clear();
	}

	private void OnOptionButtonsUpdateRequest(object sender, InteractionEventArgs e)
	{
		if (e.Context == null)
		{
			return;
		}
		Sequence sequence = DOTween.Sequence();
		foreach (DialogChainComponent.DialogButton dialogButton in (List<DialogChainComponent.DialogButton>)e.Context)
		{
			if (dialogButton.State == "inactive")
			{
				continue;
			}
			MapItemDialogueButton mapItemDialogueButton = UnityEngine.Object.Instantiate(dialogueButtonPrefab, buttonOptionsRoot);
			mapItemDialogueButton.transform.localPosition = new Vector3(0f, 114.8f - (float)(dialogueButtons.Count * 80), 0f);
			mapItemDialogueButton.RegitsterClickEvent(async delegate
			{
				await dialogButton.ClickButton();
				await ClearOptionButtons();
				if (viewModel != null)
				{
					if (dialogButton.Result == "返回首页")
					{
						viewModel.StartDialogue();
					}
					else if (!(dialogButton.Result == "关闭界面"))
					{
						viewModel.NextDialogue();
					}
				}
			});
			mapItemDialogueButton.DoShow(sequence, dialogueButtons.Count + 1, dialogButton);
			dialogueButtons.Add(mapItemDialogueButton);
		}
	}

	private void Update()
	{
		if (viewModel != null)
		{
			viewModel.Update();
		}
		if ((bool)(UnityEngine.Object)(object)contentText)
		{
			if (printProcess == 1f)
			{
				((TMP_Text)contentText).maxVisibleCharacters = ((TMP_Text)contentText).textInfo.characterCount;
			}
			else
			{
				((TMP_Text)contentText).maxVisibleCharacters = Mathf.FloorToInt((float)((TMP_Text)contentText).textInfo.characterCount * printProcess);
			}
		}
	}
}
