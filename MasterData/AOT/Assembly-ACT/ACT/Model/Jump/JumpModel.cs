using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Model.Jump;

public class JumpModel : Model<JumpModel>
{
	public static readonly Dictionary<int, (int, LuminModelType)> UIJumpIdToUITypeMap = new Dictionary<int, (int, LuminModelType)>
	{
		{
			1,
			(28, LuminModelType.CharacterView)
		},
		{
			2,
			(189, LuminModelType.Activities)
		},
		{
			3,
			(186, LuminModelType.Activities)
		},
		{
			4,
			(169, LuminModelType.Gacha)
		},
		{
			5,
			(269, LuminModelType.Shops)
		},
		{
			6,
			(4, LuminModelType.AbyssLayers)
		},
		{
			7,
			(67, LuminModelType.HandBook)
		},
		{
			8,
			(328, LuminModelType.Missions)
		},
		{
			9,
			(77, LuminModelType.Raids)
		},
		{
			10,
			(200, LuminModelType.Team)
		},
		{
			11,
			(163, LuminModelType.Raids)
		},
		{
			12,
			(100, LuminModelType.Map)
		},
		{
			13,
			(158, LuminModelType.Equipment)
		},
		{
			15,
			(256, LuminModelType.RogueLike)
		},
		{
			16,
			(64, LuminModelType.Compose)
		},
		{
			17,
			(13, LuminModelType.Inventory)
		},
		{
			18,
			(248, LuminModelType.BattlePass)
		},
		{
			19,
			(181, LuminModelType.BloodBottle)
		},
		{
			20,
			(226, LuminModelType.WorldLevel)
		},
		{
			21,
			(302, LuminModelType.Training)
		}
	};

	public static readonly Dictionary<UI_TYPE, int> UITypeToUIJumpIdMap = new Dictionary<UI_TYPE, int>();

	private Dictionary<LuminModelType, IJumpable> _jumpables;

	protected override void Init()
	{
		_jumpables = DictionaryPool<LuminModelType, IJumpable>.Get();
		foreach (KeyValuePair<ContextType, List<IContext>> readOnlyContext in ContextManager.ReadOnlyContexts)
		{
			foreach (IContext item in readOnlyContext.Value)
			{
				OnContextAdd(item);
			}
		}
		ContextManager.OnContextAdd = (Action<IContext>)Delegate.Combine(ContextManager.OnContextAdd, new Action<IContext>(OnContextAdd));
		ContextManager.OnContextRemove = (Action<IContext>)Delegate.Combine(ContextManager.OnContextRemove, new Action<IContext>(OnContextRemove));
		UITypeToUIJumpIdMap.Clear();
		foreach (KeyValuePair<int, (int, LuminModelType)> item2 in UIJumpIdToUITypeMap)
		{
			UITypeToUIJumpIdMap[(UI_TYPE)item2.Value.Item1] = item2.Key;
		}
	}

	protected override void UnInit()
	{
		ContextManager.OnContextAdd = (Action<IContext>)Delegate.Remove(ContextManager.OnContextAdd, new Action<IContext>(OnContextAdd));
		ContextManager.OnContextRemove = (Action<IContext>)Delegate.Remove(ContextManager.OnContextRemove, new Action<IContext>(OnContextRemove));
		DictionaryPool<LuminModelType, IJumpable>.Release(_jumpables);
		_jumpables = null;
	}

	private void OnContextAdd(IContext context)
	{
		if (_jumpables != null && context is IJumpable jumpable)
		{
			_jumpables[jumpable.JumpSourceType] = jumpable;
		}
	}

	private void OnContextRemove(IContext context)
	{
		if (_jumpables != null && context is IJumpable jumpable)
		{
			_jumpables.Remove(jumpable.JumpSourceType);
		}
	}

