using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class CopySecondTouch : MonoBehaviour, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler
{
	private Action<CopyItem2View> UpdateItemAction;

	public float itemCenterPos = 0.5f;

	public int itemShowCount = 5;

	private int itemCount;

	public float itemInterval;

	public float itemStartOffset;

	public GameObject aniItemTempl;

	public Transform aniItemRoot;

	public float disapearPos;

	private List<CopyItem2View> aniItemPool;

	private List<CopyItem2View> showItemList;

	public float offsetPlaySpeed;

	public float dragEndOffsetPlaySpeed;

	public float dragPlaySpeed;

	public float clickPlaySpeed;

	private CopySecondType2ViewModel viewModel;

	private bool startPlayFlag;

	private float startPlayPos;

	private bool normalPlayFlag;

	private float normalPlayPos;

	private float normalPlaySpeed;

	private bool dragPlayFlag;

	private float dragY;

	private int curCenterIndex;

	private int nextCenterIndex;

	private bool move2IndexFlag;

	private float lastDragY;

	public void RefreshList()
	{
		if (viewModel == null)
		{
			return;
		}
		itemCount = viewModel.CopyItemVms.Count;
		int num = -1;
		int selectIndex = viewModel.GetSelectIndex();
		List<int> showList = viewModel.GetShowList(itemShowCount);
		curCenterIndex = selectIndex;
		int count = showList.Count;
		for (int i = 0; i < count; i++)
		{
			float num2 = itemCenterPos + (float)(showList[i] - selectIndex) * itemInterval - itemStartOffset;
			if (!(num2 + itemStartOffset < disapearPos) && !(num2 + itemStartOffset > 1f - disapearPos))
			{
				CopyItem2View copyItem2View = null;
				if (showItemList.Count > i)
				{
					copyItem2View = showItemList[i];
				}
				else
				{
					copyItem2View = GetAniItem();
					showItemList.Add(copyItem2View);
				}
				copyItem2View.Init(viewModel.CopyItemVms[showList[i]]);
				copyItem2View.SetIndex(showList[i]);
				copyItem2View.SetAniPos(num2);
				copyItem2View.gameObject.SetActive(value: true);
				num = i;
			}
		}
		for (int num3 = showItemList.Count - 1; num3 > num; num3--)
		{
			CycleAniItem(showItemList[num3]);
			showItemList.RemoveAt(num3);
		}
		startPlayFlag = true;
		startPlayPos = itemStartOffset;
	}

	public void Init(CopySecondType2ViewModel viewModel)
	{
		if (viewModel != null)
		{
			this.viewModel = viewModel;
			itemCount = this.viewModel.CopyItemVms.Count;
			aniItemTempl?.gameObject.SetActive(value: false);
			CreatePool();
			InitAniItemDataAndPos();
		}
	}

	private void InitAniItemDataAndPos()
	{
		showItemList = new List<CopyItem2View>();
		int selectIndex = viewModel.GetSelectIndex();
		List<int> showList = viewModel.GetShowList(itemShowCount);
		int count = showList.Count;
		for (int i = 0; i < count; i++)
		{
			float num = itemCenterPos + (float)(showList[i] - selectIndex) * itemInterval - itemStartOffset;
			if (!(num + itemStartOffset < disapearPos) && !(num + itemStartOffset > 1f - disapearPos))
			{
				CopyItem2View aniItem = GetAniItem();
				aniItem.Init(viewModel.CopyItemVms[showList[i]]);
				aniItem.SetIndex(showList[i]);
				showItemList.Add(aniItem);
				aniItem.SetAniPos(num);
				aniItem.gameObject.SetActive(value: true);
			}
		}
		startPlayFlag = true;
		startPlayPos = itemStartOffset;
		curCenterIndex = selectIndex;
	}

	private void Update()
	{
		if (startPlayFlag)
		{
			float num = Time.deltaTime * offsetPlaySpeed;
			startPlayPos -= num;
			if (startPlayPos <= 0f)
			{
				startPlayFlag = false;
			}
			RefreshItemDataAndPos(num);
			if (!startPlayFlag)
			{
				FixItemPos();
			}
		}
		else if (normalPlayFlag)
		{
			float delta = GetDelta(normalPlayPos, normalPlaySpeed);
			normalPlayPos += delta;
			if ((delta < 0f && normalPlayPos <= 0f) || (delta > 0f && normalPlayPos >= 0f))
			{
				normalPlayFlag = false;
			}
			RefreshItemDataAndPos(delta);
			if (!normalPlayFlag)
			{
				CheckAutoMove2Pos();
				FixItemPos();
			}
		}
		else if (dragPlayFlag && showItemList != null && showItemList.Count != 0 && dragY != 0f)
		{
			float num2 = dragY * dragPlaySpeed;
			if (num2 > 0f && GetAniItem(first: true).CurAniPos + num2 > itemCenterPos)
			{
				num2 = Mathf.Clamp01(itemCenterPos - showItemList[0].CurAniPos);
			}
			else if (num2 < 0f && GetAniItem(first: false).CurAniPos + num2 < itemCenterPos)
			{
				num2 = 0f - Mathf.Clamp(showItemList[0].CurAniPos - itemCenterPos, 0f, 1f);
			}
			RefreshItemDataAndPos(num2);
			dragPlayFlag = false;
		}
	}

	public float GetDelta(float dir, float playSpeed)
	{
		if (!(dir > 0f))
		{
			return Time.deltaTime * playSpeed;
		}
		return (0f - Time.deltaTime) * playSpeed;
	}

	public void AutoPlay2Index(int index)
	{
		move2IndexFlag = true;
		nextCenterIndex = index;
		float num = itemInterval * (float)(index - curCenterIndex);
		normalPlayFlag = true;
		normalPlayPos = num;
		normalPlaySpeed = clickPlaySpeed;
	}

	private void CheckAutoMove2Pos()
	{
		if (move2IndexFlag)
		{
			curCenterIndex = nextCenterIndex;
			move2IndexFlag = false;
		}
	}

	private void FixItemPos()
	{
		if (curCenterIndex < 0 || curCenterIndex >= itemCount)
		{
			return;
		}
		for (int i = 0; i < showItemList.Count; i++)
		{
			showItemList[i].SetAniPos(itemCenterPos + itemInterval * (float)(showItemList[i].Index - curCenterIndex));
		}
		for (int j = 0; j < showItemList.Count; j++)
		{
			if (showItemList[j].Index == curCenterIndex)
			{
				UpdateItemAction(showItemList[j]);
			}
		}
	}

	private CopyItem2View GetAniItem(bool first)
	{
		if (first)
		{
			return showItemList[0];
		}
		return showItemList[showItemList.Count - 1];
	}

	private void RefreshItemDataAndPos(float delta)
	{
		bool flag = delta > 0f;
		for (int i = 0; i < showItemList.Count; i++)
		{
			showItemList[i].SetAniPos(showItemList[i].CurAniPos + delta);
		}
		CopyItem2View copyItem2View = showItemList[showItemList.Count - 1];
		CopyItem2View copyItem2View2 = showItemList[0];
		if (flag)
		{
			if (copyItem2View.CurAniPos > 1f - disapearPos)
			{
				CycleAniItem(copyItem2View);
				showItemList.RemoveAt(showItemList.Count - 1);
			}
			if (copyItem2View2.CurAniPos - itemInterval > disapearPos && copyItem2View2.Index > 0)
			{
				CopyItem2View aniItem = GetAniItem();
				aniItem.gameObject.SetActive(value: true);
				aniItem.SetAniPos(copyItem2View2.CurAniPos - itemInterval);
				aniItem.Init(viewModel.CopyItemVms[copyItem2View2.Index - 1]);
				aniItem.SetIndex(copyItem2View2.Index - 1);
				showItemList.Insert(0, aniItem);
			}
		}
		else
		{
			if (copyItem2View.CurAniPos + itemInterval < 1f - disapearPos && copyItem2View.Index < itemCount - 1)
			{
				CopyItem2View aniItem2 = GetAniItem();
				aniItem2.gameObject.SetActive(value: true);
				aniItem2.SetAniPos(copyItem2View.CurAniPos + itemInterval);
				aniItem2.Init(viewModel.CopyItemVms[copyItem2View.Index + 1]);
				aniItem2.SetIndex(copyItem2View.Index + 1);
				showItemList.Add(aniItem2);
			}
			if (copyItem2View2.CurAniPos < disapearPos)
			{
				CycleAniItem(copyItem2View2);
				showItemList.RemoveAt(0);
			}
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		move2IndexFlag = false;
		normalPlayFlag = false;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		int index = 0;
		float num = Mathf.Abs(showItemList[0].CurAniPos - itemCenterPos);
		for (int i = 0; i < showItemList.Count; i++)
		{
			float num2 = Mathf.Abs(showItemList[i].CurAniPos - itemCenterPos);
			if (num2 < num)
			{
				num = num2;
				index = i;
			}
		}
		curCenterIndex = showItemList[index].Index;
		num = showItemList[index].CurAniPos - itemCenterPos;
		normalPlayFlag = true;
		normalPlaySpeed = dragEndOffsetPlaySpeed;
		normalPlayPos = num;
		dragPlayFlag = false;
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragPlayFlag = true;
		if (eventData.delta.y - 1f < lastDragY && lastDragY < eventData.delta.y + 1f)
		{
			dragY = 0f;
			return;
		}
		dragY = eventData.delta.y;
		lastDragY = eventData.delta.y;
	}

	private void CreatePool()
	{
		aniItemPool = new List<CopyItem2View>();
		for (int i = 0; i < itemShowCount + 2; i++)
		{
			GetAniItem();
		}
	}

	private CopyItem2View GetAniItem()
	{
		for (int i = 0; i < aniItemPool.Count; i++)
		{
			if (aniItemPool[i].Index < 0)
			{
				return aniItemPool[i];
			}
		}
		GameObject gameObject = UnityEngine.Object.Instantiate(aniItemTempl.gameObject, aniItemRoot);
		if (gameObject != null)
		{
			CopyItem2View component = gameObject.GetComponent<CopyItem2View>();
			aniItemPool.Add(component);
			return component;
		}
		return null;
	}

	private void CycleAniItem(CopyItem2View item)
	{
		item.SetIndex(-1);
		item.gameObject.SetActive(value: false);
	}

	public void AddAction(Action<CopyItem2View> action)
	{
		UpdateItemAction = action;
	}

	private void OnDestroy()
	{
		viewModel = null;
		if (showItemList != null)
		{
			showItemList.Clear();
			showItemList = null;
		}
		if (aniItemPool != null)
		{
			for (int num = aniItemPool.Count - 1; num >= 0; num--)
			{
				UnityEngine.Object.Destroy(aniItemPool[num]);
				aniItemPool[num] = null;
			}
			aniItemPool.Clear();
			aniItemPool = null;
		}
	}
}
