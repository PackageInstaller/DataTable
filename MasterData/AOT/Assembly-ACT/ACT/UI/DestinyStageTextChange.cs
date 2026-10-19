using TMPro;
using UnityEngine;

namespace ACT.UI;

public class DestinyStageTextChange : MonoBehaviour
{
	[Header("ColorConfig")]
	public Color normalColor;

	public Color getStageColor;

	public TextMeshPro[] targetTexts;

	public void SetTextState(int curDesStage)
	{
		for (int i = 0; i < targetTexts.Length; i++)
		{
			if (i < curDesStage)
			{
				targetTexts[i].color = getStageColor;
			}
			else
			{
				targetTexts[i].color = normalColor;
			}
		}
	}
}
