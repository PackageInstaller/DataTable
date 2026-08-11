using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryInfoView : UGuiView
{
	[SerializeField]
	private Button outlineAreaBtn;

	[SerializeField]
	private RectTransform parentRect;

	[SerializeField]
	private RectTransform main;

	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private GameObject scrollObj;

	[SerializeField]
	private EntryLevelItem entryLevelItem;

	[SerializeField]
	private TextMeshProUGUI entryDesc;

	[SerializeField]
	private bool dragAutoHide;

	[SerializeField]
	private ScrollChild scrollChild;

	private CanvasGroup _canvasGroup;

	private EntryItemData entryItemData;

	private EntryUpgradeItemData entryUpgradeItemData;

	private List<EntryData> drEntryDataList = new List<EntryData>();

	private EntryInfoViewModel _viewModel;

	public float mainHeight => main.sizeDelta.y;

	public void Init()
	{
		_canvasGroup = GetComponent<CanvasGroup>();
		outlineAreaBtn.onClick.AddListener(Hide);
		scrollView.InitListView(drEntryDataList.Count, OnGetItemByIndex);
		if (dragAutoHide && scrollChild != null)
		{
			scrollChild.AddBeginDrag(BeginDrag);
			scrollChild.AddEndDrag(EndDrag);
		}
	}

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<EntryInfoViewModel>(userData);
		BindingSet<EntryInfoView, EntryInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((EntryInfoView v) => v.Refresh).To((EntryInfoViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		Init();
		if (_viewModel.ItemData != null)
		{
			Show(_viewModel.ItemData, _viewModel.Pos);
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (_viewModel?.ItemData != null)
		{
			Show(_viewModel.ItemData, null, !_viewModel.ItemData.IsMainEntry);
		}
	}

	private void Refresh(object sender, InteractionEventArgs e)
	{
		Show(_viewModel.ItemData, null, !_viewModel.ItemData.IsMainEntry);
	}

	public void Show(EntryItemData data, EntryUpgradeItemData upgradeData = null, bool showLevel = true)
	{
		drEntryDataList.Clear();
		entryItemData = data;
		scrollObj.SetActive(showLevel);
		if (upgradeData != null)
		{
			entryUpgradeItemData = upgradeData;
			entryItemData = new EntryItemData(upgradeData.EntryData);
		}
		EntryLevelItemData viewModel = new EntryLevelItemData(null, data.EntryData, data.AllLevel, showLevel);
		if (entryLevelItem != null)
		{
			if (entryLevelItem.IsInit)
			{
				entryLevelItem.RefreshEntryLevelItemData(viewModel);
			}
			else
			{
				entryLevelItem.InitItem(viewModel);
			}
			((TMP_Text)entryDesc).text = (showLevel ? "" : data.EntryData.DrEntry.Desc);
		}
		else
		{
			((TMP_Text)entryDesc).text = "";
		}
		DREntry[] dataRows = GameEntry.DataTable.GetDataRows((DREntry p) => p.EntryId.Equals(entryItemData.EntryData.DrEntry.EntryId));
		for (int num = 0; num < dataRows.Length; num++)
		{
			EntryData entryData = new EntryData(dataRows[num]);
			if (entryData.DrEntry != null)
			{
				drEntryDataList.Add(entryData);
			}
		}
		scrollView.SetListItemCount(drEntryDataList.Count);
		scrollView.RefreshAllShownItem();
		int itemIndex = ((entryItemData.AllLevel > entryItemData.EntryData.MaxLevel) ? (entryItemData.EntryData.MaxLevel - 1) : (entryItemData.AllLevel - 1));
		scrollView.MovePanelToItemIndex(itemIndex, 0f);
		if ((Object)(object)_canvasGroup != null)
		{
			_canvasGroup.alpha = 1f;
			_canvasGroup.blocksRaycasts = true;
			base.gameObject.SetActive(value: true);
		}
		else
		{
			base.gameObject.SetActive(value: true);
		}
		outlineAreaBtn.gameObject.SetActive(value: true);
	}

	public void Show(EntryItemData data, Vector2 pos)
	{
		SetInfoPanelPosition(pos);
		Show(data, null, !data.IsMainEntry);
	}

	public void Show2(EntryItemData data, EntryItem entryItem)
	{
		SetInfoPanelPosition2(entryItem);
		Show(data, null, !data.IsMainEntry);
	}

	public void Show3(EntryItemData data)
	{
		Show(data, null, !data.IsMainEntry);
	}

	public void Hide()
	{
		if (entryItemData != null)
		{
			_viewModel?.Hide();
			entryItemData.SetSelect(isSelect: false);
			if (entryUpgradeItemData != null)
			{
				entryUpgradeItemData.SetSelect(isSelect: false);
			}
			drEntryDataList.Clear();
			base.gameObject.SetActive(value: false);
			main.GetComponent<CanvasGroup>().alpha = 1f;
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (drEntryDataList == null)
		{
			return null;
		}
		if (index < 0 || index >= drEntryDataList.Count)
		{
			return null;
		}
		EntryData entryData = drEntryDataList[index];
		if (entryData == null || entryData.DrEntry == null || entryData.DrEntry == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollView.NewListViewItem("EntryInfoItem");
		EntryInfoItem component = loopListViewItem.GetComponent<EntryInfoItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
		}
		bool flag = ((entryItemData.AllLevel >= entryItemData.EntryData.MaxLevel) ? (entryData.DrEntry.Level == entryItemData.EntryData.MaxLevel) : (entryData.DrEntry.Level == entryItemData.AllLevel));
		bool isCurLevel = ((entryItemData != null) & flag) && entryItemData.EntryData.IsRealData;
		bool isMax = entryItemData != null && entryData.DrEntry.Level == entryItemData.EntryData.MaxLevel;
		component.Refresh(entryData, isCurLevel, isMax);
		return loopListViewItem;
	}

	public void SetInfoPanelPosition2(EntryItem entryItem)
	{
		float x = entryItem.GetComponent<RectTransform>().sizeDelta.x;
		Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), (Vector3)new Vector2(entryItem.transform.position.x, entryItem.transform.position.y));
		Vector2 vector2 = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, vector + new Vector2(x / 2f, 10f), UIUtilly.GetUICamera(), ref vector2);
		main.localPosition = vector2;
	}

	private void SetInfoPanelPosition(Vector2 pos)
	{
		Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), (Vector3)pos);
		Vector2 vector2 = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, vector, UIUtilly.GetUICamera(), ref vector2);
		main.localPosition = vector2;
	}

	public void SetPosition(Vector2 pos)
	{
		main.transform.SetLocalPositionX(pos.x);
		main.transform.SetLocalPositionY(pos.y);
	}

	private void BeginDrag()
	{
		if (dragAutoHide && main != null)
		{
			main.GetComponent<CanvasGroup>().alpha = 0f;
		}
	}

	private void EndDrag()
	{
		if (dragAutoHide && outlineAreaBtn.gameObject.activeSelf)
		{
			outlineAreaBtn.gameObject.SetActive(value: false);
			Hide();
		}
	}
}
