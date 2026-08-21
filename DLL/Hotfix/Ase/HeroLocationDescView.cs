using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroLocationDescView : UGuiView
{
	[SerializeField]
	private Button btnOpen;

	[SerializeField]
	private GameObject descPanel;

	[SerializeField]
	private Button btnClose;

	public void Init()
	{
		btnOpen.onClick.AddListener(Open);
		btnClose.onClick.AddListener(Close);
		Close();
	}

	public void Open()
	{
		descPanel.SetActive(value: true);
		btnClose.gameObject.SetActive(value: true);
	}

	public void Close()
	{
		descPanel.SetActive(value: false);
		btnClose.gameObject.SetActive(value: false);
	}
}
