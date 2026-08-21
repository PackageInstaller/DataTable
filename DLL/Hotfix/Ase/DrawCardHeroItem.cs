using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardHeroItem : DrawCardChooseItem
{
	[SerializeField]
	private Image attributeImg;

	[SerializeField]
	private TextMeshProUGUI attributeText;

	[SerializeField]
	private TextMeshProUGUI heroNameText;

	[SerializeField]
	private TextMeshProUGUI tageNameText;

	[SerializeField]
	private TextMeshProUGUI tageTypeText;
}
