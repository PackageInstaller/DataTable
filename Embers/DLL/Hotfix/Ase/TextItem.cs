using TMPro;
using UnityEngine;

namespace Ase;

public class TextItem
{
	private GameObject _go;

	private TextMeshProUGUI _text;

	public GameObject Go => _go;

	public TextItem(GameObject go)
	{
		_go = go;
		_text = go.transform.GetChild(1).GetComponent<TextMeshProUGUI>();
	}

	public void Refresh(string str)
	{
		((TMP_Text)_text).text = str;
		_go.SetActive(value: true);
	}

	public void Hide()
	{
		_go.SetActive(value: false);
	}
}
