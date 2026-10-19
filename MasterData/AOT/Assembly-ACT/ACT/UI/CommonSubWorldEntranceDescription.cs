using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CommonSubWorldEntranceDescription : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI _description;

	public void RefreshUI(string description)
	{
		_description.text = description;
	}
}
