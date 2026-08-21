using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ToHaveEmoteItem : UGuiView
{
	[SerializeField]
	private LoadUISprite emoteIcon;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private Button selectedBtn;

	[SerializeField]
	private GameObject selected;

	private ToHaveEmoteItemModel viewModel;

	[SerializeField]
	public ToHaveEmotePoint toHaveEmotePoint;

	[SerializeField]
	public float pointerDownTime = 0.5f;

	private float downTime;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ToHaveEmoteItemModel>(userData);
		BindingSet<ToHaveEmoteItem, ToHaveEmoteItemModel> bindingSet = this.CreateBindingSet(viewModel);
		if (emoteIcon != null)
		{
			bindingSet.Bind(emoteIcon).For((LoadUISprite v) => v.Path).ToExpression((ToHaveEmoteItemModel vm) => vm.EmoteIconPath);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).ToExpression((ToHaveEmoteItemModel vm) => vm.IsSelected);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((ToHaveEmoteItemModel vm) => vm.OnClike);
		}
		if (selectedBtn != null)
		{
			bindingSet.Bind(selectedBtn).For((Button v) => v.onClick).To((ToHaveEmoteItemModel vm) => vm.OnClike);
		}
		bindingSet.Build();
	}

	public void Init(ToHaveEmoteItemModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ToHaveEmoteItem, ToHaveEmoteItemModel> bindingSet = this.CreateBindingSet(viewModel);
		if (emoteIcon != null)
		{
			bindingSet.Bind(emoteIcon).For((LoadUISprite v) => v.Path).ToExpression((ToHaveEmoteItemModel vm) => vm.EmoteIconPath);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).ToExpression((ToHaveEmoteItemModel vm) => vm.IsSelected);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((ToHaveEmoteItemModel vm) => vm.OnClike);
		}
		if (selectedBtn != null)
		{
			bindingSet.Bind(selectedBtn).For((Button v) => v.onClick).To((ToHaveEmoteItemModel vm) => vm.OnClike);
		}
		bindingSet.Build();
	}

	public void RefreshData(ToHaveEmoteItemModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void Update()
	{
		if (toHaveEmotePoint == null)
		{
			return;
		}
		if (toHaveEmotePoint.isPointerDown)
		{
			downTime += Time.deltaTime;
			if (downTime >= pointerDownTime)
			{
				toHaveEmotePoint.isPointerDown = false;
				downTime = 0f;
				viewModel.EmoteDrag = EmoteDragState.Dragging;
				if (viewModel.Parent is BattleEmoteSetViewModel battleEmoteSetViewModel)
				{
					battleEmoteSetViewModel.SetSelectedEmote(viewModel);
				}
			}
		}
		if (toHaveEmotePoint.isPointerUp)
		{
			downTime = 0f;
		}
	}
}
