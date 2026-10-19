using ACT.UI;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class SystemGuideChapterItem : MonoBehaviour
{
	public BetterAnimation betterAnimation;

	public GameObject selected;

	public TextMeshProUGUI chapterText;

	public LocalizeStringEvent chapterStringEvent;

	public TextMeshProUGUI selectedText;

	public LocalizeStringEvent selectedStringEvent;

	public GameObject normalTxt;

	public GameObject extraTxt;

	public ActButton btn;

	public void SetActive(bool active)
	{
		selected.SetActive(active);
		if (active)
		{
			betterAnimation?.GetSequence("Change").Play();
		}
		normalTxt.SetActive(!active);
	}

	public void SetDisabled(bool disabled)
	{
		selected.SetActive(!disabled);
		normalTxt.SetActive(!disabled);
		extraTxt.SetActive(disabled);
		btn.interactable = !disabled;
	}

	public void SetLabel(string label)
	{
		chapterText.text = label;
		selectedText.text = label;
	}

	public void SetLocalizationTxt(int localizationId)
	{
		chapterStringEvent.StringReference.TableEntryReference = localizationId;
		selectedStringEvent.StringReference.TableEntryReference = localizationId;
	}
}
