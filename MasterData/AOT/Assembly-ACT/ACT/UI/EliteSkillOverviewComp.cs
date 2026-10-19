using ACT.Config;
using ACT.Core;
using ACT.RichText;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EliteSkillOverviewComp : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent skillNameLocalize;

	[SerializeField]
	private TextMeshProUGUI skillDescLocalize;

	[SerializeField]
	private LocalizeStringEvent skillNameLocalize_inactive;

	[SerializeField]
	private TextMeshProUGUI skillDescLocalize_inactive;

	[SerializeField]
	private LocalizeStringEvent unlockTips;

	[SerializeField]
	private BImage skillIcon;

	[SerializeField]
	private Image skillIconColor;

	[SerializeField]
	private PublicToggle unlockToggle;

	[SerializeField]
	private LocalizeStringEvent stageLocalize;

	[SerializeField]
	private Image activeBoard;

	[SerializeField]
	private Image notActiveBoard;

	public void Init(int index, int skillGroupId, bool active, ImageAssetStation imageAssetStation, int activeLevel)
	{
		ColorUtility.TryParseHtmlString(active ? "#ceff8f" : "#6a6d71", out var color);
		int[] skillMessageId = CoreUtils.GetSkillMessageId(skillGroupId);
		if (skillMessageId != null && skillMessageId.Length != 0)
		{
			int num = skillMessageId[0];
			SkillDetailMessageData data = CoreUtils.GetData(num, RuntimeConfigs.data.skillDetailMessageDatas);
			skillNameLocalize.SetReference(LocalizeTable.ShortCommon, data.nameLocal);
			skillNameLocalize.gameObject.GetComponent<TextMeshProUGUI>().color = color;
			skillDescLocalize.text = CustomTagParser.ReplaceSkillMessageText(num, "longcommon", isBrief: false);
			skillNameLocalize_inactive.SetReference(LocalizeTable.ShortCommon, data.nameLocal);
			skillDescLocalize_inactive.text = CustomTagParser.ReplaceSkillMessageText(num, "longcommon", isBrief: false);
			ColorUtility.TryParseHtmlString("#181f1d", out var color2);
			skillIconColor.color = (active ? color2 : Color.white);
			activeBoard.gameObject.SetActive(active);
			notActiveBoard.gameObject.SetActive(!active);
		}
		unlockTips.StringReference.TableEntryReference = (active ? 1787 : 2246);
		unlockTips.gameObject.GetComponent<TextMeshProUGUI>().color = color;
		unlockToggle.isOn = active;
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(index + 2, out var value))
		{
			stageLocalize.SetReference(LocalizeTable.ShortCommon, value.name);
		}
	}
}
