using TMPro;
using UnityEngine;

namespace ACT.UI.AOT;

public class AnnouncementContentText : MonoBehaviour
{
	[SerializeField]
	private RectTransform container;

	[SerializeField]
	private TextMeshProUGUI text;

	public void Set(AnnouncementTextSegment textSegment)
	{
		text.text = textSegment.Text;
		Canvas.ForceUpdateCanvases();
	}
}
