using System.Collections.Generic;
using ACT.Model;
using ACT.Utility;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SchemeSelectBar : UIBehaviour
{
	public Transform customSchemeCellRoot;

	public SchemeSelectCell customSchemeCellPrefab;

	public ActButton addSchemeButton;

	public ActButton closeBtn;

	public List<SchemeSelectCell> fixedSchemeCells;

	private readonly List<SchemeSelectCell> _customSchemeCells = new List<SchemeSelectCell>();

	private SchemeSelectCell _lastSelectCell;

	private ModifyCustomSchemePanel _panel;

	public void Init(ModifyCustomSchemePanel panel)
	{
		_panel = panel;
		InitFixedSchemeCells();
		LoadCustomSchemeCells();
		addSchemeButton?.SetBtnClick(OnAddSchemeBtnClick);
		closeBtn?.SetBtnClick(OnCloseBtnClick);
		RefreshSelectedPlanDisPlay(_panel?.GetCurrentSchemeId() ?? 0);
		_panel?.RefreshOperateRoot();
	}

	private void InitFixedSchemeCells()
	{
		if (fixedSchemeCells == null)
		{
			return;
		}
		for (int i = 0; i < fixedSchemeCells.Count; i++)
		{
			SchemeSelectCell schemeSelectCell = fixedSchemeCells[i];
			if (!(schemeSelectCell == null))
			{
				int mobileFixedIdByIndex = DeviceCustomUISchemeId.GetMobileFixedIdByIndex(i);
				bool flag = Model<CustomUIModel>.Interface.TryGetScheme(mobileFixedIdByIndex, out var scheme);
				schemeSelectCell.gameObject.SetActive(flag);
				if (flag)
				{
					schemeSelectCell.Init(_panel, new SchemeSelectCellData
					{
						SchemeId = mobileFixedIdByIndex,
						IsCustomScheme = false
					}, scheme.GetName());
				}
			}
		}
	}

	public void LoadCustomSchemeCells()
	{
		if (customSchemeCellPrefab != null)
		{
			customSchemeCellPrefab.gameObject.SetActive(value: false);
		}
		if (customSchemeCellPrefab == null || customSchemeCellRoot == null)
		{
			RefreshAddBtnState();
			RefreshSelectedPlanDisPlay(_panel?.GetCurrentSchemeId() ?? 0);
			return;
		}
		Model<CustomUIModel>.Interface.Scheme.GetAllCustomSchemeId(out var ids);
		foreach (int item in ids)
		{
			if (!DeviceCustomUISchemeId.IsValidMobileCustomId(item) || !Model<CustomUIModel>.Interface.Scheme.TryGetScheme(item, out var scheme))
			{
				continue;
			}
			if (_customSchemeCells.Count >= 4)
			{
				break;
			}
			SchemeSelectCell customSchemeCell = GetCustomSchemeCell(item);
			if (customSchemeCell == null)
			{
				customSchemeCell = CreateCustomSchemeCell(item, scheme.GetName());
				if (customSchemeCell != null)
				{
					_customSchemeCells.Add(customSchemeCell);
				}
			}
			else
			{
				customSchemeCell.SetName(scheme.GetName());
				customSchemeCell.gameObject.SetActive(value: true);
			}
		}
		RefreshAddBtnState();
		RefreshSelectedPlanDisPlay(_panel?.GetCurrentSchemeId() ?? 0);
	}

	public void DestroyCustomSchemeCell(int schemeId)
	{
		SchemeSelectCell customSchemeCell = GetCustomSchemeCell(schemeId);
		if (!(customSchemeCell == null))
		{
			DestroyCustomSchemeCell(customSchemeCell);
			RefreshAddBtnState();
			RefreshSelectedPlanDisPlay(_panel?.GetCurrentSchemeId() ?? 0);
		}
	}

	private void DestroyCustomSchemeCell(SchemeSelectCell cell)
	{
		if (!(cell == null))
		{
			if (_lastSelectCell == cell)
			{
				_lastSelectCell = null;
			}
			_customSchemeCells.Remove(cell);
			cell.UnInit();
			Object.Destroy(cell.gameObject);
		}
	}

	private SchemeSelectCell CreateCustomSchemeCell(int schemeId, string schemeName)
	{
		if (customSchemeCellPrefab == null || customSchemeCellRoot == null)
		{
			return null;
		}
		SchemeSelectCell schemeSelectCell = Object.Instantiate(customSchemeCellPrefab, customSchemeCellRoot);
		schemeSelectCell.gameObject.SetActive(value: true);
		schemeSelectCell.Init(_panel, new SchemeSelectCellData
		{
			SchemeId = schemeId,
			IsCustomScheme = true
		}, schemeName);
		return schemeSelectCell;
	}

	public void RefreshSchemeNames()
	{
		RefreshCellNames(fixedSchemeCells);
		RefreshCellNames(_customSchemeCells);
	}

	private void RefreshCellNames(List<SchemeSelectCell> cells)
	{
		if (cells == null)
		{
			return;
		}
		foreach (SchemeSelectCell cell in cells)
		{
			if (cell?.Data != null && Model<CustomUIModel>.Interface.Scheme.TryGetScheme(cell.Data.SchemeId, out var scheme))
			{
				cell.SetName(scheme.GetName());
			}
		}
	}

	private void RefreshAddBtnState()
	{
		if (!(addSchemeButton == null))
		{
			addSchemeButton.gameObject.SetActive(_customSchemeCells.Count < 4 && Model<CustomUIModel>.Interface.Scheme.CanAddCustomScheme());
			addSchemeButton.transform.SetAsLastSibling();
		}
	}

	private void ClearCustomSchemeCells()
	{
		foreach (SchemeSelectCell customSchemeCell in _customSchemeCells)
		{
			if (!(customSchemeCell == null))
			{
				customSchemeCell.UnInit();
				Object.Destroy(customSchemeCell.gameObject);
			}
		}
		_customSchemeCells.Clear();
		_lastSelectCell = null;
	}

	private void OnAddSchemeBtnClick()
	{
		_panel?.AddNewSchemePlan();
	}

	private void OnCloseBtnClick()
	{
		_panel?.HideSchemeSelectBar();
	}

	public void RefreshSelectedPlanDisPlay(int schemeId)
	{
		if (!IsSelectableSchemeId(schemeId))
		{
			ClearSelectedCell();
			return;
		}
		SchemeSelectCell schemeSelectCell = GetFixedSchemeCell(schemeId) ?? GetCustomSchemeCell(schemeId);
		if (_lastSelectCell != null && _lastSelectCell != schemeSelectCell)
		{
			_lastSelectCell.SetSelected(selected: false);
		}
		_lastSelectCell = schemeSelectCell;
		_lastSelectCell?.SetSelected(selected: true);
	}

	private bool IsSelectableSchemeId(int schemeId)
	{
		if (!DeviceCustomUISchemeId.IsValidMobileFixedId(schemeId))
		{
			return DeviceCustomUISchemeId.IsValidMobileCustomId(schemeId);
		}
		return true;
	}

	private SchemeSelectCell GetFixedSchemeCell(int schemeId)
	{
		if (fixedSchemeCells == null)
		{
			return null;
		}
		foreach (SchemeSelectCell fixedSchemeCell in fixedSchemeCells)
		{
			if (fixedSchemeCell?.Data != null && fixedSchemeCell.Data.SchemeId == schemeId)
			{
				return fixedSchemeCell;
			}
		}
		return null;
	}

	private SchemeSelectCell GetCustomSchemeCell(int schemeId)
	{
		foreach (SchemeSelectCell customSchemeCell in _customSchemeCells)
		{
			if (customSchemeCell?.Data != null && customSchemeCell.Data.SchemeId == schemeId)
			{
				return customSchemeCell;
			}
		}
		return null;
	}

	private void ClearSelectedCell()
	{
		if (fixedSchemeCells != null)
		{
			foreach (SchemeSelectCell fixedSchemeCell in fixedSchemeCells)
			{
				fixedSchemeCell?.SetSelected(selected: false);
			}
		}
		foreach (SchemeSelectCell customSchemeCell in _customSchemeCells)
		{
			customSchemeCell?.SetSelected(selected: false);
		}
		_lastSelectCell = null;
	}

	public void Show()
	{
		RefreshSelectedPlanDisPlay(_panel?.GetCurrentSchemeId() ?? 0);
		_panel?.RefreshOperateRoot();
		gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}

	public void UnInit()
	{
		if (fixedSchemeCells != null)
		{
			foreach (SchemeSelectCell fixedSchemeCell in fixedSchemeCells)
			{
				fixedSchemeCell?.UnInit();
			}
		}
		ClearCustomSchemeCells();
		addSchemeButton?.OnClick.RemoveAllListeners();
		closeBtn?.OnClick.RemoveAllListeners();
		_lastSelectCell = null;
		_panel = null;
	}
}
