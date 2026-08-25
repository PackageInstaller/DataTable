local M = {
  Charge_PCExclusive = {
    ["是"] = 1,
    ["否"] = 0
  },
  PermResSummary_Key = {
    ["调查行动"] = 1,
    ["幕间演习"] = 2,
    ["相位对弈"] = 3,
    ["幻梦深潜"] = 4,
    ["疾驰的欢愉专列"] = 5
  },
  Summon_SummonTimeCond = {
    ["随任务开启倒计时"] = "unlockByTask"
  },
  MapTileMaterial_Trigger = {
    ["进入前触发"] = 1,
    ["进入后触发"] = 2,
    ["离开后触发"] = 3
  },
  MapNodeGroup_GroupType = {
    ["掉落包"] = "DropPack",
    ["直接配"] = "Direct"
  },
  MapNodeGroup_isStageLayer = {
    ["是"] = 1,
    ["否"] = 0
  },
  Drop_DropType = {
    ["道具"] = 0,
    ["掉落"] = 1,
    ["造物"] = 2,
    ["刻印"] = 3,
    ["贤石"] = 4,
    ["卡牌"] = 5,
    ["节点组"] = 6
  },
  Drop_FilterType = {
    ["拥有唤醒体"] = "HadAwaker",
    ["未拥有唤醒体"] = "NoAwaker",
    ["拥有道具"] = "HadItem",
    ["拥有造物"] = "HadRelic",
    ["未拥有造物"] = "NoRelic",
    ["不是定向卡池的道具"] = "NoSelection",
    ["不是定向卡池的界域"] = "NoSelectionSchool",
    ["不是自选限定列表卡池的唤醒体道具"] = "NoMultiSelectionAwaker",
    ["不是自选限定列表卡池的道具"] = "NoMultiSelection"
  },
  Item_SubType = {
    ["货币"] = "TopBarItem",
    ["命轮"] = "Weapon",
    ["密契"] = "Trinket",
    ["密契碎片"] = "TrinketChip",
    ["唤醒体"] = "Awaker",
    ["唤醒体好感度"] = "AwakerFavor",
    ["唤醒体碎片"] = "AwakerChip",
    ["唤醒体时装"] = "AwakerSkin",
    ["时装兑换券"] = "SkinVoucher",
    ["体力"] = "Stamina",
    ["宝箱"] = "Chest",
    ["自选材料礼包"] = "MultiSelectChest",
    ["角色残片宝箱"] = "AwakerChipChest",
    ["角色宝箱"] = "AwakerChest",
    ["命轮宝箱"] = "WeaponChest",
    ["角色宝箱碎片"] = "AwakerChestChip",
    ["命轮宝箱碎片"] = "WeaponChestChip",
    ["外观自选券"] = "CosmeticsChest",
    ["外观收藏券"] = "CosmeticsRandChest",
    ["头像框"] = "AvatarFrame",
    ["头像"] = "PlayerAvatar",
    ["对战表情"] = "Emoji",
    ["守密人性别头像表情"] = "GenderDifference",
    ["特殊材料"] = "SpecialMaterial",
    ["经验书"] = "ExpMaterial",
    ["技能材料"] = "SkillMaterial",
    ["饰品材料"] = "TrinketMaterial",
    ["周常材料"] = "WeeklyMaterial",
    ["转录锁定材料"] = "TrinketRefineLock",
    ["回溯道具"] = "Backtrack",
    ["通用直升道具"] = "FastPromotion",
    ["共鸣粒子"] = "ResonanceParticle",
    ["掉落包"] = "DropItem",
    ["密契掉落包"] = "TrinketDropItem",
    ["钥令"] = "KeeperSkill",
    ["剧情道具"] = "StoryItem",
    ["经验加成特权"] = "ExpBonus",
    SeasonS1SkillMaterial = "SeasonS1SkillMaterial",
    ["唤醒体随机宝箱"] = "AwakerRandomChest",
    ["命轮随机宝箱"] = "WeaponRandomChest",
    ["卡池直充消耗道具"] = "DirectChargeChest",
    ["活动展示掉落虚拟道具"] = "ActivityShowDropItem"
  },
  Resonance_IsDefaultTalentNode = {
    ["初始节点"] = 1,
    ["非初始节点"] = 0
  },
  Resonance_AddAttrsTarget = {
    ["玩家"] = 0,
    ["所有唤醒体"] = 1,
    ["伤害型唤醒体"] = 2,
    ["防御型唤醒体"] = 3,
    ["辅助型唤醒体"] = 4,
    ["混沌唤醒体"] = 5,
    ["深海唤醒体"] = 6,
    ["血肉唤醒体"] = 7,
    ["超维唤醒体"] = 8,
    ["男性唤醒体"] = 9,
    ["女性唤醒体"] = 10
  },
  Stage_MapType = {
    ["纯剧情关卡"] = 0,
    ["地图探索关卡"] = 1,
    ["节点列表线性关卡"] = 2,
    ["节点组线性关卡"] = 3
  },
  Stage_SkipPlot = {
    ["强制播放"] = 0,
    ["强制忽略"] = 1
  },
  AwakerPotency_EffectType = {
    ["属性提升"] = "Attr_Promote",
    ["超限狂气爆发"] = "UtlSkill_Promote",
    ["等级上限提升"] = "LevelLimit_Promote",
    ["添加状态"] = "BEAddState",
    ["敬请期待"] = "ComingSoon"
  },
  AwakerTalent_TalentType = {
    ["唤醒体天赋"] = 0,
    ["疯狂预兆"] = 1,
    ["灵塑适性"] = 2,
    ["内在灵格"] = 3
  },
  AwakerTalent_TalentType1 = {
    ["属性提升"] = "Attr_Promote",
    ["添加状态"] = "Add_State",
    ["天赋额外等级属性"] = "Talent_Attr_Lv"
  },
  AwakerStory_ConditionType = {
    ["唤醒体等级"] = "Awaker_Level",
    ["同调率等级"] = "AwakerFavorabilityLevel",
    ["首次通关关卡"] = "StageFirstClear"
  },
  Tutorial_Prompt = {
    ["弹"] = 1,
    ["不弹"] = 0
  },
  ItemConversion_ConversionType = {
    ["合成"] = "Compose",
    ["分解"] = "Decompose",
    ["重印"] = "Recast",
    ["置换"] = "Exchange"
  },
  Shop_PricingModel = {
    ["固定价格"] = 0,
    ["价格递增"] = 1,
    ["稀有度定价"] = 2,
    ["免费"] = 3
  },
  CareerLevel_Type = {
    ["深潜生涯等级"] = 1,
    ["预组模式生涯等级"] = 2,
    ["轮选模式生涯等级"] = 3,
    ["疾驰的欢愉专列生涯等级"] = 4
  },
  SeasonRankReward_Type = {
    ["幻梦深潜"] = "幻梦深潜",
    ["相位对弈预组模式"] = "预组模式",
    ["欢愉列车"] = "欢愉列车",
    ["相位对弈轮选模式"] = "轮选模式"
  },
  SeasonRotation_SeasonType = {
    ["幻梦深潜"] = "幻梦深潜",
    ["相位对弈预组模式"] = "预组模式",
    ["欢愉列车"] = "欢愉列车",
    ["相位对弈轮选模式"] = "轮选模式"
  },
  CollectionHall_CollectionCountType = {
    ["世界观"] = "WorldView",
    ["角色"] = "Role",
    ["主线CG"] = "StoryLineCG",
    ["场景CG"] = "ScenesCG",
    PV = "PromotionVideo",
    ["活动CG"] = "ActivityCG",
    ["广播剧"] = "RadioDrama",
    ["音乐"] = "Music",
    ["事件"] = "Event",
    ["造物"] = "Creation",
    ["命轮"] = "Weapon",
    ["密契"] = "Trinket"
  },
  PopupAd_PopupType = {
    ["活动弹窗"] = 1,
    ["唤醒体唤醒活动弹窗"] = 2,
    ["命轮唤醒活动弹窗"] = 3,
    ["商店弹窗"] = 4
  },
  State_Owner = {
    ["持有方"] = "StateOwner",
    ["来源方"] = "StateCaster"
  },
  State_StatisticOwner = {
    ["持有方"] = "StateOwner",
    ["来源方"] = "StateCaster",
    ["行动方"] = "CmdCaster"
  },
  State_Statistic = {
    ["不统计"] = "Disable",
    ["统计"] = "Enable"
  },
  BattleConfig_SkipPlot = {
    ["强制播放"] = 0,
    ["强制忽略"] = 1
  },
  State_Owner = {
    ["持有方"] = "StateOwner",
    ["来源方"] = "StateCaster",
    ["行动方"] = "CmdCaster"
  },
  State_Statistic = {
    ["不统计"] = "Disable",
    ["统计"] = "Enable"
  },
  State_StatisticOwner = {
    ["持有方"] = "StateOwner",
    ["来源方"] = "StateCaster",
    ["行动方"] = "CmdCaster"
  },
  SpireMap_Type = {
    ["随机替换空白"] = 1,
    ["按非空比例替换空白"] = 2,
    ["向上最近链接"] = 3,
    ["向下最近链接"] = 4,
    ["按比例随机替换"] = 5,
    ["按数量随机替换"] = 6
  },
  Drop_DropType = {
    ["道具"] = 0,
    ["掉落"] = 1,
    ["造物"] = 2,
    ["刻印"] = 3,
    ["贤石"] = 4,
    ["卡牌"] = 5,
    ["战斗"] = 6,
    ["节点"] = 7,
    ["事件"] = 8
  },
  Drop_FilterType = {
    ["拥有唤醒体"] = "HadAwaker",
    ["未拥有唤醒体"] = "NoAwaker",
    ["拥有道具"] = "HadItem",
    ["拥有造物"] = "HadRelic",
    ["未拥有造物"] = "NoRelic",
    ["不是定向卡池的道具"] = "NoSelection",
    ["不是定向卡池的界域"] = "NoSelectionSchool"
  }
}
return M
