using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TextLibraryRoot : LoopScrollBaseItem
{
	public ActButton self;

	public LocalizeStringEvent txtLibraryTypeName;

	public TextMeshProUGUI itemsNumber;

	public GameObject cellRoot;

	public GameObject cellPrefab;

	public RectTransform arrowTrans;

	public RedDotItem redDot;

	public TextLibraryView parentView;

	public GamePadSelectComponent selected;

	public ACT.ViewControl.SelectableEx selectableEx;

	public VerticalLayoutGroup parentLayout;

	public RectTransform rootTemplateRect;

	private TextLibraryRootData _curGroupData;

	private StringBuilder _sb;

	private List<TextLibraryCell> _curGroupCells = new List<TextLibraryCell>();

	public TextLibraryRootData curGroupData => _curGroupData;

	public int dataCount
	{
		get
		{
			if (_curGroupData == null)
			{
				return 0;
			}
			return _curGroupData.curShowTextLibraryCellDatas.Count;
		}
	}

	public bool cellRootIsOpen { get; private set; }

	public override void Init(object param)
	{
		base.Init(param);
		if (_sb == null)
		{
			_sb = new StringBuilder();
		}
		if (param is TextLibraryRootData textLibraryRootData)
		{
			_curGroupData = textLibraryRootData;
			txtLibraryTypeName.StringReference.TableEntryReference = textLibraryRootData.tableData.name;
			_sb.Clear();
			_sb.Append("[").Append(dataCount.FastToString()).Append("]");
			itemsNumber.SetText(_sb);
			string text = string.Empty;
			switch (textLibraryRootData.tableData.tabId)
			{
			case 1:
				text = RedDotPathDefine.TextLibrary + $"|{textLibraryRootData.tableData.id}";
				break;
			case 2:
				text = RedDotPathDefine.ViewPort + $"|{textLibraryRootData.tableData.id}";
				break;
			}
			if (!string.IsNullOrEmpty(text))
			{
				RefreshRedDot(text);
			}
			self.SetBtnClick(() =>
			{
				Model<TextLibraryModel>.Interface.groupState[_curGroupData.tableData.id] = cellRootIsOpen;
				bool flag = !cellRootIsOpen;
				Singleton<GameManager>.instance.audioManager.PlaySound(flag ? "event:/UI/Interface/Knowledge/Expand" : "event:/UI/Interface/Knowledge/Collapse");
				SetCellRootState(flag);
				RectTransform component = GetComponent<RectTransform>();
				float anchorViewportY = ((parentView != null) ? parentView.GetItemViewportTopY(component) : 0f);
				parentView?.RefreshScrollLayout(component, anchorViewportY);
			});
			LoadTextLibraryCell(_curGroupData.curShowTextLibraryCellDatas, text);
			bool textLibraryGroupState = Model<TextLibraryModel>.Interface.GetTextLibraryGroupState(textLibraryRootData.tableData.id);
			SetCellRootState(!textLibraryGroupState);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("词条初始化失败，检查逻辑");
		}
	}

	private void LoadTextLibraryCell(List<TextLibraryData> datas, string rootRedDotPath)
	{
		if (datas == null || datas.Count <= 0)
		{
			return;
		}
		if (_curGroupCells.Count > 0)
		{
			for (int num = _curGroupCells.Count - 1; num >= 0; num--)
			{
				Singleton<TextLibraryManager>.instance.textLibraryCellPool.ReleaseTextLibraryCell(_curGroupCells[num], parentView.ControlTransform);
				_curGroupCells.Remove(_curGroupCells[num]);
			}
		}
		foreach (TextLibraryData data in datas)
		{
			if (data != null)
			{
				TextLibraryCell cell = Singleton<TextLibraryManager>.instance.textLibraryCellPool.GetTextLibraryCell(cellPrefab, cellRoot.transform);
				cell.UpdateDisPlay(data, rootRedDotPath, () =>
				{
					parentView?.SetSelectedCell(cell);
				});
				cell.gameObject.SetActive(value: true);
				_curGroupCells.Add(cell);
			}
		}
	}

	public void SetCellRootState(bool active)
	{
		cellRootIsOpen = active;
		cellRoot?.SetActive(active);
		if (MonoECS.instance.IsGamePadMode())
		{
			parentView?.RefreshConfirmPromptText(active);
			parentView?.RefreshOperatePromptState();
		}
		arrowTrans.localScale = new Vector3(arrowTrans.localScale.x, active ? (-1f) : 1f, arrowTrans.localScale.z);
	}

	private void RefreshRedDot(string path)
	{
		redDot?.InitRedDot(path, RedDotType.New);
	}

	public RectTransform GetCellRectByContentId(int contentId)
	{
		List<TextLibraryCell> curGroupCells = _curGroupCells;
		if (curGroupCells == null || curGroupCells.Count <= 0)
		{
			return null;
		}
		for (int i = 0; i < _curGroupCells.Count; i++)
		{
			TextLibraryCell textLibraryCell = _curGroupCells[i];
			if (textLibraryCell != null && textLibraryCell.data.contentId == contentId)
			{
				return textLibraryCell.GetComponent<RectTransform>();
			}
		}
		return null;
	}

	protected override void OnUnityDestroy()
	{
		_sb = null;
		_curGroupCells.Clear();
		Singleton<TextLibraryManager>.instance.textLibraryCellPool.Clear();
		_curGroupData = null;
		cellRootIsOpen = false;
	}
}
