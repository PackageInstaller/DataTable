using ACT.Core;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ElementCell : UIBehaviour
{
	public ElementBitmask element;

	public GameObject inactiveRoot;

	public GameObject activeRoot;

	public void Init(ElementBitmask environmentElement)
	{
		inactiveRoot.SetActive(environmentElement != element);
		activeRoot.SetActive(environmentElement == element);
	}
}
