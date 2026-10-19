using TMPro;
using UnityEngine;

namespace ACT.UI;

public sealed class RogueSettlementStatItem : MonoBehaviour
{
	public TextMeshProUGUI TxtLabel;

	public TextMeshProUGUI TxtValue;

	public void SetData(string label, string value)
	{
		TxtLabel.text = label;
		TxtValue.text = value;
	}
}
