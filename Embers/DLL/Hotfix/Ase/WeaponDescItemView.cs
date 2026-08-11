using System;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponDescItemView : MonoBehaviour
{
	public RectTransform content;

	public float height;

	public GameObject sel;

	public Button btn;

	public WeaponEnum weaponEnum;

	private Action<WeaponEnum> onButtonClick;

	public void AddAction(Action<WeaponEnum> onButtonClick)
	{
		this.onButtonClick = (Action<WeaponEnum>)Delegate.Combine(this.onButtonClick, onButtonClick);
	}

	private void Start()
	{
		btn.onClick.AddListener(delegate
		{
			onButtonClick(weaponEnum);
		});
	}
}
