using System;
using TMPro;
using UnityEngine;

namespace Ase;

public class AffixKnapsackItem
{
	private GameObject _go;

	private TextMeshProUGUI _name;

	private TextMeshProUGUI _value;

	public GameObject Go => _go;

	public AffixKnapsackItem(GameObject go)
	{
		_go = go;
		_name = go.transform.GetChild(0).GetComponent<TextMeshProUGUI>();
		_value = go.transform.GetChild(1).GetComponent<TextMeshProUGUI>();
	}

	public void Refresh(string name, float value, int valueType)
	{
		((TMP_Text)_name).text = name;
		switch (valueType)
		{
		case 1:
			((TMP_Text)_value).text = $"{Math.Round(value, MidpointRounding.AwayFromZero)}";
			break;
		case 2:
		{
			double num = Math.Round(value, 3, MidpointRounding.AwayFromZero);
			((TMP_Text)_value).text = num.ToString("P1");
			break;
		}
		}
		_go.SetActive(value: true);
	}

	public void Hide()
	{
		_go.SetActive(value: false);
	}
}
