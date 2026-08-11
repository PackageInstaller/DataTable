#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class NpcDialogueWindow : UGuiWindow
{
	public GameObject prologueGo;

	public GameObject arrowGo;

	public TextMeshProUGUI prologueText;

	public TextMeshProUGUI nameText;

	public RectTransform leftCharacter;

	public RectTransform rightCharacter;

	public GameObject quickPrologueButton;

	public GameObject nextButton;

	public Animator optionAnimator;

	public Transform buttonOptionsRoot;

	public NpcDialogueButton dialogueButtonPrefab;

	private StoryActor leftCharacterSkeleton;

	private StoryActor rightCharacterSkeleton;

	private string leftCharacterUrl;

	private string rightCharacterUrl;

	private string oldLeftCharacterUrl;

	private string oldRightCharacterUrl;

	private NpcDialogueViewModel viewModel;

	private Color inactiveColor = new Color(0.45f, 0.45f, 0.45f, 1f);

	private Color activeColor = new Color(1f, 1f, 1f, 1f);

	private float printProcess;

	private List<NpcDialogueButton> dialogueButtons = new List<NpcDialogueButton>();

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(990001);
		Button orAddComponent = quickPrologueButton.GetOrAddComponent<Button>();
		Button orAddComponent2 = nextButton.GetOrAddComponent<Button>();
		oldLeftCharacterUrl = string.Empty;
		oldRightCharacterUrl = string.Empty;
		leftCharacterSkeleton = new StoryActor(null);
		InitAnchoredPosition(leftCharacterSkeleton, Vector2.zero);
		rightCharacterSkeleton = new StoryActor(null);
		InitAnchoredPosition(rightCharacterSkeleton, Vector2.zero);
		viewModel = GetData<NpcDialogueViewModel>();
		BindingSet<NpcDialogueWindow, NpcDialogueViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((NpcDialogueWindow v) => v.printProcess).To((NpcDialogueViewModel vm) => vm.PrologeTextPrintProcess);
		bindingSet.Bind<TextMeshProUGUI>(prologueText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((NpcDialogueViewModel vm) => vm.PrologeText);
		bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((NpcDialogueViewModel vm) => vm.NameText);
		bindingSet.Bind().For((NpcDialogueWindow v) => v.leftCharacterUrl).To((NpcDialogueViewModel vm) => vm.LeftCharacterName);
		bindingSet.Bind().For((NpcDialogueWindow v) => v.rightCharacterUrl).To((NpcDialogueViewModel vm) => vm.RightCharacterName);
		bindingSet.Bind().For((NpcDialogueWindow v) => v.OnCharacterSkeletonUpdateRequest).To((NpcDialogueViewModel vm) => vm.OnCharacterUpdateRequest);
		bindingSet.Bind(leftCharacterSkeleton).For((StoryActor v) => v.ActorColor).ToExpression((NpcDialogueViewModel vm) => vm.ActiveDirect ? activeColor : inactiveColor);
		bindingSet.Bind(rightCharacterSkeleton).For((StoryActor v) => v.ActorColor).ToExpression((NpcDialogueViewModel vm) => (!vm.ActiveDirect) ? activeColor : inactiveColor);
		bindingSet.Bind(arrowGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((NpcDialogueViewModel vm) => vm.PrologeTextPrintProcess == 1f);
		bindingSet.Bind(prologueGo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((NpcDialogueViewModel vm) => !string.IsNullOrEmpty(vm.PrologeText));
		bindingSet.Bind(quickPrologueButton).For((GameObject v) => v.activeSelf).ToExpression((NpcDialogueViewModel vm) => vm.PrologeTextPrintProcess != 1f);
		bindingSet.Bind(orAddComponent).For((Button v) => v.onClick).To((NpcDialogueViewModel vm) => vm.OnQuickButtonClickCommand);
		bindingSet.Bind(nextButton).For((GameObject v) => v.activeSelf).ToExpression((NpcDialogueViewModel vm) => vm.PrologeTextPrintProcess == 1f);
		bindingSet.Bind(orAddComponent2).For((Button v) => v.onClick).To((NpcDialogueViewModel vm) => vm.OnNextButtonClickCommand);
		bindingSet.Bind().For((NpcDialogueWindow v) => v.OnCloseDialogUI).To((NpcDialogueViewModel vm) => vm.OnCloseDialogUI);
		bindingSet.Bind().For((NpcDialogueWindow v) => v.OnOptionButtonsUpdateRequest).To((NpcDialogueViewModel vm) => vm.OnOptionButtonsUpdateRequest);
		bindingSet.Build();
	}

	private void OnCloseDialogUI(object sender, InteractionEventArgs e)
	{
		Singleton<AudioSystem>.Instance.StopGlobalSnapshot(990001, (STOP_MODE)0);
		Close();
	}

	private async Task ClearOptionButtons()
	{
		if (dialogueButtons.Count > 0)
		{
			for (int num = dialogueButtons.Count - 1; num >= 0; num--)
			{
				dialogueButtons[num].DoHide();
			}
			await new WaitForSeconds(0.4f);
		}
		dialogueButtons.Clear();
	}

	private void OnOptionButtonsUpdateRequest(object sender, InteractionEventArgs e)
	{
		if (e.Context == null)
		{
			return;
		}
		foreach (DialogChainComponent.DialogButton dialogButton in (List<DialogChainComponent.DialogButton>)e.Context)
		{
			if (dialogButton.State == "inactive")
			{
				continue;
			}
			NpcDialogueButton npcDialogueButton = UnityEngine.Object.Instantiate(dialogueButtonPrefab, buttonOptionsRoot);
			npcDialogueButton.transform.localPosition = new Vector3(16f, 134f - (float)(dialogueButtons.Count * 100), 0f);
			npcDialogueButton.RegitsterClickEvent(async delegate
			{
				await dialogButton.ClickButton();
				await ClearOptionButtons();
				if (dialogButton.Result == "返回首页")
				{
					viewModel.StartDialogue();
				}
				else if (!(dialogButton.Result == "关闭界面"))
				{
					viewModel.NextDialogue();
				}
			});
			npcDialogueButton.DoShow(dialogButton);
			dialogueButtons.Add(npcDialogueButton);
		}
		optionAnimator.ResetTrigger("Show");
		optionAnimator.SetTrigger("Show");
	}

	private void InitAnchoredPosition(StoryActor actor, Vector2 position)
	{
		actor.anchoredPosition = Vector2.Scale(position, AssetUtility.ScreenSize);
	}

	private async void OnCharacterSkeletonUpdateRequest(object sender, InteractionEventArgs e)
	{
		await OnSpineUpdate(leftCharacterSkeleton, oldLeftCharacterUrl, leftCharacterUrl, leftCharacter, viewModel.ActiveDirect ? activeColor : inactiveColor);
		oldLeftCharacterUrl = leftCharacterUrl;
		await OnSpineUpdate(rightCharacterSkeleton, oldRightCharacterUrl, rightCharacterUrl, rightCharacter, (!viewModel.ActiveDirect) ? activeColor : inactiveColor);
		oldRightCharacterUrl = rightCharacterUrl;
	}

	private async UniTask<SkeletonGraphic> GetSpineInstance(string actorName, RectTransform parent)
	{
		try
		{
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetStorySpine(actorName), parent, "Story");
			if ((bool)gameObject)
			{
				SkeletonGraphic component = gameObject.GetComponent<SkeletonGraphic>();
				((UnityEngine.Object)(object)component).name = actorName;
				((Graphic)(object)component).SetNativeSize();
				return component;
			}
			return null;
		}
		catch (Exception message)
		{
			Log.Error(message);
			return null;
		}
	}

	private async UniTask OnSpineUpdate(StoryActor actor, string oldUrl, string newUrl, RectTransform parent, Color color)
	{
		try
		{
			if (!string.IsNullOrEmpty(newUrl))
			{
				if (oldUrl != newUrl)
				{
					actor.SetSpine(await GetSpineInstance(newUrl, parent));
				}
				actor.ActorColor = color;
			}
			else
			{
				actor.SetSpine(null);
			}
			if (actor == null)
			{
				actor.Inactive();
			}
			else
			{
				actor.Active();
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	private void Update()
	{
		if (viewModel != null)
		{
			viewModel.Update();
		}
		if ((bool)(UnityEngine.Object)(object)prologueText)
		{
			if (printProcess == 1f)
			{
				((TMP_Text)prologueText).maxVisibleCharacters = ((TMP_Text)prologueText).textInfo.characterCount;
			}
			else
			{
				((TMP_Text)prologueText).maxVisibleCharacters = Mathf.FloorToInt((float)((TMP_Text)prologueText).textInfo.characterCount * printProcess);
			}
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (leftCharacterSkeleton != null)
		{
			leftCharacterSkeleton.Release();
			leftCharacterSkeleton = null;
		}
		if (rightCharacterSkeleton != null)
		{
			rightCharacterSkeleton.Release();
			rightCharacterSkeleton = null;
		}
	}
}
