using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SchemeSelectCell : UIBehaviour
{
	public bool isCustomSchemeCell;

	public ActButton btn;

	public ActButton deleteBtn;

	public ActButton editeNameBtn;

	public GameObject onSelectDot;

	public GameObject onSelect;

	public TextMeshProUGUI schemeName;

	private ModifyCustomSchemePanel _panel;

	public SchemeSelectCellData Data { get; private set; }

	public void Init(ModifyCustomSchemePanel panel, SchemeSelectCellData data, string name)
	{
		_panel = panel;
		Data = data;
		isCustomSchemeCell = data.IsCustomScheme;
		SetName(name);
		btn?.SetBtnClick(OnSelectBtnClick);
		if (deleteBtn != null)
		{
			deleteBtn.gameObject.SetActive(isCustomSchemeCell);
			deleteBtn.SetBtnClick(OnDeleteBtnClick);
		}
		if (editeNameBtn != null)
		{
			editeNameBtn.gameObject.SetActive(isCustomSchemeCell);
			editeNameBtn.SetBtnClick(OnReNameBtnClick);
		}
		SetSelected(selected: false);
	}

	public void SetName(string name)
	{
		if (schemeName != null)
		{
			schemeName.text = name;
		}
	}

	public void SetSelected(bool selected)
	{
		onSelectDot?.SetActive(selected);
		onSelect?.SetActive(selected);
		if (deleteBtn != null)
		{
			deleteBtn.gameObject.SetActive(isCustomSchemeCell && !selected);
		}
	}

	private void OnSelectBtnClick()
	{
		if (Data != null)
		{
			_panel?.SelectSchemePlanCell(Data.SchemeId);
		}
	}

	private void OnDeleteBtnClick()
	{
		if (Data != null)
		{
			_panel?.DeleteCustomSchemePlan(Data.SchemeId);
		}
	}

	private void OnReNameBtnClick()
	{
		SchemeSelectCellData data = Data;
		if (data != null && data.IsCustomScheme)
		{
			_panel?.OpenCustomSchemeRenamePanel(Data.SchemeId);
		}
	}

	public void UnInit()
	{
		_panel = null;
		Data = null;
	}
}
