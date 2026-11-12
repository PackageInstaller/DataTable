using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class BattleTestDropHelp : Dropdown
{
	public override void OnPointerClick(PointerEventData eventData)
	{
		base.OnPointerClick(eventData);
		InputField component = transform.Find("InputCharId").GetComponent<InputField>();
		component.text = string.Empty;
		component.gameObject.SetActive(value: true);
	}

	protected override void DestroyDropdownList(GameObject dropdownList)
	{
		base.DestroyDropdownList(dropdownList);
		transform.Find("InputCharId").gameObject.SetActive(value: false);
	}
}
