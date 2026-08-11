using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleEmoteSetView : UGuiView
{
	private List<SetEmoteItem> emoteList = new List<SetEmoteItem>();

	[SerializeField]
	private LoopListView2 tabList;

	[SerializeField]
	private LoopGridView battleEmoteList;

	[SerializeField]
	private LoopGridView battleStartList;

	[SerializeField]
	private GameObject emotePrefab;

	[SerializeField]
	private GameObject emoteRoot;

	[SerializeField]
	private GameObject timeLimitObj;

	[SerializeField]
	private TextMeshProUGUI timeLimitTxt;

	[SerializeField]
	private Button changeStateBtn;

	[SerializeField]
	private Button btnJump;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	private float radius = 268.5f;

	private float halfDeg = 26.3f;

	private float deg;

	private BattleEmoteSetViewModel viewModel;

	[SerializeField]
	private ToHaveEmoteItem dragObj;

	[SerializeField]
	private ScrollRect scrollRect;

	private RectTransform _dragRect;

	private RectTransform _dragParentRect;

	private Canvas _dragCanvas;

	private Camera _uiCamera;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleEmoteSetViewModel>(userData);
		BindingSet<BattleEmoteSetView, BattleEmoteSetViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleEmoteSetView v) => v.UpdateToHaveEmoteList).To((BattleEmoteSetViewModel vm) => vm.UpdateToHaveListRequest);
		bindingSet.Bind(timeLimitObj).For((GameObject v) => v.activeSelf).ToExpression((BattleEmoteSetViewModel vm) => vm.IsShowTimeLimitTxt);
		bindingSet.Bind<TextMeshProUGUI>(timeLimitTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleEmoteSetViewModel vm) => vm.TimeLimitText);
		bindingSet.Bind(changeStateBtn).For((Button v) => v.onClick).To((BattleEmoteSetViewModel vm) => vm.HideEmoteState);
		bindingSet.Bind(this).For((BattleEmoteSetView v) => v.DragEndSetScrollRectVertical).To((BattleEmoteSetViewModel vm) => vm.DragEndRequest);
		bindingSet.Build();
		if (btnJump != null)
		{
			JumpWindowParams param = new JumpWindowParams(jumpWindow, jumpParams);
			btnJump.onClick.AddListener(delegate
			{
				viewModel.ItemOnClick(param);
			});
		}
		InitEmoteItem();
		tabList.InitListView(viewModel.TabList.Count, OnGetTabItemByIndex);
		battleEmoteList.InitGridView(viewModel.ShowToHaveEmoteList.Count, OnGetToHaveEmoteItemByIndex);
		battleStartList.InitGridView(viewModel.BattleStartList.Count, OnGetBattleStartEmoteItemByIndex);
		InitDragVM();
	}

	public void ViewOnEnable()
	{
		OnEnable();
		if (viewModel != null)
		{
			viewModel.OnOpen();
		}
	}

	private void UpdateToHaveEmoteList(object sender, InteractionEventArgs e)
	{
		battleEmoteList.SetListItemCount(viewModel.ShowToHaveEmoteList.Count);
		battleEmoteList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetTabItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TabList.Count)
		{
			return null;
		}
		BattleEmoteTabViewModel data = viewModel.TabList[index];
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EmoteTabItem");
		if (loopListViewItem != null)
		{
			BattleEmoteTabView component = loopListViewItem.GetComponent<BattleEmoteTabView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(data);
			}
			else
			{
				component.RefreshData(data);
			}
			loopListViewItem.GetComponent<UIRedPoint>()?.Dispose();
			loopListViewItem.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.BattleEmoji).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.BattleEmote) ?? new List<RoleDecorateData>()).Find((RoleDecorateData p) => p.id == data.Id)?.isNew ?? false)
				.Invoke();
		}
		return loopListViewItem;
	}

	public LoopGridViewItem OnGetToHaveEmoteItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.ShowToHaveEmoteList.Count)
		{
			return null;
		}
		ToHaveEmoteItemModel toHaveEmoteItemModel = viewModel.ShowToHaveEmoteList[itemIndex];
		if (toHaveEmoteItemModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("EmoteItem");
		ToHaveEmoteItem component = loopGridViewItem.GetComponent<ToHaveEmoteItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(toHaveEmoteItemModel);
		}
		else
		{
			component.RefreshData(toHaveEmoteItemModel);
		}
		return loopGridViewItem;
	}

	public LoopGridViewItem OnGetBattleStartEmoteItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.BattleStartList.Count)
		{
			return null;
		}
		SetEmoteItemModel setEmoteItemModel = viewModel.BattleStartList[itemIndex];
		if (setEmoteItemModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("EmoteItem");
		SetEmoteItem component = loopGridViewItem.GetComponent<SetEmoteItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(setEmoteItemModel);
		}
		else
		{
			component.RefreshData(setEmoteItemModel);
		}
		return loopGridViewItem;
	}

	public void InitEmoteItem()
	{
		deg = 360f / (float)viewModel.SetEmoteDic.Count;
		for (int i = 0; i < viewModel.SetEmoteDic.Count; i++)
		{
			GameObject obj = UnityEngine.Object.Instantiate(emotePrefab);
			obj.SetActive(value: true);
			float f = (float)((double)(halfDeg + (float)i * deg) * (Math.PI / 180.0));
			float x = Mathf.Sin(f) * radius;
			float y = Mathf.Cos(f) * radius;
			obj.transform.SetParent(emoteRoot.transform);
			obj.transform.localScale = Vector3.one;
			obj.GetComponent<RectTransform>().anchoredPosition = new Vector3(x, y, 0f);
			obj.GetComponent<RectTransform>().eulerAngles = new Vector3(0f, 0f, (0f - deg) * (float)i);
			SetEmoteItem component = obj.GetComponent<SetEmoteItem>();
			component?.Init(viewModel.SetEmoteDic[i + 1]);
			emoteList.Add(component);
		}
	}

	public void DragEndSetScrollRectVertical(object sender, InteractionEventArgs e)
	{
		if (scrollRect != null && !scrollRect.vertical)
		{
			scrollRect.vertical = true;
		}
		ToHaveEmoteItemModel toHaveEmoteItemModel = viewModel?.CurSelectEmote;
		if (toHaveEmoteItemModel != null && toHaveEmoteItemModel.EmoteDrag == EmoteDragState.Dragging)
		{
			toHaveEmoteItemModel.EmoteDrag = EmoteDragState.Normal;
			if (dragObj != null && dragObj.gameObject.activeSelf)
			{
				dragObj.gameObject.SetActive(value: false);
			}
			viewModel.SetSelectedEmote(toHaveEmoteItemModel);
			viewModel.MousePointerUpSaveInitialEmote();
			viewModel.CheckDragEndEmoteState();
			viewModel.SendSaveBattleEmote();
		}
	}

	public void InitDragVM()
	{
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		dragObj.Init(viewModel.DragtVM);
		_dragRect = ((dragObj != null) ? dragObj.GetComponent<RectTransform>() : null);
		_dragParentRect = ((_dragRect != null) ? (_dragRect.parent as RectTransform) : null);
		_dragCanvas = ((dragObj != null) ? dragObj.GetComponentInParent<Canvas>() : null);
		_uiCamera = (((UnityEngine.Object)(object)_dragCanvas != null && (int)_dragCanvas.renderMode != 0) ? _dragCanvas.worldCamera : null);
		if (_dragRect != null)
		{
			_dragRect.pivot = new Vector2(0.5f, 0.5f);
		}
	}

	private void SetDragPosition(Vector2 screenPos)
	{
		if (!(_dragRect == null))
		{
			Vector2 anchoredPosition = default(Vector2);
			if (_dragParentRect == null)
			{
				_dragRect.position = screenPos;
			}
			else if (RectTransformUtility.ScreenPointToLocalPointInRectangle(_dragParentRect, screenPos, _uiCamera, ref anchoredPosition))
			{
				_dragRect.anchoredPosition = anchoredPosition;
			}
		}
	}

	public void Update()
	{
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Invalid comparison between Unknown and I4
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Invalid comparison between Unknown and I4
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		if (viewModel?.CurSelectEmote == null || dragObj == null || viewModel.DragtVM == null || viewModel.CurSelectEmote.EmoteDrag != EmoteDragState.Dragging)
		{
			return;
		}
		bool mouseButtonUp = Input.GetMouseButtonUp(0);
		bool flag = false;
		Vector2 dragPosition = Input.mousePosition;
		if (Input.touchCount > 0)
		{
			Touch touch = Input.GetTouch(0);
			dragPosition = ((Touch)(ref touch)).position;
			flag = (int)((Touch)(ref touch)).phase == 3 || (int)((Touch)(ref touch)).phase == 4;
		}
		if (mouseButtonUp | flag)
		{
			viewModel.DragEndRequest.Raise();
			return;
		}
		if (Input.touchCount == 0 && !Input.GetMouseButton(0))
		{
			viewModel.InterruptDrag();
			return;
		}
		for (int i = 0; i < Input.touchCount; i++)
		{
			Touch touch2 = Input.GetTouch(i);
			if ((int)((Touch)(ref touch2)).phase == 0)
			{
				viewModel.InterruptDrag();
				return;
			}
		}
		SetDragPosition(dragPosition);
		if (scrollRect != null && scrollRect.vertical)
		{
			scrollRect.vertical = false;
		}
		if (!dragObj.gameObject.activeSelf)
		{
			dragObj.gameObject.SetActive(value: true);
		}
		if (viewModel.DragtVM.EmoteIconPath != viewModel.CurSelectEmote.EmoteIconPath)
		{
			viewModel.ShowEmoteState();
			viewModel.DragtVM.SetDragEmoteIcon(viewModel.CurSelectEmote.EmoteIconPath);
		}
	}
}
