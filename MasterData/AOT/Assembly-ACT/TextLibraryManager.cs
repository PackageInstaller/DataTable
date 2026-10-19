using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using Fundamental;
using UnityEngine;

public class TextLibraryManager : Singleton<TextLibraryManager>
{
	public class TextLibraryCellPool
	{
		private Stack<TextLibraryCell> _pool;

		public TextLibraryCellPool()
		{
			_pool = new Stack<TextLibraryCell>();
		}

		public TextLibraryCell GetTextLibraryCell(GameObject prefab, Transform parent)
		{
			if (prefab == null || parent == null)
			{
				return null;
			}
			while (_pool.Count > 0)
			{
				TextLibraryCell textLibraryCell = _pool.Pop();
				if (textLibraryCell != null && textLibraryCell.gameObject != null)
				{
					textLibraryCell.transform.SetParent(parent, worldPositionStays: false);
					textLibraryCell.gameObject.SetActive(value: true);
					return textLibraryCell;
				}
			}
			GameObject gameObject = Object.Instantiate(prefab, parent);
			if (gameObject != null && gameObject.TryGetComponent(typeof(TextLibraryCell), out var component))
			{
				TextLibraryCell textLibraryCell2 = component as TextLibraryCell;
				if (textLibraryCell2 != null && textLibraryCell2.gameObject != null)
				{
					textLibraryCell2.gameObject.SetActive(value: true);
				}
				return textLibraryCell2;
			}
			return null;
		}

		public void ReleaseTextLibraryCell(TextLibraryCell cell, Transform parent)
		{
			if (!(cell == null) && !(cell.gameObject == null))
			{
				cell.gameObject.SetActive(value: false);
				cell.transform.SetParent(parent, worldPositionStays: false);
				_pool.Push(cell);
			}
		}

		public void Clear()
		{
			while (_pool.Count > 0)
			{
				TextLibraryCell textLibraryCell = _pool.Pop();
				if (textLibraryCell != null && textLibraryCell.gameObject != null)
				{
					Object.Destroy(textLibraryCell.gameObject);
				}
			}
			_pool.Clear();
		}
	}

	public TextLibraryCellPool textLibraryCellPool;

	private List<TextLibraryContent> _list = new List<TextLibraryContent>();

	private Queue<TextLibraryContent> _pendingNew = new Queue<TextLibraryContent>();

	private Stack<TextLibraryPropPickCell> _cellPool = new Stack<TextLibraryPropPickCell>();

	private Queue<TextLibraryContent> pendingNew => pendingNew;

	public List<TextLibraryContent> textLibraryList => _list;

	public int Count => _list.Count;

	public bool HasData => _list.Count > 0;

	public bool HasPendingNew => _pendingNew.Count > 0;

	public override void Init()
	{
		textLibraryCellPool = new TextLibraryCellPool();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PropPickTextLibraryOnHud, OnPropPickTextLibraryOnHud);
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PropPickTextLibraryOnHud, OnPropPickTextLibraryOnHud);
		ClearCellPool();
		if (textLibraryCellPool != null)
		{
			textLibraryCellPool.Clear();
		}
		_list.Clear();
		_pendingNew.Clear();
	}

	private void OnPropPickTextLibraryOnHud(BaseEventContent obj)
	{
		if (!(obj is HudPropPickTextLibrary { unlockTextId: { Count: >0 } } hudPropPickTextLibrary))
		{
			return;
		}
		List<TextLibraryContent> list = ListPool<TextLibraryContent>.Get();
		foreach (int item in hudPropPickTextLibrary.unlockTextId)
		{
			list.Add(CoreUtils.GetData(item, RuntimeConfigs.data.textLibraryContents));
		}
		if (_list.Count > 0)
		{
			_list.AddRange(list);
			for (int i = 0; i < list.Count; i++)
			{
				_pendingNew.Enqueue(list[i]);
			}
		}
		else
		{
			_list.AddRange(list);
			for (int j = 0; j < list.Count; j++)
			{
				_pendingNew.Enqueue(list[j]);
			}
			OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
			evt.position = UIPosition.LeftBottom;
			evt.type = HudComponentType.TextLibraryPropPick;
			evt.uiData = new TextLibraryPropPickData
			{
				seatLimit = 2,
				isAvgTextLibrariesDats = hudPropPickTextLibrary.isFromAvg
			};
			evt.timeOutDuration = 15f;
			evt.priorityInQueue = 1;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		ListPool<TextLibraryContent>.Release(list);
	}

	public void AddTextLibraryData(List<TextLibraryContent> datas)
	{
		if (datas == null || datas.Count == 0)
		{
			return;
		}
		EnqueueTextLibraryData(datas);
		for (int i = 0; i < datas.Count; i++)
		{
			if (datas[i] != null)
			{
				_list.Add(datas[i]);
			}
		}
	}

	private void EnqueueTextLibraryData(List<TextLibraryContent> datas)
	{
		if (datas == null || datas.Count == 0)
		{
			return;
		}
		for (int i = 0; i < datas.Count; i++)
		{
			if (datas[i] != null)
			{
				_pendingNew.Enqueue(datas[i]);
			}
		}
	}

	public TextLibraryContent GetAt(int index)
	{
		if (index < 0 || index >= _list.Count)
		{
			return null;
		}
		return _list[index];
	}

	public void RemoveFirst()
	{
		if (_list.Count > 0)
		{
			_list.RemoveAt(0);
		}
	}

	public void RemoveAt(int index)
	{
		if (index >= 0 && index < _list.Count)
		{
			_list.RemoveAt(index);
		}
	}

	public void ClearAll()
	{
		if (_list.Count > 0)
		{
			_list.Clear();
		}
		_pendingNew.Clear();
	}

	public bool TryDequeuePendingNew(out TextLibraryContent data)
	{
		if (_pendingNew.Count > 0)
		{
			data = _pendingNew.Dequeue();
			return true;
		}
		data = null;
		return false;
	}

	public TextLibraryPropPickCell Get(GameObject prefab, Transform parent)
	{
		if (prefab == null || parent == null)
		{
			return null;
		}
		TextLibraryPropPickCell textLibraryPropPickCell = null;
		while (_cellPool.Count > 0)
		{
			textLibraryPropPickCell = _cellPool.Pop();
			textLibraryPropPickCell.transform.SetParent(parent);
			textLibraryPropPickCell.ClearData();
		}
		if (textLibraryPropPickCell == null)
		{
			GameObject gameObject = Object.Instantiate(prefab, parent);
			if (gameObject != null && gameObject.TryGetComponent(typeof(TextLibraryPropPickCell), out var component))
			{
				return component as TextLibraryPropPickCell;
			}
		}
		return textLibraryPropPickCell;
	}

	public void ReleaseInPool(TextLibraryPropPickCell cell)
	{
		if (!(cell == null))
		{
			MonoBattleMainBaseView monoBattleMainBaseView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) as MonoBattleMainBaseView;
			if (monoBattleMainBaseView != null)
			{
				cell.canvasGroup.alpha = 0f;
				cell.transform.SetParent(monoBattleMainBaseView.ControlTransform, worldPositionStays: false);
				cell.gameObject.SetActive(value: false);
				_cellPool.Push(cell);
			}
		}
	}

	public void ClearCellPool()
	{
		while (_cellPool.Count > 0)
		{
			TextLibraryPropPickCell textLibraryPropPickCell = _cellPool.Pop();
			if (textLibraryPropPickCell != null)
			{
				Object.Destroy(textLibraryPropPickCell.gameObject);
			}
		}
	}
}
