local System = require("System.System")
local readonly = System.readonly
local MapNodeType = readonly({
  [18431] = {
    ID = 18431,
    CnID = "节点类型@战斗",
    BaseSortID = 1,
    TypeEffect = 1,
    Name = "MapNodeType_18431_Name|战斗",
    Desc = "MapNodeType_18431_Desc|一些不期而遇的敌人，会触发一场战斗。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_01a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18411] = {
    ID = 18411,
    CnID = "节点类型@高危战",
    BaseSortID = 2,
    TypeEffect = 2,
    Name = "MapNodeType_18411_Name|精英",
    Desc = "MapNodeType_18411_Desc|一些略有挑战的敌人，会触发一场稍难的战斗。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_02a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18396] = {
    ID = 18396,
    CnID = "节点类型@最终战",
    BaseSortID = 3,
    TypeEffect = 3,
    Name = "MapNodeType_18396_Name|最终战",
    Desc = "MapNodeType_18396_Desc|最终，亦是最强的敌人，击败后将结束这场调查。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_03a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18398] = {
    ID = 18398,
    CnID = "节点类型@序章联络点",
    BaseSortID = 4,
    TypeEffect = 4,
    Name = "MapNodeType_18398_Name|联络点",
    Desc = "MapNodeType_18398_Desc|触发以获得弥萨格大学的帮助，可以恢复生命。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_08a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18413] = {
    ID = 18413,
    CnID = "节点类型@联络点",
    BaseSortID = 5,
    TypeEffect = 4,
    Name = "MapNodeType_18413_Name|联络点",
    Desc = "MapNodeType_18413_Desc|触发以获得弥萨格大学的帮助，可以恢复生命，或选择觉醒一名唤醒体。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_08a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18423] = {
    ID = 18423,
    CnID = "节点类型@融痕",
    BaseSortID = 6,
    TypeEffect = 5,
    Name = "MapNodeType_18423_Name|融痕",
    Desc = "MapNodeType_18423_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2,
    Effect2 = "3;math.max(50-PlayerRole.GetStateLayer(3758),0);4;PlayerRole.GetStateLayer(3187)>0 and DrawDeck.GetCardByType({Card_Strike,Card_Defend,Card_Skill,Card_Curse},99,RANDOM) or DrawDeck.GetCardByType({Card_Strike,Card_Defend,Card_Skill},99,RANDOM);5;2+GetResonancePara(35106,1)+PlayerRole.GetStateLayer(44711)+PlayerRole.GetStateLayer(3701);math.max(5-PlayerRole.GetStateLayer(3578),0)"
  },
  [18394] = {
    ID = 18394,
    CnID = "节点类型@事件",
    BaseSortID = 7,
    TypeEffect = 6,
    Name = "MapNodeType_18394_Name|事件",
    Desc = "MapNodeType_18394_Desc|危险还是机遇，取决于你的抉择。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_14a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18428] = {
    ID = 18428,
    CnID = "节点类型@银芯",
    BaseSortID = 8,
    TypeEffect = 7,
    Name = "MapNodeType_18428_Name|银芯",
    Desc = "MapNodeType_18428_Desc|获取游离的银芯。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_17a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18400] = {
    ID = 18400,
    CnID = "节点类型@影池",
    BaseSortID = 9,
    TypeEffect = 8,
    Name = "MapNodeType_18400_Name|影池",
    Desc = "MapNodeType_18400_Desc|暗影的池水深不可测，充满未知，触发后可以获得随机奖励。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_05a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18404] = {
    ID = 18404,
    CnID = "节点类型@黑印",
    BaseSortID = 10,
    TypeEffect = 9,
    Name = "MapNodeType_18404_Name|黑印",
    Desc = "MapNodeType_18404_Desc|获得黑印——一种在幻梦空间中的通行货币。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_06a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18393] = {
    ID = 18393,
    CnID = "节点类型@虚无",
    BaseSortID = 11,
    TypeEffect = 10,
    Name = "MapNodeType_18393_Name|虚无",
    Desc = "MapNodeType_18393_Desc|精神的迷雾无形却坚硬，不允许任何物体穿透。",
    Block = 1,
    HideMov = 1,
    Trigger = 0
  },
  [18422] = {
    ID = 18422,
    CnID = "节点类型@门扉",
    BaseSortID = 12,
    TypeEffect = 11,
    Name = "MapNodeType_18422_Name|锈蚀门扉",
    Desc = "MapNodeType_18422_Desc|沉默矗立的坚固门扉。需要使用锈蚀钥匙开启。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_10a.png"
    },
    Block = 0,
    Trigger = 1
  },
  [18425] = {
    ID = 18425,
    CnID = "节点类型@机关",
    BaseSortID = 13,
    TypeEffect = 12,
    Name = "MapNodeType_18425_Name|锈蚀钥匙",
    Desc = "MapNodeType_18425_Desc|它耐心地寻找着属于它的那一扇门扉。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_11a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18427] = {
    ID = 18427,
    CnID = "节点类型@幻象",
    BaseSortID = 14,
    TypeEffect = 13,
    Name = "MapNodeType_18427_Name|幻象",
    Desc = "MapNodeType_18427_Desc|扭曲的幻象阻挡了你的前进，若选择破除，将会感染未知的症状。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_15a.png"
    },
    Block = 0,
    Trigger = 1
  },
  [18417] = {
    ID = 18417,
    CnID = "节点类型@隧道",
    BaseSortID = 15,
    TypeEffect = 14,
    Name = "MapNodeType_18417_Name|隧道",
    Desc = "MapNodeType_18417_Desc|漆黑的道路通向未知，进入后将传送至通道的另一端。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_09a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18402] = {
    ID = 18402,
    CnID = "节点类型@开始",
    BaseSortID = 16,
    TypeEffect = 15,
    Name = "MapNodeType_18402_Name|开始",
    Desc = "MapNodeType_18402_Desc|玩家开始位置，你不应当看到此节点，看到就是有BUG了！",
    Block = 0,
    Trigger = 0
  },
  [18395] = {
    ID = 18395,
    CnID = "节点类型@剧情",
    BaseSortID = 17,
    TypeEffect = 16,
    Name = "MapNodeType_18395_Name|剧情",
    Desc = "MapNodeType_18395_Desc|一场相遇，一次危机，抑或一段回忆。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_12a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18407] = {
    ID = 18407,
    CnID = "节点类型@造物",
    BaseSortID = 18,
    TypeEffect = 17,
    Name = "MapNodeType_18407_Name|造物",
    Desc = "MapNodeType_18407_Desc|获得造物。",
    Block = 0,
    Trigger = 2
  },
  [18430] = {
    ID = 18430,
    CnID = "节点类型@特殊商店",
    BaseSortID = 19,
    TypeEffect = 18,
    Name = "MapNodeType_18430_Name|特殊商店",
    Desc = "MapNodeType_18430_Desc|测试用特殊商店节点，能看到说明你不在正式关卡中",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18408] = {
    ID = 18408,
    CnID = "节点类型@单向门入口",
    BaseSortID = 20,
    TypeEffect = 19,
    Name = "MapNodeType_18408_Name|单行密道",
    Desc = "MapNodeType_18408_Desc|一条有去无回的不稳定通路，进入后将无法从出口折返。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_18a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18406] = {
    ID = 18406,
    CnID = "节点类型@单向门出口",
    BaseSortID = 21,
    TypeEffect = 19,
    Name = "MapNodeType_18406_Name|密道出口",
    Desc = "MapNodeType_18406_Desc|单行密道的出口，内部已经坍缩，无法从此处折返回密道入口。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_19a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18416] = {
    ID = 18416,
    CnID = "节点类型@造物融痕",
    BaseSortID = 22,
    TypeEffect = 20,
    Name = "MapNodeType_18416_Name|造物融痕",
    Desc = "MapNodeType_18416_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18414] = {
    ID = 18414,
    CnID = "节点类型@刻印融痕",
    BaseSortID = 23,
    TypeEffect = 21,
    Name = "MapNodeType_18414_Name|刻印融痕",
    Desc = "MapNodeType_18414_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18397] = {
    ID = 18397,
    CnID = "节点类型@定制造物融痕",
    BaseSortID = 24,
    TypeEffect = 22,
    Name = "MapNodeType_18397_Name|定制造物融痕",
    Desc = "MapNodeType_18397_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18412] = {
    ID = 18412,
    CnID = "节点类型@定制刻印融痕",
    BaseSortID = 25,
    TypeEffect = 23,
    Name = "MapNodeType_18412_Name|定制刻印融痕",
    Desc = "MapNodeType_18412_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18421] = {
    ID = 18421,
    CnID = "节点类型@驱雾结晶",
    BaseSortID = 26,
    TypeEffect = 24,
    Name = "MapNodeType_18421_Name|探照灯",
    Desc = "MapNodeType_18421_Desc|前人遗留下来的照明装置，可驱散四周的浓雾。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_20a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18409] = {
    ID = 18409,
    CnID = "节点类型@测试水晶球",
    BaseSortID = 27,
    TypeEffect = 25,
    Name = "MapNodeType_18409_Name|测试水晶球",
    Desc = "MapNodeType_18409_Desc|测试水晶球",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_14a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18420] = {
    ID = 18420,
    CnID = "节点类型@测试隐藏通道",
    BaseSortID = 28,
    TypeEffect = 26,
    Name = "MapNodeType_18420_Name|测试隐藏通道",
    Desc = "MapNodeType_18420_Desc|测试隐藏通道",
    Block = 0,
    HideMov = 1,
    Trigger = 1
  },
  [18424] = {
    ID = 18424,
    CnID = "节点类型@不牢固的地板",
    BaseSortID = 29,
    TypeEffect = 27,
    Name = "MapNodeType_18424_Name|不牢固的地板",
    Desc = "MapNodeType_18424_Desc|不牢固的地板",
    Block = 0,
    Trigger = 2
  },
  [18419] = {
    ID = 18419,
    CnID = "节点类型@定时塌陷地板",
    BaseSortID = 30,
    TypeEffect = 28,
    Name = "MapNodeType_18419_Name|定时塌陷地板",
    Desc = "MapNodeType_18419_Desc|测试定时塌陷地板",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_14a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18415] = {
    ID = 18415,
    CnID = "节点类型@隐藏奖励",
    BaseSortID = 31,
    TypeEffect = 29,
    Name = "MapNodeType_18415_Name|隐藏奖励",
    Desc = "MapNodeType_18415_Desc|隐藏奖励",
    Block = 0,
    Trigger = 2
  },
  [18429] = {
    ID = 18429,
    CnID = "节点类型@章一共鸣处",
    BaseSortID = 32,
    TypeEffect = 30,
    Name = "MapNodeType_18429_Name|善意的礼物",
    Desc = "MapNodeType_18429_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_21a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18405] = {
    ID = 18405,
    CnID = "节点类型@章二共鸣处",
    BaseSortID = 33,
    TypeEffect = 30,
    Name = "MapNodeType_18405_Name|未完的雕像",
    Desc = "MapNodeType_18405_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_22a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18392] = {
    ID = 18392,
    CnID = "节点类型@章三共鸣处",
    BaseSortID = 34,
    TypeEffect = 30,
    Name = "MapNodeType_18392_Name|古怪脓疱",
    Desc = "MapNodeType_18392_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_23a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18399] = {
    ID = 18399,
    CnID = "节点类型@章四共鸣处",
    BaseSortID = 35,
    TypeEffect = 30,
    Name = "MapNodeType_18399_Name|蜂蜜甜酒",
    Desc = "MapNodeType_18399_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_24a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18410] = {
    ID = 18410,
    CnID = "节点类型@章五共鸣处",
    BaseSortID = 36,
    TypeEffect = 30,
    Name = "MapNodeType_18410_Name|代行之仪",
    Desc = "MapNodeType_18410_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_41a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [35889] = {
    ID = 35889,
    CnID = "节点类型@章六共鸣处",
    BaseSortID = 37,
    TypeEffect = 30,
    Name = "MapNodeType_35889_Name|纯白之帆",
    Desc = "MapNodeType_35889_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_43a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [49100] = {
    ID = 49100,
    CnID = "节点类型@章七共鸣处",
    BaseSortID = 38,
    TypeEffect = 30,
    Name = "MapNodeType_49100_Name|孕育之母",
    Desc = "MapNodeType_49100_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_50a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [59662] = {
    ID = 59662,
    CnID = "节点类型@章八共鸣处",
    BaseSortID = 39,
    TypeEffect = 30,
    Name = "MapNodeType_59662_Name|入学仪式",
    Desc = "MapNodeType_59662_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_45a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [35056] = {
    ID = 35056,
    CnID = "节点类型@莉莉活动共鸣处",
    BaseSortID = 40,
    TypeEffect = 30,
    Name = "MapNodeType_35056_Name|制片人的迷思",
    Desc = "MapNodeType_35056_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_42a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18403] = {
    ID = 18403,
    CnID = "节点类型@光影演出",
    BaseSortID = 41,
    TypeEffect = 32,
    Name = "MapNodeType_18403_Name|光影演出",
    Desc = "MapNodeType_18403_Desc|光影演出",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18426] = {
    ID = 18426,
    CnID = "节点类型@头像替换",
    BaseSortID = 42,
    TypeEffect = 33,
    Name = "MapNodeType_18426_Name|头像替换",
    Desc = "MapNodeType_18426_Desc|头像替换",
    Block = 0,
    Trigger = 2
  },
  [18432] = {
    ID = 18432,
    CnID = "节点类型@毒气地板",
    BaseSortID = 43,
    TypeEffect = 34,
    Name = "MapNodeType_18432_Name|恶沼",
    Desc = "MapNodeType_18432_Desc|危险的融蚀地带，不要轻易踏入",
    Block = 0,
    Trigger = 2
  },
  [18401] = {
    ID = 18401,
    CnID = "节点类型@2_6专用剧情传送入口",
    BaseSortID = 44,
    TypeEffect = 19,
    Name = "MapNodeType_18401_Name|事件",
    Desc = "MapNodeType_18401_Desc|危险还是机遇，取决于你的抉择。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_14a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [18391] = {
    ID = 18391,
    CnID = "节点类型@2_6专用剧情传送出口",
    BaseSortID = 45,
    TypeEffect = 19,
    Name = "MapNodeType_18391_Name|事件",
    Desc = "MapNodeType_18391_Desc|危险还是机遇，取决于你的抉择。",
    Block = 0,
    Trigger = 2
  },
  [24876] = {
    ID = 24876,
    CnID = "节点类型@剧情本源拉蒙娜",
    BaseSortID = 46,
    TypeEffect = 16,
    Name = "MapNodeType_24876_Name|精英",
    Desc = "MapNodeType_24876_Desc|一些略有挑战的敌人，会触发一场稍难的战斗。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_02a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [37987] = {
    ID = 37987,
    CnID = "节点类型@旺达活动共鸣处",
    BaseSortID = 47,
    TypeEffect = 30,
    Name = "MapNodeType_37987_Name|代行密令",
    Desc = "MapNodeType_37987_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_45a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [38711] = {
    ID = 38711,
    CnID = "节点类型@旺达特殊商店",
    BaseSortID = 48,
    TypeEffect = 5,
    Name = "MapNodeType_38711_Name|夏里奇市集",
    Desc = "MapNodeType_38711_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_44a.png"
    },
    Block = 0,
    Trigger = 2,
    Effect2 = "1;GetResonanceLevel(36898)==1 and 38710;2;14314;2;GetResonanceLevel(36897)==1 and 35237;2;GetResonanceLevel(36905)==1 and 35275;3;math.max(50-PlayerRole.GetStateLayer(3758),0);4;PlayerRole.GetStateLayer(3187)>0 and DrawDeck.GetCardByType({Card_Strike,Card_Defend,Card_Skill,Card_Curse},99,RANDOM) or DrawDeck.GetCardByType({Card_Strike,Card_Defend,Card_Skill},99,RANDOM);5;0+GetResonancePara(36893,1)"
  },
  [44838] = {
    ID = 44838,
    CnID = "节点类型@萨尔瓦多活动共鸣处a",
    BaseSortID = 49,
    TypeEffect = 30,
    Name = "MapNodeType_44838_Name|欲望",
    Desc = "MapNodeType_44838_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_47a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [44840] = {
    ID = 44840,
    CnID = "节点类型@萨尔瓦多活动共鸣处b",
    BaseSortID = 50,
    TypeEffect = 30,
    Name = "MapNodeType_44840_Name|忏悔",
    Desc = "MapNodeType_44840_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_46a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [44839] = {
    ID = 44839,
    CnID = "节点类型@萨尔瓦多活动共鸣处c",
    BaseSortID = 51,
    TypeEffect = 30,
    Name = "MapNodeType_44839_Name|救赎",
    Desc = "MapNodeType_44839_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_48a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [46149] = {
    ID = 46149,
    CnID = "节点类型@模拟战融痕",
    BaseSortID = 52,
    TypeEffect = 5,
    Name = "MapNodeType_46149_Name|融痕",
    Desc = "MapNodeType_46149_Desc|触发后进入融痕，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_13a.png"
    },
    Block = 0,
    Trigger = 2,
    Effect2 = "3;math.max(50-PlayerRole.GetStateLayer(3758),0);4;PlayerRole.GetStateLayer(3187)>0 and DrawDeck.GetCardByType({Card_Strike,Card_Defend,Card_Skill,Card_Curse},99,RANDOM) or DrawDeck.GetCardByType({Card_Strike,Card_Defend,Card_Skill},99,RANDOM);math.max(5-PlayerRole.GetStateLayer(3578),0)"
  },
  [47475] = {
    ID = 47475,
    CnID = "节点类型@「24」活动共鸣处a",
    BaseSortID = 53,
    TypeEffect = 30,
    Name = "MapNodeType_47475_Name|催眠蛇",
    Desc = "MapNodeType_47475_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_49a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [47473] = {
    ID = 47473,
    CnID = "节点类型@「24」活动共鸣处b",
    BaseSortID = 54,
    TypeEffect = 30,
    Name = "MapNodeType_47473_Name|清醒梦",
    Desc = "MapNodeType_47473_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_49a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [47474] = {
    ID = 47474,
    CnID = "节点类型@「24」活动共鸣处c",
    BaseSortID = 55,
    TypeEffect = 30,
    Name = "MapNodeType_47474_Name|主体融合",
    Desc = "MapNodeType_47474_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_49a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [48144] = {
    ID = 48144,
    CnID = "节点类型@「24」活动事件",
    BaseSortID = 56,
    TypeEffect = 6,
    Name = "MapNodeType_48144_Name|自性觉知",
    Desc = "MapNodeType_48144_Desc|危险还是机遇，取决于你的抉择。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_49a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [49058] = {
    ID = 49058,
    CnID = "节点类型@血池",
    BaseSortID = 57,
    TypeEffect = 36,
    Name = "MapNodeType_49058_Name|血污之池",
    Desc = "MapNodeType_49058_Desc|红的发黑的池水中似乎隐藏着什么",
    Block = 0,
    Trigger = 2
  },
  [52486] = {
    ID = 52486,
    CnID = "节点类型@弥利亚姆活动共鸣处a",
    BaseSortID = 58,
    TypeEffect = 30,
    Name = "MapNodeType_52486_Name|天灾",
    Desc = "MapNodeType_52486_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_51a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [52485] = {
    ID = 52485,
    CnID = "节点类型@弥利亚姆活动共鸣处b",
    BaseSortID = 59,
    TypeEffect = 30,
    Name = "MapNodeType_52485_Name|天灾",
    Desc = "MapNodeType_52485_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_51a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [52484] = {
    ID = 52484,
    CnID = "节点类型@弥利亚姆活动共鸣处c",
    BaseSortID = 60,
    TypeEffect = 30,
    Name = "MapNodeType_52484_Name|天灾",
    Desc = "MapNodeType_52484_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_51a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [52487] = {
    ID = 52487,
    CnID = "节点类型@弥利亚姆活动共鸣处d",
    BaseSortID = 61,
    TypeEffect = 30,
    Name = "MapNodeType_52487_Name|终极献祭",
    Desc = "MapNodeType_52487_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_51a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [55798] = {
    ID = 55798,
    CnID = "节点类型@奥尔拉活动共鸣处a",
    BaseSortID = 62,
    TypeEffect = 30,
    Name = "MapNodeType_55798_Name|缪斯的眷顾",
    Desc = "MapNodeType_55798_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_52a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [55797] = {
    ID = 55797,
    CnID = "节点类型@奥尔拉活动共鸣处b",
    BaseSortID = 63,
    TypeEffect = 30,
    Name = "MapNodeType_55797_Name|春天的赠礼",
    Desc = "MapNodeType_55797_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_52a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [65469] = {
    ID = 65469,
    CnID = "节点类型@本源希洛活动共鸣",
    BaseSortID = 64,
    TypeEffect = 30,
    Name = "MapNodeType_65469_Name|安全撤离点",
    Desc = "MapNodeType_65469_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_07a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [57742] = {
    ID = 57742,
    CnID = "节点类型@守卫",
    BaseSortID = 65,
    TypeEffect = 37,
    Name = "MapNodeType_57742_Name|审查会探员",
    Desc = "MapNodeType_57742_Desc|于丽埃特的鹰犬似乎无穷无尽。又一队审查会探员拦在了你前进的路上。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_53a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [57741] = {
    ID = 57741,
    CnID = "节点类型@监狱",
    BaseSortID = 66,
    TypeEffect = 38,
    Name = "MapNodeType_57741_Name|羁押点",
    Desc = "MapNodeType_57741_Desc|审查会的看守并不严密，或许，这反而会是一条可以利用的道路？",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_54a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [57740] = {
    ID = 57740,
    CnID = "节点类型@空节点",
    BaseSortID = 67,
    TypeEffect = 39,
    Name = "MapNodeType_57740_Name|监察点",
    Desc = "MapNodeType_57740_Desc|这块没有任何遮挡物的区域，完全暴露在审查会的监视之下。",
    Block = 0,
    Trigger = 2
  },
  [76256] = {
    ID = 76256,
    CnID = "节点类型@灰烬遗迹",
    BaseSortID = 68,
    TypeEffect = 40,
    Name = "MapNodeType_76256_Name|灰烬遗迹",
    Desc = "MapNodeType_76256_Desc|利莫利亚沉没的遗迹，其后的存在渴求着用神秘力量交换你手中的黑印。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_56a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [76417] = {
    ID = 76417,
    CnID = "节点类型@褪色遗骨",
    BaseSortID = 69,
    TypeEffect = 4,
    Name = "MapNodeType_76417_Name|褪色遗骨",
    Desc = "MapNodeType_76417_Desc|一截苍白的骸骨，半数浸没于漆黑的融蚀浆中",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_55a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [74221] = {
    ID = 74221,
    CnID = "节点类型@星辰章一共鸣处",
    BaseSortID = 70,
    TypeEffect = 30,
    Name = "MapNodeType_74221_Name|尚未流失的意识",
    Desc = "MapNodeType_74221_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_45a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [80599] = {
    ID = 80599,
    CnID = "节点类型@星辰章二共鸣处",
    BaseSortID = 71,
    TypeEffect = 30,
    Name = "MapNodeType_80599_Name|生命的蜕变",
    Desc = "MapNodeType_80599_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_45a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [90661] = {
    ID = 90661,
    CnID = "节点类型@星辰章三共鸣处",
    BaseSortID = 72,
    TypeEffect = 30,
    Name = "MapNodeType_90661_Name|完美品味",
    Desc = "MapNodeType_90661_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_45a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [121329] = {
    ID = 121329,
    CnID = "节点类型@星辰章四共鸣处",
    BaseSortID = 73,
    TypeEffect = 30,
    Name = "MapNodeType_121329_Name|墨菲的幻影",
    Desc = "MapNodeType_121329_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_57a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [130326] = {
    ID = 130326,
    CnID = "节点类型@星辰章五共鸣处",
    BaseSortID = 74,
    TypeEffect = 30,
    Name = "MapNodeType_130326_Name|命运的剧场",
    Desc = "MapNodeType_130326_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_57a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [149067] = {
    ID = 149067,
    CnID = "节点类型@星辰章六共鸣处",
    BaseSortID = 75,
    TypeEffect = 30,
    Name = "MapNodeType_149067_Name|上现蜃景",
    Desc = "MapNodeType_149067_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。",
    HexIcon = {
      "MUnit/Common/Texture/TextureNew/MUnit_Event_57a.png"
    },
    Block = 0,
    Trigger = 2
  },
  [116421] = {
    ID = 116421,
    CnID = "节点类型@随机战斗",
    BaseSortID = 76,
    TypeEffect = 100001,
    Name = "MapNodeType_116421_Name|随机战斗",
    Desc = "MapNodeType_116421_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。"
  },
  [116420] = {
    ID = 116420,
    CnID = "节点类型@随机节点",
    BaseSortID = 77,
    TypeEffect = 100002,
    Name = "MapNodeType_116420_Name|随机节点",
    Desc = "MapNodeType_116420_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。"
  },
  [116422] = {
    ID = 116422,
    CnID = "节点类型@随机事件",
    BaseSortID = 78,
    TypeEffect = 100003,
    Name = "MapNodeType_116422_Name|随机事件",
    Desc = "MapNodeType_116422_Desc|银钥将你指引向此地，与存在于此之物共鸣吧。"
  },
  [128222] = {
    ID = 128222,
    CnID = "节点类型@指令节点",
    BaseSortID = 79,
    TypeEffect = 41,
    Name = "MapNodeType_128222_Name|指令节点",
    Block = 0,
    Trigger = 2
  }
})
return MapNodeType
