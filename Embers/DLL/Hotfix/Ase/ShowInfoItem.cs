using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ShowInfoItem : MonoBehaviour
{
	public List<Button> btnOpen;

	public List<Button> btnClose;

	public GameObject infoPanelGo;

	private bool isInit;

	public void Init()
	{
		if (isInit || infoPanelGo == null)
		{
			return;
		}
		infoPanelGo.gameObject.SetActive(value: false);
		if (btnOpen != null)
		{
			for (int i = 0; i < btnOpen.Count; i++)
			{
				btnOpen[i]?.onClick.AddListener(delegate
				{
					infoPanelGo.gameObject.SetActive(value: true);
				});
			}
		}
		if (btnClose == null)
		{
			return;
		}
		for (int num = 0; num < btnClose.Count; num++)
		{
			btnClose[num]?.onClick.AddListener(delegate
			{
				infoPanelGo.gameObject.SetActive(value: false);
			});
		}
	}

	private void OnDestroy()
	{
	}
}
