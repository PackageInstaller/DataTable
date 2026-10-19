using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using Pb;
using Runtime.Model;
using UnityEngine;

namespace ACT.DebugGUI;

public class Test : SingleMonitor
{
	public bool isUnlockTrainingGround;

	private DebugGUITextField year;

	private DebugGUITextField month;

	private DebugGUITextField day;

	private DebugGUITextField hour;

	private DebugGUITextField itemId;

	private DebugGUITextField itemCount;

	private DebugGUITextField ShopitemId;

	private DebugGUITextField tipSafeTime;

	private DebugGUITextField triggerTutorialId;

	private DebugGUITextField triggerTutorialType;

	private DebugGUITextField triggerGuideId;

	private DebugGUITextField gmAddAbilityName;

	private DebugGUITextField gmRemoveAbilityName;

	private DebugGUITextField AddRogueItemId;

	private DebugGUITextField RemoveRogueItemId;

	private DebugGUITextField RogueSeedId;

	private DebugGUITextField RogueGameWorldId;

	private DebugGUITextField GmGachaOnce;

	private DebugGUITextField GmGachaPoolId;

	private DebugGUITextField GmGachaTen;

	private DebugGUITextField characterItemId;

	private DebugGUITextField LoungeStoryId;

	private DebugGUITextField LoungeCharacterId;

	private DebugGUITextField LoungePointId;

	private DebugGUITextField sessionId;

	private DebugGUITextField propertyId;

	private DebugGUITextField proChangeValue;

	private DebugGUITextField systemSourceId;

	private DebugGUITextField readableId;

