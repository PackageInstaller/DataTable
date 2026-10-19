using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT;

public class RaidTypeButton : MonoBehaviour
{
	public Button RaidTypeBtn;

	public LocalizeStringEvent RaidTypeText;

	public void SetRaidTypeText(int textId)
	{
		RaidTypeText.StringReference.TableEntryReference = textId;
	}
}
