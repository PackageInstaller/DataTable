using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class SetEmoteItem : UGuiView, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	[SerializeField]
	private LoadUISprite emoteIcon;

	[SerializeField]
	private GameObject selectedIcon;

	[SerializeField]
	private TextMeshProUGUI sendEmoteTimeTxt;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private Button removeBtn;

	[SerializeField]
	private Button replaceBtn;

	[SerializeField]
	private Button addBtn;

	[SerializeField]
	private GameObject btnBGMask;

	private SetEmoteItemModel viewModel;

	[SerializeField]
	private ToHaveEmotePoint addBtnDragCheck;

	[SerializeField]
	private ToHaveEmotePoint replaceBtnDragCheck;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<SetEmoteItemModel>(userData);
		BindingSet<SetEmoteItem, SetEmoteItemModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(emoteIcon).For((LoadUISprite v) => v.Path).ToExpression((SetEmoteItemModel vm) => vm.EmoteIcon);
		bindingSet.Bind(emoteIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SetEmoteItemModel vm) => vm.IsHaveEmote);
		if (selectedIcon != null)
		{
			bindingSet.Bind(selectedIcon).For((GameObject v) => v.activeSelf).ToExpression((SetEmoteItemModel vm) => !vm.IsSelected);
		}
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((SetEmoteItemModel vm) => vm.OptCommand)
			.CommandParameter("OnClick");
		bindingSet.Bind(removeBtn).For((Button v) => v.onClick).To((SetEmoteItemModel vm) => vm.OptCommand)
			.CommandParameter("Remove");
		bindingSet.Bind(replaceBtn).For((Button v) => v.onClick).To((SetEmoteItemModel vm) => vm.OptCommand)
			.CommandParameter("Replace");
		bindingSet.Bind(addBtn).For((Button v) => v.onClick).To((SetEmoteItemModel vm) => vm.OptCommand)
			.CommandParameter("Add");
		bindingSet.Bind(removeBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SetEmoteItemModel vm) => vm.ShowRemoveBtn);
		bindingSet.Bind(replaceBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SetEmoteItemModel vm) => vm.ShowReplaceBtn);
		bindingSet.Bind(addBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SetEmoteItemModel vm) => vm.ShowAddBtn);
		if (btnBGMask != null)
		{
			bindingSet.Bind(btnBGMask).For((GameObject v) => v.activeSelf).ToExpression((SetEmoteItemModel vm) => vm.ShowRemoveBtn || vm.ShowReplaceBtn || vm.ShowAddBtn);
		}
		if ((UnityEngine.Object)(object)sendEmoteTimeTxt != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(sendEmoteTimeTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SetEmoteItemModel vm) => vm.SendEmoteTimeTxt);
		}
		bindingSet.Build();
		InitAngles();
	}

	private void InitAngles()
	{
		emoteIcon.GetComponent<RectTransform>().eulerAngles = new Vector3(0f, 0f, 0f);
		removeBtn.GetComponent<RectTransform>().eulerAngles = new Vector3(0f, 0f, 0f);
		replaceBtn.GetComponent<RectTransform>().eulerAngles = new Vector3(0f, 0f, 0f);
		addBtn.GetComponent<RectTransform>().eulerAngles = new Vector3(0f, 0f, 0f);
	}

	public void RefreshData(SetEmoteItemModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void Update()
	{
		if (Input.GetMouseButtonUp(0) && viewModel != null && viewModel.Parent is BattleEmoteSetViewModel { CurSelectEmote: not null } battleEmoteSetViewModel && battleEmoteSetViewModel.CurSelectEmote.EmoteDrag == EmoteDragState.Dragging)
		{
			battleEmoteSetViewModel.DragEndRequest.Raise();
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (viewModel != null && viewModel.Parent is BattleEmoteSetViewModel { CurSelectEmote: not null } battleEmoteSetViewModel && battleEmoteSetViewModel.CurSelectEmote.EmoteDrag == EmoteDragState.Dragging)
		{
			viewModel.IsHaveEmote = true;
			viewModel.SetEmote(battleEmoteSetViewModel.CurSelectEmote);
			battleEmoteSetViewModel.HideEmote();
			battleEmoteSetViewModel.HideRemoveEmoteBtn();
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (viewModel != null && viewModel.Parent is BattleEmoteSetViewModel { CurSelectEmote: not null } battleEmoteSetViewModel && battleEmoteSetViewModel.CurSelectEmote.EmoteDrag == EmoteDragState.Dragging)
		{
			viewModel.IsHaveEmote = false;
			viewModel.SetEmote(null);
			battleEmoteSetViewModel.ShowEmoteState();
		}
	}
}
