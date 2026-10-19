using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ItemSource : BaseUIComponent
{
	private const int InventoryBagChestTabId = 6;

	public GameObject jumpRoot;

	public GameObject lockRoot;

	public GameObject textRoot;

	public LocalizeStringEvent textSourceNameLocalize;

	public ActButton btn;

	private int[] _param;

	private JumpResult _jumpResult;

	public Action OnJump { get; set; }

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		ReleaseJumpResult();
		OnJump = null;
	}

	public void ReleaseJumpResult()
	{
		_jumpResult.Release();
		_jumpResult = default;
	}

	public void Init(RuntimeJumpData jumpData)
	{
		ReleaseJumpResult();
		_jumpResult = jumpData.Result;
		if (jumpData.Result.ShowType == JumpResult.JumpShowType.OnlyText)
		{
			ResetRoot(textRoot);
			btn.OnClick.RemoveAllListeners();
		}
		else if (jumpData.Result.ShowType == JumpResult.JumpShowType.CanJump)
		{
			ResetRoot(jumpRoot);
			btn.OnClick.RemoveAllListeners();
			btn.OnClick.AddListener(() =>
			{
				Model<JumpModel>.Interface.JumpTo(jumpData);
				OnJump?.Invoke();
			});
		}
		else if (jumpData.Result.ShowType == JumpResult.JumpShowType.Forbidden)
		{
			ResetRoot(lockRoot);
			btn.OnClick.RemoveAllListeners();
			btn.OnClick.AddListener(() =>
			{
				GameUtility.OpenJumpResultTips(_jumpResult);
			});
		}
		GenTextByJumpType(jumpData);
	}

	private void GenTextByJumpType(RuntimeJumpData jumpData)
	{
		if (jumpData.NavigationID != 0)
		{
			ItemNavigation data = CoreUtils.GetData(jumpData.NavigationID, RuntimeConfigs.data.ItemNavigations);
			textSourceNameLocalize.SetTable("shortcommon");
			textSourceNameLocalize.StringReference.TableEntryReference = data.jumpText;
			return;
		}
		switch (jumpData.ModelType)
		{
		default:
			_ = 999;
			break;
		case LuminModelType.Raids:
		{
			RaidEntranceData data4 = CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.raidEntranceDatas);
			if (data4 != null)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				textSourceNameLocalize.StringReference.TableEntryReference = data4.entranceName;
			}
			break;
		}
		case LuminModelType.Temples:
			textSourceNameLocalize.SetTable("Common");
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Temple;
			break;
		case LuminModelType.AbyssLayers:
			textSourceNameLocalize.SetTable("Common");
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.AbyssStartReward;
			break;
		case LuminModelType.Shops:
		{
			SubshopData data10 = CoreUtils.GetData(GetJumpSubShopId(jumpData), RuntimeConfigs.data.subshopDatas);
			textSourceNameLocalize.SetTable("shortcommon");
			if (data10 != null)
			{
				textSourceNameLocalize.StringReference.TableEntryReference = data10.nameLocal;
				break;
			}
			ShopData data11 = CoreUtils.GetData(GetJumpShopId(jumpData), RuntimeConfigs.data.shopDatas);
			if (data11 != null)
			{
				textSourceNameLocalize.StringReference.TableEntryReference = data11.nameLocal;
			}
			break;
		}
		case LuminModelType.Missions:
		{
			MissionBase data7 = CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.missionBases);
			if (data7 != null)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				textSourceNameLocalize.StringReference.TableEntryReference = data7.name;
			}
			break;
		}
		case LuminModelType.MonsterType:
		{
			EntityData data5 = CoreUtils.GetData(jumpData.Params[2], RuntimeConfigs.data.entityDatas);
			if (data5 != null)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				textSourceNameLocalize.StringReference.TableEntryReference = data5.nameLocal;
			}
			break;
		}
		case LuminModelType.CollectionPoints:
		{
			CollectionPoint data12 = CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.collectionPoints);
			if (data12 != null)
			{
				string localizeString = LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Goto);
				string localizeString2 = LocalizationUtility.GetLocalizeString("shortcommon", data12.pointName);
				textSourceNameLocalize.OnUpdateString?.Invoke(localizeString + localizeString2);
			}
			break;
		}
		case LuminModelType.Compose:
			textSourceNameLocalize.SetTable("Common");
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Compose;
			break;
		case LuminModelType.Gacha:
		{
			Gacha data9 = CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.gachas);
			if (data9 != null)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				textSourceNameLocalize.StringReference.TableEntryReference = data9.gachaName;
			}
			break;
		}
		case LuminModelType.AbyssConstantStar:
			textSourceNameLocalize.SetTable("Common");
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.AbyssConstantReward;
			break;
		case LuminModelType.AbyssCycleStar:
			textSourceNameLocalize.SetTable("Common");
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.AbyssStartReward;
			break;
		case LuminModelType.TempleStar:
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NeedBreakLevel;
			break;
		case LuminModelType.Activities:
		{
			ActivityData data8 = CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.activityDatas);
			if (data8 != null)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				textSourceNameLocalize.StringReference.TableEntryReference = data8.activityName;
			}
			break;
		}
		case LuminModelType.HandBook:
			textSourceNameLocalize.SetTable("shortcommon");
			if (!TrySetWildBossMonsterName(jumpData))
			{
				HandBookMain data6 = CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.handBookMains);
				if (data6 != null)
				{
					textSourceNameLocalize.StringReference.TableEntryReference = data6.contentLv1name;
				}
			}
			break;
		case LuminModelType.Team:
			textSourceNameLocalize.SetTable("Common");
			textSourceNameLocalize.StringReference.TableEntryReference = LocalizationCommonData.CommonString.TeamSelect;
			break;
		case LuminModelType.Inventory:
			if (jumpData.Params[1] == 6)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				ItemData data3 = CoreUtils.GetData(jumpData.Params[2], RuntimeConfigs.data.itemDatas);
				if (data3 != null)
				{
					textSourceNameLocalize.StringReference.TableEntryReference = data3.nameLocal;
				}
			}
			break;
		case LuminModelType.BattlePass:
		{
			BattlePass data2 = CoreUtils.GetData(Model<BattlePassModel>.Interface.CurBattlePassId, RuntimeConfigs.data.battlePasss);
			if (data2 != null)
			{
				textSourceNameLocalize.SetTable("shortcommon");
				textSourceNameLocalize.StringReference.TableEntryReference = data2.nameLocal;
			}
			break;
		}
		case LuminModelType.Map:
		case LuminModelType.CharacterView:
		case LuminModelType.Equipment:
		case LuminModelType.BloodBottle:
		case LuminModelType.RogueLike:
			break;
		}
	}

	private bool TrySetWildBossMonsterName(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count <= 3)
		{
			return false;
		}
		int num = jumpData.Params[3];
		if (num == 0)
		{
			return false;
		}
		WildBossUse data = CoreUtils.GetData(num, RuntimeConfigs.data.wildBossUses);
		if (data == null)
		{
			return false;
		}
		EnemySpawn data2 = CoreUtils.GetData(data.monsterID, RuntimeConfigs.data.enemySpawns);
		List<Maybe> list2 = data2?.enemy;
		if (list2 == null || list2.Count <= 0)
		{
			return false;
		}
		EntityData data3 = CoreUtils.GetData(data2.enemy[0].id, RuntimeConfigs.data.entityDatas);
		if (data3 == null)
		{
			return false;
		}
		textSourceNameLocalize.StringReference.TableEntryReference = data3.nameLocal;
		return true;
	}

	private static int GetJumpShopId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count <= 1)
		{
			return 0;
		}
		return jumpData.Params[1];
	}

	private static int GetJumpSubShopId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count <= 1)
		{
			return 0;
		}
		if (jumpData.Params.Count <= 2)
		{
			return jumpData.Params[1];
		}
		return jumpData.Params[2];
	}

	private void ResetRoot(GameObject openRoot)
	{
		jumpRoot.SetActive(value: false);
		lockRoot.SetActive(value: false);
		textRoot.SetActive(value: true);
		textSourceNameLocalize.SetTable("shortcommon");
		openRoot.SetActive(value: true);
	}
}