	public static bool IsCurrentWorldChallangeNormal()
	{
		if (MonoECS.instance == null || !MonoECS.instance.IsNotInMain)
		{
			return false;
		}
		WorldBase currentWorld = Singleton<GameManager>.instance.worldManager.GetCurrentWorld();
		if (currentWorld != null)
		{
			return currentWorld.WorldChallengeState == WorldChallengeState.Normal;
		}
		return false;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (_jumpables == null)
		{
			return default;
		}
		try
		{
			if (_jumpables.TryGetValue(jumpData.ModelType, out var value))
			{
				return value.CanJump(jumpData);
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		return UnManagedCanJump(jumpData);
	}

	public void JumpTo(RuntimeJumpData jumpData)
	{
		if (_jumpables == null)
		{
			return;
		}
		try
		{
			if (_jumpables.TryGetValue(jumpData.ModelType, out var value))
			{
				value.Jump(jumpData);
			}
			else
			{
				UnManagedJumpTo(jumpData);
			}
			TrackJump(jumpData);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			UnManagedJumpTo(jumpData);
		}
	}

	private JumpResult UnManagedCanJump(RuntimeJumpData jumpData)
	{
		try
		{
			if (jumpData.JumpType == 1)
			{
				StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(jumpData.Params[0]);
				if (worldStateAssetDataBySGOID is PortalData)
				{
					if (worldStateAssetDataBySGOID.stateId == -2)
					{
						return new JumpResult
						{
							ShowType = JumpResult.JumpShowType.CanJump
						};
					}
					return new JumpResult
					{
						ShowType = JumpResult.JumpShowType.Forbidden
					};
				}
			}
			else if (jumpData.JumpType == 2)
			{
				if (Singleton<NewUIManager>.instance.GetTopActivePanel().UIType == (UI_TYPE)UIJumpIdToUITypeMap[jumpData.Params[0]].Item1)
				{
					return new JumpResult
					{
						ShowType = JumpResult.JumpShowType.Forbidden,
						Message = LocalizationUtility.GetLocalizeString("Common", 2171)
					};
				}
				string message = string.Empty;
				if (jumpData.NavigationID != 0)
				{
					ItemNavigation data = CoreUtils.GetData(jumpData.NavigationID, RuntimeConfigs.data.ItemNavigations);
					if (data != null)
					{
						message = LocalizationUtility.GetLocalizeString("shortcommon", data.jumpText);
					}
				}
				return new JumpResult
				{
					ShowType = JumpResult.JumpShowType.CanJump,
					Message = message
				};
			}
			return new JumpResult
			{
				ShowType = jumpData.Result.ShowType
			};
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Hide
			};
		}
	}

	private void UnManagedJumpTo(RuntimeJumpData jumpData)
	{
		switch (jumpData.JumpType)
		{
		case 1:
		{
			int num = jumpData.Params[0];
			if ((uint)(num - 1) <= 1u)
			{
				int swid = jumpData.Params[0];
				StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(swid);
				TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
				evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
				evt.targetPosition = ((PortalData)worldStateAssetDataBySGOID).SitPos;
				EventTrackSolver.Instance.Dispatch(evt);
				TeleportUtility.TeleportWithInteractObject(worldStateAssetDataBySGOID).Forget();
				if (MPPlayer.local.CurrentActiveBattlePotionId != 0)
				{
					Singleton<BloodBottleHandler>.instance.RecoverItems();
					Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(MPPlayer.local.CurrentActiveBattlePotionId);
				}
			}
			break;
		}
		case 2:
		{
			object obj = null;
			UI_TYPE item = (UI_TYPE)UIJumpIdToUITypeMap[jumpData.Params[0]].Item1;
			obj = item switch
			{
				UI_TYPE.UI_CHARACTER => (object)new CharacterViewData
				{
					defaultCharacterId = jumpData.Params[1],
					PageIndex = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0)
				}, 
				UI_TYPE.UI_TEMPLEENTRANCE => new TempleEntranceViewData
				{
					templeId = jumpData.Params[1]
				}, 
				UI_TYPE.UI_LARGEMAP => new LargeMapViewData
				{
					wantTrackMonsterPointId = jumpData.Params[1]
				}, 
				UI_TYPE.UI_SHOP => new ShopViewData
				{
					FirstTabID = ((jumpData.Params.Count > 1) ? jumpData.Params[1] : 0),
					SecondTabID = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0)
				}, 
				UI_TYPE.UI_CARDDRAW => null, 
				UI_TYPE.UI_ABYSSLIST => new MonoAbyssListData
				{
					IsOpenAbyssTeamPanel = true,
					AbyssType = (AbyssType)jumpData.Params[1],
					AbyssId = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0)
				}, 
				UI_TYPE.UI_HANDBOOK => new HandBookViewParam
				{
					H1TabIndex = jumpData.Params[1],
					H2TabIndex = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0),
					WildBossUseId = ((jumpData.Params.Count > 3) ? jumpData.Params[3] : 0)
				}, 
				UI_TYPE.UI_TASK => new TaskViewV3Data
				{
					missionId = jumpData.Params[1]
				}, 
				UI_TYPE.UI_RAID => new MonoRaidViewData
				{
					RaidEntranceId = jumpData.Params[1]
				}, 
				UI_TYPE.UI_ACTIVITYCENTER => new ActivityCenterViewData
				{
					ActivityId = jumpData.Params[1]
				}, 
				UI_TYPE.UI_BAGPANEL => new MonoInventoryData
				{
					inventoryTab = (InventoryTab)jumpData.Params[1]
				}, 
				_ => null, 
			};
			Singleton<NewUIManager>.instance.OpenUI(item, obj);
			break;
		}
		default:
			throw new ArgumentOutOfRangeException($"Unknown jump type: {jumpData.JumpType}");
		}
	}

	private void TrackJump(RuntimeJumpData jumpData)
	{
		if (jumpData.ItemID != 0)
		{
			ItemObtainJumpEvent evt = EventTrackSolver.Instance.GetEvt<ItemObtainJumpEvent>();
			evt.itemId = jumpData.ItemID;
			evt.systemId = (int)jumpData.FromSystem;
			evt.toSystemId = (int)LuminModelType2SystemType(jumpData.ModelType);
			evt.jumpType = (int)jumpData.ModelType;
			evt.jumpId = GetJumpDetailId(jumpData);
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	private static SystemType LuminModelType2SystemType(LuminModelType luminModelType)
	{
		switch (luminModelType)
		{
		case LuminModelType.CollectionPoints:
		case LuminModelType.MonsterType:
			return SystemType.MapUnLock;
		case LuminModelType.AbyssLayers:
			return SystemType.Abyss;
		case LuminModelType.Raids:
			return SystemType.Raid;
		case LuminModelType.Temples:
			return SystemType.Temple;
		case LuminModelType.Shops:
			return SystemType.Shop;
		case LuminModelType.Missions:
			return SystemType.Mission;
		case LuminModelType.Compose:
			return SystemType.Craft;
		case LuminModelType.Gacha:
			return SystemType.DrawCard;
		case LuminModelType.AbyssConstantStar:
		case LuminModelType.AbyssCycleStar:
			return SystemType.Abyss;
		case LuminModelType.TempleStar:
			return SystemType.Temple;
		case LuminModelType.Activities:
			return SystemType.Activity;
		case LuminModelType.HandBook:
			return SystemType.HandBook;
		case LuminModelType.Team:
			return SystemType.Team;
		case LuminModelType.Map:
			return SystemType.MapUnLock;
		case LuminModelType.CharacterView:
			return SystemType.CharacterView;
		case LuminModelType.Equipment:
			return SystemType.Equip;
		case LuminModelType.BloodBottle:
			return SystemType.BloodBottleCultivate;
		case LuminModelType.RogueLike:
			return SystemType.Rogue;
		case LuminModelType.Inventory:
			return SystemType.Bag;
		case LuminModelType.BattlePass:
			return SystemType.BattlePass;
		case LuminModelType.WorldLevel:
			return SystemType.SystemGuide;
		case LuminModelType.Unmanaged:
			return SystemType.None;
		default:
			return SystemType.None;
		}
	}

	private static int GetJumpDetailId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		int result = 0;
		switch (jumpData.ModelType)
		{
		case LuminModelType.Temples:
		case LuminModelType.AbyssLayers:
		case LuminModelType.Shops:
		case LuminModelType.Missions:
		case LuminModelType.CollectionPoints:
		case LuminModelType.MonsterType:
			if (list.Count >= 3)
			{
				result = list[2];
			}
			break;
		case LuminModelType.Raids:
			if (list.Count >= 2)
			{
				result = list[1];
			}
			break;
		case LuminModelType.Compose:
			if (list.Count >= 3)
			{
				result = list[0];
			}
			break;
		case LuminModelType.Gacha:
			if (list.Count >= 3)
			{
				result = list[2];
			}
			break;
		case LuminModelType.Activities:
			if (list.Count >= 3)
			{
				result = list[2];
			}
			break;
		case LuminModelType.HandBook:
			if (list.Count >= 2)
			{
				result = list[1];
			}
			break;
		}
		return result;
	}
}
