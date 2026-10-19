using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskCellTemplate : MonoBehaviour
{
	public LocalizeStringEvent titleText;

	public LocalizeStringEvent chapterText;

	public GameObject selected;

	public GameObject normal;

	public BetterAnimation betterAnimation;

	public CanvasGroup canvasGroup;
}
