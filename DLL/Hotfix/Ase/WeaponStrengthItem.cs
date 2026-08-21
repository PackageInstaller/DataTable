using TMPro;
using UnityEngine;

namespace Ase;

public class WeaponStrengthItem
{
	private GameObject _go;

	private TextMeshProUGUI _value;

	public WeaponStrengthItem(Transform transform)
	{
		_go = transform.parent.gameObject;
		_value = transform.GetChild(1).GetComponent<TextMeshProUGUI>();
	}

	public void Refresh(int value)
	{
		((TMP_Text)_value).text = $"{value}";
		_go.SetActive(value: true);
	}

	public void Hide()
	{
		_go.SetActive(value: false);
	}
}
