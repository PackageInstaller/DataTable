using UnityEngine;
using UnityEngine.UI;

public class ToggleTextInverse : MonoBehaviour
{
	public Graphic text;

	public Color selectedColor;

	public Color unselectedColor;

	private Toggle toggle;

	private void Start()
	{
		toggle = base.gameObject.GetComponent<Toggle>();
		toggle.onValueChanged.AddListener(delegate
		{
			Inverse(toggle);
		});
		Inverse(toggle);
	}

	private void Update()
	{
	}

	private void Inverse(Toggle toggle)
	{
		if (toggle.isOn)
		{
			text.color = selectedColor;
		}
		else
		{
			text.color = unselectedColor;
		}
	}
}
