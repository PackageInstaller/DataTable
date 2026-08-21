using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SourceItem
{
	private GameObject _go;

	private TextMeshProUGUI _text;

	private Button _btn;

	private OptionBase _parent;

	public GameObject Go => _go;

	public SourceItem(GameObject go, OptionBase parent)
	{
		_go = go;
		_parent = parent;
		_text = go.transform.GetChild(0).GetComponent<TextMeshProUGUI>();
		_btn = go.GetComponent<Button>();
	}

	public void Refresh(string name)
	{
		((TMP_Text)_text).text = name;
		_go.SetActive(value: true);
	}

	private void ResouceOnClick(string windowName, List<object> args)
	{
		_parent.ItemOnClick(new JumpWindowParams(windowName, args));
	}

	public void Hide()
	{
		_go.SetActive(value: false);
	}
}
