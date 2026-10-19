using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RaidTaskItem : CommonTaskItemBase
{
	[SerializeField]
	private GameObject _target2;

	[SerializeField]
	private GameObject _goldIcon;

	[SerializeField]
	private GameObject _expIcon;

	[SerializeField]
	private TextMeshProUGUI _countText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	public override void Refresh(SettlementType settlementType)
	{
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		int raidType = Model<RaidModel>.Interface.GetRaidType(currentRaidId);
		int totalSeconds = (int)Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
		RuntimeConfigs.data.raids.TryGetValue(currentRaidId, out var value);
		SetActive(active: true);
		_target2.SetActive(value: false);
		UpdateTotalTime(totalSeconds);
		_title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.raidName);
		if (raidType == 7)
		{
			RuntimeConfigs.data.raidParkourDatas.TryGetValue(currentRaidId, out var value2);
			if (value != null && value.mainTarget.Length != 0)
			{
				_target2.SetActive(value: true);
				RaidMissionTarget raidMissionTarget = RuntimeConfigs.data.raidMissionTargets[value.mainTarget[1]];
				int stateWorldAssetInStateNumberByTag = MonoECS.instance.ruleManager.GetStateWorldAssetInStateNumberByTag(ServiceSaveTag.RaidCollection, 1);
				int total = value2.total;
				_countText.SetText("{0:0}/{1:0}", stateWorldAssetInStateNumberByTag, total);
				_goldIcon.SetActive(raidMissionTarget.targetIcon == 1);
				_expIcon.SetActive(raidMissionTarget.targetIcon != 1);
			}
		}
		_betterAnimation.GetComponent<CanvasGroup>().alpha = 0f;
	}

	public override void PlayItemAnimation(SettlementType settlementType)
	{
		_betterAnimation.GetComponent<CanvasGroup>().alpha = 1f;
		_betterAnimation.GetSequence("NormalShow").Play();
	}
}
