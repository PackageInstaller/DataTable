using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;

namespace ACT.UI;

[Obsolete]
public class RaidOpeningPerformanceView : BaseUIView
{
	public TextMeshProUGUI Title;

	public TextMeshProUGUI Description;

	public float CloseTime = 2f;

	private RaidOpeningPerformanceData raidOpeningPerformanceData;

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void Init()
	{
		base.Init();
		raidOpeningPerformanceData = uiViewData as RaidOpeningPerformanceData;
		int localizeId = 0;
		int localizeId2 = 0;
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid)
		{
			ACT.Config.Raid raid = RuntimeConfigs.data.raids[Model<RaidModel>.Interface.CurrentRaidId];
			RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[raid.belongEntranceData];
			RaidTypeData raidTypeData = null;
			foreach (KeyValuePair<int, RaidTypeData> raidTypeData2 in RuntimeConfigs.data.raidTypeDatas)
			{
				for (int i = 0; i < raidTypeData2.Value.raidEntranceId.Length; i++)
				{
					if (raidTypeData2.Value.raidEntranceId[i] == raidEntranceData.id)
					{
						raidTypeData = raidTypeData2.Value;
						break;
					}
				}
				if (raidTypeData != null)
				{
					break;
				}
			}
			if (raidTypeData.raidType == 7)
			{
				if (raidEntranceData.id == 101)
				{
					localizeId = 2260;
					localizeId2 = 2267;
				}
				else
				{
					localizeId = 2259;
					localizeId2 = 2266;
				}
			}
			else if (raidTypeData.raidType == 1)
			{
				int num = 0;
				for (int j = 0; j < raidTypeData.raidEntranceId.Length; j++)
				{
					if (raidTypeData.raidEntranceId[j] == raidEntranceData.id)
					{
						num = j;
						break;
					}
				}
				switch (num)
				{
				case 0:
					localizeId = 2262;
					localizeId2 = 2268;
					break;
				case 1:
					localizeId = 2261;
					localizeId2 = 2268;
					break;
				case 2:
					localizeId = 2261;
					localizeId2 = 2268;
					break;
				}
			}
			else if (raidTypeData.raidType == 3)
			{
				localizeId = 2262;
				localizeId2 = 2269;
			}
			else if (raidTypeData.raidType == 8)
			{
				localizeId = 2264;
				localizeId2 = 2270;
			}
			else if (raidTypeData.raidType == 6)
			{
				localizeId = 2262;
				localizeId2 = 2272;
			}
			else if (raidTypeData.raidType == 5)
			{
				localizeId = 2265;
				localizeId2 = 2271;
			}
		}
		else if (MonoECS.instance.sceneStatus == SceneStatus.Temple)
		{
			localizeId = 2265;
			localizeId2 = 2271;
		}
		else if (MonoECS.instance.sceneStatus == SceneStatus.Abyss)
		{
			localizeId = 2261;
			localizeId2 = 2269;
		}
		Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizeId);
		Description.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizeId2);
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		OnClose();
	}

	private async void OnClose()
	{
		await UniTask.DelayFrame(10);
		Close();
		if (raidOpeningPerformanceData != null)
		{
			raidOpeningPerformanceData.OnCloseHandle?.Invoke();
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
		}
	}
}
