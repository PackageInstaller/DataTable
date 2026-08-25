local System = require("System.System")
local readonly = System.readonly
local LanguageConfig = readonly({
  ActorString_Sort_Ascend = {
    ID = "ActorString_Sort_Ascend",
    CN = "LanguageConfig_ActorString_Sort_Ascend_CN|升序"
  },
  ActorString_Sort_Descend = {
    ID = "ActorString_Sort_Descend",
    CN = "LanguageConfig_ActorString_Sort_Descend_CN|降序"
  },
  Battle_Begin_CHN = {
    ID = "Battle_Begin_CHN",
    CN = "LanguageConfig_Battle_Begin_CHN_CN|战斗开始"
  },
  Battle_Begin_Boss_CHN = {
    ID = "Battle_Begin_Boss_CHN",
    CN = "LanguageConfig_Battle_Begin_Boss_CHN_CN|最高警报"
  },
  Battle_Begin_Elite_CHN = {
    ID = "Battle_Begin_Elite_CHN",
    CN = "LanguageConfig_Battle_Begin_Elite_CHN_CN|危险警报"
  },
  Battle_Begin_EN = {
    ID = "Battle_Begin_EN",
    CN = "LanguageConfig_Battle_Begin_EN_CN|BATTLE BEGIN"
  },
  Battle_ChooseCard = {
    ID = "Battle_ChooseCard",
    CN = "LanguageConfig_Battle_ChooseCard_CN|选择指令卡"
  },
  Battle_ChooseCardToHand = {
    ID = "Battle_ChooseCardToHand",
    CN = "LanguageConfig_Battle_ChooseCardToHand_CN|选择{s1}张卡加入手卡"
  },
  Battle_Defeated_Title_CHN = {
    ID = "Battle_Defeated_Title_CHN",
    CN = "LanguageConfig_Battle_Defeated_Title_CHN_CN|战斗失败"
  },
  Battle_Defeated_Title_EN = {
    ID = "Battle_Defeated_Title_EN",
    CN = "LanguageConfig_Battle_Defeated_Title_EN_CN|DEFEATED"
  },
  Battle_Discard_Title = {
    ID = "Battle_Discard_Title",
    CN = "LanguageConfig_Battle_Discard_Title_CN|弃卡堆"
  },
  Battle_Draw_Title = {
    ID = "Battle_Draw_Title",
    CN = "LanguageConfig_Battle_Draw_Title_CN|抽卡堆"
  },
  Battle_ExtraTurn_Desc_CHN = {
    ID = "Battle_ExtraTurn_Desc_CHN",
    CN = "LanguageConfig_Battle_ExtraTurn_Desc_CHN_CN|超维跃迁！"
  },
  Battle_ExtraTurn_Desc_EN = {
    ID = "Battle_ExtraTurn_Desc_EN",
    CN = "LanguageConfig_Battle_ExtraTurn_Desc_EN_CN|进入超维状态，激发超维唤醒体的全部潜能"
  },
  Battle_EndTurn_EN = {
    ID = "Battle_EndTurn_EN",
    CN = "LanguageConfig_Battle_EndTurn_EN_CN|END TURN"
  },
  Battle_EnemyTurn_Title_CHN = {
    ID = "Battle_EnemyTurn_Title_CHN",
    CN = "LanguageConfig_Battle_EnemyTurn_Title_CHN_CN|敌方行动",
    en = "ENEMY TURN"
  },
  Battle_EnemyTurn_Title_EN = {
    ID = "Battle_EnemyTurn_Title_EN",
    CN = "LanguageConfig_Battle_EnemyTurn_Title_EN_CN|ENEMY TURN"
  },
  BattleSim_Err_NoActor = {
    ID = "BattleSim_Err_NoActor",
    CN = "LanguageConfig_BattleSim_Err_NoActor_CN|角色栏为空，不能进入战斗"
  },
  Battle_Exhaust_Title = {
    ID = "Battle_Exhaust_Title",
    CN = "LanguageConfig_Battle_Exhaust_Title_CN|消耗堆"
  },
  Battle_Gain_Card = {
    ID = "Battle_Gain_Card",
    CN = "LanguageConfig_Battle_Gain_Card_CN|获取"
  },
  Battle_Gain_Relic = {
    ID = "Battle_Gain_Relic",
    CN = "LanguageConfig_Battle_Gain_Relic_CN|获取"
  },
  Battle_ExtraTurn_Title_CHN = {
    ID = "Battle_ExtraTurn_Title_CHN",
    CN = "LanguageConfig_Battle_ExtraTurn_Title_CHN_CN|额外回合"
  },
  Battle_ExtraTurn_Title_EN = {
    ID = "Battle_ExtraTurn_Title_EN",
    CN = "LanguageConfig_Battle_ExtraTurn_Title_EN_CN|EXTRA TURN"
  },
  Battle_GiveUp_Card = {
    ID = "Battle_GiveUp_Card",
    CN = "LanguageConfig_Battle_GiveUp_Card_CN|放弃"
  },
  Battle_GiveUp_Relic = {
    ID = "Battle_GiveUp_Relic",
    CN = "LanguageConfig_Battle_GiveUp_Relic_CN|放弃"
  },
  Battle_GiveUp_Stone = {
    ID = "Battle_GiveUp_Stone",
    CN = "LanguageConfig_Battle_GiveUp_Stone_CN|所有战斗放弃获取黑印"
  },
  Battle_PlayerTurn_Title_CHN = {
    ID = "Battle_PlayerTurn_Title_CHN",
    CN = "LanguageConfig_Battle_PlayerTurn_Title_CHN_CN|我方行动"
  },
  Battle_PlayerTurn_Title_EN = {
    ID = "Battle_PlayerTurn_Title_EN",
    CN = "LanguageConfig_Battle_PlayerTurn_Title_EN_CN|PLAYER TURN"
  },
  Battle_RelicList_Title = {
    ID = "Battle_RelicList_Title",
    CN = "LanguageConfig_Battle_RelicList_Title_CN|持有造物"
  },
  Battle_Threat_Unknown = {
    ID = "Battle_Threat_Unknown",
    CN = "LanguageConfig_Battle_Threat_Unknown_CN|未知"
  },
  Battle_Threat_Save = {
    ID = "Battle_Threat_Save",
    CN = "LanguageConfig_Battle_Threat_Save_CN|安全"
  },
  Battle_Win_Return = {
    ID = "Battle_Win_Return",
    CN = "LanguageConfig_Battle_Win_Return_CN|返回指令卡选择"
  },
  Battle_Win_Select1 = {
    ID = "Battle_Win_Select1",
    CN = "LanguageConfig_Battle_Win_Select1_CN|已选：0/1"
  },
  Battle_Win_Select2 = {
    ID = "Battle_Win_Select2",
    CN = "LanguageConfig_Battle_Win_Select2_CN|已选：0/2"
  },
  Battle_Win_SelectCard = {
    ID = "Battle_Win_SelectCard",
    CN = "LanguageConfig_Battle_Win_SelectCard_CN|选择指令卡"
  },
  Battle_Win_SelectRelic = {
    ID = "Battle_Win_SelectRelic",
    CN = "LanguageConfig_Battle_Win_SelectRelic_CN|选择造物"
  },
  Battle_Win_Title_CHN = {
    ID = "Battle_Win_Title_CHN",
    CN = "LanguageConfig_Battle_Win_Title_CHN_CN|战斗胜利"
  },
  Battle_Win_Title_EN = {
    ID = "Battle_Win_Title_EN",
    CN = "LanguageConfig_Battle_Win_Title_EN_CN|VICTORY"
  },
  BattleBuff_1 = {
    ID = "BattleBuff_1",
    CN = "LanguageConfig_BattleBuff_1_CN|攻击力"
  },
  BattleBuff_2 = {
    ID = "BattleBuff_2",
    CN = "LanguageConfig_BattleBuff_2_CN|增加伤害值"
  },
  BattleBuff_3 = {
    ID = "BattleBuff_3",
    CN = "LanguageConfig_BattleBuff_3_CN|防御力"
  },
  BattleBuff_4 = {
    ID = "BattleBuff_4",
    CN = "LanguageConfig_BattleBuff_4_CN|增加护盾力"
  },
  BattleBuff_5 = {
    ID = "BattleBuff_5",
    CN = "LanguageConfig_BattleBuff_5_CN|触腕力量"
  },
  BattleBuff_6 = {
    ID = "BattleBuff_6",
    CN = "LanguageConfig_BattleBuff_6_CN|增加触腕的伤害值"
  },
  BattleString_01 = {
    ID = "BattleString_01",
    CN = "LanguageConfig_BattleString_01_CN|剩余回合数：{s1}"
  },
  BattleString_02 = {
    ID = "BattleString_02",
    CN = "LanguageConfig_BattleString_02_CN|算力不足，无法使用指令卡"
  },
  Card_Bag_Title = {
    ID = "Card_Bag_Title",
    CN = "LanguageConfig_Card_Bag_Title_CN|指令卡"
  },
  Card_Upgrade = {
    ID = "Card_Upgrade",
    CN = "LanguageConfig_Card_Upgrade_CN|强化"
  },
  Card_Upgrade_Desc = {
    ID = "Card_Upgrade_Desc",
    CN = "LanguageConfig_Card_Upgrade_Desc_CN|选择1张卡进行强化"
  },
  CardString_01 = {
    ID = "CardString_01",
    CN = "LanguageConfig_CardString_01_CN|伤害"
  },
  CardString_02 = {
    ID = "CardString_02",
    CN = "LanguageConfig_CardString_02_CN|能力"
  },
  CardString_03 = {
    ID = "CardString_03",
    CN = "LanguageConfig_CardString_03_CN|状态"
  },
  CardString_04 = {
    ID = "CardString_04",
    CN = "LanguageConfig_CardString_04_CN|技能"
  },
  CardString_05 = {
    ID = "CardString_05",
    CN = "LanguageConfig_CardString_05_CN|症状"
  },
  CardString_06 = {
    ID = "CardString_06",
    CN = "LanguageConfig_CardString_06_CN|护盾"
  },
  Event_Shop_BuyTip_1 = {
    ID = "Event_Shop_BuyTip_1",
    CN = "LanguageConfig_Event_Shop_BuyTip_1_CN|黑印不足"
  },
  Event_Shop_BuyTip_2 = {
    ID = "Event_Shop_BuyTip_2",
    CN = "LanguageConfig_Event_Shop_BuyTip_2_CN|黑印不足"
  },
  Event_Shop_BuyBtn_Y = {
    ID = "Event_Shop_BuyBtn_Y",
    CN = "LanguageConfig_Event_Shop_BuyBtn_Y_CN|确认"
  },
  Event_Shop_BuyBtn_N = {
    ID = "Event_Shop_BuyBtn_N",
    CN = "LanguageConfig_Event_Shop_BuyBtn_N_CN|取消"
  },
  Event_Shop_String_5 = {
    ID = "Event_Shop_String_5",
    CN = "LanguageConfig_Event_Shop_String_5_CN|售罄"
  },
  Main_Title_3 = {
    ID = "Main_Title_3",
    CN = "LanguageConfig_Main_Title_3_CN|学籍档案"
  },
  DailyCopy_Start = {
    ID = "DailyCopy_Start",
    CN = "LanguageConfig_DailyCopy_Start_CN|挑战"
  },
  Battle_EndTurn_CHN = {
    ID = "Battle_EndTurn_CHN",
    CN = "LanguageConfig_Battle_EndTurn_CHN_CN|结束回合"
  },
  ReConnect_1 = {
    ID = "ReConnect_1",
    CN = "LanguageConfig_ReConnect_1_CN|尝试重新同步中…"
  },
  ReConnect_6 = {
    ID = "ReConnect_6",
    CN = "LanguageConfig_ReConnect_6_CN|正在进行精神同步"
  },
  ReConnect_7 = {
    ID = "ReConnect_7",
    CN = "LanguageConfig_ReConnect_7_CN|失去同步"
  },
  StoryLineTask_String_Received = {
    ID = "StoryLineTask_String_Received",
    CN = "LanguageConfig_StoryLineTask_String_Received_CN|已领取"
  },
  StoryLineTask_String_Available = {
    ID = "StoryLineTask_String_Available",
    CN = "LanguageConfig_StoryLineTask_String_Available_CN|领取"
  },
  ItemGain_String_MainTitle_CHN = {
    ID = "ItemGain_String_MainTitle_CHN",
    CN = "LanguageConfig_ItemGain_String_MainTitle_CHN_CN|获得物资"
  },
  ItemGain_String_MainTitle_ENG = {
    ID = "ItemGain_String_MainTitle_ENG",
    CN = "LanguageConfig_ItemGain_String_MainTitle_ENG_CN|ITEMS GAINED"
  },
  ItemGain_String_MainCont_CHN = {
    ID = "ItemGain_String_MainCont_CHN",
    CN = "LanguageConfig_ItemGain_String_MainCont_CHN_CN|点击屏幕继续"
  },
  ItemGain_String_MainCont_ENG = {
    ID = "ItemGain_String_MainCont_ENG",
    CN = "LanguageConfig_ItemGain_String_MainCont_ENG_CN|CONTINUE"
  },
  ItemGain_String_WorkTitle_CHN = {
    ID = "ItemGain_String_WorkTitle_CHN",
    CN = "LanguageConfig_ItemGain_String_WorkTitle_CHN_CN|获得物资"
  },
  ItemGain_String_WorkCont_CHN = {
    ID = "ItemGain_String_WorkCont_CHN",
    CN = "LanguageConfig_ItemGain_String_WorkCont_CHN_CN|点击屏幕继续"
  },
  ItemGain_String_SpecialItemUse = {
    ID = "ItemGain_String_SpecialItemUse",
    CN = "LanguageConfig_ItemGain_String_SpecialItemUse_CN|获得物资"
  },
  ItemGain_String_LevelUpGet_CHN = {
    ID = "ItemGain_String_LevelUpGet_CHN",
    CN = "LanguageConfig_ItemGain_String_LevelUpGet_CHN_CN|溢出经验返还"
  },
  ItemGain_String_ShareTitle = {
    ID = "ItemGain_String_ShareTitle",
    CN = "LanguageConfig_ItemGain_String_ShareTitle_CN|分享奖励"
  },
  ItemGain_AwakerGainLikeReward_CHN = {
    ID = "ItemGain_AwakerGainLikeReward_CHN",
    CN = "LanguageConfig_ItemGain_AwakerGainLikeReward_CHN_CN|同调率奖励"
  },
  Team_AwakerLevel = {
    ID = "Team_AwakerLevel",
    CN = "LanguageConfig_Team_AwakerLevel_CN|Lv.{s1}"
  },
  Battle_Tips_EnergyInfo = {
    ID = "Battle_Tips_EnergyInfo",
    CN = "LanguageConfig_Battle_Tips_EnergyInfo_CN|开场获得能量: [ene_init]\n能量自动回复: [ene_passive]\n能量消耗降低: [ene_return]"
  },
  Battle_Tips_BeDamageInfo = {
    ID = "Battle_Tips_BeDamageInfo",
    CN = "LanguageConfig_Battle_Tips_BeDamageInfo_CN|本回合敌人即将造成的伤害总量。获得护盾可以抵挡伤害。"
  },
  Battle_Tips_TurnInfo = {
    ID = "Battle_Tips_TurnInfo",
    CN = "LanguageConfig_Battle_Tips_TurnInfo_CN|本场战斗经历的回合数。敌人会随着回合数的增加逐渐成长。"
  },
  Battle_Tips_GoldInfo = {
    ID = "Battle_Tips_GoldInfo",
    CN = "LanguageConfig_Battle_Tips_GoldInfo_CN|持有的黑印数量。用于与融痕交易，换取造物和刻印强化战斗能力。击败敌方或是访问事件均可获得黑印。"
  },
  Battle_Tips_HpHeal_Title = {
    ID = "Battle_Tips_HpHeal_Title",
    CN = "LanguageConfig_Battle_Tips_HpHeal_Title_CN|生命自动回复"
  },
  Battle_Tips_HpHeal = {
    ID = "Battle_Tips_HpHeal",
    CN = "LanguageConfig_Battle_Tips_HpHeal_CN|每当你的回合开始时，回复等同于该点数的生命。"
  },
  Battle_Tips_DeathResist = {
    ID = "Battle_Tips_DeathResist",
    CN = "LanguageConfig_Battle_Tips_DeathResist_CN|在战斗中受到致命伤害时有概率保留 1 点生命。触发后下回合获得 2 点算力和抽 2 张牌，队伍的<CardKeyWord:死亡抵抗>减半，后续获得的<CardKeyWord:死亡抵抗>减半，持续到调查结束。\n若有至少 1 个混沌界域唤醒体，<CardKeyWord:死亡抵抗>初始 +100%。"
  },
  Battle_Tips_LuckyEnchant = {
    ID = "Battle_Tips_LuckyEnchant",
    CN = "LanguageConfig_Battle_Tips_LuckyEnchant_CN|在战斗结束获得刻印或是商店购买刻印时，有概率将其升级为高级刻印。"
  },
  Battle_Tips_PhiloStoneDropBonuses = {
    ID = "Battle_Tips_PhiloStoneDropBonuses",
    CN = "LanguageConfig_Battle_Tips_PhiloStoneDropBonuses_CN|黑印掉落加成"
  },
  Battle_Tips_PhiloStoneDropBonusesTips = {
    ID = "Battle_Tips_PhiloStoneDropBonusesTips",
    CN = "LanguageConfig_Battle_Tips_PhiloStoneDropBonusesTips_CN|百分比提高战斗胜利后敌人掉落的黑印。"
  },
  Battle_BoutCount = {
    ID = "Battle_BoutCount",
    CN = "LanguageConfig_Battle_BoutCount_CN|总回合数"
  },
  Battle_Tips_BoutCount = {
    ID = "Battle_Tips_BoutCount",
    CN = "LanguageConfig_Battle_Tips_BoutCount_CN|所有战斗的总回合数。"
  },
  Battle_Tips_Immune = {
    ID = "Battle_Tips_Immune",
    CN = "LanguageConfig_Battle_Tips_Immune_CN|免疫"
  },
  Battle_Tips_Block = {
    ID = "Battle_Tips_Block",
    CN = "LanguageConfig_Battle_Tips_Block_CN|格挡"
  },
  Battle_Tips_EffectEnd = {
    ID = "Battle_Tips_EffectEnd",
    CN = "LanguageConfig_Battle_Tips_EffectEnd_CN|{s1}效果结束"
  },
  Battle_Tips_TentacleTips = {
    ID = "Battle_Tips_TentacleTips",
    CN = "LanguageConfig_Battle_Tips_TentacleTips_CN|战斗开始时生成 1 条触腕，触腕在回合结束时攻击前排敌人。\n每当敌人死亡时触腕伤害永久获得提升。"
  },
  Battle_Tips_TentacleName = {
    ID = "Battle_Tips_TentacleName",
    CN = "LanguageConfig_Battle_Tips_TentacleName_CN|触腕"
  },
  Battle_Tips_BloodTips = {
    ID = "Battle_Tips_BloodTips",
    CN = "LanguageConfig_Battle_Tips_BloodTips_CN|·回合开始时<CardKeyWord:胚胎融合> +20（随损失生命提升，最高 40），达到上限时将 1 张<CardKeyWord:「胚胎」>置入手牌。\n·血肉界域的「狂气爆发」会消耗<CardKeyWord:「胚胎」>触发<CardKeyWord:吞噬>效果。"
  },
  Battle_Tips_BloodName = {
    ID = "Battle_Tips_BloodName",
    CN = "LanguageConfig_Battle_Tips_BloodName_CN|胚胎融合"
  },
  Battle_Tips_DimensionName = {
    ID = "Battle_Tips_DimensionName",
    CN = "LanguageConfig_Battle_Tips_DimensionName_CN|超维空间"
  },
  Battle_Tips_DimensionTips = {
    ID = "Battle_Tips_DimensionTips",
    CN = "LanguageConfig_Battle_Tips_DimensionTips_CN|·每回合打出的第 1 张指令卡的临时复制会发动「奇点折跃」进入<CardKeyWord:超维空间>并触发其跃迁效果。\n·当超维空间达到上限时，获得 1 个额外的超维回合，该回合不再通常抽牌，而是将超维空间的卡牌加入手牌。超维回合能触发所有跃迁效果。"
  },
  Battle_Tips_MonsterDimensionTips = {
    ID = "Battle_Tips_MonsterDimensionTips",
    CN = "LanguageConfig_Battle_Tips_MonsterDimensionTips_CN|每回合打出第 1 张指令卡的临时复制会进入敌人的维度裂隙，不同敌人会对裂隙内的卡牌产生不同的影响。"
  },
  PVPBattle_Tips_NumberOfCards = {
    ID = "PVPBattle_Tips_NumberOfCards",
    CN = "LanguageConfig_PVPBattle_Tips_NumberOfCards_CN|目前一共持有 {s1} 张手牌。\n手牌上限默认为 10。\n每回合开始会抽 5 张牌，当持有的手牌到达手牌上限时将不再获得手牌。"
  },
  Battle_Cards_Number = {
    ID = "Battle_Cards_Number",
    CN = "LanguageConfig_Battle_Cards_Number_CN|{s1}<size=20>    /     {s2}</size>"
  },
  TaskModule_btn_reward = {
    ID = "TaskModule_btn_reward",
    CN = "LanguageConfig_TaskModule_btn_reward_CN|领取"
  },
  Common_Button_Confirm = {
    ID = "Common_Button_Confirm",
    CN = "LanguageConfig_Common_Button_Confirm_CN|确定"
  },
  Copy_Recommend_School = {
    ID = "Copy_Recommend_School",
    CN = "LanguageConfig_Copy_Recommend_School_CN|推荐界域："
  },
  Copy_Recommend_Level = {
    ID = "Copy_Recommend_Level",
    CN = "LanguageConfig_Copy_Recommend_Level_CN|推荐等级："
  },
  Actor_Skill_Upgrade_MaxLeve = {
    ID = "Actor_Skill_Upgrade_MaxLeve",
    CN = "LanguageConfig_Actor_Skill_Upgrade_MaxLeve_CN|已满级"
  },
  ItemGain_String_MainTitle = {
    ID = "ItemGain_String_MainTitle",
    CN = "LanguageConfig_ItemGain_String_MainTitle_CN|获得物资"
  },
  RuneGain_Title = {
    ID = "RuneGain_Title",
    CN = "LanguageConfig_RuneGain_Title_CN|选择1张卡牌镶嵌刻印"
  },
  AbilityCard_Lock = {
    ID = "AbilityCard_Lock",
    CN = "LanguageConfig_AbilityCard_Lock_CN|能力封印"
  },
  RPGTeam_School_Have_No_Actor = {
    ID = "RPGTeam_School_Have_No_Actor",
    CN = "LanguageConfig_RPGTeam_School_Have_No_Actor_CN|当前界域暂未获得唤醒体"
  },
  RPGTeam_School_All = {
    ID = "RPGTeam_School_All",
    CN = "LanguageConfig_RPGTeam_School_All_CN|总览"
  },
  RoleDetails_Str_DBG = {
    ID = "RoleDetails_Str_DBG",
    CN = "LanguageConfig_RoleDetails_Str_DBG_CN|调查模式"
  },
  RoleDetails_Str_RPG = {
    ID = "RoleDetails_Str_RPG",
    CN = "LanguageConfig_RoleDetails_Str_RPG_CN|课题模式"
  },
  RoleInterface_Str_Title = {
    ID = "RoleInterface_Str_Title",
    CN = "LanguageConfig_RoleInterface_Str_Title_CN|全界域"
  },
  RoleInterface_Str_Tips = {
    ID = "RoleInterface_Str_Tips",
    CN = "LanguageConfig_RoleInterface_Str_Tips_CN|暂无该界域的唤醒体"
  },
  RoleInterface_Btn_Determine = {
    ID = "RoleInterface_Btn_Determine",
    CN = "LanguageConfig_RoleInterface_Btn_Determine_CN|关闭"
  },
  RoleInterface_SortTypeBtn_Level = {
    ID = "RoleInterface_SortTypeBtn_Level",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Level_CN|等级"
  },
  RoleInterface_SortTypeBtn_Score = {
    ID = "RoleInterface_SortTypeBtn_Score",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Score_CN|战力"
  },
  RoleInterface_SortTypeBtn_Star = {
    ID = "RoleInterface_SortTypeBtn_Star",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Star_CN|稀有度"
  },
  RoleInterface_SortTypeBtn_Potency = {
    ID = "RoleInterface_SortTypeBtn_Potency",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Potency_CN|启灵"
  },
  RoleInterface_SortTypeBtn_Hp = {
    ID = "RoleInterface_SortTypeBtn_Hp",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Hp_CN|体质"
  },
  RoleInterface_SortTypeBtn_Atk = {
    ID = "RoleInterface_SortTypeBtn_Atk",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Atk_CN|攻击"
  },
  RoleInterface_SortTypeBtn_Def = {
    ID = "RoleInterface_SortTypeBtn_Def",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Def_CN|防御"
  },
  RoleInterface_SortTypeBtn_Favorability = {
    ID = "RoleInterface_SortTypeBtn_Favorability",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Favorability_CN|同调率"
  },
  RoleInterface_SortTypeBtn_Collection = {
    ID = "RoleInterface_SortTypeBtn_Collection",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Collection_CN|收藏"
  },
  RoleInterface_SortTypeBtn_Type = {
    ID = "RoleInterface_SortTypeBtn_Type",
    CN = "LanguageConfig_RoleInterface_SortTypeBtn_Type_CN|界域"
  },
  RoleInterfaceSort_Str_Level = {
    ID = "RoleInterfaceSort_Str_Level",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Level_CN|Lv.{s1}"
  },
  RoleInterfaceSort_Str_Score = {
    ID = "RoleInterfaceSort_Str_Score",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Score_CN|战力 {s1}"
  },
  RoleInterfaceSort_Str_Potency = {
    ID = "RoleInterfaceSort_Str_Potency",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Potency_CN|启灵 {s1}/{s2}"
  },
  RoleInterfaceSort_Str_Hp = {
    ID = "RoleInterfaceSort_Str_Hp",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Hp_CN|体质 {s1}"
  },
  RoleInterfaceSort_Str_Atk = {
    ID = "RoleInterfaceSort_Str_Atk",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Atk_CN|攻击 {s1}"
  },
  RoleInterfaceSort_Str_Def = {
    ID = "RoleInterfaceSort_Str_Def",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Def_CN|防御 {s1}"
  },
  RoleInterfaceSort_Str_Favorability = {
    ID = "RoleInterfaceSort_Str_Favorability",
    CN = "LanguageConfig_RoleInterfaceSort_Str_Favorability_CN|同调率 {s1}"
  },
  RoleInterfaceSort_Str_AtkType = {
    ID = "RoleInterfaceSort_Str_AtkType",
    CN = "LanguageConfig_RoleInterfaceSort_Str_AtkType_CN|强袭"
  },
  RoleInterfaceSort_Str_DefType = {
    ID = "RoleInterfaceSort_Str_DefType",
    CN = "LanguageConfig_RoleInterfaceSort_Str_DefType_CN|防卫"
  },
  RoleInterfaceSort_Str_SupType = {
    ID = "RoleInterfaceSort_Str_SupType",
    CN = "LanguageConfig_RoleInterfaceSort_Str_SupType_CN|特殊"
  },
  AwakerFavorability_Description_Title = {
    ID = "AwakerFavorability_Description_Title",
    CN = "LanguageConfig_AwakerFavorability_Description_Title_CN|同调率说明"
  },
  AwakerFavorability_Description_Detail = {
    ID = "AwakerFavorability_Description_Detail",
    CN = "LanguageConfig_AwakerFavorability_Description_Detail_CN|<Title:【同调率获取】>\n·通关调查行动、特遣纪录、意识潜游和幻梦深潜等关卡后，上阵唤醒体可以获得同调率。\n·唤醒体出牌越多、消耗算力和狂气越多，获得的同调率越多；关卡推荐等级越高，获得的同调率也越多。\n·守密人银钥能量消耗越多，上阵唤醒体获得的同调率也越多。\n·手动战斗期间获得的同调率为开启「自动战斗」时的 3 倍。\n·使用助战通关关卡后，守密人的上阵唤醒体获得同调率提高 50%。\n·邀请唤醒体进入宿舍后，每 5 分钟可获得 1 点同调率。\n·离线储存超过 300 点后，获取速度降为每 15 分钟 1 点，最多可储存至 3000 点。\n\n<Title:【同调率等级】>\n·收集唤醒体的同调率可以提升同调率等级，等级越高可解锁更多唤醒体的语音和故事，部分等级还可获得「无垢之芯」。\n·唤醒体同调率达到 Lv15 后，可通过「灵肉同调」消耗「同心之证」将等级上限逐级提升至 Lv20，每级可获得「精粹灵核碎片」×5，提升至 Lv20 时还可额外获得「曜闪」。\n·唤醒体同调率达到当前等级上限后将不再继续累积，需先完成灵肉同调才能继续获取。"
  },
  AwakerFavorability_Str_LvUp = {
    ID = "AwakerFavorability_Str_LvUp",
    CN = "LanguageConfig_AwakerFavorability_Str_LvUp_CN|{s1}的同调率提升至{s2}"
  },
  RoleDetailsAttributeLevelUp_Btn_LevelUp = {
    ID = "RoleDetailsAttributeLevelUp_Btn_LevelUp",
    CN = "LanguageConfig_RoleDetailsAttributeLevelUp_Btn_LevelUp_CN|升1级"
  },
  RoleDetailsAttributeLevelUp_Btn_LevelUpLimit = {
    ID = "RoleDetailsAttributeLevelUp_Btn_LevelUpLimit",
    CN = "LanguageConfig_RoleDetailsAttributeLevelUp_Btn_LevelUpLimit_CN|升至上限"
  },
  RoleDetailsAttributeLevelUp_Str_LimitTip = {
    ID = "RoleDetailsAttributeLevelUp_Str_LimitTip",
    CN = "LanguageConfig_RoleDetailsAttributeLevelUp_Str_LimitTip_CN|等级已达上限"
  },
  RoleDetailsSkill_Str_AbilitySkill = {
    ID = "RoleDetailsSkill_Str_AbilitySkill",
    CN = "LanguageConfig_RoleDetailsSkill_Str_AbilitySkill_CN|灵知觉醒"
  },
  RoleDetailsSkillLevelUp_Btn_Determine = {
    ID = "RoleDetailsSkillLevelUp_Btn_Determine",
    CN = "LanguageConfig_RoleDetailsSkillLevelUp_Btn_Determine_CN|升级"
  },
  RoleDetailsEquipDetails_Btn_Replace = {
    ID = "RoleDetailsEquipDetails_Btn_Replace",
    CN = "LanguageConfig_RoleDetailsEquipDetails_Btn_Replace_CN|替换"
  },
  RoleDetailsEquipDetails_Btn_LevelUp = {
    ID = "RoleDetailsEquipDetails_Btn_LevelUp",
    CN = "LanguageConfig_RoleDetailsEquipDetails_Btn_LevelUp_CN|强化"
  },
  RoleDetailsEquipDetails_Btn_PutOn = {
    ID = "RoleDetailsEquipDetails_Btn_PutOn",
    CN = "LanguageConfig_RoleDetailsEquipDetails_Btn_PutOn_CN|装备"
  },
  RoleDetailsEquipDetails_Btn_Remove = {
    ID = "RoleDetailsEquipDetails_Btn_Remove",
    CN = "LanguageConfig_RoleDetailsEquipDetails_Btn_Remove_CN|卸下"
  },
  RoleDetailsEquipDetails_Btn_Change = {
    ID = "RoleDetailsEquipDetails_Btn_Change",
    CN = "LanguageConfig_RoleDetailsEquipDetails_Btn_Change_CN|更换"
  },
  Revive_Tips = {
    ID = "Revive_Tips",
    CN = "LanguageConfig_Revive_Tips_CN|已启用<RedQuality:应急灵知体>\n唤醒体已重新恢复战斗能力\n把握最后的机会吧"
  },
  ClearCopy_Tips = {
    ID = "ClearCopy_Tips",
    CN = "LanguageConfig_ClearCopy_Tips_CN|用扫荡来快捷战斗吧！"
  },
  ClearCopy_Btn = {
    ID = "ClearCopy_Btn",
    CN = "LanguageConfig_ClearCopy_Btn_CN|扫荡{s1}次"
  },
  ClearCopy_Tips_Unlock = {
    ID = "ClearCopy_Tips_Unlock",
    CN = "LanguageConfig_ClearCopy_Tips_Unlock_CN|三星通关关卡后解锁"
  },
  Team_Card_Str_Nill_Overview = {
    ID = "Team_Card_Str_Nill_Overview",
    CN = "LanguageConfig_Team_Card_Str_Nill_Overview_CN|请把角色放入编队"
  },
  MaxLevel_Tips_Exp = {
    ID = "MaxLevel_Tips_Exp",
    CN = "LanguageConfig_MaxLevel_Tips_Exp_CN|已满级"
  },
  Ticket_Revert_Btn_Sure = {
    ID = "Ticket_Revert_Btn_Sure",
    CN = "LanguageConfig_Ticket_Revert_Btn_Sure_CN|确定"
  },
  Ticket_Revert_Btn_Return = {
    ID = "Ticket_Revert_Btn_Return",
    CN = "LanguageConfig_Ticket_Revert_Btn_Return_CN|取消"
  },
  Shop_Revert_Str_Next_Time = {
    ID = "Shop_Revert_Str_Next_Time",
    CN = "LanguageConfig_Shop_Revert_Str_Next_Time_CN|重置倒计时：{s1}"
  },
  Shop_Revert_Btn_Price = {
    ID = "Shop_Revert_Btn_Price",
    CN = "LanguageConfig_Shop_Revert_Btn_Price_CN|用{s1}立即重置"
  },
  Shop_Remove_Btn_Select = {
    ID = "Shop_Remove_Btn_Select",
    CN = "LanguageConfig_Shop_Remove_Btn_Select_CN|取消选中"
  },
  Shop_Buy_Btn = {
    ID = "Shop_Buy_Btn",
    CN = "LanguageConfig_Shop_Buy_Btn_CN|购买"
  },
  Shop_Buy_Str_BuyLimit = {
    ID = "Shop_Buy_Str_BuyLimit",
    CN = "LanguageConfig_Shop_Buy_Str_BuyLimit_CN|剩余：{s1}"
  },
  Shop_Batch_Buy_Btn = {
    ID = "Shop_Batch_Buy_Btn",
    CN = "LanguageConfig_Shop_Batch_Buy_Btn_CN|批量购买{s1}"
  },
  Shop_Confirm_Buy_Str_Title = {
    ID = "Shop_Confirm_Buy_Str_Title",
    CN = "LanguageConfig_Shop_Confirm_Buy_Str_Title_CN|购买确认"
  },
  Shop_Confirm_Buy_Str_Tips = {
    ID = "Shop_Confirm_Buy_Str_Tips",
    CN = "LanguageConfig_Shop_Confirm_Buy_Str_Tips_CN|确认花费{s1}购买以下道具吗？"
  },
  Shop_Confirm_Buy_Btn_Sure = {
    ID = "Shop_Confirm_Buy_Btn_Sure",
    CN = "LanguageConfig_Shop_Confirm_Buy_Btn_Sure_CN|确定"
  },
  Shop_Confirm_Buy_Btn_Back = {
    ID = "Shop_Confirm_Buy_Btn_Back",
    CN = "LanguageConfig_Shop_Confirm_Buy_Btn_Back_CN|取消"
  },
  Shop_Confirm_Buy_Str_Now_Money = {
    ID = "Shop_Confirm_Buy_Str_Now_Money",
    CN = "LanguageConfig_Shop_Confirm_Buy_Str_Now_Money_CN|当前{s1}"
  },
  Shop_Confirm_Buy_Str_Need_Money = {
    ID = "Shop_Confirm_Buy_Str_Need_Money",
    CN = "LanguageConfig_Shop_Confirm_Buy_Str_Need_Money_CN|消耗{s1}"
  },
  Shop_Confirm_Buy_Str_Now_Arena_Money = {
    ID = "Shop_Confirm_Buy_Str_Now_Arena_Money",
    CN = "LanguageConfig_Shop_Confirm_Buy_Str_Now_Arena_Money_CN|当前竞技场币{s1}"
  },
  Shop_Confirm_Buy_Str_Need_Arena_Money = {
    ID = "Shop_Confirm_Buy_Str_Need_Arena_Money",
    CN = "LanguageConfig_Shop_Confirm_Buy_Str_Need_Arena_Money_CN|消耗竞技场币{s1}"
  },
  Shop_Confirm_Revert_Str_Title = {
    ID = "Shop_Confirm_Revert_Str_Title",
    CN = "LanguageConfig_Shop_Confirm_Revert_Str_Title_CN|确认重置"
  },
  Shop_Confirm_Revert_Str_Money_Tips = {
    ID = "Shop_Confirm_Revert_Str_Money_Tips",
    CN = "LanguageConfig_Shop_Confirm_Revert_Str_Money_Tips_CN|要使用"
  },
  Shop_Confirm_Revert_Str_Tips = {
    ID = "Shop_Confirm_Revert_Str_Tips",
    CN = "LanguageConfig_Shop_Confirm_Revert_Str_Tips_CN|重置商店内容吗？"
  },
  Shop_Confirm_Revert_Str_Lack_Money_Tips = {
    ID = "Shop_Confirm_Revert_Str_Lack_Money_Tips",
    CN = "LanguageConfig_Shop_Confirm_Revert_Str_Lack_Money_Tips_CN|蔷薇金券不足"
  },
  Shop_Confirm_Revert_Str_Arena_Money_Tips = {
    ID = "Shop_Confirm_Revert_Str_Arena_Money_Tips",
    CN = "LanguageConfig_Shop_Confirm_Revert_Str_Arena_Money_Tips_CN|竞技场币不足"
  },
  Shop_GiftBag_Exchange = {
    ID = "Shop_GiftBag_Exchange",
    CN = "LanguageConfig_Shop_GiftBag_Exchange_CN|兑换"
  },
  Shop_Now_Num_Goods_Str = {
    ID = "Shop_Now_Num_Goods_Str",
    CN = "LanguageConfig_Shop_Now_Num_Goods_Str_CN|持有数：{s1}"
  },
  Shop_Buy_Lack_Money = {
    ID = "Shop_Buy_Lack_Money",
    CN = "LanguageConfig_Shop_Buy_Lack_Money_CN|{s1}不足"
  },
  Shop_Buy_Lack_Arena_Money = {
    ID = "Shop_Buy_Lack_Arena_Money",
    CN = "LanguageConfig_Shop_Buy_Lack_Arena_Money_CN|竞技场币不足"
  },
  Shop_Revert_Button_Text = {
    ID = "Shop_Revert_Button_Text",
    CN = "LanguageConfig_Shop_Revert_Button_Text_CN|立即重置"
  },
  Team_Str_Nill_Actor = {
    ID = "Team_Str_Nill_Actor",
    CN = "LanguageConfig_Team_Str_Nill_Actor_CN|无唤醒体"
  },
  Energy_Countdown_Str = {
    ID = "Energy_Countdown_Str",
    CN = "LanguageConfig_Energy_Countdown_Str_CN|{s1}后恢复1点「灵啡肽」"
  },
  Ticket_Countdown_Str = {
    ID = "Ticket_Countdown_Str",
    CN = "LanguageConfig_Ticket_Countdown_Str_CN|{s1}后恢复1张凭证"
  },
  Level_Up_Title = {
    ID = "Level_Up_Title",
    CN = "LanguageConfig_Level_Up_Title_CN|等级提升"
  },
  Level_Up_Str_tips = {
    ID = "Level_Up_Str_tips"
  },
  Level_Up_Level_Str = {
    ID = "Level_Up_Level_Str",
    CN = "LanguageConfig_Level_Up_Level_Str_CN|等级"
  },
  Level_Up_Max_Energy_Str = {
    ID = "Level_Up_Max_Energy_Str",
    CN = "LanguageConfig_Level_Up_Max_Energy_Str_CN|灵啡肽上限"
  },
  Level_Up_Energy_Str = {
    ID = "Level_Up_Energy_Str",
    CN = "LanguageConfig_Level_Up_Energy_Str_CN|灵啡肽"
  },
  Level_Up_Relic = {
    ID = "Level_Up_Relic"
  },
  Level_Up_Tips = {
    ID = "Level_Up_Tips",
    CN = "LanguageConfig_Level_Up_Tips_CN|守密人调查等级提升"
  },
  Ticket_Revert_Time_Tips = {
    ID = "Ticket_Revert_Time_Tips",
    CN = "LanguageConfig_Ticket_Revert_Time_Tips_CN|每小时回复一张"
  },
  Battle_Elite_Tips = {
    ID = "Battle_Elite_Tips",
    CN = "LanguageConfig_Battle_Elite_Tips_CN|高危"
  },
  Battle_Boss_Tips = {
    ID = "Battle_Boss_Tips",
    CN = "LanguageConfig_Battle_Boss_Tips_CN|BOSS"
  },
  Shop_Sell_Out_Tips = {
    ID = "Shop_Sell_Out_Tips",
    CN = "LanguageConfig_Shop_Sell_Out_Tips_CN|售罄"
  },
  Battle_Str_DeathResist = {
    ID = "Battle_Str_DeathResist",
    CN = "LanguageConfig_Battle_Str_DeathResist_CN|死亡抵抗！"
  },
  Energy_Revert_Str_Title = {
    ID = "Energy_Revert_Str_Title",
    CN = "LanguageConfig_Energy_Revert_Str_Title_CN|灵啡肽回复"
  },
  Energy_Revert_Str_Content = {
    ID = "Energy_Revert_Str_Content",
    CN = "LanguageConfig_Energy_Revert_Str_Content_CN|要回复「灵啡肽」吗？"
  },
  Energy_Revert_Str_Time = {
    ID = "Energy_Revert_Str_Time",
    CN = "LanguageConfig_Energy_Revert_Str_Time_CN|（今日剩余回复次数{s1}/{s2}次）"
  },
  Energy_Revert_Str_Num = {
    ID = "Energy_Revert_Str_Num",
    CN = "LanguageConfig_Energy_Revert_Str_Num_CN|灵啡肽"
  },
  Energy_Buy_Item_Acess = {
    ID = "Energy_Buy_Item_Acess",
    CN = "LanguageConfig_Energy_Buy_Item_Acess_CN|当前银芯"
  },
  Energy_Buy_Item_Used = {
    ID = "Energy_Buy_Item_Used",
    CN = "LanguageConfig_Energy_Buy_Item_Used_CN|消耗银芯"
  },
  Buy_Jewel_Str_Title = {
    ID = "Buy_Jewel_Str_Title",
    CN = "LanguageConfig_Buy_Jewel_Str_Title_CN|购买银芯"
  },
  Buy_Jewel_Btn_Sure = {
    ID = "Buy_Jewel_Btn_Sure",
    CN = "LanguageConfig_Buy_Jewel_Btn_Sure_CN|返回"
  },
  Buy_Jewel_Str_Price = {
    ID = "Buy_Jewel_Str_Price",
    CN = "LanguageConfig_Buy_Jewel_Str_Price_CN|价格"
  },
  Repeat_Get_Copy_Reward = {
    ID = "Repeat_Get_Copy_Reward",
    CN = "LanguageConfig_Repeat_Get_Copy_Reward_CN|已获得蔷薇金券效率奖励"
  },
  DBG_Sweep_Count = {
    ID = "DBG_Sweep_Count",
    CN = "LanguageConfig_DBG_Sweep_Count_CN|{s1}/{s2}张"
  },
  DeathResistance = {
    ID = "DeathResistance",
    CN = "LanguageConfig_DeathResistance_CN|<color=#E3FFE3>死亡抵抗</color>"
  },
  Shop_Refresh_Cost_Text = {
    ID = "Shop_Refresh_Cost_Text",
    CN = "LanguageConfig_Shop_Refresh_Cost_Text_CN|消耗{s1}黑印"
  },
  Less_Sweep_Item = {
    ID = "Less_Sweep_Item",
    CN = "LanguageConfig_Less_Sweep_Item_CN|扫荡券不足"
  },
  Summon_Str_Free = {
    ID = "Summon_Str_Free",
    CN = "LanguageConfig_Summon_Str_Free_CN|首次免费"
  },
  SkillLevelUp_NeedAwakerLevel = {
    ID = "SkillLevelUp_NeedAwakerLevel",
    CN = "LanguageConfig_SkillLevelUp_NeedAwakerLevel_CN|唤醒体需达到等级 <Color4:{s1}>"
  },
  Shield_Break = {
    ID = "Shield_Break",
    CN = "LanguageConfig_Shield_Break_CN|护盾破除"
  },
  DiamondShop_Str_Title = {
    ID = "DiamondShop_Str_Title",
    CN = "LanguageConfig_DiamondShop_Str_Title_CN|购买银芯"
  },
  ShopItem_Str_Free = {
    ID = "ShopItem_Str_Free",
    CN = "LanguageConfig_ShopItem_Str_Free_CN|免费"
  },
  Skill_LevelUp_Success = {
    ID = "Skill_LevelUp_Success",
    CN = "LanguageConfig_Skill_LevelUp_Success_CN|技能升级成功"
  },
  Awaker_LevelUp_Success = {
    ID = "Awaker_LevelUp_Success",
    CN = "LanguageConfig_Awaker_LevelUp_Success_CN|升级成功"
  },
  Potency_LevelUp_Success = {
    ID = "Potency_LevelUp_Success",
    CN = "LanguageConfig_Potency_LevelUp_Success_CN|启灵成功"
  },
  Card_Tip_CardDestroy = {
    ID = "Card_Tip_CardDestroy",
    CN = "LanguageConfig_Card_Tip_CardDestroy_CN|<CardTip:销毁>\n整场探索过程中只能使用1次，打出后将从卡组中永久移除。"
  },
  Card_Tip_Consume = {
    ID = "Card_Tip_Consume",
    CN = "LanguageConfig_Card_Tip_Consume_CN|<CardTip:消耗>\n在战斗结束前被移除出卡组。"
  },
  Card_Tip_Dexterity = {
    ID = "Card_Tip_Dexterity",
    CN = "LanguageConfig_Card_Tip_Dexterity_CN|<CardTip:戒备>\n增加从指令卡获得的护盾值。"
  },
  Card_Tip_Ethereal = {
    ID = "Card_Tip_Ethereal",
    CN = "LanguageConfig_Card_Tip_Ethereal_CN|<CardTip:虚无>\n若本卡从手牌被弃掉或洗入牌库，将被消耗。"
  },
  Card_Tip_Frail = {
    ID = "Card_Tip_Frail",
    CN = "LanguageConfig_Card_Tip_Frail_CN|<CardTip:脆弱>\n获得的护盾值减少50%"
  },
  Card_Tip_Innate = {
    ID = "Card_Tip_Innate",
    CN = "LanguageConfig_Card_Tip_Innate_CN|<CardTip:固有>\n战斗开始时，本卡将出现在手卡中。"
  },
  Card_Tip_LifeSteal = {
    ID = "Card_Tip_LifeSteal",
    CN = "LanguageConfig_Card_Tip_LifeSteal_CN|<CardTip:吸血>\n恢复与未被护盾的伤害值等量的生命值。"
  },
  Card_Tip_Marking = {
    ID = "Card_Tip_Marking",
    CN = "LanguageConfig_Card_Tip_Marking_CN|<CardTip:触腕标记>\n触腕将集中攻击最后被标记的对象。"
  },
  Card_Tip_Multiprotection = {
    ID = "Card_Tip_Multiprotection",
    CN = "LanguageConfig_Card_Tip_Multiprotection_CN|<CardTip:多重加护>\n回合结束时，获得等同当前加护层数的护盾值。每次受到伤害，加护减少1层。"
  },
  Card_Tip_NoDiscard = {
    ID = "Card_Tip_NoDiscard",
    CN = "LanguageConfig_Card_Tip_NoDiscard_CN|<CardTip:保留>\n保留的卡不会在回合结束时被放入弃卡堆。"
  },
  Card_Tip_Regenerate = {
    ID = "Card_Tip_Regenerate",
    CN = "LanguageConfig_Card_Tip_Regenerate_CN|<CardTip:再生>\n回合结束时，恢复等同于再生层数的生命。"
  },
  Card_Tip_Strength = {
    ID = "Card_Tip_Strength",
    CN = "LanguageConfig_Card_Tip_Strength_CN|<CardTip:力量>\n增加造成的伤害量。"
  },
  Card_Tip_TentacleStrength = {
    ID = "Card_Tip_TentacleStrength",
    CN = "LanguageConfig_Card_Tip_TentacleStrength_CN|<CardTip:触腕伤害>\n增加触腕造成的伤害量。"
  },
  Card_Tip_Useless = {
    ID = "Card_Tip_Useless",
    CN = "LanguageConfig_Card_Tip_Useless_CN|<CardTip:无法打出>\n本卡无法从手卡中打出。"
  },
  Card_Tip_Vnlnerable = {
    ID = "Card_Tip_Vnlnerable",
    CN = "LanguageConfig_Card_Tip_Vnlnerable_CN|<CardTip:易伤>\n受到的伤害量增加50%。"
  },
  Card_Tip_Weak = {
    ID = "Card_Tip_Weak",
    CN = "LanguageConfig_Card_Tip_Weak_CN|<CardTip:虚弱>\n造成的伤害量减少25%。"
  },
  Card_Tip_Wind = {
    ID = "Card_Tip_Wind",
    CN = "LanguageConfig_Card_Tip_Wind_CN|<CardTip:中毒>\n每次施加中毒时层数叠加。敌方回合结束时，目标受到等同于当前中毒层数的伤害。"
  },
  Card_Tip_CantRemove = {
    ID = "Card_Tip_CantRemove",
    CN = "LanguageConfig_Card_Tip_CantRemove_CN|<CardTip:无法被移除>\n在整场探索过程中，本卡无法从卡组中移除。"
  },
  Card_Tip_Condition = {
    ID = "Card_Tip_Condition",
    CN = "LanguageConfig_Card_Tip_Condition_CN|<CardTip:状态>\n战斗结束后此卡会被移出卡组。"
  },
  Card_Tip_Free = {
    ID = "Card_Tip_Free",
    CN = "LanguageConfig_Card_Tip_Free_CN|<CardTip:免算力>\n指令卡的算力花费变为0。"
  },
  CardTip_Metallicize = {
    ID = "CardTip_Metallicize",
    CN = "LanguageConfig_CardTip_Metallicize_CN|<CardTip:金属化>\n每回合结束时，获得等同于当前加护层数的护盾值。"
  },
  CardTip_Destroy = {
    ID = "CardTip_Destroy",
    CN = "LanguageConfig_CardTip_Destroy_CN|<CardTip:销毁>\n打出后，本卡将从卡组中永久移除。"
  },
  CardTip_Innate = {
    ID = "CardTip_Innate",
    CN = "LanguageConfig_CardTip_Innate_CN|<CardTip:固有>\n战斗开始时，本卡将出现在手卡中。"
  },
  Card_Tip_Wing = {
    ID = "Card_Tip_Wing",
    CN = "LanguageConfig_Card_Tip_Wing_CN|<CardTip:附肢>\n附肢会增加神域秘守的<BuffTipDamage:伤害>量。"
  },
  Card_Tip_Fire = {
    ID = "Card_Tip_Fire",
    CN = "LanguageConfig_Card_Tip_Fire_CN|<CardTip:魂火>\n魂火会增加执守幼灵的<BuffTipDamage:伤害>量。"
  },
  Card_Tip_Bramble = {
    ID = "Card_Tip_Bramble",
    CN = "LanguageConfig_Card_Tip_Bramble_CN|<CardTip:尖刺>\n受到攻击时对攻击者造成和尖刺层数相等的伤害。"
  },
  Card_Tip_Artifact = {
    ID = "Card_Tip_Artifact",
    CN = "LanguageConfig_Card_Tip_Artifact_CN|<CardTip:坚韧>\n每层坚韧可以免疫一次debuff"
  },
  Tip_TemporaryStrength = {
    ID = "Tip_TemporaryStrength",
    CN = "LanguageConfig_Tip_TemporaryStrength_CN|<CardTip:临时力量>\n增加造成的伤害量。自身回合结束时失去临时力量"
  },
  Tip_Ability = {
    ID = "Tip_Ability",
    CN = "LanguageConfig_Tip_Ability_CN|<CardTip:能力>\n每个唤醒体都拥有强大的能力，可在商店和营地进行解锁"
  },
  Tip_Rune = {
    ID = "Tip_Rune",
    CN = "LanguageConfig_Tip_Rune_CN|<CardTip:刻印>\n可镶嵌在除能力卡外的任意卡牌上，并对其附加刻印效果，每张卡牌至多镶嵌1个刻印"
  },
  Card_Tip_Anger = {
    ID = "Card_Tip_Anger",
    CN = "LanguageConfig_Card_Tip_Anger_CN|<CardTip:巨刃之威>\n消耗2点算力，对所有敌人造成攻击力*200%伤害，力量在此伤害上发挥3倍效果。消耗。"
  },
  Card_Tip_devour = {
    ID = "Card_Tip_devour",
    CN = "LanguageConfig_Card_Tip_devour_CN|<CardTip:吞噬>\n消耗手牌中的1个血肉胚胎，触发额外效果"
  },
  Card_Tip_Blood = {
    ID = "Card_Tip_Blood",
    CN = "LanguageConfig_Card_Tip_Blood_CN|<CardTip:胚胎融合>\n胚胎融合到达上限时将一张能够强化血肉界域本源降临的胚胎置入手中。"
  },
  Card_Tip_Goat = {
    ID = "Card_Tip_Goat",
    CN = "LanguageConfig_Card_Tip_Goat_CN|<CardTip:圣洁之子>\n0费，在手牌中时，每使用 1 张牌就变为其 0 费的复制。消耗，保留。"
  },
  Card_Tip_Ability = {
    ID = "Card_Tip_Ability",
    CN = "LanguageConfig_Card_Tip_Ability_CN|<CardTip:灵知觉醒>\n此效果一个唤醒体只能触发一次，无法叠加"
  },
  Card_Tip_Critical = {
    ID = "Card_Tip_Critical",
    CN = "LanguageConfig_Card_Tip_Critical_CN|暴击率：[critical]\n暴击伤害：[critical_damage]"
  },
  Card_Tip_Energy = {
    ID = "Card_Tip_Energy",
    CN = "LanguageConfig_Card_Tip_Energy_CN|开场获得能量:  [ene_init]\n能量自动回复:  [ene_passive]\n能量消耗降低:  [ene_return]"
  },
  Float_Tip_Revive = {
    ID = "Float_Tip_Revive",
    CN = "LanguageConfig_Float_Tip_Revive_CN|重生"
  },
  Float_Tip_DefenceCrash = {
    ID = "Float_Tip_DefenceCrash",
    CN = "LanguageConfig_Float_Tip_DefenceCrash_CN|护盾破除！"
  },
  Float_Tip_TentacleFull = {
    ID = "Float_Tip_TentacleFull",
    CN = "LanguageConfig_Float_Tip_TentacleFull_CN|触腕满溢！"
  },
  Float_Tip_EnergyDown = {
    ID = "Float_Tip_EnergyDown",
    CN = "LanguageConfig_Float_Tip_EnergyDown_CN|能量下降…"
  },
  Float_Tip_BloodDevour = {
    ID = "Float_Tip_BloodDevour",
    CN = "LanguageConfig_Float_Tip_BloodDevour_CN|吞噬效果发动！"
  },
  Float_Tip_DimensionJump = {
    ID = "Float_Tip_DimensionJump",
    CN = "LanguageConfig_Float_Tip_DimensionJump_CN|跃迁效果发动！"
  },
  Service_Not_Errcode = {
    ID = "Service_Not_Errcode",
    CN = "LanguageConfig_Service_Not_Errcode_CN|功能提示：未找到提示代码"
  },
  Service_Tips_71 = {
    ID = "Service_Tips_71",
    CN = "LanguageConfig_Service_Tips_71_CN|不满足使用条件"
  },
  MoppingUp_lock_Warn = {
    ID = "MoppingUp_lock_Warn",
    CN = "LanguageConfig_MoppingUp_lock_Warn_CN|调查等级2级解锁快速调查"
  },
  Server_Stop_Tittle = {
    ID = "Server_Stop_Tittle",
    CN = "LanguageConfig_Server_Stop_Tittle_CN|连接中断"
  },
  Server_Stop_Desc = {
    ID = "Server_Stop_Desc",
    CN = "LanguageConfig_Server_Stop_Desc_CN|服务器连接中断，稍后将返回登录页面。"
  },
  Server_Stop_Confirm = {
    ID = "Server_Stop_Confirm",
    CN = "LanguageConfig_Server_Stop_Confirm_CN|确认"
  },
  Server_Closed = {
    ID = "Server_Closed",
    CN = "LanguageConfig_Server_Closed_CN|校园维护中，请静候修整完成"
  },
  Server_Warn_1 = {
    ID = "Server_Warn_1",
    CN = "LanguageConfig_Server_Warn_1_CN|操作成功"
  },
  Server_Warn_10 = {
    ID = "Server_Warn_10",
    CN = "LanguageConfig_Server_Warn_10_CN|未找到对应密境"
  },
  Server_Warn_11 = {
    ID = "Server_Warn_11",
    CN = "LanguageConfig_Server_Warn_11_CN|密境事件已完成"
  },
  Server_Warn_12 = {
    ID = "Server_Warn_12",
    CN = "LanguageConfig_Server_Warn_12_CN|密境事件配置类型填写错误"
  },
  Server_Warn_13 = {
    ID = "Server_Warn_13",
    CN = "LanguageConfig_Server_Warn_13_CN|密境事件不存在"
  },
  Server_Warn_14 = {
    ID = "Server_Warn_14",
    CN = "LanguageConfig_Server_Warn_14_CN|黑印不足，无法购买"
  },
  Server_Warn_15 = {
    ID = "Server_Warn_15",
    CN = "LanguageConfig_Server_Warn_15_CN|此卡无法强化"
  },
  Server_Warn_16 = {
    ID = "Server_Warn_16",
    CN = "LanguageConfig_Server_Warn_16_CN|此卡已达强化上限"
  },
  Server_Warn_17 = {
    ID = "Server_Warn_17",
    CN = "LanguageConfig_Server_Warn_17_CN|行商不出售此商品"
  },
  Server_Warn_18 = {
    ID = "Server_Warn_18",
    CN = "LanguageConfig_Server_Warn_18_CN|无此奖励"
  },
  Server_Warn_19 = {
    ID = "Server_Warn_19",
    CN = "LanguageConfig_Server_Warn_19_CN|奖励已领取"
  },
  Server_Warn_2 = {
    ID = "Server_Warn_2",
    CN = "LanguageConfig_Server_Warn_2_CN|配置表错误"
  },
  Server_Warn_20 = {
    ID = "Server_Warn_20",
    CN = "LanguageConfig_Server_Warn_20_CN|事件数据错误"
  },
  Server_Warn_21 = {
    ID = "Server_Warn_21",
    CN = "LanguageConfig_Server_Warn_21_CN|商品已购买"
  },
  Server_Warn_22 = {
    ID = "Server_Warn_22",
    CN = "LanguageConfig_Server_Warn_22_CN|未找到课题单元数据"
  },
  Server_Warn_23 = {
    ID = "Server_Warn_23",
    CN = "LanguageConfig_Server_Warn_23_CN|单元已提交，无需再次提交"
  },
  Server_Warn_24 = {
    ID = "Server_Warn_24",
    CN = "LanguageConfig_Server_Warn_24_CN|单元下的课题尚未全部完成，无法提交"
  },
  Server_Warn_25 = {
    ID = "Server_Warn_25",
    CN = "LanguageConfig_Server_Warn_25_CN|课题无模块"
  },
  Server_Warn_26 = {
    ID = "Server_Warn_26",
    CN = "LanguageConfig_Server_Warn_26_CN|关卡无课题数据"
  },
  Server_Warn_3 = {
    ID = "Server_Warn_3",
    CN = "LanguageConfig_Server_Warn_3_CN|客户端传入数据错误"
  },
  Server_Warn_4 = {
    ID = "Server_Warn_4",
    CN = "LanguageConfig_Server_Warn_4_CN|服务未启动"
  },
  Server_Warn_5 = {
    ID = "Server_Warn_5",
    CN = "LanguageConfig_Server_Warn_5_CN|角色数据错误"
  },
  Server_Warn_6 = {
    ID = "Server_Warn_6",
    CN = "LanguageConfig_Server_Warn_6_CN|没有角色，需创建"
  },
  Server_Warn_7 = {
    ID = "Server_Warn_7",
    CN = "LanguageConfig_Server_Warn_7_CN|已有角色，不需要再次创建"
  },
  Server_Warn_8 = {
    ID = "Server_Warn_8",
    CN = "LanguageConfig_Server_Warn_8_CN|角色名重复"
  },
  Server_Warn_9 = {
    ID = "Server_Warn_9",
    CN = "LanguageConfig_Server_Warn_9_CN|密境错误"
  },
  StoryRole_Unlock = {
    ID = "StoryRole_Unlock",
    CN = "LanguageConfig_StoryRole_Unlock_CN|该剧情线尚未解锁，无法进入。"
  },
  StoryLine_EffectTip = {
    ID = "StoryLine_EffectTip",
    CN = "LanguageConfig_StoryLine_EffectTip_CN|在此处可以查看地形效果以及怪物信息"
  },
  StoryLine_LockAdvance = {
    ID = "StoryLine_LockAdvance",
    CN = "LanguageConfig_StoryLine_LockAdvance_CN|{s1}达到{s2}解锁{s3}"
  },
  Copy_Lock = {
    ID = "Copy_Lock",
    CN = "LanguageConfig_Copy_Lock_CN|{s1}达到{s2}解锁{s3}"
  },
  Service_Tips_11859 = {
    ID = "Service_Tips_11859",
    CN = "LanguageConfig_Service_Tips_11859_CN|未达到建筑解锁条件"
  },
  Service_Tips_11860 = {
    ID = "Service_Tips_11860",
    CN = "LanguageConfig_Service_Tips_11860_CN|未达到建筑升级条件"
  },
  Service_Tips_11861 = {
    ID = "Service_Tips_11861",
    CN = "LanguageConfig_Service_Tips_11861_CN|建筑升级材料不足"
  },
  TaskNpc_001 = {
    ID = "TaskNpc_001",
    CN = "LanguageConfig_TaskNpc_001_CN|有可领取的任务奖励"
  },
  Contact_Tips_1 = {
    ID = "Contact_Tips_1",
    CN = "LanguageConfig_Contact_Tips_1_CN|已解锁1个造物保留格！"
  },
  MainInterface_Btn_DailyCopy = {
    ID = "MainInterface_Btn_DailyCopy",
    CN = "LanguageConfig_MainInterface_Btn_DailyCopy_CN|融蚀之墟"
  },
  MainInterface_Btn_TrinketCopy = {
    ID = "MainInterface_Btn_TrinketCopy",
    CN = "LanguageConfig_MainInterface_Btn_TrinketCopy_CN|禁忌纂录"
  },
  MainInterface_Btn_DailyChallenge = {
    ID = "MainInterface_Btn_DailyChallenge",
    CN = "LanguageConfig_MainInterface_Btn_DailyChallenge_CN|幻梦深潜"
  },
  MainInterface_Btn_WeekChallenge = {
    ID = "MainInterface_Btn_WeekChallenge",
    CN = "LanguageConfig_MainInterface_Btn_WeekChallenge_CN|无光之境"
  },
  MainInterface_Btn_Arena = {
    ID = "MainInterface_Btn_Arena",
    CN = "LanguageConfig_MainInterface_Btn_Arena_CN|幕间演习"
  },
  MainInterface_Btn_MultiTeamArena = {
    ID = "MainInterface_Btn_MultiTeamArena",
    CN = "LanguageConfig_MainInterface_Btn_MultiTeamArena_CN|狂蚀集训-开发中"
  },
  MainInterface_Btn_BOSS = {
    ID = "MainInterface_Btn_BOSS",
    CN = "LanguageConfig_MainInterface_Btn_BOSS_CN|超验存在"
  },
  MainInterface_Btn_Send = {
    ID = "MainInterface_Btn_Send",
    CN = "LanguageConfig_MainInterface_Btn_Send_CN|派遣"
  },
  DailyCopy_Str_Title = {
    ID = "DailyCopy_Str_Title",
    CN = "LanguageConfig_DailyCopy_Str_Title_CN|融蚀之墟"
  },
  DailyCopy_Str_Money_Title = {
    ID = "DailyCopy_Str_Money_Title",
    CN = "LanguageConfig_DailyCopy_Str_Money_Title_CN|金券搜查"
  },
  DailyCopy_Str_Money_Exp = {
    ID = "DailyCopy_Str_Money_Exp",
    CN = "LanguageConfig_DailyCopy_Str_Money_Exp_CN|制剂淬炼"
  },
  DailyCopy_Str_Ocean_Title = {
    ID = "DailyCopy_Str_Ocean_Title",
    CN = "LanguageConfig_DailyCopy_Str_Ocean_Title_CN|海渊残像"
  },
  DailyCopy_Str_Blood_Title = {
    ID = "DailyCopy_Str_Blood_Title",
    CN = "LanguageConfig_DailyCopy_Str_Blood_Title_CN|器质残像"
  },
  DailyCopy_Str_Dimension_Title = {
    ID = "DailyCopy_Str_Dimension_Title",
    CN = "LanguageConfig_DailyCopy_Str_Dimension_Title_CN|维度残像"
  },
  DailyCopy_Str_Dialog = {
    ID = "DailyCopy_Str_Dialog",
    CN = "LanguageConfig_DailyCopy_Str_Dialog_CN|攻略关卡后，可以获取材料\n能拿的东西，当然全部拿光"
  },
  DailyCopy_Str_TrinketCopy = {
    ID = "DailyCopy_Str_TrinketCopy",
    CN = "LanguageConfig_DailyCopy_Str_TrinketCopy_CN|攻略关卡后，可以获取密契\n能拿的东西，当然全部拿光"
  },
  ClearCopy_Str_Title = {
    ID = "ClearCopy_Str_Title",
    CN = "LanguageConfig_ClearCopy_Str_Title_CN|重现奖励"
  },
  Battle_expect_Str_hurt = {
    ID = "Battle_expect_Str_hurt",
    CN = "LanguageConfig_Battle_expect_Str_hurt_CN|怪物回合伤害"
  },
  Battle_Str_Round = {
    ID = "Battle_Str_Round",
    CN = "LanguageConfig_Battle_Str_Round_CN|回合"
  },
  Battle_CardGroup = {
    ID = "Battle_CardGroup",
    CN = "LanguageConfig_Battle_CardGroup_CN|牌堆"
  },
  Battle_DrawCardGroup_Str = {
    ID = "Battle_DrawCardGroup_Str",
    CN = "LanguageConfig_Battle_DrawCardGroup_Str_CN|抽牌堆({s1})"
  },
  Battle_DisCardGroup_Str = {
    ID = "Battle_DisCardGroup_Str",
    CN = "LanguageConfig_Battle_DisCardGroup_Str_CN|弃牌堆({s1})"
  },
  Battle_ResonanceBuff_Str = {
    ID = "Battle_ResonanceBuff_Str",
    CN = "LanguageConfig_Battle_ResonanceBuff_Str_CN|共鸣"
  },
  Battle_Strengthen_Str = {
    ID = "Battle_Strengthen_Str",
    CN = "LanguageConfig_Battle_Strengthen_Str_CN|强化"
  },
  Battle_DeathResist = {
    ID = "Battle_DeathResist",
    CN = "LanguageConfig_Battle_DeathResist_CN|死亡抵抗"
  },
  Battle_Cooldown = {
    ID = "Battle_Cooldown",
    CN = "LanguageConfig_Battle_Cooldown_CN|冷却中"
  },
  Battle_State_Layer = {
    ID = "Battle_State_Layer",
    CN = "LanguageConfig_Battle_State_Layer_CN|{s1}层"
  },
  Task_Module_Btn = {
    ID = "Task_Module_Btn",
    CN = "LanguageConfig_Task_Module_Btn_CN|任务入口"
  },
  TaskType_Appoint_Battle = {
    ID = "TaskType_Appoint_Battle",
    CN = "LanguageConfig_TaskType_Appoint_Battle_CN|战斗"
  },
  TaskType_Appoint_Dispatch = {
    ID = "TaskType_Appoint_Dispatch",
    CN = "LanguageConfig_TaskType_Appoint_Dispatch_CN|调查"
  },
  TaskAward_Btn_Completed = {
    ID = "TaskAward_Btn_Completed",
    CN = "LanguageConfig_TaskAward_Btn_Completed_CN|领取"
  },
  Task_Career_Btn_Last = {
    ID = "Task_Career_Btn_Last",
    CN = "LanguageConfig_Task_Career_Btn_Last_CN|上一组"
  },
  Task_Career_Btn_Next = {
    ID = "Task_Career_Btn_Next",
    CN = "LanguageConfig_Task_Career_Btn_Next_CN|下一组"
  },
  Task_Career_NextChapter_Tips = {
    ID = "Task_Career_NextChapter_Tips",
    CN = "LanguageConfig_Task_Career_NextChapter_Tips_CN|完成所有任务后解锁下一组"
  },
  Task_Career_LastChapter_Tips = {
    ID = "Task_Career_LastChapter_Tips",
    CN = "LanguageConfig_Task_Career_LastChapter_Tips_CN|当前已经是第一组"
  },
  Task_Career_Progress = {
    ID = "Task_Career_Progress",
    CN = "LanguageConfig_Task_Career_Progress_CN|当前进度： {s1}/{s2}"
  },
  Task_Career_Parent_Pickup_Tips = {
    ID = "Task_Career_Parent_Pickup_Tips",
    CN = "LanguageConfig_Task_Career_Parent_Pickup_Tips_CN|完成右侧所有任务后可领取"
  },
  Task_Dispatch_SpeedUp = {
    ID = "Task_Dispatch_SpeedUp",
    CN = "LanguageConfig_Task_Dispatch_SpeedUp_CN|加速（已废弃）"
  },
  Task_Dispatch_SpeedUp_Free = {
    ID = "Task_Dispatch_SpeedUp_Free",
    CN = "LanguageConfig_Task_Dispatch_SpeedUp_Free_CN|免费（已废弃）"
  },
  Task_Dispatch_SpeedUp_NotEnoughItem = {
    ID = "Task_Dispatch_SpeedUp_NotEnoughItem",
    CN = "LanguageConfig_Task_Dispatch_SpeedUp_NotEnoughItem_CN|加速券不足（已废弃）"
  },
  Task_Dispatch_Select = {
    ID = "Task_Dispatch_Select",
    CN = "LanguageConfig_Task_Dispatch_Select_CN|派遣上阵"
  },
  Task_Dispatch_Select_Null = {
    ID = "Task_Dispatch_Select_Null",
    CN = "LanguageConfig_Task_Dispatch_Select_Null_CN|需要至少派遣一个唤醒体"
  },
  Task_Dispatch_Select_Condition_NotMeet = {
    ID = "Task_Dispatch_Select_Condition_NotMeet",
    CN = "LanguageConfig_Task_Dispatch_Select_Condition_NotMeet_CN|满足必要条件后方可派遣"
  },
  Task_Dispatch_SelectConfirm = {
    ID = "Task_Dispatch_SelectConfirm",
    CN = "LanguageConfig_Task_Dispatch_SelectConfirm_CN|确认派遣"
  },
  Task_Dispatch_Callback = {
    ID = "Task_Dispatch_Callback",
    CN = "LanguageConfig_Task_Dispatch_Callback_CN|召回"
  },
  Task_Dispatch_Callback_Title = {
    ID = "Task_Dispatch_Callback_Title",
    CN = "LanguageConfig_Task_Dispatch_Callback_Title_CN|派遣召回"
  },
  Task_Dispatch_Callback_Desc1 = {
    ID = "Task_Dispatch_Callback_Desc1",
    CN = "LanguageConfig_Task_Dispatch_Callback_Desc1_CN|是否立即召回当前派遣的队伍？"
  },
  Task_Dispatch_Callback_Desc2 = {
    ID = "Task_Dispatch_Callback_Desc2",
    CN = "LanguageConfig_Task_Dispatch_Callback_Desc2_CN|已派遣的唤醒体"
  },
  Task_Dispatch_Callback_Desc3 = {
    ID = "Task_Dispatch_Callback_Desc3",
    CN = "LanguageConfig_Task_Dispatch_Callback_Desc3_CN|注意：召回后不会获得任何奖励"
  },
  Task_Dispatch_Callback_CancelBtn = {
    ID = "Task_Dispatch_Callback_CancelBtn",
    CN = "LanguageConfig_Task_Dispatch_Callback_CancelBtn_CN|取消"
  },
  Task_Dispatch_Callback_ConfirmBtn = {
    ID = "Task_Dispatch_Callback_ConfirmBtn",
    CN = "LanguageConfig_Task_Dispatch_Callback_ConfirmBtn_CN|确认"
  },
  Task_Dispatch_Essential_Cond = {
    ID = "Task_Dispatch_Essential_Cond",
    CN = "LanguageConfig_Task_Dispatch_Essential_Cond_CN|必要条件"
  },
  Task_Dispatch_Extra_Cond = {
    ID = "Task_Dispatch_Extra_Cond",
    CN = "LanguageConfig_Task_Dispatch_Extra_Cond_CN|加分条件（已废弃）"
  },
  Task_Dispatch_Extra_Award = {
    ID = "Task_Dispatch_Extra_Award",
    CN = "LanguageConfig_Task_Dispatch_Extra_Award_CN|额外报酬（已废弃）"
  },
  Task_Dispatch_Awakers = {
    ID = "Task_Dispatch_Awakers",
    CN = "LanguageConfig_Task_Dispatch_Awakers_CN|派遣唤醒体"
  },
  Task_Appoint_Refresh = {
    ID = "Task_Appoint_Refresh",
    CN = "LanguageConfig_Task_Appoint_Refresh_CN|刷新（已废弃）"
  },
  Task_Appoint_Refresh_Free = {
    ID = "Task_Appoint_Refresh_Free",
    CN = "LanguageConfig_Task_Appoint_Refresh_Free_CN|免费刷新（已废弃）"
  },
  Task_Appoint_Refresh_NotAvailable = {
    ID = "Task_Appoint_Refresh_NotAvailable",
    CN = "LanguageConfig_Task_Appoint_Refresh_NotAvailable_CN|今日已派遣任务达到上限，不可刷新"
  },
  Task_Appoint_Cannot_GetNewApppoint = {
    ID = "Task_Appoint_Cannot_GetNewApppoint",
    CN = "LanguageConfig_Task_Appoint_Cannot_GetNewApppoint_CN|今日已派遣任务达到上限"
  },
  Task_Appoint_Unclaimed_Toomuch = {
    ID = "Task_Appoint_Unclaimed_Toomuch",
    CN = "LanguageConfig_Task_Appoint_Unclaimed_Toomuch_CN|未领取奖励任务过多，请先领取"
  },
  Task_Appoint_Refresh_NoTaskToRefresh = {
    ID = "Task_Appoint_Refresh_NoTaskToRefresh",
    CN = "LanguageConfig_Task_Appoint_Refresh_NoTaskToRefresh_CN|没有可刷新任务（已废弃）"
  },
  Task_Appoint_Refresh_NotEnoughItem = {
    ID = "Task_Appoint_Refresh_NotEnoughItem",
    CN = "LanguageConfig_Task_Appoint_Refresh_NotEnoughItem_CN|银芯不足（已废弃）"
  },
  Task_Appoint_Battle_Select = {
    ID = "Task_Appoint_Battle_Select",
    CN = "LanguageConfig_Task_Appoint_Battle_Select_CN|前往战斗"
  },
  Task_Dispatch_TeamNum = {
    ID = "Task_Dispatch_TeamNum",
    CN = "LanguageConfig_Task_Dispatch_TeamNum_CN|已派遣队伍：{s1}/{s2}"
  },
  Task_Appoint_TimesLeft = {
    ID = "Task_Appoint_TimesLeft",
    CN = "LanguageConfig_Task_Appoint_TimesLeft_CN|派遣限制：{s1}/{s2}"
  },
  Task_Appoint_AllFinished = {
    ID = "Task_Appoint_AllFinished",
    CN = "LanguageConfig_Task_Appoint_AllFinished_CN|今日派遣任务已全部完成！"
  },
  Task_Dispatch_TeamNum_NotEnough = {
    ID = "Task_Dispatch_TeamNum_NotEnough",
    CN = "LanguageConfig_Task_Dispatch_TeamNum_NotEnough_CN|可派遣队伍不足"
  },
  Task_Appoint_Refresh_TimeLeft = {
    ID = "Task_Appoint_Refresh_TimeLeft",
    CN = "LanguageConfig_Task_Appoint_Refresh_TimeLeft_CN|{s1}后刷新"
  },
  Task_Appoint_Newer_Tips = {
    ID = "Task_Appoint_Newer_Tips",
    CN = "LanguageConfig_Task_Appoint_Newer_Tips_CN|完成所有任务后刷新"
  },
  Task_Appoint_Level = {
    ID = "Task_Appoint_Level",
    CN = "LanguageConfig_Task_Appoint_Level_CN|派遣等级：{s1}（已废弃）"
  },
  Task_Appoint_Rules = {
    ID = "Task_Appoint_Rules",
    CN = "LanguageConfig_Task_Appoint_Rules_CN|<Title:【派遣规则】>\n·守密人可以派遣唤醒体进行调查或研究任务，完成任务后可获得相应的奖励。\n·达到任务需求的派遣总等级才可成功派遣，每个任务至多可同时派遣4名唤醒体。\n·派遣总等级每超出任务需求20级，可获得1份额外奖励。\n·每个唤醒体同时只能承接一个派遣任务。若在任务途中取消派遣，可以快速释放占用的唤醒体，但将无法获得该任务的奖励。\n·守密人调查等级提升至20/30/40/50/60级时，可承接的派遣任务数额外+1。\n·注意：唤醒体本源形态不可派遣。"
  },
  Task_Appoint_AcountLvUpTips = {
    ID = "Task_Appoint_AcountLvUpTips",
    CN = "LanguageConfig_Task_Appoint_AcountLvUpTips_CN|可同时派遣任务提升至<TipsHighlightText_1: {s1} >个"
  },
  Task_Appoint_Battle_Award = {
    ID = "Task_Appoint_Battle_Award",
    CN = "LanguageConfig_Task_Appoint_Battle_Award_CN|任务报酬"
  },
  Task_Appoint_Battle_EnemyInfo = {
    ID = "Task_Appoint_Battle_EnemyInfo",
    CN = "LanguageConfig_Task_Appoint_Battle_EnemyInfo_CN|战斗概况"
  },
  Task_Appoint_Battle_NeedTime = {
    ID = "Task_Appoint_Battle_NeedTime",
    CN = "LanguageConfig_Task_Appoint_Battle_NeedTime_CN|立即"
  },
  Task_Dispatch_NeedTime = {
    ID = "Task_Dispatch_NeedTime",
    CN = "LanguageConfig_Task_Dispatch_NeedTime_CN|需耗时{s1}小时"
  },
  Task_Dispatch_NeedTime_Min = {
    ID = "Task_Dispatch_NeedTime_Min",
    CN = "LanguageConfig_Task_Dispatch_NeedTime_Min_CN|需耗时{s1}分钟"
  },
  Task_Dispatch_LeftTime = {
    ID = "Task_Dispatch_LeftTime",
    CN = "LanguageConfig_Task_Dispatch_LeftTime_CN|剩余【待删除】"
  },
  Task_Dispatch_Hour = {
    ID = "Task_Dispatch_Hour",
    CN = "LanguageConfig_Task_Dispatch_Hour_CN|{s1}小时{s2}分"
  },
  Task_Dispatch_Minute = {
    ID = "Task_Dispatch_Minute",
    CN = "LanguageConfig_Task_Dispatch_Minute_CN|{s1}分钟"
  },
  Task_Dispatch_Second = {
    ID = "Task_Dispatch_Second",
    CN = "LanguageConfig_Task_Dispatch_Second_CN|{s1}秒"
  },
  Task_Dispatch_AwakerState = {
    ID = "Task_Dispatch_AwakerState",
    CN = "LanguageConfig_Task_Dispatch_AwakerState_CN|派遣中"
  },
  Task_Dispatch_DispatchingTips = {
    ID = "Task_Dispatch_DispatchingTips",
    CN = "LanguageConfig_Task_Dispatch_DispatchingTips_CN|该唤醒体已经在执行其他任务"
  },
  Task_Dispatch_FinishedTips = {
    ID = "Task_Dispatch_FinishedTips",
    CN = "LanguageConfig_Task_Dispatch_FinishedTips_CN|此任务已完成，不可召回"
  },
  Task_Appoint_NonExistent = {
    ID = "Task_Appoint_NonExistent",
    CN = "LanguageConfig_Task_Appoint_NonExistent_CN|任务已被刷新"
  },
  Task_State_Ongoing = {
    ID = "Task_State_Ongoing",
    CN = "LanguageConfig_Task_State_Ongoing_CN|进行中"
  },
  Task_State_Completed = {
    ID = "Task_State_Completed",
    CN = "LanguageConfig_Task_State_Completed_CN|已完成"
  },
  Task_State_Received = {
    ID = "Task_State_Received",
    CN = "LanguageConfig_Task_State_Received_CN|奖励已领取"
  },
  Task_Tips_ToReceive = {
    ID = "Task_Tips_ToReceive",
    CN = "LanguageConfig_Task_Tips_ToReceive_CN|可领取"
  },
  Task_Tab_Appoint = {
    ID = "Task_Tab_Appoint",
    CN = "LanguageConfig_Task_Tab_Appoint_CN|派遣"
  },
  Task_Tab_Daily = {
    ID = "Task_Tab_Daily",
    CN = "LanguageConfig_Task_Tab_Daily_CN|日程"
  },
  Task_Tab_Achievement = {
    ID = "Task_Tab_Achievement",
    CN = "LanguageConfig_Task_Tab_Achievement_CN|成就"
  },
  Task_Tab_Career = {
    ID = "Task_Tab_Career",
    CN = "LanguageConfig_Task_Tab_Career_CN|行动报告"
  },
  Task_Daily_Name = {
    ID = "Task_Daily_Name",
    CN = "LanguageConfig_Task_Daily_Name_CN|每日任务"
  },
  Task_Daily_Desc = {
    ID = "Task_Daily_Desc",
    CN = "LanguageConfig_Task_Daily_Desc_CN|每日任务提供「银芯」和大量「守密人经验」奖励。"
  },
  Task_Achievement_Finished = {
    ID = "Task_Achievement_Finished",
    CN = "LanguageConfig_Task_Achievement_Finished_CN|已完成<color=#359bb1>{s1}</color>个成就"
  },
  Task_AchievementLabel = {
    ID = "Task_AchievementLabel",
    CN = "LanguageConfig_Task_AchievementLabel_CN|成就标签"
  },
  Summon_Shop_Btn = {
    ID = "Summon_Shop_Btn",
    CN = "LanguageConfig_Summon_Shop_Btn_CN|商店兑换"
  },
  Summon_RateDesc_Btn = {
    ID = "Summon_RateDesc_Btn",
    CN = "LanguageConfig_Summon_RateDesc_Btn_CN|唤醒详情"
  },
  Summon_RateDesc_Tab_UPItem = {
    ID = "Summon_RateDesc_Tab_UPItem",
    CN = "LanguageConfig_Summon_RateDesc_Tab_UPItem_CN|UP物品"
  },
  Summon_RateDesc_Tab_LongDesc = {
    ID = "Summon_RateDesc_Tab_LongDesc",
    CN = "LanguageConfig_Summon_RateDesc_Tab_LongDesc_CN|概率说明"
  },
  Summon_RateDesc_Tab_ItemList = {
    ID = "Summon_RateDesc_Tab_ItemList",
    CN = "LanguageConfig_Summon_RateDesc_Tab_ItemList_CN|物品清单"
  },
  Summon_LongDesc_Text1 = {
    ID = "Summon_LongDesc_Text1",
    CN = "LanguageConfig_Summon_LongDesc_Text1_CN|以下内容出现【概率UP！！！】"
  },
  Summon_LongDesc_Text2 = {
    ID = "Summon_LongDesc_Text2",
    CN = "LanguageConfig_Summon_LongDesc_Text2_CN|以下SSR占全部SSR物品出率的50%"
  },
  Summon_LongDesc_Text3 = {
    ID = "Summon_LongDesc_Text3",
    CN = "LanguageConfig_Summon_LongDesc_Text3_CN|以下SR占全部SR物品出率的50%"
  },
  Summon_RateList_Text1 = {
    ID = "Summon_RateList_Text1",
    CN = "LanguageConfig_Summon_RateList_Text1_CN|以下为唤醒物品清单："
  },
  Summon_RateList_Text2 = {
    ID = "Summon_RateList_Text2",
    CN = "LanguageConfig_Summon_RateList_Text2_CN|（当未触发UP或保底规则时，所有唤醒体或命轮均分基础出率）"
  },
  Summon_History_Btn = {
    ID = "Summon_History_Btn",
    CN = "LanguageConfig_Summon_History_Btn_CN|唤醒历史"
  },
  Summon_DrawOnce_Btn = {
    ID = "Summon_DrawOnce_Btn",
    CN = "LanguageConfig_Summon_DrawOnce_Btn_CN|唤醒1次"
  },
  Summon_DrawTenTimes_Btn = {
    ID = "Summon_DrawTenTimes_Btn",
    CN = "LanguageConfig_Summon_DrawTenTimes_Btn_CN|唤醒5次"
  },
  Summon_Tab_Type0 = {
    ID = "Summon_Tab_Type0",
    CN = "LanguageConfig_Summon_Tab_Type0_CN|常驻唤醒"
  },
  Summon_Tab_Type1 = {
    ID = "Summon_Tab_Type1",
    CN = "LanguageConfig_Summon_Tab_Type1_CN|命轮\n活动唤醒"
  },
  Summon_Tab_Type2 = {
    ID = "Summon_Tab_Type2",
    CN = "LanguageConfig_Summon_Tab_Type2_CN|唤醒体\n活动唤醒"
  },
  Summon_Times_Left = {
    ID = "Summon_Times_Left",
    CN = "LanguageConfig_Summon_Times_Left_CN|{s1} 次后消失"
  },
  Summon_Time_Remain1 = {
    ID = "Summon_Time_Remain1",
    CN = "LanguageConfig_Summon_Time_Remain1_CN|{s1} 天"
  },
  Summon_Time_Remain2 = {
    ID = "Summon_Time_Remain2",
    CN = "LanguageConfig_Summon_Time_Remain2_CN|<RedQuality:{s1}>"
  },
  Summon_Free = {
    ID = "Summon_Free",
    CN = "LanguageConfig_Summon_Free_CN|免费"
  },
  Summon_ReselectTimes = {
    ID = "Summon_ReselectTimes",
    CN = "LanguageConfig_Summon_ReselectTimes_CN|次数：{s1}/{s2}"
  },
  Summon_Select_Btn = {
    ID = "Summon_Select_Btn",
    CN = "LanguageConfig_Summon_Select_Btn_CN|选择本次结果"
  },
  Summon_Reselect_Btn = {
    ID = "Summon_Reselect_Btn",
    CN = "LanguageConfig_Summon_Reselect_Btn_CN|重新唤醒"
  },
  Summon_Detail_Btn = {
    ID = "Summon_Detail_Btn",
    CN = "LanguageConfig_Summon_Detail_Btn_CN|查看"
  },
  Summon_School_Difficulty = {
    ID = "Summon_School_Difficulty",
    CN = "LanguageConfig_Summon_School_Difficulty_CN|上手难度"
  },
  Summon_School_DetailTitle = {
    ID = "Summon_School_DetailTitle",
    CN = "LanguageConfig_Summon_School_DetailTitle_CN|界域特色——"
  },
  Summon_SelectSchool = {
    ID = "Summon_SelectSchool",
    CN = "LanguageConfig_Summon_SelectSchool_CN|指定界域"
  },
  Summon_SchoolSelected = {
    ID = "Summon_SchoolSelected",
    CN = "LanguageConfig_Summon_SchoolSelected_CN|当前指定：{s1}"
  },
  Summon_SelectSchoolTips = {
    ID = "Summon_SelectSchoolTips",
    CN = "LanguageConfig_Summon_SelectSchoolTips_CN|指定界域后才能唤醒"
  },
  SummonTypeText_0 = {
    ID = "SummonTypeText_0",
    CN = "LanguageConfig_SummonTypeText_0_CN|常驻命轮唤醒"
  },
  SummonTypeText_1 = {
    ID = "SummonTypeText_1",
    CN = "LanguageConfig_SummonTypeText_1_CN|命轮活动唤醒"
  },
  SummonTypeText_2 = {
    ID = "SummonTypeText_2",
    CN = "LanguageConfig_SummonTypeText_2_CN|角色活动唤醒"
  },
  SummonTypeText_3 = {
    ID = "SummonTypeText_3",
    CN = "LanguageConfig_SummonTypeText_3_CN|预留唤醒"
  },
  SummonTypeText_4 = {
    ID = "SummonTypeText_4",
    CN = "LanguageConfig_SummonTypeText_4_CN|预留唤醒"
  },
  SummonTypeText_5 = {
    ID = "SummonTypeText_5",
    CN = "LanguageConfig_SummonTypeText_5_CN|常驻角色唤醒"
  },
  SummonTypeText_6 = {
    ID = "SummonTypeText_6",
    CN = "LanguageConfig_SummonTypeText_6_CN|新生推荐唤醒"
  },
  SummonTypeText_7 = {
    ID = "SummonTypeText_7",
    CN = "LanguageConfig_SummonTypeText_7_CN|循序命理唤醒"
  },
  SummonTypeText_8 = {
    ID = "SummonTypeText_8",
    CN = "LanguageConfig_SummonTypeText_8_CN|命轨合契唤醒"
  },
  SummonTypeText_9 = {
    ID = "SummonTypeText_9",
    CN = "LanguageConfig_SummonTypeText_9_CN|新手角色唤醒"
  },
  SummonTypeText_10 = {
    ID = "SummonTypeText_10",
    CN = "LanguageConfig_SummonTypeText_10_CN|众生百相唤醒"
  },
  SummonTypeText_12 = {
    ID = "SummonTypeText_12",
    CN = "LanguageConfig_SummonTypeText_12_CN|逆命双生唤醒"
  },
  SummonTypeText_13 = {
    ID = "SummonTypeText_13",
    CN = "LanguageConfig_SummonTypeText_13_CN|界域锚定唤醒"
  },
  SummonTypeText_14 = {
    ID = "SummonTypeText_14",
    CN = "LanguageConfig_SummonTypeText_14_CN|角色自选唤醒"
  },
  SummonTypeText_15 = {
    ID = "SummonTypeText_15",
    CN = "LanguageConfig_SummonTypeText_15_CN|命轨合契·三倍唤醒"
  },
  SummonTypeText_16 = {
    ID = "SummonTypeText_16",
    CN = "LanguageConfig_SummonTypeText_16_CN|缚誓之谕"
  },
  SummonTypeText_17 = {
    ID = "SummonTypeText_17",
    CN = "LanguageConfig_SummonTypeText_17_CN|百相自选唤醒"
  },
  SummonRulesTitle = {
    ID = "SummonRulesTitle",
    CN = "LanguageConfig_SummonRulesTitle_CN|唤醒规则"
  },
  SummonNoCallbackTips = {
    ID = "SummonNoCallbackTips",
    CN = "LanguageConfig_SummonNoCallbackTips_CN|上一次唤醒尚未完成，请稍候"
  },
  ConvertedToFragment = {
    ID = "ConvertedToFragment",
    CN = "LanguageConfig_ConvertedToFragment_CN|已转换"
  },
  AwakerFragment = {
    ID = "AwakerFragment",
    CN = "LanguageConfig_AwakerFragment_CN|{s1}的碎片"
  },
  SummonDailyDiscount = {
    ID = "SummonDailyDiscount",
    CN = "LanguageConfig_SummonDailyDiscount_CN|今日限定一次"
  },
  SummonDailyRecommend = {
    ID = "SummonDailyRecommend",
    CN = "LanguageConfig_SummonDailyRecommend_CN|今日推荐"
  },
  SummonRulesExtraTxt1 = {
    ID = "SummonRulesExtraTxt1",
    CN = "LanguageConfig_SummonRulesExtraTxt1_CN|次数不足时，如果有额外补偿次数，则以额外补偿次数补足。"
  },
  SummonRulesExtraTxt2 = {
    ID = "SummonRulesExtraTxt2",
    CN = "LanguageConfig_SummonRulesExtraTxt2_CN|当前额外补偿次数：{s1}"
  },
  SummonFirstTitle = {
    ID = "SummonFirstTitle",
    CN = "LanguageConfig_SummonFirstTitle_CN|初回限定"
  },
  SummonFirstDesc = {
    ID = "SummonFirstDesc",
    CN = "LanguageConfig_SummonFirstDesc_CN|首次5连唤醒不满意唤醒结果可无限重抽"
  },
  SummonTrial = {
    ID = "SummonTrial",
    CN = "LanguageConfig_SummonTrial_CN|唤醒体试用"
  },
  ItemType_Material = {
    ID = "ItemType_Material",
    CN = "LanguageConfig_ItemType_Material_CN|素材"
  },
  ItemType_Weapon = {
    ID = "ItemType_Weapon",
    CN = "LanguageConfig_ItemType_Weapon_CN|命轮"
  },
  ItemType_Trinket = {
    ID = "ItemType_Trinket",
    CN = "LanguageConfig_ItemType_Trinket_CN|密契"
  },
  ItemType_Specail = {
    ID = "ItemType_Specail",
    CN = "LanguageConfig_ItemType_Specail_CN|特殊"
  },
  ItemType_Awaker = {
    ID = "ItemType_Awaker",
    CN = "LanguageConfig_ItemType_Awaker_CN|唤醒体"
  },
  PhiloStone = {
    ID = "PhiloStone",
    CN = "LanguageConfig_PhiloStone_CN|黑印"
  },
  PhiloStone_Desc = {
    ID = "PhiloStone_Desc",
    CN = "LanguageConfig_PhiloStone_Desc_CN|融痕渴求的神秘印记，可以用于换取等价物品。"
  },
  ExploreSpiritTitle = {
    ID = "ExploreSpiritTitle",
    CN = "LanguageConfig_ExploreSpiritTitle_CN|压力过载（压力废弃）"
  },
  ExploreSpiritDesc = {
    ID = "ExploreSpiritDesc",
    CN = "LanguageConfig_ExploreSpiritDesc_CN|不知从何而来的目光如有实体地压在你身上。你感到呼吸困难，眼前逐渐模糊……（压力废弃）"
  },
  ExploreCurseTitle = {
    ID = "ExploreCurseTitle",
    CN = "LanguageConfig_ExploreCurseTitle_CN|症状（压力废弃）"
  },
  ExploreCurseDesc = {
    ID = "ExploreCurseDesc",
    CN = "LanguageConfig_ExploreCurseDesc_CN|重压之下，你的精神逐渐紧绷，向某个看不见的临界点不断逼近。（压力废弃）\n\n你获得了{s1}张“{s2}”",
    en = "症状卡名称/数量/症状卡名称"
  },
  ExploreCurseConfirm = {
    ID = "ExploreCurseConfirm",
    CN = "LanguageConfig_ExploreCurseConfirm_CN|承压前进（压力废弃）"
  },
  RelicDeleteCardDesc = {
    ID = "RelicDeleteCardDesc",
    CN = "LanguageConfig_RelicDeleteCardDesc_CN|选择{s1}张卡牌删除"
  },
  EnchantmentAwardTitle = {
    ID = "EnchantmentAwardTitle",
    CN = "LanguageConfig_EnchantmentAwardTitle_CN|选择一张卡牌镶嵌刻印"
  },
  EnchantmentAwardTitle2 = {
    ID = "EnchantmentAwardTitle2",
    CN = "LanguageConfig_EnchantmentAwardTitle2_CN|选择两张卡牌镶嵌刻印"
  },
  RelicAwardTitle = {
    ID = "RelicAwardTitle",
    CN = "LanguageConfig_RelicAwardTitle_CN|选取一个造物"
  },
  EnchantmentAwardFull = {
    ID = "EnchantmentAwardFull",
    CN = "LanguageConfig_EnchantmentAwardFull_CN|所有卡牌均已镶嵌刻印"
  },
  EnchantmentAwardButton = {
    ID = "EnchantmentAwardButton",
    CN = "LanguageConfig_EnchantmentAwardButton_CN|刻印"
  },
  RelicAwardButton = {
    ID = "RelicAwardButton",
    CN = "LanguageConfig_RelicAwardButton_CN|确定"
  },
  EnchantmentAwardLevelUp = {
    ID = "EnchantmentAwardLevelUp",
    CN = "LanguageConfig_EnchantmentAwardLevelUp_CN|幸运刻印！"
  },
  EnchantmentAwardUncheck = {
    ID = "EnchantmentAwardUncheck",
    CN = "LanguageConfig_EnchantmentAwardUncheck_CN|请选择一张卡牌镶嵌刻印"
  },
  RelicAwardUncheck = {
    ID = "RelicAwardUncheck",
    CN = "LanguageConfig_RelicAwardUncheck_CN|请选择一个造物"
  },
  RelicSelectedEnoughHint = {
    ID = "RelicSelectedEnoughHint",
    CN = "LanguageConfig_RelicSelectedEnoughHint_CN|不能选择更多造物了"
  },
  RelicSelectedNotEnoughHint = {
    ID = "RelicSelectedNotEnoughHint",
    CN = "LanguageConfig_RelicSelectedNotEnoughHint_CN|请选择{s1}个造物"
  },
  StoreTitle = {
    ID = "StoreTitle",
    CN = "LanguageConfig_StoreTitle_CN|融痕"
  },
  StoreTitle_Sp = {
    ID = "StoreTitle_Sp",
    CN = "LanguageConfig_StoreTitle_Sp_CN|特殊融痕"
  },
  LeaveSpStore_Tips = {
    ID = "LeaveSpStore_Tips",
    CN = "LanguageConfig_LeaveSpStore_Tips_CN|蠕动的融痕发出嘶哑的低语：\n离开，便再也无法在此处与它会面。"
  },
  StoreBuyConfirm = {
    ID = "StoreBuyConfirm",
    CN = "LanguageConfig_StoreBuyConfirm_CN|确认"
  },
  StoreBuyCancel = {
    ID = "StoreBuyCancel",
    CN = "LanguageConfig_StoreBuyCancel_CN|取消"
  },
  StoreRenewButton = {
    ID = "StoreRenewButton",
    CN = "LanguageConfig_StoreRenewButton_CN|刷新({s1}/{s2})"
  },
  StoreRenewTitle = {
    ID = "StoreRenewTitle",
    CN = "LanguageConfig_StoreRenewTitle_CN|刷新商品"
  },
  StoreRenewTimes = {
    ID = "StoreRenewTimes",
    CN = "LanguageConfig_StoreRenewTimes_CN|剩余{s1}次"
  },
  StoreSoldOut = {
    ID = "StoreSoldOut",
    CN = "LanguageConfig_StoreSoldOut_CN|当前商品已售罄"
  },
  StoreSellCardTimesOut = {
    ID = "StoreSellCardTimesOut",
    CN = "LanguageConfig_StoreSellCardTimesOut_CN|剩余次数不足"
  },
  StoreSellCardNoCard = {
    ID = "StoreSellCardNoCard",
    CN = "LanguageConfig_StoreSellCardNoCard_CN|没有可出售指令卡"
  },
  StoreSellCardTitle = {
    ID = "StoreSellCardTitle",
    CN = "LanguageConfig_StoreSellCardTitle_CN|出售一张指令卡"
  },
  StoreSellCardConfirm = {
    ID = "StoreSellCardConfirm",
    CN = "LanguageConfig_StoreSellCardConfirm_CN|确定"
  },
  StoreSellCardCancel = {
    ID = "StoreSellCardCancel",
    CN = "LanguageConfig_StoreSellCardCancel_CN|取消"
  },
  StoreReleaseTimesOut = {
    ID = "StoreReleaseTimesOut",
    CN = "LanguageConfig_StoreReleaseTimesOut_CN|剩余次数不足"
  },
  StorePhiloStoneLack = {
    ID = "StorePhiloStoneLack",
    CN = "LanguageConfig_StorePhiloStoneLack_CN|黑印不足"
  },
  StoreReleaseNoAwaker = {
    ID = "StoreReleaseNoAwaker",
    CN = "LanguageConfig_StoreReleaseNoAwaker_CN|所有唤醒体均已觉醒"
  },
  VictoryAward = {
    ID = "VictoryAward",
    CN = "LanguageConfig_VictoryAward_CN|获得"
  },
  AwardNodeGetItemTitle = {
    ID = "AwardNodeGetItemTitle",
    CN = "LanguageConfig_AwardNodeGetItemTitle_CN|获得物品"
  },
  AwardNodeGetItemButton = {
    ID = "AwardNodeGetItemButton",
    CN = "LanguageConfig_AwardNodeGetItemButton_CN|确定"
  },
  StoreGoodsTypeItem = {
    ID = "StoreGoodsTypeItem",
    CN = "LanguageConfig_StoreGoodsTypeItem_CN|材料"
  },
  StoreGoodsTypeRelic = {
    ID = "StoreGoodsTypeRelic",
    CN = "LanguageConfig_StoreGoodsTypeRelic_CN|造物"
  },
  StoreGoodsTypeEnchantment = {
    ID = "StoreGoodsTypeEnchantment",
    CN = "LanguageConfig_StoreGoodsTypeEnchantment_CN|刻印"
  },
  StoreEnchantmentConfirmTitle = {
    ID = "StoreEnchantmentConfirmTitle",
    CN = "LanguageConfig_StoreEnchantmentConfirmTitle_CN|确定刻印此卡"
  },
  StoreEnchantmentConfirm = {
    ID = "StoreEnchantmentConfirm",
    CN = "LanguageConfig_StoreEnchantmentConfirm_CN|确认"
  },
  StoreEnchantmentCancel = {
    ID = "StoreEnchantmentCancel",
    CN = "LanguageConfig_StoreEnchantmentCancel_CN|取消"
  },
  StoreAwakerAwake = {
    ID = "StoreAwakerAwake",
    CN = "LanguageConfig_StoreAwakerAwake_CN|唤醒体觉醒"
  },
  StoreSellCardPrice = {
    ID = "StoreSellCardPrice",
    CN = "LanguageConfig_StoreSellCardPrice_CN|获得{s1}黑印"
  },
  StoreSellCard = {
    ID = "StoreSellCard",
    CN = "LanguageConfig_StoreSellCard_CN|出售一张指令卡"
  },
  ExploreStressMax = {
    ID = "ExploreStressMax",
    CN = "LanguageConfig_ExploreStressMax_CN|MAX"
  },
  ExploreStressMaxReduceMaxHP = {
    ID = "ExploreStressMaxReduceMaxHP",
    CN = "LanguageConfig_ExploreStressMaxReduceMaxHP_CN|{s1}生命上限"
  },
  ExploreStressRaise = {
    ID = "ExploreStressRaise",
    CN = "LanguageConfig_ExploreStressRaise_CN|+{s1}压力"
  },
  MultiLifeReduceStar = {
    ID = "MultiLifeReduceStar",
    CN = "LanguageConfig_MultiLifeReduceStar_CN|本次通关评价将降为{s1}星"
  },
  LevelFailureGuide = {
    ID = "LevelFailureGuide",
    CN = "LanguageConfig_LevelFailureGuide_CN|·提升唤醒体等级\n·强化唤醒体技能\n·叠位命轮\n·强化密契\n·激活启灵"
  },
  RelicStoreTitle = {
    ID = "RelicStoreTitle",
    CN = "LanguageConfig_RelicStoreTitle_CN|造物融痕"
  },
  EnchantStoreTitle = {
    ID = "EnchantStoreTitle",
    CN = "LanguageConfig_EnchantStoreTitle_CN|刻印融痕"
  },
  KPLevel = {
    ID = "KPLevel",
    CN = "LanguageConfig_KPLevel_CN|守密人"
  },
  AchievementGet = {
    ID = "AchievementGet",
    CN = "LanguageConfig_AchievementGet_CN|达成成就"
  },
  NextStep = {
    ID = "NextStep",
    CN = "LanguageConfig_NextStep_CN|下一步"
  },
  ResearchComplete = {
    ID = "ResearchComplete",
    CN = "LanguageConfig_ResearchComplete_CN|完成调查"
  },
  DataStatistics = {
    ID = "DataStatistics",
    CN = "LanguageConfig_DataStatistics_CN|数据统计"
  },
  FunctionNotComplete = {
    ID = "FunctionNotComplete",
    CN = "LanguageConfig_FunctionNotComplete_CN|功能未完成"
  },
  PromoteMethod = {
    ID = "PromoteMethod",
    CN = "LanguageConfig_PromoteMethod_CN|提升方式"
  },
  FailureConfirm = {
    ID = "FailureConfirm",
    CN = "LanguageConfig_FailureConfirm_CN|止步于此"
  },
  FailureHint = {
    ID = "FailureHint",
    CN = "LanguageConfig_FailureHint_CN|提升唤醒体的力量后，再来挑战强敌吧！"
  },
  RemoveCardHint = {
    ID = "RemoveCardHint",
    CN = "LanguageConfig_RemoveCardHint_CN|被删除的卡牌将在本局调查中永久移除，请谨慎选择"
  },
  CellCardHint = {
    ID = "CellCardHint",
    CN = "LanguageConfig_CellCardHint_CN|被出售的卡牌将在本局调查中永久移除，请谨慎选择"
  },
  AllAwakerAwaked = {
    ID = "AllAwakerAwaked",
    CN = "LanguageConfig_AllAwakerAwaked_CN|全部唤醒体已觉醒"
  },
  NoAwakerAwaked = {
    ID = "NoAwakerAwaked",
    CN = "LanguageConfig_NoAwakerAwaked_CN|无已觉醒的唤醒体"
  },
  DailyChallengeEnterButton = {
    ID = "DailyChallengeEnterButton",
    CN = "LanguageConfig_DailyChallengeEnterButton_CN|挑战"
  },
  DailyChallengeEnterButtonGreyTips = {
    ID = "DailyChallengeEnterButtonGreyTips",
    CN = "LanguageConfig_DailyChallengeEnterButtonGreyTips_CN|请选择挑战共鸣项"
  },
  DailyChallengeLockedResonanceTips = {
    ID = "DailyChallengeLockedResonanceTips",
    CN = "LanguageConfig_DailyChallengeLockedResonanceTips_CN|完成上级共鸣挑战解锁"
  },
  DailyChallengeStarAward = {
    ID = "DailyChallengeStarAward",
    CN = "LanguageConfig_DailyChallengeStarAward_CN|{s1}/{s2}"
  },
  DailyChallengeTodayRelicTitle = {
    ID = "DailyChallengeTodayRelicTitle",
    CN = "LanguageConfig_DailyChallengeTodayRelicTitle_CN|本日造物"
  },
  DailyChallengeTodayStarTitle = {
    ID = "DailyChallengeTodayStarTitle",
    CN = "LanguageConfig_DailyChallengeTodayStarTitle_CN|本日最高星级"
  },
  DailyChallengeStarAwardShort = {
    ID = "DailyChallengeStarAwardShort",
    CN = "LanguageConfig_DailyChallengeStarAwardShort_CN|还差{s1}<Star>获得下阶段奖励"
  },
  DailyChallengeResonanceSelectTitle = {
    ID = "DailyChallengeResonanceSelectTitle",
    CN = "LanguageConfig_DailyChallengeResonanceSelectTitle_CN|可选共鸣"
  },
  DailyChallengeChosenResonanceTitle = {
    ID = "DailyChallengeChosenResonanceTitle",
    CN = "LanguageConfig_DailyChallengeChosenResonanceTitle_CN|已选共鸣"
  },
  DailyChallengeClearButton = {
    ID = "DailyChallengeClearButton",
    CN = "LanguageConfig_DailyChallengeClearButton_CN|清空"
  },
  DailyChallengeChosenStar = {
    ID = "DailyChallengeChosenStar",
    CN = "LanguageConfig_DailyChallengeChosenStar_CN|当前星级"
  },
  DailyChallengeTodayRelicGetTitle = {
    ID = "DailyChallengeTodayRelicGetTitle",
    CN = "LanguageConfig_DailyChallengeTodayRelicGetTitle_CN|获得每日造物"
  },
  DailyChallengeUnlockNewResonanceTitle = {
    ID = "DailyChallengeUnlockNewResonanceTitle",
    CN = "LanguageConfig_DailyChallengeUnlockNewResonanceTitle_CN|解锁新共鸣"
  },
  DailyChallengeUnlockNewResonanceConfirmButton = {
    ID = "DailyChallengeUnlockNewResonanceConfirmButton",
    CN = "LanguageConfig_DailyChallengeUnlockNewResonanceConfirmButton_CN|确定"
  },
  DailyChallengeAwardPreviewTitle = {
    ID = "DailyChallengeAwardPreviewTitle",
    CN = "LanguageConfig_DailyChallengeAwardPreviewTitle_CN|奖励预览"
  },
  DailyChallengeTodayRelicGetConfirmButton = {
    ID = "DailyChallengeTodayRelicGetConfirmButton",
    CN = "LanguageConfig_DailyChallengeTodayRelicGetConfirmButton_CN|确定"
  },
  BagCapacity = {
    ID = "BagCapacity",
    CN = "LanguageConfig_BagCapacity_CN|数量 {s1} / {s2}"
  },
  BagWeaponTitle = {
    ID = "BagWeaponTitle",
    CN = "LanguageConfig_BagWeaponTitle_CN|命轮"
  },
  BagTrinketTitle = {
    ID = "BagTrinketTitle",
    CN = "LanguageConfig_BagTrinketTitle_CN|密契"
  },
  BagMaterialTitle = {
    ID = "BagMaterialTitle",
    CN = "LanguageConfig_BagMaterialTitle_CN|材料"
  },
  BagSpecialTitle = {
    ID = "BagSpecialTitle",
    CN = "LanguageConfig_BagSpecialTitle_CN|消耗品"
  },
  BagWeaponEnTitle = {
    ID = "BagWeaponEnTitle",
    CN = "LanguageConfig_BagWeaponEnTitle_CN|Weapon"
  },
  BagTrinketEnTitle = {
    ID = "BagTrinketEnTitle",
    CN = "LanguageConfig_BagTrinketEnTitle_CN|Trinket"
  },
  BagMaterialEnTitle = {
    ID = "BagMaterialEnTitle",
    CN = "LanguageConfig_BagMaterialEnTitle_CN|Material"
  },
  BagSpecialEnTitle = {
    ID = "BagSpecialEnTitle",
    CN = "LanguageConfig_BagSpecialEnTitle_CN|Special"
  },
  BagTitle = {
    ID = "BagTitle",
    CN = "LanguageConfig_BagTitle_CN|物资"
  },
  BagEmptyTitle = {
    ID = "BagEmptyTitle",
    CN = "LanguageConfig_BagEmptyTitle_CN|暂无{s1}道具"
  },
  BagWeaponEmptyDesc = {
    ID = "BagWeaponEmptyDesc",
    CN = "LanguageConfig_BagWeaponEmptyDesc_CN|可通过唤醒获取"
  },
  BagTrinketEmptyDesc = {
    ID = "BagTrinketEmptyDesc",
    CN = "LanguageConfig_BagTrinketEmptyDesc_CN|可通过禁忌纂录获取"
  },
  BagMaterialEmptyDesc = {
    ID = "BagMaterialEmptyDesc",
    CN = "LanguageConfig_BagMaterialEmptyDesc_CN|可通过调查和幕间演习获取"
  },
  BagSpecialEmptyDesc = {
    ID = "BagSpecialEmptyDesc",
    CN = "LanguageConfig_BagSpecialEmptyDesc_CN|可通过特定途径获取"
  },
  AwakerChipTypeName = {
    ID = "AwakerChipTypeName",
    CN = "LanguageConfig_AwakerChipTypeName_CN|唤醒体残片"
  },
  TrinketMaterialTypeName = {
    ID = "TrinketMaterialTypeName",
    CN = "LanguageConfig_TrinketMaterialTypeName_CN|密契材料"
  },
  ResonanceParticleTypeName = {
    ID = "ResonanceParticleTypeName",
    CN = "LanguageConfig_ResonanceParticleTypeName_CN|共鸣粒子"
  },
  SkillMaterialTypeName = {
    ID = "SkillMaterialTypeName",
    CN = "LanguageConfig_SkillMaterialTypeName_CN|技能材料"
  },
  StoryItemTypeName = {
    ID = "StoryItemTypeName",
    CN = "LanguageConfig_StoryItemTypeName_CN|剧情道具"
  },
  SpecialMaterialTypeName = {
    ID = "SpecialMaterialTypeName",
    CN = "LanguageConfig_SpecialMaterialTypeName_CN|特殊材料"
  },
  WeaponTypeName = {
    ID = "WeaponTypeName",
    CN = "LanguageConfig_WeaponTypeName_CN|命轮"
  },
  TrinketTypeName = {
    ID = "TrinketTypeName",
    CN = "LanguageConfig_TrinketTypeName_CN|密契"
  },
  ConsumeItemTypeName = {
    ID = "ConsumeItemTypeName",
    CN = "LanguageConfig_ConsumeItemTypeName_CN|消耗品"
  },
  ChestTypeName = {
    ID = "ChestTypeName",
    CN = "LanguageConfig_ChestTypeName_CN|宝箱"
  },
  DropItemTypeName = {
    ID = "DropItemTypeName",
    CN = "LanguageConfig_DropItemTypeName_CN|礼盒"
  },
  TopBarItemTypeName = {
    ID = "TopBarItemTypeName",
    CN = "LanguageConfig_TopBarItemTypeName_CN|通用货币"
  },
  FastPromotionTypeName = {
    ID = "FastPromotionTypeName",
    CN = "LanguageConfig_FastPromotionTypeName_CN|灵知增幅器"
  },
  TipsRefineLevel = {
    ID = "TipsRefineLevel",
    CN = "LanguageConfig_TipsRefineLevel_CN|叠位{s1}阶"
  },
  TipsOriginTitle = {
    ID = "TipsOriginTitle",
    CN = "LanguageConfig_TipsOriginTitle_CN|来源"
  },
  TipsAwakerEquip = {
    ID = "TipsAwakerEquip",
    CN = "LanguageConfig_TipsAwakerEquip_CN|{s1}已装备"
  },
  CosmeticsRandChestRateTitle = {
    ID = "CosmeticsRandChestRateTitle",
    CN = "LanguageConfig_CosmeticsRandChestRateTitle_CN|概率说明"
  },
  CosmeticsRandChestRateText = {
    ID = "CosmeticsRandChestRateText",
    CN = "LanguageConfig_CosmeticsRandChestRateText_CN|<Title:概率说明>\n1、每次使用后有 10% 的概率获得无形者礼券的「专属头像和对战表情」，90%的概率获得往期核心课题、相位对弈赛季的限定头像和对战表情。\n2、所有专属头像和对战表情均分 10% 概率。具体可查看下文的「专属头像和对战表情清单」。\n3、核心课题的限定头像和对战表情将在该期学期课题结束约 1 年后会加入掉落清单。相位对弈赛季奖励的对战表情则将在该赛季结束后立即加入掉落清单。\n4、所有往期限定头像和对战表情均分 90%的概率。特别的，「无形者的请柬」也视为 1 个往期限定头像和对战表情，当掉落清单中没有其他往期限定头像和对战表情时，此时「无形者的请柬」独占90%的概率。\n5、当获得已有的头像或表情时，将转换为「无形者的请柬」× 1。收集一定数量的「无形者的请柬」使用，可任选一个「无形者的礼券」中的未获得的头像或对战表情。\n\n<Title:专属头像和对战表情清单>\n1、专属头像包括：\n以银钥之名：艾尔瓦、以银钥之名：戈利亚、以银钥之名：尤乌哈希、以银钥之名：卡茜亚、以银钥之名：诃勒特、以银钥之名：德克斯特、以银钥之名：茜尔维亚、以银钥之名：威廉。\n2、专属对战表情包括：\n发疯弥萨格：尤乌哈希·我要、发疯弥萨格：布朗·不知道、发疯弥萨格：希洛·杀杀杀、轻松弥萨格：茜尔维亚·喝茶、轻松弥萨格：诃勒特·熬夜、轻松弥萨格：奥吉尔·敬礼、轻松弥萨格：萝坦·哥俩好、轻松弥萨格：拉蒙娜·扶额、轻松弥萨格：朵尔·电量不足、相位通讯：守密人·我？、智慧弥萨格：戈利亚·强、智慧弥萨格：雷娅·流泪、智慧弥萨格：诺缔拉·诶？、智慧弥萨格：詹金·思索、智慧弥萨格：阿格里帕·暗中观察、智慧弥萨格：凯刻斯·记仇、小小弥萨格：詹金·吐舌。"
  },
  WeaponRefineLevel = {
    ID = "WeaponRefineLevel",
    CN = "LanguageConfig_WeaponRefineLevel_CN|叠位{s1}阶"
  },
  AwakerSkillUpgradeTips = {
    ID = "AwakerSkillUpgradeTips",
    CN = "LanguageConfig_AwakerSkillUpgradeTips_CN|升格等阶{s1}可继续升级"
  },
  AwakerSkillValueTips = {
    ID = "AwakerSkillValueTips",
    CN = "LanguageConfig_AwakerSkillValueTips_CN|消耗算力: {s1}"
  },
  QualityOrange = {
    ID = "QualityOrange",
    CN = "LanguageConfig_QualityOrange_CN|SSR",
    en = "SSR"
  },
  QualityPurple = {
    ID = "QualityPurple",
    CN = "LanguageConfig_QualityPurple_CN|SR",
    en = "SR"
  },
  QualityBlue = {
    ID = "QualityBlue",
    CN = "LanguageConfig_QualityBlue_CN|R",
    en = "R"
  },
  QualityWhite = {
    ID = "QualityWhite",
    CN = "LanguageConfig_QualityWhite_CN|N"
  },
  AwakerDetailButton = {
    ID = "AwakerDetailButton",
    CN = "LanguageConfig_AwakerDetailButton_CN|详 情",
    en = "详 情"
  },
  AwakerUpgradeButton = {
    ID = "AwakerUpgradeButton",
    CN = "LanguageConfig_AwakerUpgradeButton_CN|升 级",
    en = "升 级"
  },
  WeaponExclusiveTips = {
    ID = "WeaponExclusiveTips",
    CN = "LanguageConfig_WeaponExclusiveTips_CN|当装备者为{s1}时，{s2}的所有卡牌变成金色。"
  },
  CombatEffectiveness = {
    ID = "CombatEffectiveness",
    CN = "LanguageConfig_CombatEffectiveness_CN|战力"
  },
  AwakerSkillExaltTips = {
    ID = "AwakerSkillExaltTips",
    CN = "LanguageConfig_AwakerSkillExaltTips_CN|消耗狂气: {s1}"
  },
  Battle_Uenergy_Float = {
    ID = "Battle_Uenergy_Float",
    CN = "LanguageConfig_Battle_Uenergy_Float_CN|{s1}狂气"
  },
  Card_Select = {
    ID = "Card_Select",
    CN = "LanguageConfig_Card_Select_CN|选择 {s1} 张卡牌"
  },
  ShopConfirmExchange = {
    ID = "ShopConfirmExchange",
    CN = "LanguageConfig_ShopConfirmExchange_CN|确认兑换"
  },
  ShopExchangeQuantity = {
    ID = "ShopExchangeQuantity",
    CN = "LanguageConfig_ShopExchangeQuantity_CN|兑换数量"
  },
  Relic_Select = {
    ID = "Relic_Select",
    CN = "LanguageConfig_Relic_Select_CN|选择 {s1} 个造物"
  },
  Card_Awaker_Select = {
    ID = "Card_Awaker_Select",
    CN = "LanguageConfig_Card_Awaker_Select_CN|选择能力"
  },
  TrinketLevelUpTips_1 = {
    ID = "TrinketLevelUpTips_1",
    CN = "LanguageConfig_TrinketLevelUpTips_1_CN|增加{s1}条新的追加属性"
  },
  TrinketLevelUpTips_2 = {
    ID = "TrinketLevelUpTips_2",
    CN = "LanguageConfig_TrinketLevelUpTips_2_CN|随机提升{s1}条追加属性"
  },
  TrinketEmptyStateTips = {
    ID = "TrinketEmptyStateTips",
    CN = "LanguageConfig_TrinketEmptyStateTips_CN|尚未拥有当前位置的密契"
  },
  TrinketStrengthenEmptyStateTips_1 = {
    ID = "TrinketStrengthenEmptyStateTips_1",
    CN = "LanguageConfig_TrinketStrengthenEmptyStateTips_1_CN|尚未拥有未装备的密契或素材道具"
  },
  TrinketStrengthenEmptyStateTips_2 = {
    ID = "TrinketStrengthenEmptyStateTips_2",
    CN = "LanguageConfig_TrinketStrengthenEmptyStateTips_2_CN|尚未拥有未装备的命轮"
  },
  WeaponSortTypeName_1 = {
    ID = "WeaponSortTypeName_1",
    CN = "LanguageConfig_WeaponSortTypeName_1_CN|等级"
  },
  WeaponSortTypeName_2 = {
    ID = "WeaponSortTypeName_2",
    CN = "LanguageConfig_WeaponSortTypeName_2_CN|稀有度"
  },
  WeaponSortTypeName_3 = {
    ID = "WeaponSortTypeName_3",
    CN = "LanguageConfig_WeaponSortTypeName_3_CN|获取顺序"
  },
  TrinketStrengthenLockTips_1 = {
    ID = "TrinketStrengthenLockTips_1",
    CN = "LanguageConfig_TrinketStrengthenLockTips_1_CN|当前密契已锁定，解锁以作为素材消耗"
  },
  TrinketStrengthenLockTips_2 = {
    ID = "TrinketStrengthenLockTips_2",
    CN = "LanguageConfig_TrinketStrengthenLockTips_2_CN|当前命轮已锁定，解锁以作为素材消耗"
  },
  MainInterface_Recharge = {
    ID = "MainInterface_Recharge",
    CN = "LanguageConfig_MainInterface_Recharge_CN|商城"
  },
  MainInterface_Awaker = {
    ID = "MainInterface_Awaker",
    CN = "LanguageConfig_MainInterface_Awaker_CN|唤醒体"
  },
  MainInterface_Summon = {
    ID = "MainInterface_Summon",
    CN = "LanguageConfig_MainInterface_Summon_CN|唤醒"
  },
  MainInterface_Bag = {
    ID = "MainInterface_Bag",
    CN = "LanguageConfig_MainInterface_Bag_CN|物资"
  },
  MainInterface_Home = {
    ID = "MainInterface_Home",
    CN = "LanguageConfig_MainInterface_Home_CN|研究中心"
  },
  MainInterface_Shop = {
    ID = "MainInterface_Shop",
    CN = "LanguageConfig_MainInterface_Shop_CN|交换商店"
  },
  MainInterface_Battlepass = {
    ID = "MainInterface_Battlepass",
    CN = "LanguageConfig_MainInterface_Battlepass_CN|通行令"
  },
  MainInterface_Challenge = {
    ID = "MainInterface_Challenge",
    CN = "LanguageConfig_MainInterface_Challenge_CN|幕间演习"
  },
  MainInterface_MainCopy = {
    ID = "MainInterface_MainCopy",
    CN = "LanguageConfig_MainInterface_MainCopy_CN|调查"
  },
  SkillDetailedInformation = {
    ID = "SkillDetailedInformation",
    CN = "LanguageConfig_SkillDetailedInformation_CN|详细信息"
  },
  SkillStowInformation = {
    ID = "SkillStowInformation",
    CN = "LanguageConfig_SkillStowInformation_CN|收起信息"
  },
  ActivationResonance_Tips = {
    ID = "ActivationResonance_Tips",
    CN = "LanguageConfig_ActivationResonance_Tips_CN|共鸣点亮提示"
  },
  TrinketStrengthenSuccess_1 = {
    ID = "TrinketStrengthenSuccess_1",
    CN = "LanguageConfig_TrinketStrengthenSuccess_1_CN|强化成功"
  },
  TrinketStrengthenSuccess_5 = {
    ID = "TrinketStrengthenSuccess_5",
    CN = "LanguageConfig_TrinketStrengthenSuccess_5_CN|强化成功·五倍"
  },
  TrinketStrengthenSuccess_2 = {
    ID = "TrinketStrengthenSuccess_2",
    CN = "LanguageConfig_TrinketStrengthenSuccess_2_CN|强化成功·双倍"
  },
  SkillLevelExUpgrade = {
    ID = "SkillLevelExUpgrade",
    CN = "LanguageConfig_SkillLevelExUpgrade_CN|<AwakerSkill:技能等级+{s1}>"
  },
  AwakerStateInformation = {
    ID = "AwakerStateInformation",
    CN = "LanguageConfig_AwakerStateInformation_CN|详细信息"
  },
  TrinketContrast = {
    ID = "TrinketContrast",
    CN = "LanguageConfig_TrinketContrast_CN|对比"
  },
  TrinketStow = {
    ID = "TrinketStow",
    CN = "LanguageConfig_TrinketStow_CN|收起"
  },
  TrinketEquipped = {
    ID = "TrinketEquipped",
    CN = "LanguageConfig_TrinketEquipped_CN|已装备"
  },
  ItemEquipping = {
    ID = "ItemEquipping",
    CN = "LanguageConfig_ItemEquipping_CN|当前装备"
  },
  TrinketStrengthenItemNum_1 = {
    ID = "TrinketStrengthenItemNum_1",
    CN = "LanguageConfig_TrinketStrengthenItemNum_1_CN|密契 {s1}"
  },
  TrinketStrengthenItemNum_2 = {
    ID = "TrinketStrengthenItemNum_2",
    CN = "LanguageConfig_TrinketStrengthenItemNum_2_CN|命轮 {s1}"
  },
  LoginInterface_Announcement = {
    ID = "LoginInterface_Announcement",
    CN = "LanguageConfig_LoginInterface_Announcement_CN|告示"
  },
  LoginInterface_Btn_Enter = {
    ID = "LoginInterface_Btn_Enter",
    CN = "LanguageConfig_LoginInterface_Btn_Enter_CN|进入大学"
  },
  AwakerSystemClose = {
    ID = "AwakerSystemClose",
    CN = "LanguageConfig_AwakerSystemClose_CN|close"
  },
  AwakerSystemBack = {
    ID = "AwakerSystemBack",
    CN = "LanguageConfig_AwakerSystemBack_CN|back"
  },
  Battle_Btn_BeDamageInfo = {
    ID = "Battle_Btn_BeDamageInfo",
    CN = "LanguageConfig_Battle_Btn_BeDamageInfo_CN|敌方伤害总量"
  },
  Battle_Btn_TurnInfo = {
    ID = "Battle_Btn_TurnInfo",
    CN = "LanguageConfig_Battle_Btn_TurnInfo_CN|回合数"
  },
  Battle_Btn_GoldInfo = {
    ID = "Battle_Btn_GoldInfo",
    CN = "LanguageConfig_Battle_Btn_GoldInfo_CN|黑印"
  },
  SummonRepetitiveAwaker = {
    ID = "SummonRepetitiveAwaker",
    CN = "LanguageConfig_SummonRepetitiveAwaker_CN|重复唤醒体，已转化"
  },
  SummonExtraItem = {
    ID = "SummonExtraItem",
    CN = "LanguageConfig_SummonExtraItem_CN|额外赠送"
  },
  SummonAwakerFragment = {
    ID = "SummonAwakerFragment",
    CN = [[
LanguageConfig_SummonAwakerFragment_CN|{s1}
*{s2}]]
  },
  SummonCountdown = {
    ID = "SummonCountdown",
    CN = "LanguageConfig_SummonCountdown_CN|剩余时间：\n{s1}"
  },
  SmallPotencyTitle = {
    ID = "SmallPotencyTitle",
    CN = "LanguageConfig_SmallPotencyTitle_CN|共用"
  },
  BigPotencyDesc = {
    ID = "BigPotencyDesc",
    CN = "LanguageConfig_BigPotencyDesc_CN|核心启灵（已废弃）"
  },
  SmallPotencyDesc = {
    ID = "SmallPotencyDesc",
    CN = "LanguageConfig_SmallPotencyDesc_CN|次级启灵（已废弃）"
  },
  TrinketSuitEffect = {
    ID = "TrinketSuitEffect",
    CN = "LanguageConfig_TrinketSuitEffect_CN|{s1}件套: {s2}"
  },
  WeekChallengeRewardHaveBeenObtained = {
    ID = "WeekChallengeRewardHaveBeenObtained",
    CN = "LanguageConfig_WeekChallengeRewardHaveBeenObtained_CN|已获取全部奖励"
  },
  WeekChallengeRewardsPreview = {
    ID = "WeekChallengeRewardsPreview",
    CN = "LanguageConfig_WeekChallengeRewardsPreview_CN|挑战奖励预览"
  },
  WeekChallengeStarNumReach = {
    ID = "WeekChallengeStarNumReach",
    CN = "LanguageConfig_WeekChallengeStarNumReach_CN|当前挑战星数达到"
  },
  WeekChallengeNotReached = {
    ID = "WeekChallengeNotReached",
    CN = "LanguageConfig_WeekChallengeNotReached_CN|未达成"
  },
  WeekChallengeNotReached_1 = {
    ID = "WeekChallengeNotReached_1",
    CN = "LanguageConfig_WeekChallengeNotReached_1_CN|尚未达到下一阶段的奖励要求或所有奖励均已被领取"
  },
  WeekChallengeAwakerCannotChoose = {
    ID = "WeekChallengeAwakerCannotChoose",
    CN = "LanguageConfig_WeekChallengeAwakerCannotChoose_CN|精疲力竭"
  },
  LeftCountText = {
    ID = "LeftCountText",
    CN = "LanguageConfig_LeftCountText_CN|剩余次数"
  },
  DailyChallengeTips = {
    ID = "DailyChallengeTips",
    CN = "LanguageConfig_DailyChallengeTips_CN|幕间演习：所有唤醒体等级、技能等级、调整为 1 级，造物的强度与守密人调查等级为 1 时的强度一致。"
  },
  TrinketStrengthentTips = {
    ID = "TrinketStrengthentTips",
    CN = "LanguageConfig_TrinketStrengthentTips_CN|请选择要强化的密契"
  },
  TeamTypeTips_Def = {
    ID = "TeamTypeTips_Def",
    CN = "LanguageConfig_TeamTypeTips_Def_CN|队伍中缺少防御型唤醒体"
  },
  TeamTypeTips_Atk = {
    ID = "TeamTypeTips_Atk",
    CN = "LanguageConfig_TeamTypeTips_Atk_CN|队伍中缺少攻击型唤醒体"
  },
  TeamTypeTips_Auxiliary = {
    ID = "TeamTypeTips_Auxiliary",
    CN = "LanguageConfig_TeamTypeTips_Auxiliary_CN|队伍中缺少辅助型唤醒体"
  },
  Monster_S0202_1 = {
    ID = "Monster_S0202_1",
    CN = "LanguageConfig_Monster_S0202_1_CN|咯吱…（磨牙声）…"
  },
  Monster_S0103_1 = {
    ID = "Monster_S0103_1",
    CN = "LanguageConfig_Monster_S0103_1_CN|维度之孔使你失去了部分力量……"
  },
  Monster_S0103_2 = {
    ID = "Monster_S0103_2",
    CN = "LanguageConfig_Monster_S0103_2_CN|维度之孔的攻击中充满了电流…"
  },
  Monster_S0303_1 = {
    ID = "Monster_S0303_1",
    CN = "LanguageConfig_Monster_S0303_1_CN|「聆听启示」强化了所有敌人！"
  },
  Monster_S0303_2 = {
    ID = "Monster_S0303_2",
    CN = "LanguageConfig_Monster_S0303_2_CN|「固守之执妄」强化了所有敌人！"
  },
  Monster_C0102_AT_1 = {
    ID = "Monster_C0102_AT_1",
    CN = "LanguageConfig_Monster_C0102_AT_1_CN|敌人变得疯狂了！对其展开攻击来降低威胁！"
  },
  Monster_C0102_AT_2 = {
    ID = "Monster_C0102_AT_2",
    CN = "LanguageConfig_Monster_C0102_AT_2_CN|敌人正在准备进行一记重击！"
  },
  Monster_AF_C09 = {
    ID = "Monster_AF_C09",
    CN = "LanguageConfig_Monster_AF_C09_CN|潘狄娅会狠狠惩罚胆敢攻击她的坏孩子……"
  },
  Monster_S0203_1 = {
    ID = "Monster_S0203_1",
    CN = "LanguageConfig_Monster_S0203_1_CN|西区佬，送你一点小礼物，接着！"
  },
  Monster_S0203_2 = {
    ID = "Monster_S0203_2",
    CN = "LanguageConfig_Monster_S0203_2_CN|詹金召唤了鼠群…攻击她会使鼠群更加愤怒！"
  },
  Monster_S0203_3 = {
    ID = "Monster_S0203_3",
    CN = "LanguageConfig_Monster_S0203_3_CN|头好晕…有点难以招架攻击了…"
  },
  Monster_xiluo1 = {
    ID = "Monster_xiluo1",
    CN = "LanguageConfig_Monster_xiluo1_CN|我将舍弃圣女之命。"
  },
  Monster_xiluo2 = {
    ID = "Monster_xiluo2",
    CN = "LanguageConfig_Monster_xiluo2_CN|那是不被容许的怜悯吗？"
  },
  Monster_xiluo3 = {
    ID = "Monster_xiluo3",
    CN = "LanguageConfig_Monster_xiluo3_CN|我曾是你的掌上明珠……"
  },
  Monster_xiluo0 = {
    ID = "Monster_xiluo0",
    CN = "LanguageConfig_Monster_xiluo0_CN|聆听吧，复仇者的愤怒！"
  },
  Monster_shuilian1 = {
    ID = "Monster_shuilian1",
    CN = "LanguageConfig_Monster_shuilian1_CN|请不要接近我……"
  },
  Monster_shuilian2 = {
    ID = "Monster_shuilian2",
    CN = "LanguageConfig_Monster_shuilian2_CN|我并不想伤害你们……"
  },
  Monster_shuilian3 = {
    ID = "Monster_shuilian3",
    CN = "LanguageConfig_Monster_shuilian3_CN|请不要再前进了……"
  },
  Monster_B0001_1 = {
    ID = "Monster_B0001_1",
    CN = "LanguageConfig_Monster_B0001_1_CN|你感觉身体逐渐变得沉重，难以给唤醒体下指令…"
  },
  Monster_B0001_2 = {
    ID = "Monster_B0001_2",
    CN = "LanguageConfig_Monster_B0001_2_CN|对不起…"
  },
  Monster_B0001_3 = {
    ID = "Monster_B0001_3",
    CN = "LanguageConfig_Monster_B0001_3_CN|当心！本回合未被打出的卡牌都将化为石头…"
  },
  Monster_S0302_1 = {
    ID = "Monster_S0302_1",
    CN = "LanguageConfig_Monster_S0302_1_CN|超脱之俯仰进行鲜血仪式，每回合都会强化！…"
  },
  Monster_B0002_1 = {
    ID = "Monster_B0002_1",
    CN = "LanguageConfig_Monster_B0002_1_CN|好饿，乔治好饿……"
  },
  Monster_B0002_2 = {
    ID = "Monster_B0002_2",
    CN = "LanguageConfig_Monster_B0002_2_CN|不要抛弃乔治，不要抛弃我们……！"
  },
  Monster_B0004_1 = {
    ID = "Monster_B0004_1",
    CN = "LanguageConfig_Monster_B0004_1_CN|「梭行维度之犬」盯上你了……注意维度裂隙，放入卡牌来保护自己！"
  },
  Monster_B0004_2 = {
    ID = "Monster_B0004_2",
    CN = "LanguageConfig_Monster_B0004_2_CN|撕裂……现实！"
  },
  Monster_LT_1 = {
    ID = "Monster_LT_1",
    CN = "LanguageConfig_Monster_LT_1_CN|敌人准备释放「灵知觉醒」来逆转局势！此时免疫一切伤害…"
  },
  Monster_KM_1 = {
    ID = "Monster_KM_1",
    CN = "LanguageConfig_Monster_KM_1_CN|敌人叠加了「反击」状态，谨慎采取攻击！"
  },
  Monster_XL_1 = {
    ID = "Monster_XL_1",
    CN = "LanguageConfig_Monster_XL_1_CN|敌人大幅强化了「力量」，小心！"
  },
  Monster_LL_1 = {
    ID = "Monster_LL_1",
    CN = "LanguageConfig_Monster_LL_1_CN|敌人受到一定程度伤害后将会转变行动方式！"
  },
  Monster_LL_2 = {
    ID = "Monster_LL_2",
    CN = "LanguageConfig_Monster_LL_2_CN|敌人的护盾值在回合结束时将转化为生命，击破它吧！"
  },
  Monster_MadHorse_1 = {
    ID = "Monster_MadHorse_1",
    CN = "LanguageConfig_Monster_MadHorse_1_CN|一回合内的每次伤害都会扩大敌人的融蚀伤口。"
  },
  Monster_MadHorse_2 = {
    ID = "Monster_MadHorse_2",
    CN = "LanguageConfig_Monster_MadHorse_2_CN|如果没完全挡住伤害，会获得额外的「伤口」。"
  },
  Monster_TDJZ_1 = {
    ID = "Monster_TDJZ_1",
    CN = "LanguageConfig_Monster_TDJZ_1_CN|你被施加了「出血」状态，可以通过治疗进行解除。"
  },
  Monster_TDJZ_2 = {
    ID = "Monster_TDJZ_2",
    CN = "LanguageConfig_Monster_TDJZ_2_CN|处于「祈祷」状态下会大大提升攻击次数，需要对其造成伤害来进行削减。"
  },
  Monster_WDZZ_1 = {
    ID = "Monster_WDZZ_1",
    CN = "LanguageConfig_Monster_WDZZ_1_CN|唤醒体的「狂气爆发」技能本回合被封印。"
  },
  Monster_DYQ_1 = {
    ID = "Monster_DYQ_1",
    CN = "LanguageConfig_Monster_DYQ_1_CN|敌人被「维度障壁」环绕，生命减少到一定程度后会获得大量护盾。"
  },
  Monster_LLZ_1 = {
    ID = "Monster_LLZ_1",
    CN = "LanguageConfig_Monster_LLZ_1_CN|猎颅者正在进行追猎，每抽一张牌都会引起他的关注！"
  },
  Monster_LLZ_2 = {
    ID = "Monster_LLZ_2",
    CN = "LanguageConfig_Monster_LLZ_2_CN|猎颅者正在狩猎一名唤醒体，他的行动会引发猎颅者的寻踪本能！"
  },
  Monster_BZLLZ_1 = {
    ID = "Monster_BZLLZ_1",
    CN = "LanguageConfig_Monster_BZLLZ_1_CN|猎颅者正在狩猎一名唤醒体，他的行动会强化猎颅者！"
  },
  Awaker_Select_Get_Tips1 = {
    ID = "Awaker_Select_Get_Tips1",
    CN = "LanguageConfig_Awaker_Select_Get_Tips1_CN|测试测试选择唤醒体"
  },
  Card_Select_Get_Tipsfengrang = {
    ID = "Card_Select_Get_Tipsfengrang",
    CN = "LanguageConfig_Card_Select_Get_Tipsfengrang_CN|选择 1 张手牌，将其 3 张复制洗入抽牌堆。"
  },
  Card_Select_Get_Tipslaxiang = {
    ID = "Card_Select_Get_Tipslaxiang",
    CN = "LanguageConfig_Card_Select_Get_Tipslaxiang_CN|选择 1 张手牌，使其算力消耗变为 0，"
  },
  Card_Select_Get_Tipszhuiyi = {
    ID = "Card_Select_Get_Tipszhuiyi",
    CN = "LanguageConfig_Card_Select_Get_Tipszhuiyi_CN|选择 1 个追忆效果并释放。"
  },
  Card_Select_Get_Tipspikeman2 = {
    ID = "Card_Select_Get_Tipspikeman2",
    CN = "LanguageConfig_Card_Select_Get_Tipspikeman2_CN|选择并获取 1 个皮克曼创构的造物。"
  },
  Card_Select_Get_Tipspikeman1 = {
    ID = "Card_Select_Get_Tipspikeman1",
    CN = "LanguageConfig_Card_Select_Get_Tipspikeman1_CN|选择 1 张卡牌置入手中，并为其赋予「消耗」和「保留」。"
  },
  Card_Select_Get_Tipstiaojiu1 = {
    ID = "Card_Select_Get_Tipstiaojiu1",
    CN = "LanguageConfig_Card_Select_Get_Tipstiaojiu1_CN|选择 1 味调料，在本场战斗中将其永久置入「祭灵夜特调」。"
  },
  Card_Select_Get_Tipsxiaomao = {
    ID = "Card_Select_Get_Tipsxiaomao",
    CN = "LanguageConfig_Card_Select_Get_Tipsxiaomao_CN|选择 1 名唤醒体，将其支援卡置入手中。"
  },
  Card_Select_Get_Tipslamengna = {
    ID = "Card_Select_Get_Tipslamengna",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna_CN|选择 1 张牌加入手中，其余卡牌置入弃牌堆。"
  },
  Card_Select_Get_Tipslamengna2 = {
    ID = "Card_Select_Get_Tipslamengna2",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna2_CN|选择 1 张牌赋予「回声」刻印，其余卡牌置入弃牌堆。"
  },
  Card_Select_Get_Tipslamengna3 = {
    ID = "Card_Select_Get_Tipslamengna3",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna3_CN|选择任意张卡牌弃置，抽取等量卡牌。"
  },
  Card_Select_Get_Tipslamengna4 = {
    ID = "Card_Select_Get_Tipslamengna4",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna4_CN|选择 1 张卡牌，使其算力消耗-1。"
  },
  Card_Select_Get_Tipslamengna5 = {
    ID = "Card_Select_Get_Tipslamengna5",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna5_CN|选择 1 张非衍生指令卡"
  },
  Card_Select_Get_Tipslamengna6 = {
    ID = "Card_Select_Get_Tipslamengna6",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna6_CN|选择任意张卡牌弃置，每弃置 1 张临时暴击伤害+15％"
  },
  Card_Select_Get_Tipslamengna7 = {
    ID = "Card_Select_Get_Tipslamengna7",
    CN = "LanguageConfig_Card_Select_Get_Tipslamengna7_CN|选择 1 张卡牌，将其临时复制置入手中并使其算力消耗-1。"
  },
  Card_Select_Get_Tips1 = {
    ID = "Card_Select_Get_Tips1",
    CN = "LanguageConfig_Card_Select_Get_Tips1_CN|选择 1 张牌加入手中"
  },
  Card_Select_Get_Tips2 = {
    ID = "Card_Select_Get_Tips2",
    CN = "LanguageConfig_Card_Select_Get_Tips2_CN|选择 2 张牌加入手中"
  },
  Card_Select_Get_Tips3 = {
    ID = "Card_Select_Get_Tips3",
    CN = "LanguageConfig_Card_Select_Get_Tips3_CN|选择 3 张牌加入手中"
  },
  Card_Select_Get_Tips33 = {
    ID = "Card_Select_Get_Tips33",
    CN = "LanguageConfig_Card_Select_Get_Tips33_CN|选择至多 3 张牌加入手中"
  },
  Card_Select_Get_Tips1_Use = {
    ID = "Card_Select_Get_Tips1_Use",
    CN = "LanguageConfig_Card_Select_Get_Tips1_Use_CN|选择 1 张牌使用"
  },
  Card_Select_Del_Tips1 = {
    ID = "Card_Select_Del_Tips1",
    CN = "LanguageConfig_Card_Select_Del_Tips1_CN|选择 1 张牌删除"
  },
  Card_Select_Del_Tips1_UP = {
    ID = "Card_Select_Del_Tips1_UP",
    CN = "LanguageConfig_Card_Select_Del_Tips1_UP_CN|选择最多 1 张牌删除"
  },
  Card_Select_Del_Tips2 = {
    ID = "Card_Select_Del_Tips2",
    CN = "LanguageConfig_Card_Select_Del_Tips2_CN|选择 2 张牌删除"
  },
  Card_Select_Del_Tips2_Up = {
    ID = "Card_Select_Del_Tips2_Up",
    CN = "LanguageConfig_Card_Select_Del_Tips2_Up_CN|选择最多 2 张牌删除"
  },
  Card_Select_Del_Tips3 = {
    ID = "Card_Select_Del_Tips3",
    CN = "LanguageConfig_Card_Select_Del_Tips3_CN|选择 3 张牌删除"
  },
  Card_Select_Del_Tips5_Up = {
    ID = "Card_Select_Del_Tips5_Up",
    CN = "LanguageConfig_Card_Select_Del_Tips5_Up_CN|选择最多 5 张牌删除"
  },
  Card_Select_Copy_Tips1 = {
    ID = "Card_Select_Copy_Tips1",
    CN = "LanguageConfig_Card_Select_Copy_Tips1_CN|选择 1 张牌进行复制"
  },
  Card_Select_Up_Tips1 = {
    ID = "Card_Select_Up_Tips1",
    CN = "LanguageConfig_Card_Select_Up_Tips1_CN|选择 1 张已镶嵌刻印卡牌对其刻印升级"
  },
  Card_Select_Copy_Tips1_Ruins = {
    ID = "Card_Select_Copy_Tips1_Ruins",
    CN = "LanguageConfig_Card_Select_Copy_Tips1_Ruins_CN|选择 1 张牌降低算力消耗并获得共鸣效果"
  },
  Card_Select_Del_Tips1_Ruins = {
    ID = "Card_Select_Del_Tips1_Ruins",
    CN = "LanguageConfig_Card_Select_Del_Tips1_Ruins_CN|选择 1 张牌删除并获得共鸣效果"
  },
  Card_Select_Del_Tips2_Ruins = {
    ID = "Card_Select_Del_Tips2_Ruins",
    CN = "LanguageConfig_Card_Select_Del_Tips2_Ruins_CN|选择 2 张牌删除并获得共鸣效果"
  },
  Card_Select_Get_Tips1_qianmian1 = {
    ID = "Card_Select_Get_Tips1_qianmian1",
    CN = "LanguageConfig_Card_Select_Get_Tips1_qianmian1_CN|选择 1 张千面幻象加入手中"
  },
  Card_Select_Get_Tips1_qianmian2 = {
    ID = "Card_Select_Get_Tips1_qianmian2",
    CN = "LanguageConfig_Card_Select_Get_Tips1_qianmian2_CN|选择为千面幻象附加额外效果"
  },
  Card_Select_Retain_Tips1 = {
    ID = "Card_Select_Retain_Tips1",
    CN = "LanguageConfig_Card_Select_Retain_Tips1_CN|选择 1 张牌保留在手中"
  },
  Card_Select_Retain_Tips2 = {
    ID = "Card_Select_Retain_Tips2",
    CN = "LanguageConfig_Card_Select_Retain_Tips2_CN|选择 1 张牌保留在手中，并使其算力消耗 -1"
  },
  Card_Select_Sell_Tips1 = {
    ID = "Card_Select_Sell_Tips1",
    CN = "LanguageConfig_Card_Select_Sell_Tips1_CN|选择 1 张牌出售"
  },
  Card_Select_Del_Tips1_Curse = {
    ID = "Card_Select_Del_Tips1_Curse",
    CN = "LanguageConfig_Card_Select_Del_Tips1_Curse_CN|选择 1 张症状卡删除"
  },
  Card_Select_Del_Tips2_Curse = {
    ID = "Card_Select_Del_Tips2_Curse",
    CN = "LanguageConfig_Card_Select_Del_Tips2_Curse_CN|选择 2 张症状卡删除"
  },
  Card_Select_Del_Tips4_Curse = {
    ID = "Card_Select_Del_Tips4_Curse",
    CN = "LanguageConfig_Card_Select_Del_Tips4_Curse_CN|选择 4 张症状卡删除"
  },
  Card_Select_Del_Tips6_Curse = {
    ID = "Card_Select_Del_Tips6_Curse",
    CN = "LanguageConfig_Card_Select_Del_Tips6_Curse_CN|选择 6 张症状卡删除"
  },
  Card_Select_Del_Tips6_Curse_Up = {
    ID = "Card_Select_Del_Tips6_Curse_Up",
    CN = "LanguageConfig_Card_Select_Del_Tips6_Curse_Up_CN|选择最多 6 张症状卡删除"
  },
  Card_Select_Tips1 = {
    ID = "Card_Select_Tips1",
    CN = "LanguageConfig_Card_Select_Tips1_CN|选择 1 张卡牌"
  },
  Card_Select_Tips1_huihuana = {
    ID = "Card_Select_Tips1_huihuana",
    CN = "LanguageConfig_Card_Select_Tips1_huihuana_CN|选择 1 张卡牌添加「回环乐音」"
  },
  Card_Select_Tips1_huihuanb = {
    ID = "Card_Select_Tips1_huihuanb",
    CN = "LanguageConfig_Card_Select_Tips1_huihuanb_CN|选择 2 张卡牌添加「回环乐音」"
  },
  Card_Select_Tips1_hamulin = {
    ID = "Card_Select_Tips1_hamulin",
    CN = "LanguageConfig_Card_Select_Tips1_hamulin_CN|选择 1 个乐音并释放"
  },
  Card_Select_Tips1_tawei = {
    ID = "Card_Select_Tips1_tawei",
    CN = "LanguageConfig_Card_Select_Tips1_tawei_CN|选择 1 个「追忆」并触发其效果"
  },
  Card_Select_Tips1_kelaimenting = {
    ID = "Card_Select_Tips1_kelaimenting",
    CN = "LanguageConfig_Card_Select_Tips1_kelaimenting_CN|选择将「共感」转化为「精神创伤」或「恐惧固着」。"
  },
  Card_Select_Tips1_xu = {
    ID = "Card_Select_Tips1_xu",
    CN = "LanguageConfig_Card_Select_Tips1_xu_CN|选择「相许」或「夺魄」。"
  },
  Card_Select_Tips1_cost1 = {
    ID = "Card_Select_Tips1_cost1",
    CN = "LanguageConfig_Card_Select_Tips1_cost1_CN|选择 1 张卡牌使其算力消耗变为 1"
  },
  Card_Select_Tips1_consume = {
    ID = "Card_Select_Tips1_consume",
    CN = "LanguageConfig_Card_Select_Tips1_consume_CN|选择 1 张卡牌消耗"
  },
  Card_Select_Act_Tips1 = {
    ID = "Card_Select_Act_Tips1",
    CN = "LanguageConfig_Card_Select_Act_Tips1_CN|选择 1 个行动意图"
  },
  Card_Select_Act_Tips2 = {
    ID = "Card_Select_Act_Tips2",
    CN = "LanguageConfig_Card_Select_Act_Tips2_CN|选择 2 个行动意图"
  },
  Card_Select_Get_Tips1_jingji1 = {
    ID = "Card_Select_Get_Tips1_jingji1",
    CN = "LanguageConfig_Card_Select_Get_Tips1_jingji1_CN|选择额外效果"
  },
  Card_Select_Get_Tipsbaiyin = {
    ID = "Card_Select_Get_Tipsbaiyin",
    CN = "LanguageConfig_Card_Select_Get_Tipsbaiyin_CN|选择 1 个普通的造物。"
  },
  Card_Select_Get_Tipshuangjin = {
    ID = "Card_Select_Get_Tipshuangjin",
    CN = "LanguageConfig_Card_Select_Get_Tipshuangjin_CN|选择 1 个稀有的造物。"
  },
  Card_Select_Get_Tipslengcai = {
    ID = "Card_Select_Get_Tipslengcai",
    CN = "LanguageConfig_Card_Select_Get_Tipslengcai_CN|选择 1 个惊世的造物。"
  },
  Card_Select_Del_Tipsnaogang = {
    ID = "Card_Select_Del_Tipsnaogang",
    CN = "LanguageConfig_Card_Select_Del_Tipsnaogang_CN|选择至多 2 张卡牌删除，将它们置入「备用脑缸」。"
  },
  Card_Select_Del_Tipsnaogang2 = {
    ID = "Card_Select_Del_Tipsnaogang2",
    CN = "LanguageConfig_Card_Select_Del_Tipsnaogang2_CN|选择至多 3 张牌加入手中"
  },
  Card_Select_Del_Tipskelaimenting = {
    ID = "Card_Select_Del_Tipskelaimenting",
    CN = "LanguageConfig_Card_Select_Del_Tipskelaimenting_CN|选择 1 张指令卡置入手中。"
  },
  Card_Select_Get_Tipszhiyuan = {
    ID = "Card_Select_Get_Tipszhiyuan",
    CN = "LanguageConfig_Card_Select_Get_Tipszhiyuan_CN|选择 1 张支援卡加入手中。"
  },
  RedRelicTypeName = {
    ID = "RedRelicTypeName",
    CN = "LanguageConfig_RedRelicTypeName_CN|<RedRelic:诅咒造物>"
  },
  OrangeRelicTypeName = {
    ID = "OrangeRelicTypeName",
    CN = "LanguageConfig_OrangeRelicTypeName_CN|<OrangeRelic:黄金造物>"
  },
  WhiteRelicTypeName = {
    ID = "WhiteRelicTypeName",
    CN = "LanguageConfig_WhiteRelicTypeName_CN|<WhiteRelic:白银造物>"
  },
  PurpleRelicTypeName = {
    ID = "PurpleRelicTypeName",
    CN = "LanguageConfig_PurpleRelicTypeName_CN|<OrangeRelic:特殊造物>"
  },
  HolyRelicTypeName = {
    ID = "HolyRelicTypeName",
    CN = "LanguageConfig_HolyRelicTypeName_CN|<OrangeRelic:受祝造物>"
  },
  SinRelicTypeName = {
    ID = "SinRelicTypeName",
    CN = "LanguageConfig_SinRelicTypeName_CN|<RedRelic:负罪造物>"
  },
  ForgedRelicTypeName = {
    ID = "ForgedRelicTypeName",
    CN = "LanguageConfig_ForgedRelicTypeName_CN|<OrangeRelic:黄金造物>"
  },
  RedEnchantConfigTypeName = {
    ID = "RedEnchantConfigTypeName",
    CN = "LanguageConfig_RedEnchantConfigTypeName_CN|<RedRelic:诅咒刻印>"
  },
  OrangeEnchantConfigTypeName = {
    ID = "OrangeEnchantConfigTypeName",
    CN = "LanguageConfig_OrangeEnchantConfigTypeName_CN|<OrangeRelic:高级刻印>"
  },
  WhiteEnchantConfigTypeName = {
    ID = "WhiteEnchantConfigTypeName",
    CN = "LanguageConfig_WhiteEnchantConfigTypeName_CN|<WhiteRelic:普通刻印>"
  },
  RPGJJC_Desc = {
    ID = "RPGJJC_Desc",
    CN = "LanguageConfig_RPGJJC_Desc_CN|你可以消耗「演习凭证」挑战其他守密人布置的防守队伍，挑战成功后将会提升排名。你也需要精心布置你的防守队伍，否则将可能被其他守密人挑战成功造成排名下降。排名越高每小时获得的「演习徽章」越多。「演习凭证」将跟随时间自动获得。「演习徽章」可以在兑换商店中兑换蔷薇金券、灵知制剂等道具。"
  },
  GetRelic = {
    ID = "GetRelic",
    CN = "LanguageConfig_GetRelic_CN|获得造物"
  },
  RelicLvUnlock = {
    ID = "RelicLvUnlock",
    CN = "LanguageConfig_RelicLvUnlock_CN|解锁造物"
  },
  Daily_First_Finish = {
    ID = "Daily_First_Finish",
    CN = "LanguageConfig_Daily_First_Finish_CN|首次通关"
  },
  Daily_First_Finish_Tips = {
    ID = "Daily_First_Finish_Tips",
    CN = "LanguageConfig_Daily_First_Finish_Tips_CN|通关后获得下阶段奖励"
  },
  NewLevelUp_autoSet = {
    ID = "NewLevelUp_autoSet",
    CN = "LanguageConfig_NewLevelUp_autoSet_CN|自动置入"
  },
  NewLevelUp_alllClean = {
    ID = "NewLevelUp_alllClean",
    CN = "LanguageConfig_NewLevelUp_alllClean_CN|全部清除"
  },
  SchoolNotAagreeWith = {
    ID = "SchoolNotAagreeWith",
    CN = "LanguageConfig_SchoolNotAagreeWith_CN|界域冲突"
  },
  Formation_Default_TeamName_String1 = {
    ID = "Formation_Default_TeamName_String1",
    CN = "LanguageConfig_Formation_Default_TeamName_String1_CN|队伍1"
  },
  Formation_Default_TeamName_String2 = {
    ID = "Formation_Default_TeamName_String2",
    CN = "LanguageConfig_Formation_Default_TeamName_String2_CN|队伍2"
  },
  Formation_Default_TeamName_String3 = {
    ID = "Formation_Default_TeamName_String3",
    CN = "LanguageConfig_Formation_Default_TeamName_String3_CN|队伍3"
  },
  Formation_Default_TeamName_String4 = {
    ID = "Formation_Default_TeamName_String4",
    CN = "LanguageConfig_Formation_Default_TeamName_String4_CN|队伍4"
  },
  Formation_Default_TeamName_String5 = {
    ID = "Formation_Default_TeamName_String5",
    CN = "LanguageConfig_Formation_Default_TeamName_String5_CN|队伍5"
  },
  Formation_Fast_Btn = {
    ID = "Formation_Fast_Btn",
    CN = "LanguageConfig_Formation_Fast_Btn_CN|快速编队"
  },
  Formation_EnterCopy_Btn = {
    ID = "Formation_EnterCopy_Btn",
    CN = "LanguageConfig_Formation_EnterCopy_Btn_CN|调查"
  },
  Formation_CurrentTeam_AvgLevelNum_String = {
    ID = "Formation_CurrentTeam_AvgLevelNum_String",
    CN = "LanguageConfig_Formation_CurrentTeam_AvgLevelNum_String_CN|当前队伍平均等级"
  },
  Formation_RecommendLevel = {
    ID = "Formation_RecommendLevel",
    CN = "LanguageConfig_Formation_RecommendLevel_CN|推荐等级"
  },
  Formation_RecommendTeam_LevelNum_String = {
    ID = "Formation_RecommendTeam_LevelNum_String",
    CN = "LanguageConfig_Formation_RecommendTeam_LevelNum_String_CN|关卡推荐等级"
  },
  Formation_Role_Recommend_String = {
    ID = "Formation_Role_Recommend_String",
    CN = "LanguageConfig_Formation_Role_Recommend_String_CN|点击选择唤醒体上场"
  },
  Formation_Role_ForceAssist_Recommend = {
    ID = "Formation_Role_ForceAssist_Recommend",
    CN = "LanguageConfig_Formation_Role_ForceAssist_Recommend_CN|<Blue:选择助战唤醒体上场>"
  },
  Formation_Administration_Title_String = {
    ID = "Formation_Administration_Title_String",
    CN = "LanguageConfig_Formation_Administration_Title_String_CN|队伍管理"
  },
  Formation_Administration_Sure_Btn = {
    ID = "Formation_Administration_Sure_Btn",
    CN = "LanguageConfig_Formation_Administration_Sure_Btn_CN|选择"
  },
  Formation_Administration_CombatNum_String = {
    ID = "Formation_Administration_CombatNum_String",
    CN = "LanguageConfig_Formation_Administration_CombatNum_String_CN|总战力"
  },
  Formation_RenameTeam_Title_String = {
    ID = "Formation_RenameTeam_Title_String",
    CN = "LanguageConfig_Formation_RenameTeam_Title_String_CN|修改队伍名"
  },
  Formation_RenameTeam_CurrentTeam_String = {
    ID = "Formation_RenameTeam_CurrentTeam_String",
    CN = "LanguageConfig_Formation_RenameTeam_CurrentTeam_String_CN|当前名称："
  },
  Formation_RenameTeam_Recommend_String = {
    ID = "Formation_RenameTeam_Recommend_String",
    CN = "LanguageConfig_Formation_RenameTeam_Recommend_String_CN|点击编辑队伍名"
  },
  Formation_RenameTeam_Sure_Btn = {
    ID = "Formation_RenameTeam_Sure_Btn",
    CN = "LanguageConfig_Formation_RenameTeam_Sure_Btn_CN|确认"
  },
  Formation_RenameTeam_Back_Btn = {
    ID = "Formation_RenameTeam_Back_Btn",
    CN = "LanguageConfig_Formation_RenameTeam_Back_Btn_CN|取消"
  },
  Formation_SelectRole_DifferentOccupation_String = {
    ID = "Formation_SelectRole_DifferentOccupation_String",
    CN = "LanguageConfig_Formation_SelectRole_DifferentOccupation_String_CN|界域冲突"
  },
  Formation_SelectRole_NotBattle_String = {
    ID = "Formation_SelectRole_NotBattle_String",
    CN = "LanguageConfig_Formation_SelectRole_NotBattle_String_CN|无法上场"
  },
  Formation_SelectRole_Recommend_String1 = {
    ID = "Formation_SelectRole_Recommend_String1",
    CN = "LanguageConfig_Formation_SelectRole_Recommend_String1_CN|暂无选中唤醒体"
  },
  Formation_SelectRole_Recommend_String2 = {
    ID = "Formation_SelectRole_Recommend_String2",
    CN = "LanguageConfig_Formation_SelectRole_Recommend_String2_CN|点击左侧唤醒体头像进行选择"
  },
  Formation_SelectRole_Sure_Btn1 = {
    ID = "Formation_SelectRole_Sure_Btn1",
    CN = "LanguageConfig_Formation_SelectRole_Sure_Btn1_CN|下场"
  },
  Formation_SelectRole_Sure_Btn2 = {
    ID = "Formation_SelectRole_Sure_Btn2",
    CN = "LanguageConfig_Formation_SelectRole_Sure_Btn2_CN|上场"
  },
  Formation_SelectRole_Sure_Btn3 = {
    ID = "Formation_SelectRole_Sure_Btn3",
    CN = "LanguageConfig_Formation_SelectRole_Sure_Btn3_CN|替换"
  },
  Formation_SelectRole_Title_String = {
    ID = "Formation_SelectRole_Title_String",
    CN = "LanguageConfig_Formation_SelectRole_Title_String_CN|选择唤醒体"
  },
  Formation_SelectRole_Details_Btn = {
    ID = "Formation_SelectRole_Details_Btn",
    CN = "LanguageConfig_Formation_SelectRole_Details_Btn_CN|详情"
  },
  Formation_Fast_Sure_Btn = {
    ID = "Formation_Fast_Sure_Btn",
    CN = "LanguageConfig_Formation_Fast_Sure_Btn_CN|保存"
  },
  Mail_Description_Title = {
    ID = "Mail_Description_Title",
    CN = "LanguageConfig_Mail_Description_Title_CN|邮箱说明"
  },
  Mail_Description_Detail = {
    ID = "Mail_Description_Detail",
    CN = "LanguageConfig_Mail_Description_Detail_CN|<Title:【邮件容量】>\n·邮箱最多保存100封邮件。\n·邮件到达上限时，系统会自动删除最早的邮件。\n·每封邮件都有有效期，到期后会自动删除。\n\n<Title:【珍藏邮件箱】>\n·生日祝福等特别邮件在领取完奖励后会放入邮件珍藏箱，并拥有永久的有效期。"
  },
  Mail_Title = {
    ID = "Mail_Title",
    CN = "LanguageConfig_Mail_Title_CN|邮箱"
  },
  Mail_Treasures = {
    ID = "Mail_Treasures",
    CN = "LanguageConfig_Mail_Treasures_CN|邮件珍藏箱"
  },
  Mail_Number = {
    ID = "Mail_Number",
    CN = "LanguageConfig_Mail_Number_CN|{s1}/{s2}"
  },
  Mail_CollectAll = {
    ID = "Mail_CollectAll",
    CN = "LanguageConfig_Mail_CollectAll_CN|全部领取"
  },
  Mail_DeleteRead = {
    ID = "Mail_DeleteRead",
    CN = "LanguageConfig_Mail_DeleteRead_CN|删除已读"
  },
  Mail_Recive = {
    ID = "Mail_Recive",
    CN = "LanguageConfig_Mail_Recive_CN|领取"
  },
  Mail_Sender = {
    ID = "Mail_Sender",
    CN = "LanguageConfig_Mail_Sender_CN|发件人：{s1}"
  },
  Mail_SendTime = {
    ID = "Mail_SendTime",
    CN = "LanguageConfig_Mail_SendTime_CN|时间：{s1}"
  },
  Mail_BackpackFull_Title = {
    ID = "Mail_BackpackFull_Title",
    CN = "LanguageConfig_Mail_BackpackFull_Title_CN|系统奖励补发"
  },
  Mail_BackpackFull_Message = {
    ID = "Mail_BackpackFull_Message",
    CN = "LanguageConfig_Mail_BackpackFull_Message_CN|尊敬的守密人，您于{s1}中获得的奖励因背包已满未能领取，现以邮件奖励补发给您，请及时清理背包"
  },
  Mail_BackpackFull_Sender = {
    ID = "Mail_BackpackFull_Sender",
    CN = "LanguageConfig_Mail_BackpackFull_Sender_CN|Z1项目组"
  },
  Mail_CountDown_Day = {
    ID = "Mail_CountDown_Day",
    CN = "LanguageConfig_Mail_CountDown_Day_CN|{s1}天后到期"
  },
  Mail_CountDown_Hour = {
    ID = "Mail_CountDown_Hour",
    CN = "LanguageConfig_Mail_CountDown_Hour_CN|{s1}小时后到期"
  },
  Mail_CountDown_Soon = {
    ID = "Mail_CountDown_Soon",
    CN = "LanguageConfig_Mail_CountDown_Soon_CN|即将到期"
  },
  Mail_Number_Treasures = {
    ID = "Mail_Number_Treasures",
    CN = "LanguageConfig_Mail_Number_Treasures_CN|珍藏数 {s1}/{s2}"
  },
  Mail_CheckPrompt = {
    ID = "Mail_CheckPrompt",
    CN = "LanguageConfig_Mail_CheckPrompt_CN|选择一封邮件查看"
  },
  School_Title_String = {
    ID = "School_Title_String",
    CN = "LanguageConfig_School_Title_String_CN|界域天赋"
  },
  School_Tips_String = {
    ID = "School_Tips_String",
    CN = "LanguageConfig_School_Tips_String_CN|在调查模式中，根据队伍包含的界域激活界域天赋效果。\n点击可查看详情。"
  },
  School_Chaos_Title_String = {
    ID = "School_Chaos_Title_String",
    CN = "LanguageConfig_School_Chaos_Title_String_CN|宇宙万象"
  },
  School_Chaos_Content_String = {
    ID = "School_Chaos_Content_String",
    CN = "LanguageConfig_School_Chaos_Content_String_CN|·混沌界域唤醒体可以突破界域限制与其他界域唤醒体编队。\n·任意队伍中如果存在混沌唤醒体，可以额外获得 100% 死亡抵抗。\n·回合结束和释放「狂气爆发」后，<CardKeyWord:银钥能量> +50。"
  },
  School_Ocean_Title_String = {
    ID = "School_Ocean_Title_String",
    CN = "LanguageConfig_School_Ocean_Title_String_CN|沉渊之触"
  },
  School_Ocean_Content_String = {
    ID = "School_Ocean_Content_String",
    CN = "LanguageConfig_School_Ocean_Content_String_CN|·战斗开始时生成 1 条触腕，触腕在回合结束时攻击前排敌人。\n·每释放 1 次狂气爆发，在回合结束时驱使 1 条触腕攻击。\n·每获得 3 点力量提供 1 点触腕伤害，力量每下降 3 点使触腕伤害降低 1 点。"
  },
  School_Blood_Title_String = {
    ID = "School_Blood_Title_String",
    CN = "LanguageConfig_School_Blood_Title_String_CN|猩红献祭"
  },
  School_Blood_Content_String = {
    ID = "School_Blood_Content_String",
    CN = "LanguageConfig_School_Blood_Content_String_CN|·回合开始时<CardKeyWord:胚胎融合> +20（随损失生命提升，最高 40），达到上限时将 1 张<CardKeyWord:「胚胎」>置入手牌。\n·血肉界域的「狂气爆发」会消耗<CardKeyWord:「胚胎」>触发<CardKeyWord:吞噬>效果，每回合首次吞噬后会获得最大生命 2% 的护盾和 1% 的临时力量。（随损失生命提高，最大为 2 倍）"
  },
  School_Dimension_Title_String = {
    ID = "School_Dimension_Title_String",
    CN = "LanguageConfig_School_Dimension_Title_String_CN|维度跃迁"
  },
  School_Dimension_Content_String = {
    ID = "School_Dimension_Content_String",
    CN = "LanguageConfig_School_Dimension_Content_String_CN|·每回合打出的第 1 张指令卡的临时复制会进入<CardKeyWord:超维空间>并触发其跃迁效果。\n·当超维空间达到上限时，获得 1 个额外的超维回合，该回合不再通常抽牌，而是将超维空间的卡牌加入手牌。超维回合能触发所有跃迁效果。"
  },
  PVP_School_Title_String = {
    ID = "PVP_School_Title_String"
  },
  PVP_School_Tips_String = {
    ID = "PVP_School_Tips_String"
  },
  PVP_School_Chaos_Title_String = {
    ID = "PVP_School_Chaos_Title_String"
  },
  PVP_School_Chaos_Content_String = {
    ID = "PVP_School_Chaos_Content_String"
  },
  PVP_School_Ocean_Title_String = {
    ID = "PVP_School_Ocean_Title_String"
  },
  PVP_School_Ocean_Content_String = {
    ID = "PVP_School_Ocean_Content_String"
  },
  PVP_School_Blood_Title_String = {
    ID = "PVP_School_Blood_Title_String"
  },
  PVP_School_Blood_Content_String = {
    ID = "PVP_School_Blood_Content_String"
  },
  PVP_School_Dimension_Title_String = {
    ID = "PVP_School_Dimension_Title_String"
  },
  PVP_School_Dimension_Content_String = {
    ID = "PVP_School_Dimension_Content_String"
  },
  Awaker_Type_Atk = {
    ID = "Awaker_Type_Atk",
    CN = "LanguageConfig_Awaker_Type_Atk_CN|伤害型"
  },
  Awaker_Type_Def = {
    ID = "Awaker_Type_Def",
    CN = "LanguageConfig_Awaker_Type_Def_CN|防御型"
  },
  Awaker_Type_Assist = {
    ID = "Awaker_Type_Assist",
    CN = "LanguageConfig_Awaker_Type_Assist_CN|辅助型"
  },
  Formation_SelectRole_Nothing_Tips = {
    ID = "Formation_SelectRole_Nothing_Tips",
    CN = "LanguageConfig_Formation_SelectRole_Nothing_Tips_CN|无该界域唤醒体"
  },
  Formation_Administration_Current_Team_String = {
    ID = "Formation_Administration_Current_Team_String",
    CN = "LanguageConfig_Formation_Administration_Current_Team_String_CN|当前队伍"
  },
  AlchemyWorkshop = {
    ID = "AlchemyWorkshop",
    CN = "LanguageConfig_AlchemyWorkshop_CN|冶炼室"
  },
  ComposeTitle = {
    ID = "ComposeTitle",
    CN = "LanguageConfig_ComposeTitle_CN|材料合成"
  },
  DecomposeTitle = {
    ID = "DecomposeTitle",
    CN = "LanguageConfig_DecomposeTitle_CN|命轮分解"
  },
  TrinketDecomposeTitle = {
    ID = "TrinketDecomposeTitle",
    CN = "LanguageConfig_TrinketDecomposeTitle_CN|密契分解"
  },
  RecastTitle = {
    ID = "RecastTitle",
    CN = "LanguageConfig_RecastTitle_CN|密契重印"
  },
  QuantityHeld = {
    ID = "QuantityHeld",
    CN = "LanguageConfig_QuantityHeld_CN|持有数量：{s1}"
  },
  AboutToCompose = {
    ID = "AboutToCompose",
    CN = "LanguageConfig_AboutToCompose_CN|即将合成"
  },
  AboutToDecompose = {
    ID = "AboutToDecompose",
    CN = "LanguageConfig_AboutToDecompose_CN|即将分解"
  },
  ComposeTimes = {
    ID = "ComposeTimes",
    CN = "LanguageConfig_ComposeTimes_CN|合成数量"
  },
  DecomposeTimes = {
    ID = "DecomposeTimes",
    CN = "LanguageConfig_DecomposeTimes_CN|分解数量"
  },
  RecastTimes = {
    ID = "RecastTimes",
    CN = "LanguageConfig_RecastTimes_CN|重印次数"
  },
  ItemForCompose = {
    ID = "ItemForCompose",
    CN = "LanguageConfig_ItemForCompose_CN|合成配方"
  },
  ItemByDecompose = {
    ID = "ItemByDecompose",
    CN = "LanguageConfig_ItemByDecompose_CN|分解可获得材料"
  },
  ItemNeed = {
    ID = "ItemNeed",
    CN = "LanguageConfig_ItemNeed_CN|需要"
  },
  ComposeButtonText = {
    ID = "ComposeButtonText",
    CN = "LanguageConfig_ComposeButtonText_CN|合成"
  },
  DecomposeButtonText = {
    ID = "DecomposeButtonText",
    CN = "LanguageConfig_DecomposeButtonText_CN|分解"
  },
  RecastButtonText = {
    ID = "RecastButtonText",
    CN = "LanguageConfig_RecastButtonText_CN|重印"
  },
  SelectItemToDecompose = {
    ID = "SelectItemToDecompose",
    CN = "LanguageConfig_SelectItemToDecompose_CN|请从左侧选择需要分解的材料"
  },
  RecastConsumeTrinketTips = {
    ID = "RecastConsumeTrinketTips",
    CN = "LanguageConfig_RecastConsumeTrinketTips_CN|将任意3个SSR密契重印为新的密契"
  },
  RecastConsumeTrinketTips_1 = {
    ID = "RecastConsumeTrinketTips_1",
    CN = "LanguageConfig_RecastConsumeTrinketTips_1_CN|可通过重印获得{s1}个密契匣子"
  },
  LackOfItemForCompose = {
    ID = "LackOfItemForCompose",
    CN = "LanguageConfig_LackOfItemForCompose_CN|所需材料不足，无法合成"
  },
  LackOfItemForDecompose = {
    ID = "LackOfItemForDecompose",
    CN = "LanguageConfig_LackOfItemForDecompose_CN|尚未拥有可分解的材料"
  },
  ChooseItemForDecompose = {
    ID = "ChooseItemForDecompose",
    CN = "LanguageConfig_ChooseItemForDecompose_CN|尚未选择需要分解的材料"
  },
  LackOfTrinketForRecast = {
    ID = "LackOfTrinketForRecast",
    CN = "LanguageConfig_LackOfTrinketForRecast_CN|尚未拥有未装备的SSR品阶密契"
  },
  TrinketIsLocked = {
    ID = "TrinketIsLocked",
    CN = "LanguageConfig_TrinketIsLocked_CN|密契已锁定"
  },
  TrinketMustChooseThree = {
    ID = "TrinketMustChooseThree",
    CN = "LanguageConfig_TrinketMustChooseThree_CN|所选密契不足3个，无法重印"
  },
  TrinketChooseLimited = {
    ID = "TrinketChooseLimited",
    CN = "LanguageConfig_TrinketChooseLimited_CN|所选密契数量已达上限"
  },
  LackOfGoldCoin = {
    ID = "LackOfGoldCoin",
    CN = "LanguageConfig_LackOfGoldCoin_CN|「蔷薇金券」不足"
  },
  TrinketChooseForRecast = {
    ID = "TrinketChooseForRecast",
    CN = "LanguageConfig_TrinketChooseForRecast_CN|选择用于重印的密契"
  },
  RecastConsumeTrinketTips_2 = {
    ID = "RecastConsumeTrinketTips_2",
    CN = "LanguageConfig_RecastConsumeTrinketTips_2_CN|消耗已选密契可制造<color=#fea338>{s1}</color>个新密契（至下一个新密契所需：<color=#fea338>{s2}/{s3}</color>）"
  },
  DefaultName = {
    ID = "DefaultName",
    CN = "LanguageConfig_DefaultName_CN|西维斯特"
  },
  AwakerTypeName = {
    ID = "AwakerTypeName",
    CN = "LanguageConfig_AwakerTypeName_CN|唤醒体"
  },
  DailyChallengeRewardButtonText = {
    ID = "DailyChallengeRewardButtonText",
    CN = "LanguageConfig_DailyChallengeRewardButtonText_CN|奖励规则"
  },
  DailyChallengeRewardTips = {
    ID = "DailyChallengeRewardTips",
    CN = "LanguageConfig_DailyChallengeRewardTips_CN|挑战难度达到"
  },
  DailyChallengeRewardPreview = {
    ID = "DailyChallengeRewardPreview",
    CN = "LanguageConfig_DailyChallengeRewardPreview_CN|奖励预览"
  },
  DailyChallengeRewardTips_1 = {
    ID = "DailyChallengeRewardTips_1",
    CN = "LanguageConfig_DailyChallengeRewardTips_1_CN|选择更高的挑战难度以获得更多奖励"
  },
  DailyChallengeRewardTips_2 = {
    ID = "DailyChallengeRewardTips_2",
    CN = "LanguageConfig_DailyChallengeRewardTips_2_CN|已获得所有奖励"
  },
  DailyChallengeResonanceSelectTips = {
    ID = "DailyChallengeResonanceSelectTips",
    CN = "LanguageConfig_DailyChallengeResonanceSelectTips_CN|请从右侧选择共鸣"
  },
  Monster_B0002_Tips_1 = {
    ID = "Monster_B0002_Tips_1",
    CN = "LanguageConfig_Monster_B0002_Tips_1_CN|乔治正准备号令他的伙伴们……"
  },
  FirstUnity_Monster_Tips_1 = {
    ID = "FirstUnity_Monster_Tips_1",
    CN = "LanguageConfig_FirstUnity_Monster_Tips_1_CN|银色六翼，予汝护佑。"
  },
  FirstUnity_Monster_Tips_2 = {
    ID = "FirstUnity_Monster_Tips_2",
    CN = "LanguageConfig_FirstUnity_Monster_Tips_2_CN|双翼初张，狂气汇集。"
  },
  FirstUnity_Monster_Tips_3 = {
    ID = "FirstUnity_Monster_Tips_3",
    CN = "LanguageConfig_FirstUnity_Monster_Tips_3_CN|四翼渐生，银羽夺辉！"
  },
  FirstUnity_Monster_Tips_4 = {
    ID = "FirstUnity_Monster_Tips_4",
    CN = "LanguageConfig_FirstUnity_Monster_Tips_4_CN|六翼满开，审判将至！"
  },
  FirstUnity_Monster_Tips_5 = {
    ID = "FirstUnity_Monster_Tips_5",
    CN = "LanguageConfig_FirstUnity_Monster_Tips_5_CN|狂气充盈，审判将至！"
  },
  Monster_C06_Tips_1 = {
    ID = "Monster_C06_Tips_1",
    CN = "LanguageConfig_Monster_C06_Tips_1_CN|「分裂患者」即将发狂，快用「安闲之铃」降低她的狂气！"
  },
  Monster_C06_Tips_2 = {
    ID = "Monster_C06_Tips_2",
    CN = "LanguageConfig_Monster_C06_Tips_2_CN|所有人都难逃一死……粉碎吧！"
  },
  Monster_C09_Tips_1 = {
    ID = "Monster_C09_Tips_1",
    CN = "LanguageConfig_Monster_C09_Tips_1_CN|甜蜜恶鬼准备反击···！"
  },
  Monster_C0203_Tips_1 = {
    ID = "Monster_C0203_Tips_1",
    CN = "LanguageConfig_Monster_C0203_Tips_1_CN|蜡像们使用了蜡油武装…！"
  },
  Investigation_Successful = {
    ID = "Investigation_Successful",
    CN = "LanguageConfig_Investigation_Successful_CN|调查完成"
  },
  Investigation_Failed = {
    ID = "Investigation_Failed",
    CN = "LanguageConfig_Investigation_Failed_CN|调查终止"
  },
  MainLinesSimple = {
    ID = "MainLinesSimple",
    CN = "LanguageConfig_MainLinesSimple_CN|普通"
  },
  MainLinesHard = {
    ID = "MainLinesHard",
    CN = "LanguageConfig_MainLinesHard_CN|困难"
  },
  MainLines_Investigation_Reward = {
    ID = "MainLines_Investigation_Reward",
    CN = "LanguageConfig_MainLines_Investigation_Reward_CN|调查奖励"
  },
  MainLines_Ways_To_Lift = {
    ID = "MainLines_Ways_To_Lift",
    CN = "LanguageConfig_MainLines_Ways_To_Lift_CN|提升方式"
  },
  Level_Detail_Stamina = {
    ID = "Level_Detail_Stamina",
    CN = "LanguageConfig_Level_Detail_Stamina_CN|{s1}/{s2}"
  },
  Under_Investigation_Monster = {
    ID = "Under_Investigation_Monster",
    CN = "LanguageConfig_Under_Investigation_Monster_CN|正在调查中"
  },
  MainLinesInvestigation = {
    ID = "MainLinesInvestigation",
    CN = "LanguageConfig_MainLinesInvestigation_CN|调查"
  },
  MainLinesChallenge = {
    ID = "MainLinesChallenge",
    CN = "LanguageConfig_MainLinesChallenge_CN|调查"
  },
  MainLines_NextStep = {
    ID = "MainLines_NextStep",
    CN = "LanguageConfig_MainLines_NextStep_CN|下一步"
  },
  MainLines_StopThere = {
    ID = "MainLines_StopThere",
    CN = "LanguageConfig_MainLines_StopThere_CN|止步于此"
  },
  MainLines_CompleteInvestigation = {
    ID = "MainLines_CompleteInvestigation",
    CN = "LanguageConfig_MainLines_CompleteInvestigation_CN|完成调查"
  },
  MainLines_Chapterx = {
    ID = "MainLines_Chapterx",
    CN = "LanguageConfig_MainLines_Chapterx_CN|第 {s1} 章"
  },
  MainLines_Chapter1 = {
    ID = "MainLines_Chapter1",
    CN = "LanguageConfig_MainLines_Chapter1_CN|第一章"
  },
  MainLines_Chapter2 = {
    ID = "MainLines_Chapter2",
    CN = "LanguageConfig_MainLines_Chapter2_CN|第二章"
  },
  MainLines_Chapter3 = {
    ID = "MainLines_Chapter3",
    CN = "LanguageConfig_MainLines_Chapter3_CN|第三章"
  },
  MainLines_Chapter4 = {
    ID = "MainLines_Chapter4",
    CN = "LanguageConfig_MainLines_Chapter4_CN|第四章"
  },
  MainLines_Chapter5 = {
    ID = "MainLines_Chapter5",
    CN = "LanguageConfig_MainLines_Chapter5_CN|第五章"
  },
  MainLines_Chapter6 = {
    ID = "MainLines_Chapter6",
    CN = "LanguageConfig_MainLines_Chapter6_CN|第六章"
  },
  MainLines_Chapter9 = {
    ID = "MainLines_Chapter9",
    CN = "LanguageConfig_MainLines_Chapter9_CN|终章"
  },
  MainLines_Chapter0 = {
    ID = "MainLines_Chapter0",
    CN = "LanguageConfig_MainLines_Chapter0_CN|序章"
  },
  MainLines_ThreeStarCondition = {
    ID = "MainLines_ThreeStarCondition",
    CN = "LanguageConfig_MainLines_ThreeStarCondition_CN|三星条件（{s1}/{s2}）"
  },
  MainLines_AchieveCondition = {
    ID = "MainLines_AchieveCondition",
    CN = "LanguageConfig_MainLines_AchieveCondition_CN|成就条件（{s1}/{s2}）"
  },
  MainLines_HideCondition = {
    ID = "MainLines_HideCondition",
    CN = "LanguageConfig_MainLines_HideCondition_CN|隐藏条件（{s1}/{s2}）"
  },
  MainLines_ThreeStarConditionTips = {
    ID = "MainLines_ThreeStarConditionTips",
    CN = "LanguageConfig_MainLines_ThreeStarConditionTips_CN|调查评价"
  },
  MainLines_CurrentProgressGreen = {
    ID = "MainLines_CurrentProgressGreen",
    CN = "LanguageConfig_MainLines_CurrentProgressGreen_CN|当前：<GreenQuality:{s1}>"
  },
  MainLines_CurrentProgressRed = {
    ID = "MainLines_CurrentProgressRed",
    CN = "LanguageConfig_MainLines_CurrentProgressRed_CN|当前：<RedQuality:{s1}>"
  },
  MainLinesDetail = {
    ID = "MainLinesDetail",
    CN = "LanguageConfig_MainLinesDetail_CN|关卡详情"
  },
  Monster_B05_Tips1 = {
    ID = "Monster_B05_Tips1",
    CN = "LanguageConfig_Monster_B05_Tips1_CN|品尝我的绝望与愤怒吧！！"
  },
  Charge_NotOpen = {
    ID = "Charge_NotOpen",
    CN = "LanguageConfig_Charge_NotOpen_CN|充值暂未开放"
  },
  DailyChallenge_CurrentProgress = {
    ID = "DailyChallenge_CurrentProgress",
    CN = "LanguageConfig_DailyChallenge_CurrentProgress_CN|(当前：{s1})"
  },
  MapEvent_Key_Tips1 = {
    ID = "MapEvent_Key_Tips1",
    CN = "LanguageConfig_MapEvent_Key_Tips1_CN|当前已拥有钥匙"
  },
  MainLinesInvestigationResult = {
    ID = "MainLinesInvestigationResult",
    CN = "LanguageConfig_MainLinesInvestigationResult_CN|调查评价"
  },
  PotencyNumberOfLayers = {
    ID = "PotencyNumberOfLayers",
    CN = "LanguageConfig_PotencyNumberOfLayers_CN|第{s1}层"
  },
  AwakerNotObtained = {
    ID = "AwakerNotObtained",
    CN = "LanguageConfig_AwakerNotObtained_CN|未获得该唤醒体"
  },
  NeedToActivateTheFrontPotency = {
    ID = "NeedToActivateTheFrontPotency",
    CN = "LanguageConfig_NeedToActivateTheFrontPotency_CN|需要激活前置启灵点"
  },
  StageAchievementButton = {
    ID = "StageAchievementButton",
    CN = "LanguageConfig_StageAchievementButton_CN|成就（{s1}/{s2}）"
  },
  StageHideRewardsButton = {
    ID = "StageHideRewardsButton",
    CN = "LanguageConfig_StageHideRewardsButton_CN|隐藏（{s1}/{s2}）"
  },
  StageRewardsTitle = {
    ID = "StageRewardsTitle",
    CN = "LanguageConfig_StageRewardsTitle_CN|成就奖励"
  },
  InterludeStageRewardsTitle = {
    ID = "InterludeStageRewardsTitle",
    CN = "LanguageConfig_InterludeStageRewardsTitle_CN|三星奖励"
  },
  ArchiveCollectionRewardsTitle = {
    ID = "ArchiveCollectionRewardsTitle",
    CN = "LanguageConfig_ArchiveCollectionRewardsTitle_CN|收集奖励"
  },
  Monster_C0303_Tips_1 = {
    ID = "Monster_C0303_Tips_1",
    CN = "LanguageConfig_Monster_C0303_Tips_1_CN|zzzzzZZZZZ······"
  },
  Monster_C0303_Tips_2 = {
    ID = "Monster_C0303_Tips_2",
    CN = "LanguageConfig_Monster_C0303_Tips_2_CN|······？？？"
  },
  FirstTimeNormalRewardTagText = {
    ID = "FirstTimeNormalRewardTagText",
    CN = "LanguageConfig_FirstTimeNormalRewardTagText_CN|首通双倍"
  },
  ResonanceRewardTagText = {
    ID = "ResonanceRewardTagText",
    CN = "LanguageConfig_ResonanceRewardTagText_CN|共鸣加成"
  },
  Monster_B0003_Tips_1 = {
    ID = "Monster_B0003_Tips_1",
    CN = "LanguageConfig_Monster_B0003_Tips_1_CN|疯狂与融蚀正在吞没你的卡牌，打出的卡牌将被消耗。"
  },
  Monster_B0003_Tips_2 = {
    ID = "Monster_B0003_Tips_2",
    CN = "LanguageConfig_Monster_B0003_Tips_2_CN|封锁…世界之扉！"
  },
  Buff_Tips_Buff = {
    ID = "Buff_Tips_Buff",
    CN = "LanguageConfig_Buff_Tips_Buff_CN|Buff"
  },
  Buff_Tips_DeBuff = {
    ID = "Buff_Tips_DeBuff",
    CN = "LanguageConfig_Buff_Tips_DeBuff_CN|DeBuff"
  },
  Buff_Tips_DispelBuff = {
    ID = "Buff_Tips_DispelBuff",
    CN = "LanguageConfig_Buff_Tips_DispelBuff_CN|无法驱散"
  },
  Billing_Total_Damage = {
    ID = "Billing_Total_Damage",
    CN = "LanguageConfig_Billing_Total_Damage_CN|总伤害"
  },
  RedemptionTips_419 = {
    ID = "RedemptionTips_419",
    CN = "LanguageConfig_RedemptionTips_419_CN|兑换码不存在。"
  },
  RedemptionTips_10602 = {
    ID = "RedemptionTips_10602",
    CN = "LanguageConfig_RedemptionTips_10602_CN|当前兑换码类型未生效 或 您不满足礼包码的领取条件。"
  },
  RedemptionTips_10603 = {
    ID = "RedemptionTips_10603",
    CN = "LanguageConfig_RedemptionTips_10603_CN|当前兑换码没有配置奖励。"
  },
  RedemptionTips_10604 = {
    ID = "RedemptionTips_10604",
    CN = "LanguageConfig_RedemptionTips_10604_CN|您使用同类型兑换码次数达到上限。"
  },
  RedemptionTips_10607 = {
    ID = "RedemptionTips_10607",
    CN = "LanguageConfig_RedemptionTips_10607_CN|系统繁忙，请稍后重试。"
  },
  RedemptionTips_10610 = {
    ID = "RedemptionTips_10610",
    CN = "LanguageConfig_RedemptionTips_10610_CN|您已兑换过该兑换码的互斥兑换码。"
  },
  RedemptionTips_10611 = {
    ID = "RedemptionTips_10611",
    CN = "LanguageConfig_RedemptionTips_10611_CN|当前兑换码兑换人数已达到上限。"
  },
  RedemptionTips_10612 = {
    ID = "RedemptionTips_10612",
    CN = "LanguageConfig_RedemptionTips_10612_CN|您已兑换过此兑换码。"
  },
  RedemptionTips_430 = {
    ID = "RedemptionTips_430",
    CN = "LanguageConfig_RedemptionTips_430_CN|兑换码奖励不可用。"
  },
  RedemptionTips_10026 = {
    ID = "RedemptionTips_10026",
    CN = "LanguageConfig_RedemptionTips_10026_CN|您已领取过此兑换码的同类奖励。"
  },
  RedemptionTips_10028 = {
    ID = "RedemptionTips_10028",
    CN = "LanguageConfig_RedemptionTips_10028_CN|您已领取过此兑换码的互斥奖励。"
  },
  RedemptionTips_15000 = {
    ID = "RedemptionTips_15000",
    CN = "LanguageConfig_RedemptionTips_15000_CN|您不满足此兑换码奖励的领取条件。"
  },
  RedemptionTips_10029 = {
    ID = "RedemptionTips_10029",
    CN = "LanguageConfig_RedemptionTips_10029_CN|当前兑换码奖励已过期。"
  },
  RedemptionTips_10608 = {
    ID = "RedemptionTips_10608",
    CN = "LanguageConfig_RedemptionTips_10608_CN|您输入的角色编号或者角色名称错误，请重试。"
  },
  RedemptionTips_200 = {
    ID = "RedemptionTips_200",
    CN = "LanguageConfig_RedemptionTips_200_CN|兑换成功！请稍后前往信箱中查收。"
  },
  RedemptionTips_429 = {
    ID = "RedemptionTips_429",
    CN = "LanguageConfig_RedemptionTips_429_CN|您的操作过于频繁，请稍后再试。"
  },
  RedemptionTips_other = {
    ID = "RedemptionTips_other",
    CN = "LanguageConfig_RedemptionTips_other_CN|当前兑换码兑换人数已达上限或兑换码不存在。"
  },
  RedemptionTips_Empty = {
    ID = "RedemptionTips_Empty",
    CN = "LanguageConfig_RedemptionTips_Empty_CN|当前兑换码为空，请输入兑换码。"
  },
  BreakThrough_Btn_Str = {
    ID = "BreakThrough_Btn_Str",
    CN = "LanguageConfig_BreakThrough_Btn_Str_CN|升格"
  },
  MaxLevel_Str = {
    ID = "MaxLevel_Str",
    CN = "LanguageConfig_MaxLevel_Str_CN|Max"
  },
  MaxLevel_Tips = {
    ID = "MaxLevel_Tips",
    CN = "LanguageConfig_MaxLevel_Tips_CN|已满级"
  },
  BreakThrough_Unmet_Tips = {
    ID = "BreakThrough_Unmet_Tips",
    CN = "LanguageConfig_BreakThrough_Unmet_Tips_CN|调查等级  {s1}级 解锁"
  },
  BreakThrough_Detail_Btn_Str = {
    ID = "BreakThrough_Detail_Btn_Str",
    CN = "LanguageConfig_BreakThrough_Detail_Btn_Str_CN|升格"
  },
  BreakThrough_Detail_Item_Str = {
    ID = "BreakThrough_Detail_Item_Str",
    CN = "LanguageConfig_BreakThrough_Detail_Item_Str_CN|升格材料"
  },
  BreakThrough_Detail_Deblock_Skill_Str = {
    ID = "BreakThrough_Detail_Deblock_Skill_Str",
    CN = "LanguageConfig_BreakThrough_Detail_Deblock_Skill_Str_CN|可激活新技能"
  },
  BreakThrough_Detail_Level_Str = {
    ID = "BreakThrough_Detail_Level_Str",
    CN = "LanguageConfig_BreakThrough_Detail_Level_Str_CN|Lv.{s1}/Lv.{s2}"
  },
  BreakThrough_Detail_Unmet_Tips = {
    ID = "BreakThrough_Detail_Unmet_Tips",
    CN = "LanguageConfig_BreakThrough_Detail_Unmet_Tips_CN|材料不足，无法升格"
  },
  BreakThrough_Preview_Title_Str = {
    ID = "BreakThrough_Preview_Title_Str",
    CN = "LanguageConfig_BreakThrough_Preview_Title_Str_CN|升格预览"
  },
  BreakThrough_Preview_Completed_Tips = {
    ID = "BreakThrough_Preview_Completed_Tips",
    CN = "LanguageConfig_BreakThrough_Preview_Completed_Tips_CN|已升格"
  },
  BreakThrough_Preview_Not_Completed_Tips = {
    ID = "BreakThrough_Preview_Not_Completed_Tips",
    CN = "LanguageConfig_BreakThrough_Preview_Not_Completed_Tips_CN|唤醒体达到Lv.{s1}且守密人达到Lv.{s2}可升格"
  },
  BreakThrough_Preview_Item_Str = {
    ID = "BreakThrough_Preview_Item_Str",
    CN = "LanguageConfig_BreakThrough_Preview_Item_Str_CN|升格材料"
  },
  BreakThrough_Preview_Btn_Str = {
    ID = "BreakThrough_Preview_Btn_Str",
    CN = "LanguageConfig_BreakThrough_Preview_Btn_Str_CN|领取"
  },
  BreakThrough_Preview_Completed_Tips_Str = {
    ID = "BreakThrough_Preview_Completed_Tips_Str",
    CN = "LanguageConfig_BreakThrough_Preview_Completed_Tips_Str_CN|奖励已领取"
  },
  BreakThrough_Completed_Title_Str = {
    ID = "BreakThrough_Completed_Title_Str",
    CN = "LanguageConfig_BreakThrough_Completed_Title_Str_CN|升格成功"
  },
  BreakThrough_Completed_Level_Str = {
    ID = "BreakThrough_Completed_Level_Str",
    CN = "LanguageConfig_BreakThrough_Completed_Level_Str_CN|Lv.{s1}/Lv.{s2}"
  },
  BreakThrough_Completed_Deblock_Skill_Str = {
    ID = "BreakThrough_Completed_Deblock_Skill_Str",
    CN = "LanguageConfig_BreakThrough_Completed_Deblock_Skill_Str_CN|可激活新技能"
  },
  BreakThrough_Skill_Deblock_Str = {
    ID = "BreakThrough_Skill_Deblock_Str",
    CN = "LanguageConfig_BreakThrough_Skill_Deblock_Str_CN|唤醒体升格至{s1}阶解锁"
  },
  BreakThrough_Skill_Block_Str = {
    ID = "BreakThrough_Skill_Block_Str",
    CN = "LanguageConfig_BreakThrough_Skill_Block_Str_CN|已满级"
  },
  BreakThrough_Task_Requirement = {
    ID = "BreakThrough_Task_Requirement",
    CN = "LanguageConfig_BreakThrough_Task_Requirement_CN|完成任一升格条件后可升格"
  },
  BreakThrough_PlayLevel_Requirement = {
    ID = "BreakThrough_PlayLevel_Requirement",
    CN = "LanguageConfig_BreakThrough_PlayLevel_Requirement_CN|守密人达到Lv.{s1}可升格"
  },
  BreakThrough_Skill_Active_Requirement = {
    ID = "BreakThrough_Skill_Active_Requirement",
    CN = "LanguageConfig_BreakThrough_Skill_Active_Requirement_CN|需要激活{s1}"
  },
  BreakThrough_Skill_Active_Success = {
    ID = "BreakThrough_Skill_Active_Success",
    CN = "LanguageConfig_BreakThrough_Skill_Active_Success_CN|激活成功"
  },
  UniversalProgressDisplay = {
    ID = "UniversalProgressDisplay",
    CN = "LanguageConfig_UniversalProgressDisplay_CN|{s1}/{s2}"
  },
  UniversalSettlementPhiloStone = {
    ID = "UniversalSettlementPhiloStone",
    CN = "LanguageConfig_UniversalSettlementPhiloStone_CN|{s1}黑印"
  },
  UniversalCancelButton = {
    ID = "UniversalCancelButton",
    CN = "LanguageConfig_UniversalCancelButton_CN|取消"
  },
  UniversalConfirmButton = {
    ID = "UniversalConfirmButton",
    CN = "LanguageConfig_UniversalConfirmButton_CN|确定"
  },
  UniversalAlertTitle = {
    ID = "UniversalAlertTitle",
    CN = "LanguageConfig_UniversalAlertTitle_CN|提示"
  },
  ExchangeTitle = {
    ID = "ExchangeTitle",
    CN = "LanguageConfig_ExchangeTitle_CN|兑换银芯"
  },
  ExchangeNumZeroText = {
    ID = "ExchangeNumZeroText",
    CN = "LanguageConfig_ExchangeNumZeroText_CN|兑换数量不能为0"
  },
  ExchangeConfirmTitle = {
    ID = "ExchangeConfirmTitle",
    CN = "LanguageConfig_ExchangeConfirmTitle_CN|银芯不足"
  },
  ExchangeConfirmText = {
    ID = "ExchangeConfirmText",
    CN = "LanguageConfig_ExchangeConfirmText_CN|「银芯」不足，是否使用「源液」× {s1} 兑换等量「银芯」"
  },
  CurrencyNotEnoughTitle = {
    ID = "CurrencyNotEnoughTitle",
    CN = "LanguageConfig_CurrencyNotEnoughTitle_CN|源液不足"
  },
  CurrencyNotEnoughText = {
    ID = "CurrencyNotEnoughText",
    CN = "LanguageConfig_CurrencyNotEnoughText_CN|所需「源液」不足，是否前往源液提取？"
  },
  MonthCardLeftDaysText = {
    ID = "MonthCardLeftDaysText",
    CN = "LanguageConfig_MonthCardLeftDaysText_CN|剩余{s1}天"
  },
  MonthCardRuleText = {
    ID = "MonthCardRuleText",
    CN = "LanguageConfig_MonthCardRuleText_CN|<Title:【月相观测介绍】>\n·每次购买月相观测，可立即获得「银芯」× 300 和为期 30 天的月相观测许可。\n·月相观测生效时间内，每日登录可领取「银芯」× 200。（每日9点更新【GMT+8】）\n\n\n<Title:【注意事项】>\n·月相观测剩余生效时间≤150天内续购，可延长生效时间。\n·守密人在月相观测生效期间如因未登录而未领取的「银芯」不会返还。"
  },
  AwakerStoryBasicI = {
    ID = "AwakerStoryBasicI",
    CN = "LanguageConfig_AwakerStoryBasicI_CN|基本信息"
  },
  AwakerStoryName = {
    ID = "AwakerStoryName",
    CN = "LanguageConfig_AwakerStoryName_CN|名字"
  },
  AwakerStoryEpithet = {
    ID = "AwakerStoryEpithet",
    CN = "LanguageConfig_AwakerStoryEpithet_CN|称号"
  },
  AwakerStoryAge = {
    ID = "AwakerStoryAge",
    CN = "LanguageConfig_AwakerStoryAge_CN|年龄"
  },
  AwakerStoryBirth = {
    ID = "AwakerStoryBirth",
    CN = "LanguageConfig_AwakerStoryBirth_CN|生日"
  },
  AwakerStoryGender = {
    ID = "AwakerStoryGender",
    CN = "LanguageConfig_AwakerStoryGender_CN|性别"
  },
  AwakerStoryHeight = {
    ID = "AwakerStoryHeight",
    CN = "LanguageConfig_AwakerStoryHeight_CN|身高"
  },
  AwakerStoryWeight = {
    ID = "AwakerStoryWeight",
    CN = "LanguageConfig_AwakerStoryWeight_CN|体重"
  },
  AwakerStoryKnowsIndex = {
    ID = "AwakerStoryKnowsIndex",
    CN = "LanguageConfig_AwakerStoryKnowsIndex_CN|诺斯指数"
  },
  AwakerStoryIcon = {
    ID = "AwakerStoryIcon",
    CN = "LanguageConfig_AwakerStoryIcon_CN|故事"
  },
  AwakerVoiceIcon = {
    ID = "AwakerVoiceIcon",
    CN = "LanguageConfig_AwakerVoiceIcon_CN|语音"
  },
  ResonanceText = {
    ID = "ResonanceText",
    CN = "LanguageConfig_ResonanceText_CN|共鸣"
  },
  ResonanceReset = {
    ID = "ResonanceReset",
    CN = "LanguageConfig_ResonanceReset_CN|共鸣点重置"
  },
  ResonanceResetCostConfirm = {
    ID = "ResonanceResetCostConfirm",
    CN = "LanguageConfig_ResonanceResetCostConfirm_CN|是否需要消耗<color=%s>%d</color>%s重置当前关卡共鸣点？"
  },
  ResonanceUnlockText = {
    ID = "ResonanceUnlockText",
    CN = "LanguageConfig_ResonanceUnlockText_CN|未解锁"
  },
  ResonanceArriveMaxLevelText = {
    ID = "ResonanceArriveMaxLevelText",
    CN = "LanguageConfig_ResonanceArriveMaxLevelText_CN|已升至最高等级"
  },
  ResonanceUpgradeText = {
    ID = "ResonanceUpgradeText",
    CN = "LanguageConfig_ResonanceUpgradeText_CN|升级"
  },
  ResonanceActiveText = {
    ID = "ResonanceActiveText",
    CN = "LanguageConfig_ResonanceActiveText_CN|激活"
  },
  ResonanceActiveDefault = {
    ID = "ResonanceActiveDefault",
    CN = "LanguageConfig_ResonanceActiveDefault_CN|默认开启"
  },
  ResonanceTipsName = {
    ID = "ResonanceTipsName",
    CN = "LanguageConfig_ResonanceTipsName_CN|「%s」"
  },
  ResonanceRelateToEvent = {
    ID = "ResonanceRelateToEvent",
    CN = "LanguageConfig_ResonanceRelateToEvent_CN|受【共鸣】效果影响"
  },
  ResonanceEffectsText = {
    ID = "ResonanceEffectsText",
    CN = "LanguageConfig_ResonanceEffectsText_CN|%s(Lv.%d)：%s"
  },
  ResonanceActiveNoneEffectsText = {
    ID = "ResonanceActiveNoneEffectsText",
    CN = "LanguageConfig_ResonanceActiveNoneEffectsText_CN|未激活任何共鸣"
  },
  ResonanceSelectCard = {
    ID = "ResonanceSelectCard",
    CN = "LanguageConfig_ResonanceSelectCard_CN|选择一张卡牌复制"
  },
  Resonance_Group_Name_1 = {
    ID = "Resonance_Group_Name_1",
    CN = "LanguageConfig_Resonance_Group_Name_1_CN|孩童的歌谣"
  },
  Resonance_Group_Name_2 = {
    ID = "Resonance_Group_Name_2",
    CN = "LanguageConfig_Resonance_Group_Name_2_CN|蜡像手记"
  },
  Resonance_Group_Name_3 = {
    ID = "Resonance_Group_Name_3",
    CN = "LanguageConfig_Resonance_Group_Name_3_CN|呓语冥思"
  },
  Resonance_Group_Name_4 = {
    ID = "Resonance_Group_Name_4",
    CN = "LanguageConfig_Resonance_Group_Name_4_CN|疯人学究"
  },
  Resonance_Group_Name_5 = {
    ID = "Resonance_Group_Name_5",
    CN = "LanguageConfig_Resonance_Group_Name_5_CN|航海日记"
  },
  Resonance_Group_Name_6 = {
    ID = "Resonance_Group_Name_6",
    CN = "LanguageConfig_Resonance_Group_Name_6_CN|纯白之帆"
  },
  Resonance_Group_Name_7 = {
    ID = "Resonance_Group_Name_7",
    CN = "LanguageConfig_Resonance_Group_Name_7_CN|万千子嗣"
  },
  Resonance_Group_Name_8 = {
    ID = "Resonance_Group_Name_8",
    CN = "LanguageConfig_Resonance_Group_Name_8_CN|极夜的微光"
  },
  Resonance_Group_Name_9 = {
    ID = "Resonance_Group_Name_9",
    CN = "LanguageConfig_Resonance_Group_Name_9_CN|无上的意志"
  },
  Resonance_Group_Name_Railway = {
    ID = "Resonance_Group_Name_Railway",
    CN = "LanguageConfig_Resonance_Group_Name_Railway_CN|疾驰的欢愉专列"
  },
  Resonance_Group_Desc_1 = {
    ID = "Resonance_Group_Desc_1",
    CN = "LanguageConfig_Resonance_Group_Desc_1_CN|在节点【善意的礼物】处，可将 1 张「天真的回礼」加入牌库 —— 算力消耗 1，给予狂气最低的一名唤醒体 30 狂气，消耗。"
  },
  Resonance_Group_Desc_2 = {
    ID = "Resonance_Group_Desc_2",
    CN = "LanguageConfig_Resonance_Group_Desc_2_CN|在节点【未完的蜡像】处，可选择 1 张卡牌，使其算力消耗降低1。"
  },
  Resonance_Group_Desc_3 = {
    ID = "Resonance_Group_Desc_3",
    CN = "LanguageConfig_Resonance_Group_Desc_3_CN|在节点【古怪脓疱】处，可将一张「畸变之心」加入牌库，算力消耗 0，打出后弃掉所有手牌并抽取弃牌数+1的牌，消耗。"
  },
  Resonance_Group_Desc_4 = {
    ID = "Resonance_Group_Desc_4",
    CN = "LanguageConfig_Resonance_Group_Desc_4_CN|在节点【蜂蜜甜酒】处，可将一张「蜂蜜甜酒」加入牌库 —— 算力消耗 1，获得 1 层临时屏障，消耗。"
  },
  Resonance_Group_Desc_5 = {
    ID = "Resonance_Group_Desc_5",
    CN = "LanguageConfig_Resonance_Group_Desc_5_CN|于关卡「沉溺之徒」及之后关卡的节点【代行之仪】处，可获得「神国腕肢」效果——回合结束后对前排敌方造成自身队伍 10% 最大生命的伤害。\n可将一张「代行者的裁决」加入牌库——0算力消耗，打出后失去 10% 当前生命，使「神国腕肢」对后排敌方造成 3 倍伤害，若在首领战中则造成 10 倍伤害。消耗。"
  },
  Resonance_Group_Desc_6 = {
    ID = "Resonance_Group_Desc_6",
    CN = "LanguageConfig_Resonance_Group_Desc_6_CN|于「纯白之帆」处，将一张「乌托邦帷幕」加入牌库。1 算力消耗，查看 3 个与当前携带不同的钥令，选择 1 个立即释放，不会触发钥令冷却。首领战中可额外使用 1 次。消耗。"
  },
  Resonance_Group_Desc_7 = {
    ID = "Resonance_Group_Desc_7",
    CN = "LanguageConfig_Resonance_Group_Desc_7_CN|探索起点附近，会遭遇特殊的共鸣事件——【孕育之母】，选择一张指令卡，使其获得特殊的【孕育】刻印，但也使你获得 3 张随机症状卡。\n【孕育】刻印：使卡牌获得保留，回合结束时若在手中，获得一张附加保留和消耗的原始复制。"
  },
  Resonance_Group_Desc_8 = {
    ID = "Resonance_Group_Desc_8",
    CN = "LanguageConfig_Resonance_Group_Desc_8_CN|探索起点附近，会遭遇特殊的共鸣事件——【入学仪式】，将【极夜微光】加入牌库。\n【极夜微光】：选择抽牌堆或弃牌堆的 1 张指令卡置入手中，并使其算力消耗变为 0。使用 1 次后消耗。"
  },
  Resonance_Group_Desc_9 = {
    ID = "Resonance_Group_Desc_9",
    CN = "LanguageConfig_Resonance_Group_Desc_9_CN|探索起点附近，会遭遇特殊的共鸣事件——【入学仪式】，将【极夜微光】加入牌库且其继承第八章的所有加成。"
  },
  Resonance_Group_Desc_x1 = {
    ID = "Resonance_Group_Desc_x1",
    CN = "LanguageConfig_Resonance_Group_Desc_x1_CN|在共鸣事件「尚未流失的意识」处，将 一张「备用脑缸」洗入牌库。「备用脑缸」能够暂时储存曾经使用过的卡牌，依据不同场合决定是否将其取出置入手中。"
  },
  Resonance_Group_Desc_x2 = {
    ID = "Resonance_Group_Desc_x2",
    CN = "LanguageConfig_Resonance_Group_Desc_x2_CN|在「生命的蜕变」事件处，选择一名唤醒体转化为「虫族」。\n「虫族」的狂气回充和银钥充能提高 50%，所有指令卡算力消耗 -1，但打出后会消耗。"
  },
  Resonance_Group_Desc_x3 = {
    ID = "Resonance_Group_Desc_x3",
    CN = "LanguageConfig_Resonance_Group_Desc_x3_CN|在「宴前仪礼」事件处，将 1 张「祭灵夜特调」置入牌库。\n「祭灵夜特调」：算力消耗 1，所有唤醒体暴击率和暴击伤害临时提高 10%。打出「祭灵夜特调」后，将 1 种材料置入其中，使其在本场战斗中永久获得特定效果！"
  },
  Resonance_Group_Desc_x4 = {
    ID = "Resonance_Group_Desc_x4",
    CN = "LanguageConfig_Resonance_Group_Desc_x4_CN|在「墨菲的幻影」事件处，将 3 张「循环的倒影」置入牌库。\n打出「循环的倒影」时，发现一个「追忆效果」将其释放，消耗。余波：所有唤醒体获得 5 点狂气。"
  },
  Resonance_Group_Desc_x5 = {
    ID = "Resonance_Group_Desc_x5",
    CN = "LanguageConfig_Resonance_Group_Desc_x5_CN|临时文本，星辰章五共鸣功能描述。"
  },
  Resonance_Group_Desc_x6 = {
    ID = "Resonance_Group_Desc_x6",
    CN = "LanguageConfig_Resonance_Group_Desc_x6_CN|临时文本，星辰章六共鸣功能描述。"
  },
  Resonance_Group_Desc_Lily = {
    ID = "Resonance_Group_Desc_Lily",
    CN = "LanguageConfig_Resonance_Group_Desc_Lily_CN|在共鸣事件「制片人的迷思」处，选项「求助合伙人」可以获得高级刻印 3 选 1 。"
  },
  Resonance_Group_Desc_Wangda = {
    ID = "Resonance_Group_Desc_Wangda",
    CN = "LanguageConfig_Resonance_Group_Desc_Wangda_CN|在共鸣事件「代行密令」处，选项「获取经费」可以获得25黑印和随机白银造物 。"
  },
  Resonance_Group_Desc_SEWD = {
    ID = "Resonance_Group_Desc_SEWD",
    CN = "LanguageConfig_Resonance_Group_Desc_SEWD_CN|「欲望」事件获得随机负罪造物或黄金造物；「忏悔」事件将负罪造物净化为受祝造物；「救赎」事件可以删除症状卡获得奖励"
  },
  Resonance_Group_Desc_24 = {
    ID = "Resonance_Group_Desc_24",
    CN = "LanguageConfig_Resonance_Group_Desc_24_CN|在「疯狂之路」事件中指定一名唤醒体使其精神分裂，失去初始的四张指令卡，此后，前进的道路才会出现并使你获得 3 选 1 黄金造物。\n你可以在后续的四个「精神碎片」事件中逐个找回失去的指令卡，找回的指令卡将直接拥有独特的<EnsembleKeywords:「合奏」>刻印。"
  },
  Resonance_Group_Desc_MLYM = {
    ID = "Resonance_Group_Desc_MLYM",
    CN = "LanguageConfig_Resonance_Group_Desc_MLYM_CN|探索开始时将 3 张增益卡加入牌库：<DerivativeCardKeywords_57:「温暖的家庭」>、<DerivativeCardKeywords_58:「诚挚的朋友」>、<DerivativeCardKeywords_59:「安定的生活」>。\n「温暖的家庭」：获得 2 点算力。\n「诚挚的朋友」：对所有敌人施加 1 层虚弱、易伤。\n「安定的生活」：抽 2 张牌。"
  },
  Resonance_Group_Desc_Horla = {
    ID = "Resonance_Group_Desc_Horla",
    CN = "LanguageConfig_Resonance_Group_Desc_Horla_CN|探索开始时获得初始造物「奥尔拉的笔与墨」：战斗结束后获得 1 层「笔墨」，「笔墨」达到 2 层后消耗，随机将 1 张「意象」置入牌库。\n可在特殊的共鸣事件【春天的赠礼】中选择「创作献诗」：选择 3 张「意象」卡，让奥尔拉为你创作「献诗」。"
  },
  Resonance_Group_Desc_D05EX = {
    ID = "Resonance_Group_Desc_D05EX",
    CN = "LanguageConfig_Resonance_Group_Desc_D05EX_CN|获得初始造物「科考团」：初始拥有 30 科考团人数。战斗开始时，将 5 张「猜疑」置入牌库中。「猜疑」：打出后将选择消耗不同的科考团人数，获得不同效果。\n\\n在探索的过程中，将不断的面临「猜疑」的抉择，科考团人员的损失，触发联络处后，还有机会获得救援，最后安全撤离时，根据剩余科考团人数获得「救难勋章」，撤离人数越多「救难勋章」越强大。"
  },
  Resonance_Group_Desc_Railway = {
    ID = "Resonance_Group_Desc_Railway",
    CN = "LanguageConfig_Resonance_Group_Desc_Railway_CN|待填充。"
  },
  Dev_EnterAccount = {
    ID = "Dev_EnterAccount",
    CN = "LanguageConfig_Dev_EnterAccount_CN|请输入账号"
  },
  Dev_SelectServer = {
    ID = "Dev_SelectServer",
    CN = "LanguageConfig_Dev_SelectServer_CN|请选择服务器"
  },
  ReplenishEnergy_Title = {
    ID = "ReplenishEnergy_Title",
    CN = "LanguageConfig_ReplenishEnergy_Title_CN|补充灵啡肽"
  },
  ReplenishEnergy_Supplement = {
    ID = "ReplenishEnergy_Supplement",
    CN = "LanguageConfig_ReplenishEnergy_Supplement_CN|补充方式"
  },
  ReplenishEnergy_ExchangeDesc1 = {
    ID = "ReplenishEnergy_ExchangeDesc1",
    CN = "LanguageConfig_ReplenishEnergy_ExchangeDesc1_CN|使用后，获得「灵啡肽」× <Blue:{s1}>"
  },
  ReplenishEnergy_ExchangeDesc2 = {
    ID = "ReplenishEnergy_ExchangeDesc2",
    CN = "LanguageConfig_ReplenishEnergy_ExchangeDesc2_CN|消耗 <Blue:「银芯」× {s1}>，获得「灵啡肽」× <Blue:{s2}>，今日剩余获取次数：<Blue:{s3}>"
  },
  ReplenishEnergy_ExchangeSubDesc1 = {
    ID = "ReplenishEnergy_ExchangeSubDesc1"
  },
  ReplenishEnergy_ExchangeSubDesc2 = {
    ID = "ReplenishEnergy_ExchangeSubDesc2",
    CN = "LanguageConfig_ReplenishEnergy_ExchangeSubDesc2_CN|单日补充次数越多，所需「银芯」越多"
  },
  ReplenishEnergy_Comfirm1 = {
    ID = "ReplenishEnergy_Comfirm1",
    CN = "LanguageConfig_ReplenishEnergy_Comfirm1_CN|确认"
  },
  ReplenishEnergy_Comfirm2 = {
    ID = "ReplenishEnergy_Comfirm2",
    CN = "LanguageConfig_ReplenishEnergy_Comfirm2_CN|兑换"
  },
  Event_ItemUseTitle = {
    ID = "Event_ItemUseTitle",
    CN = "LanguageConfig_Event_ItemUseTitle_CN|快捷使用"
  },
  Event_ItemUseConfirm = {
    ID = "Event_ItemUseConfirm",
    CN = "LanguageConfig_Event_ItemUseConfirm_CN|确认"
  },
  Event_ItemUseCancel = {
    ID = "Event_ItemUseCancel",
    CN = "LanguageConfig_Event_ItemUseCancel_CN|取消"
  },
  Event_ItemUseLeftCnt = {
    ID = "Event_ItemUseLeftCnt",
    CN = "LanguageConfig_Event_ItemUseLeftCnt_CN|剩余：{s1}"
  },
  Event_ItemUseCnt = {
    ID = "Event_ItemUseCnt",
    CN = "LanguageConfig_Event_ItemUseCnt_CN|使用数量"
  },
  Event_ItemOwnCnt = {
    ID = "Event_ItemOwnCnt",
    CN = "LanguageConfig_Event_ItemOwnCnt_CN|持有数：{s1}"
  },
  BattlePassLeftTimeMore = {
    ID = "BattlePassLeftTimeMore",
    CN = "LanguageConfig_BattlePassLeftTimeMore_CN|{s1}天{s2}小时"
  },
  BattlePassLeftTimeLess = {
    ID = "BattlePassLeftTimeLess",
    CN = "LanguageConfig_BattlePassLeftTimeLess_CN|{s1}小时{s2}分钟"
  },
  BattlePassLevel = {
    ID = "BattlePassLevel",
    CN = "LanguageConfig_BattlePassLevel_CN|%d级"
  },
  BPExpireTips = {
    ID = "BPExpireTips",
    CN = "LanguageConfig_BPExpireTips_CN|新学期课题已更新"
  },
  BPOpenPreviewTxt = {
    ID = "BPOpenPreviewTxt",
    CN = "LanguageConfig_BPOpenPreviewTxt_CN|{s1}天{s2}小时后新课题开启"
  },
  BPExpWeeklyLimitTxt = {
    ID = "BPExpWeeklyLimitTxt",
    CN = "LanguageConfig_BPExpWeeklyLimitTxt_CN|本周课题经验获取已达到上限"
  },
  BPLevelLimitTxt = {
    ID = "BPLevelLimitTxt",
    CN = "LanguageConfig_BPLevelLimitTxt_CN|恭喜你的课题等级已满"
  },
  BPRuleTxt = {
    ID = "BPRuleTxt",
    CN = "LanguageConfig_BPRuleTxt_CN|<Title:【课题类别】>\n·每期课题中，基础课题默认解锁获取，守密人还可通过解锁高阶课题，获取更丰厚的奖励。\n·通常每期课题会持续 28 天，有时候弥萨格会开启持续时间更短的特殊课题，特殊课题期间获取到的课题经验都会翻倍，助力守密人更快完成当期课题！\n \n·持续 28 天的课题：\n  ·解锁「高阶课题」需要「源液」×680，可立即获得 「银芯」×680。\n  ·解锁「核心课题」需要「源液」×1280，可立即获得「银芯」×1460。\n  ·将「高级课题」升级为「核心课题」需要「源液」×780，可立即获得「银芯」×780。\n \n·特殊课题：\n  ·课题期间获得的「课题经验」翻倍。\n  ·解锁「高阶课题」需要「源液」×680，可立即获得 「银芯」×680。\n  ·解锁「核心课题」需要「源液」×980，可立即获得「银芯」×1070。\n  ·将「高级课题」升级为「核心课题」需要「源液」×390，可立即获得「银芯」×390。\n\n<Title:【核心课题特权】>\n·解锁「核心课题」后，可以在本期课题持续期间获得特权。\n·在「日常试训」的「基础活性离子」累积奖励中获得的「现实起点」、「无垢之芯」、「经验」、「银芯」提升至 3 倍。购买「核心课题」后会补发本期已领取的「基础活性离子」累积奖励的额外倍率部分。\n·可以在战斗中使用「时序逆行」返回经历过的回合。\n·可以在「相位对弈」中限时解锁所有卡牌。\n\n<Title:【课题等级】>\n·守密人可通过完成密境课室的日常试训和周常试训来获取课题经验，提高课题等级，获取丰厚奖励。\n·「日常试训」将在9点刷新，「周常试训」将在每周一9点(GMT+8)刷新。\n·课题等级达到50级后，每提升1级，可获得1份额外奖励。"
  },
  BPAwardTab = {
    ID = "BPAwardTab",
    CN = "LanguageConfig_BPAwardTab_CN|奖励"
  },
  BPTaskTab = {
    ID = "BPTaskTab",
    CN = "LanguageConfig_BPTaskTab_CN|任务"
  },
  BPBoxTab = {
    ID = "BPBoxTab",
    CN = "LanguageConfig_BPBoxTab_CN|礼匣"
  },
  BPBuyLevelTxt = {
    ID = "BPBuyLevelTxt",
    CN = "LanguageConfig_BPBuyLevelTxt_CN|<size=30><color=#ffffff>购买后升至</color></size>%d<size=34><color=#ffffff>级，可以获得以下奖励"
  },
  BPTaskSubTabDaily = {
    ID = "BPTaskSubTabDaily",
    CN = "LanguageConfig_BPTaskSubTabDaily_CN|每日任务"
  },
  BPTaskSubTabMonthly = {
    ID = "BPTaskSubTabMonthly",
    CN = "LanguageConfig_BPTaskSubTabMonthly_CN|每周任务"
  },
  BPTaskSubTabPeriod = {
    ID = "BPTaskSubTabPeriod",
    CN = "LanguageConfig_BPTaskSubTabPeriod_CN|学期任务"
  },
  BPSingleChooseTitle = {
    ID = "BPSingleChooseTitle",
    CN = "LanguageConfig_BPSingleChooseTitle_CN|请选择获得的奖励"
  },
  BPMultiChooseTitle = {
    ID = "BPMultiChooseTitle",
    CN = "LanguageConfig_BPMultiChooseTitle_CN|请选择获得的奖励"
  },
  BPMultiChooseTitleNum = {
    ID = "BPMultiChooseTitleNum",
    CN = "LanguageConfig_BPMultiChooseTitleNum_CN|（{s1}/{s2}）"
  },
  BPChooseNextBtn = {
    ID = "BPChooseNextBtn",
    CN = "LanguageConfig_BPChooseNextBtn_CN|下一个"
  },
  BPChooseConfirmBtn = {
    ID = "BPChooseConfirmBtn",
    CN = "LanguageConfig_BPChooseConfirmBtn_CN|确认"
  },
  BPChooseColectDirectlyBtn = {
    ID = "BPChooseColectDirectlyBtn",
    CN = "LanguageConfig_BPChooseColectDirectlyBtn_CN|直接领取"
  },
  BPChooseSelectHint = {
    ID = "BPChooseSelectHint",
    CN = "LanguageConfig_BPChooseSelectHint_CN|请选择您想要的奖励"
  },
  BPMultiChooseLastHint = {
    ID = "BPMultiChooseLastHint",
    CN = "LanguageConfig_BPMultiChooseLastHint_CN|已经是最后一个奖励"
  },
  BPNewOpenTitle = {
    ID = "BPNewOpenTitle",
    CN = "LanguageConfig_BPNewOpenTitle_CN|新课题开启"
  },
  BPNewOpenContent = {
    ID = "BPNewOpenContent",
    CN = "LanguageConfig_BPNewOpenContent_CN|新学期课题已开启！\n完成密境课室的日常试训和周常试训，提升课题等级，领取丰厚奖励！"
  },
  BPExtraLvAwardTxt = {
    ID = "BPExtraLvAwardTxt",
    CN = "LanguageConfig_BPExtraLvAwardTxt_CN|额外奖励"
  },
  BPAdvanceBuyConfirmTipTopDesc = {
    ID = "BPAdvanceBuyConfirmTipTopDesc",
    CN = "LanguageConfig_BPAdvanceBuyConfirmTipTopDesc_CN|购买「核心课题」后会补发本期已领取的「基础活性离子」累积奖励的额外倍率部分。"
  },
  BPAdvanceBuyConfirmTipBottomDesc = {
    ID = "BPAdvanceBuyConfirmTipBottomDesc",
    CN = "LanguageConfig_BPAdvanceBuyConfirmTipBottomDesc_CN|是否消耗 <Blue:{s1}>源液购买？"
  },
  Dispel_Tips = {
    ID = "Dispel_Tips",
    CN = "LanguageConfig_Dispel_Tips_CN|驱散{s1}"
  },
  WeaponEnhanceCost = {
    ID = "WeaponEnhanceCost",
    CN = "LanguageConfig_WeaponEnhanceCost_CN|消耗材料({s1}/{s2})"
  },
  WeaponEnhanceMtrlType_1 = {
    ID = "WeaponEnhanceMtrlType_1",
    CN = "LanguageConfig_WeaponEnhanceMtrlType_1_CN|以太"
  },
  WeaponEnhanceMtrlType_2 = {
    ID = "WeaponEnhanceMtrlType_2",
    CN = "LanguageConfig_WeaponEnhanceMtrlType_2_CN|R阶及以下的命轮"
  },
  WeaponBreakthroughTip = {
    ID = "WeaponBreakthroughTip",
    CN = "LanguageConfig_WeaponBreakthroughTip_CN|命轮提升到{s1}级可升格下一阶"
  },
  WeaponBreakthroughPlayerLevelRequire = {
    ID = "WeaponBreakthroughPlayerLevelRequire",
    CN = "LanguageConfig_WeaponBreakthroughPlayerLevelRequire_CN|需要守密人达到 {s1} 级"
  },
  WeaponReachBreakthroughLimit = {
    ID = "WeaponReachBreakthroughLimit",
    CN = "LanguageConfig_WeaponReachBreakthroughLimit_CN|已满级"
  },
  WeaponCurrRefineLevel = {
    ID = "WeaponCurrRefineLevel",
    CN = "LanguageConfig_WeaponCurrRefineLevel_CN|{s1}阶"
  },
  WeaponReachNewRefineLevel = {
    ID = "WeaponReachNewRefineLevel",
    CN = "LanguageConfig_WeaponReachNewRefineLevel_CN|已叠位至{s1}阶"
  },
  ExaltUpgradeDescription = {
    ID = "ExaltUpgradeDescription",
    CN = "LanguageConfig_ExaltUpgradeDescription_CN|等于其他技能等级的平均值"
  },
  WeaponEnhanceMtrlSortType_1 = {
    ID = "WeaponEnhanceMtrlSortType_1",
    CN = "LanguageConfig_WeaponEnhanceMtrlSortType_1_CN|强化等级"
  },
  WeaponEnhanceMtrlSortType_2 = {
    ID = "WeaponEnhanceMtrlSortType_2",
    CN = "LanguageConfig_WeaponEnhanceMtrlSortType_2_CN|稀有度"
  },
  WeaponEnhanced = {
    ID = "WeaponEnhanced",
    CN = "LanguageConfig_WeaponEnhanced_CN|已强化"
  },
  WeaponRefined = {
    ID = "WeaponRefined",
    CN = "LanguageConfig_WeaponRefined_CN|已叠位"
  },
  WeaponHigherQuality = {
    ID = "WeaponHigherQuality",
    CN = "LanguageConfig_WeaponHigherQuality_CN|稀有度较高"
  },
  WeaponOverflowReturn = {
    ID = "WeaponOverflowReturn",
    CN = "LanguageConfig_WeaponOverflowReturn_CN|溢出经验返还"
  },
  WeaponUnequip = {
    ID = "WeaponUnequip",
    CN = "LanguageConfig_WeaponUnequip_CN|未装备"
  },
  WeaponUnequip_2 = {
    ID = "WeaponUnequip_2",
    CN = "LanguageConfig_WeaponUnequip_2_CN|未装备命轮"
  },
  WeaponListEmpty = {
    ID = "WeaponListEmpty",
    CN = "LanguageConfig_WeaponListEmpty_CN|无可装备命轮"
  },
  WeaponBreakthroughSkillDesc = {
    ID = "WeaponBreakthroughSkillDesc",
    CN = "LanguageConfig_WeaponBreakthroughSkillDesc_CN|特殊能力"
  },
  ActiveSkill = {
    ID = "ActiveSkill",
    CN = "LanguageConfig_ActiveSkill_CN|技能激活"
  },
  Refine = {
    ID = "Refine",
    CN = "LanguageConfig_Refine_CN|叠位"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_Month = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_Month",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_CN|月相观测"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_Root = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_Root",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_CN|浮沫兑换"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_CN|源液提取"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_AdvanceDC = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_AdvanceDC",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_AdvanceDC_CN|沉淀兑换"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Normal_GiftBag = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Normal_GiftBag",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_GiftBag_CN|精选礼盒"
  },
  UI_Recharge_Panel_DayShopItemRefresh = {
    ID = "UI_Recharge_Panel_DayShopItemRefresh",
    CN = "LanguageConfig_UI_Recharge_Panel_DayShopItemRefresh_CN|{s1}天{s2}小时"
  },
  UI_Recharge_Panel_DayShopItemRefresh_Hour = {
    ID = "UI_Recharge_Panel_DayShopItemRefresh_Hour",
    CN = "LanguageConfig_UI_Recharge_Panel_DayShopItemRefresh_Hour_CN|{s1}小时{s2}分钟"
  },
  UI_Recharge_Panel_HourShopItemRefresh = {
    ID = "UI_Recharge_Panel_HourShopItemRefresh",
    CN = "LanguageConfig_UI_Recharge_Panel_HourShopItemRefresh_CN|0天{s1}小时"
  },
  UI_Recharge_Panel_Deadline = {
    ID = "UI_Recharge_Panel_Deadline",
    CN = "LanguageConfig_UI_Recharge_Panel_Deadline_CN|{s1}天{s2}小时后下架"
  },
  UI_Recharge_Panel_Deadline_Hour = {
    ID = "UI_Recharge_Panel_Deadline_Hour",
    CN = "LanguageConfig_UI_Recharge_Panel_Deadline_Hour_CN|{s1}小时{s2}分后下架"
  },
  UI_Recharge_Panel_SpecialSaleDeadline = {
    ID = "UI_Recharge_Panel_SpecialSaleDeadline",
    CN = "LanguageConfig_UI_Recharge_Panel_SpecialSaleDeadline_CN|{s1}天{s2}小时后结束"
  },
  UI_Recharge_Panel_SpecialSaleDeadline_Hour = {
    ID = "UI_Recharge_Panel_SpecialSaleDeadline_Hour",
    CN = "LanguageConfig_UI_Recharge_Panel_SpecialSaleDeadline_Hour_CN|{s1}小时{s2}分后结束"
  },
  UI_Recharge_Panel_PlayerLevelCondition = {
    ID = "UI_Recharge_Panel_PlayerLevelCondition",
    CN = "LanguageConfig_UI_Recharge_Panel_PlayerLevelCondition_CN|调查等级 {s1}级 解锁"
  },
  UI_Recharge_Panel_HaveItemCondition = {
    ID = "UI_Recharge_Panel_HaveItemCondition",
    CN = "LanguageConfig_UI_Recharge_Panel_HaveItemCondition_CN|拥有{s1}后解锁"
  },
  MainShopSingleBuyConfirmPanel_SellOut = {
    ID = "MainShopSingleBuyConfirmPanel_SellOut",
    CN = "LanguageConfig_MainShopSingleBuyConfirmPanel_SellOut_CN|已售罄"
  },
  MainShopSingleBuyConfirmPanel_Lock = {
    ID = "MainShopSingleBuyConfirmPanel_Lock",
    CN = "LanguageConfig_MainShopSingleBuyConfirmPanel_Lock_CN|未解锁"
  },
  MainShopSingleBuyConfirmPanel_MaxPotency = {
    ID = "MainShopSingleBuyConfirmPanel_MaxPotency",
    CN = "LanguageConfig_MainShopSingleBuyConfirmPanel_MaxPotency_CN|启灵已达最高"
  },
  UI_WeekBoss_Refresh = {
    ID = "UI_WeekBoss_Refresh",
    CN = "LanguageConfig_UI_WeekBoss_Refresh_CN|{s1}天{s2}小时后刷新"
  },
  SpecialTeamAssignTitle = {
    ID = "SpecialTeamAssignTitle",
    CN = "LanguageConfig_SpecialTeamAssignTitle_CN|预设队伍"
  },
  RelicGroup_1 = {
    ID = "RelicGroup_1",
    CN = "LanguageConfig_RelicGroup_1_CN|起源"
  },
  RelicGroup_2 = {
    ID = "RelicGroup_2",
    CN = "LanguageConfig_RelicGroup_2_CN|萌芽"
  },
  RelicGroup_3 = {
    ID = "RelicGroup_3",
    CN = "LanguageConfig_RelicGroup_3_CN|节律"
  },
  RelicGroup_4 = {
    ID = "RelicGroup_4",
    CN = "LanguageConfig_RelicGroup_4_CN|无厌"
  },
  RelicGroup_5 = {
    ID = "RelicGroup_5",
    CN = "LanguageConfig_RelicGroup_5_CN|脓血"
  },
  RelicGroup_6 = {
    ID = "RelicGroup_6",
    CN = "LanguageConfig_RelicGroup_6_CN|狂想"
  },
  RelicGroup_7 = {
    ID = "RelicGroup_7",
    CN = "LanguageConfig_RelicGroup_7_CN|诡丽"
  },
  RelicGroup_8 = {
    ID = "RelicGroup_8",
    CN = "LanguageConfig_RelicGroup_8_CN|适性"
  },
  RelicGroup_9 = {
    ID = "RelicGroup_9",
    CN = "LanguageConfig_RelicGroup_9_CN|进击"
  },
  RelicGroup_10 = {
    ID = "RelicGroup_10",
    CN = "LanguageConfig_RelicGroup_10_CN|戏法"
  },
  RelicGroup_11 = {
    ID = "RelicGroup_11",
    CN = "LanguageConfig_RelicGroup_11_CN|诅咒"
  },
  RelicGroup_12 = {
    ID = "RelicGroup_12",
    CN = "LanguageConfig_RelicGroup_12_CN|护佑"
  },
  RelicGroup_13 = {
    ID = "RelicGroup_13",
    CN = "LanguageConfig_RelicGroup_13_CN|双生"
  },
  RelicGroup_14 = {
    ID = "RelicGroup_14",
    CN = "LanguageConfig_RelicGroup_14_CN|增殖"
  },
  RelicGroup_15 = {
    ID = "RelicGroup_15",
    CN = "LanguageConfig_RelicGroup_15_CN|至臻"
  },
  RelicGroup_16 = {
    ID = "RelicGroup_16",
    CN = "LanguageConfig_RelicGroup_16_CN|即刻"
  },
  RelicGroup_99 = {
    ID = "RelicGroup_99",
    CN = "LanguageConfig_RelicGroup_99_CN|深海"
  },
  RelicGroup_100 = {
    ID = "RelicGroup_100",
    CN = "LanguageConfig_RelicGroup_100_CN|血肉"
  },
  RelicGroup_101 = {
    ID = "RelicGroup_101",
    CN = "LanguageConfig_RelicGroup_101_CN|超维"
  },
  RelicGroup_999 = {
    ID = "RelicGroup_999",
    CN = "LanguageConfig_RelicGroup_999_CN|造物组测试999"
  },
  RelicGroup_998 = {
    ID = "RelicGroup_998",
    CN = "LanguageConfig_RelicGroup_998_CN|负罪"
  },
  RelicGroup_997 = {
    ID = "RelicGroup_997",
    CN = "LanguageConfig_RelicGroup_997_CN|受祝"
  },
  RelicGroup_290 = {
    ID = "RelicGroup_290",
    CN = "LanguageConfig_RelicGroup_290_CN|维度影像-混沌"
  },
  RelicGroup_291 = {
    ID = "RelicGroup_291",
    CN = "LanguageConfig_RelicGroup_291_CN|维度影像-深海"
  },
  RelicGroup_292 = {
    ID = "RelicGroup_292",
    CN = "LanguageConfig_RelicGroup_292_CN|维度影像-血肉"
  },
  RelicGroup_293 = {
    ID = "RelicGroup_293",
    CN = "LanguageConfig_RelicGroup_293_CN|维度影像-超维"
  },
  RelicGroup_201 = {
    ID = "RelicGroup_201",
    CN = "LanguageConfig_RelicGroup_201_CN|原初"
  },
  RelicGroup_202 = {
    ID = "RelicGroup_202",
    CN = "LanguageConfig_RelicGroup_202_CN|主宰"
  },
  RelicGroup_203 = {
    ID = "RelicGroup_203",
    CN = "LanguageConfig_RelicGroup_203_CN|潜能"
  },
  RelicGroup_204 = {
    ID = "RelicGroup_204",
    CN = "LanguageConfig_RelicGroup_204_CN|统御"
  },
  RelicGroup_251 = {
    ID = "RelicGroup_251",
    CN = "LanguageConfig_RelicGroup_251_CN|超维"
  },
  RelicGroup_252 = {
    ID = "RelicGroup_252",
    CN = "LanguageConfig_RelicGroup_252_CN|血肉"
  },
  RelicGroup_253 = {
    ID = "RelicGroup_253",
    CN = "LanguageConfig_RelicGroup_253_CN|深海"
  },
  RelicGroup_205 = {
    ID = "RelicGroup_205",
    CN = "LanguageConfig_RelicGroup_205_CN|处决"
  },
  RelicGroup_206 = {
    ID = "RelicGroup_206",
    CN = "LanguageConfig_RelicGroup_206_CN|腐蚀"
  },
  RelicGroup_207 = {
    ID = "RelicGroup_207",
    CN = "LanguageConfig_RelicGroup_207_CN|洞察"
  },
  RelicGroup_208 = {
    ID = "RelicGroup_208",
    CN = "LanguageConfig_RelicGroup_208_CN|凋亡"
  },
  RelicGroup_209 = {
    ID = "RelicGroup_209",
    CN = "LanguageConfig_RelicGroup_209_CN|血祭"
  },
  RelicGroup_210 = {
    ID = "RelicGroup_210",
    CN = "LanguageConfig_RelicGroup_210_CN|无明"
  },
  EnchantGroup_1 = {
    ID = "EnchantGroup_1",
    CN = "LanguageConfig_EnchantGroup_1_CN|刻印"
  },
  EnchantGroup_2 = {
    ID = "EnchantGroup_2",
    CN = "LanguageConfig_EnchantGroup_2_CN|特殊刻印"
  },
  ReportTimeLimited = {
    ID = "ReportTimeLimited",
    CN = "LanguageConfig_ReportTimeLimited_CN|今日举报次数已达上限"
  },
  Dot = {
    ID = "Dot",
    CN = "LanguageConfig_Dot_CN|。"
  },
  TalentTab_ALL = {
    ID = "TalentTab_ALL",
    CN = "LanguageConfig_TalentTab_ALL_CN|全部"
  },
  LevelSuppression_Description_Title = {
    ID = "LevelSuppression_Description_Title",
    CN = "LanguageConfig_LevelSuppression_Description_Title_CN|推荐等级"
  },
  LevelSuppression_Description_Detail = {
    ID = "LevelSuppression_Description_Detail",
    CN = "LanguageConfig_LevelSuppression_Description_Detail_CN|·推荐等级主要为守密人提供本次调查难度的参考标准，若队伍平均等级或守密人调查等级低于推荐等级，进行的调查时可能会遇到较大的挑战。"
  },
  RecClass_Description_Title = {
    ID = "RecClass_Description_Title",
    CN = "LanguageConfig_RecClass_Description_Title_CN|推荐界域说明"
  },
  RecClass_Description_Detail = {
    ID = "RecClass_Description_Detail",
    CN = "LanguageConfig_RecClass_Description_Detail_CN|·如果队伍激活界域与任一推荐界域相同，则所有出战唤醒体的体质、攻击、防御获得固定比例的提升。"
  },
  LevelSuppression_tips = {
    ID = "LevelSuppression_tips",
    CN = "LanguageConfig_LevelSuppression_tips_CN|我方队伍属性{s1}"
  },
  RecClass_tips = {
    ID = "RecClass_tips",
    CN = "LanguageConfig_RecClass_tips_CN|我方队伍属性{s1}"
  },
  School_Activate = {
    ID = "School_Activate",
    CN = "LanguageConfig_School_Activate_CN|已激活"
  },
  Team_Occupation_Tips = {
    ID = "Team_Occupation_Tips",
    CN = "LanguageConfig_Team_Occupation_Tips_CN|界域天赋"
  },
  PlayerLv = {
    ID = "PlayerLv",
    CN = "LanguageConfig_PlayerLv_CN|调查等级"
  },
  TeamAverageLevel = {
    ID = "TeamAverageLevel",
    CN = "LanguageConfig_TeamAverageLevel_CN|队伍平均等级"
  },
  TeamSkillStrength = {
    ID = "TeamSkillStrength",
    CN = "LanguageConfig_TeamSkillStrength_CN|队伍技能强度"
  },
  TeamWeaponStrength = {
    ID = "TeamWeaponStrength",
    CN = "LanguageConfig_TeamWeaponStrength_CN|队伍命轮强度"
  },
  TeamTrinketStrength = {
    ID = "TeamTrinketStrength",
    CN = "LanguageConfig_TeamTrinketStrength_CN|队伍密契强度"
  },
  TeamRecommendLevel = {
    ID = "TeamRecommendLevel",
    CN = "LanguageConfig_TeamRecommendLevel_CN|推荐{s1}级"
  },
  RecommendAccountLevel = {
    ID = "RecommendAccountLevel",
    CN = "LanguageConfig_RecommendAccountLevel_CN|推荐{s1}级"
  },
  ShopChargeDesc = {
    ID = "ShopChargeDesc",
    CN = "LanguageConfig_ShopChargeDesc_CN|{s1}滴{s2}"
  },
  PlayerNotLoggedIn = {
    ID = "PlayerNotLoggedIn",
    CN = "LanguageConfig_PlayerNotLoggedIn_CN|玩家-未登录"
  },
  AwakerUpgradeBtnText = {
    ID = "AwakerUpgradeBtnText",
    CN = "LanguageConfig_AwakerUpgradeBtnText_CN|升级"
  },
  AwakerUpgradeMaxBtnText = {
    ID = "AwakerUpgradeMaxBtnText",
    CN = "LanguageConfig_AwakerUpgradeMaxBtnText_CN|已满级"
  },
  AwakerPotencyBtnText = {
    ID = "AwakerPotencyBtnText",
    CN = "LanguageConfig_AwakerPotencyBtnText_CN|激活"
  },
  AwakerTrinketStrengthenBtnText = {
    ID = "AwakerTrinketStrengthenBtnText",
    CN = "LanguageConfig_AwakerTrinketStrengthenBtnText_CN|强化"
  },
  BagItemUseBtnText = {
    ID = "BagItemUseBtnText",
    CN = "LanguageConfig_BagItemUseBtnText_CN|使用"
  },
  DailyCopyChallengeBtnText = {
    ID = "DailyCopyChallengeBtnText",
    CN = "LanguageConfig_DailyCopyChallengeBtnText_CN|挑战"
  },
  CommonItemFirst3Star = {
    ID = "CommonItemFirst3Star",
    CN = "LanguageConfig_CommonItemFirst3Star_CN|三星"
  },
  CommonItemFirst = {
    ID = "CommonItemFirst",
    CN = "LanguageConfig_CommonItemFirst_CN|首通"
  },
  CommonItemDailyFirst = {
    ID = "CommonItemDailyFirst",
    CN = "LanguageConfig_CommonItemDailyFirst_CN|本日首通"
  },
  CommonItemExplore = {
    ID = "CommonItemExplore",
    CN = "LanguageConfig_CommonItemExplore_CN|探索"
  },
  CommonItemBattle = {
    ID = "CommonItemBattle",
    CN = "LanguageConfig_CommonItemBattle_CN|战斗"
  },
  CommonItemShop = {
    ID = "CommonItemShop",
    CN = "LanguageConfig_CommonItemShop_CN|弥萨格商店"
  },
  CommonItemHide = {
    ID = "CommonItemHide",
    CN = "LanguageConfig_CommonItemHide_CN|隐藏"
  },
  CommonItemAchievement = {
    ID = "CommonItemAchievement",
    CN = "LanguageConfig_CommonItemAchievement_CN|成就"
  },
  CommonItemTalent = {
    ID = "CommonItemTalent",
    CN = "LanguageConfig_CommonItemTalent_CN|共鸣"
  },
  SettingPanelTitle = {
    ID = "SettingPanelTitle",
    CN = "LanguageConfig_SettingPanelTitle_CN|设置"
  },
  RedemptionCodePanelTitle = {
    ID = "RedemptionCodePanelTitle",
    CN = "LanguageConfig_RedemptionCodePanelTitle_CN|兑换奖励"
  },
  SettingToggleOpen = {
    ID = "SettingToggleOpen",
    CN = "LanguageConfig_SettingToggleOpen_CN|开启"
  },
  SettingToggleClose = {
    ID = "SettingToggleClose",
    CN = "LanguageConfig_SettingToggleClose_CN|关闭"
  },
  CopySweepBtnText = {
    ID = "CopySweepBtnText",
    CN = "LanguageConfig_CopySweepBtnText_CN|重现"
  },
  AchievementRewards = {
    ID = "AchievementRewards",
    CN = "LanguageConfig_AchievementRewards_CN|成就奖励"
  },
  setUp = {
    ID = "setUp",
    CN = "LanguageConfig_setUp_CN|设置"
  },
  FightAgain = {
    ID = "FightAgain",
    CN = "LanguageConfig_FightAgain_CN|重新战斗"
  },
  ExitInvestigation = {
    ID = "ExitInvestigation",
    CN = "LanguageConfig_ExitInvestigation_CN|退出调查"
  },
  Choose = {
    ID = "Choose",
    CN = "LanguageConfig_Choose_CN|选择"
  },
  ExtraGift = {
    ID = "ExtraGift",
    CN = "LanguageConfig_ExtraGift_CN|额外赠送"
  },
  RepetitiveAwakerConvert = {
    ID = "RepetitiveAwakerConvert",
    CN = "LanguageConfig_RepetitiveAwakerConvert_CN|重复唤醒体，已转化"
  },
  Word_He = {
    ID = "Word_He",
    CN = "LanguageConfig_Word_He_CN|他"
  },
  Word_She = {
    ID = "Word_She",
    CN = "LanguageConfig_Word_She_CN|她"
  },
  Word_GeGe = {
    ID = "Word_GeGe",
    CN = "LanguageConfig_Word_GeGe_CN|哥哥"
  },
  Word_JieJie = {
    ID = "Word_JieJie",
    CN = "LanguageConfig_Word_JieJie_CN|姐姐"
  },
  Word_DiDi = {
    ID = "Word_DiDi",
    CN = "LanguageConfig_Word_DiDi_CN|弟弟"
  },
  Word_MeiMei = {
    ID = "Word_MeiMei",
    CN = "LanguageConfig_Word_MeiMei_CN|妹妹"
  },
  Word_Sir = {
    ID = "Word_Sir",
    CN = "LanguageConfig_Word_Sir_CN|先生"
  },
  Word_Madam = {
    ID = "Word_Madam",
    CN = "LanguageConfig_Word_Madam_CN|小姐"
  },
  Word_Lord = {
    ID = "Word_Lord",
    CN = "LanguageConfig_Word_Lord_CN|少爷"
  },
  Word_LordLady = {
    ID = "Word_LordLady",
    CN = "LanguageConfig_Word_LordLady_CN|小姐"
  },
  LevelDetailRelicEnchantGroupNone = {
    ID = "LevelDetailRelicEnchantGroupNone",
    CN = "LanguageConfig_LevelDetailRelicEnchantGroupNone_CN|暂无造物及刻印"
  },
  LevelDetailRelicGroup = {
    ID = "LevelDetailRelicGroup",
    CN = "LanguageConfig_LevelDetailRelicGroup_CN|造物"
  },
  LevelDetailEnchantGroup = {
    ID = "LevelDetailEnchantGroup",
    CN = "LanguageConfig_LevelDetailEnchantGroup_CN|刻印"
  },
  LevelDetailBattle_Elite_Tips = {
    ID = "LevelDetailBattle_Elite_Tips",
    CN = "LanguageConfig_LevelDetailBattle_Elite_Tips_CN|精英"
  },
  LevelDetailBattle_Boss_Tips = {
    ID = "LevelDetailBattle_Boss_Tips",
    CN = "LanguageConfig_LevelDetailBattle_Boss_Tips_CN|首领"
  },
  TimeFormatYMDHm = {
    ID = "TimeFormatYMDHm",
    CN = "LanguageConfig_TimeFormatYMDHm_CN|{s1}年{s2}月{s3}日{s4}时{s5}分"
  },
  ActivityRewardReceived = {
    ID = "ActivityRewardReceived",
    CN = "LanguageConfig_ActivityRewardReceived_CN|<Claimed:已领取>"
  },
  ActivityRewardNotReceived = {
    ID = "ActivityRewardNotReceived",
    CN = "LanguageConfig_ActivityRewardNotReceived_CN|<Receive:可领取>"
  },
  ActivityDescriptionTitle = {
    ID = "ActivityDescriptionTitle",
    CN = "LanguageConfig_ActivityDescriptionTitle_CN|活动说明"
  },
  ActivityRewardday = {
    ID = "ActivityRewardday",
    CN = "LanguageConfig_ActivityRewardday_CN|<DayTime:第{s1}天>"
  },
  ActivityTimePermanent = {
    ID = "ActivityTimePermanent",
    CN = "LanguageConfig_ActivityTimePermanent_CN|永久"
  },
  ActivityTimeExpired = {
    ID = "ActivityTimeExpired",
    CN = "LanguageConfig_ActivityTimeExpired_CN|已过期"
  },
  ActivityTimeCountdown = {
    ID = "ActivityTimeCountdown",
    CN = "LanguageConfig_ActivityTimeCountdown_CN|{s1}天{s2}小时后结束"
  },
  ActivityTimeCountdown_2 = {
    ID = "ActivityTimeCountdown_2",
    CN = "LanguageConfig_ActivityTimeCountdown_2_CN|{s1}小时{s2}分钟后结束"
  },
  PreOrderTobeClaimed = {
    ID = "PreOrderTobeClaimed",
    CN = "LanguageConfig_PreOrderTobeClaimed_CN|待领取"
  },
  NewPreOrderPurchaseTobeClaimed = {
    ID = "NewPreOrderPurchaseTobeClaimed",
    CN = "LanguageConfig_NewPreOrderPurchaseTobeClaimed_CN|{s1}后消失，购买后可立即领取"
  },
  PreOrderNotPurchasedTobeClaimed = {
    ID = "PreOrderNotPurchasedTobeClaimed",
    CN = "LanguageConfig_PreOrderNotPurchasedTobeClaimed_CN|购买后可立即领取"
  },
  PreOrderNotPurchasedNeedWait = {
    ID = "PreOrderNotPurchasedNeedWait",
    CN = "LanguageConfig_PreOrderNotPurchasedNeedWait_CN|购买{s1}后可领取"
  },
  PreOrderNeedWaitTobeClaimed = {
    ID = "PreOrderNeedWaitTobeClaimed",
    CN = "LanguageConfig_PreOrderNeedWaitTobeClaimed_CN|{s1}后可领取"
  },
  PreOrderBeforePurchaseTips = {
    ID = "PreOrderBeforePurchaseTips",
    CN = "LanguageConfig_PreOrderBeforePurchaseTips_CN|购买后可按时领取所有奖励"
  },
  PreOrderPurchaseCountdownTips = {
    ID = "PreOrderPurchaseCountdownTips",
    CN = "LanguageConfig_PreOrderPurchaseCountdownTips_CN|{s1}后无法购买"
  },
  NewPreOrderPurchaseCountdownTips = {
    ID = "NewPreOrderPurchaseCountdownTips",
    CN = "LanguageConfig_NewPreOrderPurchaseCountdownTips_CN|{s1}内购买可领取限时专属奖励"
  },
  PreOrderPurchasedTips = {
    ID = "PreOrderPurchasedTips",
    CN = "LanguageConfig_PreOrderPurchasedTips_CN|已完成购买\n可按时领取所有奖励"
  },
  TrialActivityRewardTips = {
    ID = "TrialActivityRewardTips",
    CN = "LanguageConfig_TrialActivityRewardTips_CN|完成该唤醒体试玩后可领取"
  },
  DoubleOutputActivityTimes = {
    ID = "DoubleOutputActivityTimes",
    CN = "LanguageConfig_DoubleOutputActivityTimes_CN|今日额外奖励+50%"
  },
  DoubleOutputActivityTimesRunOut = {
    ID = "DoubleOutputActivityTimesRunOut",
    CN = "LanguageConfig_DoubleOutputActivityTimesRunOut_CN|今日双倍奖励次数已耗尽"
  },
  ActivityStartTrial = {
    ID = "ActivityStartTrial",
    CN = "LanguageConfig_ActivityStartTrial_CN|开启试玩"
  },
  CommonReceive = {
    ID = "CommonReceive",
    CN = "LanguageConfig_CommonReceive_CN|领取"
  },
  DoubleOutputActivityStageTips = {
    ID = "DoubleOutputActivityStageTips",
    CN = "LanguageConfig_DoubleOutputActivityStageTips_CN|今日剩余双倍奖励次数：<DoubleOutputActivityTimes:{s1}/{s2}>"
  },
  SubplotJumpButton = {
    ID = "SubplotJumpButton",
    CN = "LanguageConfig_SubplotJumpButton_CN|调查"
  },
  DailyChallengeInstructions = {
    ID = "DailyChallengeInstructions",
    CN = "LanguageConfig_DailyChallengeInstructions_CN|<Title:【幻梦深潜】>\n·初始造物、关卡造物会在每周一9点(GMT+8)时发生变化。\n·每次挑战都会随机进入一个挑战场景。\n<Title:【深潜经验】>\n·若「守密人等级」与关卡的推荐等级相近，则挑战胜利即可完成深潜成就，获得「深潜经验」。\n   ·「挑战征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 40 级 时，可获得基础深潜经验。\n   ·「超越征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 20 级 时，可再额外获得一份基础深潜经验。\n<Title:【深潜等级】>\n·当深潜经验达到一定值时，深潜等级提升。每升一级都可以获得丰富的奖励。\n<Title:【赛季更新】>\n·一般情况下，赛季每 28 天重置。\n·调查结束会获得调查评分，每赛季会记录本赛季最高的调查评分用作当赛季排行，可重复调查以提高评分。当与其他守密人的调查评分相同时，将会视为同一名次。\n·赛季结束时会结算本赛季排名，并通过邮件发送本赛季排名奖励。守密人可以通过点击「排行榜」-「排行奖励」中查看排行奖励。\n·每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在赛季结束时重置。\n<Title:【每赛季强化唤醒体】>\n·每赛季的每个界域会有两名随机唤醒体在本赛季的幻梦深潜行动中变得躁狂，因此其体质、攻击力、防御力提高50%。\n<Title:【调查评分】>\n·调查结束会用当前关卡的难度基础分跟完成的评分项进行结算，挑战越高难度时难度基础分越高。\n·下面是具体评分项。\n1、「时序沙漏」：初始回合为 50，每剩余 1 回合额外获得 20 分。\n2、「深渊呼唤」：使用 1/2 名强化唤醒体时出战时，获得 250 / 500 分。\n3、「幻境援救」：每使用 1 次应急灵知体，调查评分降低 20% ，多次触发多次乘算。\n4、「拓梦先驱」：每日首次游玩 获得 500 分。"
  },
  DailyChallengeInstructionsV2 = {
    ID = "DailyChallengeInstructionsV2",
    CN = "LanguageConfig_DailyChallengeInstructionsV2_CN|<Title:【幻梦深潜】>\n·初始造物、关卡造物会在每周一9点(GMT+8)时发生变化。\n·每次挑战都会随机进入一个挑战场景。\n<Title:【深潜经验】>\n·若「守密人等级」与关卡的推荐等级相近，则挑战胜利即可完成深潜成就，获得「深潜经验」。\n   ·「挑战征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 40 级 时，可获得基础深潜经验。\n   ·「超越征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 20 级 时，可再额外获得一份基础深潜经验。\n<Title:【深潜等级】>\n·当深潜经验达到一定值时，深潜等级提升。每升一级都可以获得丰富的奖励。\n<Title:【赛季更新】>\n·一般情况下，赛季每 28 天重置。\n·调查结束会获得调查评分，每赛季会记录本赛季最高的调查评分用作当赛季排行，可重复调查以提高评分。当与其他守密人的调查评分相同时，将会视为同一名次。\n·赛季结束时会结算本赛季排名，并通过邮件发送本赛季排名奖励。守密人可以通过点击「排行榜」-「排行奖励」中查看排行奖励。\n·每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在赛季结束时重置。\n<Title:【每赛季强化唤醒体】>\n·每赛季的每个界域会有两名随机唤醒体在本赛季的幻梦深潜行动中变得躁狂，因此其体质、攻击力、防御力提高50%。\n<Title:【调查评分】>\n·调查结束会用当前关卡的难度基础分跟完成的评分项进行结算，挑战越高难度时难度基础分越高。\n·下面是具体评分项。\n1、「时序沙漏」：初始回合为 50，每剩余 1 回合额外获得 20 分。\n2、「深渊呼唤」：使用 1 / 2 / 3 / 4 名强化唤醒体时出战时，获得 250 / 500 /750 / 1000 分。\n3、「幻境援救」：每使用 1 次应急灵知体，调查评分降低 20% ，多次触发多次乘算。\n4、「拓梦先驱」：每日首次游玩 获得 500 分。"
  },
  DailyChallengeInstructionsExample = {
    ID = "DailyChallengeInstructionsExample",
    CN = "LanguageConfig_DailyChallengeInstructionsExample_CN|（{s1}）「{s2}」：{s3}"
  },
  DailyChallengeCountdown_Hour = {
    ID = "DailyChallengeCountdown_Hour",
    CN = "LanguageConfig_DailyChallengeCountdown_Hour_CN|每周试炼奖励重置： {s1}天{s2}小时"
  },
  DailyChallengeCountdown_Minute = {
    ID = "DailyChallengeCountdown_Minute",
    CN = "LanguageConfig_DailyChallengeCountdown_Minute_CN|每周试炼奖励重置： {s1}时{s2}分"
  },
  DailyChallengeRewardCount = {
    ID = "DailyChallengeRewardCount",
    CN = "LanguageConfig_DailyChallengeRewardCount_CN|累计奖励{s1}/{s2}"
  },
  DailyChallengeMagnificationDescribe = {
    ID = "DailyChallengeMagnificationDescribe",
    CN = "LanguageConfig_DailyChallengeMagnificationDescribe_CN|当前调查评分倍率×{s1}，最终评分以调查完成为准"
  },
  DailyChallenge = {
    ID = "DailyChallenge",
    CN = "LanguageConfig_DailyChallenge_CN|融珠兑换"
  },
  DailyChallengeScoreBase = {
    ID = "DailyChallengeScoreBase",
    CN = "LanguageConfig_DailyChallengeScoreBase_CN|难度基础分： <OptionHighlight_Dadly: {s1}>"
  },
  DailyChallengeScoreMultiple = {
    ID = "DailyChallengeScoreMultiple",
    CN = "LanguageConfig_DailyChallengeScoreMultiple_CN|评分倍率 <OptionHighlight_Dadly:× {s1}>"
  },
  LevelUnlockDesc = {
    ID = "LevelUnlockDesc",
    CN = "LanguageConfig_LevelUnlockDesc_CN|通关{s1}后解锁"
  },
  Today = {
    ID = "Today",
    CN = "LanguageConfig_Today_CN|本周"
  },
  ThisWeek = {
    ID = "ThisWeek",
    CN = "LanguageConfig_ThisWeek_CN|本周"
  },
  RulesOfPlay = {
    ID = "RulesOfPlay",
    CN = "LanguageConfig_RulesOfPlay_CN|幻梦深潜"
  },
  ScoreReachTo = {
    ID = "ScoreReachTo",
    CN = "LanguageConfig_ScoreReachTo_CN|分数累计至"
  },
  ScoreSumDesc = {
    ID = "ScoreSumDesc",
    CN = "LanguageConfig_ScoreSumDesc_CN|（总评分为以下总和）"
  },
  ScoreMultipleDesc = {
    ID = "ScoreMultipleDesc",
    CN = "LanguageConfig_ScoreMultipleDesc_CN|（总评分为以下总和×{s1}）"
  },
  DailyChallengeCountdown_Week = {
    ID = "DailyChallengeCountdown_Week",
    CN = "LanguageConfig_DailyChallengeCountdown_Week_CN|本周排行奖励重置： {s1}"
  },
  CommonItemDoubleOutputActivity = {
    ID = "CommonItemDoubleOutputActivity",
    CN = "LanguageConfig_CommonItemDoubleOutputActivity_CN|福利"
  },
  AutoBattleOpen = {
    ID = "AutoBattleOpen",
    CN = "LanguageConfig_AutoBattleOpen_CN|已开启"
  },
  AutoBattleClose = {
    ID = "AutoBattleClose",
    CN = "LanguageConfig_AutoBattleClose_CN|未开启"
  },
  AutoBattleTxt = {
    ID = "AutoBattleTxt",
    CN = "LanguageConfig_AutoBattleTxt_CN|自动战斗"
  },
  PlayerLevelTaskLabel = {
    ID = "PlayerLevelTaskLabel",
    CN = "LanguageConfig_PlayerLevelTaskLabel_CN|成长记录"
  },
  SchoolTaskLabel = {
    ID = "SchoolTaskLabel",
    CN = "LanguageConfig_SchoolTaskLabel_CN|界域精通"
  },
  QuestionnaireEmailSender = {
    ID = "QuestionnaireEmailSender",
    CN = "LanguageConfig_QuestionnaireEmailSender_CN|弥萨格大学校务处"
  },
  MaxHp = {
    ID = "MaxHp",
    CN = "LanguageConfig_MaxHp_CN|最大生命"
  },
  CommonTipsOwnedText = {
    ID = "CommonTipsOwnedText",
    CN = "LanguageConfig_CommonTipsOwnedText_CN|当前拥有：{s1}"
  },
  GetAchievementPopTipsText = {
    ID = "GetAchievementPopTipsText",
    CN = "LanguageConfig_GetAchievementPopTipsText_CN|{s1}"
  },
  WeeklyBossInstructions = {
    ID = "WeeklyBossInstructions",
    CN = "LanguageConfig_WeeklyBossInstructions_CN|\n<Title:奖励次数>\n·每周一9点(GMT+8)奖励次数重置，通关任意「超验存在」的关卡后将消耗1次奖励次数获得任务报酬奖励。\n·未使用的奖励次数将不会继承到下一周。\n\n<Title:重现>\n·首次完成「超验存在」关卡挑战后将解锁重现，重现将消耗1次奖励次数并直接获得任务报酬奖励。\n·若三星通关高难度关卡，则较低难度的关卡挑战进度会自动标记为三星通关。"
  },
  WeeklyBossTitle = {
    ID = "WeeklyBossTitle",
    CN = "LanguageConfig_WeeklyBossTitle_CN|规则说明"
  },
  WeeklyBoss_LvLimit = {
    ID = "WeeklyBoss_LvLimit",
    CN = "LanguageConfig_WeeklyBoss_LvLimit_CN|调查等级达到{s1}解锁"
  },
  VoiceActorTips = {
    ID = "VoiceActorTips",
    CN = "LanguageConfig_VoiceActorTips_CN|VA：{s1}"
  },
  CostTips = {
    ID = "CostTips",
    CN = "LanguageConfig_CostTips_CN|算力 +{s1}"
  },
  TentaclesTips = {
    ID = "TentaclesTips",
    CN = "LanguageConfig_TentaclesTips_CN|触腕伤害 +{s1}"
  },
  MonsterHideIntention = {
    ID = "MonsterHideIntention",
    CN = "LanguageConfig_MonsterHideIntention_CN|未知"
  },
  MainCopyOutPanelTrinketMaxTips = {
    ID = "MainCopyOutPanelTrinketMaxTips",
    CN = "LanguageConfig_MainCopyOutPanelTrinketMaxTips_CN|密契背包已满，新获得的密契已通过邮件下发"
  },
  StageRelicEmpty = {
    ID = "StageRelicEmpty",
    CN = "LanguageConfig_StageRelicEmpty_CN|当前关卡无初始造物"
  },
  ChargeItemNoChargeTest = {
    ID = "ChargeItemNoChargeTest",
    CN = "LanguageConfig_ChargeItemNoChargeTest_CN|本次测试不开放充值功能"
  },
  RankingPercentDesc = {
    ID = "RankingPercentDesc",
    CN = "LanguageConfig_RankingPercentDesc_CN|{s1}"
  },
  SkillActivated = {
    ID = "SkillActivated",
    CN = "LanguageConfig_SkillActivated_CN|已激发"
  },
  SkillNotActivated = {
    ID = "SkillNotActivated",
    CN = "LanguageConfig_SkillNotActivated_CN|未激发"
  },
  NameChangeTips = {
    ID = "NameChangeTips",
    CN = "LanguageConfig_NameChangeTips_CN|修改后，{s1}小时内不可再次修改"
  },
  WeekChallengeInstructions = {
    ID = "WeekChallengeInstructions",
    CN = "LanguageConfig_WeekChallengeInstructions_CN|<Title:【无光之境】>\n·「无光之境」是一系列高难度调查关卡。守密人战胜最终首领完成调查后，可领取丰厚的调查奖励。守密人于「无光之境」的挑战不会消耗「灵啡肽」。\n\n<Title:【挑战规则】>\n·守密人战胜密境最终首领完成调查后，可以获取相应星级的调查评价。随着调查评分星级的提升，可以获得不同的奖励。\n·在不同的「无光之境」关卡中，守密人会获得独特的初始造物支持，仅在当前「无光之境」关卡内生效。\n·在同一「无光之境」关卡中，守密人成功通关某一密境关卡后，将记录当前编队所使用的唤醒体。相同的唤醒体无法在其他密境关卡中上场。\n·守密人可对已经通关的密境关卡进行进度重置，重置后该密境下通关使用的角色以及星级记录将会被清除，守密人可重新进行编队调整并继续挑战。"
  },
  WeekChallengeRulesOfPlay = {
    ID = "WeekChallengeRulesOfPlay",
    CN = "LanguageConfig_WeekChallengeRulesOfPlay_CN|无光之境"
  },
  MainCopyTitle = {
    ID = "MainCopyTitle",
    CN = "LanguageConfig_MainCopyTitle_CN|调查行动"
  },
  LargeSubplotTitle = {
    ID = "LargeSubplotTitle",
    CN = "LanguageConfig_LargeSubplotTitle_CN|特遣纪录"
  },
  SmallSubplotTitle = {
    ID = "SmallSubplotTitle",
    CN = "LanguageConfig_SmallSubplotTitle_CN|意识潜游"
  },
  SpecialSubplotTitle = {
    ID = "SpecialSubplotTitle",
    CN = "LanguageConfig_SpecialSubplotTitle_CN|异梦视界"
  },
  LinkageActivityTitle = {
    ID = "LinkageActivityTitle",
    CN = "LanguageConfig_LinkageActivityTitle_CN|多维连接"
  },
  VindicateTitle = {
    ID = "VindicateTitle",
    CN = "LanguageConfig_VindicateTitle_CN|繁衍狂热"
  },
  StoryGuideTitle = {
    ID = "StoryGuideTitle",
    CN = "LanguageConfig_StoryGuideTitle_CN|剧情导览"
  },
  StorylineGuide_0 = {
    ID = "StorylineGuide_0",
    CN = "LanguageConfig_StorylineGuide_0_CN|向死而生。"
  },
  StorylineGuide_1 = {
    ID = "StorylineGuide_1",
    CN = "LanguageConfig_StorylineGuide_1_CN|踏入伦蒂尼恩危险的夜雾吧，守密人。属于你的道路，于此开始。"
  },
  StorylineGuide_2 = {
    ID = "StorylineGuide_2",
    CN = "LanguageConfig_StorylineGuide_2_CN|艺术家，疯子，苦行者，痴愚之人……这座城市是属于你的展馆，蜡像们站在故事开场的地方，渴盼着你的光临。"
  },
  StorylineGuide_3 = {
    ID = "StorylineGuide_3",
    CN = "LanguageConfig_StorylineGuide_3_CN|拉伊的风雪厌弃杀戮，她等待着你，只为一场交易。她将带给你，你无比渴求的秘密。她的价格永远残忍，永远合理。"
  },
  StorylineGuide_4 = {
    ID = "StorylineGuide_4",
    CN = "LanguageConfig_StorylineGuide_4_CN|回忆吧，为回忆而战，为回忆而死。回忆是我们的福音书，我们的墓志铭。除了回忆，我们一无所有。"
  },
  StorylineGuide_5 = {
    ID = "StorylineGuide_5",
    CN = "LanguageConfig_StorylineGuide_5_CN|在群星坠落以前，我们面向海洋祈祷：愿平静的涛声护我们入梦，愿我们重回故土的怀抱，长梦不醒。"
  },
  StorylineGuide_6 = {
    ID = "StorylineGuide_6",
    CN = "LanguageConfig_StorylineGuide_6_CN|吟咏吧——那古老的王，已重新看见祂的王座。神圣的谕令，将为每一位虔诚的子民，带来神的国度。"
  },
  StorylineGuide_7 = {
    ID = "StorylineGuide_7",
    CN = "LanguageConfig_StorylineGuide_7_CN|聆听，祈祷，呼唤，繁衍，服从最高贵的理想与最卑微的欲望。以母亲的名义，祂得以于混沌与恐惧中长存。"
  },
  StorylineGuide_8 = {
    ID = "StorylineGuide_8",
    CN = "LanguageConfig_StorylineGuide_8_CN|长明的灯已燃起，那幽暗的光，将为你照亮通往终途的路。"
  },
  StorylineGuide_9 = {
    ID = "StorylineGuide_9",
    CN = "LanguageConfig_StorylineGuide_9_CN|告诉祂，你的回答。"
  },
  StorylineGuide_10 = {
    ID = "StorylineGuide_10",
    CN = "LanguageConfig_StorylineGuide_10_CN|当然，混乱是一切的结局。可总有人不愿放弃挣扎，不是吗？"
  },
  StorylineGuide_11 = {
    ID = "StorylineGuide_11",
    CN = "LanguageConfig_StorylineGuide_11_CN|不可直视头顶的寰宇。不可直视内心的深渊。"
  },
  StorylineGuide_12 = {
    ID = "StorylineGuide_12",
    CN = "LanguageConfig_StorylineGuide_12_CN|进食，是这个世界唯一的美德。"
  },
  StorylineGuide_13 = {
    ID = "StorylineGuide_13",
    CN = "LanguageConfig_StorylineGuide_13_CN|无垠的幻梦里没有答案。这场梦境，到了该醒来的时候了。"
  },
  StorylineGuide_14 = {
    ID = "StorylineGuide_14",
    CN = "LanguageConfig_StorylineGuide_14_CN|命运的舞台之上，我们将扮演的角色，从来无从选择。"
  },
  StorylineGuide_15 = {
    ID = "StorylineGuide_15",
    CN = "LanguageConfig_StorylineGuide_15_CN|旅人啊，请悄声步入雪夜。于无愿的尖峰，见证大梦的终结。"
  },
  StorylineGuide_16 = {
    ID = "StorylineGuide_16",
    CN = "LanguageConfig_StorylineGuide_16_CN|临时文本"
  },
  StorylineGuide_17 = {
    ID = "StorylineGuide_17",
    CN = "LanguageConfig_StorylineGuide_17_CN|临时文本"
  },
  StorylineGuide_18 = {
    ID = "StorylineGuide_18",
    CN = "LanguageConfig_StorylineGuide_18_CN|临时文本"
  },
  StorylineGuide_19 = {
    ID = "StorylineGuide_19",
    CN = "LanguageConfig_StorylineGuide_19_CN|临时文本"
  },
  StorylineGuide_20 = {
    ID = "StorylineGuide_20",
    CN = "LanguageConfig_StorylineGuide_20_CN|临时文本"
  },
  ShareLineText = {
    ID = "ShareLineText",
    CN = "LanguageConfig_ShareLineText_CN|我在《忘却前夜》抽到了{s1}，快来看看吧！"
  },
  ShareFacebookText = {
    ID = "ShareFacebookText",
    CN = "LanguageConfig_ShareFacebookText_CN|我在《忘却前夜》抽到了{s1}，快来看看吧！"
  },
  ShareTwitterText = {
    ID = "ShareTwitterText",
    CN = "LanguageConfig_ShareTwitterText_CN|我在《忘却前夜》抽到了{s1}，快来看看吧！"
  },
  RuleTipsTitle = {
    ID = "RuleTipsTitle",
    CN = "LanguageConfig_RuleTipsTitle_CN|规则说明"
  },
  AlchemyDecomposeWeaponLockTip = {
    ID = "AlchemyDecomposeWeaponLockTip",
    CN = "LanguageConfig_AlchemyDecomposeWeaponLockTip_CN|当前命轮已锁定"
  },
  AlchemyDecomposeTrinketLockTip = {
    ID = "AlchemyDecomposeTrinketLockTip",
    CN = "LanguageConfig_AlchemyDecomposeTrinketLockTip_CN|当前密契已锁定"
  },
  AlchemyDecomposeCostItemNotEnoughTip = {
    ID = "AlchemyDecomposeCostItemNotEnoughTip",
    CN = "LanguageConfig_AlchemyDecomposeCostItemNotEnoughTip_CN|分解所需物资不足，无法分解"
  },
  AlchemyDecomposeSelectLimitTips = {
    ID = "AlchemyDecomposeSelectLimitTips",
    CN = "LanguageConfig_AlchemyDecomposeSelectLimitTips_CN|所选分解道具已达到上限"
  },
  CommunityJumpTipsTitle = {
    ID = "CommunityJumpTipsTitle",
    CN = "LanguageConfig_CommunityJumpTipsTitle_CN|加入社区"
  },
  CommunityJumpTips = {
    ID = "CommunityJumpTips",
    CN = "LanguageConfig_CommunityJumpTips_CN|欢迎守密人加入社区"
  },
  CommunityJump_1 = {
    ID = "CommunityJump_1",
    CN = "LanguageConfig_CommunityJump_1_CN|FaceBook"
  },
  CommunityJump_2 = {
    ID = "CommunityJump_2",
    CN = "LanguageConfig_CommunityJump_2_CN|Discord"
  },
  Exchange_Start = {
    ID = "Exchange_Start",
    CN = "LanguageConfig_Exchange_Start_CN|置换"
  },
  ExchangeTips = {
    ID = "ExchangeTips",
    CN = "LanguageConfig_ExchangeTips_CN|是否确认消耗以下材料，置换获得 <Blue:{s2}> 个<Blue:{s3}>？"
  },
  ExchangeConfirm = {
    ID = "ExchangeConfirm",
    CN = "LanguageConfig_ExchangeConfirm_CN|确认置换"
  },
  ExchangeCostItemEnoughTips = {
    ID = "ExchangeCostItemEnoughTips",
    CN = "LanguageConfig_ExchangeCostItemEnoughTips_CN|置换产物"
  },
  ExchangeCostItemNotEnoughTips = {
    ID = "ExchangeCostItemNotEnoughTips",
    CN = "LanguageConfig_ExchangeCostItemNotEnoughTips_CN|材料不足"
  },
  ExchangeCostInfoPreviewTips = {
    ID = "ExchangeCostInfoPreviewTips",
    CN = "LanguageConfig_ExchangeCostInfoPreviewTips_CN|将通过置换，获得 <Blue:{s1}> 个<Blue:{s2}>"
  },
  ExchangeCostSelectPanelTitle = {
    ID = "ExchangeCostSelectPanelTitle",
    CN = "LanguageConfig_ExchangeCostSelectPanelTitle_CN|选择材料"
  },
  ExchangeCostSelectPanelTips = {
    ID = "ExchangeCostSelectPanelTips",
    CN = "LanguageConfig_ExchangeCostSelectPanelTips_CN|消耗已选材料可置换 <Blue:{s1}> 个新材料"
  },
  ExchangeCostSelectLimitTips = {
    ID = "ExchangeCostSelectLimitTips",
    CN = "LanguageConfig_ExchangeCostSelectLimitTips_CN|最多只能选择 6 种类型材料，无法选择更多类型"
  },
  Monster_Awaker_O04_Tips_1 = {
    ID = "Monster_Awaker_O04_Tips_1",
    CN = "LanguageConfig_Monster_Awaker_O04_Tips_1_CN|凯刻斯正在以惊人的速度愈合伤口，攻击以干扰他的回复！"
  },
  ExchangeCostItemNumNotEnoughTips = {
    ID = "ExchangeCostItemNumNotEnoughTips",
    CN = "LanguageConfig_ExchangeCostItemNumNotEnoughTips_CN|当前所选材料不足{s1}个，无法置换"
  },
  ExchangeCostItemNumReachLimitTips = {
    ID = "ExchangeCostItemNumReachLimitTips",
    CN = "LanguageConfig_ExchangeCostItemNumReachLimitTips_CN|当前选中的消耗道具数量已达到上限"
  },
  WeaponLevelMaxSelectTips = {
    ID = "WeaponLevelMaxSelectTips",
    CN = "LanguageConfig_WeaponLevelMaxSelectTips_CN|{s1}已达到叠位等级上限，请更换选择的物品"
  },
  AwakerLevelMaxSelectTips = {
    ID = "AwakerLevelMaxSelectTips",
    CN = "LanguageConfig_AwakerLevelMaxSelectTips_CN|{s1}已达到启灵等级上限，请更换选择的物品"
  },
  AffixConnect = {
    ID = "AffixConnect",
    CN = "LanguageConfig_AffixConnect_CN|的"
  },
  Monster_C0502 = {
    ID = "Monster_C0502",
    CN = "LanguageConfig_Monster_C0502_CN|「我…看到你了……」"
  },
  Monster_C0502_1 = {
    ID = "Monster_C0502_1",
    CN = "LanguageConfig_Monster_C0502_1_CN|「再临，诞生，再临，诞生……」"
  },
  Monster_C0502_2 = {
    ID = "Monster_C0502_2",
    CN = "LanguageConfig_Monster_C0502_2_CN|敌人将「海中之物」寄生在了你的身体内！打出卡牌会受到伤害并使其变弱！"
  },
  Trinket_Suggest_Btn = {
    ID = "Trinket_Suggest_Btn",
    CN = "LanguageConfig_Trinket_Suggest_Btn_CN|推荐"
  },
  Weapon_Suggest_Btn = {
    ID = "Weapon_Suggest_Btn",
    CN = "LanguageConfig_Weapon_Suggest_Btn_CN|推荐"
  },
  DailyChallengeLiquidation = {
    ID = "DailyChallengeLiquidation",
    CN = "LanguageConfig_DailyChallengeLiquidation_CN|排行榜结算中…"
  },
  DailyChallengeEmptyTips = {
    ID = "DailyChallengeEmptyTips",
    CN = "LanguageConfig_DailyChallengeEmptyTips_CN|暂无记录"
  },
  Monster_C0503BOSS_Tips_1 = {
    ID = "Monster_C0503BOSS_Tips_1",
    CN = "LanguageConfig_Monster_C0503BOSS_Tips_1_CN|剩余手牌越多敌人的攻击就越弱，保留更多手牌来减弱攻势！"
  },
  Monster_C0503BOSS_Tips_2 = {
    ID = "Monster_C0503BOSS_Tips_2",
    CN = "LanguageConfig_Monster_C0503BOSS_Tips_2_CN|剩余手牌越多敌人就会获得更多屏障，尽可能打出手牌！"
  },
  Monster_C0503BOSS_Tips_3 = {
    ID = "Monster_C0503BOSS_Tips_3",
    CN = "LanguageConfig_Monster_C0503BOSS_Tips_3_CN|当心！敌人的重击会弃掉你所有的手牌！"
  },
  Monster_C0603BOSS_Tips_1 = {
    ID = "Monster_C0603BOSS_Tips_1",
    CN = "LanguageConfig_Monster_C0603BOSS_Tips_1_CN|敌人每失去一定生命，就会有「灵觉之子」自其腹中诞生！"
  },
  Monster_B0005 = {
    ID = "Monster_B0005",
    CN = "LanguageConfig_Monster_B0005_CN|「渎神者…我将以代行者之名，降下神罚！」"
  },
  Monster_B0005_1 = {
    ID = "Monster_B0005_1",
    CN = "LanguageConfig_Monster_B0005_1_CN|「可恶的…不敬之人…」"
  },
  Monster_B0005_Tips_1 = {
    ID = "Monster_B0005_Tips_1",
    CN = "LanguageConfig_Monster_B0005_Tips_1_CN|曾名为「弥利亚姆」的异怪，正在祈祷神之注视……"
  },
  Monster_B0005_2 = {
    ID = "Monster_B0005_2",
    CN = "LanguageConfig_Monster_B0005_2_CN|「沉睡之主，听吾呼唤…」"
  },
  Monster_B0005_3 = {
    ID = "Monster_B0005_3",
    CN = "LanguageConfig_Monster_B0005_3_CN|「永恒@1，候@1入梦…」"
  },
  Monster_B0005_4 = {
    ID = "Monster_B0005_4",
    CN = "LanguageConfig_Monster_B0005_4_CN|「混沌将散，群星…归位」"
  },
  Monster_B0005_5 = {
    ID = "Monster_B0005_5",
    CN = "LanguageConfig_Monster_B0005_5_CN|「主啊，容我僭越，对不敬者予以仲裁……！」"
  },
  Monster_B0005_6 = {
    ID = "Monster_B0005_6",
    CN = "LanguageConfig_Monster_B0005_6_CN|「不…不！为何阻拦……！」"
  },
  Monster_B0005_7 = {
    ID = "Monster_B0005_7",
    CN = "LanguageConfig_Monster_B0005_7_CN|「亵渎之徒…降以极刑！」"
  },
  CoursePopMultiTipText = {
    ID = "CoursePopMultiTipText",
    CN = "LanguageConfig_CoursePopMultiTipText_CN|多个教学…"
  },
  DailyResetTips = {
    ID = "DailyResetTips",
    CN = "LanguageConfig_DailyResetTips_CN|每日刷新，回到主界面"
  },
  SocializeOnLineTime_Day = {
    ID = "SocializeOnLineTime_Day",
    CN = "LanguageConfig_SocializeOnLineTime_Day_CN|{s1} 天前在线"
  },
  SocializeOnLineTime_Hour = {
    ID = "SocializeOnLineTime_Hour",
    CN = "LanguageConfig_SocializeOnLineTime_Hour_CN|{s1} 小时前在线"
  },
  SocializeOnLineTime_Minute = {
    ID = "SocializeOnLineTime_Minute",
    CN = "LanguageConfig_SocializeOnLineTime_Minute_CN|{s1} 分钟前在线"
  },
  SocializeOnLineTime_Month = {
    ID = "SocializeOnLineTime_Month",
    CN = "LanguageConfig_SocializeOnLineTime_Month_CN|{s1} 个月前在线"
  },
  SocializeOnLineTime_Year = {
    ID = "SocializeOnLineTime_Year",
    CN = "LanguageConfig_SocializeOnLineTime_Year_CN|{s1} 年前在线"
  },
  SocializeOnLineTime_YearMonth = {
    ID = "SocializeOnLineTime_YearMonth",
    CN = "LanguageConfig_SocializeOnLineTime_YearMonth_CN|上次登录：{s1}年{s2}月"
  },
  SocializeOnLineState_Shop = {
    ID = "SocializeOnLineState_Shop",
    CN = "LanguageConfig_SocializeOnLineState_Shop_CN|正在弥萨格商店..."
  },
  SocializeOnLineState_Summon = {
    ID = "SocializeOnLineState_Summon",
    CN = "LanguageConfig_SocializeOnLineState_Summon_CN|正在尝试唤醒..."
  },
  SocializeOnLineState_Activity = {
    ID = "SocializeOnLineState_Activity",
    CN = "LanguageConfig_SocializeOnLineState_Activity_CN|正在参与活动..."
  },
  SocializeOnLineState_MainCopy = {
    ID = "SocializeOnLineState_MainCopy",
    CN = "LanguageConfig_SocializeOnLineState_MainCopy_CN|正在准备调查..."
  },
  SocializeOnLineState_Awaker = {
    ID = "SocializeOnLineState_Awaker",
    CN = "LanguageConfig_SocializeOnLineState_Awaker_CN|正在观察唤醒体..."
  },
  SocializeOnLineState_Challenge = {
    ID = "SocializeOnLineState_Challenge",
    CN = "LanguageConfig_SocializeOnLineState_Challenge_CN|正在准备幕间演习..."
  },
  SocializeOnLineState_Manual = {
    ID = "SocializeOnLineState_Manual",
    CN = "LanguageConfig_SocializeOnLineState_Manual_CN|正在查看学籍档案..."
  },
  SocializeOnLineState_Battlepass = {
    ID = "SocializeOnLineState_Battlepass",
    CN = "LanguageConfig_SocializeOnLineState_Battlepass_CN|正在研究课题..."
  },
  SocializeOnLineState_Bag = {
    ID = "SocializeOnLineState_Bag",
    CN = "LanguageConfig_SocializeOnLineState_Bag_CN|正在清点物资..."
  },
  SocializeOnLineState_Alchemy = {
    ID = "SocializeOnLineState_Alchemy",
    CN = "LanguageConfig_SocializeOnLineState_Alchemy_CN|正在进行冶炼..."
  },
  SocializeOnLineState_Dispatch = {
    ID = "SocializeOnLineState_Dispatch",
    CN = "LanguageConfig_SocializeOnLineState_Dispatch_CN|正在派遣任务..."
  },
  SocializeOnLineState_MainCopyInvestigate = {
    ID = "SocializeOnLineState_MainCopyInvestigate",
    CN = "LanguageConfig_SocializeOnLineState_MainCopyInvestigate_CN|正在调查行动..."
  },
  SocializeOnLineState_DailyCopy = {
    ID = "SocializeOnLineState_DailyCopy",
    CN = "LanguageConfig_SocializeOnLineState_DailyCopy_CN|正在融蚀之墟..."
  },
  SocializeOnLineState_Copy = {
    ID = "SocializeOnLineState_Copy",
    CN = "LanguageConfig_SocializeOnLineState_Copy_CN|正在禁忌纂录..."
  },
  SocializeOnLineState_WeekChallenge = {
    ID = "SocializeOnLineState_WeekChallenge",
    CN = "LanguageConfig_SocializeOnLineState_WeekChallenge_CN|正在无光之境..."
  },
  SocializeOnLineState_DailyChallenge = {
    ID = "SocializeOnLineState_DailyChallenge",
    CN = "LanguageConfig_SocializeOnLineState_DailyChallenge_CN|正在幻梦深潜..."
  },
  SocializeOnLineState_WeeklyBoss = {
    ID = "SocializeOnLineState_WeeklyBoss",
    CN = "LanguageConfig_SocializeOnLineState_WeeklyBoss_CN|正在超验存在..."
  },
  SocializeOnLineState_PreparePVP = {
    ID = "SocializeOnLineState_PreparePVP",
    CN = "LanguageConfig_SocializeOnLineState_PreparePVP_CN|准备进行相位对弈…"
  },
  SocializeOnLineState_PVP = {
    ID = "SocializeOnLineState_PVP",
    CN = "LanguageConfig_SocializeOnLineState_PVP_CN|正在相位对弈…"
  },
  SocializeAdmireTime_Day = {
    ID = "SocializeAdmireTime_Day",
    CN = "LanguageConfig_SocializeAdmireTime_Day_CN|{s1} 天前点赞了你"
  },
  SocializeAdmireTime_Hour = {
    ID = "SocializeAdmireTime_Hour",
    CN = "LanguageConfig_SocializeAdmireTime_Hour_CN|{s1} 小时前点赞了你"
  },
  SocializeAdmireTime_Minute = {
    ID = "SocializeAdmireTime_Minute",
    CN = "LanguageConfig_SocializeAdmireTime_Minute_CN|{s1} 分钟前点赞了你"
  },
  SocializeAdmireTime_JustNow = {
    ID = "SocializeAdmireTime_JustNow",
    CN = "LanguageConfig_SocializeAdmireTime_JustNow_CN|刚刚点赞了你"
  },
  Socialize_FollowTime_Day = {
    ID = "Socialize_FollowTime_Day",
    CN = "LanguageConfig_Socialize_FollowTime_Day_CN|{s1} 天前关注了你"
  },
  Socialize_FollowTime_Hour = {
    ID = "Socialize_FollowTime_Hour",
    CN = "LanguageConfig_Socialize_FollowTime_Hour_CN|{s1} 小时前关注了你"
  },
  Socialize_FollowTime_Minute = {
    ID = "Socialize_FollowTime_Minute",
    CN = "LanguageConfig_Socialize_FollowTime_Minute_CN|{s1} 分钟前关注了你"
  },
  Socialize_FollowTime_JustNow = {
    ID = "Socialize_FollowTime_JustNow",
    CN = "LanguageConfig_Socialize_FollowTime_JustNow_CN|刚刚关注了你"
  },
  Socialize_AllStrangersFollowed = {
    ID = "Socialize_AllStrangersFollowed",
    CN = "LanguageConfig_Socialize_AllStrangersFollowed_CN|已全部关注"
  },
  Socialize_AttentionPlayer = {
    ID = "Socialize_AttentionPlayer",
    CN = "LanguageConfig_Socialize_AttentionPlayer_CN|助战关注按钮"
  },
  Socialize_CancelAttention = {
    ID = "Socialize_CancelAttention",
    CN = "LanguageConfig_Socialize_CancelAttention_CN|助战取消按钮"
  },
  ResurrectionCoinSkillDescription = {
    ID = "ResurrectionCoinSkillDescription",
    CN = "LanguageConfig_ResurrectionCoinSkillDescription_CN|死亡后可发动，在使用应急灵知体后恢复所有生命、狂气、银钥能量，并在该回合免疫后续的所有伤害。"
  },
  SocializeAdmireReason = {
    ID = "SocializeAdmireReason",
    CN = "LanguageConfig_SocializeAdmireReason_CN|来自{s1}"
  },
  Keeper_Cost = {
    ID = "Keeper_Cost",
    CN = "LanguageConfig_Keeper_Cost_CN|能量消耗:"
  },
  TutorialTitle = {
    ID = "TutorialTitle",
    CN = "LanguageConfig_TutorialTitle_CN|教学"
  },
  TutorialSearchResult = {
    ID = "TutorialSearchResult",
    CN = "LanguageConfig_TutorialSearchResult_CN|总共<color=#5ef2ff>{s1}</color>个结果"
  },
  UniversalUnlockButton = {
    ID = "UniversalUnlockButton",
    CN = "LanguageConfig_UniversalUnlockButton_CN|解锁"
  },
  StageUnlockCountdownText = {
    ID = "StageUnlockCountdownText",
    CN = "LanguageConfig_StageUnlockCountdownText_CN|{s1}天{s2}小时后开启"
  },
  SubplotActivityRewardTimeTips = {
    ID = "SubplotActivityRewardTimeTips",
    CN = "LanguageConfig_SubplotActivityRewardTimeTips_CN|\n<GrayState:({s1}天{s2}小时后开启)>"
  },
  StageCloseCountdownText = {
    ID = "StageCloseCountdownText",
    CN = "LanguageConfig_StageCloseCountdownText_CN|{s1}后关闭"
  },
  StageClosedText = {
    ID = "StageClosedText",
    CN = "LanguageConfig_StageClosedText_CN|已关闭"
  },
  LockedSubplotStageName = {
    ID = "LockedSubplotStageName",
    CN = "LanguageConfig_LockedSubplotStageName_CN|@1<CardDescColor.Light>@2<CardDescColor.Light>"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Battle_Pass = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Battle_Pass",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Battle_Pass_CN|课题礼匣"
  },
  UI_Recharge_Panel_Main_Text_Toggle_Diamond_Shop = {
    ID = "UI_Recharge_Panel_Main_Text_Toggle_Diamond_Shop",
    CN = "LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Diamond_Shop_CN|「银芯」购买"
  },
  StageOpenCountdownText = {
    ID = "StageOpenCountdownText",
    CN = "LanguageConfig_StageOpenCountdownText_CN|{s1}后开启"
  },
  RatingTipsTitle = {
    ID = "RatingTipsTitle",
    CN = "LanguageConfig_RatingTipsTitle_CN|评价邀请"
  },
  RatingTipsDesc = {
    ID = "RatingTipsDesc",
    CN = "LanguageConfig_RatingTipsDesc_CN|特此邀请你前往商店给出对游戏宝贵的评价与意见"
  },
  KeeperSkillEnergy = {
    ID = "KeeperSkillEnergy",
    CN = "LanguageConfig_KeeperSkillEnergy_CN|银钥能量{s1}"
  },
  KeeperSkillEnergyConsume = {
    ID = "KeeperSkillEnergyConsume",
    CN = "LanguageConfig_KeeperSkillEnergyConsume_CN|银钥能量消耗:{s1}"
  },
  KeeperSkillEquipPrompt = {
    ID = "KeeperSkillEquipPrompt",
    CN = "LanguageConfig_KeeperSkillEquipPrompt_CN|已选择使用钥令 {s1}"
  },
  KeeperSkillCannotChange = {
    ID = "KeeperSkillCannotChange",
    CN = "LanguageConfig_KeeperSkillCannotChange_CN|当前副本不可更换银钥技能"
  },
  KeeperSkillTitle = {
    ID = "KeeperSkillTitle",
    CN = "LanguageConfig_KeeperSkillTitle_CN|钥令"
  },
  EnergyMonthCardCountDownDesc = {
    ID = "EnergyMonthCardCountDownDesc",
    CN = "LanguageConfig_EnergyMonthCardCountDownDesc_CN|剩余领取天数 <color=#21849a>{s1}</color> 天"
  },
  EnergyMonthCardImmediateRewardDesc = {
    ID = "EnergyMonthCardImmediateRewardDesc",
    CN = "LanguageConfig_EnergyMonthCardImmediateRewardDesc_CN|购买后立即获得"
  },
  EnergyMonthCardDailyRewardDesc = {
    ID = "EnergyMonthCardDailyRewardDesc",
    CN = "LanguageConfig_EnergyMonthCardDailyRewardDesc_CN|30天内每日邮件领取"
  },
  EnergyMonthCardOutLimitDayTips = {
    ID = "EnergyMonthCardOutLimitDayTips",
    CN = "LanguageConfig_EnergyMonthCardOutLimitDayTips_CN|剩余{s1}时长大于{s2}天，无法购买"
  },
  EnergyMonthCardRuleTitle = {
    ID = "EnergyMonthCardRuleTitle",
    CN = "LanguageConfig_EnergyMonthCardRuleTitle_CN|鞘内补给说明"
  },
  EnergyMonthCardRuleContent = {
    ID = "EnergyMonthCardRuleContent",
    CN = "LanguageConfig_EnergyMonthCardRuleContent_CN|【鞘内补给介绍】\n每次购买鞘内补给，可立即获得「银芯」× 680 与为期 30 天的鞘内补给生效时间。\n鞘内补给生效时间内，每日可从邮箱中领取「灵啡肽」× 300 和「追念羽笔」× 30 ，每日9点重置【GMT+8】。\n \n【注意事项】\n鞘内补给剩余生效时间≤180天时续购，总生效时间才会延长。\n当鞘内补给剩余生效时间＞180天时不可再进行购买。\n如因特殊原因导致重复购买，总生效时间将无法进行累加，并将直接返还「银芯」× 680。\n玩家在鞘内补给生效期间未领取的「灵啡肽」和「追念羽笔」，将不会返还。"
  },
  CopyResonanceBtnGroupName = {
    ID = "CopyResonanceBtnGroupName",
    CN = "LanguageConfig_CopyResonanceBtnGroupName_CN|共鸣"
  },
  CopyCollectBtnGroupName = {
    ID = "CopyCollectBtnGroupName",
    CN = "LanguageConfig_CopyCollectBtnGroupName_CN|星级评分"
  },
  CopyAchievementBtnGroupName = {
    ID = "CopyAchievementBtnGroupName",
    CN = "LanguageConfig_CopyAchievementBtnGroupName_CN|关卡成就"
  },
  MapNodeChaosName = {
    ID = "MapNodeChaosName",
    CN = "LanguageConfig_MapNodeChaosName_CN|迷雾结节"
  },
  TutorialReward = {
    ID = "TutorialReward",
    CN = "LanguageConfig_TutorialReward_CN|教学学习奖励"
  },
  SummonAutoDecomposeItem = {
    ID = "SummonAutoDecomposeItem",
    CN = "LanguageConfig_SummonAutoDecomposeItem_CN|自动分解"
  },
  BlockText = {
    ID = "BlockText",
    CN = "LanguageConfig_BlockText_CN|护盾"
  },
  WeaponDecomposeEmptyTips = {
    ID = "WeaponDecomposeEmptyTips",
    CN = "LanguageConfig_WeaponDecomposeEmptyTips_CN|暂无可分解的命轮"
  },
  TrinketDecomposeEmptyTips = {
    ID = "TrinketDecomposeEmptyTips",
    CN = "LanguageConfig_TrinketDecomposeEmptyTips_CN|暂无可分解的密契"
  },
  AllAchievement = {
    ID = "AllAchievement",
    CN = "LanguageConfig_AllAchievement_CN|成就/全部成就"
  },
  InvestAchievement = {
    ID = "InvestAchievement",
    CN = "LanguageConfig_InvestAchievement_CN|成就/调查成就"
  },
  AwakerAchievement = {
    ID = "AwakerAchievement",
    CN = "LanguageConfig_AwakerAchievement_CN|成就/唤醒体成就"
  },
  BattleAchievement = {
    ID = "BattleAchievement",
    CN = "LanguageConfig_BattleAchievement_CN|成就/战斗成就"
  },
  OtherAchievement = {
    ID = "OtherAchievement",
    CN = "LanguageConfig_OtherAchievement_CN|成就/其他成就"
  },
  PvPPlayOrderFirst = {
    ID = "PvPPlayOrderFirst",
    CN = "LanguageConfig_PvPPlayOrderFirst_CN|先手"
  },
  PvPPlayOrderSecond = {
    ID = "PvPPlayOrderSecond",
    CN = "LanguageConfig_PvPPlayOrderSecond_CN|后手"
  },
  PvPGiveUp = {
    ID = "PvPGiveUp",
    CN = "LanguageConfig_PvPGiveUp_CN|投降"
  },
  PvPTrainGiveUp = {
    ID = "PvPTrainGiveUp",
    CN = "LanguageConfig_PvPTrainGiveUp_CN|退出"
  },
  PvPWinCount = {
    ID = "PvPWinCount",
    CN = "LanguageConfig_PvPWinCount_CN|赛季胜场：{s1}胜"
  },
  TimeSettleStr = {
    ID = "TimeSettleStr",
    CN = "LanguageConfig_TimeSettleStr_CN|{s1}后结算"
  },
  AwakerTagName = {
    ID = "AwakerTagName",
    CN = "LanguageConfig_AwakerTagName_CN|特性"
  },
  Task_GoldShop_Rules = {
    ID = "Task_GoldShop_Rules",
    CN = "LanguageConfig_Task_GoldShop_Rules_CN|<Title:【金券兑换规则】>\n·金券兑换商店每日9点重置【GMT+8】。\n·守密人可以消耗一定数量的「蔷薇金券」，来刷新金券兑换商店的库存。\n·每次重置最多可以手动刷新5次，消耗的「蔷薇金券」数量递增。\n·当守密人调查等级提升时，金券兑换商品会随之升级并解锁新内容。"
  },
  TrinketStrengthTitle = {
    ID = "TrinketStrengthTitle",
    CN = "LanguageConfig_TrinketStrengthTitle_CN|密契详情"
  },
  TrinketUpgrade = {
    ID = "TrinketUpgrade",
    CN = "LanguageConfig_TrinketUpgrade_CN|升级"
  },
  TrinketConversion = {
    ID = "TrinketConversion",
    CN = "LanguageConfig_TrinketConversion_CN|转录"
  },
  TrinketConversionOriEnries = {
    ID = "TrinketConversionOriEnries",
    CN = "LanguageConfig_TrinketConversionOriEnries_CN|原副属性"
  },
  TrinketConversionNewEnries = {
    ID = "TrinketConversionNewEnries",
    CN = "LanguageConfig_TrinketConversionNewEnries_CN|新副属性"
  },
  TrinketConversionReplace = {
    ID = "TrinketConversionReplace",
    CN = "LanguageConfig_TrinketConversionReplace_CN|替换"
  },
  TrinketStrengthNeed = {
    ID = "TrinketStrengthNeed",
    CN = "LanguageConfig_TrinketStrengthNeed_CN|需要"
  },
  TrinketsUpgradeMax = {
    ID = "TrinketsUpgradeMax",
    CN = "LanguageConfig_TrinketsUpgradeMax_CN|升至上限"
  },
  TrinketsUpgradeOne = {
    ID = "TrinketsUpgradeOne",
    CN = "LanguageConfig_TrinketsUpgradeOne_CN|升1级"
  },
  TrinketsUpgradeMaxLevel = {
    ID = "TrinketsUpgradeMaxLevel",
    CN = "LanguageConfig_TrinketsUpgradeMaxLevel_CN|已达等级上限"
  },
  TrinketUpgradeConsume = {
    ID = "TrinketUpgradeConsume",
    CN = "LanguageConfig_TrinketUpgradeConsume_CN|消耗材料"
  },
  TrinketUpgradeLevelSuccess = {
    ID = "TrinketUpgradeLevelSuccess",
    CN = "LanguageConfig_TrinketUpgradeLevelSuccess_CN|强化成功"
  },
  TrinketUpgradeConsumeReturn = {
    ID = "TrinketUpgradeConsumeReturn",
    CN = "LanguageConfig_TrinketUpgradeConsumeReturn_CN|强化溢出返还"
  },
  TrinketUpgradeSelMats = {
    ID = "TrinketUpgradeSelMats",
    CN = "LanguageConfig_TrinketUpgradeSelMats_CN|选择升级材料"
  },
  TrinketUpgradeNoneMats = {
    ID = "TrinketUpgradeNoneMats",
    CN = "LanguageConfig_TrinketUpgradeNoneMats_CN|暂无套装与位置均相同的密契"
  },
  TrinketGetNewEntries = {
    ID = "TrinketGetNewEntries",
    CN = "LanguageConfig_TrinketGetNewEntries_CN|点击转录获得新副属性"
  },
  TrinketEntriesNone = {
    ID = "TrinketEntriesNone",
    CN = "LanguageConfig_TrinketEntriesNone_CN|暂无属性"
  },
  TrinketAutoRefine = {
    ID = "TrinketAutoRefine",
    CN = "LanguageConfig_TrinketAutoRefine_CN|<Title:自动转录>\n·自动转录可以根据当前材料情况，至多进行 100 次转录。\n·自动转录时，如果转录结果中有 1 条未锁定属性强度为 8 ，自动转录终止。\n·材料不足时，自动转录停止。\n\n<Title:跳过>\n·自动转录时将显示每一次转录结果，可以选择跳过转录过程。跳过后，将直接显示自动转录最终结果。"
  },
  TrinketConversionLockOneOption = {
    ID = "TrinketConversionLockOneOption",
    CN = "LanguageConfig_TrinketConversionLockOneOption_CN|消耗「{s1}」补足残本"
  },
  TrinketConversionRuleTitle = {
    ID = "TrinketConversionRuleTitle",
    CN = "LanguageConfig_TrinketConversionRuleTitle_CN|规则说明"
  },
  TrinketConversionRule = {
    ID = "TrinketConversionRule",
    CN = "LanguageConfig_TrinketConversionRule_CN|<Title:转录>\n·转录可以更改密契副属性的种类和数值，对主属性的种类和数值没有影响。\n·转录时，副属性的种类可以与主属性重复，副属性间的种类也可以重复。\n·转录时，副属性将会获得不同强度的数值。\n·守密人解锁密契转录后，通过任何方式新获得的密契都将自动免费转录一次。\n\n<Title:锁定>\n·转录时，如果想保留某些副属性，可以点击副属性旁的锁定按钮进行锁定，上锁副属性的种类和数值在转录时将会进行保留。\n·最多可同时对两个副属性进行锁定。\n·锁定1条属性时，需要额外消耗相应的「密契残本」× 20；锁定2条属性时，需要额外消耗「追念羽笔」× 10。\n·选择锁定1条属性时，可以勾选「消耗追念羽笔补足残本」；勾选后，若当前「密契残本」不足，将自动消耗相应数量的追念羽笔进行转录。"
  },
  TrinketPlsSelect = {
    ID = "TrinketPlsSelect",
    CN = "LanguageConfig_TrinketPlsSelect_CN|请选择密契装备"
  },
  TrinketChoosenTitle = {
    ID = "TrinketChoosenTitle",
    CN = "LanguageConfig_TrinketChoosenTitle_CN|选择密契"
  },
  SuitPlanChoosenTitle = {
    ID = "SuitPlanChoosenTitle",
    CN = "LanguageConfig_SuitPlanChoosenTitle_CN|选择方案"
  },
  TrinketChoosenPartTitle = {
    ID = "TrinketChoosenPartTitle",
    CN = "LanguageConfig_TrinketChoosenPartTitle_CN|部位"
  },
  TrinketChoosenSuitTitle = {
    ID = "TrinketChoosenSuitTitle",
    CN = "LanguageConfig_TrinketChoosenSuitTitle_CN|方案"
  },
  TrinketSuitSavedTitle = {
    ID = "TrinketSuitSavedTitle",
    CN = "LanguageConfig_TrinketSuitSavedTitle_CN|保存密契方案"
  },
  TrinketSuitPlanNum = {
    ID = "TrinketSuitPlanNum",
    CN = "LanguageConfig_TrinketSuitPlanNum_CN|方案数量"
  },
  TrinketSuitSavedTips = {
    ID = "TrinketSuitSavedTips",
    CN = "LanguageConfig_TrinketSuitSavedTips_CN|请输入方案名称"
  },
  TrinketSuitEditTitle = {
    ID = "TrinketSuitEditTitle",
    CN = "LanguageConfig_TrinketSuitEditTitle_CN|编辑方案"
  },
  TrinketsEquipedByAwakersTips = {
    ID = "TrinketsEquipedByAwakersTips",
    CN = "LanguageConfig_TrinketsEquipedByAwakersTips_CN|以下密契正在装备中，是否进行装备？"
  },
  LargeSubplotTipsTitle = {
    ID = "LargeSubplotTipsTitle",
    CN = "LanguageConfig_LargeSubplotTipsTitle_CN|规则说明"
  },
  LargeSubplotTipsText = {
    ID = "LargeSubplotTipsText",
    CN = "LanguageConfig_LargeSubplotTipsText_CN|<Title:特遣纪录>\n1、需要达成以下条件方可进行特遣纪录：\n·完成对应的调查行动；\n·消耗 「现实起点」× 7 解锁。\n2、当特遣纪录处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、完成特遣纪录调查任务可以获得无垢之芯、守密人经验和调查徽章等奖励。"
  },
  SmallSubplotTipsTitle = {
    ID = "SmallSubplotTipsTitle",
    CN = "LanguageConfig_SmallSubplotTipsTitle_CN|规则说明"
  },
  SmallSubplotTipsText = {
    ID = "SmallSubplotTipsText",
    CN = "LanguageConfig_SmallSubplotTipsText_CN|<Title:意识潜游>\n1、部分意识潜游需要达成以下条件方可进行：\n·完成前置调查事件；\n·消耗指定数量的「现实起点」解锁。\n2、当意识潜游处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、完成意识潜游调查任务可以获得无垢之芯、守密人经验和调查徽章等奖励。"
  },
  CollaborationSubplotTipsTitle = {
    ID = "CollaborationSubplotTipsTitle",
    CN = "LanguageConfig_CollaborationSubplotTipsTitle_CN|规则说明"
  },
  CollaborationSubplotTipsText = {
    ID = "CollaborationSubplotTipsText",
    CN = "LanguageConfig_CollaborationSubplotTipsText_CN|<Title:多维连接>\n1、需要达成以下条件方可进行多维连接：\n·完成对应的调查行动；\n·消耗指定数量的「现实起点」解锁。\n2、当多维连接处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、首次完成多维连接调查任务可以获得无垢之芯。"
  },
  SpecialSubplotTipsTitle = {
    ID = "SpecialSubplotTipsTitle",
    CN = "LanguageConfig_SpecialSubplotTipsTitle_CN|规则说明"
  },
  SpecialSubplotTipsText = {
    ID = "SpecialSubplotTipsText",
    CN = "LanguageConfig_SpecialSubplotTipsText_CN|<Title:异梦视界>\n1、需要达成以下条件方可进行异梦视界：\n·完成对应的调查行动；\n·消耗「现实起点」× 7 解锁。\n2、当异梦视界处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、首次完成异梦视界调查任务可以获得无垢之芯。"
  },
  GoldShopRuleTitle = {
    ID = "GoldShopRuleTitle",
    CN = "LanguageConfig_GoldShopRuleTitle_CN|金券兑换说明"
  },
  GoldShopRefreshDesc = {
    ID = "GoldShopRefreshDesc",
    CN = "LanguageConfig_GoldShopRefreshDesc_CN|{s1}小时{s2}分"
  },
  GoldShopRefreshTimesOutTips = {
    ID = "GoldShopRefreshTimesOutTips",
    CN = "LanguageConfig_GoldShopRefreshTimesOutTips_CN|手动刷新次数已达上限"
  },
  StateEffectDesc = {
    ID = "StateEffectDesc",
    CN = "LanguageConfig_StateEffectDesc_CN|状态说明"
  },
  StateEffectDurationDesc_1 = {
    ID = "StateEffectDurationDesc_1",
    CN = "LanguageConfig_StateEffectDurationDesc_1_CN|本回合有效"
  },
  StateEffectDurationDesc_2 = {
    ID = "StateEffectDurationDesc_2",
    CN = "LanguageConfig_StateEffectDurationDesc_2_CN|本场战斗有效"
  },
  StateEffectDurationDesc_3 = {
    ID = "StateEffectDurationDesc_3",
    CN = "LanguageConfig_StateEffectDurationDesc_3_CN|本次探索有效"
  },
  WordItemDesc = {
    ID = "WordItemDesc",
    CN = "LanguageConfig_WordItemDesc_CN|词缀说明"
  },
  EnchantDesc = {
    ID = "EnchantDesc",
    CN = "LanguageConfig_EnchantDesc_CN|刻印说明"
  },
  DerivedCardDesc = {
    ID = "DerivedCardDesc",
    CN = "LanguageConfig_DerivedCardDesc_CN|衍生卡说明"
  },
  Poem = {
    ID = "Poem",
    CN = "LanguageConfig_Poem_CN|诗篇"
  },
  MapNodeKeyDescription = {
    ID = "MapNodeKeyDescription",
    CN = "LanguageConfig_MapNodeKeyDescription_CN|一串锈迹斑斑的钥匙，可帮助守密人打开锈蚀门扉。"
  },
  RepairTipsTitle = {
    ID = "RepairTipsTitle",
    CN = "LanguageConfig_RepairTipsTitle_CN|资源修复"
  },
  RepairTipsContent = {
    ID = "RepairTipsContent",
    CN = "LanguageConfig_RepairTipsContent_CN|修复功能将删除所有已下载的游戏资源，点选确认后将重新下载。\n建议仅发生在游戏无法正常进行、闪退等问题时使用此功能。\n确认是否清除资源？"
  },
  DevelopVersionShowText = {
    ID = "DevelopVersionShowText",
    CN = "LanguageConfig_DevelopVersionShowText_CN|Res: {s1}.{s2}.{s3}.{s4}"
  },
  GMUserIdText = {
    ID = "GMUserIdText",
    CN = "LanguageConfig_GMUserIdText_CN|UID：{s1}"
  },
  GMNetText = {
    ID = "GMNetText",
    CN = "LanguageConfig_GMNetText_CN|{s1}ms"
  },
  GMVersionText = {
    ID = "GMVersionText",
    CN = "LanguageConfig_GMVersionText_CN|Ver：{s1}"
  },
  Card_Select_Get_Tips1_KeeperSkill = {
    ID = "Card_Select_Get_Tips1_KeeperSkill",
    CN = "LanguageConfig_Card_Select_Get_Tips1_KeeperSkill_CN|选择 1 张钥令"
  },
  SchoolTowerRuleTxt = {
    ID = "SchoolTowerRuleTxt",
    CN = "LanguageConfig_SchoolTowerRuleTxt_CN|<Title:无光之境>\n·无光之境，是一系列难度较高的关卡。通关关卡可以领取丰厚奖励。此外，达成累计的关卡评分星级还可以获取额外奖励。\n\n<Title:调查要求>\n·无光之境的关卡可能会要求使用指定界域和数量的唤醒体进行调查，守密人可以在关卡详情和队伍配置界面中查看。\n\n<Title:初始造物>\n·无光之境的关卡会存在独特的造物，该造物仅在当前关卡生效，合理利用造物效果将会使调查事半功倍。"
  },
  SchoolTowerTeamBuildFobiddenTips = {
    ID = "SchoolTowerTeamBuildFobiddenTips",
    CN = "LanguageConfig_SchoolTowerTeamBuildFobiddenTips_CN|当前选择不满足队伍要求"
  },
  TurnLockCardTips = {
    ID = "TurnLockCardTips",
    CN = "LanguageConfig_TurnLockCardTips_CN|还有指令卡可以打出，紧急情况就别保留实力了！"
  },
  TurnLockExSkillTips = {
    ID = "TurnLockExSkillTips",
    CN = "LanguageConfig_TurnLockExSkillTips_CN|狂气爆发已就绪，紧急情况就别保留实力了！"
  },
  TurnLockPosseTips = {
    ID = "TurnLockPosseTips",
    CN = "LanguageConfig_TurnLockPosseTips_CN|钥令准备好了，紧急情况就别保留实力了！"
  },
  SchoolTowerChallengeLockTips = {
    ID = "SchoolTowerChallengeLockTips",
    CN = "LanguageConfig_SchoolTowerChallengeLockTips_CN|完成上一关卡后解锁"
  },
  SchoolTowerChallengeNotReachLevelTips = {
    ID = "SchoolTowerChallengeNotReachLevelTips",
    CN = "LanguageConfig_SchoolTowerChallengeNotReachLevelTips_CN|挑战所需等级不足"
  },
  CurrRefineLevelEffect = {
    ID = "CurrRefineLevelEffect",
    CN = "LanguageConfig_CurrRefineLevelEffect_CN|当前效果"
  },
  NextRefineLevelEffect = {
    ID = "NextRefineLevelEffect",
    CN = "LanguageConfig_NextRefineLevelEffect_CN|叠位后效果"
  },
  RefineReturn = {
    ID = "RefineReturn",
    CN = "LanguageConfig_RefineReturn_CN|叠位溢出返还"
  },
  LevelUpTipsHpMultiplierText = {
    ID = "LevelUpTipsHpMultiplierText",
    CN = "LanguageConfig_LevelUpTipsHpMultiplierText_CN|唤醒体每点体质带来的最大生命提升至<TipsHighlightText_1: {s1} >"
  },
  LevelUpTipsAccountDamagerText = {
    ID = "LevelUpTipsAccountDamagerText",
    CN = "LanguageConfig_LevelUpTipsAccountDamagerText_CN|关卡造物和刻印强度已提升"
  },
  BreakthroughTitleText = {
    ID = "BreakthroughTitleText",
    CN = "LanguageConfig_BreakthroughTitleText_CN|升格{s1}阶"
  },
  BPChargeSuccessfulTips = {
    ID = "BPChargeSuccessfulTips",
    CN = "LanguageConfig_BPChargeSuccessfulTips_CN|购买成功"
  },
  StageAchieveTaskGot = {
    ID = "StageAchieveTaskGot",
    CN = "LanguageConfig_StageAchieveTaskGot_CN|已达成"
  },
  StageAchieveTaskNotGot = {
    ID = "StageAchieveTaskNotGot",
    CN = "LanguageConfig_StageAchieveTaskNotGot_CN|未达成"
  },
  SweepRuleTxt = {
    ID = "SweepRuleTxt",
    CN = "LanguageConfig_SweepRuleTxt_CN|<Title:重现>\n·重现可以立即获得该关卡的任务报酬。\n·每次重现需消耗等同于进行调查所需的「灵啡肽」或奖励次数。\n<Title:解锁条件>\n·不同关卡解锁重现的条件不同，在未解锁时守密人可以查看重现弹窗中的解锁方式提示。"
  },
  SweepTipsNotThreeStarTxt = {
    ID = "SweepTipsNotThreeStarTxt",
    CN = "LanguageConfig_SweepTipsNotThreeStarTxt_CN|调查评价达到三星后解锁"
  },
  SweepTipsUnopenTxt = {
    ID = "SweepTipsUnopenTxt",
    CN = "LanguageConfig_SweepTipsUnopenTxt_CN|完成挑战后解锁重现"
  },
  SweepTipsAllTasksNotClearTxt = {
    ID = "SweepTipsAllTasksNotClearTxt",
    CN = "LanguageConfig_SweepTipsAllTasksNotClearTxt_CN|通关后，「成就奖励」完成度达到100%解锁"
  },
  Unranked = {
    ID = "Unranked",
    CN = "LanguageConfig_Unranked_CN|未上榜"
  },
  PVPEmailRewardrTxt = {
    ID = "PVPEmailRewardrTxt",
    CN = "LanguageConfig_PVPEmailRewardrTxt_CN|由于上个赛季您有段位奖励未领取，已通过本邮件发放，请及时查收。"
  },
  PVPEmailSeasonBonusTxt = {
    ID = "PVPEmailSeasonBonusTxt"
  },
  PvPTeamBuildChallengeNotFullTips = {
    ID = "PvPTeamBuildChallengeNotFullTips",
    CN = "LanguageConfig_PvPTeamBuildChallengeNotFullTips_CN|需要将编队填满才可进行匹配"
  },
  PVPRankRewardCountdown = {
    ID = "PVPRankRewardCountdown",
    CN = "LanguageConfig_PVPRankRewardCountdown_CN|当前赛季剩余{s1}天{s2}小时"
  },
  PVPSeasonCountdown = {
    ID = "PVPSeasonCountdown",
    CN = "LanguageConfig_PVPSeasonCountdown_CN|{s1}天{s2}小时"
  },
  PVPInstructions = {
    ID = "PVPInstructions",
    CN = "LanguageConfig_PVPInstructions_CN|<Title:【相位对弈】>\n· 相位对弈模式是《忘却前夜》附赠玩法，每个赛季游戏每张卡牌和整体游戏玩法都可能会大幅度重做变化，来换取更平衡更有趣的游戏环境，因此请谨慎为解锁相位对弈的游戏内容而投入资源。\n<Title:【匹配相关】>\n· 相位对弈是两人对抗游戏，需要通过匹配功能等待一段时间以寻找对手，匹配功能会优先寻找旗鼓相当的对手与你进行对抗。\n·同步匹配：守密人可以勾选「预组模式」与「轮选模式」同时对多模式进行匹配，可以有效缩短匹配到对手的等待时间。\n·精准匹配：开启设置会寻找更势均力敌的对手，但这会延长匹配到对手的等待时间。关闭设置会缩短匹配到对手的等待时间，但对手相对不那么势均力敌。\n·模拟对手：开启设置将允许匹配时看情况分配模拟对手，这会缩短匹配到对手的等待时间。关闭设置将仅允许匹配时分配真人对手，这会延长匹配到对手的等待时间。\n<Title:【积分排名】>\n·分数规则：初始积分为 0 分，守密人可通过匹配对战获得积分。\n·分数变化：当双方分数一致时，胜利方将获得 5% 总积分的积分，失败方将失去等值积分。\n·新手保护：当积分低于 1500 时，胜利时将获得更多的分数，失败时将失去更少的分数。\n·强敌挑战：当战胜强敌时获得更多的分数，败于强敌时将失去更少的分数。战胜弱敌时获得更少的分数。\n·分数独立：「预组模式」与「轮选模式」各自拥有独立的积分，但二者一致使用上述积分规则。\n<Title:【赛季更新】>\n·赛季重置：一般情况下，赛季每 28 天重置。重置后，所有人的积分超过 3000 的部分将会减半。\n·赛季排行：「预组模式」与「轮选模式」各自拥有独立的赛季和赛季排行，赛季排行奖励将会在每次赛季结束时进行结算。\n·排行条件：当前赛季内参与一场即可进入对应模式的赛季排行，并以赛季内的历史最高分作为排名依据。当前赛季内获胜一场即可在赛季结束时根据当前赛季排行结算奖励。\n·赛季任务：「预组模式」与「轮选模式」均会有赛季任务，完成赛季任务可以获得丰富的奖励。赛季任务会在每次赛季更新时重置。\n<Title:【预组模式】>\n· 「预组模式」是相位对弈的基础模式，使用预先准备的编队与对手进行对抗，在匹配前需要选择自己的编队与未知编队的对手进行对抗。\n<Title:【轮选模式】>\n·「轮选模式」是相位对弈的进阶模式，无需预组队伍便可进行匹配，在开始战斗前双方需要在一个拥有唤醒体、命轮、钥令的卡池中轮流选取，以此构建自己的编队在后续与对方进行对战。\n· 每场对局中系统会随机选取一个造物，在对战中生效。"
  },
  PvPChallengeBtnText = {
    ID = "PvPChallengeBtnText",
    CN = "LanguageConfig_PvPChallengeBtnText_CN|挑战"
  },
  PvPTeamMultiBuildTitle = {
    ID = "PvPTeamMultiBuildTitle",
    CN = "LanguageConfig_PvPTeamMultiBuildTitle_CN|编辑队伍"
  },
  PvPTeamSingleBuildAwakerTitle = {
    ID = "PvPTeamSingleBuildAwakerTitle",
    CN = "LanguageConfig_PvPTeamSingleBuildAwakerTitle_CN|选择唤醒体"
  },
  PvPTeamSingleBuildKeyTitle = {
    ID = "PvPTeamSingleBuildKeyTitle",
    CN = "LanguageConfig_PvPTeamSingleBuildKeyTitle_CN|选择钥令卡"
  },
  PvPTeamSingleBuildWeaponTitle = {
    ID = "PvPTeamSingleBuildWeaponTitle",
    CN = "LanguageConfig_PvPTeamSingleBuildWeaponTitle_CN|选择命轮卡"
  },
  PvPTeamBuildPanelSaveBtnText = {
    ID = "PvPTeamBuildPanelSaveBtnText",
    CN = "LanguageConfig_PvPTeamBuildPanelSaveBtnText_CN|上阵"
  },
  DFDESideDia1 = {
    ID = "DFDESideDia1",
    CN = "LanguageConfig_DFDESideDia1_CN|它为自己逝去的青春而愤怒。"
  },
  DFDESideDia2 = {
    ID = "DFDESideDia2",
    CN = "LanguageConfig_DFDESideDia2_CN|终于把这个吵闹的东西送出去了。"
  },
  DFDESideDia3 = {
    ID = "DFDESideDia3",
    CN = "LanguageConfig_DFDESideDia3_CN|不要直视它的眼眶。"
  },
  DFDESideDia4 = {
    ID = "DFDESideDia4",
    CN = "LanguageConfig_DFDESideDia4_CN|它对猎物的体脂率有严格要求。"
  },
  DFDESideDia5 = {
    ID = "DFDESideDia5",
    CN = "LanguageConfig_DFDESideDia5_CN|当心，它会吃掉你的脑子哦。"
  },
  DFDESideDia6 = {
    ID = "DFDESideDia6",
    CN = "LanguageConfig_DFDESideDia6_CN|它对逝去之物情有独钟……"
  },
  DFDESideDia7 = {
    ID = "DFDESideDia7",
    CN = "LanguageConfig_DFDESideDia7_CN|记录了弥萨格郊外一成不变的乏味风景。"
  },
  DFDESideDia8 = {
    ID = "DFDESideDia8",
    CN = "LanguageConfig_DFDESideDia8_CN|教你如何抵挡「猎犬」袭击。"
  },
  DFDESideDia9 = {
    ID = "DFDESideDia9",
    CN = "LanguageConfig_DFDESideDia9_CN|记录了拉蒙娜日常生活的绝版胶片。"
  },
  DFDESideDia10 = {
    ID = "DFDESideDia10",
    CN = "LanguageConfig_DFDESideDia10_CN|一个「小礼物」，你会怎么选择呢？"
  },
  DFDESideDia11 = {
    ID = "DFDESideDia11",
    CN = "LanguageConfig_DFDESideDia11_CN|拒绝女士的馈赠可是会变得不幸哦。"
  },
  DFDESideDia12 = {
    ID = "DFDESideDia12",
    CN = "LanguageConfig_DFDESideDia12_CN|哎呀，似乎对现在的状况无效哦。"
  },
  UWHXSideDia1 = {
    ID = "UWHXSideDia1",
    CN = "LanguageConfig_UWHXSideDia1_CN|呵呵……这就是你的全部实力了么？"
  },
  UWHXSideDia2 = {
    ID = "UWHXSideDia2",
    CN = "LanguageConfig_UWHXSideDia2_CN|游戏时间到，轮到我反击了！"
  },
  UWHXSideDia3 = {
    ID = "UWHXSideDia3",
    CN = "LanguageConfig_UWHXSideDia3_CN|真可怜，你以为它能一直控制我么？"
  },
  UWHXSideDia4 = {
    ID = "UWHXSideDia4",
    CN = "LanguageConfig_UWHXSideDia4_CN|自群星而来之物，我们……永不餍足！"
  },
  LTMainDia1 = {
    ID = "LTMainDia1",
    CN = "LanguageConfig_LTMainDia1_CN|太好了，上次可还没分出胜负呢！"
  },
  LTMainDia2 = {
    ID = "LTMainDia2",
    CN = "LanguageConfig_LTMainDia2_CN|看看这招！"
  },
  LTMainDia3 = {
    ID = "LTMainDia3",
    CN = "LanguageConfig_LTMainDia3_CN|哈哈，这可比上次来劲，我可要动真格了！"
  },
  LTMainDia4 = {
    ID = "LTMainDia4",
    CN = "LanguageConfig_LTMainDia4_CN|现在，热身结束"
  },
  KMMainDia1 = {
    ID = "KMMainDia1",
    CN = "LanguageConfig_KMMainDia1_CN|快……跑吧……"
  },
  KMMainDia2 = {
    ID = "KMMainDia2",
    CN = "LanguageConfig_KMMainDia2_CN|呜……痛……"
  },
  HZWMainDia1 = {
    ID = "HZWMainDia1",
    CN = "LanguageConfig_HZWMainDia1_CN|外乡佬，可别小看我们！"
  },
  HZWMainDia2 = {
    ID = "HZWMainDia2",
    CN = "LanguageConfig_HZWMainDia2_CN|别来捣乱，外乡佬！"
  },
  XLMainDia1 = {
    ID = "XLMainDia1",
    CN = "LanguageConfig_XLMainDia1_CN|哼，就凭你们"
  },
  XLMainDia2 = {
    ID = "XLMainDia2",
    CN = "LanguageConfig_XLMainDia2_CN|休想拦住我！"
  },
  XLMainDia3 = {
    ID = "XLMainDia3",
    CN = "LanguageConfig_XLMainDia3_CN|把莉莉…………还给我！"
  },
  XLMainDia4 = {
    ID = "XLMainDia4",
    CN = "LanguageConfig_XLMainDia4_CN|来吧，萝坦！"
  },
  XLMainDia5 = {
    ID = "XLMainDia5",
    CN = "LanguageConfig_XLMainDia5_CN|一决高下！"
  },
  XLMainDia6 = {
    ID = "XLMainDia6",
    CN = "LanguageConfig_XLMainDia6_CN|我还……没有输！"
  },
  LLMainDia1 = {
    ID = "LLMainDia1",
    CN = "LanguageConfig_LLMainDia1_CN|我——是——谁？"
  },
  LLMainDia2 = {
    ID = "LLMainDia2",
    CN = "LanguageConfig_LLMainDia2_CN|妈……妈……"
  },
  LLMainDia3 = {
    ID = "LLMainDia3",
    CN = "LanguageConfig_LLMainDia3_CN|我要……守护"
  },
  LLMainDia4 = {
    ID = "LLMainDia4",
    CN = "LanguageConfig_LLMainDia4_CN|一点……也……不痛"
  },
  TDJZMainDia1 = {
    ID = "TDJZMainDia1",
    CN = "LanguageConfig_TDJZMainDia1_CN|永夜将至，光沐得赎"
  },
  TDJMMainDia1 = {
    ID = "TDJMMainDia1",
    CN = "LanguageConfig_TDJMMainDia1_CN|黯赋永罪，光赐福音"
  },
  TDJMMainDia2 = {
    ID = "TDJMMainDia2",
    CN = "LanguageConfig_TDJMMainDia2_CN|皈光群羊，判汝黯堕"
  },
  NFYMainDia1 = {
    ID = "NFYMainDia1",
    CN = "LanguageConfig_NFYMainDia1_CN|对不起，我必须阻止你们"
  },
  NFYMainDia2 = {
    ID = "NFYMainDia2",
    CN = "LanguageConfig_NFYMainDia2_CN|弗朗西斯夫人……我……还不能倒下"
  },
  WDZZMainDia1 = {
    ID = "WDZZMainDia1",
    CN = "LanguageConfig_WDZZMainDia1_CN|#@……#?……#*"
  },
  Monster_JL_Tips_1 = {
    ID = "Monster_JL_Tips_1",
    CN = "LanguageConfig_Monster_JL_Tips_1_CN|珈伦进入了吃饱喝足状态！你每次消耗算力，珈伦都会获得力量！"
  },
  PvPMatchingText = {
    ID = "PvPMatchingText",
    CN = "LanguageConfig_PvPMatchingText_CN|正在匹配实力相当的对手"
  },
  PVPCollectFilterTypeName_All = {
    ID = "PVPCollectFilterTypeName_All",
    CN = "LanguageConfig_PVPCollectFilterTypeName_All_CN|全部"
  },
  PVPCollectFilterTypeName_Chaos = {
    ID = "PVPCollectFilterTypeName_Chaos",
    CN = "LanguageConfig_PVPCollectFilterTypeName_Chaos_CN|混沌"
  },
  PVPCollectFilterTypeName_Blood = {
    ID = "PVPCollectFilterTypeName_Blood",
    CN = "LanguageConfig_PVPCollectFilterTypeName_Blood_CN|血肉"
  },
  PVPCollectFilterTypeName_Dimension = {
    ID = "PVPCollectFilterTypeName_Dimension",
    CN = "LanguageConfig_PVPCollectFilterTypeName_Dimension_CN|超维"
  },
  PVPCollectFilterTypeName_Ocean = {
    ID = "PVPCollectFilterTypeName_Ocean",
    CN = "LanguageConfig_PVPCollectFilterTypeName_Ocean_CN|深海"
  },
  PVPCollectFilterTypeName_Weapon = {
    ID = "PVPCollectFilterTypeName_Weapon",
    CN = "LanguageConfig_PVPCollectFilterTypeName_Weapon_CN|命轮"
  },
  PVPCollectFilterTypeName_KeeperSkill = {
    ID = "PVPCollectFilterTypeName_KeeperSkill",
    CN = "LanguageConfig_PVPCollectFilterTypeName_KeeperSkill_CN|钥令"
  },
  BattleSchoolEffectTipsTitle = {
    ID = "BattleSchoolEffectTipsTitle",
    CN = "LanguageConfig_BattleSchoolEffectTipsTitle_CN|界域机制"
  },
  MockDungeonTitle = {
    ID = "MockDungeonTitle",
    CN = "LanguageConfig_MockDungeonTitle_CN|模拟训练"
  },
  Chaos_Tips_Title = {
    ID = "Chaos_Tips_Title",
    CN = "LanguageConfig_Chaos_Tips_Title_CN|银钥共鸣"
  },
  Chaos_Tips_Title2 = {
    ID = "Chaos_Tips_Title2",
    CN = "LanguageConfig_Chaos_Tips_Title2_CN|原初吐息"
  },
  NetBlockMaskTips = {
    ID = "NetBlockMaskTips",
    CN = "LanguageConfig_NetBlockMaskTips_CN|网络通信中，请稍候"
  },
  UIBlockMaskTips = {
    ID = "UIBlockMaskTips",
    CN = "LanguageConfig_UIBlockMaskTips_CN|资源加载中，请稍候"
  },
  WakeFromSleep = {
    ID = "WakeFromSleep",
    CN = "LanguageConfig_WakeFromSleep_CN|要来咯！"
  },
  Sleep = {
    ID = "Sleep",
    CN = "LanguageConfig_Sleep_CN|..z<size=40>z</size>Z<size=40>Z</size>"
  },
  RemoveBuff = {
    ID = "RemoveBuff",
    CN = "LanguageConfig_RemoveBuff_CN|驱散"
  },
  RepelBuff = {
    ID = "RepelBuff",
    CN = "LanguageConfig_RepelBuff_CN|击退状态"
  },
  HalfBleeding = {
    ID = "HalfBleeding",
    CN = "LanguageConfig_HalfBleeding_CN|出血减半"
  },
  BuffOffset = {
    ID = "BuffOffset",
    CN = "LanguageConfig_BuffOffset_CN|抵消"
  },
  RemoveDeBuff = {
    ID = "RemoveDeBuff",
    CN = "LanguageConfig_RemoveDeBuff_CN|净化"
  },
  Resurrection = {
    ID = "Resurrection",
    CN = "LanguageConfig_Resurrection_CN|复活"
  },
  DestroyWeapon = {
    ID = "DestroyWeapon",
    CN = "LanguageConfig_DestroyWeapon_CN|摧毁命轮"
  },
  DoubleKill = {
    ID = "DoubleKill",
    CN = "LanguageConfig_DoubleKill_CN|双杀！"
  },
  TripleKill = {
    ID = "TripleKill",
    CN = "LanguageConfig_TripleKill_CN|三杀！！"
  },
  TeamWipe = {
    ID = "TeamWipe",
    CN = "LanguageConfig_TeamWipe_CN|团灭！！！"
  },
  Overload = {
    ID = "Overload",
    CN = "LanguageConfig_Overload_CN|算力超载！"
  },
  SoulSynchronization = {
    ID = "SoulSynchronization",
    CN = "LanguageConfig_SoulSynchronization_CN|同调结束"
  },
  FloatingTextColor_Red = {
    ID = "FloatingTextColor_Red",
    CN = "LanguageConfig_FloatingTextColor_Red_CN|FF0000"
  },
  FloatingTextColor_Green = {
    ID = "FloatingTextColor_Green",
    CN = "LanguageConfig_FloatingTextColor_Green_CN|00CB00"
  },
  ImmuneSpDown = {
    ID = "ImmuneSpDown",
    CN = "LanguageConfig_ImmuneSpDown_CN|免疫算力降低"
  },
  TotallyNumb = {
    ID = "TotallyNumb",
    CN = "LanguageConfig_TotallyNumb_CN|彻底麻了！"
  },
  Frenzy = {
    ID = "Frenzy",
    CN = "LanguageConfig_Frenzy_CN|哎嘿嘿嘿"
  },
  DeathResistFail = {
    ID = "DeathResistFail",
    CN = "LanguageConfig_DeathResistFail_CN|<color=#FF7370>死亡抵抗失败</color>"
  },
  Task_Dispatch_Level_Tips = {
    ID = "Task_Dispatch_Level_Tips",
    CN = "LanguageConfig_Task_Dispatch_Level_Tips_CN|总派遣等级{s1}级"
  },
  GoTo = {
    ID = "GoTo",
    CN = "LanguageConfig_GoTo_CN|前往"
  },
  AppointTaskRewardAddTag = {
    ID = "AppointTaskRewardAddTag",
    CN = "LanguageConfig_AppointTaskRewardAddTag_CN|额外"
  },
  TentacleOverflow = {
    ID = "TentacleOverflow",
    CN = "LanguageConfig_TentacleOverflow_CN|溢出激发"
  },
  SelectTrinketSuit = {
    ID = "SelectTrinketSuit",
    CN = "LanguageConfig_SelectTrinketSuit_CN|选择套装"
  },
  SelectTrinketMainAttr = {
    ID = "SelectTrinketMainAttr",
    CN = "LanguageConfig_SelectTrinketMainAttr_CN|选择主属性"
  },
  SelectTrinketSubAttr = {
    ID = "SelectTrinketSubAttr",
    CN = "LanguageConfig_SelectTrinketSubAttr_CN|选择副属性"
  },
  SelectTrinketHave = {
    ID = "SelectTrinketHave",
    CN = "LanguageConfig_SelectTrinketHave_CN|有"
  },
  SelectTrinketNo = {
    ID = "SelectTrinketNo",
    CN = "LanguageConfig_SelectTrinketNo_CN|无"
  },
  TrinketFilterSuitTitle = {
    ID = "TrinketFilterSuitTitle",
    CN = "LanguageConfig_TrinketFilterSuitTitle_CN|套装"
  },
  TrinketFilterPartTitle = {
    ID = "TrinketFilterPartTitle",
    CN = "LanguageConfig_TrinketFilterPartTitle_CN|位置"
  },
  TrinketFilterMainAttrTitle = {
    ID = "TrinketFilterMainAttrTitle",
    CN = "LanguageConfig_TrinketFilterMainAttrTitle_CN|主属性：(主属性受位置影响)"
  },
  TrinketFilterSubAttrTitle = {
    ID = "TrinketFilterSubAttrTitle",
    CN = "LanguageConfig_TrinketFilterSubAttrTitle_CN|副属性"
  },
  risk_error_msg_maliciousEnv = {
    ID = "risk_error_msg_maliciousEnv",
    CN = "LanguageConfig_risk_error_msg_maliciousEnv_CN|设备或网络环境异常，请稍后再试。"
  },
  risk_error_msg_freqControl = {
    ID = "risk_error_msg_freqControl",
    CN = "LanguageConfig_risk_error_msg_freqControl_CN|您当前的角色创建数量已达上限。"
  },
  risk_error_msg_requestLimit = {
    ID = "risk_error_msg_requestLimit",
    CN = "LanguageConfig_risk_error_msg_requestLimit_CN|系统繁忙，请稍后再试。"
  },
  risk_error_msg_maliciousAction = {
    ID = "risk_error_msg_maliciousAction",
    CN = "LanguageConfig_risk_error_msg_maliciousAction_CN|检测到违规行为，请前往【客服入口】联系客服进行申诉。"
  },
  BreakThroughCondition_1 = {
    ID = "BreakThroughCondition_1",
    CN = "LanguageConfig_BreakThroughCondition_1_CN|<Gray:条件一>"
  },
  BreakThroughCondition_2 = {
    ID = "BreakThroughCondition_2",
    CN = "LanguageConfig_BreakThroughCondition_2_CN|<Gray:条件二>"
  },
  BreakThroughCondition_3 = {
    ID = "BreakThroughCondition_3",
    CN = "LanguageConfig_BreakThroughCondition_3_CN|<Gray:条件三>"
  },
  AwakerSelectTitle = {
    ID = "AwakerSelectTitle",
    CN = "LanguageConfig_AwakerSelectTitle_CN|选择唤醒体"
  },
  WeaponSelectTitle = {
    ID = "WeaponSelectTitle",
    CN = "LanguageConfig_WeaponSelectTitle_CN|选择命轮"
  },
  AwakerWeaponSelectDetail = {
    ID = "AwakerWeaponSelectDetail",
    CN = "LanguageConfig_AwakerWeaponSelectDetail_CN|查看详情"
  },
  AwakerRandomSelectTitle = {
    ID = "AwakerRandomSelectTitle",
    CN = "LanguageConfig_AwakerRandomSelectTitle_CN|随机获得唤醒体"
  },
  WeaponRandomSelectTitle = {
    ID = "WeaponRandomSelectTitle",
    CN = "LanguageConfig_WeaponRandomSelectTitle_CN|随机获得命轮"
  },
  RandomSelectAward = {
    ID = "RandomSelectAward",
    CN = "LanguageConfig_RandomSelectAward_CN|随机获得"
  },
  PickCosmeticsAllPlayerAvatarsGot = {
    ID = "PickCosmeticsAllPlayerAvatarsGot",
    CN = "LanguageConfig_PickCosmeticsAllPlayerAvatarsGot_CN|您已获得列表内所有头像"
  },
  PickCosmeticsAllEmojiGot = {
    ID = "PickCosmeticsAllEmojiGot",
    CN = "LanguageConfig_PickCosmeticsAllEmojiGot_CN|您已获得列表内所有对战表情"
  },
  WaitResponseTips = {
    ID = "WaitResponseTips",
    CN = "LanguageConfig_WaitResponseTips_CN|正在排队进入校园，请耐心等候"
  },
  WeaponInvalidPrompt = {
    ID = "WeaponInvalidPrompt",
    CN = "LanguageConfig_WeaponInvalidPrompt_CN|<Damage:相同的命轮效果无法重复生效。当前该命轮效果已于<Block:{s1}>生效，此处未生效。>"
  },
  TrinketInvalidPrompt = {
    ID = "TrinketInvalidPrompt",
    CN = "LanguageConfig_TrinketInvalidPrompt_CN|<Block:{s1}><Damage:的6件套效果为队伍唯一效果，无法重复生效。当前该效果已于<Block:{s2}>生效，此处未生效。>"
  },
  PVPFailTips = {
    ID = "PVPFailTips",
    CN = "LanguageConfig_PVPFailTips_CN|无需气馁，每位守密人都会经历挑战。重新来过，下一次你会更强！"
  },
  PVPMatchVictory = {
    ID = "PVPMatchVictory",
    CN = "LanguageConfig_PVPMatchVictory_CN|比赛胜利"
  },
  PVPWinningStreak = {
    ID = "PVPWinningStreak",
    CN = "LanguageConfig_PVPWinningStreak_CN|连续胜利"
  },
  PVPSeasonBonus = {
    ID = "PVPSeasonBonus",
    CN = "LanguageConfig_PVPSeasonBonus_CN|赛季加成"
  },
  PVPFirstWinBonus = {
    ID = "PVPFirstWinBonus",
    CN = "LanguageConfig_PVPFirstWinBonus_CN|首胜加成"
  },
  PVPBattlePerformance = {
    ID = "PVPBattlePerformance",
    CN = "LanguageConfig_PVPBattlePerformance_CN|战斗表现"
  },
  PVPMatchDefeat = {
    ID = "PVPMatchDefeat",
    CN = "LanguageConfig_PVPMatchDefeat_CN|比赛失败"
  },
  PvPMatchinging = {
    ID = "PvPMatchinging",
    CN = "LanguageConfig_PvPMatchinging_CN|正在 {s1} 人中匹配实力相当的对手{s2}"
  },
  SocialSystemStrollingAround = {
    ID = "SocialSystemStrollingAround",
    CN = "LanguageConfig_SocialSystemStrollingAround_CN|正在闲逛..."
  },
  SocialSystemModifyRemarks = {
    ID = "SocialSystemModifyRemarks",
    CN = "LanguageConfig_SocialSystemModifyRemarks_CN|修改备注"
  },
  SocialSystemSetRemarks = {
    ID = "SocialSystemSetRemarks",
    CN = "LanguageConfig_SocialSystemSetRemarks_CN|设置备注"
  },
  SocialSystemLeaveNoteName = {
    ID = "SocialSystemLeaveNoteName",
    CN = "LanguageConfig_SocialSystemLeaveNoteName_CN|为【{s1}】备注名称，取消关注将清除备注"
  },
  SocialSystemEnterNoteName = {
    ID = "SocialSystemEnterNoteName",
    CN = "LanguageConfig_SocialSystemEnterNoteName_CN|请输入备注名"
  },
  SocialSystemCancelFollow = {
    ID = "SocialSystemCancelFollow",
    CN = "LanguageConfig_SocialSystemCancelFollow_CN|取消关注"
  },
  SocialSystemSocialInteraction = {
    ID = "SocialSystemSocialInteraction",
    CN = "LanguageConfig_SocialSystemSocialInteraction_CN|校友会"
  },
  SocialSystemFollow = {
    ID = "SocialSystemFollow",
    CN = "LanguageConfig_SocialSystemFollow_CN|关注"
  },
  SocialSystemFans = {
    ID = "SocialSystemFans",
    CN = "LanguageConfig_SocialSystemFans_CN|追随者"
  },
  SocialSystemVisitor = {
    ID = "SocialSystemVisitor",
    CN = "LanguageConfig_SocialSystemVisitor_CN|来访者"
  },
  SocialSystemLookup = {
    ID = "SocialSystemLookup",
    CN = "LanguageConfig_SocialSystemLookup_CN|查找"
  },
  SocialSystemChangeBatch = {
    ID = "SocialSystemChangeBatch",
    CN = "LanguageConfig_SocialSystemChangeBatch_CN|换一批"
  },
  SocialSystemCoolDown = {
    ID = "SocialSystemCoolDown",
    CN = "LanguageConfig_SocialSystemCoolDown_CN|冷却{s1}秒"
  },
  SocialSystemEnterUID = {
    ID = "SocialSystemEnterUID",
    CN = "LanguageConfig_SocialSystemEnterUID_CN|请输入UID"
  },
  SocialSystemSearch = {
    ID = "SocialSystemSearch",
    CN = "LanguageConfig_SocialSystemSearch_CN|搜索"
  },
  SocialSystemStranger = {
    ID = "SocialSystemStranger",
    CN = "LanguageConfig_SocialSystemStranger_CN|陌生人"
  },
  SocialSystemSearchResult = {
    ID = "SocialSystemSearchResult",
    CN = "LanguageConfig_SocialSystemSearchResult_CN|搜索结果"
  },
  SocialSystemSearchPlayers = {
    ID = "SocialSystemSearchPlayers",
    CN = "LanguageConfig_SocialSystemSearchPlayers_CN|输入UID查找守密人"
  },
  SocialSystemAddNewFans = {
    ID = "SocialSystemAddNewFans",
    CN = "LanguageConfig_SocialSystemAddNewFans_CN|新增追随者"
  },
  SocialSystemNewAddition = {
    ID = "SocialSystemNewAddition",
    CN = "LanguageConfig_SocialSystemNewAddition_CN|新增"
  },
  SocialSystemVisitedDaysAgo = {
    ID = "SocialSystemVisitedDaysAgo",
    CN = "LanguageConfig_SocialSystemVisitedDaysAgo_CN|{s1}天前来访"
  },
  SocialSystemVisitedHoursAgo = {
    ID = "SocialSystemVisitedHoursAgo",
    CN = "LanguageConfig_SocialSystemVisitedHoursAgo_CN|{s1}小时前来访"
  },
  SocialSystemVisitedMinutesAgo = {
    ID = "SocialSystemVisitedMinutesAgo",
    CN = "LanguageConfig_SocialSystemVisitedMinutesAgo_CN|{s1}分钟前来访"
  },
  SocialSystemJustVisited = {
    ID = "SocialSystemJustVisited",
    CN = "LanguageConfig_SocialSystemJustVisited_CN|刚刚来访"
  },
  SocialSystemNoFoundInTheSearch = {
    ID = "SocialSystemNoFoundInTheSearch",
    CN = "LanguageConfig_SocialSystemNoFoundInTheSearch_CN|未搜索到其他守密人"
  },
  SocialSystemCannotSearchForOneself = {
    ID = "SocialSystemCannotSearchForOneself",
    CN = "LanguageConfig_SocialSystemCannotSearchForOneself_CN|不可搜索自己"
  },
  SocialSystemSurveyProgress = {
    ID = "SocialSystemSurveyProgress",
    CN = "LanguageConfig_SocialSystemSurveyProgress_CN|调查行动"
  },
  SocialSystemHighestRecord = {
    ID = "SocialSystemHighestRecord",
    CN = "LanguageConfig_SocialSystemHighestRecord_CN|最高纪录"
  },
  SocialSystemHighestTitle = {
    ID = "SocialSystemHighestTitle",
    CN = "LanguageConfig_SocialSystemHighestTitle_CN|最高头衔"
  },
  SocialSystemAccumulatedRatingThisWeek = {
    ID = "SocialSystemAccumulatedRatingThisWeek",
    CN = "LanguageConfig_SocialSystemAccumulatedRatingThisWeek_CN|本周累计评分"
  },
  SocialSystemSchoolTowerGap = {
    ID = "SocialSystemSchoolTowerGap",
    CN = "LanguageConfig_SocialSystemSchoolTowerGap_CN|无光之境"
  },
  SocialSystemSchoolTowerWheelGap = {
    ID = "SocialSystemSchoolTowerWheelGap",
    CN = "LanguageConfig_SocialSystemSchoolTowerWheelGap_CN|无光之境·轮转间隙"
  },
  SocialSystemNewFansTip = {
    ID = "SocialSystemNewFansTip",
    CN = "LanguageConfig_SocialSystemNewFansTip_CN|可查看近期新增的{s1}名追随者"
  },
  SocialSystemCommonUseBattleHelp = {
    ID = "SocialSystemCommonUseBattleHelp",
    CN = "LanguageConfig_SocialSystemCommonUseBattleHelp_CN|设为常用助战"
  },
  SocialSystemCancelCommonUseBattleHelp = {
    ID = "SocialSystemCancelCommonUseBattleHelp",
    CN = "LanguageConfig_SocialSystemCancelCommonUseBattleHelp_CN|取消常用助战"
  },
  AwakerFormConflict = {
    ID = "AwakerFormConflict",
    CN = "LanguageConfig_AwakerFormConflict_CN|无法上阵"
  },
  ActivityExtraDropTimes = {
    ID = "ActivityExtraDropTimes",
    CN = "LanguageConfig_ActivityExtraDropTimes_CN|不限次"
  },
  SocialSystemSetBirthday = {
    ID = "SocialSystemSetBirthday",
    CN = "LanguageConfig_SocialSystemSetBirthday_CN|设置生日"
  },
  SocialSystemIntroduction = {
    ID = "SocialSystemIntroduction",
    CN = "LanguageConfig_SocialSystemIntroduction_CN|编辑简介"
  },
  SocialSystemIntroductionNotYetEdited = {
    ID = "SocialSystemIntroductionNotYetEdited",
    CN = "LanguageConfig_SocialSystemIntroductionNotYetEdited_CN|点击输入简介"
  },
  SocialSystemLikeHistory = {
    ID = "SocialSystemLikeHistory",
    CN = "LanguageConfig_SocialSystemLikeHistory_CN|点赞记录"
  },
  SocialSystemLikeEmptyStatusDesc = {
    ID = "SocialSystemLikeEmptyStatusDesc",
    CN = "LanguageConfig_SocialSystemLikeEmptyStatusDesc_CN|去点赞更多有趣的守密人吧"
  },
  SocialSystemMainLineMadness = {
    ID = "SocialSystemMainLineMadness",
    CN = "LanguageConfig_SocialSystemMainLineMadness_CN|癫狂"
  },
  SocialSystemChangeAvatar = {
    ID = "SocialSystemChangeAvatar",
    CN = "LanguageConfig_SocialSystemChangeAvatar_CN|更换头像"
  },
  SocialSystemIntroductionNone = {
    ID = "SocialSystemIntroductionNone",
    CN = "LanguageConfig_SocialSystemIntroductionNone_CN|暂无简介"
  },
  SocialSystemBirthday = {
    ID = "SocialSystemBirthday",
    CN = "LanguageConfig_SocialSystemBirthday_CN|{s1}月{s2}日"
  },
  SocialSystemInterrelated = {
    ID = "SocialSystemInterrelated",
    CN = "LanguageConfig_SocialSystemInterrelated_CN|互相关注"
  },
  SocialSystemFollowed = {
    ID = "SocialSystemFollowed",
    CN = "LanguageConfig_SocialSystemFollowed_CN|已关注"
  },
  AssistanceSystemTitle = {
    ID = "AssistanceSystemTitle",
    CN = "LanguageConfig_AssistanceSystemTitle_CN|助战规则"
  },
  AssistanceSystemIntroduction = {
    ID = "AssistanceSystemIntroduction",
    CN = "LanguageConfig_AssistanceSystemIntroduction_CN|·守密人可以选择1名唤醒体进行助战，其他已互相关注的守密人可以在融蚀之墟、禁忌纂录和幻梦深潜中使用你的助战唤醒体出战。\n·每次当其他守密人使用你的助战唤醒体调查成功后，你可以获得「蔷薇金券」×1000的奖励，每日最多可获得20次奖励。\n·当蔷薇金券奖励累计到 50 次时，守密人需先领取奖励后才可继续获得助战奖励。"
  },
  SocialSystemFollowEmptyStatusTitle = {
    ID = "SocialSystemFollowEmptyStatusTitle",
    CN = "LanguageConfig_SocialSystemFollowEmptyStatusTitle_CN|暂无关注"
  },
  SocialSystemFollowEmptyStatusDesc = {
    ID = "SocialSystemFollowEmptyStatusDesc",
    CN = "LanguageConfig_SocialSystemFollowEmptyStatusDesc_CN|去关注更多有趣的守密人吧"
  },
  SocialSystemFansEmptyStatusTitle = {
    ID = "SocialSystemFansEmptyStatusTitle",
    CN = "LanguageConfig_SocialSystemFansEmptyStatusTitle_CN|暂无追随者"
  },
  SocialSystemFansEmptyStatusDesc = {
    ID = "SocialSystemFansEmptyStatusDesc",
    CN = "LanguageConfig_SocialSystemFansEmptyStatusDesc_CN|终会有第一个发现你的守密人"
  },
  SocialSystemVisitorEmptyStatusTitle = {
    ID = "SocialSystemVisitorEmptyStatusTitle",
    CN = "LanguageConfig_SocialSystemVisitorEmptyStatusTitle_CN|暂无来访者"
  },
  SocialSystemVisitorEmptyStatusDesc = {
    ID = "SocialSystemVisitorEmptyStatusDesc",
    CN = "LanguageConfig_SocialSystemVisitorEmptyStatusDesc_CN|等待其他守密人留下足迹"
  },
  SocialSystemLookupEmptyStatusTitle = {
    ID = "SocialSystemLookupEmptyStatusTitle",
    CN = "LanguageConfig_SocialSystemLookupEmptyStatusTitle_CN|暂无陌生人"
  },
  SocialSystemLookupEmptyStatusDesc = {
    ID = "SocialSystemLookupEmptyStatusDesc",
    CN = "LanguageConfig_SocialSystemLookupEmptyStatusDesc_CN|点击换一批，认识更多有趣的守密人"
  },
  ScoreMaxTo = {
    ID = "ScoreMaxTo",
    CN = "LanguageConfig_ScoreMaxTo_CN|累计深潜经验值达到"
  },
  ScoreReachTile = {
    ID = "ScoreReachTile",
    CN = "LanguageConfig_ScoreReachTile_CN|每周试炼"
  },
  ScoreAchieveTitle = {
    ID = "ScoreAchieveTitle",
    CN = "LanguageConfig_ScoreAchieveTitle_CN|深潜纪录"
  },
  ScoreAchieveNum = {
    ID = "ScoreAchieveNum",
    CN = "LanguageConfig_ScoreAchieveNum_CN|累计深潜经验值：{s1}"
  },
  RoleDayExpLimit = {
    ID = "RoleDayExpLimit",
    CN = "LanguageConfig_RoleDayExpLimit_CN|今日经验上限"
  },
  CommonTabAll = {
    ID = "CommonTabAll",
    CN = "LanguageConfig_CommonTabAll_CN|全部"
  },
  OpenExpression_PVP = {
    ID = "OpenExpression_PVP",
    CN = "LanguageConfig_OpenExpression_PVP_CN|开启互动"
  },
  CloseExpression_PVP = {
    ID = "CloseExpression_PVP",
    CN = "LanguageConfig_CloseExpression_PVP_CN|屏蔽互动"
  },
  PVPandDailyChallengeExpTips = {
    ID = "PVPandDailyChallengeExpTips",
    CN = "LanguageConfig_PVPandDailyChallengeExpTips_CN|通过「幻梦深潜」和「相位对弈」可以获取守密人经验，每日通过该途径最多可以获取{s1}点，今日已获取{s2}点。"
  },
  SubplotFreeTips = {
    ID = "SubplotFreeTips",
    CN = "LanguageConfig_SubplotFreeTips_CN|活动期间<WeaponEffect_Num:「限时免费解锁」>调查内容"
  },
  DailyChallengeAll = {
    ID = "DailyChallengeAll",
    CN = "LanguageConfig_DailyChallengeAll_CN|全部"
  },
  DailyChallengeChaos = {
    ID = "DailyChallengeChaos",
    CN = "LanguageConfig_DailyChallengeChaos_CN|至纯混沌"
  },
  DailyChallengeBlood = {
    ID = "DailyChallengeBlood",
    CN = "LanguageConfig_DailyChallengeBlood_CN|至纯血肉"
  },
  DailyChallengeDimension = {
    ID = "DailyChallengeDimension",
    CN = "LanguageConfig_DailyChallengeDimension_CN|至纯超维"
  },
  DailyChallengeOcean = {
    ID = "DailyChallengeOcean",
    CN = "LanguageConfig_DailyChallengeOcean_CN|至纯深海"
  },
  DailyChallengeOceanBlood = {
    ID = "DailyChallengeOceanBlood",
    CN = "LanguageConfig_DailyChallengeOceanBlood_CN|深海血肉"
  },
  DailyChallengeOceanDimension = {
    ID = "DailyChallengeOceanDimension",
    CN = "LanguageConfig_DailyChallengeOceanDimension_CN|深海超维"
  },
  DailyChallengeBloodDimension = {
    ID = "DailyChallengeBloodDimension",
    CN = "LanguageConfig_DailyChallengeBloodDimension_CN|血肉超维"
  },
  TheNth = {
    ID = "TheNth",
    CN = "LanguageConfig_TheNth_CN|第{s1}名"
  },
  AfterTheNth = {
    ID = "AfterTheNth",
    CN = "LanguageConfig_AfterTheNth_CN|第{s1}名后"
  },
  SpecialTeamBanTips = {
    ID = "SpecialTeamBanTips",
    CN = "LanguageConfig_SpecialTeamBanTips_CN|本次调查{s1}无法上场"
  },
  ForceAssistTeam = {
    ID = "ForceAssistTeam",
    CN = "LanguageConfig_ForceAssistTeam_CN|本次调查必须上场助战唤醒体"
  },
  AlertForceAssist = {
    ID = "AlertForceAssist",
    CN = "LanguageConfig_AlertForceAssist_CN|未上场助战唤醒体，无法进入调查"
  },
  AwakerUseTimesLimitTips = {
    ID = "AwakerUseTimesLimitTips",
    CN = "LanguageConfig_AwakerUseTimesLimitTips_CN|*通关后，本次出战的唤醒体今日将无法在本活动中上场。"
  },
  AbyssAwakerLimitTips = {
    ID = "AbyssAwakerLimitTips"
  },
  CurUenergyValue = {
    ID = "CurUenergyValue",
    CN = "LanguageConfig_CurUenergyValue_CN|当前狂气值{s1}"
  },
  SelectKeeperSkill_Title1 = {
    ID = "SelectKeeperSkill_Title1",
    CN = "LanguageConfig_SelectKeeperSkill_Title1_CN|选择一个钥令"
  },
  SelectKeeperSkillToUse_Title1 = {
    ID = "SelectKeeperSkillToUse_Title1",
    CN = "LanguageConfig_SelectKeeperSkillToUse_Title1_CN|选择一个钥令释放"
  },
  DailyChallengeRankingRuleTitle = {
    ID = "DailyChallengeRankingRuleTitle",
    CN = "LanguageConfig_DailyChallengeRankingRuleTitle_CN|排行规则"
  },
  DailyChallengeRankingRuleDesc = {
    ID = "DailyChallengeRankingRuleDesc",
    CN = "LanguageConfig_DailyChallengeRankingRuleDesc_CN|1、调查头衔的排名区间会根据参与总人数动态变化，比例如下：\n·幻梦传奇：前0.2%\n·幻梦主宰：0.2%~1%\n·深潜大师：1%~5%\n·深潜学者：5%~15%\n·梦境学徒：15%~35%\n·潜游新手：35%~75%\n·失眠病患：75%后\n2、当出现与其他守密人同分的情况时，排名会按照挑战时间进行先后排序，但排行奖励将以此分的最高排名为准。"
  },
  PVPRankingRuleTitle = {
    ID = "PVPRankingRuleTitle",
    CN = "LanguageConfig_PVPRankingRuleTitle_CN|排行规则"
  },
  PVPRankingRuleDesc = {
    ID = "PVPRankingRuleDesc",
    CN = "LanguageConfig_PVPRankingRuleDesc_CN|<Title:【积分排行】>\n·「预组模式」与「轮选模式」各自拥有独立的赛季和赛季排行，赛季排行奖励将会在每次赛季结束时进行结算。\n·当前赛季内参与一场即可进入对应模式的赛季排行，并以赛季内的历史最高分作为排名依据。当前赛季内获胜一场即可在赛季结束时根据当前赛季排行结算奖励。\n<Title:【排名比例】>\n·对弈头衔按参与排行的积分排名，比例如下:\n     ·相位传奇：前2%\n     ·相位支配者：2%~10%\n     ·对弈大师：10%~25%\n     ·相位精英：25%~50%\n     ·对弈学徒：50%~75%\n     ·相位新手：75%后\n·当出现与其他守密人相同积分的情况时，将按照进入排行的先后进行排序，但对弈头衔和奖励仍以此分的最高排名为准。"
  },
  AwakerAssistRuleTitle = {
    ID = "AwakerAssistRuleTitle",
    CN = "LanguageConfig_AwakerAssistRuleTitle_CN|助战规则"
  },
  AwakerAssistRule = {
    ID = "AwakerAssistRule",
    CN = "LanguageConfig_AwakerAssistRule_CN|·在进行融蚀之墟、禁忌纂录、幻梦深潜、超验存在等玩法时，可以选择使用1名已互相关注守密人的助战唤醒体进行出战。\n·助战唤醒体需满足当前编队的界域限制，不符合条件的助战唤醒体无法上场，守密人可以返回调整编队后再进行上场。\n·部分活动可能会有额外的特殊助战规则，请查看该活动的「活动说明」进行详细了解。"
  },
  TotalNumWins = {
    ID = "TotalNumWins",
    CN = "LanguageConfig_TotalNumWins_CN|合计胜利场数"
  },
  WeeklyRecord = {
    ID = "WeeklyRecord",
    CN = "LanguageConfig_WeeklyRecord_CN|每周试炼"
  },
  WeeklyRecordDesc = {
    ID = "WeeklyRecordDesc",
    CN = "LanguageConfig_WeeklyRecordDesc_CN|相位对弈和幻梦深潜合计胜利{s1}场"
  },
  LevelLimitIncrease = {
    ID = "LevelLimitIncrease",
    CN = "LanguageConfig_LevelLimitIncrease_CN|等级上限提升"
  },
  AwakerLevelLimitIncreaseTo = {
    ID = "AwakerLevelLimitIncreaseTo",
    CN = "LanguageConfig_AwakerLevelLimitIncreaseTo_CN|唤醒体等级上限已提升至{s1}级，可继续升级"
  },
  ContinueToUpgrade = {
    ID = "ContinueToUpgrade"
  },
  SpiritualDeepenInsufficientMaterials = {
    ID = "SpiritualDeepenInsufficientMaterials",
    CN = "LanguageConfig_SpiritualDeepenInsufficientMaterials_CN|灵知深化材料不足"
  },
  SpiritualDeepen = {
    ID = "SpiritualDeepen",
    CN = "LanguageConfig_SpiritualDeepen_CN|灵知深化"
  },
  AwakerUpgradeMaterialCompose = {
    ID = "AwakerUpgradeMaterialCompose",
    CN = "LanguageConfig_AwakerUpgradeMaterialCompose_CN|材料合成"
  },
  Monster_HDN_SideDia1 = {
    ID = "Monster_HDN_SideDia1",
    CN = "LanguageConfig_Monster_HDN_SideDia1_CN|霍迪妮大师要抓一个幸运小孩！谁会成为幸运儿呢~"
  },
  Monster_HDN_SideDia2 = {
    ID = "Monster_HDN_SideDia2",
    CN = "LanguageConfig_Monster_HDN_SideDia2_CN|精妙绝伦的飞牌表演！"
  },
  Monster_HDN_SideDia3 = {
    ID = "Monster_HDN_SideDia3",
    CN = "LanguageConfig_Monster_HDN_SideDia3_CN|霍迪妮大师的魔术秀~在此开场！"
  },
  Monster_HDN_SideDia4 = {
    ID = "Monster_HDN_SideDia4",
    CN = "LanguageConfig_Monster_HDN_SideDia4_CN|去吧！魔术助手！把霍迪妮大师的观众抬上来！"
  },
  Monster_KXY_SideDia1 = {
    ID = "Monster_KXY_SideDia1",
    CN = "LanguageConfig_Monster_KXY_SideDia1_CN|既然不要了，不如消失掉吧！"
  },
  Monster_KXY_SideDia2 = {
    ID = "Monster_KXY_SideDia2",
    CN = "LanguageConfig_Monster_KXY_SideDia2_CN|选哪张都没有用，没有用！"
  },
  BacktrackTimesLeft = {
    ID = "BacktrackTimesLeft",
    CN = "LanguageConfig_BacktrackTimesLeft_CN|回溯功能将在{s1}后关闭"
  },
  BacktrackAwaker_Rules = {
    ID = "BacktrackAwaker_Rules",
    CN = "LanguageConfig_BacktrackAwaker_Rules_CN|<Title:【养成回溯】>\n·此操作将重置唤醒体的所有升级、升格、技能、灵知深化状态，消耗的材料与金券均会全数返还。\n·唤醒体所有消耗的界域升格素材，返还为等同数量与稀有度的「初阶升格匣子」、「中阶升格匣子」、「高阶升格匣子」，可以选择等同数量与稀有度的任意界域升格素材。\n·唤醒体所有消耗的界域技能素材，返还为等同数量与稀有度的「初阶技能补给」、「中阶技能补给」、「高阶技能补给」，可以选择等同数量与稀有度的任意界域技能素材。\n·唤醒体所有消耗的「幸运糖果」、「蜡像泥胚」、「漆黑锁扣」、「维度结晶」、「虔诚圣心」，返还为30倍数量的「拟态凝晶」。 \n<Title:【启灵回溯】>\n·此操作将重置唤醒体的启灵状态，并重置启灵带来的等级上限，消耗的材料会全数返还。\n·唤醒体所有消耗或未使用的启灵残片，将视获取来源分别返还成不同的道具。\n·由「原型视界」兑换所得的，返还为「原型视界」。\n·由限时唤醒所得的限定唤醒体转化而来的，返还为「灵魂回溯之芯」。\n·「朵尔」「奥吉尔」「萝坦」将会返回「调查徽章」× 2500。\n·「拉蒙娜」「环行·拉蒙娜」将会返回「残片·拉蒙娜」。\n·「艾继丝」「奥瑞塔」「艾瑞卡」将会返回「融蚀之珠」× 8000。\n·通过其他方式所得的，返还为「原质乐园」。\n<Title:【黑池归还】>\n·此操作除了「养成回溯」所有效果之外，还将唤醒体本身也重置，变为未解锁状态。\n·唤醒体所装备的命轮、密契都将卸下，其头像将会变为不可用，如果正在使用会切换为默认头像。\n·唤醒体的升格奖励领取状态、同调率与同调率奖励领取状态均将保留，重新获取该唤醒体时会继承。\n·唤醒体本身将视来源分别返还成不同的道具。由限时唤醒所得的限定唤醒体，返还为「灵魂回溯之芯」；通过其他方式所得的，返还为「原质乐园」。\n<Title:【物品说明】>\n·「初阶升格匣子」：使用时可任选纯白残片、淬制本能、记忆副本、认知模板中其中1个。\n·「中阶升格匣子」：使用时可任选纯白文书、淬制理智、情感副本、精神模板中其中1个。\n·「高阶升格匣子」：使用时可任选纯白秘篇、淬制心灵、意识副本、灵知模板中其中1个。\n·「初阶技能补给」：使用时可任选失色晶蝶、低茎海百合、风干虫蛹、残破矿晶中其中1个。\n·「中阶技能补给」：使用时可任选闪耀晶蝶、高茎海百合、原生虫蛹、陨星碎块中其中1个。\n·「高阶技能补给」：使用时可任选混沌结晶、尤因他百合、芽孢聚合物、尤卡坦之星中其中1个。\n·「原型视界」：使用时可从中任选1个已解锁SSR角色的唤醒体残片。\n·「原质乐园」：使用时可从中任选1个「界域研习」中的唤醒体唤醒。\n·「灵魂回溯之芯」：使用时可从中任选1个「界域研习」、往期角色活动唤醒和当期角色活动唤醒中的唤醒体。"
  },
  BacktrackWeapon_Rules = {
    ID = "BacktrackWeapon_Rules",
    CN = "LanguageConfig_BacktrackWeapon_Rules_CN|<Title:【叠位回溯】>\n·此操作将重置命轮所有叠位状态，消耗的材料会全数返还。\n·通过「循环母版」激活的叠位，返还「循环母版」；通过限时唤醒所得的限定命轮激活的叠位，返还「命途回溯之芯」；通过其他方式激活的叠位，返还为「轮转之书」。\n<Title:【黑池归还】>\n·此操作除了「养成回溯」所有效果之外，还将命轮本身也重置。\n·通过限时唤醒所得的限定命轮，返还「命途回溯之芯」；通过其他方式所得的，返还为「轮转之书」。\n<Title:【物品说明】>\n·以下物品均在物资界面中使用。\n·「循环母版」：可以作为任意一个SSR命轮的叠位素材。\n·「轮转之书」：使用时可从中任选1个「轮转之相」中的SSR命轮获得。\n·「命途回溯之心」：使用时可从中任选1个「轮转之相」、往期命轮活动唤醒和当期命轮活动唤醒中的SSR命轮。"
  },
  BacktrackTips1 = {
    ID = "BacktrackTips1",
    CN = "LanguageConfig_BacktrackTips1_CN|特殊唤醒体仅能进行「养成回溯」"
  },
  BacktrackTips2 = {
    ID = "BacktrackTips2",
    CN = "LanguageConfig_BacktrackTips2_CN|「养成回溯」或「启灵回溯」后，无法再进行「黑池归还」"
  },
  BacktrackTips3 = {
    ID = "BacktrackTips3",
    CN = "LanguageConfig_BacktrackTips3_CN|特殊唤醒体无法进行「黑池归还」"
  },
  BacktrackRedirectHint = {
    ID = "BacktrackRedirectHint",
    CN = "LanguageConfig_BacktrackRedirectHint_CN|前往解锁"
  },
  BacktrackCannotSkipTips = {
    ID = "BacktrackCannotSkipTips",
    CN = "LanguageConfig_BacktrackCannotSkipTips_CN|正在调查中，无法进行跳转。"
  },
  AbyssChallengeAwakerAssistRuleTitle = {
    ID = "AbyssChallengeAwakerAssistRuleTitle",
    CN = "LanguageConfig_AbyssChallengeAwakerAssistRuleTitle_CN|助战说明"
  },
  AbyssChallengeAwakerAssistRule = {
    ID = "AbyssChallengeAwakerAssistRule",
    CN = "LanguageConfig_AbyssChallengeAwakerAssistRule_CN|·在「融灾禁区」中可以使用1次助战，助战唤醒体与命轮不会受到限制法则的影响。（守密人可以在融灾禁区的规则说明中查看限制法则的详细说明。）\n·重置带有助战唤醒体的调查队伍时，会返还1次助战次数。"
  },
  AbyssChallengeResetTipsDateHour = {
    ID = "AbyssChallengeResetTipsDateHour",
    CN = "LanguageConfig_AbyssChallengeResetTipsDateHour_CN|{s1}天{s2}小时后重置"
  },
  AbyssChallengeResetTipsHourMinute = {
    ID = "AbyssChallengeResetTipsHourMinute",
    CN = "LanguageConfig_AbyssChallengeResetTipsHourMinute_CN|{s1}小时{s2}分钟后重置"
  },
  AbyssChallengeEndTips = {
    ID = "AbyssChallengeEndTips",
    CN = "LanguageConfig_AbyssChallengeEndTips_CN|已结束"
  },
  AbyssChallengeTipsTitle = {
    ID = "AbyssChallengeTipsTitle",
    CN = "LanguageConfig_AbyssChallengeTipsTitle_CN|规则说明"
  },
  AbyssChallengeTips = {
    ID = "AbyssChallengeTips",
    CN = "LanguageConfig_AbyssChallengeTips_CN|<Title:「融灾禁区」>\n·融灾禁区是一个难度较高的玩法系统。守密人需要灵活搭配多个挑战队伍，尽可能地获取更多的特训值，从而获得更多的奖励。\n\n<Title:「禁区基础规则」>\n·融灾禁区共分为 5 个波次，每个波次中包含难度等级不同的关卡。\n·通关关卡后，可以获得对应数量的特训值，具体可在关卡详情界面中查看。\n·当特训值达到指定要求后，除了可以领取「银芯」和「黑色贡物」外，还可以获得珍稀物资「原初灵核」「精粹原初灵核」！它是产自弥萨格地底黑池的神秘灵核，能帮助唤醒体提升等级上限，最多提升至 90 级！\n·「融灾禁区」会周期性更新关卡内容和奖励，一般情况下，每 14 天更新一次。当期时间结束后，未领取的奖励将无法获取，守密人记得及时完成和领取喔~\n\n<Title:「禁区特殊规则」>\n·在融灾禁区中有其独特的限制法则：同一唤醒体和钥令、同名命轮无法重复上场，守密人可以根据初始造物、怪物和推荐等级，灵活选择本次挑战的队伍。\n·完成挑战后，若守密人发现有更好的搭配方案，可以使用「重置」功能将对应关卡的挑战队伍进行重置，重置后唤醒体、钥令和命轮都可以重新上场，但通过该关卡获得的特训值也会扣除（不影响奖励状态）。\n·在「融灾禁区」中可以使用 1 次助战，助战唤醒体与命轮不会受到限制法则的影响；重置带有助战唤醒体的挑战队伍时，也会返回 1 次助战次数。\n\n<Title:「额外挑战」>\n·通关任一关卡后，即可解锁该关卡的「额外挑战」，迎接更高难度的考验。\n·额外挑战需要单独编成挑战队伍，且同样受到限制法则影响：同一唤醒体和钥令、同名命轮无法重复上场，助战次数与普通挑战共享（全玩法共 1 次）。\n·通关额外挑战可获得 5 点特训值，计入本期特训值总额，助力领取更多奖励、提升排行榜名次。\n·可使用「重置」功能单独重置额外挑战队伍或普通挑战队伍。\n·若在额外通关后重置普通挑战队伍，额外挑战队伍将转为新的普通挑战队伍，额外挑战进度清空，并扣除额外通关特训值。\n\n<Title:「排行榜」>\n·现在可以查看本期和上期的特训值排行榜，以及其他守密人在融灾禁区中的通关信息，为守密人提供参考情报。\n·排行榜会展示达到本期最高特训值时的特训值与通关信息，重置不会影响排名，也不会影响通关编队信息展示。"
  },
  AbyssChallengeTipsV2 = {
    ID = "AbyssChallengeTipsV2",
    CN = "LanguageConfig_AbyssChallengeTipsV2_CN|<Title:「融灾禁区」>\n·融灾禁区是一个难度较高的玩法系统。守密人需要灵活搭配多个挑战队伍，尽可能地获取更多的特训值，从而获得更多的奖励。\n\n<Title:「禁区基础规则」>\n·融灾禁区共分为 5 个波次，每个波次中包含难度等级不同的关卡。\n·通关关卡后，可以获得对应数量的特训值，具体可在关卡详情界面中查看。\n·当特训值达到指定要求后，除了可以领取「银芯」和「黑色贡物」外，还可以获得珍稀物资「原初灵核」「精粹原初灵核」！它是产自弥萨格地底黑池的神秘灵核，能帮助唤醒体提升等级上限，最多提升至 90 级！\n·「融灾禁区」会周期性更新关卡内容和奖励，一般情况下，每 14 天更新一次。当期时间结束后，上一期仍在进行中的挑战将立即结束，未领取的奖励将无法获取，守密人记得及时完成和领取喔~\n\n<Title:「禁区特殊规则」>\n·在融灾禁区中有其独特的限制法则：同一唤醒体和钥令、同名命轮无法重复上场，守密人可以根据初始造物、怪物和推荐等级，灵活选择本次挑战的队伍。\n·完成挑战后，若守密人发现有更好的搭配方案，可以使用「重置」功能将对应关卡的挑战队伍进行重置，重置后唤醒体、钥令和命轮都可以重新上场，但通过该关卡获得的特训值也会扣除（不影响奖励状态）。\n·在「融灾禁区」中可以使用 1 次助战，助战唤醒体与命轮不会受到限制法则的影响；重置带有助战唤醒体的挑战队伍时，也会返回 1 次助战次数。\n·挑战过程中可使用「应急灵知体」协助通关，每次使用需要花费 3 个「应急灵知体」。使用后完成的挑战与特训值将被特殊标记，可正常领取特训奖励，但不计入排行榜。\n\n<Title:「额外挑战」>\n·通关任一关卡后，即可解锁该关卡的「额外挑战」，迎接更高难度的考验。\n·额外挑战需要单独编成挑战队伍，且同样受到限制法则影响：同一唤醒体和钥令、同名命轮无法重复上场，助战次数与普通挑战共享（全玩法共 1 次）。\n·通关额外挑战可获得 5 点特训值，计入本期特训值总额，助力领取更多奖励、提升排行榜名次。\n·可使用「重置」功能单独重置额外挑战队伍或普通挑战队伍。\n·若在额外通关后重置普通挑战队伍，额外挑战队伍将转为新的普通挑战队伍，额外挑战进度清空，并扣除额外通关特训值。\n\n<Title:「排行榜」>\n·现在可以查看本期和上期的特训值排行榜，以及其他守密人在融灾禁区中的通关信息，为守密人提供参考情报。\n·排行榜会展示达到本期最高特训值时的特训值与通关信息，重置不会影响排名，也不会影响通关编队信息展示。\n·请注意，使用「应急灵知体」通关挑战获得的特训值将被特殊标记且不会计入排行榜。"
  },
  AbyssChallengePerfectPass = {
    ID = "AbyssChallengePerfectPass",
    CN = "LanguageConfig_AbyssChallengePerfectPass_CN|完美通关"
  },
  AbyssChallengePass = {
    ID = "AbyssChallengePass",
    CN = "LanguageConfig_AbyssChallengePass_CN|已通关"
  },
  AbyssChallengeScore = {
    ID = "AbyssChallengeScore",
    CN = "LanguageConfig_AbyssChallengeScore_CN|累计特训值达到"
  },
  AbyssChallengeObtainScore = {
    ID = "AbyssChallengeObtainScore",
    CN = "LanguageConfig_AbyssChallengeObtainScore_CN|获得特训值"
  },
  AbyssChallengeStageClearance = {
    ID = "AbyssChallengeStageClearance",
    CN = "LanguageConfig_AbyssChallengeStageClearance_CN|通关{s1}"
  },
  AbyssChallengeBattleTips = {
    ID = "AbyssChallengeBattleTips",
    CN = "LanguageConfig_AbyssChallengeBattleTips_CN|*通关后，本次出战的唤醒体、命轮和钥令将无法在其他融灾禁区中上场。"
  },
  AbyssChallengeHistoricalRecord = {
    ID = "AbyssChallengeHistoricalRecord",
    CN = "LanguageConfig_AbyssChallengeHistoricalRecord_CN|·额外"
  },
  StageInitialStateTitle = {
    ID = "StageInitialStateTitle",
    CN = "LanguageConfig_StageInitialStateTitle_CN|减益效果"
  },
  StageInitialStateTitle_1 = {
    ID = "StageInitialStateTitle_1",
    CN = "LanguageConfig_StageInitialStateTitle_1_CN|增益效果"
  },
  StageInitialStateContent = {
    ID = "StageInitialStateContent",
    CN = "LanguageConfig_StageInitialStateContent_CN|「%s」 ：%s"
  },
  TentacleModeSwitch1 = {
    ID = "TentacleModeSwitch1",
    CN = "LanguageConfig_TentacleModeSwitch1_CN|「潮涌」为当前触腕姿态，不可重复选择"
  },
  TentacleModeSwitch2 = {
    ID = "TentacleModeSwitch2",
    CN = "LanguageConfig_TentacleModeSwitch2_CN|当前永久触腕数量不足，无法切换「怒涛」姿态"
  },
  TentacleModeSwitch3 = {
    ID = "TentacleModeSwitch3",
    CN = "LanguageConfig_TentacleModeSwitch3_CN|「静海」姿态冷却中，无法切换，还需冷却 {s1} 回合"
  },
  TentacleModeSwitch4 = {
    ID = "TentacleModeSwitch4",
    CN = "LanguageConfig_TentacleModeSwitch4_CN|「怒涛」姿态冷却中，无法切换，还需冷却 {s1} 回合"
  },
  TentacleModeSwitchTips = {
    ID = "TentacleModeSwitchTips",
    CN = "LanguageConfig_TentacleModeSwitchTips_CN|选择触腕姿态"
  },
  TentacleModeSwitchCondTips = {
    ID = "TentacleModeSwitchCondTips",
    CN = "LanguageConfig_TentacleModeSwitchCondTips_CN|本回合已切换过触腕姿态"
  },
  TentacleModeSwitchNew = {
    ID = "TentacleModeSwitchNew",
    CN = "LanguageConfig_TentacleModeSwitchNew_CN|当前姿态"
  },
  TentacleModeSwitchCondString = {
    ID = "TentacleModeSwitchCondString",
    CN = "LanguageConfig_TentacleModeSwitchCondString_CN|无法选择"
  },
  Battle_Transcendent_Title = {
    ID = "Battle_Transcendent_Title",
    CN = "LanguageConfig_Battle_Transcendent_Title_CN|发动超维空间"
  },
  BloodAbilityCoolDown = {
    ID = "BloodAbilityCoolDown",
    CN = "LanguageConfig_BloodAbilityCoolDown_CN|「猩红熔炉」冷却中，无法使用，还需冷却 {s1} 回合"
  },
  DimensionAbilityCoolDown = {
    ID = "DimensionAbilityCoolDown",
    CN = "LanguageConfig_DimensionAbilityCoolDown_CN|「湮灭」冷却中，无法使用，还需冷却 {s1} 回合"
  },
  LilyResonance1_1 = {
    ID = "LilyResonance1_1",
    CN = "LanguageConfig_LilyResonance1_1_CN|，普通刻印 3 选 1"
  },
  LilyResonance1_2 = {
    ID = "LilyResonance1_2",
    CN = "LanguageConfig_LilyResonance1_2_CN|，高级刻印 3 选 1"
  },
  LilyResonance4_1 = {
    ID = "LilyResonance4_1",
    CN = "LanguageConfig_LilyResonance4_1_CN|，获得 1 张「灵感」"
  },
  LilyResonance4_2 = {
    ID = "LilyResonance4_2",
    CN = "LanguageConfig_LilyResonance4_2_CN|，获得 2 张「灵感」"
  },
  WangdaResonance1_1 = {
    ID = "WangdaResonance1_1",
    CN = "LanguageConfig_WangdaResonance1_1_CN|，获得 Arg3 黑印"
  },
  WangdaResonance15_1 = {
    ID = "WangdaResonance15_1",
    CN = "LanguageConfig_WangdaResonance15_1_CN|，随机觉醒 1 名唤醒体"
  },
  SEWDResonance1_1 = {
    ID = "SEWDResonance1_1",
    CN = "LanguageConfig_SEWDResonance1_1_CN|获得随机负罪造物"
  },
  SEWDResonance1_2 = {
    ID = "SEWDResonance1_2",
    CN = "LanguageConfig_SEWDResonance1_2_CN|获得3选1负罪造物"
  },
  ["24Resonance1_1"] = {
    ID = "24Resonance1_1",
    CN = "LanguageConfig_24Resonance1_1_CN|随机 2 张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  ["24Resonance1_2"] = {
    ID = "24Resonance1_2",
    CN = "LanguageConfig_24Resonance1_2_CN|随机 4 张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  ["24Resonance1_3"] = {
    ID = "24Resonance1_3",
    CN = "LanguageConfig_24Resonance1_3_CN|获得3个随机白银造物"
  },
  ["24Resonance1_4"] = {
    ID = "24Resonance1_4",
    CN = "LanguageConfig_24Resonance1_4_CN|获得3个随机白银造物或获得1个随机黄金+造物"
  },
  Chapter7Resonance1_1 = {
    ID = "Chapter7Resonance1_1",
    CN = "LanguageConfig_Chapter7Resonance1_1_CN|和其他共鸣效果"
  },
  Chapter7Resonance1_2 = {
    ID = "Chapter7Resonance1_2",
    CN = "LanguageConfig_Chapter7Resonance1_2_CN|，获得 3 个随机症状"
  },
  Chapter7Resonance1_3 = {
    ID = "Chapter7Resonance1_3",
    CN = "LanguageConfig_Chapter7Resonance1_3_CN|1"
  },
  Chapter7Resonance1_4 = {
    ID = "Chapter7Resonance1_4",
    CN = "LanguageConfig_Chapter7Resonance1_4_CN|2"
  },
  MLYMResonance1_1 = {
    ID = "MLYMResonance1_1",
    CN = "LanguageConfig_MLYMResonance1_1_CN|【牺牲珍视之物】随机失去「温暖的家庭」、「诚挚的朋友」或「安定的生活」中的 1 张卡。"
  },
  MLYMResonance1_2 = {
    ID = "MLYMResonance1_2",
    CN = "LanguageConfig_MLYMResonance1_2_CN|【献祭珍视之物】选择失去「温暖的家庭」、「诚挚的朋友」或「安定的生活」中的 1 张卡,并加入1张「神国幻影」。"
  },
  DailyChallengeRules = {
    ID = "DailyChallengeRules",
    CN = "LanguageConfig_DailyChallengeRules_CN|深潜规则"
  },
  SpecialRating = {
    ID = "SpecialRating",
    CN = "LanguageConfig_SpecialRating_CN|评分项"
  },
  AbyssChallengeWeaponCanNotFight = {
    ID = "AbyssChallengeWeaponCanNotFight",
    CN = "LanguageConfig_AbyssChallengeWeaponCanNotFight_CN|当前命轮已在其他融灾禁区中使用"
  },
  AbyssChallengeRuleTitle = {
    ID = "AbyssChallengeRuleTitle",
    CN = "LanguageConfig_AbyssChallengeRuleTitle_CN|规则说明"
  },
  AbyssChallengeRuleDesc = {
    ID = "AbyssChallengeRuleDesc",
    CN = "LanguageConfig_AbyssChallengeRuleDesc_CN|-"
  },
  AbyssChallengeTitle = {
    ID = "AbyssChallengeTitle",
    CN = "LanguageConfig_AbyssChallengeTitle_CN|融灾禁区"
  },
  FreeTrialRuleTitle = {
    ID = "FreeTrialRuleTitle",
    CN = "LanguageConfig_FreeTrialRuleTitle_CN|规则说明"
  },
  FreeTrialRuleDesc = {
    ID = "FreeTrialRuleDesc",
    CN = "LanguageConfig_FreeTrialRuleDesc_CN|·在唤醒体试玩中，守密人可以参与所有唤醒体的试玩关卡，帮助你掌握唤醒体的基本用法。\n·常驻唤醒体的试玩关卡将提供「银芯」、「无垢之芯」的首通奖励！\n·限定唤醒体的试玩关卡将提供「根源沉淀」的首通奖励"
  },
  FreeTrialTitle = {
    ID = "FreeTrialTitle",
    CN = "LanguageConfig_FreeTrialTitle_CN|唤醒体试玩"
  },
  TalentExtraFavor = {
    ID = "TalentExtraFavor",
    CN = "LanguageConfig_TalentExtraFavor_CN|{s1}（+{s2}）"
  },
  ResonanceUnlockTips = {
    ID = "ResonanceUnlockTips",
    CN = "LanguageConfig_ResonanceUnlockTips_CN|激活{s1}后解锁"
  },
  ResonanceActiveExtraItem = {
    ID = "ResonanceActiveExtraItem",
    CN = "LanguageConfig_ResonanceActiveExtraItem_CN|（可使用{s1}激活）"
  },
  ResonanceUnlock_Or = {
    ID = "ResonanceUnlock_Or",
    CN = "LanguageConfig_ResonanceUnlock_Or_CN|或"
  },
  ResonanceUnlock_And = {
    ID = "ResonanceUnlock_And",
    CN = "LanguageConfig_ResonanceUnlock_And_CN|和"
  },
  SocialOnlineTimeLabel = {
    ID = "SocialOnlineTimeLabel",
    CN = "LanguageConfig_SocialOnlineTimeLabel_CN|上线时间"
  },
  Monster_6unit_C0602boss_tips1 = {
    ID = "Monster_6unit_C0602boss_tips1",
    CN = "LanguageConfig_Monster_6unit_C0602boss_tips1_CN|我···看到你了······"
  },
  Monster_6unit_C0602boss_tips2 = {
    ID = "Monster_6unit_C0602boss_tips2",
    CN = "LanguageConfig_Monster_6unit_C0602boss_tips2_CN|敌人正要以惊人速度回复生命，对其造成伤害来阻止它！"
  },
  Monster_6unit_C0603_tips1 = {
    ID = "Monster_6unit_C0603_tips1",
    CN = "LanguageConfig_Monster_6unit_C0603_tips1_CN|我的珊瑚…希望你能喜欢…"
  },
  Monster_6unit_C0603_tips2 = {
    ID = "Monster_6unit_C0603_tips2",
    CN = "LanguageConfig_Monster_6unit_C0603_tips2_CN|敌人每损失一定生命，就会有「变异珊瑚」自体内生成！"
  },
  Monster_Ocean_Title = {
    ID = "Monster_Ocean_Title",
    CN = "LanguageConfig_Monster_Ocean_Title_CN|触腕"
  },
  Monster_Ocean_Tips = {
    ID = "Monster_Ocean_Tips",
    CN = "LanguageConfig_Monster_Ocean_Tips_CN|每个回合开始时，所有触腕会进行 1 次攻击。"
  },
  Monster_6unit_C0602_tips1 = {
    ID = "Monster_6unit_C0602_tips1",
    CN = "LanguageConfig_Monster_6unit_C0602_tips1_CN|自寄主中重生……"
  },
  Monster_6unit_EndBoss_Select_Card_Tips = {
    ID = "Monster_6unit_EndBoss_Select_Card_Tips",
    CN = "LanguageConfig_Monster_6unit_EndBoss_Select_Card_Tips_CN|选择一个效果释放"
  },
  Monster_C0603_Title = {
    ID = "Monster_C0603_Title",
    CN = "LanguageConfig_Monster_C0603_Title_CN|当心！释放狂气爆发会使敌人获得「孕育」状态，增强敌人的力量，达到 5 层还会释放强力技能！"
  },
  Monster_6unit_B0006_Tips1 = {
    ID = "Monster_6unit_B0006_Tips1",
    CN = "LanguageConfig_Monster_6unit_B0006_Tips1_CN|自…女儿的…中……醒来……"
  },
  Monster_6unit_B0006_Tips2 = {
    ID = "Monster_6unit_B0006_Tips2",
    CN = "LanguageConfig_Monster_6unit_B0006_Tips2_CN|蜕变…自此而生……"
  },
  Monster_6unit_B0006_Tips3 = {
    ID = "Monster_6unit_B0006_Tips3",
    CN = "LanguageConfig_Monster_6unit_B0006_Tips3_CN|螺湮的暂熄……不…余不要……"
  },
  Monster_6unit_C0603_BOSSSIZE_Tips1 = {
    ID = "Monster_6unit_C0603_BOSSSIZE_Tips1",
    CN = "LanguageConfig_Monster_6unit_C0603_BOSSSIZE_Tips1_CN|见证吧，见证此身蒙神恩之力……！"
  },
  Monster_6unit_C0603_Tips1 = {
    ID = "Monster_6unit_C0603_Tips1",
    CN = "LanguageConfig_Monster_6unit_C0603_Tips1_CN|诞生…嘶…诞生……"
  },
  DailyChallengeAwardIllustrateTitle = {
    ID = "DailyChallengeAwardIllustrateTitle",
    CN = "LanguageConfig_DailyChallengeAwardIllustrateTitle_CN|规则说明"
  },
  DailyChallengeAwardIllustrateContent = {
    ID = "DailyChallengeAwardIllustrateContent",
    CN = "LanguageConfig_DailyChallengeAwardIllustrateContent_CN|1、根据今日通关幻梦深潜的最高难度决定次日获取的「融蚀之珠」奖励，各难度对应的奖励如下：\n·幻梦深潜Ⅰ：融蚀之珠*300\n·幻梦深潜Ⅱ：融蚀之珠*400\n·幻梦深潜Ⅲ：融蚀之珠*500\n·幻梦深潜Ⅳ：融蚀之珠*600\n·幻梦深潜Ⅴ：融蚀之珠*700\n·幻梦深潜Ⅵ：融蚀之珠*800\n·幻梦深潜Ⅶ：融蚀之珠*900\n·幻梦深潜·癫狂：融蚀之珠*900\n2、奖励将于次日通过结算邮件发送，请守密人记得查收。\n3、如果守密人在参与「幻梦深潜」或「外勤代理」当日同时参与了「相位对弈」，则次日9点结算的融蚀之珠奖励，将以每日幻梦奖励和「相位对弈」排行奖励中更高的融蚀之珠奖励为准。"
  },
  DailyChallengeChallengeNoneText = {
    ID = "DailyChallengeChallengeNoneText",
    CN = "LanguageConfig_DailyChallengeChallengeNoneText_CN|今日尚无挑战记录"
  },
  DailyChallengeAwardSendTimeText = {
    ID = "DailyChallengeAwardSendTimeText",
    CN = "LanguageConfig_DailyChallengeAwardSendTimeText_CN|奖励于次日%s发送至邮件"
  },
  ConfirmationNoLongerPromptsText_1 = {
    ID = "ConfirmationNoLongerPromptsText_1",
    CN = "LanguageConfig_ConfirmationNoLongerPromptsText_1_CN|今日不再提醒"
  },
  ConfirmationNoLongerPromptsText_2 = {
    ID = "ConfirmationNoLongerPromptsText_2",
    CN = "LanguageConfig_ConfirmationNoLongerPromptsText_2_CN|{s1}天内不再提醒"
  },
  PrerequisiteStagesRequired = {
    ID = "PrerequisiteStagesRequired",
    CN = "LanguageConfig_PrerequisiteStagesRequired_CN|需完成前置关卡"
  },
  Unlockable = {
    ID = "Unlockable",
    CN = "LanguageConfig_Unlockable_CN|可解锁"
  },
  LimitedTimeFreeUnlock = {
    ID = "LimitedTimeFreeUnlock",
    CN = "LanguageConfig_LimitedTimeFreeUnlock_CN|限时免费解锁"
  },
  TextComma = {
    ID = "TextComma",
    CN = "LanguageConfig_TextComma_CN|、"
  },
  ReturnEventRewardButtonText = {
    ID = "ReturnEventRewardButtonText",
    CN = "LanguageConfig_ReturnEventRewardButtonText_CN|重启补给"
  },
  ReturnEventRewardTitleText = {
    ID = "ReturnEventRewardTitleText",
    CN = "LanguageConfig_ReturnEventRewardTitleText_CN|重启未知的旅途"
  },
  ReturnEventRewardText = {
    ID = "ReturnEventRewardText",
    CN = "LanguageConfig_ReturnEventRewardText_CN|与融蚀对抗的使命是一条通向未知的不归路，路上遍布陷阱与危机。\n而「拯救世界」又是一个太重要，也太容易让人迷失的课题。在弥萨格大学的历史上，有不少年轻调查员受到使命感的蛊惑，失去理智地燃烧了自己。\n因此你能做出休息一段时间的决定，我们都很庆幸。我们承受不起又一次失去守密人的损失。\n寒暄到此为止，为了能让你迅速回到调查状态，我为你拟定了一套重启训练方案。照着做，拿着结果回来找我，我自有奖励。\n顺便，拉蒙娜为你准备了一些「小礼物」。她挺想你的。"
  },
  ReturnEventRewardSenderText = {
    ID = "ReturnEventRewardSenderText",
    CN = "LanguageConfig_ReturnEventRewardSenderText_CN|——朵尔"
  },
  TeamTitleText = {
    ID = "TeamTitleText",
    CN = "LanguageConfig_TeamTitleText_CN|队伍配置"
  },
  DynamicStageRuleTitle = {
    ID = "DynamicStageRuleTitle",
    CN = "LanguageConfig_DynamicStageRuleTitle_CN|规则说明"
  },
  DynamicStageRuleDesc = {
    ID = "DynamicStageRuleDesc",
    CN = "LanguageConfig_DynamicStageRuleDesc_CN|·该关卡难度与守密人等级有关。守密人等级越高，敌人越强，通关后获得的蔷薇金券、灵知制剂、同调率奖励也会少量提高。"
  },
  SystemPreset = {
    ID = "SystemPreset",
    CN = "LanguageConfig_SystemPreset_CN|剧情预设"
  },
  MustBattle = {
    ID = "MustBattle",
    CN = "LanguageConfig_MustBattle_CN|必须上阵"
  },
  Team = {
    ID = "Team",
    CN = "LanguageConfig_Team_CN|队伍"
  },
  TeamFormation = {
    ID = "TeamFormation",
    CN = "LanguageConfig_TeamFormation_CN|编队"
  },
  SpecialTeamPreset = {
    ID = "SpecialTeamPreset",
    CN = "LanguageConfig_SpecialTeamPreset_CN|预选"
  },
  SpecialTeamTryOut = {
    ID = "SpecialTeamTryOut",
    CN = "LanguageConfig_SpecialTeamTryOut_CN|试用"
  },
  CurrentTrinketSet = {
    ID = "CurrentTrinketSet",
    CN = "LanguageConfig_CurrentTrinketSet_CN|当前方案：{s1}"
  },
  Hour = {
    ID = "Hour",
    CN = "LanguageConfig_Hour_CN|小时"
  },
  Minute = {
    ID = "Minute",
    CN = "LanguageConfig_Minute_CN|分"
  },
  Second = {
    ID = "Second",
    CN = "LanguageConfig_Second_CN|秒"
  },
  Day = {
    ID = "Day",
    CN = "LanguageConfig_Day_CN|天"
  },
  TrinketApplyingToSuitPlan = {
    ID = "TrinketApplyingToSuitPlan",
    CN = "LanguageConfig_TrinketApplyingToSuitPlan_CN|已应用"
  },
  StageHighDifficultTipsTitle = {
    ID = "StageHighDifficultTipsTitle",
    CN = "LanguageConfig_StageHighDifficultTipsTitle_CN|警告"
  },
  StageHighDifficultTipsContent = {
    ID = "StageHighDifficultTipsContent",
    CN = "LanguageConfig_StageHighDifficultTipsContent_CN|前路危机四伏，潜藏着人类难以匹敌之物\n准备万全，谨慎做出每一个抉择\n向那些勇于挑战黑暗与未知的人们致敬\n愿银钥指引前路"
  },
  DoubleOutputActivityTimesHead = {
    ID = "DoubleOutputActivityTimesHead",
    CN = "LanguageConfig_DoubleOutputActivityTimesHead_CN|今日奖励额外+{s1}%"
  },
  DoubleOutputActivityRemainTimes = {
    ID = "DoubleOutputActivityRemainTimes",
    CN = "LanguageConfig_DoubleOutputActivityRemainTimes_CN|剩余{s1}次"
  },
  DoubleOutputActivityBonusHead = {
    ID = "DoubleOutputActivityBonusHead",
    CN = "LanguageConfig_DoubleOutputActivityBonusHead_CN|奖励+100%"
  },
  BpUnPurchaseLevelClickTips = {
    ID = "BpUnPurchaseLevelClickTips",
    CN = "LanguageConfig_BpUnPurchaseLevelClickTips_CN|当前不可购买等级"
  },
  AwakerStoryNameEn = {
    ID = "AwakerStoryNameEn",
    CN = "LanguageConfig_AwakerStoryNameEn_CN|英文名"
  },
  BonusCardRateText = {
    ID = "BonusCardRateText",
    CN = "LanguageConfig_BonusCardRateText_CN|「丰穰种核」获得强欲加成：<NetworkDelayGreen:{s1}>"
  },
  BonusCardAwardText = {
    ID = "BonusCardAwardText",
    CN = "LanguageConfig_BonusCardAwardText_CN|强欲加成"
  },
  CollectionBoxProduceSpeed = {
    ID = "CollectionBoxProduceSpeed",
    CN = "LanguageConfig_CollectionBoxProduceSpeed_CN|{s1}/小时"
  },
  CollectionBoxFillUpCountdown = {
    ID = "CollectionBoxFillUpCountdown",
    CN = "LanguageConfig_CollectionBoxFillUpCountdown_CN|距离存储上限：{s1}"
  },
  CollectionBoxCollectCountdown = {
    ID = "CollectionBoxCollectCountdown",
    CN = "LanguageConfig_CollectionBoxCollectCountdown_CN|距离可领取：{s1}"
  },
  LotteryRuleTitle = {
    ID = "LotteryRuleTitle",
    CN = "LanguageConfig_LotteryRuleTitle_CN|规则说明"
  },
  LotteryNormalReward = {
    ID = "LotteryNormalReward",
    CN = "LanguageConfig_LotteryNormalReward_CN|普通物品"
  },
  LotteryCoreReward = {
    ID = "LotteryCoreReward",
    CN = "LanguageConfig_LotteryCoreReward_CN|特殊物品"
  },
  LotteryProgressText = {
    ID = "LotteryProgressText",
    CN = "LanguageConfig_LotteryProgressText_CN|剩余：{s1}/{s2}"
  },
  LotteryResetBtnText = {
    ID = "LotteryResetBtnText",
    CN = "LanguageConfig_LotteryResetBtnText_CN|重置{s1}/{s2}"
  },
  LotteryRuleContent = {
    ID = "LotteryRuleContent",
    CN = "LanguageConfig_LotteryRuleContent_CN|1、「柯蕾特的花房」共有三个花圃，开启时间如下：\n·「鸢尾花圃」： 7 月 15 日 9 时开启。\n·「桔梗花圃」： 7 月 17 日 9 时开启。\n·「蔷薇花圃」： 7 月 19 日 9 时开启。\n2、每次交换将消耗 1000「惆怅的诗文」/「遗憾的诗文」/「欢欣的诗文」，随机获得花圃中的五个物品奖励。\n3、每个花圃的物品奖励分为「特殊物品」和「普通物品」两种，重置时可以使特殊物品奖励的剩余数量重置至上限，具体规则为：\n（1）前2次重置：当「特殊物品」无剩余数量后，守密人可以选择重置，重置后会将「特殊物品」和「普通物品」的剩余数量重置至上限；也可以选择继续交换，当「普通物品」也无剩余数量后，须进行重置才可以继续交换。\n（2）第3次开始重置：当「普通物品」无剩余数量后才可以进行重置，重置会将「普通物品」的剩余数量重置至上限，「特殊物品」不再重置。\n4、8 月 5 日 9:00（GMT+8）后，剩余未交换的「诗文」将按照每200个兑换「蔷薇金券*5000」的比例进行回收，请守密人注意查收邮件。"
  },
  LotteryDrawBtnText = {
    ID = "LotteryDrawBtnText",
    CN = "LanguageConfig_LotteryDrawBtnText_CN|诗文交换"
  },
  BonusCardTipsTitle = {
    ID = "BonusCardTipsTitle",
    CN = "LanguageConfig_BonusCardTipsTitle_CN|强欲加成说明"
  },
  BonusCardTipsContent = {
    ID = "BonusCardTipsContent",
    CN = "LanguageConfig_BonusCardTipsContent_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「紊乱情欲」关卡任务报酬中的「丰穰种核」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「泰旖丝」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「慈悲的哺育」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「灼热的吻别」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「强欲加成」以叠加的方式结算。"
  },
  BonusTips_Activity = {
    ID = "BonusTips_Activity",
    CN = "LanguageConfig_BonusTips_Activity_CN|活动加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleTitle_Activity = {
    ID = "BonusRuleTitle_Activity",
    CN = "LanguageConfig_BonusRuleTitle_Activity_CN|加成说明"
  },
  BonusAffix_Activity = {
    ID = "BonusAffix_Activity",
    CN = "LanguageConfig_BonusAffix_Activity_CN|活动加成"
  },
  BonusTips_MagicStoryActivity = {
    ID = "BonusTips_MagicStoryActivity",
    CN = "LanguageConfig_BonusTips_MagicStoryActivity_CN|获得灵感加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_MagicStoryActivity = {
    ID = "BonusRuleContent_MagicStoryActivity",
    CN = "LanguageConfig_BonusRuleContent_MagicStoryActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「剧本迷思」关卡任务报酬中的「飘零的灵感」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「莉莉」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「跨越疼痛」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「35mm的魔法」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「灵感加成」以叠加的方式结算。"
  },
  BonusAffix_MagicStoryActivity = {
    ID = "BonusAffix_MagicStoryActivity",
    CN = "LanguageConfig_BonusAffix_MagicStoryActivity_CN|灵感加成"
  },
  BonusTips_MiryamActivity = {
    ID = "BonusTips_MiryamActivity",
    CN = "LanguageConfig_BonusTips_MiryamActivity_CN|获得祀物加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_MiryamActivity = {
    ID = "BonusRuleContent_MiryamActivity",
    CN = "LanguageConfig_BonusRuleContent_MiryamActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「神国诞临」关卡任务报酬中的「祀者之泪」、「祀者之血」、「祀者之髓」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「弥利亚姆」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「虔诚的伟力」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「深海的呼唤」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「祀物加成」以叠加的方式结算。"
  },
  BonusAffix_MiryamActivity = {
    ID = "BonusAffix_MiryamActivity",
    CN = "LanguageConfig_BonusAffix_MiryamActivity_CN|祀物加成"
  },
  BonusTips_SorelActivity = {
    ID = "BonusTips_SorelActivity",
    CN = "LanguageConfig_BonusTips_SorelActivity_CN|获得羽扇加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_SorelActivity = {
    ID = "BonusRuleContent_SorelActivity",
    CN = "LanguageConfig_BonusRuleContent_SorelActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「蔷薇忆事」关卡任务报酬中的「通灵鸟羽扇」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「索蕾尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「以蔷薇之名」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「百万蒙宠之眼」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「羽扇加成」以叠加的方式结算。"
  },
  BonusAffix_SorelActivity = {
    ID = "BonusAffix_SorelActivity",
    CN = "LanguageConfig_BonusAffix_SorelActivity_CN|羽扇加成"
  },
  BonusTips_HorlaActivity = {
    ID = "BonusTips_HorlaActivity",
    CN = "LanguageConfig_BonusTips_HorlaActivity_CN|获得诗文加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_HorlaActivity = {
    ID = "BonusRuleContent_HorlaActivity",
    CN = "LanguageConfig_BonusRuleContent_HorlaActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「花园往事」关卡任务报酬中的「惆怅的诗文」、「遗憾的诗文」、「欢欣的诗文」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「奥尔拉」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「诗笺的句尾」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「往昔的花与诗」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「诗文加成」以叠加的方式结算。"
  },
  BonusAffix_HorlaActivity = {
    ID = "BonusAffix_HorlaActivity",
    CN = "LanguageConfig_BonusAffix_HorlaActivity_CN|诗文加成"
  },
  BonusTips_MurphyActivity = {
    ID = "BonusTips_MurphyActivity",
    CN = "LanguageConfig_BonusTips_MurphyActivity_CN|获得胚胎加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_MurphyActivity = {
    ID = "BonusRuleContent_MurphyActivity",
    CN = "LanguageConfig_BonusRuleContent_MurphyActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「黑暗子宫」关卡任务报酬中的「无识之胚」、「无欲之胚」、「无厌之胚」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「墨菲」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「隐秘的诞生」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「冰川下的沉眠」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「胚胎加成」以叠加的方式结算。"
  },
  BonusAffix_MurphyActivity = {
    ID = "BonusAffix_MurphyActivity",
    CN = "LanguageConfig_BonusAffix_MurphyActivity_CN|胚胎加成"
  },
  BonusTips_RykerActivity = {
    ID = "BonusTips_RykerActivity",
    CN = "LanguageConfig_BonusTips_RykerActivity_CN|获得筹码加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_RykerActivity = {
    ID = "BonusRuleContent_RykerActivity",
    CN = "LanguageConfig_BonusRuleContent_RykerActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「月夜传说」关卡任务报酬中的「决胜筹码」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「莱克」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「好运时间」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「命运轮盘赌」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「筹码加成」以叠加的方式结算。"
  },
  BonusAffix_RykerActivity = {
    ID = "BonusAffix_RykerActivity",
    CN = "LanguageConfig_BonusAffix_RykerActivity_CN|筹码加成"
  },
  BonusTips_SalvadorActivity = {
    ID = "BonusTips_SalvadorActivity",
    CN = "LanguageConfig_BonusTips_SalvadorActivity_CN|获得义卖券加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_SalvadorActivity = {
    ID = "BonusRuleContent_SalvadorActivity",
    CN = "LanguageConfig_BonusRuleContent_SalvadorActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「圣堂之路」关卡任务报酬中的「义卖券」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「萨尔瓦多」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「神言石板」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「镜中人」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「义卖券加成」以叠加的方式结算。"
  },
  BonusAffix_SalvadorActivity = {
    ID = "BonusAffix_SalvadorActivity",
    CN = "LanguageConfig_BonusAffix_SalvadorActivity_CN|辉光加成"
  },
  BonusTips_A24Activity = {
    ID = "BonusTips_A24Activity",
    CN = "LanguageConfig_BonusTips_A24Activity_CN|获得「记忆拼图」加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_A24Activity = {
    ID = "BonusRuleContent_A24Activity",
    CN = "LanguageConfig_BonusRuleContent_A24Activity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「记忆编码」关卡任务报酬中的「记忆拼图」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「24」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「畸体回噬」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「银鳕鱼的决心」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「理性加成」以叠加的方式结算。"
  },
  BonusAffix_A24Activity = {
    ID = "BonusAffix_A24Activity",
    CN = "LanguageConfig_BonusAffix_A24Activity_CN|理性加成"
  },
  BonusTips_OriginHelotActivity = {
    ID = "BonusTips_OriginHelotActivity",
    CN = "LanguageConfig_BonusTips_OriginHelotActivity_CN|获得花苞加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_OriginHelotActivity = {
    ID = "BonusRuleContent_OriginHelotActivity",
    CN = "LanguageConfig_BonusRuleContent_OriginHelotActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「野兽雄心」关卡任务报酬中的「寒冻花苞」、「银霜花苞」、「日光花苞」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「血链·希洛」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「沉入殷红」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「待到雪山消融」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「花苞加成」以叠加的方式结算。"
  },
  BonusAffix_OriginHelotActivity = {
    ID = "BonusAffix_OriginHelotActivity",
    CN = "LanguageConfig_BonusAffix_OriginHelotActivity_CN|花苞加成"
  },
  BonusTips_HamelnActivity = {
    ID = "BonusTips_HamelnActivity",
    CN = "LanguageConfig_BonusTips_HamelnActivity_CN|获得高亢乐章加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_HamelnActivity = {
    ID = "BonusRuleContent_HamelnActivity",
    CN = "LanguageConfig_BonusRuleContent_HamelnActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「轰鸣之音」关卡任务报酬中的「高亢乐章」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「哈姆林」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「永恒安魂曲」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「永不停歇的演奏」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「乐章加成」以叠加的方式结算。"
  },
  BonusAffix_HamelnActivity = {
    ID = "BonusAffix_HamelnActivity",
    CN = "LanguageConfig_BonusAffix_HamelnActivity_CN|乐章加成"
  },
  BonusTips_TawilActivity = {
    ID = "BonusTips_TawilActivity",
    CN = "LanguageConfig_BonusTips_TawilActivity_CN|获得终末指针加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_TawilActivity = {
    ID = "BonusRuleContent_TawilActivity",
    CN = "LanguageConfig_BonusRuleContent_TawilActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「最终测试」关卡任务报酬中的「终末指针」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「塔薇」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「隐世的转轮」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「真理之门」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「终末指针加成」以叠加的方式结算。"
  },
  BonusAffix_TawilActivity = {
    ID = "BonusAffix_TawilActivity",
    CN = "LanguageConfig_BonusAffix_TawilActivity_CN|终末指针加成"
  },
  BonusTips_WandaActivity = {
    ID = "BonusTips_WandaActivity",
    CN = "LanguageConfig_BonusTips_WandaActivity_CN|获得奇珍加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_WandaActivity = {
    ID = "BonusRuleContent_WandaActivity",
    CN = "LanguageConfig_BonusRuleContent_WandaActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「燃烧的群宴」关卡任务报酬中的「原生胫骨」、「圆叶菊石」、「螺旋遗迹」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「旺达」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「女王的戒律」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「伊萨拉乌的目光」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「奇珍加成」以叠加的方式结算。"
  },
  BonusAffix_WandaActivity = {
    ID = "BonusAffix_WandaActivity",
    CN = "LanguageConfig_BonusAffix_WandaActivity_CN|奇珍加成"
  },
  BonusTips_OriginDollActivity = {
    ID = "BonusTips_OriginDollActivity",
    CN = "LanguageConfig_BonusTips_OriginDollActivity_CN|获得人偶零件加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_OriginDollActivity = {
    ID = "BonusRuleContent_OriginDollActivity",
    CN = "LanguageConfig_BonusRuleContent_OriginDollActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「虚无之门」关卡任务报酬中的「人偶零件」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「熔毁·朵尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「坠入虚无的人偶」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「牧羊人的手杖」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「人偶零件加成」以叠加的方式结算。"
  },
  BonusAffix_OriginDollActivity = {
    ID = "BonusAffix_OriginDollActivity",
    CN = "LanguageConfig_BonusAffix_OriginDollActivity_CN|人偶零件加成"
  },
  BonusTips_TuluActivity = {
    ID = "BonusTips_TuluActivity",
    CN = "LanguageConfig_BonusTips_TuluActivity_CN|获得绪思加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_TuluActivity = {
    ID = "BonusRuleContent_TuluActivity",
    CN = "LanguageConfig_BonusRuleContent_TuluActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「深海凝视」关卡任务报酬中的「惫倦绪思」、「悲愁绪思」、「欢悦绪思」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「图鲁」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「神王的颂歌」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「青石王座」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「绪思加成」以叠加的方式结算。"
  },
  BonusAffix_TuluActivity = {
    ID = "BonusAffix_TuluActivity",
    CN = "LanguageConfig_BonusAffix_TuluActivity_CN|绪思加成"
  },
  BonusTips_ThaisActivity = {
    ID = "BonusTips_ThaisActivity",
    CN = "LanguageConfig_BonusTips_ThaisActivity_CN|强欲加成：<NetworkDelayGreen:{s1}>"
  },
  BonusRuleContent_ThaisActivity = {
    ID = "BonusRuleContent_ThaisActivity",
    CN = "LanguageConfig_BonusRuleContent_ThaisActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「紊乱情欲」关卡任务报酬中的「丰穰种核」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「泰旖丝」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「慈悲的哺育」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「灼热的吻别」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「强欲加成」以叠加的方式结算。"
  },
  BonusAffix_ThaisActivity = {
    ID = "BonusAffix_ThaisActivity",
    CN = "LanguageConfig_BonusAffix_ThaisActivity_CN|强欲加成"
  },
  BonusRuleContent_DaffodilActivity = {
    ID = "BonusRuleContent_DaffodilActivity",
    CN = "LanguageConfig_BonusRuleContent_DaffodilActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「魔女小店」关卡任务报酬中的「苍白野兽头骨」、「幽影野兽头骨」、「殷红野兽头骨」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「达芙黛尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「至为珍贵的藏品」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「魔女宽檐帽」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_ClementineActivity = {
    ID = "BonusRuleContent_ClementineActivity",
    CN = "LanguageConfig_BonusRuleContent_ClementineActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「恐惧愈疗」关卡任务报酬中的「诊断报告」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「克莱门汀」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「隐没的痛楚」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「催眠灵摆」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_StElmosFireActivity = {
    ID = "BonusRuleContent_StElmosFireActivity",
    CN = "LanguageConfig_BonusRuleContent_StElmosFireActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「邃海迷航」关卡任务报酬中的「信号旗」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「克珀珊特」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「圣火中的指引」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「海上领航者」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_CastorActivity = {
    ID = "BonusRuleContent_CastorActivity",
    CN = "LanguageConfig_BonusRuleContent_CastorActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「飞跃青空」关卡任务报酬中的「常识之书」、「数理之书」、「文学之书」获得额外的掉落加成，具体加成如下：\n·唤醒体「卡斯托尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「不可承受的自由」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「孤羽」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_DoresainActivity = {
    ID = "BonusRuleContent_DoresainActivity",
    CN = "LanguageConfig_BonusRuleContent_DoresainActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「噬灵之飨」关卡任务报酬中的「腐坏手骨」获得额外的掉落加成，具体加成如下：\n·唤醒体「杜勒赛因」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「安息之吻」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「珍馐」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_KathiguRaActivity = {
    ID = "BonusRuleContent_KathiguRaActivity",
    CN = "LanguageConfig_BonusRuleContent_KathiguRaActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「烬灭追猎」关卡任务报酬中的「财富之「印」」、「死亡之「印」」、「战争之「印」」获得额外的掉落加成，具体加成如下：\n·唤醒体「凯蒂古拉」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「琥珀色的死亡」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「迫近的太阳」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_PickmanActivity = {
    ID = "BonusRuleContent_PickmanActivity",
    CN = "LanguageConfig_BonusRuleContent_PickmanActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「异界图卷」关卡任务报酬中的「真实之染」、「幻梦之染」、「癫狂之染」获得额外的掉落加成，具体加成如下：\n·唤醒体「皮克曼」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「写实主义悖谬」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「渴求的画笔」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_PolluxActivity = {
    ID = "BonusRuleContent_PolluxActivity",
    CN = "LanguageConfig_BonusRuleContent_PolluxActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「极昼的终夜」关卡任务报酬中的「觐见奉礼」、「忏悔奉礼」、「忠诚奉礼」获得额外的掉落加成，具体加成如下：\n·唤醒体「波吕克斯」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「扭曲的骑士诗」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「圣子尊容」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_Summer2Activity = {
    ID = "BonusRuleContent_Summer2Activity",
    CN = "LanguageConfig_BonusRuleContent_Summer2Activity_CN|1、守密人解锁「假日纪行」中的「高级纪行」，可在「日光下新事」关卡任务报酬中获得额外100%的「海滨特产贝壳」掉落（包括重现）。\n2、特别的，癫狂难度首通挑战奖励不会受到「活动加成」影响。"
  },
  BonusRuleContent_OriginMurphyActivity = {
    ID = "BonusRuleContent_OriginMurphyActivity",
    CN = "LanguageConfig_BonusRuleContent_OriginMurphyActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「创生七日」关卡任务报酬中的「安神香薰」、「驱魇香薰」、「捕梦香薰」获得额外的掉落加成，具体加成如下：\n·唤醒体「诞妄·墨菲」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「黑暗中的安眠」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「蓝环毒素」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_MouchetteActivity = {
    ID = "BonusRuleContent_MouchetteActivity",
    CN = "LanguageConfig_BonusRuleContent_MouchetteActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「迷失的自我」关卡任务报酬中的「迷雾之视」、「迷雾之梦」、「迷雾之源」获得额外的掉落加成，具体加成如下：\n·唤醒体「茉夏」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「狂戮至世界尽头」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「理智明灯」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_XuActivity = {
    ID = "BonusRuleContent_XuActivity",
    CN = "LanguageConfig_BonusRuleContent_XuActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「玄女无相」关卡任务报酬中的「梨膏糖」获得额外的掉落加成，具体加成如下：\n·唤醒体「徐」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「枉蹙眉」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「玉兰之饵」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_MoskActivity = {
    ID = "BonusRuleContent_MoskActivity",
    CN = "LanguageConfig_BonusRuleContent_MoskActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「莫丝与海」关卡任务报酬中的「海螺一号」、「海螺二号」、「海螺三号」获得额外的掉落加成，具体加成如下：\n·唤醒体「莫丝」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「渺远的伊甸园」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「被囚禁的疯狂」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_ArachneActivity = {
    ID = "BonusRuleContent_ArachneActivity",
    CN = "LanguageConfig_BonusRuleContent_ArachneActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「木偶的舞台」关卡任务报酬中的「丝绒座票根」获得额外的掉落加成，具体加成如下：\n·唤醒体「阿拉克涅」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「永世编织之网」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「宿命纺轮」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_SayaActivity = {
    ID = "BonusRuleContent_SayaActivity",
    CN = "LanguageConfig_BonusRuleContent_SayaActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「暗室手记」关卡任务报酬中的「纯白鳞粉」、「红色鳞粉」、「耀光鳞粉」获得额外的掉落加成，具体加成如下：\n·唤醒体「沙耶」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「愿世界化作芬芳」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「淤泥里的童话」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_PontosActivity = {
    ID = "BonusRuleContent_PontosActivity",
    CN = "LanguageConfig_BonusRuleContent_PontosActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「高屋巡猎」关卡任务报酬中的「新鲜的「猎物」」「硕大的「猎物」」「古老的「猎物」」获得额外的掉落加成，具体加成如下：\n·唤醒体「庞托斯」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「活囚笼」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「指向歧路的罗盘」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_LotanCetarchon = {
    ID = "BonusRuleContent_LotanCetarchon",
    CN = "LanguageConfig_BonusRuleContent_LotanCetarchon_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「贪戮角逐」关卡任务报酬中的「血色祭品」获得额外的掉落加成，具体加成如下：\n·唤醒体「蚀灭·萝坦」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「天之陨」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「不灭的饥骨」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_CarabooActivity = {
    ID = "BonusRuleContent_CarabooActivity",
    CN = "LanguageConfig_BonusRuleContent_CarabooActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「乌摩钵蒂的宝物」关卡任务报酬中的「红苹果」「金苹果」「糖苹果」获得额外的掉落加成，具体加成如下：\n·唤醒体「卡拉布」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「蜜果的谎言」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「恬美真相」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_TaisuiActivity = {
    ID = "BonusRuleContent_TaisuiActivity",
    CN = "LanguageConfig_BonusRuleContent_TaisuiActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「临时文本」关卡任务报酬中的「临时文本」获得额外的掉落加成，具体加成如下：\n·唤醒体「太岁」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  BonusRuleContent_GenesisTinctActivity = {
    ID = "BonusRuleContent_GenesisTinctActivity",
    CN = "LanguageConfig_BonusRuleContent_GenesisTinctActivity_CN|1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「临时文本」关卡任务报酬中的「临时文本」、「临时文本」、「临时文本」获得额外的掉落加成，具体加成如下：\n·唤醒体「暮星·汀克特」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  Card_Select_Get_Tips_ShiWen = {
    ID = "Card_Select_Get_Tips_ShiWen",
    CN = "LanguageConfig_Card_Select_Get_Tips_ShiWen_CN|选择释放效果"
  },
  Card_Select_Get_Tips_waiyu = {
    ID = "Card_Select_Get_Tips_waiyu",
    CN = "LanguageConfig_Card_Select_Get_Tips_waiyu_CN|选择「兴奋」或「诅咒」"
  },
  Card_Select_Get_Tips_mofei = {
    ID = "Card_Select_Get_Tips_mofei",
    CN = "LanguageConfig_Card_Select_Get_Tips_mofei_CN|选择「算力」或「抽牌」"
  },
  CutClass_Btn_Normal = {
    ID = "CutClass_Btn_Normal",
    CN = "LanguageConfig_CutClass_Btn_Normal_CN|外勤代理"
  },
  CutClass_Btn_Finish = {
    ID = "CutClass_Btn_Finish",
    CN = "LanguageConfig_CutClass_Btn_Finish_CN|今日已代理"
  },
  CutClass_Btn_NoRecord = {
    ID = "CutClass_Btn_NoRecord",
    CN = "LanguageConfig_CutClass_Btn_NoRecord_CN|暂无法代理"
  },
  LotteryPhoneticDialogue1 = {
    ID = "LotteryPhoneticDialogue1",
    CN = "LanguageConfig_LotteryPhoneticDialogue1_CN|感谢你的爱心，亲爱的。"
  },
  LotteryPhoneticDialogue2 = {
    ID = "LotteryPhoneticDialogue2",
    CN = "LanguageConfig_LotteryPhoneticDialogue2_CN|哎呀，这可真是不错的运气！拿好了哦。"
  },
  LotteryPhoneticDialogue3 = {
    ID = "LotteryPhoneticDialogue3",
    CN = "LanguageConfig_LotteryPhoneticDialogue3_CN|你这可算捡到宝了，年轻人，我这店铺里的东西可都是上古遗物啊！"
  },
  LotteryPhoneticDialogue4 = {
    ID = "LotteryPhoneticDialogue4",
    CN = "LanguageConfig_LotteryPhoneticDialogue4_CN|竟然被这么强大的魔法选中了，难道你是传说中的天选之子吗？"
  },
  LotteryPhoneticDialogue5 = {
    ID = "LotteryPhoneticDialogue5",
    CN = "LanguageConfig_LotteryPhoneticDialogue5_CN|嗯？啊，拿走吧。感谢你的爱心之类的。"
  },
  LotteryPhoneticDialogue6 = {
    ID = "LotteryPhoneticDialogue6",
    CN = "LanguageConfig_LotteryPhoneticDialogue6_CN|哦，运气不错嘛。不像隔壁大约翰，我的东西都是讲究实际效果的。希望它能对你有用。"
  },
  LotteryPhoneticDialogue7 = {
    ID = "LotteryPhoneticDialogue7",
    CN = "LanguageConfig_LotteryPhoneticDialogue7_CN|将你最深重的欲望表露于我……我将予你渴求之物。"
  },
  LotteryPhoneticDialogue8 = {
    ID = "LotteryPhoneticDialogue8",
    CN = "LanguageConfig_LotteryPhoneticDialogue8_CN|我能感受到你的不满足……那就期盼我、索求我吧。"
  },
  LotteryPhoneticDialogue9 = {
    ID = "LotteryPhoneticDialogue9",
    CN = "LanguageConfig_LotteryPhoneticDialogue9_CN|静静聆听吧。这清脆的声响，便是神国对你的回应。"
  },
  LotteryPhoneticDialogue10 = {
    ID = "LotteryPhoneticDialogue10",
    CN = "LanguageConfig_LotteryPhoneticDialogue10_CN|再虔诚一些，再献祭一些……神国在注视你的祝祷，它终有一天会回应你。"
  },
  LotteryPhoneticDialogue11 = {
    ID = "LotteryPhoneticDialogue11",
    CN = "LanguageConfig_LotteryPhoneticDialogue11_CN|即使是最平凡的人，也能被这些诗句打动……这朵花为你而绽放！"
  },
  LotteryPhoneticDialogue12 = {
    ID = "LotteryPhoneticDialogue12",
    CN = "LanguageConfig_LotteryPhoneticDialogue12_CN|诗有自己的情绪，就像花有自己的花语。这是献给你的。"
  },
  LotteryPhoneticDialogue13 = {
    ID = "LotteryPhoneticDialogue13",
    CN = "LanguageConfig_LotteryPhoneticDialogue13_CN|请注视吧，我将永远战斗。"
  },
  LotteryPhoneticDialogue14 = {
    ID = "LotteryPhoneticDialogue14",
    CN = "LanguageConfig_LotteryPhoneticDialogue14_CN|你是来见证我的凯旋的吗？"
  },
  LotteryPhoneticDialogue15 = {
    ID = "LotteryPhoneticDialogue15",
    CN = "LanguageConfig_LotteryPhoneticDialogue15_CN|努力吧，挣扎吧，好孩子，想要老师摸摸头吗？"
  },
  LotteryPhoneticDialogue16 = {
    ID = "LotteryPhoneticDialogue16",
    CN = "LanguageConfig_LotteryPhoneticDialogue16_CN|靠这些破烂，你又能拯救什么？"
  },
  LotteryPhoneticDialogue17 = {
    ID = "LotteryPhoneticDialogue17",
    CN = "LanguageConfig_LotteryPhoneticDialogue17_CN|哎呀，客人的手气很好呢，要不要再试一次？"
  },
  LotteryPhoneticDialogue18 = {
    ID = "LotteryPhoneticDialogue18",
    CN = "LanguageConfig_LotteryPhoneticDialogue18_CN|要再看看吗？小店还有更珍贵的货品哦。"
  },
  LotteryPhoneticDialogue19 = {
    ID = "LotteryPhoneticDialogue19",
    CN = "LanguageConfig_LotteryPhoneticDialogue19_CN|这份报告非常美味，多谢款待。"
  },
  LotteryPhoneticDialogue20 = {
    ID = "LotteryPhoneticDialogue20",
    CN = "LanguageConfig_LotteryPhoneticDialogue20_CN|嗯，我收下了。还有其他的么？"
  },
  LotteryPhoneticDialogue21 = {
    ID = "LotteryPhoneticDialogue21",
    CN = "LanguageConfig_LotteryPhoneticDialogue21_CN|谢谢你的礼物，还请收下这些。"
  },
  LotteryPhoneticDialogue22 = {
    ID = "LotteryPhoneticDialogue22",
    CN = "LanguageConfig_LotteryPhoneticDialogue22_CN|我找到了些珍贵的材料，希望对你有些帮助。"
  },
  LotteryPhoneticDialogue23 = {
    ID = "LotteryPhoneticDialogue23",
    CN = "LanguageConfig_LotteryPhoneticDialogue23_CN|一份简单的前菜，祝您用餐愉快。"
  },
  LotteryPhoneticDialogue24 = {
    ID = "LotteryPhoneticDialogue24",
    CN = "LanguageConfig_LotteryPhoneticDialogue24_CN|由圣主亲制的主菜，还合您的胃口吗，客人？"
  },
  LotteryPhoneticDialogue25 = {
    ID = "LotteryPhoneticDialogue25",
    CN = "LanguageConfig_LotteryPhoneticDialogue25_CN|别太在意技法与规则。"
  },
  LotteryPhoneticDialogue26 = {
    ID = "LotteryPhoneticDialogue26",
    CN = "LanguageConfig_LotteryPhoneticDialogue26_CN|理性只教你描摹，疯狂才能让你创造。"
  },
  LotteryPhoneticDialogue27 = {
    ID = "LotteryPhoneticDialogue27",
    CN = "LanguageConfig_LotteryPhoneticDialogue27_CN|世人畏惧疯狂，是因他们未曾见过真实。"
  },
  LotteryPhoneticDialogue28 = {
    ID = "LotteryPhoneticDialogue28",
    CN = "LanguageConfig_LotteryPhoneticDialogue28_CN|你看到了吗？真实的世界！"
  },
  LotteryPhoneticDialogue29 = {
    ID = "LotteryPhoneticDialogue29",
    CN = "LanguageConfig_LotteryPhoneticDialogue29_CN|我看到了真实的色彩，多么美妙。"
  },
  LotteryPhoneticDialogue30 = {
    ID = "LotteryPhoneticDialogue30",
    CN = "LanguageConfig_LotteryPhoneticDialogue30_CN|疯狂和荒诞，才是真实之美，艺术之美！"
  },
  LotteryPhoneticDialogue31 = {
    ID = "LotteryPhoneticDialogue31",
    CN = "LanguageConfig_LotteryPhoneticDialogue31_CN|黑色，黑色仍然在这里，继续洗刷你的罪孽吧。"
  },
  LotteryPhoneticDialogue32 = {
    ID = "LotteryPhoneticDialogue32",
    CN = "LanguageConfig_LotteryPhoneticDialogue32_CN|多么美丽，我看见了你纯净的灵魂……"
  },
  LotteryPhoneticDialogue33 = {
    ID = "LotteryPhoneticDialogue33",
    CN = "LanguageConfig_LotteryPhoneticDialogue33_CN|喂，守密人！就算当时的事再重来一次，你也会救我的对吧？\n……那我就能安心睡个好觉了。谢、咳，我是说，谢谢。"
  },
  LotteryPhoneticDialogue34 = {
    ID = "LotteryPhoneticDialogue34",
    CN = "LanguageConfig_LotteryPhoneticDialogue34_CN|最近一直梦到以前的事情，烦死了，这东西最好是有点用。"
  },
  LotteryPhoneticDialogue35 = {
    ID = "LotteryPhoneticDialogue35",
    CN = "LanguageConfig_LotteryPhoneticDialogue35_CN|神母为神国做出了崇高的牺牲，我们愿用一切换取她的安宁。"
  },
  LotteryPhoneticDialogue36 = {
    ID = "LotteryPhoneticDialogue36",
    CN = "LanguageConfig_LotteryPhoneticDialogue36_CN|多谢您对神母的进奉，希望这能为她带来一夜好眠。"
  },
  LotteryPhoneticDialogue37 = {
    ID = "LotteryPhoneticDialogue37",
    CN = "LanguageConfig_LotteryPhoneticDialogue37_CN|这场梦会永不休止地循环下去，而你……\n庆幸吧，我将恩准你加入其中。"
  },
  LotteryPhoneticDialogue38 = {
    ID = "LotteryPhoneticDialogue38",
    CN = "LanguageConfig_LotteryPhoneticDialogue38_CN|你见过我的梦是什么样的吗？那种不洁且污秽到极致的场面……"
  },
  LotteryPhoneticDialogue39 = {
    ID = "LotteryPhoneticDialogue39",
    CN = "LanguageConfig_LotteryPhoneticDialogue39_CN|身外之物何其冗余，您若有什么愿望，不妨直接向妾身诉说……"
  },
  LotteryPhoneticDialogue40 = {
    ID = "LotteryPhoneticDialogue40",
    CN = "LanguageConfig_LotteryPhoneticDialogue40_CN|您若身处远东的荒旧废墟，切记万万不可胡乱祭奉——妖鬼野狐？嘻……那些可不值一提呢。"
  },
  LotteryPhoneticDialogue41 = {
    ID = "LotteryPhoneticDialogue41",
    CN = "LanguageConfig_LotteryPhoneticDialogue41_CN|小煤球，最棒！"
  },
  LotteryPhoneticDialogue42 = {
    ID = "LotteryPhoneticDialogue42",
    CN = "LanguageConfig_LotteryPhoneticDialogue42_CN|小煤球，厉害！"
  },
  LotteryPhoneticDialogue43 = {
    ID = "LotteryPhoneticDialogue43",
    CN = "LanguageConfig_LotteryPhoneticDialogue43_CN|亮晶晶！送给，小煤球！"
  },
  LotteryPhoneticDialogue44 = {
    ID = "LotteryPhoneticDialogue44",
    CN = "LanguageConfig_LotteryPhoneticDialogue44_CN|朋友，喜欢！莫丝，小煤球，交换！"
  },
  LotteryPhoneticDialogue45 = {
    ID = "LotteryPhoneticDialogue45",
    CN = "LanguageConfig_LotteryPhoneticDialogue45_CN|海螺，好漂亮！莫丝，收藏！小煤球，奖励！"
  },
  LotteryPhoneticDialogue46 = {
    ID = "LotteryPhoneticDialogue46",
    CN = "LanguageConfig_LotteryPhoneticDialogue46_CN|莫丝，喜欢！谢谢，小煤球！"
  },
  LotteryPhoneticDialogue47 = {
    ID = "LotteryPhoneticDialogue47",
    CN = "LanguageConfig_LotteryPhoneticDialogue47_CN|没错……被命运遗弃的人啊，打破它的囚笼吧！"
  },
  LotteryPhoneticDialogue48 = {
    ID = "LotteryPhoneticDialogue48",
    CN = "LanguageConfig_LotteryPhoneticDialogue48_CN|呵，命运的一个小小玩笑。"
  },
  LotteryPhoneticDialogue49 = {
    ID = "LotteryPhoneticDialogue49",
    CN = "LanguageConfig_LotteryPhoneticDialogue49_CN|繁殖、成长，这些都和爱息息相关。"
  },
  LotteryPhoneticDialogue50 = {
    ID = "LotteryPhoneticDialogue50",
    CN = "LanguageConfig_LotteryPhoneticDialogue50_CN|在我孤身到达那个世界的时候，有个人教会了我很多、很多知识，直到今天也一直努力学习着。"
  },
  LotteryPhoneticDialogue51 = {
    ID = "LotteryPhoneticDialogue51",
    CN = "LanguageConfig_LotteryPhoneticDialogue51_CN|你曾被什么人无所保留地爱过，或者抛却一切地爱过什么人吗？\n我觉得那是一件非常美好的事。"
  },
  LotteryPhoneticDialogue52 = {
    ID = "LotteryPhoneticDialogue52",
    CN = "LanguageConfig_LotteryPhoneticDialogue52_CN|人类的恋爱、不，生物的恋爱，真是奇妙啊。\n比自己还要重要的存在，比一切都要重要的存在。"
  },
  LotteryPhoneticDialogue53 = {
    ID = "LotteryPhoneticDialogue53",
    CN = "LanguageConfig_LotteryPhoneticDialogue53_CN|请和我一起等待吧，那个闪耀的、光辉的、美丽的世界的开始。"
  },
  LotteryPhoneticDialogue54 = {
    ID = "LotteryPhoneticDialogue54",
    CN = "LanguageConfig_LotteryPhoneticDialogue54_CN|谢谢你的礼物，它应该会带来一些新发现。"
  },
  LotteryPhoneticDialogue55 = {
    ID = "LotteryPhoneticDialogue55",
    CN = "LanguageConfig_LotteryPhoneticDialogue55_CN|嘶……真的假的？中大彩了？！"
  },
  LotteryPhoneticDialogue56 = {
    ID = "LotteryPhoneticDialogue56",
    CN = "LanguageConfig_LotteryPhoneticDialogue56_CN|这种小丫头的话你也信？"
  },
  LotteryPhoneticDialogue57 = {
    ID = "LotteryPhoneticDialogue57",
    CN = "LanguageConfig_LotteryPhoneticDialogue57_CN|太好了！不，我想找的东西并不在这里……但我很为大家的收获开心。"
  },
  LotteryPhoneticDialogue58 = {
    ID = "LotteryPhoneticDialogue58",
    CN = "LanguageConfig_LotteryPhoneticDialogue58_CN|我……相信大家，一定都能实现自己的愿望。"
  },
  LotteryPhoneticDialogue59 = {
    ID = "LotteryPhoneticDialogue59",
    CN = "LanguageConfig_LotteryPhoneticDialogue59_CN|嘻嘻，来领受吧，不要逃跑哦，好好享受真正的、仙女的赐福~"
  },
  LotteryPhoneticDialogue60 = {
    ID = "LotteryPhoneticDialogue60",
    CN = "LanguageConfig_LotteryPhoneticDialogue60_CN|还差一点，就差一点点啦，再来一次~"
  },
  LotteryPhoneticDialogue61 = {
    ID = "LotteryPhoneticDialogue61",
    CN = "LanguageConfig_LotteryPhoneticDialogue61_CN|临时文本"
  },
  LotteryPhoneticDialogue62 = {
    ID = "LotteryPhoneticDialogue62",
    CN = "LanguageConfig_LotteryPhoneticDialogue62_CN|临时文本"
  },
  LotteryPhoneticDialogue63 = {
    ID = "LotteryPhoneticDialogue63",
    CN = "LanguageConfig_LotteryPhoneticDialogue63_CN|临时文本"
  },
  LotteryPhoneticDialogue64 = {
    ID = "LotteryPhoneticDialogue64",
    CN = "LanguageConfig_LotteryPhoneticDialogue64_CN|临时文本"
  },
  LotteryPhoneticDialogue65 = {
    ID = "LotteryPhoneticDialogue65",
    CN = "LanguageConfig_LotteryPhoneticDialogue65_CN|临时文本"
  },
  LotteryPhoneticDialogue66 = {
    ID = "LotteryPhoneticDialogue66",
    CN = "LanguageConfig_LotteryPhoneticDialogue66_CN|临时文本"
  },
  LotteryCoreRewardLabel = {
    ID = "LotteryCoreRewardLabel",
    CN = "LanguageConfig_LotteryCoreRewardLabel_CN|特殊"
  },
  Monster_RMQ_SideDia1 = {
    ID = "Monster_RMQ_SideDia1",
    CN = "LanguageConfig_Monster_RMQ_SideDia1_CN|持灯者与我同在！"
  },
  Monster_RMQ_SideDia2 = {
    ID = "Monster_RMQ_SideDia2",
    CN = "LanguageConfig_Monster_RMQ_SideDia2_CN|由我撕裂不净之徒！"
  },
  Monster_RMQ_SideDia3 = {
    ID = "Monster_RMQ_SideDia3",
    CN = "LanguageConfig_Monster_RMQ_SideDia3_CN|注意！在本回合打出卡牌后会强化怪物的技能，每打出 1 张卡牌都会切换其强化效果。"
  },
  Monster_RMQ_SideDia4 = {
    ID = "Monster_RMQ_SideDia4",
    CN = "LanguageConfig_Monster_RMQ_SideDia4_CN|我将…跨越新的世界…"
  },
  BoutBloodSkillMaxTimesTips = {
    ID = "BoutBloodSkillMaxTimesTips",
    CN = "LanguageConfig_BoutBloodSkillMaxTimesTips_CN|本回合猩红熔炉不可再次使用"
  },
  LotteryCoreRewardResetTimes = {
    ID = "LotteryCoreRewardResetTimes",
    CN = "LanguageConfig_LotteryCoreRewardResetTimes_CN|特殊物品剩余重置:{s1}"
  },
  SalvadorStageUnlockDesc = {
    ID = "SalvadorStageUnlockDesc",
    CN = "LanguageConfig_SalvadorStageUnlockDesc_CN|完成特遣纪录前置关卡解锁"
  },
  Card_Select_Get_Tips_GLY1 = {
    ID = "Card_Select_Get_Tips_GLY1",
    CN = "LanguageConfig_Card_Select_Get_Tips_GLY1_CN|选择释放效果"
  },
  TeamAssistAwakerStepDown = {
    ID = "TeamAssistAwakerStepDown",
    CN = "LanguageConfig_TeamAssistAwakerStepDown_CN|助战唤醒体已下阵"
  },
  TeamNeedFightAwakerTips = {
    ID = "TeamNeedFightAwakerTips",
    CN = "LanguageConfig_TeamNeedFightAwakerTips_CN|本次调查{s1}必须上阵"
  },
  TalentActivationConditionPrompt = {
    ID = "TalentActivationConditionPrompt",
    CN = "LanguageConfig_TalentActivationConditionPrompt_CN|需要满足激活条件"
  },
  TalentUpgradeConditionPrompt = {
    ID = "TalentUpgradeConditionPrompt",
    CN = "LanguageConfig_TalentUpgradeConditionPrompt_CN|需要满足升级条件"
  },
  TalentUpgradeInsufficientMaterial = {
    ID = "TalentUpgradeInsufficientMaterial",
    CN = "LanguageConfig_TalentUpgradeInsufficientMaterial_CN|消耗材料不足"
  },
  ShopName_ActivityShop2 = {
    ID = "ShopName_ActivityShop2",
    CN = "LanguageConfig_ShopName_ActivityShop2_CN|人格解析"
  },
  ShopName_ActivityShop3 = {
    ID = "ShopName_ActivityShop3",
    CN = "LanguageConfig_ShopName_ActivityShop3_CN|魔法剧本商店"
  },
  ShopName_ActivityShop4 = {
    ID = "ShopName_ActivityShop4",
    CN = "LanguageConfig_ShopName_ActivityShop4_CN|金红庆典"
  },
  ShopName_ActivityShop5 = {
    ID = "ShopName_ActivityShop5",
    CN = "LanguageConfig_ShopName_ActivityShop5_CN|圣胎孵化"
  },
  ShopName_ActivityShop6 = {
    ID = "ShopName_ActivityShop6",
    CN = "LanguageConfig_ShopName_ActivityShop6_CN|好运俱乐部"
  },
  ShopName_ActivityShop7 = {
    ID = "ShopName_ActivityShop7",
    CN = "LanguageConfig_ShopName_ActivityShop7_CN|安眠宫殿"
  },
  ShopName_ActivityShop8 = {
    ID = "ShopName_ActivityShop8",
    CN = "LanguageConfig_ShopName_ActivityShop8_CN|人格解析"
  },
  ShopName_ActivityShop9 = {
    ID = "ShopName_ActivityShop9",
    CN = "LanguageConfig_ShopName_ActivityShop9_CN|旺达的奇珍宝匣"
  },
  ShopName_ActivityShop10 = {
    ID = "ShopName_ActivityShop10",
    CN = "LanguageConfig_ShopName_ActivityShop10_CN|回声"
  },
  ShopName_ActivityShop11 = {
    ID = "ShopName_ActivityShop11",
    CN = "LanguageConfig_ShopName_ActivityShop11_CN|觉知海渊"
  },
  ShopName_ActivityShop12 = {
    ID = "ShopName_ActivityShop12",
    CN = "LanguageConfig_ShopName_ActivityShop12_CN|求知的愿望"
  },
  ShopName_ActivityShop13 = {
    ID = "ShopName_ActivityShop13",
    CN = "LanguageConfig_ShopName_ActivityShop13_CN|敬献贡礼"
  },
  ShopName_ActivityShop15 = {
    ID = "ShopName_ActivityShop15",
    CN = "LanguageConfig_ShopName_ActivityShop15_CN|学生会办公楼"
  },
  ShopName_ActivityShop16 = {
    ID = "ShopName_ActivityShop16",
    CN = "LanguageConfig_ShopName_ActivityShop16_CN|隐秘的据点"
  },
  ShopName_ActivityShop17 = {
    ID = "ShopName_ActivityShop17",
    CN = "LanguageConfig_ShopName_ActivityShop17_CN|茉夏的小屋"
  },
  ShopName_ActivityShop18 = {
    ID = "ShopName_ActivityShop18",
    CN = "LanguageConfig_ShopName_ActivityShop18_CN|无边猎场"
  },
  ShopName_ActivityShop19 = {
    ID = "ShopName_ActivityShop19",
    CN = "LanguageConfig_ShopName_ActivityShop19_CN|斗兽场祭祀台"
  },
  ShopName_ActivityShop20 = {
    ID = "ShopName_ActivityShop20",
    CN = "LanguageConfig_ShopName_ActivityShop20_CN|临时文本"
  },
  ShopName_ReturnCoinShop = {
    ID = "ShopName_ReturnCoinShop",
    CN = "LanguageConfig_ShopName_ReturnCoinShop_CN|返校商店"
  },
  ShopNameDefault = {
    ID = "ShopNameDefault",
    CN = "LanguageConfig_ShopNameDefault_CN|弥萨格商店"
  },
  ActivityIsEnd = {
    ID = "ActivityIsEnd",
    CN = "LanguageConfig_ActivityIsEnd_CN|活动已结束"
  },
  ActivityShopIsEnd_1 = {
    ID = "ActivityShopIsEnd_1",
    CN = "LanguageConfig_ActivityShopIsEnd_1_CN|{s1}天{s2}小时后截止兑换"
  },
  ActivityShopIsEnd_2 = {
    ID = "ActivityShopIsEnd_2",
    CN = "LanguageConfig_ActivityShopIsEnd_2_CN|{s1}小时{s2}分钟后截止兑换"
  },
  TalentActivationConditions = {
    ID = "TalentActivationConditions",
    CN = "LanguageConfig_TalentActivationConditions_CN|激活条件"
  },
  TalentUpgradeConditions = {
    ID = "TalentUpgradeConditions",
    CN = "LanguageConfig_TalentUpgradeConditions_CN|升级条件"
  },
  ChaosSchool_RelicTips = {
    ID = "ChaosSchool_RelicTips",
    CN = "LanguageConfig_ChaosSchool_RelicTips_CN|选择获得造物"
  },
  DispatchOneClickFormation = {
    ID = "DispatchOneClickFormation",
    CN = "LanguageConfig_DispatchOneClickFormation_CN|快捷上阵"
  },
  DispatchClear = {
    ID = "DispatchClear",
    CN = "LanguageConfig_DispatchClear_CN|清空"
  },
  DispatchClose = {
    ID = "DispatchClose",
    CN = "LanguageConfig_DispatchClose_CN|关闭"
  },
  DispatchAgain = {
    ID = "DispatchAgain",
    CN = "LanguageConfig_DispatchAgain_CN|再次派遣"
  },
  DispatchReceiveAll = {
    ID = "DispatchReceiveAll",
    CN = "LanguageConfig_DispatchReceiveAll_CN|一键领取"
  },
  DispatchNormal = {
    ID = "DispatchNormal",
    CN = "LanguageConfig_DispatchNormal_CN|派遣"
  },
  DispatchNoReceiveTask = {
    ID = "DispatchNoReceiveTask",
    CN = "LanguageConfig_DispatchNoReceiveTask_CN|暂无已完成的派遣任务"
  },
  BpRewardSourceName = {
    ID = "BpRewardSourceName",
    CN = "LanguageConfig_BpRewardSourceName_CN|核心课题"
  },
  CopySettleTitle = {
    ID = "CopySettleTitle",
    CN = "LanguageConfig_CopySettleTitle_CN|调查数据"
  },
  CopySettleTeamDataRound = {
    ID = "CopySettleTeamDataRound",
    CN = "LanguageConfig_CopySettleTeamDataRound_CN|最终战回合数"
  },
  CopySettleTeamDataBlood = {
    ID = "CopySettleTeamDataBlood",
    CN = "LanguageConfig_CopySettleTeamDataBlood_CN|调查最后剩余血量"
  },
  CopySettleTeamDataResist = {
    ID = "CopySettleTeamDataResist",
    CN = "LanguageConfig_CopySettleTeamDataResist_CN|死亡抵抗触发次数"
  },
  CopySettleTeamDataRevival = {
    ID = "CopySettleTeamDataRevival",
    CN = "LanguageConfig_CopySettleTeamDataRevival_CN|应急灵知体使用次数"
  },
  CopySettleNoData = {
    ID = "CopySettleNoData",
    CN = "LanguageConfig_CopySettleNoData_CN|暂未更新数据"
  },
  CopySettleUncleared = {
    ID = "CopySettleUncleared",
    CN = "LanguageConfig_CopySettleUncleared_CN|未通关"
  },
  InviteAwaker = {
    ID = "InviteAwaker",
    CN = "LanguageConfig_InviteAwaker_CN|免费唤醒"
  },
  TextAlreadyReceived = {
    ID = "TextAlreadyReceived",
    CN = "LanguageConfig_TextAlreadyReceived_CN|已领取"
  },
  TextAlreadyReceivedAwaker = {
    ID = "TextAlreadyReceivedAwaker",
    CN = "LanguageConfig_TextAlreadyReceivedAwaker_CN|已唤醒：{s1}"
  },
  InviteWeapon = {
    ID = "InviteWeapon",
    CN = "LanguageConfig_InviteWeapon_CN|选择命轮"
  },
  TextAlreadyReceivedWeapon = {
    ID = "TextAlreadyReceivedWeapon",
    CN = "LanguageConfig_TextAlreadyReceivedWeapon_CN|已领取：{s1}"
  },
  FavorabilityUnlockCondition_1 = {
    ID = "FavorabilityUnlockCondition_1",
    CN = "LanguageConfig_FavorabilityUnlockCondition_1_CN|{s1}同调率达到{s2}级可解锁"
  },
  FavorabilityUnlockCondition_2 = {
    ID = "FavorabilityUnlockCondition_2",
    CN = "LanguageConfig_FavorabilityUnlockCondition_2_CN|<Gray1:{s1}同调率达到{s2}级可解锁>"
  },
  CurrentLevelFavorability_1 = {
    ID = "CurrentLevelFavorability_1",
    CN = "LanguageConfig_CurrentLevelFavorability_1_CN|（当前：{s1}）"
  },
  UnlockConditionExemption = {
    ID = "UnlockConditionExemption",
    CN = "LanguageConfig_UnlockConditionExemption_CN|\n<Gray:（活动期间无视同调率要求）>"
  },
  CurrentLevelFavorability_2 = {
    ID = "CurrentLevelFavorability_2",
    CN = "LanguageConfig_CurrentLevelFavorability_2_CN|<TaskFinish:（当前：{s1}）>"
  },
  ConfessionEventRulesTitle = {
    ID = "ConfessionEventRulesTitle",
    CN = "LanguageConfig_ConfessionEventRulesTitle_CN|规则说明"
  },
  ConfessionEventRulesDesc = {
    ID = "ConfessionEventRulesDesc",
    CN = "LanguageConfig_ConfessionEventRulesDesc_CN|<Title:规则说明>\n1、通关「调查行动」7-3·普通之后，全新特别调查内容「繁衍狂热」开放！\n2、受神秘力量影响，唤醒体们陷入了「繁衍狂热」状态……请各位守密人小心！\n3、当唤醒体的同调率达到 10 级后可以解锁该唤醒体的「繁衍狂热事件」，消耗 「现实起点」× 3 进行解锁，完成后可以获取「无垢之芯」× 1！"
  },
  Text_Enter_Plot = {
    ID = "Text_Enter_Plot",
    CN = "LanguageConfig_Text_Enter_Plot_CN|进入剧情"
  },
  Text_Discount_Unlock = {
    ID = "Text_Discount_Unlock",
    CN = "LanguageConfig_Text_Discount_Unlock_CN|限时优惠解锁"
  },
  Text_Unlock = {
    ID = "Text_Unlock",
    CN = "LanguageConfig_Text_Unlock_CN|解锁"
  },
  ActivityMarkReturn = {
    ID = "ActivityMarkReturn",
    CN = "LanguageConfig_ActivityMarkReturn_CN|回归活动"
  },
  ActivityMarkHalfAYear = {
    ID = "ActivityMarkHalfAYear",
    CN = "LanguageConfig_ActivityMarkHalfAYear_CN|一周年"
  },
  ActivityMarkTwoYears = {
    ID = "ActivityMarkTwoYears",
    CN = "LanguageConfig_ActivityMarkTwoYears_CN|二周年"
  },
  ActivityLoginDays = {
    ID = "ActivityLoginDays",
    CN = "LanguageConfig_ActivityLoginDays_CN|登录{s1}天"
  },
  ActivityMarkMouchetteCrossover = {
    ID = "ActivityMarkMouchetteCrossover",
    CN = "LanguageConfig_ActivityMarkMouchetteCrossover_CN|联动"
  },
  Monster_C704BOSS_SideDia4 = {
    ID = "Monster_C704BOSS_SideDia4",
    CN = "LanguageConfig_Monster_C704BOSS_SideDia4_CN|将士们！准备列阵！"
  },
  Monster_C704BOSS_SideDia1 = {
    ID = "Monster_C704BOSS_SideDia1",
    CN = "LanguageConfig_Monster_C704BOSS_SideDia1_CN|列阵！据守！"
  },
  Monster_C704BOSS_SideDia2 = {
    ID = "Monster_C704BOSS_SideDia2",
    CN = "LanguageConfig_Monster_C704BOSS_SideDia2_CN|列阵！强攻！"
  },
  Monster_C704BOSS_SideDia3 = {
    ID = "Monster_C704BOSS_SideDia3",
    CN = "LanguageConfig_Monster_C704BOSS_SideDia3_CN|你的血肉已还于圣河！"
  },
  Monster_C706BOSS_SideDia1 = {
    ID = "Monster_C706BOSS_SideDia1",
    CN = "LanguageConfig_Monster_C706BOSS_SideDia1_CN|以漫天黄沙…为你送葬……"
  },
  Monster_C706BOSS_SideDia2 = {
    ID = "Monster_C706BOSS_SideDia2",
    CN = "LanguageConfig_Monster_C706BOSS_SideDia2_CN|当心！敌人将号令满天的黄沙，吞噬所有唤醒体的狂气！"
  },
  Monster_C702_SideDia1 = {
    ID = "Monster_C702_SideDia1",
    CN = "LanguageConfig_Monster_C702_SideDia1_CN|「塞尔凯特」将要进行一次强力攻击！击败其他敌人来削弱它！"
  },
  Monster_C702_SideDia2 = {
    ID = "Monster_C702_SideDia2",
    CN = "LanguageConfig_Monster_C702_SideDia2_CN|似乎敌人将要潜入阴影中来保护自己…"
  },
  Monster_C702BOSS_SideDia1 = {
    ID = "Monster_C702BOSS_SideDia1",
    CN = "LanguageConfig_Monster_C702BOSS_SideDia1_CN|「圣河努比亚」将要进行一次强力攻击！击败其他敌人来削弱它！"
  },
  Monster_C702_SideDia3 = {
    ID = "Monster_C702_SideDia3",
    CN = "LanguageConfig_Monster_C702_SideDia3_CN|&&……%暗影）&…袭&…%"
  },
  Monster_C703_SideDia1 = {
    ID = "Monster_C703_SideDia1",
    CN = "LanguageConfig_Monster_C703_SideDia1_CN|&…%…&融为*（）一体&……%"
  },
  Monster_C703_SideDia2 = {
    ID = "Monster_C703_SideDia2",
    CN = "LanguageConfig_Monster_C703_SideDia2_CN|当心！抽到症状或状态卡时，「努比亚」们会获得临时力量！"
  },
  Monster_S0303_AT_BOSSSIZE_SideDia1 = {
    ID = "Monster_S0303_AT_BOSSSIZE_SideDia1",
    CN = "LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia1_CN|当心！敌人的维度之力已经达到了极限！本回合维度锁链会生效 3 次，谨慎发起进攻！"
  },
  Monster_S0303_AT_BOSSSIZE_SideDia3 = {
    ID = "Monster_S0303_AT_BOSSSIZE_SideDia3",
    CN = "LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia3_CN|敌人周身环绕着充满仇恨的维度锁链，会封锁第一名对它发起进攻的唤醒体！"
  },
  Monster_S0303_AT_BOSSSIZE_SideDia2 = {
    ID = "Monster_S0303_AT_BOSSSIZE_SideDia2",
    CN = "LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia2_CN|「以图存续」强化了所有敌人！"
  },
  Monster_C11_SideDia1 = {
    ID = "Monster_C11_SideDia1",
    CN = "LanguageConfig_Monster_C11_SideDia1_CN|我将护佑亚兰！"
  },
  Monster_C11_SideDia2 = {
    ID = "Monster_C11_SideDia2",
    CN = "LanguageConfig_Monster_C11_SideDia2_CN|敌人准备释放心眼利刃！击破护盾来降低伤害！"
  },
  Monster_DCD06_01_SideDia1 = {
    ID = "Monster_DCD06_01_SideDia1",
    CN = "LanguageConfig_Monster_DCD06_01_SideDia1_CN|敌人将会用认知失调覆盖随机 1 名唤醒体的卡牌！"
  },
  Monster_DCD06_01_BOSSSIZE_SideDia1 = {
    ID = "Monster_DCD06_01_BOSSSIZE_SideDia1",
    CN = "LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia1_CN|敌人将会用认知错乱覆盖随机 1 名唤醒体的卡牌！"
  },
  Monster_DCD06_01_BOSSSIZE_SideDia2 = {
    ID = "Monster_DCD06_01_BOSSSIZE_SideDia2",
    CN = "LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia2_CN|让往昔的回忆，都随枯枝消逝。"
  },
  Monster_DCD06_01_BOSSSIZE_SideDia3 = {
    ID = "Monster_DCD06_01_BOSSSIZE_SideDia3",
    CN = "LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia3_CN|沉醉吧，在这如诗般的乐园……"
  },
  Monster_B0007_SideDia1 = {
    ID = "Monster_B0007_SideDia1",
    CN = "LanguageConfig_Monster_B0007_SideDia1_CN|母树吞噬了大量亚兰血肉……"
  },
  Monster_B0007_SideDia2 = {
    ID = "Monster_B0007_SideDia2",
    CN = "LanguageConfig_Monster_B0007_SideDia2_CN|母树树瘤内传来生命的搏动……"
  },
  Monster_B0007_SideDia3 = {
    ID = "Monster_B0007_SideDia3",
    CN = "LanguageConfig_Monster_B0007_SideDia3_CN|祂即源流，祂即丰穰，祂孕育万千子嗣……"
  },
  DeathResist_1 = {
    ID = "DeathResist_1",
    CN = "LanguageConfig_DeathResist_1_CN|死亡抵抗！"
  },
  LuckyTime_1 = {
    ID = "LuckyTime_1",
    CN = "LanguageConfig_LuckyTime_1_CN|好运时间：1"
  },
  LuckyTime_2 = {
    ID = "LuckyTime_2",
    CN = "LanguageConfig_LuckyTime_2_CN|好运时间：2"
  },
  LuckyTime_3 = {
    ID = "LuckyTime_3",
    CN = "LanguageConfig_LuckyTime_3_CN|好运时间：3"
  },
  LuckyTime_4 = {
    ID = "LuckyTime_4",
    CN = "LanguageConfig_LuckyTime_4_CN|好运时间-绝佳好运：4！"
  },
  LuckyTime_5 = {
    ID = "LuckyTime_5",
    CN = "LanguageConfig_LuckyTime_5_CN|好运时间-绝佳好运：5！"
  },
  Monster_O01_SideDia1 = {
    ID = "Monster_O01_SideDia1",
    CN = "LanguageConfig_Monster_O01_SideDia1_CN|zzzZZZZ……"
  },
  Monster_O01_SideDia2 = {
    ID = "Monster_O01_SideDia2",
    CN = "LanguageConfig_Monster_O01_SideDia2_CN|*&…%￥…@…&……zzzzZZZZ……"
  },
  Monster_O01_SideDia3 = {
    ID = "Monster_O01_SideDia3",
    CN = "LanguageConfig_Monster_O01_SideDia3_CN|是谁打扰了我的安眠……！"
  },
  Monster_O01_SideDia4 = {
    ID = "Monster_O01_SideDia4",
    CN = "LanguageConfig_Monster_O01_SideDia4_CN|聒噪之徒…为你的愚行忏悔吧！"
  },
  Monster_O01_SideDia5 = {
    ID = "Monster_O01_SideDia5",
    CN = "LanguageConfig_Monster_O01_SideDia5_CN|打出卡牌或释放狂气爆发会消除图鲁的困意…"
  },
  Monster_O01_SideDia6 = {
    ID = "Monster_O01_SideDia6",
    CN = "LanguageConfig_Monster_O01_SideDia6_CN|3……"
  },
  Monster_O01_SideDia7 = {
    ID = "Monster_O01_SideDia7",
    CN = "LanguageConfig_Monster_O01_SideDia7_CN|2……"
  },
  Monster_O01_SideDia8 = {
    ID = "Monster_O01_SideDia8",
    CN = "LanguageConfig_Monster_O01_SideDia8_CN|1……"
  },
  Monster_Chapter8_01 = {
    ID = "Monster_Chapter8_01",
    CN = "LanguageConfig_Monster_Chapter8_01_CN|回复手段会受到影响，小心敌人的飞刃！"
  },
  Monster_Chapter8_02 = {
    ID = "Monster_Chapter8_02",
    CN = "LanguageConfig_Monster_Chapter8_02_CN|释放钥令会使艾瑞卡的机体状态产生变化。想办法利用它！"
  },
  Monster_Chapter8_03 = {
    ID = "Monster_Chapter8_03",
    CN = "LanguageConfig_Monster_Chapter8_03_CN|接收到不明指令。切换为进攻模式。"
  },
  Monster_Chapter8_04 = {
    ID = "Monster_Chapter8_04",
    CN = "LanguageConfig_Monster_Chapter8_04_CN|接收到不明指令。切换为防御模式。"
  },
  Monster_Chapter8_05 = {
    ID = "Monster_Chapter8_05",
    CN = "LanguageConfig_Monster_Chapter8_05_CN|打出与其意图对应算力的卡牌后会削弱敌人攻击，但也会将卡牌消耗。小心行事！"
  },
  Monster_Chapter8_06 = {
    ID = "Monster_Chapter8_06",
    CN = "LanguageConfig_Monster_Chapter8_06_CN|尽可能阻挡「原初的乐音」，否则敌人将大幅增强自身……！"
  },
  Monster_Chapter8_07 = {
    ID = "Monster_Chapter8_07",
    CN = "LanguageConfig_Monster_Chapter8_07_CN|尝试接下吧…我全心全力的一剑……！"
  },
  Monster_Chapter8_08 = {
    ID = "Monster_Chapter8_08",
    CN = "LanguageConfig_Monster_Chapter8_08_CN|主人答应过……蜕变的我，将永久存续……！"
  },
  Monster_Chapter8_09 = {
    ID = "Monster_Chapter8_09",
    CN = "LanguageConfig_Monster_Chapter8_09_CN|血肉的子嗣啊…成长吧……"
  },
  Monster_Chapter8_10 = {
    ID = "Monster_Chapter8_10",
    CN = "LanguageConfig_Monster_Chapter8_10_CN|小心！敌人即将造成穿刺伤害和高额脆弱，护盾手段会受到影响！"
  },
  Monster_Chapter8_11 = {
    ID = "Monster_Chapter8_11",
    CN = "LanguageConfig_Monster_Chapter8_11_CN|乖乖听话，我的小猫咪。"
  },
  Monster_Chapter8_12 = {
    ID = "Monster_Chapter8_12",
    CN = "LanguageConfig_Monster_Chapter8_12_CN|平静下来，我的孩子。我会带你们，走上正确的道路……"
  },
  Monster_Chapter8_13 = {
    ID = "Monster_Chapter8_13",
    CN = "LanguageConfig_Monster_Chapter8_13_CN|献上你们的掌声吧。演出，迎来高潮！"
  },
  Monster_Chapter8_14 = {
    ID = "Monster_Chapter8_14",
    CN = "LanguageConfig_Monster_Chapter8_14_CN|为了提灯教会……！"
  },
  Monster_Chapter8_15 = {
    ID = "Monster_Chapter8_15",
    CN = "LanguageConfig_Monster_Chapter8_15_CN|提灯将赐予我们光荣的进化！"
  },
  Monster_Chapter8_16 = {
    ID = "Monster_Chapter8_16",
    CN = "LanguageConfig_Monster_Chapter8_16_CN|「N」移动到了分身之后……找到合适机会一举击破吧！"
  },
  Monster_Chapter8_17 = {
    ID = "Monster_Chapter8_17",
    CN = "LanguageConfig_Monster_Chapter8_17_CN|敌人获得了超高额的加固…配合血污灯芯找到机会来终结对手吧！"
  },
  Monster_D08_SideDia1 = {
    ID = "Monster_D08_SideDia1",
    CN = "LanguageConfig_Monster_D08_SideDia1_CN|侦测到敌对人员。电磁炮充能完毕，正在瞄准……"
  },
  Monster_B0008_SideDia1 = {
    ID = "Monster_B0008_SideDia1",
    CN = "LanguageConfig_Monster_B0008_SideDia1_CN|当心矛盾体的融合度！完全融合后，拉蒙娜的意识将陷入危险…"
  },
  Monster_B0008_SideDia2 = {
    ID = "Monster_B0008_SideDia2",
    CN = "LanguageConfig_Monster_B0008_SideDia2_CN|于丽埃特借用了门扉的力量，神像的融合度每回合都在提升！"
  },
  Monster_B0008_SideDia3 = {
    ID = "Monster_B0008_SideDia3",
    CN = "LanguageConfig_Monster_B0008_SideDia3_CN|「遗忘」的力量影响了精神维度，乐音将无法再传达…"
  },
  Monster_B0008_SideDia4 = {
    ID = "Monster_B0008_SideDia4",
    CN = "LanguageConfig_Monster_B0008_SideDia4_CN|当心双子的融合度！若其达到 100%，拉蒙娜的意识可能会受到较大影响…"
  },
  Monster_B0008_SideDia5 = {
    ID = "Monster_B0008_SideDia5",
    CN = "LanguageConfig_Monster_B0008_SideDia5_CN|无谓的挣扎…门扉的力量，守护神像的孕育吧…"
  },
  Monster_B0008_SideDia6 = {
    ID = "Monster_B0008_SideDia6",
    CN = "LanguageConfig_Monster_B0008_SideDia6_CN|回归吧，拉蒙娜…让我们一起，迎接最终的遗忘之理…"
  },
  Monster_B0008_SideDia7 = {
    ID = "Monster_B0008_SideDia7",
    CN = "LanguageConfig_Monster_B0008_SideDia7_CN|完美的融合…就是此时！重塑万物之光…"
  },
  Monster_B0008_SideDia8 = {
    ID = "Monster_B0008_SideDia8",
    CN = "LanguageConfig_Monster_B0008_SideDia8_CN|为何逃避……那最终的……遗忘的净化！"
  },
  Monster_B0008_SideDia9 = {
    ID = "Monster_B0008_SideDia9",
    CN = "LanguageConfig_Monster_B0008_SideDia9_CN|侵食…毁灭…遗忘…净化！"
  },
  Monster_B0008_SideDia10 = {
    ID = "Monster_B0008_SideDia10",
    CN = "LanguageConfig_Monster_B0008_SideDia10_CN|抱歉…守密人…我只能坚持到这里了…"
  },
  Monster_B0008_SideDia11 = {
    ID = "Monster_B0008_SideDia11",
    CN = "LanguageConfig_Monster_B0008_SideDia11_CN|于丽埃特已经放弃了支援神像…战胜它吧！"
  },
  Monster_B0008_Name1 = {
    ID = "Monster_B0008_Name1",
    CN = "LanguageConfig_Monster_B0008_Name1_CN|「双子神像」"
  },
  Monster_B0008_Name2 = {
    ID = "Monster_B0008_Name2",
    CN = "LanguageConfig_Monster_B0008_Name2_CN|「暗之子」"
  },
  Monster_B0008_Name3 = {
    ID = "Monster_B0008_Name3",
    CN = "LanguageConfig_Monster_B0008_Name3_CN|「遗忘的伊始」"
  },
  Monster_B0008_Name4 = {
    ID = "Monster_B0008_Name4",
    CN = "LanguageConfig_Monster_B0008_Name4_CN|「终焉的遗忘之理」"
  },
  Monster_B0009_Name1 = {
    ID = "Monster_B0009_Name1",
    CN = "LanguageConfig_Monster_B0009_Name1_CN|「托乎瓦波，亘古混沌」"
  },
  Monster_8unit_EndBoss_Select_TaweiCard_Tips = {
    ID = "Monster_8unit_EndBoss_Select_TaweiCard_Tips",
    CN = "LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips_CN|回应塔薇"
  },
  Monster_8unit_EndBoss_Select_TaweiCard_Tips1 = {
    ID = "Monster_8unit_EndBoss_Select_TaweiCard_Tips1",
    CN = "LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips1_CN|是吗？在怨恨的锁链遍布中…拯救你的伙伴们吧。"
  },
  Monster_8unit_EndBoss_Select_TaweiCard_Tips2 = {
    ID = "Monster_8unit_EndBoss_Select_TaweiCard_Tips2",
    CN = "LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips2_CN|是吗？在无数的畸变衍生中…拯救你看重的世界吧。"
  },
  Monster_8unit_EndBoss_Select_TaweiCard_Tips3 = {
    ID = "Monster_8unit_EndBoss_Select_TaweiCard_Tips3",
    CN = "LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips3_CN|是吗？在自身的方向迷失中…拯救你自己吧。"
  },
  Monster_8unit_EndBoss_Select_TaweiCard_Tips4 = {
    ID = "Monster_8unit_EndBoss_Select_TaweiCard_Tips4",
    CN = "LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips4_CN|沉默，犹疑，软弱…你的弱点是致命的，守密人。"
  },
  Monster_8unit_EndBoss_Num3_Tips = {
    ID = "Monster_8unit_EndBoss_Num3_Tips",
    CN = "LanguageConfig_Monster_8unit_EndBoss_Num3_Tips_CN|不要攻击光之子！击败暗之子来唤醒她吧！"
  },
  Monster_O07_Tips1 = {
    ID = "Monster_O07_Tips1",
    CN = "LanguageConfig_Monster_O07_Tips1_CN|殉身吧，神国的祭品！"
  },
  AbyssChallengeRankThisPeriod = {
    ID = "AbyssChallengeRankThisPeriod",
    CN = "LanguageConfig_AbyssChallengeRankThisPeriod_CN|本期"
  },
  AbyssChallengeRankPreviousPeriod = {
    ID = "AbyssChallengeRankPreviousPeriod",
    CN = "LanguageConfig_AbyssChallengeRankPreviousPeriod_CN|上期"
  },
  AbyssChallengeRankNotOnTheList = {
    ID = "AbyssChallengeRankNotOnTheList",
    CN = "LanguageConfig_AbyssChallengeRankNotOnTheList_CN|未上榜"
  },
  AwakerFavorImproveBase = {
    ID = "AwakerFavorImproveBase",
    CN = "LanguageConfig_AwakerFavorImproveBase_CN|同调率基础奖励"
  },
  AwakerFavorImproveFirst = {
    ID = "AwakerFavorImproveFirst",
    CN = "LanguageConfig_AwakerFavorImproveFirst_CN|首通"
  },
  AwakerFavorImproveAssist = {
    ID = "AwakerFavorImproveAssist",
    CN = "LanguageConfig_AwakerFavorImproveAssist_CN|使用助战"
  },
  AwakerFavorImproveActivity = {
    ID = "AwakerFavorImproveActivity",
    CN = "LanguageConfig_AwakerFavorImproveActivity_CN|活动加成"
  },
  AwakerFavorImproveResonance = {
    ID = "AwakerFavorImproveResonance",
    CN = "LanguageConfig_AwakerFavorImproveResonance_CN|共鸣加成"
  },
  DataTransmissionTips = {
    ID = "DataTransmissionTips",
    CN = "LanguageConfig_DataTransmissionTips_CN|数据传输中，请稍后"
  },
  PvpMatchCanceling = {
    ID = "PvpMatchCanceling",
    CN = "LanguageConfig_PvpMatchCanceling_CN|正在取消…"
  },
  DisasterReliefKuroshio = {
    ID = "DisasterReliefKuroshio",
    CN = "LanguageConfig_DisasterReliefKuroshio_CN|融灾黑潮"
  },
  EffectDescription = {
    ID = "EffectDescription",
    CN = "LanguageConfig_EffectDescription_CN|效果说明"
  },
  PVPTargetErrorTips = {
    ID = "PVPTargetErrorTips",
    CN = "LanguageConfig_PVPTargetErrorTips_CN|技能目标错误，请重新选择目标"
  },
  DiamondDonateDesc = {
    ID = "DiamondDonateDesc",
    CN = "LanguageConfig_DiamondDonateDesc_CN|您捐献的每滴源液都弥足珍贵，它们会投入融蚀研究和校舍建设中，化作弥萨格的一部分，与各位一同奔赴那个不被遗忘的未来。\n愿银钥指引我们。"
  },
  DiamondDonateTipTitle = {
    ID = "DiamondDonateTipTitle",
    CN = "LanguageConfig_DiamondDonateTipTitle_CN|规则说明"
  },
  DiamondDonateTipContent = {
    ID = "DiamondDonateTipContent",
    CN = "LanguageConfig_DiamondDonateTipContent_CN|<Title:捐献规则>\n·通过「源液捐献」消耗的「源液」都会计入累计捐献值。\n·此外，在「唤醒」中「银芯」不足时直接捐献的源液也会计入。\n<Title:奖励规则>\n·每捐献 1 滴「源液」对应获得 1 点贡献值。\n·贡献值每达到 2500 可获得 1 份特别回馈。\n·每 20 份回馈为一轮循环。\n·每轮循环总计回馈包括：「精粹原初灵核」×1、「原初灵核」×3、「贤者之石」×6、「追念羽笔」×800、「无形者的礼券」×100、「千面印章」×5000、「蔷薇金券」×50000000。"
  },
  Option_RankListPlayerLevel = {
    ID = "Option_RankListPlayerLevel",
    CN = "LanguageConfig_Option_RankListPlayerLevel_CN|守密人等级"
  },
  Option_RankListHomologyRate = {
    ID = "Option_RankListHomologyRate",
    CN = "LanguageConfig_Option_RankListHomologyRate_CN|同调率总等级"
  },
  Option_RankListLoginDays = {
    ID = "Option_RankListLoginDays",
    CN = "LanguageConfig_Option_RankListLoginDays_CN|登录天数"
  },
  Option_RankListAchievementCount = {
    ID = "Option_RankListAchievementCount",
    CN = "LanguageConfig_Option_RankListAchievementCount_CN|达成成就数"
  },
  Option_RankListLikeCount = {
    ID = "Option_RankListLikeCount",
    CN = "LanguageConfig_Option_RankListLikeCount_CN|点赞数"
  },
  Option_RankListGetlikeCount = {
    ID = "Option_RankListGetlikeCount",
    CN = "LanguageConfig_Option_RankListGetlikeCount_CN|被点赞数"
  },
  Option_RankListAssistanceCount = {
    ID = "Option_RankListAssistanceCount",
    CN = "LanguageConfig_Option_RankListAssistanceCount_CN|助战次数"
  },
  Option_RankListFollowerNum = {
    ID = "Option_RankListFollowerNum",
    CN = "LanguageConfig_Option_RankListFollowerNum_CN|追随者数"
  },
  Option_RankListCollectionNum = {
    ID = "Option_RankListCollectionNum",
    CN = "LanguageConfig_Option_RankListCollectionNum_CN|秘典书库藏品数"
  },
  RankListPlayerLevel = {
    ID = "RankListPlayerLevel",
    CN = "LanguageConfig_RankListPlayerLevel_CN|守密人等级/经验"
  },
  RankListHomologyRate = {
    ID = "RankListHomologyRate",
    CN = "LanguageConfig_RankListHomologyRate_CN|同调率总等级"
  },
  RankListLoginDays = {
    ID = "RankListLoginDays",
    CN = "LanguageConfig_RankListLoginDays_CN|登录天数"
  },
  RankListAchievementCount = {
    ID = "RankListAchievementCount",
    CN = "LanguageConfig_RankListAchievementCount_CN|达成成就数"
  },
  RankListLikeCount = {
    ID = "RankListLikeCount",
    CN = "LanguageConfig_RankListLikeCount_CN|点赞数"
  },
  RankListGetlikeCount = {
    ID = "RankListGetlikeCount",
    CN = "LanguageConfig_RankListGetlikeCount_CN|被点赞数"
  },
  RankListAssistanceCount = {
    ID = "RankListAssistanceCount",
    CN = "LanguageConfig_RankListAssistanceCount_CN|助战次数"
  },
  RankListFollowerNum = {
    ID = "RankListFollowerNum",
    CN = "LanguageConfig_RankListFollowerNum_CN|追随者数"
  },
  RankListCollectionNum = {
    ID = "RankListCollectionNum",
    CN = "LanguageConfig_RankListCollectionNum_CN|秘典书库藏品数"
  },
  ItemUsingDesc = {
    ID = "ItemUsingDesc",
    CN = "LanguageConfig_ItemUsingDesc_CN|使用中"
  },
  AlchemyDecomposeWeaponRuleContent = {
    ID = "AlchemyDecomposeWeaponRuleContent",
    CN = "LanguageConfig_AlchemyDecomposeWeaponRuleContent_CN|1、守密人可以在此进行命轮分解，分解后将不可恢复，请守密人谨慎选择。\n2、若本次选择要分解的命轮中包含SSR级命轮或已叠位的命轮，分解时需要守密人完成答题才可分解。\n3、分解非限定的SSR级命轮可以获得「命途回溯碎片」× 1 和「蔷薇金券」× 2000，若分解限定SSR级命轮则获得的「命途回溯碎片」数量翻倍。\n4、当前在任意「编队」或「助战唤醒体」中使用的命轮，不可分解。"
  },
  AlchemyDecomposeTrinketRuleContent = {
    ID = "AlchemyDecomposeTrinketRuleContent",
    CN = "LanguageConfig_AlchemyDecomposeTrinketRuleContent_CN|1、守密人可以在此进行密契分解，分解后将不可恢复，请守密人谨慎选择。\n2、若本次选择要分解的命轮中包含已强化的密契，分解时需要守密人完成答题才可分解。\n3、当前在任意「编队」或「密契方案」或「助战唤醒体」中使用的密契，不可分解。"
  },
  AlchemyDecomposeItemRuleContent = {
    ID = "AlchemyDecomposeItemRuleContent",
    CN = "LanguageConfig_AlchemyDecomposeItemRuleContent_CN|1、守密人可以在此进行材料分解，分解后将不可恢复，请守密人谨慎选择。\n2、材料分解的具体产物可在界面中查看。"
  },
  AlchemyDecomposeWeaponConfirmTIps = {
    ID = "AlchemyDecomposeWeaponConfirmTIps",
    CN = "LanguageConfig_AlchemyDecomposeWeaponConfirmTIps_CN|本次分解物资包含<Blue:SSR级命轮或已叠位的命轮>，物资价值较高，确认分解请在输入框中输入<Blue:正确答案>，点击确定后将进行分解。"
  },
  AlchemyDecomposeTrinketConfirmTIps = {
    ID = "AlchemyDecomposeTrinketConfirmTIps",
    CN = "LanguageConfig_AlchemyDecomposeTrinketConfirmTIps_CN|本次分解物资包含<Blue:已升级的密契>，物资价值较高，确认分解请在输入框中输入<Blue:正确答案>，点击确定后将进行分解。"
  },
  AlchemyDecomposeEmptyResultTips = {
    ID = "AlchemyDecomposeEmptyResultTips",
    CN = "LanguageConfig_AlchemyDecomposeEmptyResultTips_CN|请输入正确答案"
  },
  AlchemyDecomposeWrongResultTips = {
    ID = "AlchemyDecomposeWrongResultTips",
    CN = "LanguageConfig_AlchemyDecomposeWrongResultTips_CN|答案错误，请重新输入"
  },
  PotencyComingSoon = {
    ID = "PotencyComingSoon",
    CN = "LanguageConfig_PotencyComingSoon_CN|该唤醒体的超限爆发能力暂未开放，敬请期待"
  },
  PotencyPopupTitle = {
    ID = "PotencyPopupTitle",
    CN = "LanguageConfig_PotencyPopupTitle_CN|人格深化"
  },
  DispatchSucessfulTip = {
    ID = "DispatchSucessfulTip",
    CN = "LanguageConfig_DispatchSucessfulTip_CN|派遣成功"
  },
  SocialSystemRank = {
    ID = "SocialSystemRank",
    CN = "LanguageConfig_SocialSystemRank_CN|达人榜"
  },
  SocialSystemInvitation = {
    ID = "SocialSystemInvitation",
    CN = "LanguageConfig_SocialSystemInvitation_CN|邀请"
  },
  SocialSystemCommunity = {
    ID = "SocialSystemCommunity",
    CN = "LanguageConfig_SocialSystemCommunity_CN|社区"
  },
  GoodSourceSocial = {
    ID = "GoodSourceSocial",
    CN = "LanguageConfig_GoodSourceSocial_CN|守密人档案"
  },
  GoodSourcePVP = {
    ID = "GoodSourcePVP",
    CN = "LanguageConfig_GoodSourcePVP_CN|相位对弈"
  },
  PVPGoodBtnUnClickableStateTips = {
    ID = "PVPGoodBtnUnClickableStateTips",
    CN = "LanguageConfig_PVPGoodBtnUnClickableStateTips_CN|已经点赞过对手啦"
  },
  PVPAttentionBtnUnClickableStateTips = {
    ID = "PVPAttentionBtnUnClickableStateTips",
    CN = "LanguageConfig_PVPAttentionBtnUnClickableStateTips_CN|已经关注对手啦"
  },
  DisasterReliefKuroshioTipsDesc = {
    ID = "DisasterReliefKuroshioTipsDesc",
    CN = "LanguageConfig_DisasterReliefKuroshioTipsDesc_CN|请守密人留意，随着调查深入推进，融灾黑潮的环境特征不同，且会对特定区域造成影响"
  },
  ActivityTaskGroupOpenCountDownFormat = {
    ID = "ActivityTaskGroupOpenCountDownFormat",
    CN = "LanguageConfig_ActivityTaskGroupOpenCountDownFormat_CN|距离解锁还有{s1}天{s2}小时{s3}分"
  },
  CanEquipOneSSRWeaonRuleDesc = {
    ID = "CanEquipOneSSRWeaonRuleDesc",
    CN = "LanguageConfig_CanEquipOneSSRWeaonRuleDesc_CN|同个唤醒体只能装备一个SSR命轮"
  },
  CanEquipTwoSSRWeaonRuleDesc = {
    ID = "CanEquipTwoSSRWeaonRuleDesc",
    CN = "LanguageConfig_CanEquipTwoSSRWeaonRuleDesc_CN|现在可以装备两个SSR命轮"
  },
  ExtraSSRWeaponUnlockTips = {
    ID = "ExtraSSRWeaponUnlockTips",
    CN = "LanguageConfig_ExtraSSRWeaponUnlockTips_CN|「超限因果」已激活！"
  },
  ExtraSSRWeaponRuleTitle = {
    ID = "ExtraSSRWeaponRuleTitle",
    CN = "LanguageConfig_ExtraSSRWeaponRuleTitle_CN|规则说明"
  },
  ExtraSSRWeaponRuleContent = {
    ID = "ExtraSSRWeaponRuleContent",
    CN = "LanguageConfig_ExtraSSRWeaponRuleContent_CN|<Title:超限因果>\n·一般情况下，同一个唤醒体只能装备一个SSR命轮。\n·当唤醒体装备了额外叠位达到12的SSR命轮时，能够激活「超限因果」效果，使唤醒体能同时装备两个SSR命轮。"
  },
  DisasterReliefKuroshioEntryNameFormat = {
    ID = "DisasterReliefKuroshioEntryNameFormat",
    CN = "LanguageConfig_DisasterReliefKuroshioEntryNameFormat_CN|{s1}·{s2}"
  },
  UltlSkillName = {
    ID = "UltlSkillName",
    CN = "LanguageConfig_UltlSkillName_CN|狂气爆发"
  },
  SuperUltlSkillName = {
    ID = "SuperUltlSkillName",
    CN = "LanguageConfig_SuperUltlSkillName_CN|超限爆发"
  },
  UltlSkillNamePrefix = {
    ID = "UltlSkillNamePrefix",
    CN = "LanguageConfig_UltlSkillNamePrefix_CN|超限爆发-"
  },
  PlayerExpRateTxt = {
    ID = "PlayerExpRateTxt",
    CN = "LanguageConfig_PlayerExpRateTxt_CN|当前经验加速：{s1}%"
  },
  PlayerExpRuleTitle = {
    ID = "PlayerExpRuleTitle",
    CN = "LanguageConfig_PlayerExpRuleTitle_CN|加速说明"
  },
  PlayerExpRuleContent = {
    ID = "PlayerExpRuleContent",
    CN = "LanguageConfig_PlayerExpRuleContent_CN|<Title:至高礼赞>\n1、在「智识赠礼」活动中，完成每个任务均可获得一个「至高礼赞」效果，使守密人经验获得加速，最高可达 100%。多个「至高礼赞」效果同时存在时，取最高的加速效果。\n2、解锁或获得更高级的「至高礼赞」效果时，会按照加速比例和当前可被加速的守密人经验总量，立即获得额外的守密人经验。\n3、解锁「至高礼赞」后，守密人每次获得守密人经验时，都将获得对应加速比例的额外守密人经验。\n4、请注意，「至高礼赞」带来的额外守密人经验不会计入可被加速的守密人经验总量。\n5、当前可被加速的守密人经验总量：{s1}。\n6、加速已累计获得额外守密人经验：{s2}（{s3}%）。"
  },
  EnergyCommonAutoRecoverTips = {
    ID = "EnergyCommonAutoRecoverTips",
    CN = "LanguageConfig_EnergyCommonAutoRecoverTips_CN|当前补充速度：5分钟/支"
  },
  EnergyOverAutoRecoverTips = {
    ID = "EnergyOverAutoRecoverTips",
    CN = "LanguageConfig_EnergyOverAutoRecoverTips_CN|当前补充速度：15分钟/支"
  },
  RecordShortcut = {
    ID = "RecordShortcut",
    CN = "LanguageConfig_RecordShortcut_CN|按下绑定的键位"
  },
  Summon_SelectWeapon = {
    ID = "Summon_SelectWeapon",
    CN = "LanguageConfig_Summon_SelectWeapon_CN|定向命轮"
  },
  Summon_SelectWeapon_Tips = {
    ID = "Summon_SelectWeapon_Tips",
    CN = "LanguageConfig_Summon_SelectWeapon_Tips_CN|点击此处选择定向命轮"
  },
  Summon_SelectSchool_Tips = {
    ID = "Summon_SelectSchool_Tips",
    CN = "LanguageConfig_Summon_SelectSchool_Tips_CN|点击此处选择指定界域"
  },
  SummonProbabilityUpDescFormat = {
    ID = "SummonProbabilityUpDescFormat",
    CN = "LanguageConfig_SummonProbabilityUpDescFormat_CN|<SummonOrange:「{s1}」>获取概率提升！"
  },
  SummonTargetPoolNotSelectTips = {
    ID = "SummonTargetPoolNotSelectTips",
    CN = "LanguageConfig_SummonTargetPoolNotSelectTips_CN|选择定向命轮后方可唤醒"
  },
  yixiang1 = {
    ID = "yixiang1",
    CN = "LanguageConfig_yixiang1_CN|太阳"
  },
  yixiang2 = {
    ID = "yixiang2",
    CN = "LanguageConfig_yixiang2_CN|星星"
  },
  yixiang3 = {
    ID = "yixiang3",
    CN = "LanguageConfig_yixiang3_CN|春天"
  },
  yixiang4 = {
    ID = "yixiang4",
    CN = "LanguageConfig_yixiang4_CN|诗句"
  },
  yixiang5 = {
    ID = "yixiang5",
    CN = "LanguageConfig_yixiang5_CN|蝴蝶"
  },
  yixiang6 = {
    ID = "yixiang6",
    CN = "LanguageConfig_yixiang6_CN|云朵"
  },
  yixiang7 = {
    ID = "yixiang7",
    CN = "LanguageConfig_yixiang7_CN|风"
  },
  yixiang8 = {
    ID = "yixiang8",
    CN = "LanguageConfig_yixiang8_CN|森林"
  },
  yixiang9 = {
    ID = "yixiang9",
    CN = "LanguageConfig_yixiang9_CN|雪"
  },
  yixiang10 = {
    ID = "yixiang10",
    CN = "LanguageConfig_yixiang10_CN|花束"
  },
  yixiang11 = {
    ID = "yixiang11",
    CN = "LanguageConfig_yixiang11_CN|猫"
  },
  yixiang12 = {
    ID = "yixiang12",
    CN = "LanguageConfig_yixiang12_CN|大地"
  },
  yixiang13 = {
    ID = "yixiang13",
    CN = "LanguageConfig_yixiang13_CN|泉水"
  },
  yixiang14 = {
    ID = "yixiang14",
    CN = "LanguageConfig_yixiang14_CN|月亮"
  },
  Nonimagery_1_1_1_1 = {
    ID = "Nonimagery_1_1_1_1",
    CN = "LanguageConfig_Nonimagery_1_1_1_1_CN|哭泣"
  },
  Nonimagery_1_1_1_2 = {
    ID = "Nonimagery_1_1_1_2",
    CN = "LanguageConfig_Nonimagery_1_1_1_2_CN|眺望"
  },
  Nonimagery_1_1_1_3 = {
    ID = "Nonimagery_1_1_1_3",
    CN = "LanguageConfig_Nonimagery_1_1_1_3_CN|穿越"
  },
  Nonimagery_1_2_1_1 = {
    ID = "Nonimagery_1_2_1_1",
    CN = "LanguageConfig_Nonimagery_1_2_1_1_CN|却"
  },
  Nonimagery_1_2_1_2 = {
    ID = "Nonimagery_1_2_1_2",
    CN = "LanguageConfig_Nonimagery_1_2_1_2_CN|还是"
  },
  Nonimagery_1_2_1_3 = {
    ID = "Nonimagery_1_2_1_3",
    CN = "LanguageConfig_Nonimagery_1_2_1_3_CN|仍然"
  },
  Nonimagery_1_3_1_1 = {
    ID = "Nonimagery_1_3_1_1",
    CN = "LanguageConfig_Nonimagery_1_3_1_1_CN|挥动着"
  },
  Nonimagery_1_3_1_2 = {
    ID = "Nonimagery_1_3_1_2",
    CN = "LanguageConfig_Nonimagery_1_3_1_2_CN|跳跃着"
  },
  Nonimagery_1_3_1_3 = {
    ID = "Nonimagery_1_3_1_3",
    CN = "LanguageConfig_Nonimagery_1_3_1_3_CN|忍耐着"
  },
  Nonimagery_1_4_1_1 = {
    ID = "Nonimagery_1_4_1_1",
    CN = "LanguageConfig_Nonimagery_1_4_1_1_CN|直到"
  },
  Nonimagery_1_4_1_2 = {
    ID = "Nonimagery_1_4_1_2",
    CN = "LanguageConfig_Nonimagery_1_4_1_2_CN|无论"
  },
  Nonimagery_1_4_1_3 = {
    ID = "Nonimagery_1_4_1_3",
    CN = "LanguageConfig_Nonimagery_1_4_1_3_CN|为了"
  },
  yixiang1_1 = {
    ID = "yixiang1_1",
    CN = "LanguageConfig_yixiang1_1_CN|太阳"
  },
  yixiang1_2 = {
    ID = "yixiang1_2",
    CN = "LanguageConfig_yixiang1_2_CN|太阳"
  },
  yixiang1_3 = {
    ID = "yixiang1_3",
    CN = "LanguageConfig_yixiang1_3_CN|太阳"
  },
  yixiang2_1 = {
    ID = "yixiang2_1",
    CN = "LanguageConfig_yixiang2_1_CN|星星"
  },
  yixiang2_2 = {
    ID = "yixiang2_2",
    CN = "LanguageConfig_yixiang2_2_CN|星星"
  },
  yixiang2_3 = {
    ID = "yixiang2_3",
    CN = "LanguageConfig_yixiang2_3_CN|星星"
  },
  yixiang3_1 = {
    ID = "yixiang3_1",
    CN = "LanguageConfig_yixiang3_1_CN|春天"
  },
  yixiang3_2 = {
    ID = "yixiang3_2",
    CN = "LanguageConfig_yixiang3_2_CN|春天"
  },
  yixiang3_3 = {
    ID = "yixiang3_3",
    CN = "LanguageConfig_yixiang3_3_CN|春天"
  },
  yixiang4_1 = {
    ID = "yixiang4_1",
    CN = "LanguageConfig_yixiang4_1_CN|诗句"
  },
  yixiang4_2 = {
    ID = "yixiang4_2",
    CN = "LanguageConfig_yixiang4_2_CN|诗句"
  },
  yixiang4_3 = {
    ID = "yixiang4_3",
    CN = "LanguageConfig_yixiang4_3_CN|诗句"
  },
  yixiang5_1 = {
    ID = "yixiang5_1",
    CN = "LanguageConfig_yixiang5_1_CN|蝴蝶"
  },
  yixiang5_2 = {
    ID = "yixiang5_2",
    CN = "LanguageConfig_yixiang5_2_CN|蝴蝶"
  },
  yixiang5_3 = {
    ID = "yixiang5_3",
    CN = "LanguageConfig_yixiang5_3_CN|蝴蝶"
  },
  yixiang6_1 = {
    ID = "yixiang6_1",
    CN = "LanguageConfig_yixiang6_1_CN|云朵"
  },
  yixiang6_2 = {
    ID = "yixiang6_2",
    CN = "LanguageConfig_yixiang6_2_CN|云朵"
  },
  yixiang6_3 = {
    ID = "yixiang6_3",
    CN = "LanguageConfig_yixiang6_3_CN|云朵"
  },
  yixiang7_1 = {
    ID = "yixiang7_1",
    CN = "LanguageConfig_yixiang7_1_CN|风"
  },
  yixiang7_2 = {
    ID = "yixiang7_2",
    CN = "LanguageConfig_yixiang7_2_CN|风"
  },
  yixiang7_3 = {
    ID = "yixiang7_3",
    CN = "LanguageConfig_yixiang7_3_CN|风"
  },
  yixiang8_1 = {
    ID = "yixiang8_1",
    CN = "LanguageConfig_yixiang8_1_CN|森林"
  },
  yixiang8_2 = {
    ID = "yixiang8_2",
    CN = "LanguageConfig_yixiang8_2_CN|森林"
  },
  yixiang8_3 = {
    ID = "yixiang8_3",
    CN = "LanguageConfig_yixiang8_3_CN|森林"
  },
  yixiang9_1 = {
    ID = "yixiang9_1",
    CN = "LanguageConfig_yixiang9_1_CN|雪"
  },
  yixiang9_2 = {
    ID = "yixiang9_2",
    CN = "LanguageConfig_yixiang9_2_CN|雪"
  },
  yixiang9_3 = {
    ID = "yixiang9_3",
    CN = "LanguageConfig_yixiang9_3_CN|雪"
  },
  yixiang10_1 = {
    ID = "yixiang10_1",
    CN = "LanguageConfig_yixiang10_1_CN|花束"
  },
  yixiang10_2 = {
    ID = "yixiang10_2",
    CN = "LanguageConfig_yixiang10_2_CN|花束"
  },
  yixiang10_3 = {
    ID = "yixiang10_3",
    CN = "LanguageConfig_yixiang10_3_CN|花束"
  },
  yixiang11_1 = {
    ID = "yixiang11_1",
    CN = "LanguageConfig_yixiang11_1_CN|猫"
  },
  yixiang11_2 = {
    ID = "yixiang11_2",
    CN = "LanguageConfig_yixiang11_2_CN|猫"
  },
  yixiang11_3 = {
    ID = "yixiang11_3",
    CN = "LanguageConfig_yixiang11_3_CN|猫"
  },
  yixiang12_1 = {
    ID = "yixiang12_1",
    CN = "LanguageConfig_yixiang12_1_CN|大地"
  },
  yixiang12_2 = {
    ID = "yixiang12_2",
    CN = "LanguageConfig_yixiang12_2_CN|大地"
  },
  yixiang12_3 = {
    ID = "yixiang12_3",
    CN = "LanguageConfig_yixiang12_3_CN|大地"
  },
  yixiang13_1 = {
    ID = "yixiang13_1",
    CN = "LanguageConfig_yixiang13_1_CN|泉水"
  },
  yixiang13_2 = {
    ID = "yixiang13_2",
    CN = "LanguageConfig_yixiang13_2_CN|泉水"
  },
  yixiang13_3 = {
    ID = "yixiang13_3",
    CN = "LanguageConfig_yixiang13_3_CN|泉水"
  },
  yixiang14_1 = {
    ID = "yixiang14_1",
    CN = "LanguageConfig_yixiang14_1_CN|月亮"
  },
  yixiang14_2 = {
    ID = "yixiang14_2",
    CN = "LanguageConfig_yixiang14_2_CN|月亮"
  },
  yixiang14_3 = {
    ID = "yixiang14_3",
    CN = "LanguageConfig_yixiang14_3_CN|月亮"
  },
  Select_yixiangCard = {
    ID = "Select_yixiangCard",
    CN = "LanguageConfig_Select_yixiangCard_CN|选择 3 张意象合成献诗"
  },
  PoetryFormatGroup_1 = {
    ID = "PoetryFormatGroup_1",
    CN = "LanguageConfig_PoetryFormatGroup_1_CN|斑驳的{s1}长久等候，@2停留在@2的刺痛\n@2的房间，当{s2}燃烧的声音响起\n{s3}便落满了花园"
  },
  PoetryFormatGroup_2 = {
    ID = "PoetryFormatGroup_2",
    CN = "LanguageConfig_PoetryFormatGroup_2_CN|在{s1}身旁，在一场@2消亡的@2 \n舞曲@2于追逐，{s2}开始谢幕。 \n@2，听吧：在这个夜晚，我将与{s3}共舞。"
  },
  PoetryFormatGroup_3 = {
    ID = "PoetryFormatGroup_3",
    CN = "LanguageConfig_PoetryFormatGroup_3_CN|与{s1}对饮，举起@2的杯盏\n窗外的@2属于{s2}，那是@2的时空\n@2夜幕@2的火光，生命让位于{s3}。"
  },
  PoetryFormatGroup_4 = {
    ID = "PoetryFormatGroup_4",
    CN = "LanguageConfig_PoetryFormatGroup_4_CN|一片叶子，把@2借给{s1}\n这是@2的徒劳：{s2}与@2，远远相望\n只有凋落，{s3}才相互拥抱"
  },
  PoetryFormatGroup_5 = {
    ID = "PoetryFormatGroup_5",
    CN = "LanguageConfig_PoetryFormatGroup_5_CN|在荆棘之外，{s1}与@2盛开\n永恒的{s2}从@2落下\n落入@2，落入{s3}孤单的怀中"
  },
  PoetryFormatGroup_6 = {
    ID = "PoetryFormatGroup_6",
    CN = "LanguageConfig_PoetryFormatGroup_6_CN|深渊中的{s1}，从@2的掌中盛开\n@2梦里的@2啊，我曾是@2的{s2}\n在{s3}坠落的@2，我将回忆起你荒寂的心"
  },
  Card_Select_Upyixiang_Tips1 = {
    ID = "Card_Select_Upyixiang_Tips1",
    CN = "LanguageConfig_Card_Select_Upyixiang_Tips1_CN|选择 1 张意象升级"
  },
  Card_Select_yixiang_Tips1 = {
    ID = "Card_Select_yixiang_Tips1",
    CN = "LanguageConfig_Card_Select_yixiang_Tips1_CN|选择获得 1 张意象"
  },
  RewardItemAccelerateTag = {
    ID = "RewardItemAccelerateTag",
    CN = "LanguageConfig_RewardItemAccelerateTag_CN|加速"
  },
  SocialSourcePanelAccelerateTips = {
    ID = "SocialSourcePanelAccelerateTips",
    CN = "LanguageConfig_SocialSourcePanelAccelerateTips_CN|经验加速 {s1}%"
  },
  PVPSettleAccelerateField = {
    ID = "PVPSettleAccelerateField",
    CN = "LanguageConfig_PVPSettleAccelerateField_CN|守密人经验加速"
  },
  SocialChangeAvatarFrameBtnTxt = {
    ID = "SocialChangeAvatarFrameBtnTxt",
    CN = "LanguageConfig_SocialChangeAvatarFrameBtnTxt_CN|更换头像框"
  },
  ActivityStageMadnessChallengeTips = {
    ID = "ActivityStageMadnessChallengeTips",
    CN = "LanguageConfig_ActivityStageMadnessChallengeTips_CN|癫狂难度仅可获得首通奖励"
  },
  Aoerlagongminglianluo1 = {
    ID = "Aoerlagongminglianluo1",
    CN = "LanguageConfig_Aoerlagongminglianluo1_CN|可选择合成献诗。"
  },
  Aoerlagongminglianluo2 = {
    ID = "Aoerlagongminglianluo2",
    CN = "LanguageConfig_Aoerlagongminglianluo2_CN|可选择升级意象。"
  },
  StageCopyUnlockDescFomat = {
    ID = "StageCopyUnlockDescFomat",
    CN = "LanguageConfig_StageCopyUnlockDescFomat_CN|{s1}解锁"
  },
  AwakerChipSelectTitle = {
    ID = "AwakerChipSelectTitle",
    CN = "LanguageConfig_AwakerChipSelectTitle_CN|选择唤醒体残片"
  },
  PvPMoreGameBtnOverWinStateTips = {
    ID = "PvPMoreGameBtnOverWinStateTips",
    CN = "LanguageConfig_PvPMoreGameBtnOverWinStateTips_CN|已有一人获得两次胜利，不可再来一局"
  },
  PvPMoreGameBtnQuitStateTips = {
    ID = "PvPMoreGameBtnQuitStateTips",
    CN = "LanguageConfig_PvPMoreGameBtnQuitStateTips_CN|对方已退出对局"
  },
  PvPMoreGameBtnRefuseStateTips = {
    ID = "PvPMoreGameBtnRefuseStateTips",
    CN = "LanguageConfig_PvPMoreGameBtnRefuseStateTips_CN|对方已拒绝过你"
  },
  PvPMoreGameBtnActiveRefuseStateTips = {
    ID = "PvPMoreGameBtnActiveRefuseStateTips",
    CN = "LanguageConfig_PvPMoreGameBtnActiveRefuseStateTips_CN|你已拒绝过对方"
  },
  PvPMoreGameBeCancelTips = {
    ID = "PvPMoreGameBeCancelTips",
    CN = "LanguageConfig_PvPMoreGameBeCancelTips_CN|对方已取消"
  },
  PvPMoreGameBeRefusedTips = {
    ID = "PvPMoreGameBeRefusedTips",
    CN = "LanguageConfig_PvPMoreGameBeRefusedTips_CN|对方已拒绝"
  },
  PvPMoreGame = {
    ID = "PvPMoreGame",
    CN = "LanguageConfig_PvPMoreGame_CN|再来一局"
  },
  PvPMoreGameTitle = {
    ID = "PvPMoreGameTitle",
    CN = "LanguageConfig_PvPMoreGameTitle_CN|再来一局"
  },
  C15AFNotUseCard = {
    ID = "C15AFNotUseCard",
    CN = "LanguageConfig_C15AFNotUseCard_CN|银钥能量不足"
  },
  C05AFNotUseCard = {
    ID = "C05AFNotUseCard",
    CN = "LanguageConfig_C05AFNotUseCard_CN|黑印不足"
  },
  EnchantmentUnit8_Title1 = {
    ID = "EnchantmentUnit8_Title1",
    CN = "LanguageConfig_EnchantmentUnit8_Title1_CN|选择 1 张卡牌领悟繁育之理"
  },
  EnchantmentUnit8_Title2 = {
    ID = "EnchantmentUnit8_Title2",
    CN = "LanguageConfig_EnchantmentUnit8_Title2_CN|选择 1 张卡牌领悟欢愉之理"
  },
  EnchantmentUnit8_Title3 = {
    ID = "EnchantmentUnit8_Title3",
    CN = "LanguageConfig_EnchantmentUnit8_Title3_CN|选择 1 张卡牌领悟智识之理"
  },
  EnchantmentUnit8_Title1_plus = {
    ID = "EnchantmentUnit8_Title1_plus",
    CN = "LanguageConfig_EnchantmentUnit8_Title1_plus_CN|选择 1 张卡牌完全领悟繁育之理"
  },
  EnchantmentUnit8_Title2_plus = {
    ID = "EnchantmentUnit8_Title2_plus",
    CN = "LanguageConfig_EnchantmentUnit8_Title2_plus_CN|选择 1 张卡牌完全领悟欢愉之理"
  },
  EnchantmentUnit8_Title3_plus = {
    ID = "EnchantmentUnit8_Title3_plus",
    CN = "LanguageConfig_EnchantmentUnit8_Title3_plus_CN|选择 1 张卡牌完全领悟智识之理"
  },
  EnchantmentUnit8_Title4 = {
    ID = "EnchantmentUnit8_Title4",
    CN = "LanguageConfig_EnchantmentUnit8_Title4_CN|选择最多 2 张卡牌赋予「渊海回声」刻印。"
  },
  FriendGame = {
    ID = "FriendGame",
    CN = "LanguageConfig_FriendGame_CN|友谊赛"
  },
  FriendGameWaitAccept = {
    ID = "FriendGameWaitAccept",
    CN = "LanguageConfig_FriendGameWaitAccept_CN|接受友谊赛的邀请"
  },
  FriendGameWaitFormation = {
    ID = "FriendGameWaitFormation",
    CN = "LanguageConfig_FriendGameWaitFormation_CN|编辑队伍"
  },
  CanceledText = {
    ID = "CanceledText",
    CN = "LanguageConfig_CanceledText_CN|已取消"
  },
  RefusedText = {
    ID = "RefusedText",
    CN = "LanguageConfig_RefusedText_CN|已拒绝"
  },
  TimeoutText = {
    ID = "TimeoutText",
    CN = "LanguageConfig_TimeoutText_CN|已超时"
  },
  FriendGameCount = {
    ID = "FriendGameCount",
    CN = "LanguageConfig_FriendGameCount_CN|友谊赛{s1}<size=24>人邀请</size>"
  },
  FriendGameNull = {
    ID = "FriendGameNull",
    CN = "LanguageConfig_FriendGameNull_CN|邀请已取消"
  },
  EmojiCommonDesc = {
    ID = "EmojiCommonDesc",
    CN = "LanguageConfig_EmojiCommonDesc_CN|[表情]"
  },
  PvpMatchBattle = {
    ID = "PvpMatchBattle",
    CN = "LanguageConfig_PvpMatchBattle_CN|匹配对战"
  },
  PvpFriendBattle = {
    ID = "PvpFriendBattle",
    CN = "LanguageConfig_PvpFriendBattle_CN|友谊赛"
  },
  SocialUnfollowedFans = {
    ID = "SocialUnfollowedFans",
    CN = "LanguageConfig_SocialUnfollowedFans_CN|未关注"
  },
  TextBan = {
    ID = "TextBan",
    CN = "LanguageConfig_TextBan_CN|拉黑"
  },
  TextCancelBan = {
    ID = "TextCancelBan",
    CN = "LanguageConfig_TextCancelBan_CN|取消拉黑"
  },
  TextBanned = {
    ID = "TextBanned",
    CN = "LanguageConfig_TextBanned_CN|已拉黑"
  },
  TextBanTitle = {
    ID = "TextBanTitle",
    CN = "LanguageConfig_TextBanTitle_CN|黑名单"
  },
  TextEmptyBan = {
    ID = "TextEmptyBan",
    CN = "LanguageConfig_TextEmptyBan_CN|暂无黑名单"
  },
  PVPRecordTime_Day = {
    ID = "PVPRecordTime_Day",
    CN = "LanguageConfig_PVPRecordTime_Day_CN|{s1} 天前"
  },
  PVPRecordTime_Hour = {
    ID = "PVPRecordTime_Hour",
    CN = "LanguageConfig_PVPRecordTime_Hour_CN|{s1} 小时前"
  },
  PVPRecordTime_Minute = {
    ID = "PVPRecordTime_Minute",
    CN = "LanguageConfig_PVPRecordTime_Minute_CN|{s1} 分前"
  },
  GamePassportTip = {
    ID = "GamePassportTip",
    CN = "LanguageConfig_GamePassportTip_CN|解锁高级纪行\n完成任务后可额外领取奖励"
  },
  SaleSuccessful = {
    ID = "SaleSuccessful",
    CN = "LanguageConfig_SaleSuccessful_CN|出售成功"
  },
  NormalGamePassport = {
    ID = "NormalGamePassport",
    CN = "LanguageConfig_NormalGamePassport_CN|普通纪行"
  },
  PlusGamePassport = {
    ID = "PlusGamePassport",
    CN = "LanguageConfig_PlusGamePassport_CN|高级纪行"
  },
  LevelUpGamePassport = {
    ID = "LevelUpGamePassport",
    CN = "LanguageConfig_LevelUpGamePassport_CN|纪行进阶"
  },
  DayChallengeOptionalDifficuly1_1 = {
    ID = "DayChallengeOptionalDifficuly1_1",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_1_CN|无额外难度加成"
  },
  DayChallengeOptionalDifficuly1_2 = {
    ID = "DayChallengeOptionalDifficuly1_2",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_2_CN|敌人生命 +25%"
  },
  DayChallengeOptionalDifficuly1_3 = {
    ID = "DayChallengeOptionalDifficuly1_3",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_3_CN|敌人生命 +75%"
  },
  DayChallengeOptionalDifficuly1_4 = {
    ID = "DayChallengeOptionalDifficuly1_4",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_4_CN|敌人生命 +125%"
  },
  DayChallengeOptionalDifficuly1_5 = {
    ID = "DayChallengeOptionalDifficuly1_5",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_5_CN|敌人生命 +200%"
  },
  DayChallengeOptionalDifficuly1_6 = {
    ID = "DayChallengeOptionalDifficuly1_6",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_6_CN|敌人生命 +275%"
  },
  DayChallengeOptionalDifficuly1_7 = {
    ID = "DayChallengeOptionalDifficuly1_7",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_7_CN|敌人生命 +350%"
  },
  DayChallengeOptionalDifficuly1_8 = {
    ID = "DayChallengeOptionalDifficuly1_8",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_8_CN|敌人生命 +450%"
  },
  DayChallengeOptionalDifficuly1_9 = {
    ID = "DayChallengeOptionalDifficuly1_9",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_9_CN|敌人生命 +600%"
  },
  DayChallengeOptionalDifficuly1_10 = {
    ID = "DayChallengeOptionalDifficuly1_10",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_10_CN|敌人生命 +750%"
  },
  DayChallengeOptionalDifficuly1_11 = {
    ID = "DayChallengeOptionalDifficuly1_11",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_11_CN|敌人生命 +1000%"
  },
  DayChallengeOptionalDifficuly1_12 = {
    ID = "DayChallengeOptionalDifficuly1_12",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_12_CN|敌人生命 +1100%"
  },
  DayChallengeOptionalDifficuly1_13 = {
    ID = "DayChallengeOptionalDifficuly1_13",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_13_CN|敌人生命 +1200%"
  },
  DayChallengeOptionalDifficuly1_14 = {
    ID = "DayChallengeOptionalDifficuly1_14",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_14_CN|敌人生命 +1300%"
  },
  DayChallengeOptionalDifficuly1_15 = {
    ID = "DayChallengeOptionalDifficuly1_15",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_15_CN|敌人生命 +1400%"
  },
  DayChallengeOptionalDifficuly1_16 = {
    ID = "DayChallengeOptionalDifficuly1_16",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly1_16_CN|敌人生命 +1500%"
  },
  DayChallengeOptionalDifficuly2_1 = {
    ID = "DayChallengeOptionalDifficuly2_1",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_1_CN|无额外难度加成"
  },
  DayChallengeOptionalDifficuly2_2 = {
    ID = "DayChallengeOptionalDifficuly2_2",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_2_CN|敌人伤害 +5%"
  },
  DayChallengeOptionalDifficuly2_3 = {
    ID = "DayChallengeOptionalDifficuly2_3",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_3_CN|敌人伤害 +15%"
  },
  DayChallengeOptionalDifficuly2_4 = {
    ID = "DayChallengeOptionalDifficuly2_4",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_4_CN|敌人伤害 +25%"
  },
  DayChallengeOptionalDifficuly2_5 = {
    ID = "DayChallengeOptionalDifficuly2_5",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_5_CN|敌人伤害 +40%"
  },
  DayChallengeOptionalDifficuly2_6 = {
    ID = "DayChallengeOptionalDifficuly2_6",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_6_CN|敌人伤害 +55%"
  },
  DayChallengeOptionalDifficuly2_7 = {
    ID = "DayChallengeOptionalDifficuly2_7",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_7_CN|敌人伤害 +70%"
  },
  DayChallengeOptionalDifficuly2_8 = {
    ID = "DayChallengeOptionalDifficuly2_8",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_8_CN|敌人伤害 +90%"
  },
  DayChallengeOptionalDifficuly2_9 = {
    ID = "DayChallengeOptionalDifficuly2_9",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_9_CN|敌人伤害 +120%"
  },
  DayChallengeOptionalDifficuly2_10 = {
    ID = "DayChallengeOptionalDifficuly2_10",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_10_CN|敌人伤害 +150%"
  },
  DayChallengeOptionalDifficuly2_11 = {
    ID = "DayChallengeOptionalDifficuly2_11",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_11_CN|敌人伤害 +200%"
  },
  DayChallengeOptionalDifficuly2_12 = {
    ID = "DayChallengeOptionalDifficuly2_12",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_12_CN|敌人伤害 +220%"
  },
  DayChallengeOptionalDifficuly2_13 = {
    ID = "DayChallengeOptionalDifficuly2_13",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_13_CN|敌人伤害 +240%"
  },
  DayChallengeOptionalDifficuly2_14 = {
    ID = "DayChallengeOptionalDifficuly2_14",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_14_CN|敌人伤害 +260%"
  },
  DayChallengeOptionalDifficuly2_15 = {
    ID = "DayChallengeOptionalDifficuly2_15",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_15_CN|敌人伤害 +280%"
  },
  DayChallengeOptionalDifficuly2_16 = {
    ID = "DayChallengeOptionalDifficuly2_16",
    CN = "LanguageConfig_DayChallengeOptionalDifficuly2_16_CN|敌人伤害 +300%"
  },
  RateStr = {
    ID = "RateStr",
    CN = "LanguageConfig_RateStr_CN|倍率×{s1}"
  },
  RateStrColored = {
    ID = "RateStrColored",
    CN = "LanguageConfig_RateStrColored_CN|倍率<color=#5EF2FF>×{s1}</color>"
  },
  D05EX_Activity_Card_Tips = {
    ID = "D05EX_Activity_Card_Tips",
    CN = "LanguageConfig_D05EX_Activity_Card_Tips_CN|面对猜疑，做出抉择"
  },
  D05EX_Activity_Light_String = {
    ID = "D05EX_Activity_Light_String",
    CN = "LanguageConfig_D05EX_Activity_Light_String_CN|，补充 3 名团员"
  },
  Monster_B05EX_SideDia1 = {
    ID = "Monster_B05EX_SideDia1",
    CN = "LanguageConfig_Monster_B05EX_SideDia1_CN|聆听吧…亘古寒冰的低语…！"
  },
  Monster_B05EX_SideDia2 = {
    ID = "Monster_B05EX_SideDia2",
    CN = "LanguageConfig_Monster_B05EX_SideDia2_CN|群山…在寒焰中苏醒…！"
  },
  Monster_B05EX_SideDia3 = {
    ID = "Monster_B05EX_SideDia3",
    CN = "LanguageConfig_Monster_B05EX_SideDia3_CN|每打出 3 张卡牌后会冻结 1 张指令卡，小心行事！"
  },
  Monster_B05EX_SideDia4 = {
    ID = "Monster_B05EX_SideDia4",
    CN = "LanguageConfig_Monster_B05EX_SideDia4_CN|残余的冻结卡牌本回合会被全部粉碎，并化为敌人的伤害…当心！"
  },
  Monster_B05EX_SideDia5 = {
    ID = "Monster_B05EX_SideDia5",
    CN = "LanguageConfig_Monster_B05EX_SideDia5_CN|当心！朵尔的「终末」正在堆积……达到 10层后她将引来真正的末日……"
  },
  Monster_B05EX_SideDia6 = {
    ID = "Monster_B05EX_SideDia6",
    CN = "LanguageConfig_Monster_B05EX_SideDia6_CN|主君的力量，我见证了……"
  },
  Monster_B05EX_SideDia7 = {
    ID = "Monster_B05EX_SideDia7",
    CN = "LanguageConfig_Monster_B05EX_SideDia7_CN|击破其护盾能够使其受到大量伤害，但也会使其获得临时力量。小心行事。"
  },
  Monster_B05EX_SideDia8 = {
    ID = "Monster_B05EX_SideDia8",
    CN = "LanguageConfig_Monster_B05EX_SideDia8_CN|我将永远守护这份誓言！"
  },
  Monster_B05EX_SideDia9 = {
    ID = "Monster_B05EX_SideDia9",
    CN = "LanguageConfig_Monster_B05EX_SideDia9_CN|只要缸中之脑不灭，「我」就源源不断。思考，然后行动。"
  },
  Monster_B05EX_SideDia10 = {
    ID = "Monster_B05EX_SideDia10",
    CN = "LanguageConfig_Monster_B05EX_SideDia10_CN|斩断链接之人带着怎样的力量与决心，让我看看吧，守密人。"
  },
  Monster_B05EX_SideDia11 = {
    ID = "Monster_B05EX_SideDia11",
    CN = "LanguageConfig_Monster_B05EX_SideDia11_CN|链接正在逐渐减弱…如果这就是你坚持的道路的话，我会支持你的。"
  },
  Monster_B05EX_SideDia12 = {
    ID = "Monster_B05EX_SideDia12",
    CN = "LanguageConfig_Monster_B05EX_SideDia12_CN|挣扎在无尽的融蚀黑潮中吧——深渊之门，已然开启！"
  },
  Monster_B05EX_SideDia13 = {
    ID = "Monster_B05EX_SideDia13",
    CN = "LanguageConfig_Monster_B05EX_SideDia13_CN|当心！朵尔的「终末」正在堆积……达到 10层后她将引来真正的末日……"
  },
  Monster_B05EX_SideDia15 = {
    ID = "Monster_B05EX_SideDia15",
    CN = "LanguageConfig_Monster_B05EX_SideDia15_CN|末日…终于降临了！"
  },
  Monster_B05EX_SideDia16 = {
    ID = "Monster_B05EX_SideDia16",
    CN = "LanguageConfig_Monster_B05EX_SideDia16_CN|在深暗的未知面前，化为虚无吧。"
  },
  Monster_B05EX_SideDia17 = {
    ID = "Monster_B05EX_SideDia17",
    CN = "LanguageConfig_Monster_B05EX_SideDia17_CN|朵尔分体在受到致死伤害后，会移动到后排并造成更高的伤害！控制节奏！"
  },
  Monster_B05EX_SideDia18 = {
    ID = "Monster_B05EX_SideDia18",
    CN = "LanguageConfig_Monster_B05EX_SideDia18_CN|真可惜。又要浪费一个备用躯体。"
  },
  Monster_B05EX_SideDia19 = {
    ID = "Monster_B05EX_SideDia19",
    CN = "LanguageConfig_Monster_B05EX_SideDia19_CN|这就是我的第一哲学。"
  },
  Monster_B05EX_SideDia20 = {
    ID = "Monster_B05EX_SideDia20",
    CN = "LanguageConfig_Monster_B05EX_SideDia20_CN|1……"
  },
  Monster_B05EX_SideDia21 = {
    ID = "Monster_B05EX_SideDia21",
    CN = "LanguageConfig_Monster_B05EX_SideDia21_CN|2……"
  },
  Monster_B05EX_SideDia22 = {
    ID = "Monster_B05EX_SideDia22",
    CN = "LanguageConfig_Monster_B05EX_SideDia22_CN|3……"
  },
  Monster_B05EX_SideDia23 = {
    ID = "Monster_B05EX_SideDia23",
    CN = "LanguageConfig_Monster_B05EX_SideDia23_CN|4……"
  },
  Monster_B05EX_SideDia24 = {
    ID = "Monster_B05EX_SideDia24",
    CN = "LanguageConfig_Monster_B05EX_SideDia24_CN|5……再快一点……"
  },
  Monster_B05EX_SideDia25 = {
    ID = "Monster_B05EX_SideDia25",
    CN = "LanguageConfig_Monster_B05EX_SideDia25_CN|6……"
  },
  Monster_B05EX_SideDia26 = {
    ID = "Monster_B05EX_SideDia26",
    CN = "LanguageConfig_Monster_B05EX_SideDia26_CN|7……"
  },
  Monster_B05EX_SideDia27 = {
    ID = "Monster_B05EX_SideDia27",
    CN = "LanguageConfig_Monster_B05EX_SideDia27_CN|8……"
  },
  Monster_B05EX_SideDia28 = {
    ID = "Monster_B05EX_SideDia28",
    CN = "LanguageConfig_Monster_B05EX_SideDia28_CN|9……"
  },
  Monster_B05EX_SideDia29 = {
    ID = "Monster_B05EX_SideDia29",
    CN = "LanguageConfig_Monster_B05EX_SideDia29_CN|10！末日…终于降临了！"
  },
  Monster_B05EX_SideDia30 = {
    ID = "Monster_B05EX_SideDia30",
    CN = "LanguageConfig_Monster_B05EX_SideDia30_CN|终末，即将降临…！"
  },
  Monster_B05EX_SideDia31 = {
    ID = "Monster_B05EX_SideDia31",
    CN = "LanguageConfig_Monster_B05EX_SideDia31_CN|亲眼见证终末吧！"
  },
  Monster_B05EX_SideDia32 = {
    ID = "Monster_B05EX_SideDia32",
    CN = "LanguageConfig_Monster_B05EX_SideDia32_CN|这里可是我的实验室…"
  },
  Monster_B05EX_SideDia33 = {
    ID = "Monster_B05EX_SideDia33",
    CN = "LanguageConfig_Monster_B05EX_SideDia33_CN|好久不见，搭档。"
  },
  Monster_S2B0001_Name1 = {
    ID = "Monster_S2B0001_Name1",
    CN = "LanguageConfig_Monster_S2B0001_Name1_CN|@1go-@4 8"
  },
  Monster_S2B0002_Name1 = {
    ID = "Monster_S2B0002_Name1",
    CN = "LanguageConfig_Monster_S2B0002_Name1_CN|「宇宙@2投影」"
  },
  Speicial_kuangre1 = {
    ID = "Speicial_kuangre1",
    CN = "LanguageConfig_Speicial_kuangre1_CN|即将进入「指令狂热」状态，当前剩余 3 张指令卡……"
  },
  Speicial_kuangre2 = {
    ID = "Speicial_kuangre2",
    CN = "LanguageConfig_Speicial_kuangre2_CN|即将进入「指令狂热」状态，当前剩余 2 张指令卡……"
  },
  Speicial_kuangre3 = {
    ID = "Speicial_kuangre3",
    CN = "LanguageConfig_Speicial_kuangre3_CN|即将进入「指令狂热」状态，当前剩余 1 张指令卡……"
  },
  Speicial_kuangre4 = {
    ID = "Speicial_kuangre4",
    CN = "LanguageConfig_Speicial_kuangre4_CN|已进入「指令狂热」！本回合每打出 1 张指令卡，指令卡算力消耗+1，额外获得 100 点狂气。"
  },
  WorldBossDoing = {
    ID = "WorldBossDoing",
    CN = "LanguageConfig_WorldBossDoing_CN|与其他守密人协同作战，获取珍稀奖励"
  },
  WorldBossDone = {
    ID = "WorldBossDone",
    CN = "LanguageConfig_WorldBossDone_CN|所有原初之视的分身均已被消灭"
  },
  ConitinueSurvey = {
    ID = "ConitinueSurvey",
    CN = "LanguageConfig_ConitinueSurvey_CN|继续调查"
  },
  TextFightBoss = {
    ID = "TextFightBoss",
    CN = "LanguageConfig_TextFightBoss_CN|辰星安魂曲"
  },
  TextBossProgress = {
    ID = "TextBossProgress",
    CN = "LanguageConfig_TextBossProgress_CN|再战原初进度：{s1}<color=#A7B9C3>/{s2}</color>"
  },
  TextUnlockEvent = {
    ID = "TextUnlockEvent",
    CN = "LanguageConfig_TextUnlockEvent_CN|完成「{s1}」后解锁"
  },
  TextActOpenTime = {
    ID = "TextActOpenTime",
    CN = "LanguageConfig_TextActOpenTime_CN|「s1」将于{s2}后开启"
  },
  TextEventNotFinished = {
    ID = "TextEventNotFinished",
    CN = "LanguageConfig_TextEventNotFinished_CN|完成「{s1}」后解锁"
  },
  AlertBossKilled = {
    ID = "AlertBossKilled",
    CN = "LanguageConfig_AlertBossKilled_CN|该原初之视的所有分身均已被消灭，无法继续挑战"
  },
  PVPBPLockTxt = {
    ID = "PVPBPLockTxt",
    CN = "LanguageConfig_PVPBPLockTxt_CN|解锁核心课题，本期课题可使用所有卡牌"
  },
  PVPBPUnLockTxt = {
    ID = "PVPBPUnLockTxt",
    CN = "LanguageConfig_PVPBPUnLockTxt_CN|本期课题限时解锁中"
  },
  ExpiredText = {
    ID = "ExpiredText",
    CN = "LanguageConfig_ExpiredText_CN|以下物品已过期，将无法使用"
  },
  ExpiredConvertText = {
    ID = "ExpiredConvertText",
    CN = "LanguageConfig_ExpiredConvertText_CN|部分物品已转换"
  },
  Monster_B0009_SideDia1 = {
    ID = "Monster_B0009_SideDia1",
    CN = "LanguageConfig_Monster_B0009_SideDia1_CN|*&…………*&%&"
  },
  Monster_B0009_SideDia2 = {
    ID = "Monster_B0009_SideDia2",
    CN = "LanguageConfig_Monster_B0009_SideDia2_CN|&%……&重……&启&&*……破碎……"
  },
  Monster_B0009_SideDia3 = {
    ID = "Monster_B0009_SideDia3",
    CN = "LanguageConfig_Monster_B0009_SideDia3_CN|原初的混沌即将在数回合后降临…但当务之急是应对这些源源不断的目光…在合适的时机击破敌人来获得喘息！"
  },
  Monster_B0009_SideDia4 = {
    ID = "Monster_B0009_SideDia4",
    CN = "LanguageConfig_Monster_B0009_SideDia4_CN|&%…万千世界%……¥&*…降临………"
  },
  Monster_B0009_SideDia5 = {
    ID = "Monster_B0009_SideDia5",
    CN = "LanguageConfig_Monster_B0009_SideDia5_CN|……融蚀……消亡"
  },
  Monster_B0009_SideDia6 = {
    ID = "Monster_B0009_SideDia6",
    CN = "LanguageConfig_Monster_B0009_SideDia6_CN|……无上……威压"
  },
  Monster_B0009_SideDia7 = {
    ID = "Monster_B0009_SideDia7",
    CN = "LanguageConfig_Monster_B0009_SideDia7_CN|……遗忘……"
  },
  Monster_B0009_SideDia8 = {
    ID = "Monster_B0009_SideDia8",
    CN = "LanguageConfig_Monster_B0009_SideDia8_CN|……锁链……"
  },
  Monster_B0009_SideDia9 = {
    ID = "Monster_B0009_SideDia9",
    CN = "LanguageConfig_Monster_B0009_SideDia9_CN|融蚀雾盾已被破除！旅途的追忆重新回到了你的抽牌堆，这使你充满了决心…"
  },
  Monster_FL01 = {
    ID = "Monster_FL01",
    CN = "LanguageConfig_Monster_FL01_CN|迟缓效果让你难以打出卡牌！多多释放狂气爆发来战胜悲泣之化身！"
  },
  Monster_FL02 = {
    ID = "Monster_FL02",
    CN = "LanguageConfig_Monster_FL02_CN|蜡像馆的灵魂渴望你的狂气…回转更多的指令卡来战胜恐惧之化身！"
  },
  Monster_FL03 = {
    ID = "Monster_FL03",
    CN = "LanguageConfig_Monster_FL03_CN|特定卡牌会被逐渐溶解……把握你无法放弃的…从而战胜刺骨之化身……"
  },
  Monster_FL04 = {
    ID = "Monster_FL04",
    CN = "LanguageConfig_Monster_FL04_CN|锁链与维度壁障是梭行维度之犬的拿手好戏……每回合尝试打出伤害即可战胜诡谲之化身……"
  },
  Monster_FL05 = {
    ID = "Monster_FL05",
    CN = "LanguageConfig_Monster_FL05_CN|通常的攻击手段似乎不太起作用…尝试换个思路来击破邪信之化身……"
  },
  Monster_FL06 = {
    ID = "Monster_FL06",
    CN = "LanguageConfig_Monster_FL06_CN|敌人会让你陷入疯狂…银钥或许能让你找回一部分理智…战胜疯狂之化身吧。"
  },
  Monster_FL07 = {
    ID = "Monster_FL07",
    CN = "LanguageConfig_Monster_FL07_CN|敌人的再生能力极强且能够清除各种状态！尝试一举击破诞临之化身！"
  },
  Tuluhuodong1 = {
    ID = "Tuluhuodong1",
    CN = "LanguageConfig_Tuluhuodong1_CN|选择「沉眠」或「苏醒」。"
  },
  Monster_FL08 = {
    ID = "Monster_FL08",
    CN = "LanguageConfig_Monster_FL08_CN|姐姐…我原本想和你说些什么…"
  },
  Monster_FL09 = {
    ID = "Monster_FL09",
    CN = "LanguageConfig_Monster_FL09_CN|拥抱吧…我们一起…就不会消失…"
  },
  Monster_FL10 = {
    ID = "Monster_FL10",
    CN = "LanguageConfig_Monster_FL10_CN|请告诉我，真正的你是谁？"
  },
  Monster_FL11 = {
    ID = "Monster_FL11",
    CN = "LanguageConfig_Monster_FL11_CN|不会的，不会的…那是治疗…"
  },
  Monster_FL12 = {
    ID = "Monster_FL12",
    CN = "LanguageConfig_Monster_FL12_CN|这里可是我的实验室…"
  },
  Monster_FL13 = {
    ID = "Monster_FL13",
    CN = "LanguageConfig_Monster_FL13_CN|终末，即将降临…！"
  },
  Monster_FL14 = {
    ID = "Monster_FL14",
    CN = "LanguageConfig_Monster_FL14_CN|亲眼见证终末吧！"
  },
  Monster_FL15 = {
    ID = "Monster_FL15",
    CN = "LanguageConfig_Monster_FL15_CN|@1go-@4 8的融蚀雾盾已被破除，承受的伤害大幅提高，趁此一举击溃祂……！"
  },
  Monster_FL16 = {
    ID = "Monster_FL16",
    CN = "LanguageConfig_Monster_FL16_CN|@3想给你@3心理咨询@3"
  },
  Monster_FL17 = {
    ID = "Monster_FL17",
    CN = "LanguageConfig_Monster_FL17_CN|@4痛楚……@2更多……"
  },
  Monster_FL19 = {
    ID = "Monster_FL19",
    CN = "LanguageConfig_Monster_FL19_CN|当心，每次释放狂气爆发敌人都会获得临时疯狂。"
  },
  Monster_FL18 = {
    ID = "Monster_FL18",
    CN = "LanguageConfig_Monster_FL18_CN|敌人正在与巢群意志沟通，趁此发起攻击吧！"
  },
  Monster_FL20 = {
    ID = "Monster_FL20",
    CN = "LanguageConfig_Monster_FL20_CN|医生……医生！@1救我！"
  },
  Monster_FL21 = {
    ID = "Monster_FL21",
    CN = "LanguageConfig_Monster_FL21_CN|@2们，献上……你@1的痛苦"
  },
  Monster_FL22 = {
    ID = "Monster_FL22",
    CN = "LanguageConfig_Monster_FL22_CN|与我……链接……"
  },
  Monster_FL23 = {
    ID = "Monster_FL23",
    CN = "LanguageConfig_Monster_FL23_CN|敌人获得了大量力量，但同时获得了旧日余烬，每回合受到的伤害提高……"
  },
  Monster_FL24 = {
    ID = "Monster_FL24",
    CN = "LanguageConfig_Monster_FL24_CN|选择 1 名唤醒体，封印其所有卡牌和狂气爆发 3 回合。"
  },
  Monster_FL25 = {
    ID = "Monster_FL25",
    CN = "LanguageConfig_Monster_FL25_CN|超维@1之蛹正在积蓄宇宙幽能，尽可能击杀虫族来打断它…！"
  },
  StageChapterMorimens = {
    ID = "StageChapterMorimens",
    CN = "LanguageConfig_StageChapterMorimens_CN|忘却篇"
  },
  StageChapterStarsCameRight = {
    ID = "StageChapterStarsCameRight",
    CN = "LanguageConfig_StageChapterStarsCameRight_CN|星辰篇"
  },
  StageChapterMorimens_Full = {
    ID = "StageChapterMorimens_Full",
    CN = "LanguageConfig_StageChapterMorimens_Full_CN|忘却前夜"
  },
  StageChapterStarsCameRight_Full = {
    ID = "StageChapterStarsCameRight_Full",
    CN = "LanguageConfig_StageChapterStarsCameRight_Full_CN|星辰正位之刻"
  },
  RenderChangeCDTips = {
    ID = "RenderChangeCDTips",
    CN = "LanguageConfig_RenderChangeCDTips_CN|切换性别功能{s1}后冷却完毕"
  },
  Monster_Z0001_SideDia1 = {
    ID = "Monster_Z0001_SideDia1",
    CN = "LanguageConfig_Monster_Z0001_SideDia1_CN|今天捣点什么乱好呢……"
  },
  Monster_Z0001_SideDia2 = {
    ID = "Monster_Z0001_SideDia2",
    CN = "LanguageConfig_Monster_Z0001_SideDia2_CN|来一场绅士的决斗！"
  },
  Monster_Z0001_SideDia3 = {
    ID = "Monster_Z0001_SideDia3",
    CN = "LanguageConfig_Monster_Z0001_SideDia3_CN|哎呀，银芯从帽子里掉出来了……"
  },
  Monster_Z0001_SideDia4 = {
    ID = "Monster_Z0001_SideDia4",
    CN = "LanguageConfig_Monster_Z0001_SideDia4_CN|喵嗷——你们不能这样对一个绅士！"
  },
  Monster_Z0001_SideDia5 = {
    ID = "Monster_Z0001_SideDia5",
    CN = "LanguageConfig_Monster_Z0001_SideDia5_CN|一起度过热闹的夜晚！"
  },
  ChangeGenderFreeTips = {
    ID = "ChangeGenderFreeTips",
    CN = "LanguageConfig_ChangeGenderFreeTips_CN|首次免费"
  },
  ChangeGenderCost = {
    ID = "ChangeGenderCost",
    CN = "LanguageConfig_ChangeGenderCost_CN|本次需要消耗{s1}"
  },
  StoreGiveBlood = {
    ID = "StoreGiveBlood",
    CN = "LanguageConfig_StoreGiveBlood_CN|失去 <color=#BB646D> {s1} </color> 点生命，获得 {s2} 枚黑印。"
  },
  StoreGiveBloodTitle = {
    ID = "StoreGiveBloodTitle",
    CN = "LanguageConfig_StoreGiveBloodTitle_CN|感应"
  },
  WorldstageShopRelicStrengthTitle = {
    ID = "WorldstageShopRelicStrengthTitle",
    CN = "LanguageConfig_WorldstageShopRelicStrengthTitle_CN|祭祀"
  },
  WorldstageShopRelicStrength = {
    ID = "WorldstageShopRelicStrength",
    CN = "LanguageConfig_WorldstageShopRelicStrength_CN|花费黑印将白银造物强化为黄金，每次强化花费黑印都会提高。"
  },
  ContainOneSchool = {
    ID = "ContainOneSchool",
    CN = "LanguageConfig_ContainOneSchool_CN|必须包含"
  },
  SchoolRequired = {
    ID = "SchoolRequired",
    CN = "LanguageConfig_SchoolRequired_CN|要求界域"
  },
  TeamSchoolRequired = {
    ID = "TeamSchoolRequired",
    CN = "LanguageConfig_TeamSchoolRequired_CN|队伍要求"
  },
  RelicStrengthShopTitle = {
    ID = "RelicStrengthShopTitle",
    CN = "LanguageConfig_RelicStrengthShopTitle_CN|选择{s1}个造物进行强化"
  },
  GenderChangeConfirmTitle = {
    ID = "GenderChangeConfirmTitle",
    CN = "LanguageConfig_GenderChangeConfirmTitle_CN|切换性别"
  },
  GenderChangeConfirmContent = {
    ID = "GenderChangeConfirmContent",
    CN = "LanguageConfig_GenderChangeConfirmContent_CN|将守密人性别切换为<Blue:「{s1}」>，体验游戏剧情。"
  },
  GenderChangeConfirmFreeTips = {
    ID = "GenderChangeConfirmFreeTips",
    CN = "LanguageConfig_GenderChangeConfirmFreeTips_CN|本次修改免费，之后修改将消耗<Blue:「{s1}」× {s2}>。"
  },
  SpecialShopName = {
    ID = "SpecialShopName",
    CN = "LanguageConfig_SpecialShopName_CN|灰烬遗迹"
  },
  Refresh = {
    ID = "Refresh",
    CN = "LanguageConfig_Refresh_CN|刷新"
  },
  GenderChangeSuccessfulTips = {
    ID = "GenderChangeSuccessfulTips",
    CN = "LanguageConfig_GenderChangeSuccessfulTips_CN|已修改性别为：{s1}"
  },
  KilledMonsterCount = {
    ID = "KilledMonsterCount",
    CN = "LanguageConfig_KilledMonsterCount_CN|已抓捕 <color=#5EF2FF> {s1} </color> 只"
  },
  ServerWideKilledMonstersCount = {
    ID = "ServerWideKilledMonstersCount",
    CN = "LanguageConfig_ServerWideKilledMonstersCount_CN|全维度已抓捕 <color=#5EF2FF> {s1} </color> 只"
  },
  CollectionUnlockItem = {
    ID = "CollectionUnlockItem",
    CN = "LanguageConfig_CollectionUnlockItem_CN|解锁此背景动画需要<Blue:「{s1}」×{s2}>。\n解锁后可设置为宿舍背景。"
  },
  CollectionUnlockItemTitle = {
    ID = "CollectionUnlockItemTitle",
    CN = "LanguageConfig_CollectionUnlockItemTitle_CN|解锁"
  },
  ItemUseTimes = {
    ID = "ItemUseTimes",
    CN = "LanguageConfig_ItemUseTimes_CN|使用次数"
  },
  BattleWaves = {
    ID = "BattleWaves",
    CN = "LanguageConfig_BattleWaves_CN|波次 {s1}/{s2}"
  },
  SpecialShopCustomSoldOutTips = {
    ID = "SpecialShopCustomSoldOutTips",
    CN = "LanguageConfig_SpecialShopCustomSoldOutTips_CN|「感应」在单个灰烬遗迹中只能使用 1 次"
  },
  AutoFightForbid = {
    ID = "AutoFightForbid",
    CN = "LanguageConfig_AutoFightForbid_CN|本场战斗不支持自动战斗，请用自己的策略通关吧"
  },
  BenyuanDuoerHuodong1 = {
    ID = "BenyuanDuoerHuodong1",
    CN = "LanguageConfig_BenyuanDuoerHuodong1_CN|选择一项未进行的研究。"
  },
  BenyuanDuoerHuodong2 = {
    ID = "BenyuanDuoerHuodong2",
    CN = "LanguageConfig_BenyuanDuoerHuodong2_CN|选择 3 张指令卡赋予「合奏」刻印。"
  },
  VerificationAgeFormat1 = {
    ID = "VerificationAgeFormat1",
    CN = "LanguageConfig_VerificationAgeFormat1_CN|{s1}岁以下"
  },
  VerificationAgeFormat2 = {
    ID = "VerificationAgeFormat2",
    CN = "LanguageConfig_VerificationAgeFormat2_CN|{s1}岁~{s2}岁"
  },
  VerificationAgeLimit = {
    ID = "VerificationAgeLimit",
    CN = "LanguageConfig_VerificationAgeLimit_CN|每月最高{s1}日元"
  },
  SeasonName_0 = {
    ID = "SeasonName_0",
    CN = "LanguageConfig_SeasonName_0_CN|赛季0名称"
  },
  SeasonName_1 = {
    ID = "SeasonName_1",
    CN = "LanguageConfig_SeasonName_1_CN|赛季1名称"
  },
  SeasonName_2 = {
    ID = "SeasonName_2",
    CN = "LanguageConfig_SeasonName_2_CN|赛季2名称"
  },
  SeasonName_3 = {
    ID = "SeasonName_3",
    CN = "LanguageConfig_SeasonName_3_CN|赛季3名称"
  },
  SeasonName_4 = {
    ID = "SeasonName_4",
    CN = "LanguageConfig_SeasonName_4_CN|赛季4名称"
  },
  SeasonDesc_0 = {
    ID = "SeasonDesc_0",
    CN = "LanguageConfig_SeasonDesc_0_CN|赛季0描述"
  },
  SeasonDesc_1 = {
    ID = "SeasonDesc_1",
    CN = "LanguageConfig_SeasonDesc_1_CN|赛季1描述"
  },
  SeasonDesc_2 = {
    ID = "SeasonDesc_2",
    CN = "LanguageConfig_SeasonDesc_2_CN|赛季2描述"
  },
  SeasonDesc_3 = {
    ID = "SeasonDesc_3",
    CN = "LanguageConfig_SeasonDesc_3_CN|赛季3描述"
  },
  SeasonDesc_4 = {
    ID = "SeasonDesc_4",
    CN = "LanguageConfig_SeasonDesc_4_CN|赛季4描述"
  },
  SpecialShopRefreshCostLabel = {
    ID = "SpecialShopRefreshCostLabel",
    CN = "LanguageConfig_SpecialShopRefreshCostLabel_CN|花费"
  },
  SpecialShopNoStrengthRelicTips = {
    ID = "SpecialShopNoStrengthRelicTips",
    CN = "LanguageConfig_SpecialShopNoStrengthRelicTips_CN|无造物可被强化。"
  },
  LikeBounusTips = {
    ID = "LikeBounusTips",
    CN = "LanguageConfig_LikeBounusTips_CN|{s1}同调率加成"
  },
  ReRoundRewardTitle = {
    ID = "ReRoundRewardTitle",
    CN = "LanguageConfig_ReRoundRewardTitle_CN|回合奇赏"
  },
  ReRoundScoreStr = {
    ID = "ReRoundScoreStr",
    CN = "LanguageConfig_ReRoundScoreStr_CN|当前魔法橡果数量:{s1}"
  },
  ReRoundNoReward = {
    ID = "ReRoundNoReward",
    CN = "LanguageConfig_ReRoundNoReward_CN|当前没有可领取的任务，快去参加「相位对弈」"
  },
  ReadAllStr = {
    ID = "ReadAllStr",
    CN = "LanguageConfig_ReadAllStr_CN|全部已读"
  },
  TaskAvgUnlockStr = {
    ID = "TaskAvgUnlockStr",
    CN = "LanguageConfig_TaskAvgUnlockStr_CN|剧情解锁"
  },
  DaFuDaiErHuodong1 = {
    ID = "DaFuDaiErHuodong1",
    CN = "LanguageConfig_DaFuDaiErHuodong1_CN|获得一张自定义的「禁忌的交易」。"
  },
  PvpOnlyKeeperSkillClickTips = {
    ID = "PvpOnlyKeeperSkillClickTips",
    CN = "LanguageConfig_PvpOnlyKeeperSkillClickTips_CN|该钥令为「相位对弈」专属钥令，暂不可在调查中使用"
  },
  PVPAwakerTrain = {
    ID = "PVPAwakerTrain",
    CN = "LanguageConfig_PVPAwakerTrain_CN|唤醒体试训"
  },
  PVPTraning_EnemyName = {
    ID = "PVPTraning_EnemyName",
    CN = "LanguageConfig_PVPTraning_EnemyName_CN|弥萨格校猫"
  },
  PVPTraning_ChooseWeapon = {
    ID = "PVPTraning_ChooseWeapon",
    CN = "LanguageConfig_PVPTraning_ChooseWeapon_CN|选择 1 张命轮"
  },
  PVPTraning_ChooseKeeperSkill = {
    ID = "PVPTraning_ChooseKeeperSkill",
    CN = "LanguageConfig_PVPTraning_ChooseKeeperSkill_CN|选择 1 张钥令"
  },
  PVPTraning_ResetCooldown = {
    ID = "PVPTraning_ResetCooldown",
    CN = "LanguageConfig_PVPTraning_ResetCooldown_CN|重置功能冷却中，请稍后再试"
  },
  Card_Select_Discard_Tips2 = {
    ID = "Card_Select_Discard_Tips2",
    CN = "LanguageConfig_Card_Select_Discard_Tips2_CN|选择 2 张牌丢弃"
  },
  AwakerSkin = {
    ID = "AwakerSkin",
    CN = "LanguageConfig_AwakerSkin_CN|幻衣"
  },
  DefaultWord = {
    ID = "DefaultWord",
    CN = "LanguageConfig_DefaultWord_CN|默认"
  },
  DressingWord = {
    ID = "DressingWord",
    CN = "LanguageConfig_DressingWord_CN|着装中"
  },
  ChangeDress = {
    ID = "ChangeDress",
    CN = "LanguageConfig_ChangeDress_CN|换装"
  },
  OffSell = {
    ID = "OffSell",
    CN = "LanguageConfig_OffSell_CN|已下架"
  },
  Owned = {
    ID = "Owned",
    CN = "LanguageConfig_Owned_CN|已拥有"
  },
  UnGotStr = {
    ID = "UnGotStr",
    CN = "LanguageConfig_UnGotStr_CN|未获得"
  },
  GoGetWord = {
    ID = "GoGetWord",
    CN = "LanguageConfig_GoGetWord_CN|前往购买"
  },
  DrawEmptyStr = {
    ID = "DrawEmptyStr",
    CN = "LanguageConfig_DrawEmptyStr_CN|已获取所有奖励"
  },
  DrawOneStr = {
    ID = "DrawOneStr",
    CN = "LanguageConfig_DrawOneStr_CN|抽取1次"
  },
  LeftNumStr = {
    ID = "LeftNumStr",
    CN = "LanguageConfig_LeftNumStr_CN|{s1}({s2}/{s3})"
  },
  PrizeNum1 = {
    ID = "PrizeNum1",
    CN = "LanguageConfig_PrizeNum1_CN|一等奖"
  },
  PrizeNum2 = {
    ID = "PrizeNum2",
    CN = "LanguageConfig_PrizeNum2_CN|二等奖"
  },
  PrizeNum3 = {
    ID = "PrizeNum3",
    CN = "LanguageConfig_PrizeNum3_CN|三等奖"
  },
  PrizeNum4 = {
    ID = "PrizeNum4",
    CN = "LanguageConfig_PrizeNum4_CN|四等奖"
  },
  PrizeNum5 = {
    ID = "PrizeNum5",
    CN = "LanguageConfig_PrizeNum5_CN|五等奖"
  },
  PrizeNum6 = {
    ID = "PrizeNum6",
    CN = "LanguageConfig_PrizeNum6_CN|六等奖"
  },
  PrizeNum7 = {
    ID = "PrizeNum7",
    CN = "LanguageConfig_PrizeNum7_CN|七等奖"
  },
  PrizeNum8 = {
    ID = "PrizeNum8",
    CN = "LanguageConfig_PrizeNum8_CN|八等奖"
  },
  PrizeNum9 = {
    ID = "PrizeNum9",
    CN = "LanguageConfig_PrizeNum9_CN|九等奖"
  },
  PrizeNum10 = {
    ID = "PrizeNum10",
    CN = "LanguageConfig_PrizeNum10_CN|十等奖"
  },
  TapToSummon = {
    ID = "TapToSummon",
    CN = "LanguageConfig_TapToSummon_CN|点击插入银钥"
  },
  AwakerSkinTypeName = {
    ID = "AwakerSkinTypeName",
    CN = "LanguageConfig_AwakerSkinTypeName_CN|幻衣"
  },
  TitleReward = {
    ID = "TitleReward",
    CN = "LanguageConfig_TitleReward_CN|奖项"
  },
  TitleRewardItems = {
    ID = "TitleRewardItems",
    CN = "LanguageConfig_TitleRewardItems_CN|奖励道具"
  },
  TitleRate = {
    ID = "TitleRate",
    CN = "LanguageConfig_TitleRate_CN|概率"
  },
  GetConditionStr = {
    ID = "GetConditionStr",
    CN = "LanguageConfig_GetConditionStr_CN|第{s1}次开始有机会获得"
  },
  AlreadyGot = {
    ID = "AlreadyGot",
    CN = "LanguageConfig_AlreadyGot_CN|已获得"
  },
  KarenActivityRewardTitle = {
    ID = "KarenActivityRewardTitle",
    CN = "LanguageConfig_KarenActivityRewardTitle_CN|除尘津贴"
  },
  KarenActivityRewardBottomText = {
    ID = "KarenActivityRewardBottomText",
    CN = "LanguageConfig_KarenActivityRewardBottomText_CN|当前清扫工具 {s1}"
  },
  SummonSelectAwakerOwnedLabel = {
    ID = "SummonSelectAwakerOwnedLabel",
    CN = "LanguageConfig_SummonSelectAwakerOwnedLabel_CN|已拥有"
  },
  SummonSelectAwakePanelDesc = {
    ID = "SummonSelectAwakePanelDesc",
    CN = "LanguageConfig_SummonSelectAwakePanelDesc_CN|1、循序命理：守密人可从本期循序命理唤醒活动可选的唤醒体列表中选择 1 名作为本次定向唤醒的目标。\n2、推荐命轮：选定唤醒体后，将自动选中该唤醒体的推荐命轮！\n3、唤醒概率UP：\n·每次通过唤醒获取到SSR时，有33.33%的概率为本期选定的SSR唤醒体或推荐命轮，唤醒体与推荐命轮将平分UP概率。 \n·若本次唤醒获取的SSR非本期选定的SSR唤醒体或命轮，则下次通过唤醒获取的SSR必定为本期选定的SSR唤醒体或命轮。\n·若连续2次唤醒获取到相同本期UP物品，则下次通过唤醒获取的UP必定为另一本期UP物品。\n4、唤醒体与其推荐命轮一旦选定后，本期无法再更改定向唤醒对象。"
  },
  SummonSelectAwakeBtnTips = {
    ID = "SummonSelectAwakeBtnTips",
    CN = "LanguageConfig_SummonSelectAwakeBtnTips_CN|开始选择"
  },
  SummonSelectAwakerBtnUnClickTips = {
    ID = "SummonSelectAwakerBtnUnClickTips",
    CN = "LanguageConfig_SummonSelectAwakerBtnUnClickTips_CN|请先选中唤醒体"
  },
  ResetTaskTimeCountdown = {
    ID = "ResetTaskTimeCountdown",
    CN = "LanguageConfig_ResetTaskTimeCountdown_CN|{s1}小时{s2}分钟后重置"
  },
  GoldenWeekSummonDesc1 = {
    ID = "GoldenWeekSummonDesc1",
    CN = "LanguageConfig_GoldenWeekSummonDesc1_CN|<SummonOrange:选定唤醒体和命轮>获取概率提升！"
  },
  GoldenWeekSummonDesc2 = {
    ID = "GoldenWeekSummonDesc2",
    CN = "LanguageConfig_GoldenWeekSummonDesc2_CN|选定后本期不可再更改"
  },
  SummonType_14SummonDesc1 = {
    ID = "SummonType_14SummonDesc1",
    CN = "LanguageConfig_SummonType_14SummonDesc1_CN|<SummonOrange:自选 {s1} 个唤醒体>概率提升！"
  },
  SummonType_14SummonDesc2 = {
    ID = "SummonType_14SummonDesc2",
    CN = "LanguageConfig_SummonType_14SummonDesc2_CN|选定后本期不可再更改"
  },
  SummonType_14SelectPanelDesc = {
    ID = "SummonType_14SelectPanelDesc",
    CN = "LanguageConfig_SummonType_14SelectPanelDesc_CN|1、角色自选唤醒：守密人可从本期角色自选唤醒活动可选的唤醒体列表中选择 4 个唤醒体作为本次UP目标。\n2、唤醒概率UP：\n·每次通过唤醒获取到SSR时，有50%的概率为本期选定的UP唤醒体之一。 \n·若本次唤醒获取的SSR非本期选定的UP唤醒体，则下次通过唤醒获取的SSR必定为本期选定的UP唤醒体。\n3、UP目标一旦选定后，本期无法再更改定向唤醒对象。"
  },
  SummonType_14SelectTips = {
    ID = "SummonType_14SelectTips",
    CN = "LanguageConfig_SummonType_14SelectTips_CN|选择 {s1} 名「忘却篇」限定唤醒体"
  },
  SummonType_14SelectUpTips = {
    ID = "SummonType_14SelectUpTips",
    CN = "LanguageConfig_SummonType_14SelectUpTips_CN|已选定 {s1} 名概率提升的唤醒体"
  },
  SummonType_14SelectTitle = {
    ID = "SummonType_14SelectTitle",
    CN = "LanguageConfig_SummonType_14SelectTitle_CN|选择 {s1} 名指定唤醒体"
  },
  ActivityMarkOneAndAHalfYears = {
    ID = "ActivityMarkOneAndAHalfYears",
    CN = "LanguageConfig_ActivityMarkOneAndAHalfYears_CN|1.5周年"
  },
  DeepSeaInvasionDefensiveActiviityTips1 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips1",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips1_CN|与其他守密人共同作战，获取珍稀奖励"
  },
  DeepSeaInvasionDefensiveActiviityTips2 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips2",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips2_CN|所有异动海潮集群已被消灭"
  },
  DeepSeaInvasionDefensiveActiviityTips3 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips3",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips3_CN|进入挑战"
  },
  DeepSeaInvasionDefensiveActiviityTips4 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips4",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips4_CN|今日挑战 {s1}"
  },
  DeepSeaInvasionDefensiveActiviityTips5 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips5",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips5_CN|世界BOSS进度"
  },
  DeepSeaInvasionDefensiveActiviityTips6 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips6",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips6_CN|{s1}/7"
  },
  DeepSeaInvasionDefensiveActiviityTips7 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips7",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips7_CN|今日挑战 {s1}"
  },
  DeepSeaInvasionDefensiveActiviityTips8 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips8",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips8_CN|今日挑战 {s1}"
  },
  DeepSeaInvasionDefensiveActiviityTips9 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips9",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips9_CN|等级补偿"
  },
  DeepSeaInvasionDefensiveActiviityTips10 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips10",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips10_CN|已获得等级补偿"
  },
  DeepSeaInvasionDefensiveActiviityTips11 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips11",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips11_CN|已获得等级修正"
  },
  DeepSeaInvasionDefensiveActiviityTips12 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips12",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips12_CN|已获得等级修正"
  },
  DeepSeaInvasionDefensiveActiviityTips13 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips13",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips13_CN|在「猫海淘银」中有等级补偿机制，以便各位守密人能够共同进行抓捕！\n等级补偿规则如下：\n·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n ·若守密人等级不足60级，在本次挑战中将会补偿至60级。"
  },
  DeepSeaInvasionDefensiveActiviityTips14 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips14",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips14_CN|该异动海潮的集群已被消灭，无法继续挑战"
  },
  DeepSeaInvasionDefensiveActiviityTips15 = {
    ID = "DeepSeaInvasionDefensiveActiviityTips15",
    CN = "LanguageConfig_DeepSeaInvasionDefensiveActiviityTips15_CN|所有异动海潮集群已被消灭，无法继续挑战"
  },
  ShopLimitTimeActivity = {
    ID = "ShopLimitTimeActivity",
    CN = "LanguageConfig_ShopLimitTimeActivity_CN|限时活动"
  },
  Monster_Corposant_01 = {
    ID = "Monster_Corposant_01",
    CN = "LanguageConfig_Monster_Corposant_01_CN|冷光，在此领航……"
  },
  Monster_Corposant_02 = {
    ID = "Monster_Corposant_02",
    CN = "LanguageConfig_Monster_Corposant_02_CN|航线已确定，全体注意。"
  },
  Monster_Corposant_03 = {
    ID = "Monster_Corposant_03",
    CN = "LanguageConfig_Monster_Corposant_03_CN|牺牲不可避免，而我已做好了准备。"
  },
  Monster_Corposant_04 = {
    ID = "Monster_Corposant_04",
    CN = "LanguageConfig_Monster_Corposant_04_CN|以雷霆，惩戒反抗者！"
  },
  Monster_Corposant_05 = {
    ID = "Monster_Corposant_05",
    CN = "LanguageConfig_Monster_Corposant_05_CN|我将化为圣艾尔摩之火，照亮前路。"
  },
  Burning_Opera_01 = {
    ID = "Burning_Opera_01",
    CN = "LanguageConfig_Burning_Opera_01_CN|整个剧院已被点燃…虽然火焰能赋予你力量，但要当心那些不断燃烧的卡牌！"
  },
  ResonanceRules = {
    ID = "ResonanceRules",
    CN = "LanguageConfig_ResonanceRules_CN|1、每章调查事件都有共鸣，共鸣可以在调查时提供强力的协助。\n2、首通关卡将会获得共鸣升级材料，消耗材料可以激活共鸣效果。\n3、共鸣将会在地图内的节点出现，移动至共鸣节点上将在本次探索获得共鸣。"
  },
  StarRatingRules = {
    ID = "StarRatingRules",
    CN = "LanguageConfig_StarRatingRules_CN|每关的探索都会根据首领战回合数来获得调查评价，每关最高可以获得3星，积累星数可以获取「银芯」奖励。"
  },
  DailyCopyRules = {
    ID = "DailyCopyRules",
    CN = "LanguageConfig_DailyCopyRules_CN|1、融蚀之墟内通关对应的关卡后可获得大量唤醒体升格素材、「灵知制剂」和「蔷薇金券」!\n2、完成关卡挑战后解锁重现，重现可以立即获得该关卡的任务报酬。每次重现需消耗等同于进行调查所需的「灵啡肽」。\n3、在调查等级达到 20 级后解锁技能素材关卡。\n4、若三星通关高难度关卡，则较低难度的关卡挑战进度会自动标记为三星通关。"
  },
  TrinketCopyRules = {
    ID = "TrinketCopyRules",
    CN = "LanguageConfig_TrinketCopyRules_CN|1、禁忌纂录内通关关卡后可以获得「密契」！\n2、不同推荐等级的关卡可以获得不同数量的「密契」。\n·推荐等级 25 级的关卡可以获得「密契」× 1。\n·推荐等级 35 级的关卡可以获得「密契」× 2。\n·推荐等级 45 级的关卡可以获得「密契」× 3。\n3、完成关卡挑战后解锁重现，重现可以立即获得该关卡的任务报酬。每次重现需消耗等同于进行调查所需的「灵啡肽」。\n4、每通关一章调查事件就解锁一个密契关卡。\n5、若三星通关高难度关卡，则较低难度的关卡挑战进度会自动标记为三星通关。"
  },
  RootSedimentShopRules = {
    ID = "RootSedimentShopRules",
    CN = "LanguageConfig_RootSedimentShopRules_CN|1、守密人可以通过消耗一定的「根源沉淀」兑换商品。\n2、当守密人调查等级提升时，沉淀兑换商店会随之升级并解锁新内容。\n3、沉淀兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以通过唤醒来获得「根源沉淀」。"
  },
  InvestigationBadgeShopRules = {
    ID = "InvestigationBadgeShopRules",
    CN = "LanguageConfig_InvestigationBadgeShopRules_CN|1、守密人可以通过消耗一定的「调查徽章」兑换商品。\n2、当守密人调查等级提升时，调查兑换商店会随之升级并解锁新内容。\n3、调查兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以在主线调查事件获得三星关卡星级或通过「超验存在」来获得「调查徽章」。"
  },
  BlackOfferingShopRules = {
    ID = "BlackOfferingShopRules",
    CN = "LanguageConfig_BlackOfferingShopRules_CN|1、守密人可以通过消耗一定的「黑色供物」兑换商品。\n2、当守密人调查等级提升时，无光兑换商店会随之升级并解锁新内容。\n3、无光兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以通过「无光之境」或通过「融灾禁区」来获得「黑色供物」。"
  },
  DissolutionJewelShopRules = {
    ID = "DissolutionJewelShopRules",
    CN = "LanguageConfig_DissolutionJewelShopRules_CN|1、守密人可以通过消耗一定的「融蚀之珠」兑换商品。\n2、当守密人调查等级提升时，融珠兑换商店会随之升级并解锁新内容。\n3、融珠兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以通过「常训任务：每周试炼」来获得「融蚀之珠」。"
  },
  ExchangeShopRules = {
    ID = "ExchangeShopRules",
    CN = "LanguageConfig_ExchangeShopRules_CN|<Title:兑换商店>\n·守密人可以在各个兑换商店通过消耗一定的对应货币兑换商品。\n·当守密人调查等级提升时，兑换商店会随之升级并解锁新内容。\n·兑换商店内的商品每隔一定的时间会自动刷新库存。\n\n<Title:金券兑换>\n·守密人可以在首次通关主线调查事件或通过「融蚀之墟：金券搜查」、「派遣奖励」、「课题奖励」与限时玩法活动奖励来获得「蔷薇金券」。\n\n<Title:沉淀兑换>\n·守密人可以通过唤醒来获得「根源沉淀」。\n\n<Title:调查兑换>\n·守密人可以在主线调查事件获得三星关卡星级或通过「超验存在」来获得「调查徽章」。\n\n<Title:无光兑换>\n·守密人可以通过「无光之境」或通过「融灾禁区」来获得「黑色供物」。\n\n<Title:融珠兑换>\n·守密人可以通过「常训任务：每周试炼」来获得「融蚀之珠」。"
  },
  StrongerWayTitle = {
    ID = "StrongerWayTitle",
    CN = "LanguageConfig_StrongerWayTitle_CN|如何变强"
  },
  StrongerTitle = {
    ID = "StrongerTitle",
    CN = "LanguageConfig_StrongerTitle_CN|通过「幕间演习」获取素材，强化你的唤醒体吧！"
  },
  StrongerWay = {
    ID = "StrongerWay",
    CN = "LanguageConfig_StrongerWay_CN|·「调查行动」1-2·普通解锁：「融蚀之墟」，可以获得大量唤醒体养成素材。\n·「调查行动」3-10·普通解锁：「超验存在」，可以获得大量唤醒体技能升级素材。\n·「调查等级」15级解锁：「第二命轮」，可以装备第二命轮获得强大战力。\n·「调查等级」25级解锁：「禁忌纂录」，可以获得大量密契，增强唤醒体能力。"
  },
  SkinTurntableActivityDesc1 = {
    ID = "SkinTurntableActivityDesc1",
    CN = "LanguageConfig_SkinTurntableActivityDesc1_CN|再抽<color=#e3c96e>{s1}</color>次开始有机会获得4星幻衣"
  },
  SkinTurntableActivityDesc2 = {
    ID = "SkinTurntableActivityDesc2",
    CN = "LanguageConfig_SkinTurntableActivityDesc2_CN|本次抽取有<color=#e3c96e>{s1}%</color>的概率获得4星幻衣"
  },
  SkinTurntableActivityDesc3 = {
    ID = "SkinTurntableActivityDesc3",
    CN = "LanguageConfig_SkinTurntableActivityDesc3_CN|继续抽取以获得剩余奖品"
  },
  ShenGuoShangFu_01 = {
    ID = "ShenGuoShangFu_01",
    CN = "LanguageConfig_ShenGuoShangFu_01_CN|击杀所有海怪后，会出现最终的敌人!"
  },
  DoubleExperience_01 = {
    ID = "DoubleExperience_01",
    CN = "LanguageConfig_DoubleExperience_01_CN|双倍经验"
  },
  DoubleExperience_02 = {
    ID = "DoubleExperience_02",
    CN = "LanguageConfig_DoubleExperience_02_CN|额外"
  },
  DoubleExperience_03 = {
    ID = "DoubleExperience_03",
    CN = "LanguageConfig_DoubleExperience_03_CN|双倍课题经验"
  },
  BPRuleTxt2 = {
    ID = "BPRuleTxt2",
    CN = "LanguageConfig_BPRuleTxt2_CN|\n\n<Title:【特殊课题】>\n·本期课题周期为{s1} - {s2}（GMT+8），完成任务获取双倍课题经验，助力课题等级快速提升。"
  },
  TimeFormatYMDHm2 = {
    ID = "TimeFormatYMDHm2",
    CN = "LanguageConfig_TimeFormatYMDHm2_CN|{s1} 月 {s2} 日 {s3}:{s4}"
  },
  BPTimeFormat = {
    ID = "BPTimeFormat",
    CN = "LanguageConfig_BPTimeFormat_CN|本期剩余{s1}"
  },
  Monster_Castor_01 = {
    ID = "Monster_Castor_01",
    CN = "LanguageConfig_Monster_Castor_01_CN|无论前方阻挡我们的是什么，我都会带他再次逃出去。"
  },
  Monster_Castor_02 = {
    ID = "Monster_Castor_02",
    CN = "LanguageConfig_Monster_Castor_02_CN|你的愿望，我们的愿望……我一定会坚持下去的。"
  },
  Monster_Castor_03 = {
    ID = "Monster_Castor_03",
    CN = "LanguageConfig_Monster_Castor_03_CN|敌人将释放所有蓄积的黑羽，注意防护！"
  },
  InGameDownloadReady = {
    ID = "InGameDownloadReady",
    CN = "LanguageConfig_InGameDownloadReady_CN|准备下载资源"
  },
  InGameDownloadingTips = {
    ID = "InGameDownloadingTips",
    CN = "LanguageConfig_InGameDownloadingTips_CN|关闭省电策略或低电量模式可支持后台下载，开启通知权限可以获得下载状态推送"
  },
  InGameDownloadingProg = {
    ID = "InGameDownloadingProg",
    CN = "LanguageConfig_InGameDownloadingProg_CN|下载中{s1}"
  },
  InGameDownloadingTitle = {
    ID = "InGameDownloadingTitle",
    CN = "LanguageConfig_InGameDownloadingTitle_CN|资源下载"
  },
  InGameDownloadUnzipStart = {
    ID = "InGameDownloadUnzipStart",
    CN = "LanguageConfig_InGameDownloadUnzipStart_CN|准备解压资源"
  },
  InGameDownloadUnziping = {
    ID = "InGameDownloadUnziping",
    CN = "LanguageConfig_InGameDownloadUnziping_CN|正在解压资源，请稍候…{s1}%"
  },
  InGameDownloadRedownloading = {
    ID = "InGameDownloadRedownloading",
    CN = "LanguageConfig_InGameDownloadRedownloading_CN|正在重新下载资源中，请稍候…{s1}%"
  },
  InGameDownloadChecking = {
    ID = "InGameDownloadChecking",
    CN = "LanguageConfig_InGameDownloadChecking_CN|正在校验资源，请稍后…{s1}%"
  },
  DownloadStorageSpaceTips = {
    ID = "DownloadStorageSpaceTips",
    CN = "LanguageConfig_DownloadStorageSpaceTips_CN|存储空间不足，需要预留至少{s1}存储空间，否则运行时可能导致资源丢失"
  },
  CounterTagAwaker = {
    ID = "CounterTagAwaker",
    CN = "LanguageConfig_CounterTagAwaker_CN|特攻唤醒体"
  },
  NoCounterTagAwaker = {
    ID = "NoCounterTagAwaker",
    CN = "LanguageConfig_NoCounterTagAwaker_CN|暂无特攻唤醒体"
  },
  AbyssExtraClearanceChallengeScore = {
    ID = "AbyssExtraClearanceChallengeScore",
    CN = "LanguageConfig_AbyssExtraClearanceChallengeScore_CN|额外通关特训值"
  },
  AbyssAllClearanceChallengeScore = {
    ID = "AbyssAllClearanceChallengeScore",
    CN = "LanguageConfig_AbyssAllClearanceChallengeScore_CN|总共通关特训值"
  },
  AbyssClearanceChallengeScore = {
    ID = "AbyssClearanceChallengeScore",
    CN = "LanguageConfig_AbyssClearanceChallengeScore_CN|通关特训值"
  },
  Monster_Doresain_01 = {
    ID = "Monster_Doresain_01",
    CN = "LanguageConfig_Monster_Doresain_01_CN|不要打扰我用餐。"
  },
  Monster_Doresain_02 = {
    ID = "Monster_Doresain_02",
    CN = "LanguageConfig_Monster_Doresain_02_CN|成为我的食物吧。"
  },
  Monster_Doresain_03 = {
    ID = "Monster_Doresain_03",
    CN = "LanguageConfig_Monster_Doresain_03_CN|你将为你的行为付出代价。"
  },
  Monster_Doresain_04 = {
    ID = "Monster_Doresain_04",
    CN = "LanguageConfig_Monster_Doresain_04_CN|请小心，敌人消耗的残骸越多，本次力量提升效果就越强！"
  },
  FavorabilityLimit_description = {
    ID = "FavorabilityLimit_description",
    CN = "LanguageConfig_FavorabilityLimit_description_CN|同调率基础上限为42000"
  },
  SubPlotAvgPreviewItemName = {
    ID = "SubPlotAvgPreviewItemName",
    CN = "LanguageConfig_SubPlotAvgPreviewItemName_CN|前情回顾{s1}"
  },
  AwakerRandomChestTipTitle = {
    ID = "AwakerRandomChestTipTitle",
    CN = "LanguageConfig_AwakerRandomChestTipTitle_CN|随机获得唤醒体"
  },
  WeaponRandomChestTipTitle = {
    ID = "WeaponRandomChestTipTitle",
    CN = "LanguageConfig_WeaponRandomChestTipTitle_CN|随机获得命轮"
  },
  RandomChestTipConfirmBtnTxt = {
    ID = "RandomChestTipConfirmBtnTxt",
    CN = "LanguageConfig_RandomChestTipConfirmBtnTxt_CN|随机获得"
  },
  FavorabilityLimit_description_02 = {
    ID = "FavorabilityLimit_description_02",
    CN = "LanguageConfig_FavorabilityLimit_description_02_CN|以下唤醒体同调率已满："
  },
  BigMeal = {
    ID = "BigMeal",
    CN = "LanguageConfig_BigMeal_CN|豪华大餐！"
  },
  MainLines_DiamondMapNodeTips = {
    ID = "MainLines_DiamondMapNodeTips",
    CN = "LanguageConfig_MainLines_DiamondMapNodeTips_CN|本次为特殊体验，不获得物品。"
  },
  Monster_Ghoul_01 = {
    ID = "Monster_Ghoul_01",
    CN = "LanguageConfig_Monster_Ghoul_01_CN|葬骸城，庇佑我的魂灵…"
  },
  Monster_Ghoul_02 = {
    ID = "Monster_Ghoul_02",
    CN = "LanguageConfig_Monster_Ghoul_02_CN|在巨浪面前化为尘土吧…"
  },
  Monster_Ghoul_03 = {
    ID = "Monster_Ghoul_03",
    CN = "LanguageConfig_Monster_Ghoul_03_CN|很迅猛的攻击…但我不会倒下…！"
  },
  Monster_Ghoul_04 = {
    ID = "Monster_Ghoul_04",
    CN = "LanguageConfig_Monster_Ghoul_04_CN|为了她…我绝不能倒下…！"
  },
  Monster_Ghoul_05 = {
    ID = "Monster_Ghoul_05",
    CN = "LanguageConfig_Monster_Ghoul_05_CN|小心，敌人已经进入了狂暴状态，每次受到伤害都会获得临时力量！"
  },
  Monster_Ghoul_06 = {
    ID = "Monster_Ghoul_06",
    CN = "LanguageConfig_Monster_Ghoul_06_CN|蹈海者的巨浪即将来袭…对其造成暴击来阻止它！"
  },
  AwakerPoolGroupTitle_1 = {
    ID = "AwakerPoolGroupTitle_1",
    CN = "LanguageConfig_AwakerPoolGroupTitle_1_CN|三相衡生"
  },
  AwakerPoolGroupBtnTip_1 = {
    ID = "AwakerPoolGroupBtnTip_1",
    CN = "LanguageConfig_AwakerPoolGroupBtnTip_1_CN|点击切换指定唤醒体"
  },
  WeaponPoolGroupTitle_2 = {
    ID = "WeaponPoolGroupTitle_2",
    CN = "LanguageConfig_WeaponPoolGroupTitle_2_CN|因果苗圃"
  },
  WeaponPoolGroupBtnTip_2 = {
    ID = "WeaponPoolGroupBtnTip_2",
    CN = "LanguageConfig_WeaponPoolGroupBtnTip_2_CN|点击切换指定命轮"
  },
  AwakerPoolGroupTitle_8 = {
    ID = "AwakerPoolGroupTitle_8",
    CN = "LanguageConfig_AwakerPoolGroupTitle_8_CN|往事失落以前"
  },
  PoolGroupTitle_1 = {
    ID = "PoolGroupTitle_1",
    CN = "LanguageConfig_PoolGroupTitle_1_CN|三相衡生"
  },
  PoolGroupTitle_2 = {
    ID = "PoolGroupTitle_2",
    CN = "LanguageConfig_PoolGroupTitle_2_CN|因果苗圃"
  },
  PoolGroupTitle_3 = {
    ID = "PoolGroupTitle_3",
    CN = "LanguageConfig_PoolGroupTitle_3_CN|往事失落以前"
  },
  PoolGroupTitle_4 = {
    ID = "PoolGroupTitle_4",
    CN = "LanguageConfig_PoolGroupTitle_4_CN|三相衡生"
  },
  PoolGroupTitle_5 = {
    ID = "PoolGroupTitle_5",
    CN = "LanguageConfig_PoolGroupTitle_5_CN|因果苗圃"
  },
  PoolGroupTitle_6 = {
    ID = "PoolGroupTitle_6",
    CN = "LanguageConfig_PoolGroupTitle_6_CN|三相衡生"
  },
  PoolGroupTitle_7 = {
    ID = "PoolGroupTitle_7",
    CN = "LanguageConfig_PoolGroupTitle_7_CN|因果苗圃"
  },
  PoolGroupTitle_8 = {
    ID = "PoolGroupTitle_8",
    CN = "LanguageConfig_PoolGroupTitle_8_CN|三相衡生"
  },
  PoolGroupTitle_9 = {
    ID = "PoolGroupTitle_9",
    CN = "LanguageConfig_PoolGroupTitle_9_CN|因果苗圃"
  },
  PoolGroupTitle_10 = {
    ID = "PoolGroupTitle_10",
    CN = "LanguageConfig_PoolGroupTitle_10_CN|与群星相会"
  },
  PoolGroupTitle_11 = {
    ID = "PoolGroupTitle_11",
    CN = "LanguageConfig_PoolGroupTitle_11_CN|三相衡生"
  },
  PoolGroupTitle_12 = {
    ID = "PoolGroupTitle_12",
    CN = "LanguageConfig_PoolGroupTitle_12_CN|因果苗圃"
  },
  PoolGroupTitle_13 = {
    ID = "PoolGroupTitle_13",
    CN = "LanguageConfig_PoolGroupTitle_13_CN|三相衡生"
  },
  PoolGroupTitle_14 = {
    ID = "PoolGroupTitle_14",
    CN = "LanguageConfig_PoolGroupTitle_14_CN|因果苗圃"
  },
  PoolGroupTitle_15 = {
    ID = "PoolGroupTitle_15",
    CN = "LanguageConfig_PoolGroupTitle_15_CN|三相衡生"
  },
  PoolGroupTitle_16 = {
    ID = "PoolGroupTitle_16",
    CN = "LanguageConfig_PoolGroupTitle_16_CN|因果苗圃"
  },
  PoolGroupTitle_17 = {
    ID = "PoolGroupTitle_17",
    CN = "LanguageConfig_PoolGroupTitle_17_CN|三相衡生"
  },
  PoolGroupTitle_18 = {
    ID = "PoolGroupTitle_18",
    CN = "LanguageConfig_PoolGroupTitle_18_CN|因果苗圃"
  },
  PoolGroupTitle_19 = {
    ID = "PoolGroupTitle_19",
    CN = "LanguageConfig_PoolGroupTitle_19_CN|时序外同行"
  },
  PoolGroupTitle_20 = {
    ID = "PoolGroupTitle_20",
    CN = "LanguageConfig_PoolGroupTitle_20_CN|三相衡生·其二"
  },
  PoolGroupTitle_21 = {
    ID = "PoolGroupTitle_21",
    CN = "LanguageConfig_PoolGroupTitle_21_CN|因果苗圃·其二"
  },
  PoolGroupTitle_22 = {
    ID = "PoolGroupTitle_22",
    CN = "LanguageConfig_PoolGroupTitle_22_CN|群星的盛绽"
  },
  PoolGroupTitle_23 = {
    ID = "PoolGroupTitle_23",
    CN = "LanguageConfig_PoolGroupTitle_23_CN|三相衡生"
  },
  PoolGroupTitle_24 = {
    ID = "PoolGroupTitle_24",
    CN = "LanguageConfig_PoolGroupTitle_24_CN|因果苗圃"
  },
  PoolGroupTitle_25 = {
    ID = "PoolGroupTitle_25",
    CN = "LanguageConfig_PoolGroupTitle_25_CN|三相衡生"
  },
  PoolGroupTitle_26 = {
    ID = "PoolGroupTitle_26",
    CN = "LanguageConfig_PoolGroupTitle_26_CN|因果苗圃"
  },
  PoolGroupTitle_27 = {
    ID = "PoolGroupTitle_27",
    CN = "LanguageConfig_PoolGroupTitle_27_CN|三相衡生"
  },
  PoolGroupTitle_28 = {
    ID = "PoolGroupTitle_28",
    CN = "LanguageConfig_PoolGroupTitle_28_CN|因果苗圃"
  },
  PoolGroupTitle_29 = {
    ID = "PoolGroupTitle_29",
    CN = "LanguageConfig_PoolGroupTitle_29_CN|三相衡生"
  },
  PoolGroupTitle_30 = {
    ID = "PoolGroupTitle_30",
    CN = "LanguageConfig_PoolGroupTitle_30_CN|因果苗圃"
  },
  PoolGroupTitle_31 = {
    ID = "PoolGroupTitle_31",
    CN = "LanguageConfig_PoolGroupTitle_31_CN|三相衡生"
  },
  PoolGroupTitle_32 = {
    ID = "PoolGroupTitle_32",
    CN = "LanguageConfig_PoolGroupTitle_32_CN|因果苗圃"
  },
  PoolGroupTitle_33 = {
    ID = "PoolGroupTitle_33",
    CN = "LanguageConfig_PoolGroupTitle_33_CN|溯忆寻光"
  },
  PoolGroupTitle_34 = {
    ID = "PoolGroupTitle_34",
    CN = "LanguageConfig_PoolGroupTitle_34_CN|三相衡生"
  },
  PoolGroupTitle_35 = {
    ID = "PoolGroupTitle_35",
    CN = "LanguageConfig_PoolGroupTitle_35_CN|因果苗圃"
  },
  PoolGroupTitle_36 = {
    ID = "PoolGroupTitle_36",
    CN = "LanguageConfig_PoolGroupTitle_36_CN|三相衡生"
  },
  PoolGroupTitle_37 = {
    ID = "PoolGroupTitle_37",
    CN = "LanguageConfig_PoolGroupTitle_37_CN|因果苗圃"
  },
  PoolGroupTitle_38 = {
    ID = "PoolGroupTitle_38",
    CN = "LanguageConfig_PoolGroupTitle_38_CN|三相衡生"
  },
  PoolGroupTitle_39 = {
    ID = "PoolGroupTitle_39",
    CN = "LanguageConfig_PoolGroupTitle_39_CN|因果苗圃"
  },
  PoolGroupTitle_40 = {
    ID = "PoolGroupTitle_40",
    CN = "LanguageConfig_PoolGroupTitle_40_CN|三相衡生"
  },
  PoolGroupTitle_41 = {
    ID = "PoolGroupTitle_41",
    CN = "LanguageConfig_PoolGroupTitle_41_CN|因果苗圃"
  },
  PoolGroupTitle_42 = {
    ID = "PoolGroupTitle_42",
    CN = "LanguageConfig_PoolGroupTitle_42_CN|三相衡生"
  },
  PoolGroupTitle_43 = {
    ID = "PoolGroupTitle_43",
    CN = "LanguageConfig_PoolGroupTitle_43_CN|因果苗圃"
  },
  PoolGroupTitle_44 = {
    ID = "PoolGroupTitle_44",
    CN = "LanguageConfig_PoolGroupTitle_44_CN|三相衡生"
  },
  PoolGroupTitle_45 = {
    ID = "PoolGroupTitle_45",
    CN = "LanguageConfig_PoolGroupTitle_45_CN|因果苗圃"
  },
  PoolGroupTitle_46 = {
    ID = "PoolGroupTitle_46",
    CN = "LanguageConfig_PoolGroupTitle_46_CN|三相衡生"
  },
  PoolGroupTitle_47 = {
    ID = "PoolGroupTitle_47",
    CN = "LanguageConfig_PoolGroupTitle_47_CN|因果苗圃"
  },
  PoolGroupTitle_48 = {
    ID = "PoolGroupTitle_48",
    CN = "LanguageConfig_PoolGroupTitle_48_CN|三相衡生"
  },
  PoolGroupTitle_49 = {
    ID = "PoolGroupTitle_49",
    CN = "LanguageConfig_PoolGroupTitle_49_CN|因果苗圃"
  },
  PoolGroupTitle_50 = {
    ID = "PoolGroupTitle_50",
    CN = "LanguageConfig_PoolGroupTitle_50_CN|三相衡生"
  },
  PoolGroupTitle_51 = {
    ID = "PoolGroupTitle_51",
    CN = "LanguageConfig_PoolGroupTitle_51_CN|因果苗圃"
  },
  PoolGroupTitle_52 = {
    ID = "PoolGroupTitle_52",
    CN = "LanguageConfig_PoolGroupTitle_52_CN|三相衡生"
  },
  PoolGroupTitle_53 = {
    ID = "PoolGroupTitle_53",
    CN = "LanguageConfig_PoolGroupTitle_53_CN|因果苗圃"
  },
  Monster_SeaWandererBoss_tips_01 = {
    ID = "Monster_SeaWandererBoss_tips_01",
    CN = "LanguageConfig_Monster_SeaWandererBoss_tips_01_CN|杜勒赛因正在努力催化溟梦之帷法阵，全力抵挡伤害来守护它！"
  },
  Monster_SeaWandererBoss_tips_02 = {
    ID = "Monster_SeaWandererBoss_tips_02",
    CN = "LanguageConfig_Monster_SeaWandererBoss_tips_02_CN|敌人的形态不是十分稳定，每次击破生命条都可以降低敌人的侵略性！"
  },
  Monster_SeaWandererBoss_tips_03 = {
    ID = "Monster_SeaWandererBoss_tips_03",
    CN = "LanguageConfig_Monster_SeaWandererBoss_tips_03_CN|当心卡牌上附带的「蹈海者狂乱」！打出或弃掉时会有深海分殖体出现！"
  },
  Monster_SeaWandererBoss_bubble_01 = {
    ID = "Monster_SeaWandererBoss_bubble_01",
    CN = "LanguageConfig_Monster_SeaWandererBoss_bubble_01_CN|我于腐潮之夜盛放…遵循吾主…吞噬！"
  },
  Monster_SeaWandererBoss_bubble_02 = {
    ID = "Monster_SeaWandererBoss_bubble_02",
    CN = "LanguageConfig_Monster_SeaWandererBoss_bubble_02_CN|聆听吾主…接受吾主的审判…！"
  },
  WeaponRefined_02 = {
    ID = "WeaponRefined_02",
    CN = "LanguageConfig_WeaponRefined_02_CN|自动叠位"
  },
  WeaponRefined_03 = {
    ID = "WeaponRefined_03",
    CN = "LanguageConfig_WeaponRefined_03_CN|已达叠位等级上限的命轮自动分解为其他资源"
  },
  WeaponRefined_04 = {
    ID = "WeaponRefined_04",
    CN = "LanguageConfig_WeaponRefined_04_CN|转换"
  },
  GetSSRDecompose = {
    ID = "GetSSRDecompose",
    CN = "LanguageConfig_GetSSRDecompose_CN|SSR分解获得"
  },
  ItemType_HeadAndEmoji = {
    ID = "ItemType_HeadAndEmoji",
    CN = "LanguageConfig_ItemType_HeadAndEmoji_CN|头像和表情"
  },
  AwakerPreviewTitle = {
    ID = "AwakerPreviewTitle",
    CN = "LanguageConfig_AwakerPreviewTitle_CN|唤醒体预览"
  },
  AwakerChipChestPreviewTitle = {
    ID = "AwakerChipChestPreviewTitle",
    CN = "LanguageConfig_AwakerChipChestPreviewTitle_CN|唤醒体残片预览"
  },
  ChestPreviewTitle = {
    ID = "ChestPreviewTitle",
    CN = "LanguageConfig_ChestPreviewTitle_CN|素材预览"
  },
  WeaponPreviewTitle = {
    ID = "WeaponPreviewTitle",
    CN = "LanguageConfig_WeaponPreviewTitle_CN|命轮预览"
  },
  PreviewClose = {
    ID = "PreviewClose",
    CN = "LanguageConfig_PreviewClose_CN|关闭"
  },
  Monster_KathiguRa_01 = {
    ID = "Monster_KathiguRa_01",
    CN = "LanguageConfig_Monster_KathiguRa_01_CN|敌人觉醒后会弃置所有剩余手牌并赋予<BurningKeywords:燃烧>，谨慎行动！"
  },
  Monster_KathiguRa_02 = {
    ID = "Monster_KathiguRa_02",
    CN = "LanguageConfig_Monster_KathiguRa_02_CN|在亿万耀光中，焚烧吧！"
  },
  Monster_KathiguRa_03 = {
    ID = "Monster_KathiguRa_03",
    CN = "LanguageConfig_Monster_KathiguRa_03_CN|爆燃之火啊，在此重燃吧！"
  },
  Monster_KathiguRa_04 = {
    ID = "Monster_KathiguRa_04",
    CN = "LanguageConfig_Monster_KathiguRa_04_CN|敌人将爆发强力攻击！打出燃烧卡牌来削弱敌人。"
  },
  FriendInvitationTips_Accepted = {
    ID = "FriendInvitationTips_Accepted",
    CN = "LanguageConfig_FriendInvitationTips_Accepted_CN|已接受<Blue:{s1}>的邀请！"
  },
  FriendInvitationRule = {
    ID = "FriendInvitationRule",
    CN = "LanguageConfig_FriendInvitationRule_CN|<Title:邀请活动>\n1.守密人可以通过分享邀请码来邀请新的守密人加入弥萨格校园，共赴冒险之旅。\n2.受邀的守密人完成任务后，您可以领取任务奖励获取「银钥辉光」，当「银钥辉光」达到一定数量后，可以领取丰富的奖励！\n3.守密人等级达到5/10/15/20级后可以分别获得20/20/20/40「银钥辉光」。\n4.每位守密人最多可以通过 50 位邀请的守密人获取任务奖励，超出数量的部分不再提供任务奖励。\n5.邀请的守密人在调查等级达到 5 级后才会被计入已邀请人数。\n<Title:绑定邀请>\n1.守密人可以填写邀请码来跟邀请的玩家进行绑定，并立即获得「银芯」× 300的奖励！\n2.每位守密人只能在初到弥萨格的前 7 天内输入邀请码，超时后「绑定邀请」的入口将会关闭。"
  },
  FriendInvitationShareText = {
    ID = "FriendInvitationShareText",
    CN = "LanguageConfig_FriendInvitationShareText_CN|加入《忘却前夜》，共赴冒险之旅！通过我的邀请码{s1}下载，还能领取专属奖励！\n{s2}"
  },
  FriendInvitationPaste = {
    ID = "FriendInvitationPaste",
    CN = "LanguageConfig_FriendInvitationPaste_CN|粘贴"
  },
  FriendInvitationCopy = {
    ID = "FriendInvitationCopy",
    CN = "LanguageConfig_FriendInvitationCopy_CN|复制"
  },
  LuckyBagRedDotText = {
    ID = "LuckyBagRedDotText",
    CN = "LanguageConfig_LuckyBagRedDotText_CN|推荐"
  },
  IsNewDotText = {
    ID = "IsNewDotText",
    CN = "LanguageConfig_IsNewDotText_CN|今日推荐"
  },
  AutocConversion_Title = {
    ID = "AutocConversion_Title",
    CN = "LanguageConfig_AutocConversion_Title_CN|选择要置换千面印章的材料"
  },
  ComsumeSet = {
    ID = "ComsumeSet",
    CN = "LanguageConfig_ComsumeSet_CN|置换设置"
  },
  SocializeRoleLevel = {
    ID = "SocializeRoleLevel",
    CN = "LanguageConfig_SocializeRoleLevel_CN|守密人等级"
  },
  SocializeAwakerLevel = {
    ID = "SocializeAwakerLevel",
    CN = "LanguageConfig_SocializeAwakerLevel_CN|唤醒体等级"
  },
  SocializeBatchCancel = {
    ID = "SocializeBatchCancel",
    CN = "LanguageConfig_SocializeBatchCancel_CN|批量取关"
  },
  SocializeExitCancel = {
    ID = "SocializeExitCancel",
    CN = "LanguageConfig_SocializeExitCancel_CN|退出取关"
  },
  SocializeFinishCancel = {
    ID = "SocializeFinishCancel",
    CN = "LanguageConfig_SocializeFinishCancel_CN|完成取关"
  },
  CollectionNumber = {
    ID = "CollectionNumber",
    CN = "LanguageConfig_CollectionNumber_CN|秘典书库藏品数"
  },
  AwakerColletion = {
    ID = "AwakerColletion",
    CN = "LanguageConfig_AwakerColletion_CN|筛选唤醒体"
  },
  SelectAllAwaker = {
    ID = "SelectAllAwaker",
    CN = "LanguageConfig_SelectAllAwaker_CN|全选"
  },
  CancelSelectAllAwaker = {
    ID = "CancelSelectAllAwaker",
    CN = "LanguageConfig_CancelSelectAllAwaker_CN|全部取消"
  },
  ExchangePlanSaveTips = {
    ID = "ExchangePlanSaveTips",
    CN = "LanguageConfig_ExchangePlanSaveTips_CN|已保存「千面印章」不足时的置换设置"
  },
  TrinketStrengCostItemNotEnoughTips = {
    ID = "TrinketStrengCostItemNotEnoughTips",
    CN = "LanguageConfig_TrinketStrengCostItemNotEnoughTips_CN|「千面印章」不足"
  },
  PasswordBattle = {
    ID = "PasswordBattle",
    CN = "LanguageConfig_PasswordBattle_CN|密码对战"
  },
  EnterPassword = {
    ID = "EnterPassword",
    CN = "LanguageConfig_EnterPassword_CN|输入 <color=#5EF2FF>相位值</color>"
  },
  CopyPassword = {
    ID = "CopyPassword",
    CN = "LanguageConfig_CopyPassword_CN|复制 <color=#5EF2FF>相位值</color>"
  },
  MatchingPasswordBattle = {
    ID = "MatchingPasswordBattle",
    CN = "LanguageConfig_MatchingPasswordBattle_CN|正在匹配密码对战…"
  },
  ConductPasswordBattle1 = {
    ID = "ConductPasswordBattle1",
    CN = "LanguageConfig_ConductPasswordBattle1_CN|正在进行密码对战-预组模式…"
  },
  ConductPasswordBattle2 = {
    ID = "ConductPasswordBattle2",
    CN = "LanguageConfig_ConductPasswordBattle2_CN|正在进行密码对战-轮选模式…"
  },
  WaitngTimeout = {
    ID = "WaitngTimeout",
    CN = "LanguageConfig_WaitngTimeout_CN|等待超时…"
  },
  WaitngTimeout2 = {
    ID = "WaitngTimeout2",
    CN = "LanguageConfig_WaitngTimeout2_CN|等待超时…"
  },
  MatchSuccessful = {
    ID = "MatchSuccessful",
    CN = "LanguageConfig_MatchSuccessful_CN|准备对战"
  },
  PasswordBattle_FriendGame = {
    ID = "PasswordBattle_FriendGame",
    CN = "LanguageConfig_PasswordBattle_FriendGame_CN|友谊赛"
  },
  ChooseModel = {
    ID = "ChooseModel",
    CN = "LanguageConfig_ChooseModel_CN|选择模式"
  },
  PasswordBattle1 = {
    ID = "PasswordBattle1",
    CN = "LanguageConfig_PasswordBattle1_CN|预组模式"
  },
  PasswordBattle2 = {
    ID = "PasswordBattle2",
    CN = "LanguageConfig_PasswordBattle2_CN|轮选模式"
  },
  PasswordBattleRuleTips = {
    ID = "PasswordBattleRuleTips",
    CN = "LanguageConfig_PasswordBattleRuleTips_CN|·密码对战：在创建对战后，可以通过在 社交媒体 或 通讯软件中发布 <color=#5EF2FF>相位值</color> 对群体发起邀请，其他守密人可以通过输入 <color=#5EF2FF>相位值</color> 加入你的对战，由于同时只能与一个人发起对战，因此对战名额先到先得，成功开启对战后其他应邀的守密人将被拒绝。\n·拒绝对战：若遇到不想与其对战的守密人创建者也可拒绝与其对战，拒绝过多会出现拉黑提示，可通过拉黑操作阻止其加入你的对战，直至解除拉黑。"
  },
  PasswordBattleQueueButton = {
    ID = "PasswordBattleQueueButton",
    CN = "LanguageConfig_PasswordBattleQueueButton_CN|排队中"
  },
  PvpDraftAdjustPosReady = {
    ID = "PvpDraftAdjustPosReady",
    CN = "LanguageConfig_PvpDraftAdjustPosReady_CN|准备就绪"
  },
  PvpDraftParamEntryLockTips = {
    ID = "PvpDraftParamEntryLockTips",
    CN = "LanguageConfig_PvpDraftParamEntryLockTips_CN|当前赛季的积分曾到达 {s1} 可参与"
  },
  PassportAdvanced_Txt = {
    ID = "PassportAdvanced_Txt",
    CN = "LanguageConfig_PassportAdvanced_Txt_CN|解锁立即获得「银芯」× <color=#5EF2FF><size=32>680</size></color>"
  },
  PassportHoist_Txt = {
    ID = "PassportHoist_Txt",
    CN = "LanguageConfig_PassportHoist_Txt_CN|解锁立即获得「银芯」× <color=#5EF2FF><size=32>1460</size></color>，并提升 <color=#5EF2FF><size=32>10</size></color> 级课题等级"
  },
  PassportHoistUpgrade_Txt = {
    ID = "PassportHoistUpgrade_Txt",
    CN = "LanguageConfig_PassportHoistUpgrade_Txt_CN|升级课题立即获得「银芯」×<color=#5EF2FF><size=32>780</size></color>，并提升 <color=#5EF2FF><size=32>10</size></color> 级课题等级"
  },
  PassportHoistDouble_Txt = {
    ID = "PassportHoistDouble_Txt",
    CN = "LanguageConfig_PassportHoistDouble_Txt_CN|解锁立即获得「银芯」× <color=#5EF2FF><size=32>1070</size></color>，并提升<color=#5EF2FF><size=32>20</size>级</color>课题等级"
  },
  PassportHoistDoubleUpgrade_Txt = {
    ID = "PassportHoistDoubleUpgrade_Txt",
    CN = "LanguageConfig_PassportHoistDoubleUpgrade_Txt_CN|升级课题立即获得「银芯」× <color=#5EF2FF><size=32>390</size></color>，并提升 <color=#5EF2FF><size=32>20</size></color> 级课题等级"
  },
  PassportAdvancedPurchased_Txt = {
    ID = "PassportAdvancedPurchased_Txt",
    CN = "LanguageConfig_PassportAdvancedPurchased_Txt_CN|已购买高阶课题"
  },
  PassportHoistPurchased_Txt = {
    ID = "PassportHoistPurchased_Txt",
    CN = "LanguageConfig_PassportHoistPurchased_Txt_CN|已购买核心课题"
  },
  PvpRuleTipsCreationTitle = {
    ID = "PvpRuleTipsCreationTitle",
    CN = "LanguageConfig_PvpRuleTipsCreationTitle_CN|【轮选造物】"
  },
  FriendGameInviteTipsDraft = {
    ID = "FriendGameInviteTipsDraft",
    CN = "LanguageConfig_FriendGameInviteTipsDraft_CN|正在邀请你参与 轮选模式…"
  },
  FriendGameInviteTipsNormal = {
    ID = "FriendGameInviteTipsNormal",
    CN = "LanguageConfig_FriendGameInviteTipsNormal_CN|正在邀请你参与 预组对决…"
  },
  PvpMatchEmptyPvpTypeTips = {
    ID = "PvpMatchEmptyPvpTypeTips",
    CN = "LanguageConfig_PvpMatchEmptyPvpTypeTips_CN|请至少选中一项模式再进行匹配"
  },
  PvpVoiceName_PlayerEnter = {
    ID = "PvpVoiceName_PlayerEnter",
    CN = "LanguageConfig_PvpVoiceName_PlayerEnter_CN|开场"
  },
  PvpVoiceName_OperationStop = {
    ID = "PvpVoiceName_OperationStop",
    CN = "LanguageConfig_PvpVoiceName_OperationStop_CN|思考"
  },
  PvpVoiceName_CountingStart = {
    ID = "PvpVoiceName_CountingStart",
    CN = "LanguageConfig_PvpVoiceName_CountingStart_CN|催促"
  },
  PvpVoiceName_SkillReady = {
    ID = "PvpVoiceName_SkillReady",
    CN = "LanguageConfig_PvpVoiceName_SkillReady_CN|必杀"
  },
  PvpVoiceName_OperationImpossible = {
    ID = "PvpVoiceName_OperationImpossible",
    CN = "LanguageConfig_PvpVoiceName_OperationImpossible_CN|错误"
  },
  PvpVoiceName_AwakerDied = {
    ID = "PvpVoiceName_AwakerDied",
    CN = "LanguageConfig_PvpVoiceName_AwakerDied_CN|死亡"
  },
  PvpVoiceName_ReletedAwakerInEnemies = {
    ID = "PvpVoiceName_ReletedAwakerInEnemies",
    CN = "LanguageConfig_PvpVoiceName_ReletedAwakerInEnemies_CN|闲话·关于{s1}"
  },
  PvPExitReplay = {
    ID = "PvPExitReplay",
    CN = "LanguageConfig_PvPExitReplay_CN|退出录像"
  },
  PvPReplay_CheckBot = {
    ID = "PvPReplay_CheckBot",
    CN = "LanguageConfig_PvPReplay_CheckBot_CN|无法查看模拟对手详情"
  },
  PvPReplayCode_Copy = {
    ID = "PvPReplayCode_Copy",
    CN = "LanguageConfig_PvPReplayCode_Copy_CN|已复制到剪贴板"
  },
  PvPReplayCode_ErrorPaste = {
    ID = "PvPReplayCode_ErrorPaste",
    CN = "LanguageConfig_PvPReplayCode_ErrorPaste_CN|输入内容 不合法 或 已过期"
  },
  SkillUpgradeInsufficientMaterial = {
    ID = "SkillUpgradeInsufficientMaterial",
    CN = "LanguageConfig_SkillUpgradeInsufficientMaterial_CN|技能升级素材不足"
  },
  MaxLvPreview_Txt = {
    ID = "MaxLvPreview_Txt",
    CN = "LanguageConfig_MaxLvPreview_Txt_CN|<color=#5EF2FF>{s1}</color>"
  },
  Monster_Agrippa_bubble_01 = {
    ID = "Monster_Agrippa_bubble_01",
    CN = "LanguageConfig_Monster_Agrippa_bubble_01_CN|卑贱的家伙……竟敢这么对我！"
  },
  Monster_Agrippa_bubble_tips_01 = {
    ID = "Monster_Agrippa_bubble_tips_01",
    CN = "LanguageConfig_Monster_Agrippa_bubble_tips_01_CN|当心！敌人的攻击会附带中毒效果。"
  },
  Monster_Agrippa_bubble_tips_02 = {
    ID = "Monster_Agrippa_bubble_tips_02",
    CN = "LanguageConfig_Monster_Agrippa_bubble_tips_02_CN|敌人受到一定伤害后会获得加固并转换为防御姿态。"
  },
  Monster_Pickman_bubble_01 = {
    ID = "Monster_Pickman_bubble_01",
    CN = "LanguageConfig_Monster_Pickman_bubble_01_CN|什么是真实？什么是虚假？"
  },
  Monster_Pickman_bubble_02 = {
    ID = "Monster_Pickman_bubble_02",
    CN = "LanguageConfig_Monster_Pickman_bubble_02_CN|疯狂，即是这个世界唯一的真相！即是艺术唯一的真相！"
  },
  Monster_Pickman_bubble_tips_01 = {
    ID = "Monster_Pickman_bubble_tips_01",
    CN = "LanguageConfig_Monster_Pickman_bubble_tips_01_CN|敌人将要造成大量伤害，尽可能打出认知失调卡牌来降低敌人伤害！"
  },
  Monster_Pickman_bubble_tips_02 = {
    ID = "Monster_Pickman_bubble_tips_02",
    CN = "LanguageConfig_Monster_Pickman_bubble_tips_02_CN|敌人变强了，施加的认知失调产生了奇怪的变化！"
  },
  Monster_Pickman_bubble_tips_03 = {
    ID = "Monster_Pickman_bubble_tips_03",
    CN = "LanguageConfig_Monster_Pickman_bubble_tips_03_CN|注意！打出认知错乱卡牌时，敌方攻击次数会增加。"
  },
  Monster_Faros_bubble_tips_01 = {
    ID = "Monster_Faros_bubble_tips_01",
    CN = "LanguageConfig_Monster_Faros_bubble_tips_01_CN|当心！防御住触腕伤害后会附带中毒效果！"
  },
  TurntableProbabilityDesc = {
    ID = "TurntableProbabilityDesc",
    CN = "LanguageConfig_TurntableProbabilityDesc_CN|1、幻衣奖励将在第5次抽取时开始出现。第1 ~ 4抽时，幻衣奖励的概率将根据未获得奖励的初始概率按比例分配到各项未获得奖励。\n2、奖池内的奖励固定，已获得的奖励不会再次出现。未获得奖励的概率会发生变动，变动后的概率为「该奖励的初始概率/（100%-已获得奖励的初始概率总和）」。\n3、以下为所有奖励的具体概率展示，展示至四舍五入后的小数点第四位。"
  },
  Collection_Reward_Desc = {
    ID = "Collection_Reward_Desc",
    CN = "LanguageConfig_Collection_Reward_Desc_CN|累计收集数量达到"
  },
  BagKeeperSkillTitle = {
    ID = "BagKeeperSkillTitle",
    CN = "LanguageConfig_BagKeeperSkillTitle_CN|钥令"
  },
  WeaponSortTypeName_4 = {
    ID = "WeaponSortTypeName_4",
    CN = "LanguageConfig_WeaponSortTypeName_4_CN|界域"
  },
  WeaponSortTypeName_5 = {
    ID = "WeaponSortTypeName_5",
    CN = "LanguageConfig_WeaponSortTypeName_5_CN|叠位"
  },
  AwakerTrialActivityTitle = {
    ID = "AwakerTrialActivityTitle",
    CN = "LanguageConfig_AwakerTrialActivityTitle_CN|聚灵演练"
  },
  UIKeeperSkillUsed = {
    ID = "UIKeeperSkillUsed",
    CN = "LanguageConfig_UIKeeperSkillUsed_CN|使用中"
  },
  UIKeeperSkillChoose = {
    ID = "UIKeeperSkillChoose",
    CN = "LanguageConfig_UIKeeperSkillChoose_CN|选择"
  },
  UIKeeperSkillChooseAll = {
    ID = "UIKeeperSkillChooseAll",
    CN = "LanguageConfig_UIKeeperSkillChooseAll_CN|全部"
  },
  ActiveTaskRuleDesc = {
    ID = "ActiveTaskRuleDesc"
  },
  PvpCollectCommentBtnPublish = {
    ID = "PvpCollectCommentBtnPublish",
    CN = "LanguageConfig_PvpCollectCommentBtnPublish_CN|发布评论"
  },
  PvpCollectCommentBtnMine = {
    ID = "PvpCollectCommentBtnMine",
    CN = "LanguageConfig_PvpCollectCommentBtnMine_CN|我的评论"
  },
  PvpCollectCommentSortModePublishTime = {
    ID = "PvpCollectCommentSortModePublishTime",
    CN = "LanguageConfig_PvpCollectCommentSortModePublishTime_CN|最新"
  },
  PvpCollectCommentSortModeRecommend = {
    ID = "PvpCollectCommentSortModeRecommend",
    CN = "LanguageConfig_PvpCollectCommentSortModeRecommend_CN|推荐"
  },
  PvpCollectCommentEditLabel = {
    ID = "PvpCollectCommentEditLabel",
    CN = "LanguageConfig_PvpCollectCommentEditLabel_CN|最多输入 {s1} 字符"
  },
  PvpCollectCommentLikeForbid = {
    ID = "PvpCollectCommentLikeForbid",
    CN = "LanguageConfig_PvpCollectCommentLikeForbid_CN|无法点赞自己的评论"
  },
  PvpCollectEditCommentViewTitle = {
    ID = "PvpCollectEditCommentViewTitle",
    CN = "LanguageConfig_PvpCollectEditCommentViewTitle_CN|编辑评论"
  },
  PvpCollectCommentPublishTime = {
    ID = "PvpCollectCommentPublishTime",
    CN = "LanguageConfig_PvpCollectCommentPublishTime_CN|发布于  {s1}"
  },
  PvpCollectCommentEditTimeOutTips = {
    ID = "PvpCollectCommentEditTimeOutTips",
    CN = "LanguageConfig_PvpCollectCommentEditTimeOutTips_CN|超过30天的评论不可编辑"
  },
  LikeSourcePvpCollectionComment = {
    ID = "LikeSourcePvpCollectionComment",
    CN = "LanguageConfig_LikeSourcePvpCollectionComment_CN|相位对弈卡牌评论"
  },
  SecondAnniversaryDailyReward = {
    ID = "SecondAnniversaryDailyReward",
    CN = "LanguageConfig_SecondAnniversaryDailyReward_CN|每日校猫赠礼"
  },
  SecondAnniversaryDailyTimeAlert = {
    ID = "SecondAnniversaryDailyTimeAlert",
    CN = "LanguageConfig_SecondAnniversaryDailyTimeAlert_CN|倒计时{s1}后可领"
  },
  SecondAnniversaryDailyGainAbleTip = {
    ID = "SecondAnniversaryDailyGainAbleTip",
    CN = "LanguageConfig_SecondAnniversaryDailyGainAbleTip_CN|可领取"
  },
  SecondAnniversarySevenDaySign = {
    ID = "SecondAnniversarySevenDaySign",
    CN = "LanguageConfig_SecondAnniversarySevenDaySign_CN|校猫七日奖励"
  },
  SecondAnniversaryShopName = {
    ID = "SecondAnniversaryShopName",
    CN = "LanguageConfig_SecondAnniversaryShopName_CN|校猫的小店"
  },
  AssistAwakerSortTypeAwakerLevel = {
    ID = "AssistAwakerSortTypeAwakerLevel",
    CN = "LanguageConfig_AssistAwakerSortTypeAwakerLevel_CN|唤醒体等级"
  },
  AssistAwakerSortTypeAwakerPotency = {
    ID = "AssistAwakerSortTypeAwakerPotency",
    CN = "LanguageConfig_AssistAwakerSortTypeAwakerPotency_CN|唤醒体启灵"
  },
  AssistAwakerSortTypeAwakerSkill = {
    ID = "AssistAwakerSortTypeAwakerSkill",
    CN = "LanguageConfig_AssistAwakerSortTypeAwakerSkill_CN|唤醒体技能"
  },
  AssistAwakerSortTypeAttentionTime = {
    ID = "AssistAwakerSortTypeAttentionTime",
    CN = "LanguageConfig_AssistAwakerSortTypeAttentionTime_CN|关注时间"
  },
  AssistAwakerSortTypeAwakerTalentLv = {
    ID = "AssistAwakerSortTypeAwakerTalentLv",
    CN = "LanguageConfig_AssistAwakerSortTypeAwakerTalentLv_CN|天赋等级"
  },
  AssistAwakerSortTypeWeaponPotency = {
    ID = "AssistAwakerSortTypeWeaponPotency",
    CN = "LanguageConfig_AssistAwakerSortTypeWeaponPotency_CN|命轮叠位等级"
  },
  AssistAwakerSortTypeTrinketCompletion = {
    ID = "AssistAwakerSortTypeTrinketCompletion",
    CN = "LanguageConfig_AssistAwakerSortTypeTrinketCompletion_CN|密契完成度"
  },
  PvpCommentTimeLessThan1Min = {
    ID = "PvpCommentTimeLessThan1Min",
    CN = "LanguageConfig_PvpCommentTimeLessThan1Min_CN|刚刚"
  },
  PvpCommentTimeLessThan1Hour = {
    ID = "PvpCommentTimeLessThan1Hour",
    CN = "LanguageConfig_PvpCommentTimeLessThan1Hour_CN|{s1}分钟前"
  },
  PvpCommentTimeLessThan1Day = {
    ID = "PvpCommentTimeLessThan1Day",
    CN = "LanguageConfig_PvpCommentTimeLessThan1Day_CN|{s1}小时前"
  },
  PvpCommentTimeLessThan1Month = {
    ID = "PvpCommentTimeLessThan1Month",
    CN = "LanguageConfig_PvpCommentTimeLessThan1Month_CN|{s1}天前"
  },
  PvpCommentTimeLessThan1Year = {
    ID = "PvpCommentTimeLessThan1Year",
    CN = "LanguageConfig_PvpCommentTimeLessThan1Year_CN|{s1}月前"
  },
  PvpCommentTimeMoreThan1Year = {
    ID = "PvpCommentTimeMoreThan1Year",
    CN = "LanguageConfig_PvpCommentTimeMoreThan1Year_CN|{s1}年前"
  },
  Monster_FishLeap_Bubble = {
    ID = "Monster_FishLeap_Bubble",
    CN = "LanguageConfig_Monster_FishLeap_Bubble_CN|鱼群飞跃!！"
  },
  Monster_Decay_Tips = {
    ID = "Monster_Decay_Tips",
    CN = "LanguageConfig_Monster_Decay_Tips_CN|回复生命超过 50% 最大生命即可解除腐朽状态——"
  },
  Monster_Neurotoxin_Tips = {
    ID = "Monster_Neurotoxin_Tips",
    CN = "LanguageConfig_Monster_Neurotoxin_Tips_CN|敌人即将造成穿刺伤害，当心！"
  },
  Monster_Neurotoxin_Bubble = {
    ID = "Monster_Neurotoxin_Bubble",
    CN = "LanguageConfig_Monster_Neurotoxin_Bubble_CN|践行「神母」的意志！"
  },
  Monster_Cursedbreath_Tips = {
    ID = "Monster_Cursedbreath_Tips",
    CN = "LanguageConfig_Monster_Cursedbreath_Tips_CN|尽可能格挡敌人攻击来避免其召唤！"
  },
  Monster_Cursedbreath_Bubble = {
    ID = "Monster_Cursedbreath_Bubble",
    CN = "LanguageConfig_Monster_Cursedbreath_Bubble_CN|「净化罪孽者受祝……」"
  },
  Monster_Seamonsteronslaught_Bubble = {
    ID = "Monster_Seamonsteronslaught_Bubble",
    CN = "LanguageConfig_Monster_Seamonsteronslaught_Bubble_CN|「吾神的威名不容亵渎！」"
  },
  Monster_Snakerend_Tips = {
    ID = "Monster_Snakerend_Tips",
    CN = "LanguageConfig_Monster_Snakerend_Tips_CN|剩余手牌越少敌人的攻势就越强！"
  },
  Monster_Probe_Tips = {
    ID = "Monster_Probe_Tips",
    CN = "LanguageConfig_Monster_Probe_Tips_CN|剩余手牌越多敌人就会获得更多临时反击！"
  },
  Monster_Mofei_Tips = {
    ID = "Monster_Mofei_Tips",
    CN = "LanguageConfig_Monster_Mofei_Tips_CN|本回合对其造成的伤害必定暴击，找准机会吧！"
  },
  Monster_MLYM_Tips = {
    ID = "Monster_MLYM_Tips",
    CN = "LanguageConfig_Monster_MLYM_Tips_CN|当心！释放狂气爆发会使敌人获得「呼唤」状态，增强敌人的力量，达到 5 层还会释放强力技能！"
  },
  Monster_DeepSeaAcolyte_Tips = {
    ID = "Monster_DeepSeaAcolyte_Tips",
    CN = "LanguageConfig_Monster_DeepSeaAcolyte_Tips_CN|敌人的「血誓」会大幅增加临时触腕！造成伤害破除其「血誓」吧！"
  },
  BacktrackRichText1 = {
    ID = "BacktrackRichText1",
    CN = "LanguageConfig_BacktrackRichText1_CN|剩余次数 {s1}"
  },
  BacktrackRichText2 = {
    ID = "BacktrackRichText2",
    CN = "LanguageConfig_BacktrackRichText2_CN|剩余次数 <color=#FF0000>{s1}</color>"
  },
  DailyChallengexSettlementBasicScoreTitle = {
    ID = "DailyChallengexSettlementBasicScoreTitle",
    CN = "LanguageConfig_DailyChallengexSettlementBasicScoreTitle_CN|基础分数"
  },
  DailyChallengexSettlementBasicScoreTips = {
    ID = "DailyChallengexSettlementBasicScoreTips",
    CN = "LanguageConfig_DailyChallengexSettlementBasicScoreTips_CN|根据所挑战的关卡难度获得的难度基础分数"
  },
  AwakerHasColletion = {
    ID = "AwakerHasColletion",
    CN = "LanguageConfig_AwakerHasColletion_CN|已筛选唤醒体"
  },
  Card_Select_Get_Tips1_Ceremony = {
    ID = "Card_Select_Get_Tips1_Ceremony",
    CN = "LanguageConfig_Card_Select_Get_Tips1_Ceremony_CN|选择进行 1 项仪式"
  },
  Monster_NewUnit4_EndBoss_Tips1 = {
    ID = "Monster_NewUnit4_EndBoss_Tips1",
    CN = "LanguageConfig_Monster_NewUnit4_EndBoss_Tips1_CN|击破「梦境桎梏」可降低迟缓，但也会使「乐园帷幕」的排斥效果更加强大……"
  },
  Monster_NewUnit4_EndBoss_Tips2 = {
    ID = "Monster_NewUnit4_EndBoss_Tips2",
    CN = "LanguageConfig_Monster_NewUnit4_EndBoss_Tips2_CN|打出迟缓的卡牌可以降低敌人伤害次数……！"
  },
  Monster_NewUnit4_EndBoss_Bubble1 = {
    ID = "Monster_NewUnit4_EndBoss_Bubble1",
    CN = "LanguageConfig_Monster_NewUnit4_EndBoss_Bubble1_CN|堕入轮回……永享乐土……"
  },
  Monster_NewUnit4_EndBoss_Bubble2 = {
    ID = "Monster_NewUnit4_EndBoss_Bubble2",
    CN = "LanguageConfig_Monster_NewUnit4_EndBoss_Bubble2_CN|神国的荣耀，应照耀世间！"
  },
  Monster_NewUnit4_EndBoss_Bubble3 = {
    ID = "Monster_NewUnit4_EndBoss_Bubble3",
    CN = "LanguageConfig_Monster_NewUnit4_EndBoss_Bubble3_CN|你将……面见轮回的枢纽……"
  },
  Monster_NewUnit4_EndBoss_Bubble4 = {
    ID = "Monster_NewUnit4_EndBoss_Bubble4",
    CN = "LanguageConfig_Monster_NewUnit4_EndBoss_Bubble4_CN|无知者……你们早已身处于吾神的国度。"
  },
  ActivityTaskDailyTitle = {
    ID = "ActivityTaskDailyTitle"
  },
  ActivityTaskWeeklyTitle = {
    ID = "ActivityTaskWeeklyTitle",
    CN = "LanguageConfig_ActivityTaskWeeklyTitle_CN|每周试炼"
  },
  ActivityTaskTotalFinished = {
    ID = "ActivityTaskTotalFinished",
    CN = "LanguageConfig_ActivityTaskTotalFinished_CN|常训任务已完成"
  },
  Card_Select_Get_Unit4BossBuff = {
    ID = "Card_Select_Get_Unit4BossBuff",
    CN = "LanguageConfig_Card_Select_Get_Unit4BossBuff_CN|选择获得 1 枚「圣象赐福」"
  },
  Card_Select_Get_Unit4BossDeBuff = {
    ID = "Card_Select_Get_Unit4BossDeBuff",
    CN = "LanguageConfig_Card_Select_Get_Unit4BossDeBuff_CN|选择 1 枚「圣象赐福」，将其反转为「诅咒」"
  },
  ["2ndAnniversaryTitleText"] = {
    ID = "2ndAnniversaryTitleText",
    CN = "LanguageConfig_2ndAnniversaryTitleText_CN|彼端的眷念"
  },
  ["2ndAnniversaryText"] = {
    ID = "2ndAnniversaryText",
    CN = "LanguageConfig_2ndAnniversaryText_CN|不论你在哪里，%player%。\n弥萨格一直在尝试进行维度链接，或许我们很快就能再见面了。\n朵尔说，她定位到了你所在的维度，我无法形容它令我的心感受到了怎样的狂喜。\n即使我偏好明确、精准、规则分明的事物，只有在这件事上，任何渺茫甚至不切实际的希望都没关系。\n比起长久的等待，我更无法想象永远不会重逢的别离。\n如果这一次没有成功，没关系，下一次，再下一次，或者千千万万次，不论需要多少次，我和弥萨格的所有人，都一定会带你回来。\n虽然如今我们在两个维度，弥萨格依然想办法用银芯科技搜罗了一些令你获得助力的可能，请凝聚我们过去的记忆，创造新的记忆，让这些礼物为你带来帮助吧。\n我们都知道，你一定会回来。\n因为我很擅长等待。"
  },
  ["2ndAnniversarySenderText"] = {
    ID = "2ndAnniversarySenderText",
    CN = "LanguageConfig_2ndAnniversarySenderText_CN|拉蒙娜"
  },
  ["2ndAnniversary_200DrawsText"] = {
    ID = "2ndAnniversary_200DrawsText",
    CN = "LanguageConfig_2ndAnniversary_200DrawsText_CN|完成活动任务最多可领取「流明之芯」×200！"
  },
  PVETeamShareCode = {
    ID = "PVETeamShareCode",
    CN = "LanguageConfig_PVETeamShareCode_CN|调查行动——编队分享\n守密人：{1}（{2}） 队伍名：{3}\n\n{10}、{21}、{23}、{25}\n{30}、{41}、{43}、{45}\n{50}、{61}、{63}、{65}\n{70}、{81}、{83}、{85}\n{4}\n\n{0}"
  },
  PVPTeamShareCode = {
    ID = "PVPTeamShareCode",
    CN = "LanguageConfig_PVPTeamShareCode_CN|相位对弈——编队分享\n守密人：{1}（{2}）\n\n编队名：{3}\n{12}、{7}、{6}、{5}、{4}\n{13}、{11}、{10}、{9}、{8}\n\n{0}"
  },
  PvPReplayCode = {
    ID = "PvPReplayCode",
    CN = "LanguageConfig_PvPReplayCode_CN|相位对弈-{25}——战斗回放\n\n{3}（{26}）\n{12}、{7}、{6}、{5}、{4}\n{13}、{11}、{10}、{9}、{8}\n---------------VS--------------------\n{14}（{27}）\n{23}、{18}、{17}、{16}、{15}\n{24}、{22}、{21}、{20}、{19}\n\n{0}"
  },
  PvEReplayCode = {
    ID = "PvEReplayCode",
    CN = "LanguageConfig_PvEReplayCode_CN|调查行动-{3}——战斗回放\n守密人：{1}（{2}）\n\n{4}、{5}、{6}、{17}\n{7}、{8}、{9}、{18}\n{10}、{11}、{12}、{19}\n{13}、{14}、{15}、{20}\n{16}\n\n{0}"
  },
  Card_Select_Redraw_Tips3 = {
    ID = "Card_Select_Redraw_Tips3",
    CN = "LanguageConfig_Card_Select_Redraw_Tips3_CN|最多丢弃 3 张并抽取等量卡牌"
  },
  ActivitySignReceiveRewardTimeLabel = {
    ID = "ActivitySignReceiveRewardTimeLabel",
    CN = "LanguageConfig_ActivitySignReceiveRewardTimeLabel_CN|剩余唤醒次数："
  },
  ActivitySignReceiveTaskTextAndCount = {
    ID = "ActivitySignReceiveTaskTextAndCount",
    CN = "LanguageConfig_ActivitySignReceiveTaskTextAndCount_CN|{s1} <color=#FFFFFF>{s2}</color>"
  },
  MaxLevelWeaponShopTips = {
    ID = "MaxLevelWeaponShopTips",
    CN = "LanguageConfig_MaxLevelWeaponShopTips_CN|叠位已满"
  },
  MaxPotencyAwakerShopTips = {
    ID = "MaxPotencyAwakerShopTips",
    CN = "LanguageConfig_MaxPotencyAwakerShopTips_CN|人格深化已满"
  },
  PvpDraftClickConfirmWhenNotSelect = {
    ID = "PvpDraftClickConfirmWhenNotSelect",
    CN = "LanguageConfig_PvpDraftClickConfirmWhenNotSelect_CN|请先选择参战唤醒体/命轮/钥令"
  },
  PvEReplayTabNullDesc = {
    ID = "PvEReplayTabNullDesc",
    CN = "LanguageConfig_PvEReplayTabNullDesc_CN|暂无调查行动记录"
  },
  PvPReplayTabNullDesc = {
    ID = "PvPReplayTabNullDesc",
    CN = "LanguageConfig_PvPReplayTabNullDesc_CN|暂无相位对弈记录"
  },
  RecordsSortTypeTime = {
    ID = "RecordsSortTypeTime",
    CN = "LanguageConfig_RecordsSortTypeTime_CN|通关日期"
  },
  ReplayTabTitle = {
    ID = "ReplayTabTitle",
    CN = "LanguageConfig_ReplayTabTitle_CN|战斗记录"
  },
  ReplayTabRule = {
    ID = "ReplayTabRule",
    CN = "LanguageConfig_ReplayTabRule_CN|<Title:【调查模式】>\n·在调查行动、无光之境和限时玩法活动等关卡调查完成后，可在此查看对应的调查记录。\n·失败的调查模式挑战不会被记录。\n·当前仅支持关卡中最后一场战斗的回放。\n\n<Title:【回放】>\n·可在下方的输入框内输入战斗记录来观看对应的战斗回放。\n·可以在调查模式「调查数据」、相位对弈「战斗结算」等界面中复制对战记录并分享给他人。\n·「调查行动」和「相位对弈」最多各保存100条，并且记录最多保留30天。"
  },
  PvEReplayDefeatTips = {
    ID = "PvEReplayDefeatTips",
    CN = "LanguageConfig_PvEReplayDefeatTips_CN|调查失败，无法分享回放。"
  },
  PvEReplayRoundsNum = {
    ID = "PvEReplayRoundsNum",
    CN = "LanguageConfig_PvEReplayRoundsNum_CN|最终战回合数"
  },
  PvEReplayAddRoundsNum = {
    ID = "PvEReplayAddRoundsNum",
    CN = "LanguageConfig_PvEReplayAddRoundsNum_CN|额外·最终战回合数"
  },
  PvPReplayModeDisp1 = {
    ID = "PvPReplayModeDisp1",
    CN = "LanguageConfig_PvPReplayModeDisp1_CN|预组模式"
  },
  PvPReplayModeDisp2 = {
    ID = "PvPReplayModeDisp2",
    CN = "LanguageConfig_PvPReplayModeDisp2_CN|轮选模式"
  },
  PvPReplayModeDisp3 = {
    ID = "PvPReplayModeDisp3",
    CN = "LanguageConfig_PvPReplayModeDisp3_CN|密码预组"
  },
  PvPReplayModeDisp4 = {
    ID = "PvPReplayModeDisp4",
    CN = "LanguageConfig_PvPReplayModeDisp4_CN|密码轮选"
  },
  PvPReplayModeDisp5 = {
    ID = "PvPReplayModeDisp5",
    CN = "LanguageConfig_PvPReplayModeDisp5_CN|友谊预组"
  },
  PvPReplayModeDisp6 = {
    ID = "PvPReplayModeDisp6",
    CN = "LanguageConfig_PvPReplayModeDisp6_CN|友谊轮选"
  },
  ReplayLoadingTitle = {
    ID = "ReplayLoadingTitle",
    CN = "LanguageConfig_ReplayLoadingTitle_CN|战斗记录"
  },
  ReplayLoadingTips = {
    ID = "ReplayLoadingTips",
    CN = "LanguageConfig_ReplayLoadingTips_CN|正在连接回放…"
  },
  PvpTaskViewTitle = {
    ID = "PvpTaskViewTitle",
    CN = "LanguageConfig_PvpTaskViewTitle_CN|对弈纪录"
  },
  PvpHistoryLevelViewTitle_PreBuild = {
    ID = "PvpHistoryLevelViewTitle_PreBuild",
    CN = "LanguageConfig_PvpHistoryLevelViewTitle_PreBuild_CN|预组奖励"
  },
  PvpHistoryLevelViewTitle_Draft = {
    ID = "PvpHistoryLevelViewTitle_Draft",
    CN = "LanguageConfig_PvpHistoryLevelViewTitle_Draft_CN|轮选奖励"
  },
  DailyHistoryLevelViewTitle_DailyChallenge = {
    ID = "DailyHistoryLevelViewTitle_DailyChallenge",
    CN = "LanguageConfig_DailyHistoryLevelViewTitle_DailyChallenge_CN|深潜奖励"
  },
  PvpHistoryLevelViewTitle_PreBuild_ExpProgress = {
    ID = "PvpHistoryLevelViewTitle_PreBuild_ExpProgress",
    CN = "LanguageConfig_PvpHistoryLevelViewTitle_PreBuild_ExpProgress_CN|预组经验{s1}"
  },
  PvpHistoryLevelViewTitle_Draft_ExpProgress = {
    ID = "PvpHistoryLevelViewTitle_Draft_ExpProgress",
    CN = "LanguageConfig_PvpHistoryLevelViewTitle_Draft_ExpProgress_CN|轮选经验{s1}"
  },
  DailyHistoryLevelViewTitle_DailyChallenge_ExpProgress = {
    ID = "DailyHistoryLevelViewTitle_DailyChallenge_ExpProgress",
    CN = "LanguageConfig_DailyHistoryLevelViewTitle_DailyChallenge_ExpProgress_CN|深潜经验{s1}"
  },
  DailyChallengeExpAttenuationRulesTips = {
    ID = "DailyChallengeExpAttenuationRulesTips",
    CN = "LanguageConfig_DailyChallengeExpAttenuationRulesTips_CN|·当「守密人等级」或「队伍平均等级」显著高于挑战关卡的推荐等级时，则获得深潜经验降低。"
  },
  DailyChallengeExpAttenuationRulesTipsTitle = {
    ID = "DailyChallengeExpAttenuationRulesTipsTitle",
    CN = "LanguageConfig_DailyChallengeExpAttenuationRulesTipsTitle_CN|规则说明"
  },
  DailyChallengeExpAttenuationRulesTipsAlert = {
    ID = "DailyChallengeExpAttenuationRulesTipsAlert",
    CN = "LanguageConfig_DailyChallengeExpAttenuationRulesTipsAlert_CN|获得深潜经验降低"
  },
  DailyChallengeExpOutBase = {
    ID = "DailyChallengeExpOutBase",
    CN = "LanguageConfig_DailyChallengeExpOutBase_CN|基础奖励"
  },
  DailyChallengeExpOutAttenuation = {
    ID = "DailyChallengeExpOutAttenuation",
    CN = "LanguageConfig_DailyChallengeExpOutAttenuation_CN|奖励衰减"
  },
  DailyChallengeExpRewardTask1 = {
    ID = "DailyChallengeExpRewardTask1",
    CN = "LanguageConfig_DailyChallengeExpRewardTask1_CN|挑战征程"
  },
  DailyChallengeExpRewardTask2 = {
    ID = "DailyChallengeExpRewardTask2",
    CN = "LanguageConfig_DailyChallengeExpRewardTask2_CN|超越征程"
  },
  WeeklyTotalWinTaskDesc = {
    ID = "WeeklyTotalWinTaskDesc",
    CN = "LanguageConfig_WeeklyTotalWinTaskDesc_CN|在限时活动、幻梦深潜或相位对弈中获得 {s1} 次胜利<color=#A3A6AB>({s2}/{s1})</color>"
  },
  DailyChallengeLevel = {
    ID = "DailyChallengeLevel",
    CN = "LanguageConfig_DailyChallengeLevel_CN|{s1}级"
  },
  DailyChallengeExpRewardCoefficientLevelTips = {
    ID = "DailyChallengeExpRewardCoefficientLevelTips",
    CN = "LanguageConfig_DailyChallengeExpRewardCoefficientLevelTips_CN|·若「守密人等级」与关卡的推荐等级相近，则挑战胜利即可完成深潜成就，获得「深潜经验」。\n   ·「挑战征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 40 级 时，可获得基础深潜经验。\n   ·「超越征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 20 级 时，可再额外获得一份基础深潜经验。"
  },
  CommonlyAssistCount = {
    ID = "CommonlyAssistCount",
    CN = "LanguageConfig_CommonlyAssistCount_CN|数量 <color=#ffffff>{s1}</color>/{s2}"
  },
  PvpCollectCommentUpdateTime = {
    ID = "PvpCollectCommentUpdateTime",
    CN = "LanguageConfig_PvpCollectCommentUpdateTime_CN|编辑于  {s1}"
  },
  WeeklyBossRemainTimes = {
    ID = "WeeklyBossRemainTimes",
    CN = "LanguageConfig_WeeklyBossRemainTimes_CN|本周「超验存在」剩余次数:<color={s1}>{s2}</color>/{s3}"
  },
  FavorabilityIncrease = {
    ID = "FavorabilityIncrease",
    CN = "LanguageConfig_FavorabilityIncrease_CN|{s1}  同调率<color=#1AE8F5>+{s2}</color>"
  },
  CopyLineup = {
    ID = "CopyLineup",
    CN = "LanguageConfig_CopyLineup_CN|复制阵容"
  },
  CopyRecording = {
    ID = "CopyRecording",
    CN = "LanguageConfig_CopyRecording_CN|复制回放"
  },
  CopyLeftLineup = {
    ID = "CopyLeftLineup",
    CN = "LanguageConfig_CopyLeftLineup_CN|复制左侧阵容"
  },
  CopyRightLineup = {
    ID = "CopyRightLineup",
    CN = "LanguageConfig_CopyRightLineup_CN|复制右侧阵容"
  },
  PvpBattleRewardRankBonus = {
    ID = "PvpBattleRewardRankBonus",
    CN = "LanguageConfig_PvpBattleRewardRankBonus_CN|积分加成"
  },
  Card_Select_Tips_2ndAnniversaryBOSS = {
    ID = "Card_Select_Tips_2ndAnniversaryBOSS",
    CN = "LanguageConfig_Card_Select_Tips_2ndAnniversaryBOSS_CN|选择至多 3 张卡牌赋予「余波」"
  },
  ExpFullTips = {
    ID = "ExpFullTips",
    CN = "LanguageConfig_ExpFullTips_CN|已满"
  },
  SummonLimitDesc = {
    ID = "SummonLimitDesc",
    CN = "LanguageConfig_SummonLimitDesc_CN|限定"
  },
  PVP_Opponent_Exited = {
    ID = "PVP_Opponent_Exited",
    CN = "LanguageConfig_PVP_Opponent_Exited_CN|对手已退出"
  },
  Monster_2ndAnniversary_WorldBoss1 = {
    ID = "Monster_2ndAnniversary_WorldBoss1",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss1_CN|敌人的影响让你难以打出卡牌！跟随银钥的指引战胜悲泣之化身！"
  },
  Monster_2ndAnniversary_WorldBoss2 = {
    ID = "Monster_2ndAnniversary_WorldBoss2",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss2_CN|释放狂气的手段似乎遭到了限制，爆发更多的狂气来突破恐惧之化身的封锁吧。"
  },
  Monster_2ndAnniversary_WorldBoss3 = {
    ID = "Monster_2ndAnniversary_WorldBoss3",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss3_CN|唤醒体的能力会被逐渐溶解，试着将力量集中于一人来战胜刺骨之化身！"
  },
  Monster_2ndAnniversary_WorldBoss4 = {
    ID = "Monster_2ndAnniversary_WorldBoss4",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss4_CN|敌人的锁链会影响你多次出手的能力，多次爆发突破封印即可战胜诡谲之化身！"
  },
  Monster_2ndAnniversary_WorldBoss5 = {
    ID = "Monster_2ndAnniversary_WorldBoss5",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss5_CN|通常的攻击手段似乎不太起作用…尝试换个思路来击破邪信之化身……"
  },
  Monster_2ndAnniversary_WorldBoss6 = {
    ID = "Monster_2ndAnniversary_WorldBoss6",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss6_CN|敌人的疯狂会让你丢失自我，回转更多的指令卡来对抗疯狂，战胜疯狂之化身！"
  },
  Monster_2ndAnniversary_WorldBoss7 = {
    ID = "Monster_2ndAnniversary_WorldBoss7",
    CN = "LanguageConfig_Monster_2ndAnniversary_WorldBoss7_CN|敌人的再生能力极强且能清除状态影响，每回合稳定造成伤害来击破诞临之化身！"
  },
  CancelAutoBattle = {
    ID = "CancelAutoBattle",
    CN = "LanguageConfig_CancelAutoBattle_CN|自动战斗已取消"
  },
  EnhancedPrompt = {
    ID = "EnhancedPrompt",
    CN = "LanguageConfig_EnhancedPrompt_CN|本赛季 {s1} 在幻梦深潜中行动时会变得躁狂，其体质、攻击力、防御力提高50%。"
  },
  DailyChallengeAttrBonus = {
    ID = "DailyChallengeAttrBonus",
    CN = "LanguageConfig_DailyChallengeAttrBonus_CN|属性+50%"
  },
  CollectionHall_Progress_Default = {
    ID = "CollectionHall_Progress_Default",
    CN = "LanguageConfig_CollectionHall_Progress_Default_CN|收集进度"
  },
  CollectionHall_Progress_Creation = {
    ID = "CollectionHall_Progress_Creation",
    CN = "LanguageConfig_CollectionHall_Progress_Creation_CN|造物收集"
  },
  CollectionHall_Progress_Event = {
    ID = "CollectionHall_Progress_Event",
    CN = "LanguageConfig_CollectionHall_Progress_Event_CN|事件收集"
  },
  CollectionHall_Progress_Role = {
    ID = "CollectionHall_Progress_Role",
    CN = "LanguageConfig_CollectionHall_Progress_Role_CN|角色收集"
  },
  CollectionHall_Progress_WorldView = {
    ID = "CollectionHall_Progress_WorldView",
    CN = "LanguageConfig_CollectionHall_Progress_WorldView_CN|洪积世界收集"
  },
  CollectionHall_Progress_StoryLineCG = {
    ID = "CollectionHall_Progress_StoryLineCG",
    CN = "LanguageConfig_CollectionHall_Progress_StoryLineCG_CN|剧情CG收集"
  },
  CollectionHall_Progress_ScenesCG = {
    ID = "CollectionHall_Progress_ScenesCG",
    CN = "LanguageConfig_CollectionHall_Progress_ScenesCG_CN|场景CG收集"
  },
  CollectionHall_Progress_PromotionVideo = {
    ID = "CollectionHall_Progress_PromotionVideo",
    CN = "LanguageConfig_CollectionHall_Progress_PromotionVideo_CN|PV收集"
  },
  CollectionHall_Progress_ActivityCG = {
    ID = "CollectionHall_Progress_ActivityCG",
    CN = "LanguageConfig_CollectionHall_Progress_ActivityCG_CN|活动收集"
  },
  CollectionHall_Progress_RadioDrama = {
    ID = "CollectionHall_Progress_RadioDrama",
    CN = "LanguageConfig_CollectionHall_Progress_RadioDrama_CN|广播剧收集"
  },
  CollectionHall_Progress_Music = {
    ID = "CollectionHall_Progress_Music",
    CN = "LanguageConfig_CollectionHall_Progress_Music_CN|留声机收集"
  },
  CollectionHall_Progress_Trinket = {
    ID = "CollectionHall_Progress_Trinket",
    CN = "LanguageConfig_CollectionHall_Progress_Trinket_CN|密契收集"
  },
  CollectionHall_Progress_Weapon = {
    ID = "CollectionHall_Progress_Weapon",
    CN = "LanguageConfig_CollectionHall_Progress_Weapon_CN|命轮收集"
  },
  Monster_Mouchette_Tips1 = {
    ID = "Monster_Mouchette_Tips1",
    CN = "LanguageConfig_Monster_Mouchette_Tips1_CN|注意，每当「雾中骇兽」的攻击受到抵挡，都会让她变得更强！"
  },
  Monster_Mouchette_Tips2 = {
    ID = "Monster_Mouchette_Tips2",
    CN = "LanguageConfig_Monster_Mouchette_Tips2_CN|当心，「雾中骇兽」的攻击每造成一次伤害，都会让她变得更加狂热！"
  },
  Monster_Mouchette_Bubble1 = {
    ID = "Monster_Mouchette_Bubble1",
    CN = "LanguageConfig_Monster_Mouchette_Bubble1_CN|闪耀☆龙卷风——！！"
  },
  Monster_Mouchette_Bubble2 = {
    ID = "Monster_Mouchette_Bubble2",
    CN = "LanguageConfig_Monster_Mouchette_Bubble2_CN|来吧，来吧！杀戮游戏开始了，让我们厮杀到世界尽头吧！"
  },
  Monster_Mouchette_Bubble3 = {
    ID = "Monster_Mouchette_Bubble3",
    CN = "LanguageConfig_Monster_Mouchette_Bubble3_CN|锵☆锵！杀戮时间到——接下来该我了哟~"
  },
  ShopEnchantGiftText = {
    ID = "ShopEnchantGiftText",
    CN = "LanguageConfig_ShopEnchantGiftText_CN|礼物"
  },
  PVPOpeningVoiceUnlockDesc = {
    ID = "PVPOpeningVoiceUnlockDesc",
    CN = "LanguageConfig_PVPOpeningVoiceUnlockDesc_CN|在相位对弈中触发该对话后解锁"
  },
  MultiSelectBox_FixItemTitle = {
    ID = "MultiSelectBox_FixItemTitle",
    CN = "LanguageConfig_MultiSelectBox_FixItemTitle_CN|固定物品"
  },
  MultiSelectBox_SelectItemTitle = {
    ID = "MultiSelectBox_SelectItemTitle",
    CN = "LanguageConfig_MultiSelectBox_SelectItemTitle_CN|自选物品"
  },
  MultiSelectBox_BuyConfirmText = {
    ID = "MultiSelectBox_BuyConfirmText",
    CN = "LanguageConfig_MultiSelectBox_BuyConfirmText_CN|是否确认购买以下物品？"
  },
  MultiSelectBox_SelectItemText = {
    ID = "MultiSelectBox_SelectItemText",
    CN = "LanguageConfig_MultiSelectBox_SelectItemText_CN|请选择礼包内容"
  },
  Monster_Faint_Tips1 = {
    ID = "Monster_Faint_Tips1",
    CN = "LanguageConfig_Monster_Faint_Tips1_CN|菲茵特正在汲取养料……尝试对其造成伤害打断她！"
  },
  Monster_Faint_Tips2 = {
    ID = "Monster_Faint_Tips2",
    CN = "LanguageConfig_Monster_Faint_Tips2_CN|每次打出指令卡都会被吸收力量，谨慎行动！"
  },
  Monster_Faint_Bubble1 = {
    ID = "Monster_Faint_Bubble1",
    CN = "LanguageConfig_Monster_Faint_Bubble1_CN|汀克特不想要我离开壳，但是她不在了……"
  },
  Monster_Faint_Bubble2 = {
    ID = "Monster_Faint_Bubble2",
    CN = "LanguageConfig_Monster_Faint_Bubble2_CN|失控…危险…远离我……"
  },
  Monster_Tinct_Tips1 = {
    ID = "Monster_Tinct_Tips1",
    CN = "LanguageConfig_Monster_Tinct_Tips1_CN|汀克特的幻光会造成「迟缓」……尽可能打出手中的保留卡牌！"
  },
  Monster_Tinct_Tips2 = {
    ID = "Monster_Tinct_Tips2",
    CN = "LanguageConfig_Monster_Tinct_Tips2_CN|手牌不会再自动丢弃，务必及时处理迟缓卡牌！"
  },
  Monster_Tinct_Bubble1 = {
    ID = "Monster_Tinct_Bubble1",
    CN = "LanguageConfig_Monster_Tinct_Bubble1_CN|我又要失去你了吗，姐姐……"
  },
  Monster_Tinct_Bubble2 = {
    ID = "Monster_Tinct_Bubble2",
    CN = "LanguageConfig_Monster_Tinct_Bubble2_CN|如果歌声响彻寰宇，你就能听到了吗，姐姐……"
  },
  Card_Select_Get_tawil = {
    ID = "Card_Select_Get_tawil",
    CN = "LanguageConfig_Card_Select_Get_tawil_CN|选择 3 张指令卡将其消耗"
  },
  Monster_tawil_Bubble0 = {
    ID = "Monster_tawil_Bubble0",
    CN = "LanguageConfig_Monster_tawil_Bubble0_CN|3……"
  },
  Monster_tawil_Bubble1 = {
    ID = "Monster_tawil_Bubble1",
    CN = "LanguageConfig_Monster_tawil_Bubble1_CN|2……"
  },
  Monster_tawil_Bubble2 = {
    ID = "Monster_tawil_Bubble2",
    CN = "LanguageConfig_Monster_tawil_Bubble2_CN|1……"
  },
  Monster_tawil_Bubble3 = {
    ID = "Monster_tawil_Bubble3",
    CN = "LanguageConfig_Monster_tawil_Bubble3_CN|你将以何为钥，叩响最终的门扉？"
  },
  Monster_tawil_Bubble4 = {
    ID = "Monster_tawil_Bubble4",
    CN = "LanguageConfig_Monster_tawil_Bubble4_CN|我知晓。我见证。我……于此降临。"
  },
  Monster_tawil_Bubble5 = {
    ID = "Monster_tawil_Bubble5",
    CN = "LanguageConfig_Monster_tawil_Bubble5_CN|穷极之门将启……最终的「答案」，就要映现。"
  },
  Monster_tawil_Bubble6 = {
    ID = "Monster_tawil_Bubble6",
    CN = "LanguageConfig_Monster_tawil_Bubble6_CN|万物自一而始。万物终归于一。"
  },
  Monster_tawil_Tips1 = {
    ID = "Monster_tawil_Tips1",
    CN = "LanguageConfig_Monster_tawil_Tips1_CN|每次使用指令卡都将使敌人的攻击强化，请谨慎行动！"
  },
  Monster_tawil_Tips2 = {
    ID = "Monster_tawil_Tips2",
    CN = "LanguageConfig_Monster_tawil_Tips2_CN|尽可能格挡敌人的伤害，避免受到「轮回悖论」影响！"
  },
  PontosHuoDong_Tips1 = {
    ID = "PontosHuoDong_Tips1",
    CN = "LanguageConfig_PontosHuoDong_Tips1_CN|选择「护卫」或「猎取」"
  },
  XuanWoHuodong1 = {
    ID = "XuanWoHuodong1",
    CN = "LanguageConfig_XuanWoHuodong1_CN|面对突然来找你玩的小煤球二世，你的选择是……"
  },
  TrinketCompletionRate = {
    ID = "TrinketCompletionRate",
    CN = "LanguageConfig_TrinketCompletionRate_CN|密契完成度"
  },
  CompilingShaders = {
    ID = "CompilingShaders",
    CN = "LanguageConfig_CompilingShaders_CN|正在编译着色器"
  },
  Monster_Liz_Tips1 = {
    ID = "Monster_Liz_Tips1",
    CN = "LanguageConfig_Monster_Liz_Tips1_CN|敌人受到伤害后会进行强化，请谨慎行动！"
  },
  Monster_Liz_Tips2 = {
    ID = "Monster_Liz_Tips2",
    CN = "LanguageConfig_Monster_Liz_Tips2_CN|敌人将释放告死之舞，弃掉所有卡牌，尽可能打出卡牌！"
  },
  Monster_Liz_Tips3 = {
    ID = "Monster_Liz_Tips3",
    CN = "LanguageConfig_Monster_Liz_Tips3_CN|敌人损失生命后会为绿炎助燃，控制节奏！"
  },
  Monster_Liz_Bubble1 = {
    ID = "Monster_Liz_Bubble1",
    CN = "LanguageConfig_Monster_Liz_Bubble1_CN|于绿炎中净化吧！"
  },
  Monster_Liz_Bubble2 = {
    ID = "Monster_Liz_Bubble2",
    CN = "LanguageConfig_Monster_Liz_Bubble2_CN|心怀敬意地欣赏吧，告死之舞……"
  },
  SDKLogining = {
    ID = "SDKLogining",
    CN = "LanguageConfig_SDKLogining_CN|「用户中心」登录中，请稍后。"
  },
  GamePassportTitle = {
    ID = "GamePassportTitle",
    CN = "LanguageConfig_GamePassportTitle_CN|守密纪行"
  },
  UltraPotencyCommingsoon = {
    ID = "UltraPotencyCommingsoon",
    CN = "LanguageConfig_UltraPotencyCommingsoon_CN|敬请期待"
  },
  UltraPotencyLockedName = {
    ID = "UltraPotencyLockedName",
    CN = "LanguageConfig_UltraPotencyLockedName_CN|最终法则"
  },
  DailyChallengeRightWeeklyTitle = {
    ID = "DailyChallengeRightWeeklyTitle",
    CN = "LanguageConfig_DailyChallengeRightWeeklyTitle_CN|本周深潜记录"
  },
  PotencyUnlockFormat = {
    ID = "PotencyUnlockFormat",
    CN = "LanguageConfig_PotencyUnlockFormat_CN|人格深化{s1}解锁"
  },
  OverLimitUtlSkill = {
    ID = "OverLimitUtlSkill",
    CN = "LanguageConfig_OverLimitUtlSkill_CN|<OverLimitUtlSkillKeywords:超限爆发>"
  },
  UltraPotencyDesc = {
    ID = "UltraPotencyDesc",
    CN = "LanguageConfig_UltraPotencyDesc_CN|唤醒体人格深化达到 +12 时会激活「最终法则」，激活后可获得一些独特的效果。"
  },
  UltraPotencyKeywords = {
    ID = "UltraPotencyKeywords",
    CN = "LanguageConfig_UltraPotencyKeywords_CN|<UltraPotencyKeywords:最终法则>"
  },
  FiveFreePullsTips = {
    ID = "FiveFreePullsTips",
    CN = "LanguageConfig_FiveFreePullsTips_CN|可免费 5 连唤醒 {s1} 次"
  },
  Monster_RamonoPlus_Tips1 = {
    ID = "Monster_RamonoPlus_Tips1",
    CN = "LanguageConfig_Monster_RamonoPlus_Tips1_CN|释放钥令会使「觉者」积攒回环，请勿滥用！"
  },
  Monster_RamonoPlus_Tips2 = {
    ID = "Monster_RamonoPlus_Tips2",
    CN = "LanguageConfig_Monster_RamonoPlus_Tips2_CN|「觉者」预知了数张卡牌。打出后会为敌人提供回环，尝试将其弃置。"
  },
  Monster_RamonoPlus_Bubble1 = {
    ID = "Monster_RamonoPlus_Bubble1",
    CN = "LanguageConfig_Monster_RamonoPlus_Bubble1_CN|因果于此刻闭合，迎接你的昨日。"
  },
  Monster_RamonoPlus_Bubble2 = {
    ID = "Monster_RamonoPlus_Bubble2",
    CN = "LanguageConfig_Monster_RamonoPlus_Bubble2_CN|剑锋承载万千轮回，你，无处可逃！"
  },
  PasswordBattlePasswordPrompt = {
    ID = "PasswordBattlePasswordPrompt",
    CN = "LanguageConfig_PasswordBattlePasswordPrompt_CN|请输入 6 位密码。"
  },
  ActivityRewardTitle = {
    ID = "ActivityRewardTitle",
    CN = "LanguageConfig_ActivityRewardTitle_CN|成就奖励"
  },
  RailWaySaveAndExit = {
    ID = "RailWaySaveAndExit",
    CN = "LanguageConfig_RailWaySaveAndExit_CN|保存并退出"
  },
  RailWayStageMileExpGetTitle = {
    ID = "RailWayStageMileExpGetTitle",
    CN = "LanguageConfig_RailWayStageMileExpGetTitle_CN|贵宾积分"
  },
  RailWayStageMileExpGetDesc = {
    ID = "RailWayStageMileExpGetDesc",
    CN = "LanguageConfig_RailWayStageMileExpGetDesc_CN|本次调查最多获得{s1}「贵宾积分」。\n已使用{s3}次「应急灵知体」，当前已获得{s2}「贵宾积分」。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75\n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150\n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n  ·困难/癫狂难度所获得的「贵宾积分」会提高 150%/400%\n  ·每使用 1次「应急灵知体」，「贵宾积分」降低20%。"
  },
  RailWayStageCrazyMileExpGetDesc = {
    ID = "RailWayStageCrazyMileExpGetDesc",
    CN = "LanguageConfig_RailWayStageCrazyMileExpGetDesc_CN|本次调查最多获得{s1}「贵宾积分」。\n已使用{s3}次「应急灵知体」，当前已获得{s2}「贵宾积分」。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75\n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150\n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n  ·困难/癫狂难度所获得的「贵宾积分」会提高 150%/400%\n  ·每使用 1次「应急灵知体」，「贵宾积分」降低20%。"
  },
  RailWayStageCrazyMileExpGetDescV2 = {
    ID = "RailWayStageCrazyMileExpGetDescV2",
    CN = "LanguageConfig_RailWayStageCrazyMileExpGetDescV2_CN|本次调查最多获得{s1}「贵宾积分」。\n已使用{s3}次「应急灵知体」，当前已获得{s2}「贵宾积分」。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75\n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150\n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n  ·困难/癫狂难度所获得的「贵宾积分」会提高 150%/400%\n  ·击败癫狂难度第四阶段首领可额外获得「贵宾积分」× 1500。\n  ·每使用 1次「应急灵知体」，「贵宾积分」降低20%。"
  },
  RailWayStageNowTitle = {
    ID = "RailWayStageNowTitle",
    CN = "LanguageConfig_RailWayStageNowTitle_CN|调查进度"
  },
  RailWayStageNowDesc = {
    ID = "RailWayStageNowDesc",
    CN = "LanguageConfig_RailWayStageNowDesc_CN|当前调查中会有 3 个阶段，每个阶段有 6 场战斗。\n当前已到第 {s1} 阶段-第 {s2} 场战斗。"
  },
  RailWayStageCrazyNowDesc = {
    ID = "RailWayStageCrazyNowDesc",
    CN = "LanguageConfig_RailWayStageCrazyNowDesc_CN|当前调查中会有 3 个阶段，每个阶段有 6 场战斗。\n当前已到第 {s1} 阶段-第 {s2} 场战斗。"
  },
  RailWayStageCrazyNowDescV2 = {
    ID = "RailWayStageCrazyNowDescV2",
    CN = "LanguageConfig_RailWayStageCrazyNowDescV2_CN|癫狂难度会有 4 个阶段，前 3 个阶段中每个阶段有 6 场战斗。第 4 阶段会直接挑战最终首领。\n当前已到第 {s1} 阶段-第 {s2} 场战斗。"
  },
  RailWayOutBreakRecordTips = {
    ID = "RailWayOutBreakRecordTips",
    CN = "LanguageConfig_RailWayOutBreakRecordTips_CN|进度新高！"
  },
  RailWayOutMaxExp = {
    ID = "RailWayOutMaxExp",
    CN = "LanguageConfig_RailWayOutMaxExp_CN|{s1}「贵宾积分」"
  },
  RailWayStageInformationTitle = {
    ID = "RailWayStageInformationTitle",
    CN = "LanguageConfig_RailWayStageInformationTitle_CN|关卡规则说明"
  },
  ContinueChanllengeBtnTxt = {
    ID = "ContinueChanllengeBtnTxt",
    CN = "LanguageConfig_ContinueChanllengeBtnTxt_CN|继续挑战"
  },
  RailWayMaxProgress = {
    ID = "RailWayMaxProgress",
    CN = "LanguageConfig_RailWayMaxProgress_CN|生涯最高进度"
  },
  RailWayCurProgress = {
    ID = "RailWayCurProgress",
    CN = "LanguageConfig_RailWayCurProgress_CN|当前进度{s1}"
  },
  RailWayHistoryLevelViewTitle = {
    ID = "RailWayHistoryLevelViewTitle",
    CN = "LanguageConfig_RailWayHistoryLevelViewTitle_CN|雅室规格"
  },
  RailHistoryLevelViewTitle_ExpProgress = {
    ID = "RailHistoryLevelViewTitle_ExpProgress",
    CN = "LanguageConfig_RailHistoryLevelViewTitle_ExpProgress_CN|贵宾积分{s1}"
  },
  RailWayRulesTitle = {
    ID = "RailWayRulesTitle",
    CN = "LanguageConfig_RailWayRulesTitle_CN|疾驰的欢愉专列"
  },
  RailWayRulesContent = {
    ID = "RailWayRulesContent",
    CN = "LanguageConfig_RailWayRulesContent_CN|<Title:玩法简介>\n1、「疾驰的欢愉专列」是采用「星辰篇」规则的连续挑战模式。守密人将在多变的随机遭遇中连续挑战多个调查行动中出现过的最终首领！\n2、玩法中造物持有上限最高可提升至 36 个。\n3、挑战过程中可同时拥有并强化 3 种调查行动中的强大「共鸣」效果。\n4、每使用 1 次应急灵知体，会减少 20% 本次挑战获取的「贵宾积分」。\n5、支持中途退出并保留进度，但队伍状态不会随外部养成变化同步更新。进度至多保留至上一次挑战的 7 天后，若保留期间没有继续挑战则视为放弃挑战，进度不再保留。\n\n<Title:等级补偿>\n参与「列车启程」会获得等级补偿，具体规则如下：\n  ·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n  ·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n  ·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·若守密人等级不足60级，在本次挑战中将会补偿至60级。\n\n<Title:关卡阶段>\n1、单次挑战总计分为三个阶段，每个阶段的主题敌人与共鸣效果将在对应范围内随机生成：\n  ·第一阶段： 对应「忘却篇」第一至四章内容。\n  ·第二阶段： 对应「忘却篇」第五至八章内容。\n  ·第三阶段： 对应「星辰篇」第一至四章内容。\n2、击败阶段首领后，可从随机 3 个「时灵摆」中择一获取。\n\n<Title:难度与初始造物>\n本次挑战共设三个难度，各难度有不同的关卡奖励和初始造物，各位守密人可以在选择挑战难度前了解详细信息。\n\n<Title:关卡奖励>\n1、通过击败各难度中的精英与首领可获取「贵宾积分」，「贵宾积分」用于提升「雅室规格」等级以获取奖励。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75 \n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150 \n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n2、挑战的难度越高，将会获得越多的「贵宾积分」。\n  ·【困难难度】：完成三个阶段获得的「贵宾积分」提高 150%\n  ·【癫狂难度】：完成三个阶段获得的「贵宾积分」提高 400%\n\n<Title:赛季更新>\n1、「贵宾名录」会记录挑战表现优异的守密人，每个赛季期间挑战 1 次，并且成功获得「贵宾积分」的守密人即可进入「贵宾名录」。\n2、「贵宾名录」的赛季排名会以单次挑战获得最多的「贵宾积分」和所用最少的「回合数」为依据，可重复挑战以提高排名。\n3、赛季结束后，会通过邮件结算本赛季「贵宾名录」的排名奖励。\n4、每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在每次赛季更新时重置。\n5、赛季切换时，尚在战斗中的关卡在完成挑战后可以直接完成最新的赛季任务，但无法进入最新一期「贵宾名录」。"
  },
  RailWayRulesContentV2 = {
    ID = "RailWayRulesContentV2",
    CN = "LanguageConfig_RailWayRulesContentV2_CN|<Title:玩法简介>\n1、「疾驰的欢愉专列」是采用「星辰篇」规则的连续挑战模式。守密人将在多变的随机遭遇中连续挑战多个调查行动中出现过的最终首领！\n2、玩法中造物持有上限最高可提升至 36 个。\n3、挑战过程中可同时拥有并强化 3 种调查行动中的强大「共鸣」效果。\n4、每使用 1 次应急灵知体，会减少 20% 本次挑战获取的「贵宾积分」。\n5、支持中途退出并保留进度，但队伍状态不会随外部养成变化同步更新。进度至多保留至上一次挑战的 7 天后，若保留期间没有继续挑战则视为放弃挑战，进度不再保留。\n\n<Title:等级补偿>\n参与「列车启程」会获得等级补偿，具体规则如下：\n  ·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n  ·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n  ·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·若守密人等级不足60级，在本次挑战中将会补偿至60级。\n\n<Title:关卡阶段>\n1、单次挑战总计分为三个阶段，每个阶段的主题敌人与共鸣效果将在对应范围内随机生成：\n  ·第一阶段： 对应「忘却篇」第一至四章内容。\n  ·第二阶段： 对应「忘却篇」第五至八章内容。\n  ·第三阶段： 对应「星辰篇」第一至四章内容。\n ·在癫狂难度下，完成第三阶段挑战后将额外挑战第四阶段最终首领「塔薇」。\n2、击败阶段首领后，可从随机 3 个「时灵摆」中择一获取。\n\n<Title:难度与初始造物>\n本次挑战共设三个难度，各难度有不同的关卡奖励和初始造物，各位守密人可以在选择挑战难度前了解详细信息。\n\n<Title:关卡奖励>\n1、通过击败各难度中的精英与首领可获取「贵宾积分」，「贵宾积分」用于提升「雅室规格」等级以获取奖励。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75 \n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150 \n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n2、挑战的难度越高，将会获得越多的「贵宾积分」。\n  ·【困难难度】：完成三个阶段获得的「贵宾积分」提高 150% \n\n  ·【癫狂难度】：完成三个阶段获得的「贵宾积分」提高 400%\n ·击败最终首领「塔薇」后，可额外获得「贵宾积分」× 1500。\n\n<Title:赛季更新>\n1、「贵宾名录」会记录挑战表现优异的守密人，每个赛季期间挑战 1 次，并且成功获得「贵宾积分」的守密人即可进入「贵宾名录」。\n2、「贵宾名录」的赛季排名会以单次挑战获得最多的「贵宾积分」和所用最少的「回合数」为依据，可重复挑战以提高排名。\n3、赛季结束后，会通过邮件结算本赛季「贵宾名录」的排名奖励。\n4、每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在每次赛季更新时重置。\n5、赛季切换时，尚在战斗中的关卡在完成挑战后可以直接完成最新的赛季任务，但无法进入「贵宾名录」。"
  },
  PermanentActivityTitle = {
    ID = "PermanentActivityTitle",
    CN = "LanguageConfig_PermanentActivityTitle_CN|记忆回廊"
  },
  PermanentActivityRuleTitle = {
    ID = "PermanentActivityRuleTitle",
    CN = "LanguageConfig_PermanentActivityRuleTitle_CN|规则说明"
  },
  PermanentActivityRuleContent = {
    ID = "PermanentActivityRuleContent",
    CN = "LanguageConfig_PermanentActivityRuleContent_CN|<Title:记忆回廊>\n·带有「记忆回廊」标记的活动，在活动时间结束后将被收录到「记忆回廊」中，可继续在「记忆回廊」中体验相应的玩法和剧情。\n<Title:收录规则>\n·带有「记忆回廊」标记的活动会有丰富的限时奖励，在活动时间结束后限时奖励将无法再领取，请各位守密人及时领取限时奖励。\n·活动被收录到「记忆回廊」后，会自动保留此前的进度，各位守密人可继续体验。"
  },
  RailWayTaskViewTitle = {
    ID = "RailWayTaskViewTitle",
    CN = "LanguageConfig_RailWayTaskViewTitle_CN|沿途留影"
  },
  RailWayLevelAdjustmentTips = {
    ID = "RailWayLevelAdjustmentTips",
    CN = "LanguageConfig_RailWayLevelAdjustmentTips_CN|等级补偿"
  },
  RailWayLevelAdjustmentTipsTitle = {
    ID = "RailWayLevelAdjustmentTipsTitle",
    CN = "LanguageConfig_RailWayLevelAdjustmentTipsTitle_CN|等级补偿"
  },
  RailWayLevelAdjustmentTipsContent = {
    ID = "RailWayLevelAdjustmentTipsContent",
    CN = "LanguageConfig_RailWayLevelAdjustmentTipsContent_CN|在「疾驰的欢愉专列」中有等级补偿机制，具体规则如下：\n  ·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n  ·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n  ·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·若守密人等级不足60级，在本次挑战中将会补偿至60级。"
  },
  RailWayActivityRewardTitle = {
    ID = "RailWayActivityRewardTitle",
    CN = "LanguageConfig_RailWayActivityRewardTitle_CN|专列轨迹"
  },
  RailWayResonanceRuleContent = {
    ID = "RailWayResonanceRuleContent",
    CN = "LanguageConfig_RailWayResonanceRuleContent_CN|1、在「疾驰的欢愉专列」有更丰富的共鸣强化，以便在挑战中为守密人们提供强力的协助。\n2、在「沿途留影」中可以获得共鸣升级材料，消耗材料可以激活共鸣效果。\n3、每个阶段都会有调查行动共鸣事件，进入调查行动共鸣事件后将获得对应章节的强力共鸣效果，该共鸣效果会持续至整场调查结束。\n4、在「小「N」的协助」中获得的共鸣效果将会从调查开始持续至调查结束。"
  },
  RailWayStageDifficultyBuffContent1 = {
    ID = "RailWayStageDifficultyBuffContent1",
    CN = "LanguageConfig_RailWayStageDifficultyBuffContent1_CN|<Title:关卡奖励>\n第一阶段：战胜精英/首领获得「贵宾积分」×25/75 \n第二阶段：战胜精英/首领获得「贵宾积分」×50/150 \n第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n<Title:初始造物>\n调查开始时获得造物「小「N」的完整相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。"
  },
  RailWayStageDifficultyBuffContent2 = {
    ID = "RailWayStageDifficultyBuffContent2",
    CN = "LanguageConfig_RailWayStageDifficultyBuffContent2_CN|<Title:关卡奖励>\n挑战的难度越高，将会获得越多的「贵宾积分」。完成三个阶段获得的「贵宾积分」提高 150%\n<Title:初始造物>\n调查开始时获得造物「小「N」的破旧相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 1 。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。\n·<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。"
  },
  RailWayStageDifficultyBuffContent3 = {
    ID = "RailWayStageDifficultyBuffContent3",
    CN = "LanguageConfig_RailWayStageDifficultyBuffContent3_CN|<Title:关卡奖励>\n挑战的难度越高，将会获得越多的「贵宾积分」。完成三个阶段获得的「贵宾积分」提高 400%\n<Title:初始造物>\n调查开始时获得造物「小「N」的混乱相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 2 。\n·<OrangeQuality:受祝仪式>：战胜第一、第二阶段的首领奖励变更为随机受祝造物 3 选 1。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。\n·<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。\n·<RedQuality:永夜长廊>：探索开始时，所有唤醒体的基础狂气与银钥能量上限提高 50%"
  },
  RailWayStageDifficultyBuffContent3V2 = {
    ID = "RailWayStageDifficultyBuffContent3V2",
    CN = "LanguageConfig_RailWayStageDifficultyBuffContent3V2_CN|<Title:特别挑战>\n癫狂难度下，完成第三阶段后将额外挑战第四阶段最终首领「塔薇」。\n<Title:关卡奖励>\n挑战的难度越高，将会获得越多的「贵宾积分」。完成三个阶段获得的「贵宾积分」提高 400%\n击败最终首领「塔薇」后，可额外获得「贵宾积分」× 1500。\n<Title:初始造物>\n调查开始时获得造物「小「N」的混乱相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 2 。\n·<OrangeQuality:受祝仪式>：战胜第一、第二阶段的首领奖励变更为随机受祝造物 3 选 1。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。\n·<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。\n·<RedQuality:永夜长廊>：探索开始时，所有唤醒体的基础狂气与银钥能量上限提高 50%"
  },
  HowToPlayTxt = {
    ID = "HowToPlayTxt",
    CN = "LanguageConfig_HowToPlayTxt_CN|玩法说明"
  },
  Monster_ALKN_Tips1 = {
    ID = "Monster_ALKN_Tips1",
    CN = "LanguageConfig_Monster_ALKN_Tips1_CN|每回合首张指令卡会落入维度裂隙，释放钥令将它拨回原轨。"
  },
  Monster_ALKN_Tips2 = {
    ID = "Monster_ALKN_Tips2",
    CN = "LanguageConfig_Monster_ALKN_Tips2_CN|维度裂隙中的卡牌已被堕落的命运污染，谨慎打出！"
  },
  Monster_ALKN_Bubble1 = {
    ID = "Monster_ALKN_Bubble1",
    CN = "LanguageConfig_Monster_ALKN_Bubble1_CN|转动吧，纺轮将织就万物。"
  },
  Monster_ALKN_Bubble2 = {
    ID = "Monster_ALKN_Bubble2",
    CN = "LanguageConfig_Monster_ALKN_Bubble2_CN|命运捆缚你我，无人可以逃离……"
  },
  Monster_ALKN_Bubble3 = {
    ID = "Monster_ALKN_Bubble3",
    CN = "LanguageConfig_Monster_ALKN_Bubble3_CN|裁断吧，无法挽回的命运啊。"
  },
  RailWaySettlementDetails1 = {
    ID = "RailWaySettlementDetails1",
    CN = "LanguageConfig_RailWaySettlementDetails1_CN|基础奖励"
  },
  RailWaySettlementDetails2 = {
    ID = "RailWaySettlementDetails2",
    CN = "LanguageConfig_RailWaySettlementDetails2_CN|使用应急灵知体降低"
  },
  Monster_TwistedFate1 = {
    ID = "Monster_TwistedFate1",
    CN = "LanguageConfig_Monster_TwistedFate1_CN|破除@2！吞噬@3！！！"
  },
  Monster_TwistedFate2 = {
    ID = "Monster_TwistedFate2",
    CN = "LanguageConfig_Monster_TwistedFate2_CN|狂气爆发会让敌人的意图改变并强化，请当心！"
  },
  Monster_ALKN_DarkTips1 = {
    ID = "Monster_ALKN_DarkTips1",
    CN = "LanguageConfig_Monster_ALKN_DarkTips1_CN|命运的终局，就快要降临……"
  },
  Monster_ALKN_DarkTips2 = {
    ID = "Monster_ALKN_DarkTips2",
    CN = "LanguageConfig_Monster_ALKN_DarkTips2_CN|接受吧，阿拉克涅……命运，将为你带来解脱！！"
  },
  Monster_ALKN_DarkTips3 = {
    ID = "Monster_ALKN_DarkTips3",
    CN = "LanguageConfig_Monster_ALKN_DarkTips3_CN|「过去——以命运的丝线封缄，你将永坠沉默之渊！」"
  },
  Monster_ALKN_DarkTips4 = {
    ID = "Monster_ALKN_DarkTips4",
    CN = "LanguageConfig_Monster_ALKN_DarkTips4_CN|「现在—— 让一切命数与编织的谎言，统统化为灰烬！」"
  },
  Monster_ALKN_DarkTips5 = {
    ID = "Monster_ALKN_DarkTips5",
    CN = "LanguageConfig_Monster_ALKN_DarkTips5_CN|「未来——将这枚荆棘的种子，深埋入明日的土壤。未来，我们一无所有……」"
  },
  Monster_ALKN_DarkTips6 = {
    ID = "Monster_ALKN_DarkTips6",
    CN = "LanguageConfig_Monster_ALKN_DarkTips6_CN|「断吧……断吧！来啊，命运！我用一切被抛弃的尸骨，为你献上这最后一支悲歌！」"
  },
  Monster_ALKNSpider_DarkTips = {
    ID = "Monster_ALKNSpider_DarkTips",
    CN = "LanguageConfig_Monster_ALKNSpider_DarkTips_CN|哭吧，笑吧！那宿命的终末，就快要来临！"
  },
  Monster_ALKNSpider_LightTips = {
    ID = "Monster_ALKNSpider_LightTips",
    CN = "LanguageConfig_Monster_ALKNSpider_LightTips_CN|睡吧，睡吧……那宿命的结局，将于此降临……"
  },
  Card_Select_Puppet_Tips = {
    ID = "Card_Select_Puppet_Tips",
    CN = "LanguageConfig_Card_Select_Puppet_Tips_CN|选择 1 张卡牌，将其强制打出。"
  },
  AwakerMaxLevelBtnPreview = {
    ID = "AwakerMaxLevelBtnPreview",
    CN = "LanguageConfig_AwakerMaxLevelBtnPreview_CN|{s1}级预览"
  },
  ItemNameNumShow = {
    ID = "ItemNameNumShow",
    CN = "LanguageConfig_ItemNameNumShow_CN|「{s1}」×{s2}"
  },
  ItemNameNumNextLineShow = {
    ID = "ItemNameNumNextLineShow",
    CN = "LanguageConfig_ItemNameNumNextLineShow_CN|「{s1}」\n×{s2}"
  },
  ItemNumShow = {
    ID = "ItemNumShow",
    CN = "LanguageConfig_ItemNumShow_CN|×{s1}"
  },
  ItemNameShow = {
    ID = "ItemNameShow",
    CN = "LanguageConfig_ItemNameShow_CN|「{s1}」"
  },
  Monster_NewUnit5_EndBoss_Tips1 = {
    ID = "Monster_NewUnit5_EndBoss_Tips1",
    CN = "LanguageConfig_Monster_NewUnit5_EndBoss_Tips1_CN|打出指令卡会使敌人命运的束缚逐渐降低，从而获得狂热……"
  },
  Monster_NewUnit5_EndBoss_Tips2 = {
    ID = "Monster_NewUnit5_EndBoss_Tips2",
    CN = "LanguageConfig_Monster_NewUnit5_EndBoss_Tips2_CN|打出指令卡会进入维度裂隙，并赋予同名卡「命运残碎」。积累命运残碎，让阿拉克涅修正这扭曲的命运吧！"
  },
  Monster_NewUnit5_EndBoss_Bubble1 = {
    ID = "Monster_NewUnit5_EndBoss_Bubble1",
    CN = "LanguageConfig_Monster_NewUnit5_EndBoss_Bubble1_CN|接受吧，阿拉克涅……命运，将为你带来解脱！！"
  },
  SetLogInReward_PC_Tips = {
    ID = "SetLogInReward_PC_Tips",
    CN = "LanguageConfig_SetLogInReward_PC_Tips_CN|使用PC设备登录"
  },
  SetLogInReward_MOBILE_Tips = {
    ID = "SetLogInReward_MOBILE_Tips",
    CN = "LanguageConfig_SetLogInReward_MOBILE_Tips_CN|使用移动设备登录"
  },
  SetLogInReward_Tips = {
    ID = "SetLogInReward_Tips",
    CN = "LanguageConfig_SetLogInReward_Tips_CN|多平台登录可获得限定头像等奖励！"
  },
  laikegamblingsuccess = {
    ID = "laikegamblingsuccess",
    CN = "LanguageConfig_laikegamblingsuccess_CN|豪赌的智慧-双发！"
  },
  SummonOptionCountDesc = {
    ID = "SummonOptionCountDesc",
    CN = "LanguageConfig_SummonOptionCountDesc_CN|已选<space=0.2em><color=#e1e1e1>{s1}/{s2}</color>"
  },
  GuideNotePermResSummaryProgress = {
    ID = "GuideNotePermResSummaryProgress",
    CN = "LanguageConfig_GuideNotePermResSummaryProgress_CN|{s1} / {s2}"
  },
  Localized = {
    ID = "Localized",
    CN = "LanguageConfig_Localized_CN|已本地化"
  },
  SeasonRankListSettlementNotice1 = {
    ID = "SeasonRankListSettlementNotice1",
    CN = "LanguageConfig_SeasonRankListSettlementNotice1_CN|本赛季将在{s1}天{s2}小时后结算排行奖励"
  },
  SeasonRankListSettlementNotice2 = {
    ID = "SeasonRankListSettlementNotice2",
    CN = "LanguageConfig_SeasonRankListSettlementNotice2_CN|本赛季将在{s1}小时{s2}分钟后结算排行奖励"
  },
  FilterAwakerOptionsTipsTitle = {
    ID = "FilterAwakerOptionsTipsTitle",
    CN = "LanguageConfig_FilterAwakerOptionsTipsTitle_CN|选择通关唤醒体"
  },
  FilterAwakerOptionsTipsDesc = {
    ID = "FilterAwakerOptionsTipsDesc",
    CN = "LanguageConfig_FilterAwakerOptionsTipsDesc_CN|可筛选特定唤醒体，了解携带该唤醒体的阵容。"
  },
  FilterAwakerUnableSelect = {
    ID = "FilterAwakerUnableSelect",
    CN = "LanguageConfig_FilterAwakerUnableSelect_CN|无法选择"
  },
  LoginPlatFormActivityTxt = {
    ID = "LoginPlatFormActivityTxt",
    CN = "LanguageConfig_LoginPlatFormActivityTxt_CN|完善资料、使用不同设备游玩并提取源液，即可获得专属限定头像与幻衣奖励！"
  },
  TutorialTaskLabel = {
    ID = "TutorialTaskLabel",
    CN = "LanguageConfig_TutorialTaskLabel_CN|教程"
  },
  Task_SubTab_Achievement = {
    ID = "Task_SubTab_Achievement",
    CN = "LanguageConfig_Task_SubTab_Achievement_CN|生涯成就"
  },
  GuideNote_MaterialNeeded = {
    ID = "GuideNote_MaterialNeeded",
    CN = "LanguageConfig_GuideNote_MaterialNeeded_CN|还需获得素材"
  },
  GuideNote_MaterialMet = {
    ID = "GuideNote_MaterialMet",
    CN = "LanguageConfig_GuideNote_MaterialMet_CN|素材已满足"
  },
  GuideNote_RecommendMystic = {
    ID = "GuideNote_RecommendMystic",
    CN = "LanguageConfig_GuideNote_RecommendMystic_CN|推荐密契"
  },
  GuideNote_Title1 = {
    ID = "GuideNote_Title1",
    CN = "LanguageConfig_GuideNote_Title1_CN|密境课室"
  },
  GuideNote_Title2 = {
    ID = "GuideNote_Title2",
    CN = "LanguageConfig_GuideNote_Title2_CN|日常试训"
  },
  GuideNote_Title3 = {
    ID = "GuideNote_Title3",
    CN = "LanguageConfig_GuideNote_Title3_CN|周常试训"
  },
  GuideNote_Title4 = {
    ID = "GuideNote_Title4",
    CN = "LanguageConfig_GuideNote_Title4_CN|强化秘仪"
  },
  GuideNote_Title5 = {
    ID = "GuideNote_Title5",
    CN = "LanguageConfig_GuideNote_Title5_CN|禁忌试炼"
  },
  GuideNote_Title6 = {
    ID = "GuideNote_Title6",
    CN = "LanguageConfig_GuideNote_Title6_CN|银辉之路"
  },
  GuideNote_Title7 = {
    ID = "GuideNote_Title7",
    CN = "LanguageConfig_GuideNote_Title7_CN|资源勘探"
  },
  GuideNote_ResetTime = {
    ID = "GuideNote_ResetTime",
    CN = "LanguageConfig_GuideNote_ResetTime_CN|重置时间"
  },
  InheritConsumeDrawItemConvertTips = {
    ID = "InheritConsumeDrawItemConvertTips",
    CN = "LanguageConfig_InheritConsumeDrawItemConvertTips_CN|即将转化为「无垢之芯」"
  },
  GuideNote_MoreImprovement = {
    ID = "GuideNote_MoreImprovement",
    CN = "LanguageConfig_GuideNote_MoreImprovement_CN|更多提升"
  },
  GuideNote_Breakthrough = {
    ID = "GuideNote_Breakthrough",
    CN = "LanguageConfig_GuideNote_Breakthrough_CN|满足升格条件(任选其一)"
  },
  GuideNote_SkillImprovement = {
    ID = "GuideNote_SkillImprovement",
    CN = "LanguageConfig_GuideNote_SkillImprovement_CN|技能升级条件"
  },
  GuideNote_CrazyOmen = {
    ID = "GuideNote_CrazyOmen",
    CN = "LanguageConfig_GuideNote_CrazyOmen_CN|疯狂预兆升级条件"
  },
  GuideNote_Format = {
    ID = "GuideNote_Format",
    CN = "LanguageConfig_GuideNote_Format_CN|\n   · {s1}"
  },
  GuideNote_ExplorationProgress = {
    ID = "GuideNote_ExplorationProgress",
    CN = "LanguageConfig_GuideNote_ExplorationProgress_CN|当前收集进度"
  },
  GuideNote_Rules_Title1 = {
    ID = "GuideNote_Rules_Title1",
    CN = "LanguageConfig_GuideNote_Rules_Title1_CN|日常试训"
  },
  GuideNote_Rules_Title2 = {
    ID = "GuideNote_Rules_Title2",
    CN = "LanguageConfig_GuideNote_Rules_Title2_CN|周常试训"
  },
  GuideNote_Rules_Title3 = {
    ID = "GuideNote_Rules_Title3",
    CN = "LanguageConfig_GuideNote_Rules_Title3_CN|强化密仪"
  },
  GuideNote_Rules_Title4 = {
    ID = "GuideNote_Rules_Title4",
    CN = "LanguageConfig_GuideNote_Rules_Title4_CN|禁忌试炼"
  },
  GuideNote_Rules_Title5 = {
    ID = "GuideNote_Rules_Title5",
    CN = "LanguageConfig_GuideNote_Rules_Title5_CN|银辉之路"
  },
  GuideNote_Rules_Title6 = {
    ID = "GuideNote_Rules_Title6",
    CN = "LanguageConfig_GuideNote_Rules_Title6_CN|资源勘探"
  },
  GuideNote_Rules_Description1 = {
    ID = "GuideNote_Rules_Description1"
  },
  GuideNote_Rules_Description2 = {
    ID = "GuideNote_Rules_Description2"
  },
  GuideNote_Rules_Description3 = {
    ID = "GuideNote_Rules_Description3",
    CN = "LanguageConfig_GuideNote_Rules_Description3_CN|<Title:强化密仪>\n·选择一名唤醒体，可以查看其所需的材料以及推荐佩戴的密契，其所需材料根据当前已有材料和当前可到达的极限所计算。"
  },
  GuideNote_Rules_Description4 = {
    ID = "GuideNote_Rules_Description4"
  },
  GuideNote_Rules_Description5 = {
    ID = "GuideNote_Rules_Description5"
  },
  GuideNote_Rules_Description6 = {
    ID = "GuideNote_Rules_Description6"
  },
  LoginPvModifyTipTitle = {
    ID = "LoginPvModifyTipTitle",
    CN = "LanguageConfig_LoginPvModifyTipTitle_CN|说明"
  },
  LoginPvModifyTipDesc = {
    ID = "LoginPvModifyTipDesc",
    CN = "LanguageConfig_LoginPvModifyTipDesc_CN|被选定的动画会在后续每次登录时播放，但调查进度到达新阶段时依旧优先播放一次新的动画，清除游戏数据或重新安装游戏会清除被选定的动画。"
  },
  LoginPV1_Name = {
    ID = "LoginPV1_Name",
    CN = "LanguageConfig_LoginPV1_Name_CN|忘却前夜"
  },
  LoginPV2_Name = {
    ID = "LoginPV2_Name",
    CN = "LanguageConfig_LoginPV2_Name_CN|愿银钥指引前路"
  },
  LoginPV3_Name = {
    ID = "LoginPV3_Name",
    CN = "LanguageConfig_LoginPV3_Name_CN|来自遗忘  <▼>"
  },
  LoginPV4_Name = {
    ID = "LoginPV4_Name",
    CN = "LanguageConfig_LoginPV4_Name_CN|星辰正位之刻"
  },
  Login_SetLoginBackground = {
    ID = "Login_SetLoginBackground",
    CN = "LanguageConfig_Login_SetLoginBackground_CN|设为登录背景"
  },
  Login_ResetLoginBackground = {
    ID = "Login_ResetLoginBackground",
    CN = "LanguageConfig_Login_ResetLoginBackground_CN|重置登录背景"
  },
  ShortDaysDisplay = {
    ID = "ShortDaysDisplay",
    CN = "LanguageConfig_ShortDaysDisplay_CN|{s1}天"
  },
  ShortHourDisplay = {
    ID = "ShortHourDisplay",
    CN = "LanguageConfig_ShortHourDisplay_CN|{s1}时"
  },
  DateFormat = {
    ID = "DateFormat",
    CN = "LanguageConfig_DateFormat_CN|: {s1}~{s2}"
  },
  BlackPoolBackTrack = {
    ID = "BlackPoolBackTrack",
    CN = "LanguageConfig_BlackPoolBackTrack_CN|黑池归还"
  },
  RemainValidTime = {
    ID = "RemainValidTime",
    CN = "LanguageConfig_RemainValidTime_CN|剩余有效时间:"
  },
  BackTrack = {
    ID = "BackTrack",
    CN = "LanguageConfig_BackTrack_CN|回溯"
  },
  ReachLimitForCompose = {
    ID = "ReachLimitForCompose",
    CN = "LanguageConfig_ReachLimitForCompose_CN|已达上限，无法合成"
  },
  AwakerOverflowCraftLimitTips = {
    ID = "AwakerOverflowCraftLimitTips",
    CN = "LanguageConfig_AwakerOverflowCraftLimitTips_CN|次数来源于历史唤醒体溢出记录。该次数为固定值，使用后不可恢复。"
  },
  WeaponDecompositionCraftLimitTips = {
    ID = "WeaponDecompositionCraftLimitTips",
    CN = "LanguageConfig_WeaponDecompositionCraftLimitTips_CN|次数来源于历史命轮分解记录。该次数为固定值，使用后不可恢复。"
  },
  CompositeRemainTips = {
    ID = "CompositeRemainTips",
    CN = "LanguageConfig_CompositeRemainTips_CN|剩余可合成次数：<color=#ffffff>{s1}</color>"
  },
  BattleTeachingEntryBtnTxt = {
    ID = "BattleTeachingEntryBtnTxt",
    CN = "LanguageConfig_BattleTeachingEntryBtnTxt_CN|开始训练"
  },
  BattleTeachingRuleDesc = {
    ID = "BattleTeachingRuleDesc",
    CN = "LanguageConfig_BattleTeachingRuleDesc_CN|1、守密人可以在对应关卡中学习并练习相关的战斗内容。\n2、守密人通关对应实战教学关卡时，可以在「实战教学」中领取奖励。"
  },
  BattleTeachingLabel = {
    ID = "BattleTeachingLabel",
    CN = "LanguageConfig_BattleTeachingLabel_CN|实战教学"
  },
  TripleSummonReward = {
    ID = "TripleSummonReward",
    CN = "LanguageConfig_TripleSummonReward_CN|唤醒1次 · 获得3份奖励"
  },
  SummonTripleLabel = {
    ID = "SummonTripleLabel",
    CN = "LanguageConfig_SummonTripleLabel_CN|x3"
  },
  statistic_state_concept_counterattack = {
    ID = "statistic_state_concept_counterattack",
    CN = "LanguageConfig_statistic_state_concept_counterattack_CN|反击"
  },
  statistic_state_concept_poison = {
    ID = "statistic_state_concept_poison",
    CN = "LanguageConfig_statistic_state_concept_poison_CN|中毒"
  },
  statistic_state_concept_bleed = {
    ID = "statistic_state_concept_bleed",
    CN = "LanguageConfig_statistic_state_concept_bleed_CN|出血"
  },
  statistic_state_concept_sacrifice = {
    ID = "statistic_state_concept_sacrifice",
    CN = "LanguageConfig_statistic_state_concept_sacrifice_CN|献祭"
  },
  statistic_state_concept_corrosion = {
    ID = "statistic_state_concept_corrosion",
    CN = "LanguageConfig_statistic_state_concept_corrosion_CN|侵蚀"
  },
  statistic_state_concept_FinalVerdict = {
    ID = "statistic_state_concept_FinalVerdict",
    CN = "LanguageConfig_statistic_state_concept_FinalVerdict_CN|命运裁断"
  },
  statistic_battle_filter_all = {
    ID = "statistic_battle_filter_all",
    CN = "LanguageConfig_statistic_battle_filter_all_CN|所有战斗"
  },
  statistic_battle_filter_common = {
    ID = "statistic_battle_filter_common",
    CN = "LanguageConfig_statistic_battle_filter_common_CN|普通战斗"
  },
  statistic_battle_filter_elite = {
    ID = "statistic_battle_filter_elite",
    CN = "LanguageConfig_statistic_battle_filter_elite_CN|精英战斗"
  },
  statistic_battle_filter_boss = {
    ID = "statistic_battle_filter_boss",
    CN = "LanguageConfig_statistic_battle_filter_boss_CN|首领战斗"
  },
  statistic_type_filter_damage = {
    ID = "statistic_type_filter_damage",
    CN = "LanguageConfig_statistic_type_filter_damage_CN|伤害"
  },
  statistic_type_filter_block = {
    ID = "statistic_type_filter_block",
    CN = "LanguageConfig_statistic_type_filter_block_CN|护盾"
  },
  statistic_type_filter_heal = {
    ID = "statistic_type_filter_heal",
    CN = "LanguageConfig_statistic_type_filter_heal_CN|治疗"
  },
  statistic_bout_filter_all = {
    ID = "statistic_bout_filter_all",
    CN = "LanguageConfig_statistic_bout_filter_all_CN|所有回合"
  },
  statistic_bout_filter_turn = {
    ID = "statistic_bout_filter_turn",
    CN = "LanguageConfig_statistic_bout_filter_turn_CN|第{s1}回合"
  },
  StatusApplier1 = {
    ID = "StatusApplier1",
    CN = "LanguageConfig_StatusApplier1_CN|敌方<color=#bb646d> {s1} </color>"
  },
  StatusApplier2 = {
    ID = "StatusApplier2",
    CN = "LanguageConfig_StatusApplier2_CN|友方<color=#76aac8> {s1} </color>"
  },
  StatusApplier3 = {
    ID = "StatusApplier3",
    CN = "LanguageConfig_StatusApplier3_CN|<color=#bb646d> {s1} </color>"
  },
  StatusApplier4 = {
    ID = "StatusApplier4",
    CN = "LanguageConfig_StatusApplier4_CN|<color=#76aac8> {s1} </color>"
  },
  StatusApplier5 = {
    ID = "StatusApplier5",
    CN = "LanguageConfig_StatusApplier5_CN|、"
  },
  GiveAwayItem = {
    ID = "GiveAwayItem",
    CN = "LanguageConfig_GiveAwayItem_CN|赠送"
  },
  TwoAndAHalfAnniversaryRAIDActiviityEndTime = {
    ID = "TwoAndAHalfAnniversaryRAIDActiviityEndTime",
    CN = "LanguageConfig_TwoAndAHalfAnniversaryRAIDActiviityEndTime_CN|抓捕总数达成 {s1} 天后结束"
  },
  LikeSourceCollectionHallComment = {
    ID = "LikeSourceCollectionHallComment",
    CN = "LanguageConfig_LikeSourceCollectionHallComment_CN|典藏馆收藏评论"
  },
  MonsterMeatReaction1 = {
    ID = "MonsterMeatReaction1",
    CN = "LanguageConfig_MonsterMeatReaction1_CN|不是……我的……错……"
  },
  MonsterMeatReaction2 = {
    ID = "MonsterMeatReaction2",
    CN = "LanguageConfig_MonsterMeatReaction2_CN|不ﾉ是ｲ...驫我8的ﾃ...P错ｬ..."
  },
  MonsterMeatReaction3 = {
    ID = "MonsterMeatReaction3",
    CN = "LanguageConfig_MonsterMeatReaction3_CN|只想……活下去……"
  },
  MonsterMeatReaction4 = {
    ID = "MonsterMeatReaction4",
    CN = "LanguageConfig_MonsterMeatReaction4_CN|只ﾗ想ｸ...ﾎ麤活ﾑ下w去ｦ..."
  },
  MonsterMeatTips1 = {
    ID = "MonsterMeatTips1",
    CN = "LanguageConfig_MonsterMeatTips1_CN|肉ﾑ块w似ｦ乎J能ﾒ认ｩ知ﾇ齉唤ｯ醒7体ﾘ卡L牌ﾝ,但Q过ｱ量ﾏ的r认ｮ知ﾌ会d侵ﾙ蚀3它ｪ的ﾔ龥意G识ｽ...ﾈ..."
  },
  MonsterMeatTips2 = {
    ID = "MonsterMeatTips2",
    CN = "LanguageConfig_MonsterMeatTips2_CN|肉块似乎能认知唤醒体卡牌，但过量的认知会侵蚀它的意识……"
  },
  MonsterMeat_Bubble1 = {
    ID = "MonsterMeat_Bubble1",
    CN = "LanguageConfig_MonsterMeat_Bubble1_CN|可ﾐ以4Pｾ......喰qｪ齉ﾙ掉Kt......nの東鬱ｿ7西ｪ"
  },
  MonsterMeat_Bubble2 = {
    ID = "MonsterMeat_Bubble2",
    CN = "LanguageConfig_MonsterMeat_Bubble2_CN|可以……吃掉……的东西"
  },
  MonsterMeat_Name = {
    ID = "MonsterMeat_Name",
    CN = "LanguageConfig_MonsterMeat_Name_CN|古怪肉块"
  },
  GiftDiamondDeductTip = {
    ID = "GiftDiamondDeductTip",
    CN = "LanguageConfig_GiftDiamondDeductTip_CN|<size=30><color=#ACBFCA>消耗「源液」时，优先扣除赠送的「源液」。\n（提取：{s1}，赠送：{s2}）</color></size>"
  },
  PositiveStatusColor = {
    ID = "PositiveStatusColor",
    CN = "LanguageConfig_PositiveStatusColor_CN|#93D1A0"
  },
  NegativeStatusColor = {
    ID = "NegativeStatusColor",
    CN = "LanguageConfig_NegativeStatusColor_CN|#BB646D"
  },
  OtherStatusColor = {
    ID = "OtherStatusColor",
    CN = "LanguageConfig_OtherStatusColor_CN|#FFFFFF"
  },
  LargeSubplotResonanceRules = {
    ID = "LargeSubplotResonanceRules",
    CN = "LanguageConfig_LargeSubplotResonanceRules_CN|1、「特遣纪录」的部分调查事件有专属共鸣，可以使用共鸣升级材料激活共鸣效果，共鸣将在调查时提供强力的协助。\n2、在唤醒体限时活动期间，完成指定任务可以获得共鸣升级材料。活动结束后，可通过消耗「蔷薇金券」× 5000 额外兑换 1 个共鸣升级材料。\n3、地图内会出现共鸣节点，移动至共鸣节点上将在本次探索获得共鸣效果。"
  },
  ActivityFull = {
    ID = "ActivityFull",
    CN = "LanguageConfig_ActivityFull_CN|活性离子已满"
  },
  FinalBoss_Name = {
    ID = "FinalBoss_Name",
    CN = "LanguageConfig_FinalBoss_Name_CN|「塔薇：万象门扉」"
  },
  FinalBoss_Tips1 = {
    ID = "FinalBoss_Tips1",
    CN = "LanguageConfig_FinalBoss_Tips1_CN|全知的神明亦有不可抵御之物。使用钥令会导致让祂的意图切换，调整策略可以更有效的攻克！"
  },
  FinalBoss_Tips2 = {
    ID = "FinalBoss_Tips2",
    CN = "LanguageConfig_FinalBoss_Tips2_CN|大量打出指令卡会使祂加速行动，提前做好防备！"
  },
  FinalBoss_Tips3 = {
    ID = "FinalBoss_Tips3",
    CN = "LanguageConfig_FinalBoss_Tips3_CN|祂的能力得到强化，切换不同的意图时会额外造成效果，请小心应对！"
  },
  FinalBoss_Bubble1 = {
    ID = "FinalBoss_Bubble1",
    CN = "LanguageConfig_FinalBoss_Bubble1_CN|如此……僭越……"
  },
  FinalBoss_Bubble2 = {
    ID = "FinalBoss_Bubble2",
    CN = "LanguageConfig_FinalBoss_Bubble2_CN|不必……挣扎……"
  },
  FinalBoss_Bubble3 = {
    ID = "FinalBoss_Bubble3",
    CN = "LanguageConfig_FinalBoss_Bubble3_CN|银色六翼，予汝护佑。"
  },
  FinalBoss_Bubble4 = {
    ID = "FinalBoss_Bubble4",
    CN = "LanguageConfig_FinalBoss_Bubble4_CN|双翼初张……银匙于此倾转。"
  },
  FinalBoss_Bubble5 = {
    ID = "FinalBoss_Bubble5",
    CN = "LanguageConfig_FinalBoss_Bubble5_CN|四翼渐生……光羽于此辉耀。"
  },
  FinalBoss_Bubble6 = {
    ID = "FinalBoss_Bubble6",
    CN = "LanguageConfig_FinalBoss_Bubble6_CN|六翼满开……终焉于此降诞！"
  },
  RankDataFirstLoadTip = {
    ID = "RankDataFirstLoadTip",
    CN = "LanguageConfig_RankDataFirstLoadTip_CN|数据请求中"
  },
  RankDataNull = {
    ID = "RankDataNull",
    CN = "LanguageConfig_RankDataNull_CN|暂无记录"
  },
  CommentDataNull = {
    ID = "CommentDataNull",
    CN = "LanguageConfig_CommentDataNull_CN|暂无评论"
  },
  SelectOneWheelEquipment = {
    ID = "SelectOneWheelEquipment",
    CN = "LanguageConfig_SelectOneWheelEquipment_CN|选择 1 个命轮装备"
  },
  ActivityResonanceRules = {
    ID = "ActivityResonanceRules",
    CN = "LanguageConfig_ActivityResonanceRules_CN|1、本次限时活动有专属共鸣，可以使用共鸣升级材料激活共鸣效果，共鸣将在调查时提供强力的协助。\n2、在限时活动期间，完成指定任务可以获得共鸣升级材料。\n3、地图内会出现共鸣节点，移动至共鸣节点上将在本次探索获得共鸣效果。"
  },
  test_api_a1 = {
    ID = "test_api_a1",
    CN = "LanguageConfig_test_api_a1_CN|选择1组钥令依次释放"
  },
  test_api_a2 = {
    ID = "test_api_a2",
    CN = "LanguageConfig_test_api_a2_CN|第2轮 必选2名给标记"
  },
  test_api_a3 = {
    ID = "test_api_a3",
    CN = "LanguageConfig_test_api_a3_CN|第3轮 可选2名给标记"
  },
  test_api_a4 = {
    ID = "test_api_a4",
    CN = "LanguageConfig_test_api_a4_CN|第4轮 滤出有{状态@空状态}的\n必选4名给标记"
  },
  SelectedSpecNumAwakers = {
    ID = "SelectedSpecNumAwakers",
    CN = "LanguageConfig_SelectedSpecNumAwakers_CN|请选择{s1}个唤醒体"
  },
  Awaker_Select_Get_Tips2_UP = {
    ID = "Awaker_Select_Get_Tips2_UP",
    CN = "LanguageConfig_Awaker_Select_Get_Tips2_UP_CN|选择最多 2 个唤醒体"
  },
  NotOwned = {
    ID = "NotOwned",
    CN = "LanguageConfig_NotOwned_CN|未拥有"
  },
  OwnedCount = {
    ID = "OwnedCount",
    CN = "LanguageConfig_OwnedCount_CN|已拥有：{s1}"
  },
  WeaponSelectUseDetailTips = {
    ID = "WeaponSelectUseDetailTips",
    CN = "LanguageConfig_WeaponSelectUseDetailTips_CN|长按命轮查看详情"
  },
  WeaponSelectPreviewDetailTips = {
    ID = "WeaponSelectPreviewDetailTips",
    CN = "LanguageConfig_WeaponSelectPreviewDetailTips_CN|点击命轮查看详情"
  },
  AwakerSelectUseDetailTips = {
    ID = "AwakerSelectUseDetailTips",
    CN = "LanguageConfig_AwakerSelectUseDetailTips_CN|长按唤醒体查看详情"
  },
  AwakerSelectPreviewDetailTips = {
    ID = "AwakerSelectPreviewDetailTips",
    CN = "LanguageConfig_AwakerSelectPreviewDetailTips_CN|点击唤醒体查看详情"
  },
  chaotype2_teamskill_name = {
    ID = "chaotype2_teamskill_name",
    CN = "LanguageConfig_chaotype2_teamskill_name_CN|双重·{s1}"
  },
  chaotype2_teamskill_desc = {
    ID = "chaotype2_teamskill_desc",
    CN = "LanguageConfig_chaotype2_teamskill_desc_CN|{s1}额外重复 1 次。"
  },
  chaotype2_pack_select_title = {
    ID = "chaotype2_pack_select_title",
    CN = "LanguageConfig_chaotype2_pack_select_title_CN|选择一组钥令依次释放"
  },
  Card_Select_Get_Tips_Caroboo = {
    ID = "Card_Select_Get_Tips_Caroboo",
    CN = "LanguageConfig_Card_Select_Get_Tips_Caroboo_CN|金币还是巧克力？考验你的眼力的时候到了~"
  },
  ResurrectionCoinPurchaseTips = {
    ID = "ResurrectionCoinPurchaseTips",
    CN = "LanguageConfig_ResurrectionCoinPurchaseTips_CN|（兑换后将直接消耗并且复活，若撤退则会返还应急灵知体。应急灵知体每周限购3次，当前剩余次数：{s1}/3）"
  },
  Blessing_Select = {
    ID = "Blessing_Select",
    CN = "LanguageConfig_Blessing_Select_CN|仙女赐福，童叟无欺，敬请挑选"
  },
  Monster_Pollux_bubble_01 = {
    ID = "Monster_Pollux_bubble_01",
    CN = "LanguageConfig_Monster_Pollux_bubble_01_CN|直面你的罪孽，承受提灯的审判。"
  },
  Monster_Pollux_bubble_02 = {
    ID = "Monster_Pollux_bubble_02",
    CN = "LanguageConfig_Monster_Pollux_bubble_02_CN|满身罪孽之人，向持灯者忏悔吧！"
  },
  Monster_Pollux_bubble_tips_01 = {
    ID = "Monster_Pollux_bubble_tips_01",
    CN = "LanguageConfig_Monster_Pollux_bubble_tips_01_CN|「圣子·白夜」即将释放「圣心」！打出指令卡会使他愈发狂热，谨慎行动！"
  },
  Monster_Pollux_bubble_tips_02 = {
    ID = "Monster_Pollux_bubble_tips_02",
    CN = "LanguageConfig_Monster_Pollux_bubble_tips_02_CN|「圣子·白夜」将承担每次行动产生的「罪印」，且「代罪」的清除效果减半。"
  },
  Monster_Pollux_bubble_tips_03 = {
    ID = "Monster_Pollux_bubble_tips_03",
    CN = "LanguageConfig_Monster_Pollux_bubble_tips_03_CN|苦痛正在等待宣泄……「圣心」或许能成为它的出口。"
  },
  DailyChallengeLimitedDoubleShortTip = {
    ID = "DailyChallengeLimitedDoubleShortTip",
    CN = "LanguageConfig_DailyChallengeLimitedDoubleShortTip_CN|限时双倍"
  },
  DailyChallengeLimitedDoubleTip = {
    ID = "DailyChallengeLimitedDoubleTip",
    CN = "LanguageConfig_DailyChallengeLimitedDoubleTip_CN|限时双倍经验"
  },
  DailyChallengeLimitedDoubleLessTip = {
    ID = "DailyChallengeLimitedDoubleLessTip",
    CN = "LanguageConfig_DailyChallengeLimitedDoubleLessTip_CN|双倍"
  },
  Monster_B05EX_bubble_01 = {
    ID = "Monster_B05EX_bubble_01",
    CN = "LanguageConfig_Monster_B05EX_bubble_01_CN|挣扎吧。血链只会越缚越紧。"
  },
  Monster_B05EX_bubble_02 = {
    ID = "Monster_B05EX_bubble_02",
    CN = "LanguageConfig_Monster_B05EX_bubble_02_CN|逃不掉的。到此为止吧！"
  },
  Monster_B05EX_bubble_03 = {
    ID = "Monster_B05EX_bubble_03",
    CN = "LanguageConfig_Monster_B05EX_bubble_03_CN|这份仇怨……就用你们的血来偿还！"
  },
  Monster_B05EX_tips_01 = {
    ID = "Monster_B05EX_tips_01",
    CN = "LanguageConfig_Monster_B05EX_tips_01_CN|每次打出指令卡都会使敌人获得「狂热」，谨慎出牌！"
  },
  Monster_B05EX_tips_02 = {
    ID = "Monster_B05EX_tips_02",
    CN = "LanguageConfig_Monster_B05EX_tips_02_CN|本回合护盾能力失效。想尽办法生存吧！"
  },
  Monster_B05EX_tips_03 = {
    ID = "Monster_B05EX_tips_03",
    CN = "LanguageConfig_Monster_B05EX_tips_03_CN|「嗜血链球」状态下「索魂者」免疫一切伤害和生命损失，注意应对！"
  },
  TrinketAutoRefineProgress = {
    ID = "TrinketAutoRefineProgress",
    CN = "LanguageConfig_TrinketAutoRefineProgress_CN|自动转录中，当前第{s1}次"
  },
  TrinketAutoRefineStopByMaterialNotEnough = {
    ID = "TrinketAutoRefineStopByMaterialNotEnough",
    CN = "LanguageConfig_TrinketAutoRefineStopByMaterialNotEnough_CN|已转录 {s1} 次，本次自动转录结束。"
  },
  TrinketAutoRefineStopByMaxTimeLimit = {
    ID = "TrinketAutoRefineStopByMaxTimeLimit",
    CN = "LanguageConfig_TrinketAutoRefineStopByMaxTimeLimit_CN|已完成 100 次转录，自动转录结束。"
  },
  TrinketAutoRefineStopByGetTargetAttr = {
    ID = "TrinketAutoRefineStopByGetTargetAttr",
    CN = "LanguageConfig_TrinketAutoRefineStopByGetTargetAttr_CN|密契自动转录目标达成！\n<size=40>已完成 {s1} 次转录</size>"
  },
  TrinketAutoRefineAttrResult = {
    ID = "TrinketAutoRefineAttrResult"
  },
  AwakerFavorBreakThrough = {
    ID = "AwakerFavorBreakThrough",
    CN = "LanguageConfig_AwakerFavorBreakThrough_CN|灵肉同调"
  },
  AwakerFavorBreakThroughPopTip = {
    ID = "AwakerFavorBreakThroughPopTip",
    CN = "LanguageConfig_AwakerFavorBreakThroughPopTip_CN|确定使用「同心之证」× 1 进行灵肉同调吗？"
  },
  AwakerFavorBreakThroughSuccessTip = {
    ID = "AwakerFavorBreakThroughSuccessTip",
    CN = "LanguageConfig_AwakerFavorBreakThroughSuccessTip_CN|灵肉同调"
  },
  AwakerFavorBreakThroughSuccessSubTip = {
    ID = "AwakerFavorBreakThroughSuccessSubTip",
    CN = "LanguageConfig_AwakerFavorBreakThroughSuccessSubTip_CN|<color=#808080>Lv.{s1}/{s2}</color>"
  },
  SummonType_17SelectTips = {
    ID = "SummonType_17SelectTips",
    CN = "LanguageConfig_SummonType_17SelectTips_CN|选择 {s1} 名「星辰篇」限定唤醒体"
  },
  SummonType_17SummonDesc1 = {
    ID = "SummonType_17SummonDesc1",
    CN = "LanguageConfig_SummonType_17SummonDesc1_CN|<SummonOrange:自选>唤醒SSR列表！"
  },
  SummonType_17SummonDesc2 = {
    ID = "SummonType_17SummonDesc2",
    CN = "LanguageConfig_SummonType_17SummonDesc2_CN|选定后本期不可再更改"
  },
  SummonType_17SelectPanelDesc = {
    ID = "SummonType_17SelectPanelDesc",
    CN = "LanguageConfig_SummonType_17SelectPanelDesc_CN|1、百相自选唤醒：守密人可从本期百相自选唤醒活动可选的唤醒体列表中选择 5 个唤醒体，被选中的唤醒体及其推荐命轮将作为本次唤醒活动的SSR列表\n2、每次通过唤醒获取到SSR时，有100%的概率为本期选定的唤醒体或推荐命轮之一。 \n3、UP目标一旦选定后，本期无法再更改定向唤醒对象。"
  },
  SummonType_17SelectType_1 = {
    ID = "SummonType_17SelectType_1",
    CN = "LanguageConfig_SummonType_17SelectType_1_CN|伤害型"
  },
  SummonType_17SelectType_2 = {
    ID = "SummonType_17SelectType_2",
    CN = "LanguageConfig_SummonType_17SelectType_2_CN|防御型"
  },
  SummonType_17SelectType_3 = {
    ID = "SummonType_17SelectType_3",
    CN = "LanguageConfig_SummonType_17SelectType_3_CN|辅助型"
  },
  SummonType_17SelectType_4 = {
    ID = "SummonType_17SelectType_4",
    CN = "LanguageConfig_SummonType_17SelectType_4_CN|男性"
  },
  SummonType_17SelectType_5 = {
    ID = "SummonType_17SelectType_5",
    CN = "LanguageConfig_SummonType_17SelectType_5_CN|女性"
  },
  SummonType_17SelectTitle = {
    ID = "SummonType_17SelectTitle",
    CN = "LanguageConfig_SummonType_17SelectTitle_CN|选择 1 名{s1}唤醒体"
  },
  SummonType_17SelectionProgress = {
    ID = "SummonType_17SelectionProgress",
    CN = "LanguageConfig_SummonType_17SelectionProgress_CN|已选 {s1}/{s2}"
  },
  SummonType_17SelectedTips = {
    ID = "SummonType_17SelectedTips",
    CN = "LanguageConfig_SummonType_17SelectedTips_CN|{s1}已选中"
  },
  SummonType_17SelectedDesc = {
    ID = "SummonType_17SelectedDesc",
    CN = "LanguageConfig_SummonType_17SelectedDesc_CN|已指定唤醒体和推荐命轮"
  },
  SummonType_17FinishSelect = {
    ID = "SummonType_17FinishSelect",
    CN = "LanguageConfig_SummonType_17FinishSelect_CN|完成选择"
  },
  AbyssChallengeRevivalCostTips = {
    ID = "AbyssChallengeRevivalCostTips",
    CN = "LanguageConfig_AbyssChallengeRevivalCostTips_CN|应急灵知体不足 3 个，是否花费"
  },
  FrozenResentment = {
    ID = "FrozenResentment",
    CN = "LanguageConfig_FrozenResentment_CN|别看，别听，别步入@1……"
  },
  ReducedDeathResistance = {
    ID = "ReducedDeathResistance",
    CN = "LanguageConfig_ReducedDeathResistance_CN|死亡抵抗降低！"
  },
  Monster_B11AF_bubble_01 = {
    ID = "Monster_B11AF_bubble_01",
    CN = "LanguageConfig_Monster_B11AF_bubble_01_CN|仙女驾到！还不献上供奉吗？"
  },
  Monster_B11AF_bubble_02 = {
    ID = "Monster_B11AF_bubble_02",
    CN = "LanguageConfig_Monster_B11AF_bubble_02_CN|哼哼，这就是仙女的赐福！相信我，它一定会应验的！"
  },
  Monster_B11AF_bubble_03 = {
    ID = "Monster_B11AF_bubble_03",
    CN = "LanguageConfig_Monster_B11AF_bubble_03_CN|小气鬼，画个圈圈诅咒你！"
  },
  Monster_B11AF_bubble_04 = {
    ID = "Monster_B11AF_bubble_04",
    CN = "LanguageConfig_Monster_B11AF_bubble_04_CN|来吧，吞下这甜蜜的赐福吧！"
  },
  Monster_B11AF_bubble_05 = {
    ID = "Monster_B11AF_bubble_05",
    CN = "LanguageConfig_Monster_B11AF_bubble_05_CN|满满当当的供奉！喜欢！"
  },
  Monster_B11AF_bubble_06 = {
    ID = "Monster_B11AF_bubble_06",
    CN = "LanguageConfig_Monster_B11AF_bubble_06_CN|哈啊？什么叫一无所获？！"
  },
  Monster_B11AF_bubble_07 = {
    ID = "Monster_B11AF_bubble_07",
    CN = "LanguageConfig_Monster_B11AF_bubble_07_CN|一半供奉也不错了～再接再厉～"
  },
  Monster_B11AF_tips_01 = {
    ID = "Monster_B11AF_tips_01",
    CN = "LanguageConfig_Monster_B11AF_tips_01_CN|「白雪仙女」正在收取供奉，上供者可接受赐福，不上供者将招致惩罚。"
  },
  Monster_B11AF_tips_02 = {
    ID = "Monster_B11AF_tips_02",
    CN = "LanguageConfig_Monster_B11AF_tips_02_CN|注意！「白雪仙女」将索要更多供奉。"
  },
  TrinketBind = {
    ID = "TrinketBind",
    CN = "LanguageConfig_TrinketBind_CN|结合"
  },
  TrinketUnbind = {
    ID = "TrinketUnbind",
    CN = "LanguageConfig_TrinketUnbind_CN|析离"
  },
  TrinketChangeBind = {
    ID = "TrinketChangeBind",
    CN = "LanguageConfig_TrinketChangeBind_CN|结合"
  },
  TrinketBindSuccessTips = {
    ID = "TrinketBindSuccessTips",
    CN = "LanguageConfig_TrinketBindSuccessTips_CN|密契结合成功"
  },
  TrinketBindNoneSelectedTips = {
    ID = "TrinketBindNoneSelectedTips",
    CN = "LanguageConfig_TrinketBindNoneSelectedTips_CN|没有可以结合的密契，请至少选择一个。"
  },
  TrinketUnbindMaterialTitle = {
    ID = "TrinketUnbindMaterialTitle",
    CN = "LanguageConfig_TrinketUnbindMaterialTitle_CN|析离素材选择"
  },
  TrinketBatchUnbindTitle = {
    ID = "TrinketBatchUnbindTitle",
    CN = "LanguageConfig_TrinketBatchUnbindTitle_CN|一键析离"
  },
  TrinketMaterialNotEnough = {
    ID = "TrinketMaterialNotEnough",
    CN = "LanguageConfig_TrinketMaterialNotEnough_CN|数量不足"
  },
  TrinketAutoSelectTips = {
    ID = "TrinketAutoSelectTips",
    CN = "LanguageConfig_TrinketAutoSelectTips_CN|自动选择：优先选用品质较低、等级较低的密契作为素材"
  },
  TrinketLockedCannotSelectTips = {
    ID = "TrinketLockedCannotSelectTips",
    CN = "LanguageConfig_TrinketLockedCannotSelectTips_CN|密契已上锁，无法选中"
  },
  TrinketBindRuleDesc = {
    ID = "TrinketBindRuleDesc",
    CN = "LanguageConfig_TrinketBindRuleDesc_CN|<Title:密契结合>\n·守密人现在可以为唤醒体结合密契。\n·唤醒体每个位置可结合 1 个密契，总共 6 个。\n·结合后，每个位置上的密契主属性额外提升 50%。\n·已结合的密契不会在「物资-密契」与「冶炼室」中出现。\n·编队与唤醒体助战中，如果没有为唤醒体装配密契，已结合的密契将被自动装配。\n·强化已结合的密契部件不改变结合状态，主属性提升会根据强化后的状态更新。\n\n<Title:密契析离>\n·修改或取消密契结合，需要在密契结合页面中析离已结合的密契。\n·单个部件析离需要消耗 10 个同类型密契（不限位置）。\n·析离密契时，已使用的密契不会出现在素材选项中。"
  },
  TrinketBindBonusDesc = {
    ID = "TrinketBindBonusDesc",
    CN = "LanguageConfig_TrinketBindBonusDesc_CN|结合后，密契主属性额外提升{s1}！"
  },
  TrinketBatchUnbindComingSoon = {
    ID = "TrinketBatchUnbindComingSoon",
    CN = "LanguageConfig_TrinketBatchUnbindComingSoon_CN|一键析离功能即将开放"
  },
  TrinketUnBindSuccessTips = {
    ID = "TrinketUnBindSuccessTips",
    CN = "LanguageConfig_TrinketUnBindSuccessTips_CN|密契析离成功"
  },
  TrinketChangeBindSuccessTips = {
    ID = "TrinketChangeBindSuccessTips",
    CN = "LanguageConfig_TrinketChangeBindSuccessTips_CN|密契结合修改成功"
  },
  FavorSettleShowSourceTabTotal = {
    ID = "FavorSettleShowSourceTabTotal",
    CN = "LanguageConfig_FavorSettleShowSourceTabTotal_CN|总额"
  },
  FavorSettleShowSourceTabCard = {
    ID = "FavorSettleShowSourceTabCard",
    CN = "LanguageConfig_FavorSettleShowSourceTabCard_CN|出牌"
  },
  FavorSettleShowSourceTabCost = {
    ID = "FavorSettleShowSourceTabCost",
    CN = "LanguageConfig_FavorSettleShowSourceTabCost_CN|算力"
  },
  FavorSettleShowSourceTabUlti = {
    ID = "FavorSettleShowSourceTabUlti",
    CN = "LanguageConfig_FavorSettleShowSourceTabUlti_CN|狂气"
  },
  FavorSettleShowSourceTabKeeper = {
    ID = "FavorSettleShowSourceTabKeeper",
    CN = "LanguageConfig_FavorSettleShowSourceTabKeeper_CN|银钥能量"
  },
  FavorSettleShowSourceTabManual = {
    ID = "FavorSettleShowSourceTabManual",
    CN = "LanguageConfig_FavorSettleShowSourceTabManual_CN|手动战斗"
  },
  FavorSettleShowSourceTabActivity = {
    ID = "FavorSettleShowSourceTabActivity",
    CN = "LanguageConfig_FavorSettleShowSourceTabActivity_CN|活动加成"
  },
  FavorSettleShowSourceTabWeapon = {
    ID = "FavorSettleShowSourceTabWeapon",
    CN = "LanguageConfig_FavorSettleShowSourceTabWeapon_CN|命轮加成"
  },
  FavorSettleShowSourceTabAssist = {
    ID = "FavorSettleShowSourceTabAssist",
    CN = "LanguageConfig_FavorSettleShowSourceTabAssist_CN|助战加成"
  }
})
return LanguageConfig