	protected override bool OnInit()
	{
		sigwnd.AddGUI(new DebugGUIButton("红点测试", () =>
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.CharacterOver, active: true);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.CharacterEquipment, active: true);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.CharacterSkill, active: true);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.CharacterElite, active: true);
		}));
		sigwnd.AddGUI(new DebugGUIButton("输出当前所有已注册红点树到日志", () =>
		{
			Singleton<RedDotManager>.instance.LogRegisteredRedDotsTree();
		}));
		gmAddAbilityName = new DebugGUITextField("添加Ability");
		sigwnd.AddGUI(gmAddAbilityName);
		sigwnd.AddGUI(new DebugGUIButton("添加Ability", () =>
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			mainEntity.GetCompAbility().AddAbility(mainEntity, gmAddAbilityName.text, AbilitySource.GM, default, 1);
		}));
		gmRemoveAbilityName = new DebugGUITextField("移除Ability");
		sigwnd.AddGUI(gmRemoveAbilityName);
		sigwnd.AddGUI(new DebugGUIButton("移除Ability", () =>
		{
			MonoECS.instance.mainEntity.GetCompAbility().RemoveAbility(gmRemoveAbilityName.text);
		}));
		sigwnd.AddGUI(new DebugGUIButton("进入肉鸽选关!", () =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEENTRANCE);
		}));
		AddRogueItemId = new DebugGUITextField("肉鸽添加道具");
		sigwnd.AddGUI(AddRogueItemId);
		sigwnd.AddGUI(new DebugGUIButton("肉鸽添加道具", () =>
		{
			Model<RogueNewModel>.Interface.SendRogueGmBuyItem(int.Parse(AddRogueItemId.text), null);
		}));
		RemoveRogueItemId = new DebugGUITextField("肉鸽回收道具");
		sigwnd.AddGUI(RemoveRogueItemId);
		sigwnd.AddGUI(new DebugGUIButton("肉鸽回收道具", () =>
		{
			Model<RogueNewModel>.Interface.SendOnRecycleItem(int.Parse(RemoveRogueItemId.text), null);
		}));
		sigwnd.AddGUI(new DebugGUIButton("输出当前rogue种子id", () =>
		{
			if (LuminApplication.LogEnabled)
			{
				if (Model<RogueNewModel>.Interface.Info != null)
				{
					Debug.Log($"当前rogue种子id: {Model<RogueNewModel>.Interface.Info.GameInfo.Seed}");
				}
				else
				{
					Debug.Log("当前没有rogue数据");
				}
			}
		}));
		RogueSeedId = new DebugGUITextField("肉鸽种子id");
		sigwnd.AddGUI(RogueSeedId);
		sigwnd.AddGUI(new DebugGUIButton("使用种子id挑战rogue", () =>
		{
			long num = long.Parse(RogueSeedId.text);
			if (num > 0)
			{
				Model<RogueNewModel>.Interface.SendRogueChallenge(num);
			}
		}));
		RogueGameWorldId = new DebugGUITextField("肉鸽Gameworldid");
		sigwnd.AddGUI(RogueGameWorldId);
		sigwnd.AddGUI(new DebugGUIButton("使用GameWorld进入rogue场景", () =>
		{
			int num = int.Parse(RogueGameWorldId.text);
			if (num > 0)
			{
				Model<RogueNewModel>.Interface.SendRogueEnterRoom(num);
			}
		}));
		GmGachaPoolId = new DebugGUITextField("卡池id");
		sigwnd.AddGUI(GmGachaPoolId);
		GmGachaOnce = new DebugGUITextField("卡池单抽");
		sigwnd.AddGUI(GmGachaOnce);
		sigwnd.AddGUI(new DebugGUIButton("1连N次", () =>
		{
			int times = int.Parse(GmGachaOnce.text);
			int gachaId = int.Parse(GmGachaPoolId.text);
			NarmalDrawCard(times, gachaId, isten: false);
		}));
		GmGachaTen = new DebugGUITextField("卡池十连");
		sigwnd.AddGUI(GmGachaTen);
		sigwnd.AddGUI(new DebugGUIButton("十连连N次", () =>
		{
			int times = int.Parse(GmGachaTen.text);
			int gachaId = int.Parse(GmGachaPoolId.text);
			NarmalDrawCard(times, gachaId, isten: true);
		}));
		characterItemId = new DebugGUITextField("角色道具Id(逗号分隔)");
		sigwnd.AddGUI(characterItemId);
		sigwnd.AddGUI(new DebugGUIButton("测试角色演出", () =>
		{
			string[] array = characterItemId.text.Split(',', '，');
			List<UniversalItem> list = new List<UniversalItem>();
			string[] array2 = array;
			foreach (string text in array2)
			{
				if (!int.TryParse(text.Trim(), out var result))
				{
					Debug.LogError("角色道具Id无效: " + text);
					return;
				}
				list.Add(new UniversalItem
				{
					Type = UniversalItemType.UniversalItemCharacter,
					Index = result,
					Count = 1,
					IsNew = true
				});
			}
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW, new CommonAcquireCharacterShowData
			{
				universalItems = list
			});
		}));
		sigwnd.AddGUI(new DebugGUIButton("训练场菜单替换成完整版", () =>
		{
			Model<TrainingGroundModel>.Interface.useUnlockSystem = true;
		}));
		sigwnd.AddGUI(new DebugGUIButton("肉鸽选卡!", () =>
		{
			if (Model<RoGueModel>.Interface != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUESELECTCARD);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("肉鸽选神器!", () =>
		{
			if (Model<RoGueModel>.Interface != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUESELECTARTIFACT);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("肉鸽合成!", () =>
		{
			if (Model<RoGueModel>.Interface != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUECARDSYNTHESIZE);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("重置月卡状态!", () =>
		{
			Model<ShopModel>.Interface.TestMonthyRest();
		}));
		sigwnd.AddGUI(new DebugGUIButton("打开月卡!", () =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONTHCARDREWARD, new MonthCardRewardViewData
			{
				monthlyPassId = 1100001
			});
		}));
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		year = new DebugGUITextField("year", GameUtility.year.ToString());
		month = new DebugGUITextField("month", GameUtility.month.ToString());
		day = new DebugGUITextField("day", GameUtility.day.ToString());
		hour = new DebugGUITextField("hour", GameUtility.hour.ToString());
		sigwnd.AddGUI(year);
		sigwnd.AddGUI(month);
		sigwnd.AddGUI(day);
		sigwnd.AddGUI(hour);
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("应用当前日期", () =>
		{
			GameUtility.dateMode = DateMode.System;
			if (G.service is NetGameService)
			{
				GmActionProcessReq data = new GmActionProcessReq
				{
					Cmd = "cancelActiontime"
				};
				Singleton<NetManager>.instance.Post(data);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("应用测试日期", () =>
		{
			GameUtility.dateMode = DateMode.Debug;
			GameUtility.year = int.Parse(year.text);
			GameUtility.month = int.Parse(month.text);
			GameUtility.day = int.Parse(day.text);
			GameUtility.hour = int.Parse(hour.text);
			if (G.service is NetGameService)
			{
				GmActionProcessReq data = new GmActionProcessReq
				{
					Cmd = $"actiontime {GameUtility.CovertDateTimeToInt(GameUtility.UtcNow)}"
				};
				Singleton<NetManager>.instance.Post(data);
			}
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		ShopitemId = new DebugGUITextField("商店ItemId");
		sigwnd.AddGUI(ShopitemId);
		sigwnd.AddGUI(new DebugGUIButton("购买商店物品", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = "buy_goods {\"Int\":" + ShopitemId.text + "}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		LoungeStoryId = new DebugGUITextField("后宅剧情id");
		LoungePointId = new DebugGUITextField("后宅位点");
		LoungeCharacterId = new DebugGUITextField("后宅角色id");
		sigwnd.AddGUI(LoungeStoryId);
		sigwnd.AddGUI(LoungePointId);
		sigwnd.AddGUI(LoungeCharacterId);
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("布置全局剧情(只填后宅剧情id)", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = "set_lounge_story {\"story_id\":" + LoungeStoryId.text + "}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("重置指定点位(填0表示重置全部)", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = "reset_lounge_point {\"point_id\":" + LoungePointId.text + "}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("布置角色个人剧情(全填)", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = "set_lounge_story {\"character_id\":" + LoungeCharacterId.text + ",\"point_id\":" + LoungePointId.text + ",\"story_id\":" + LoungeStoryId.text + "}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sessionId = new DebugGUITextField("特定短信Id");
		sigwnd.AddGUI(sessionId);
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("发送特定短信", () =>
		{
			if (sessionId.text != string.Empty)
			{
				GmActionProcessReq data = new GmActionProcessReq
				{
					Cmd = "send_contact_session {\"sessionId\":" + sessionId.text + "}"
				};
				Singleton<NetManager>.instance.Post(data);
			}
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("发送特定短信并打开界面", () =>
		{
			if (sessionId.text != string.Empty)
			{
				GmActionProcessReq data = new GmActionProcessReq
				{
					Cmd = "send_contact_session_open_ui {\"sessionId\":" + sessionId.text + "}"
				};
				Singleton<NetManager>.instance.Post(data);
			}
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("发送全部短信", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = "send_all_contact_sessions {}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		sigwnd.AddGUI(new DebugGUIButton("刷新每日短信", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = "refresh_daily_contact_session {}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		sigwnd.AddGUI(new DebugGUIBeginHorizontal());
		itemId = new DebugGUITextField("itemId");
		itemCount = new DebugGUITextField("itemCount");
		sigwnd.AddGUI(itemId);
		sigwnd.AddGUI(itemCount);
		sigwnd.AddGUI(new DebugGUIButton("Add Item", () =>
		{
			if (G.service is NetGameService)
			{
				GmActionProcessReq data = new GmActionProcessReq
				{
					Cmd = $"additem {int.Parse(itemId.text)} {int.Parse(itemCount.text)}"
				};
				Singleton<NetManager>.instance.Post(data);
				PropPickingUtility.DispatchPropPickingEvt(new List<Item>
				{
					new Item
					{
						Id = int.Parse(itemId.text),
						Count = int.Parse(itemCount.text)
					}
				}, PropPickingWay.Normal);
			}
			if (G.service is LocalGameService)
			{
				ItemNtf itemNtf = new ItemNtf
				{
					Changes = 
					{
						new Item
						{
							Id = int.Parse(itemId.text),
							Count = int.Parse(itemCount.text)
						}
					}
				};
				CoreUtils.DeltaItemNtfToItemNtf(itemNtf);
				Singleton<NetManager>.instance.LocalDispatch(3200, itemNtf);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("Sub Item", () =>
		{
			GmActionProcessReq data = new GmActionProcessReq
			{
				Cmd = $"subitem {int.Parse(itemId.text)} {int.Parse(itemCount.text)}"
			};
			Singleton<NetManager>.instance.Post(data);
		}));
		sigwnd.AddGUI(new DebugGUIButton("Change to enemy", () =>
		{
			MonoECS.instance.localPlayer.ChangeToEnemyServerRpc();
		}));
		sigwnd.AddGUI(new DebugGUIEndHorizontal());
		if (DebugWindowManager.instance.TestGos == null)
		{
			return false;
		}
		foreach (GameObject testGo in DebugWindowManager.instance.TestGos)
		{
			if (!(testGo == null))
			{
				sigwnd.AddGUI(new DebugGUIButton("switchActive->" + testGo.name, () =>
				{
					testGo.SetActive(!testGo.activeInHierarchy);
				}));
			}
		}
		sigwnd.AddGUI(new DebugGUIButton("Draw SafeArea", () =>
		{
			DebugWindowManager.instance.drawSafeArea = !DebugWindowManager.instance.drawSafeArea;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(Singleton<NewUIManager>.instance.ConfigSafeArea.safeArea);
			}
		}));
		sigwnd.AddGUI(new DebugGUIButton("PushPause", () =>
		{
			MonoECS.instance.PushPause();
		}));
		sigwnd.AddGUI(new DebugGUIButton("PopPause", () =>
		{
			MonoECS.instance.PopPause();
		}));
		triggerTutorialId = new DebugGUITextField("触发教程Id");
		triggerTutorialType = new DebugGUITextField("触发教程方式 ，1 是倒计时，2 是图文引导");
		sigwnd.AddGUI(triggerTutorialId);
		sigwnd.AddGUI(triggerTutorialType);
		sigwnd.AddGUI(new DebugGUIButton("触发教程", () =>
		{
			int tutorialId = int.Parse(triggerTutorialId.text);
			int tutorialType = int.Parse(triggerTutorialType.text);
			if (Model<TutorialModel>.HasInstance() && Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialId) && CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials) != null)
			{
				G.service.TriggerTutorial(tutorialId, (bool b) =>
				{
					if (b)
					{
						switch (tutorialType)
						{
						case 1:
						{
							TriggerGuideTutorial evt = Singleton<EventManager>.instance.GetEvt<TriggerGuideTutorial>();
							evt.triggerTutorialId = tutorialId;
							evt.duration = 5f;
							Singleton<EventManager>.instance.EventDispatch(ClientEvent.Trigger_Tutorial, evt);
							Singleton<EventManager>.instance.ReleaseEvt(evt);
							break;
						}
						case 2:
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
							{
								tutorialId = tutorialId
							});
							break;
						}
					}
				});
			}
		}));
		triggerGuideId = new DebugGUITextField("触发 Guide Id");
		sigwnd.AddGUI(triggerGuideId);
		sigwnd.AddGUI(new DebugGUIButton("触发Guide", () =>
		{
			Model<GuideModel>.Interface.StartGuide(int.Parse(triggerGuideId.text), isGm: true);
		}));
		sigwnd.AddGUI(new DebugGUIButton("触发多个Guide", () =>
		{
			Model<GuideModel>.Interface.StartGuide(31015, isGm: true);
			Model<GuideModel>.Interface.StartGuide(100700, isGm: true);
			Model<GuideModel>.Interface.StartGuide(31016, isGm: true);
		}));
		sigwnd.AddGUI(new DebugGUIButton("关闭输入", () =>
		{
			Singleton<GameInputActionManager>.instance.SetActive(active: false);
		}));
		sigwnd.AddGUI(new DebugGUIButton("开启输入", () =>
		{
			Singleton<GameInputActionManager>.instance.SetActive(active: true);
		}));
		sigwnd.AddGUI(new DebugGUIButton("打开神瞳养成", () =>
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_DIVINEEYE, null, isneedinqueue: false);
		}));
		readableId = new DebugGUITextField("可阅读物id");
		sigwnd.AddGUI(readableId);
		sigwnd.AddGUI(new DebugGUIButton("打开可阅读物View", () =>
		{
			ReadableViewData uiData = new ReadableViewData
			{
				id = int.Parse(readableId.text)
			};
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_READABLE, uiData);
		}));
		return true;
	}

	private void NarmalDrawCard(int times, int GachaId, bool isten)
	{
		GachaPoolEffectiveInfo gachaEffectiveInfo = Model<CardDrawModel>.Interface.GetGachaEffectiveInfo(GachaId);
		if (gachaEffectiveInfo == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"gachaid: {GachaId}，GachaEffectiveInfo没有当前卡池信息");
			}
			return;
		}
		int id = CoreUtils.GetData(GachaId, RuntimeConfigs.data.gachas).token[0].id;
		if (TimeManager.IsInTimeRange(gachaEffectiveInfo.BeginTimestamp, gachaEffectiveInfo.EndTimestamp, isMilliseconds: false))
		{
			int num = (isten ? (times * 10) : times);
			if (CheckItemEnough(num, id))
			{
				int count = ((!isten) ? 1 : 10);
				for (int i = 0; i < times; i++)
				{
					Model<CardDrawModel>.Interface.SendGachaCardDraw(GachaId, count);
				}
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"本次总计抽卡次数:{num}");
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("道具不足");
			}
		}
		else
		{
			GameUtility.OpenToolTip(1767);
		}
	}

	private bool CheckItemEnough(int neednum, int currentNeedItemId)
	{
		return G.localPlayer.GetCountById(currentNeedItemId) >= neednum;
	}

	public override void OnUpdate()
	{
		Singleton<NetManager>.instance.LogTransportDebugInfo();
	}
}
