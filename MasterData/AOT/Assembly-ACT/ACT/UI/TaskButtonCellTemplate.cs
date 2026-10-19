using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskButtonCellTemplate : MonoBehaviour
{
	public LocalizeStringEvent titleName;

	public LocalizeStringEvent titleNameSelected;

	public GameObject normal;

	public GameObject selected;

	public BetterAnimation betterAnimation;

	public CanvasGroup canvasGroup;

	public void SetTitle(int key)
	{
		titleName.StringReference.TableEntryReference = key;
		titleNameSelected.StringReference.TableEntryReference = key;
	}
}
