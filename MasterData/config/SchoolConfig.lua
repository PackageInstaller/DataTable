local System = require("System.System")
local readonly = System.readonly
local SchoolConfig = readonly({
  [2] = {
    ID = 2,
    CnID = "职业@血肉",
    BaseSortID = 1,
    Name = "SchoolConfig_2_Name|血肉",
    NameEn = "Blood",
    SchoolTipsName = "SchoolConfig_2_SchoolTipsName|猩红献祭",
    SchoolTips = "SchoolConfig_2_SchoolTips|独特的胚胎和熔炉，擅长逆势作战，把风险转为收益。",
    SchoolBattleTips = {
      {
        "true",
        "SchoolConfig_2_SchoolBattleTips_1|·胚胎融合：回合开始时，胚胎融合+<BlueQuality:[Arg1]>。\n·猩红熔炉：回合开始时，积攒 <BlueQuality:[Arg9]> 点猩红熔炉。战斗结束后，积攒 <BlueQuality:[Arg2]> 点猩红熔炉，若当前界域为「至纯血肉」积攒量翻倍，至多积攒 <BlueQuality:[Arg3]> 点。战斗结束时，手牌中每剩余 1 个「胚胎」，额外积攒 <BlueQuality:[Arg2]> 点猩红熔炉。\n·胚胎吞噬：血肉唤醒体的狂气爆发会消耗「胚胎」并触发吞噬效果。队伍每回合首次触发「吞噬」后，获得 <BlueQuality:[Arg4]％> 最大生命的护盾( <BlueQuality:[Arg5]> )和 <BlueQuality:[Arg6]％> 最大生命的临时力量( <BlueQuality:[Arg7]> )。"
      },
      {
        "GetSpecialSchoolAwakerNum(NewBloodSchoolAwakerList)>0",
        "SchoolConfig_2_SchoolBattleTips_2|·胚胎融合：回合开始时，胚胎融合+<BlueQuality:[Arg1]>。\n·繁育胚胎：每名唤醒体每回合首次消耗「繁育·胚胎」时，获得 <BlueQuality:[Arg4]> 层「繁育庆典」：每拥有 1 层该唤醒体本回合下次狂气爆发造成的伤害、固定护盾、固定生命回复、固定力量、力量降低、触腕伤害提高、固定中毒、固定反击的最终效果提高 1%。\n·猩红熔炉：回合开始时，积攒 <BlueQuality:[Arg2]> 点猩红熔炉，至多 <BlueQuality:[Arg3]> 点。3 回合冷却。\n·猩红侵蚀：使用猩红熔炉后对所有敌人造成目标最大生命 1％ 的侵蚀，消耗的猩红熔炉越多侵蚀效果就越强，至多提高 100%。对「空壳」敌人造成 5 倍侵蚀效果。\n·探索开始后，最大生命提高 10％，队伍伤害强效 +50%。回合开始时，所有唤醒体获得 <BlueQuality:[Arg5]> 层「繁育庆典」。\n·血肉精通：队伍每有 1 点界域精通，使「繁育·血肉」获得的「繁育庆典」提高 0.05%。\n·至纯血肉：如果队伍仅由血肉或混沌唤醒体组成，血肉精通效果和界域提供的伤害强效翻倍。"
      }
    },
    DisplaySort = 3,
    Tips = "SchoolConfig_2_Tips|·胚胎融合：回合开始时，胚胎融合+30，生命越低则效果越高，至多提高 100。达到 100 时将 1 张「胚胎」置入手中。「胚胎」可以直接使用为一名唤醒体提供 30 狂气，获得 10% 临时暴击率。\n·猩红熔炉：回合开始时，积攒 3％ 最大生命的猩红熔炉。战斗结束后，积攒 5% 最大生命的猩红熔炉，猩红熔炉可用于回复生命，至多积攒 25% 最大生命。战斗结束时，手牌中每剩余 1 个胚胎，积攒 5% 最大生命的猩红熔炉。\n·胚胎吞噬：血肉唤醒体的狂气爆发拥有「吞噬」效果，使用时会尝试消耗「胚胎」，如果消耗成功则触发「吞噬」效果。队伍每回合首次触发「吞噬」后获得 4% 最大生命的护盾和 2% 最大生命的临时力量，生命越低则效果越高，效果至多提高 100%。\n·血肉精通：队伍每有 1 点界域精通，首次触发「吞噬」后就额外获得 0.01% 最大生命的护盾和 0.005% 最大生命的临时力量，生命越低则效果越高，效果至多提高 100%。\n·至纯血肉：如果队伍中仅由血肉唤醒体组成时，血肉精通属性最终值翻倍，积攒的猩红熔炉翻倍。",
    SchoolBattleTipIcon = "UIResources/AtlasSource/UI_Battle_Icon/Battle_Job_3.png",
    StateList = {
      {
        "true",
        {
          72016,
          72015,
          72018,
          81022,
          126797,
          72022
        }
      },
      {
        "GetSpecialSchoolAwakerNum(NewBloodSchoolAwakerList)>0",
        {
          131769,
          72015,
          72018,
          81022,
          126797,
          72022
        }
      }
    },
    StateTarget = "PlayerRole",
    StatePara = {
      {
        "true",
        {
          "30+((PlayerRole.max_hp-PlayerRole.hp)/PlayerRole.max_hp)*30",
          "PlayerRole.max_hp*0.05",
          "math.ceil((PlayerRole.max_hp*0.05*10+PlayerRole.GetStateLayer(57343))*(1+PlayerRole.GetStateLayer(44823)/100))*PlayerRole.GetStateLayer(131769)+math.ceil((PlayerRole.max_hp*0.05*5+PlayerRole.GetStateLayer(57343))*(1+PlayerRole.GetStateLayer(44823)/100))*(1-PlayerRole.GetStateLayer(131769))",
          "math.ceil((4+PlayerRole.occupation_master_final/100)*(1+(PlayerRole.max_hp-PlayerRole.hp)/PlayerRole.max_hp))",
          "math.ceil(PlayerRole.max_hp/100*((4+PlayerRole.occupation_master_final/100)*(1+(PlayerRole.max_hp-PlayerRole.hp)/PlayerRole.max_hp)))",
          "math.ceil((2+PlayerRole.occupation_master_final/200)*(1+(PlayerRole.max_hp-PlayerRole.hp)/PlayerRole.max_hp))",
          "math.ceil(PlayerRole.max_hp/100*((2+PlayerRole.occupation_master_final/200)*(1+(PlayerRole.max_hp-PlayerRole.hp)/PlayerRole.max_hp)))",
          35,
          "PlayerRole.max_hp*0.03"
        }
      },
      {
        "GetSpecialSchoolAwakerNum(NewBloodSchoolAwakerList)>0",
        {
          "50+((PlayerRole.max_hp-PlayerRole.hp)/PlayerRole.max_hp)*50",
          "(PlayerRole.max_hp-PlayerRole.hp)*0.1",
          "math.ceil((PlayerRole.max_hp*0.05*10+PlayerRole.GetStateLayer(57343))*(1+PlayerRole.GetStateLayer(44823)/100))*PlayerRole.GetStateLayer(131769)+math.ceil((PlayerRole.max_hp*0.05*5+PlayerRole.GetStateLayer(57343))*(1+PlayerRole.GetStateLayer(44823)/100))*(1-PlayerRole.GetStateLayer(131769))",
          "math.ceil(40*(1+PlayerRole.occupation_master_final*0.0005))",
          "math.ceil(20*(1+PlayerRole.occupation_master_final*0.0005))"
        }
      }
    },
    IsolateStateTarget = "PlayerRole",
    Order = 3,
    DefaultCard = {
      101098,
      101098,
      101098,
      101098,
      101099,
      101099,
      101099,
      101099
    },
    SortID = 2,
    AwakeListBg = "UI_Awaker_CareerBg_1.png",
    Icon = "Icon/Career/Icon_Career_Xuerou.png",
    IconGlow = "Icon/Career/Icon_Career2_Xuerou.png",
    SummonPic = "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_Career_1.png",
    SummonLightPic = "UIResources/UIBigImages/UI_Large/UI_Summon_Image_Ligh_Red.png",
    SummonWeaponFrame = "UIResources/UIBigImages/UI_Large/UI_Summon_D_Line_BG1.png",
    SubplotCoverImage = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Blood.png",
    SchoolFeature = "SchoolConfig_2_SchoolFeature|该界域的唤醒体需要选择如何积攒与利用胚胎，可以主动使用来灵活地提供狂气或是被吞噬来增强狂气爆发的效果。",
    SkillUpgradeConsumeItem = {
      10108,
      9755,
      9740,
      9543
    },
    SkillUpgradeConsumeNum = {
      {
        2000,
        0,
        0,
        0
      },
      {
        4000,
        15,
        0,
        0
      },
      {
        17500,
        0,
        18,
        0
      },
      {
        70000,
        0,
        60,
        1
      }
    },
    Difficulty = 4
  },
  [3] = {
    ID = 3,
    CnID = "职业@超维",
    BaseSortID = 2,
    Name = "SchoolConfig_3_Name|超维",
    NameEn = "Dimension",
    SchoolTipsName = "SchoolConfig_3_SchoolTipsName|维度跃迁",
    SchoolTips = "SchoolConfig_3_SchoolTips|独特的超维空间，擅长调度卡牌及控制节奏。",
    SchoolBattleTips = {
      {
        "true",
        "SchoolConfig_3_SchoolBattleTips_1|·维度穿梭：每回合首次打出指令卡后触发该效果，将其临时原始复制置入超维空间，超维回合无法发动该效果。\n·超维回合：进入超维回合后，将超维空间的所有卡牌置入手中以代替抽牌。超维回合造成的伤害、护盾、生命回复、银钥能量、狂气、力量变化、中毒、反击、出血减少 25%。\n·湮灭：每回合 1 次，能够移除超维空间最左侧的卡牌，将 1 张「灵感」置入手中。\n·超维精通：队伍每有 1 点界域精通，回合开始时有 0.125％ 的概率（<BlueQuality:[Arg1]%>）获得 1 张「灵感」，概率超过 100% 可获得多张。\n·至纯超维：如果队伍中仅由超维唤醒体组成时，超维精通属性效果翻倍，且不再受到超维回合能力下降效果的影响。"
      },
      {
        "GetSpecialSchoolAwakerNum(NewDimensionSchoolAwakerList)>0",
        "SchoolConfig_3_SchoolBattleTips_2|·维度穿梭：每回合首次打出指令卡后触发该效果，将其临时原始复制置入超维空间并为其和临时复制赋予 <BlueQuality:[Arg2]> 层「奇点信标」，超维回合无法发动该效果。\n·奇点信标：每拥有 1 层使该卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击最终效果提高 2%；固定护盾、固定生命回复、力量降低的最终效果提高 1%，打出后移除。拥有奇点信标的卡牌无法触发「维度穿梭」。\n·超维空间：当其达到上限时回合结束改为发动超维空间，不再获得额外回合，弃掉非保留手牌并触发虚无效果、将超维空间所有卡牌置入手中，将当前算力设置为 5 点。发动超维空间后，本回合视为超维回合。\n·奇点湮灭：取出超维空间最左侧的卡牌，本回合下次「奇点折跃」可发动。3 回合冷却。\n·探索开始后队伍伤害强效 +50%，并获得 15 层「奇点棱镜」。\n·「奇点棱镜」：所有指令卡视为拥有等量奇点信标的加成。\n·超维精通：队伍每有 1 点界域精通，使「奇点棱镜」和「维度穿梭」施加的「奇点信标」层数提高 0.05%。\n·至纯超维：如果队伍仅由超维或混沌唤醒体组成，超维精通效果和界域提供的伤害强效翻倍。"
      }
    },
    DisplaySort = 4,
    Tips = "SchoolConfig_3_Tips|·维度穿梭：每回合首次打出指令卡后触发该效果，将其临时原始复制置入超维空间，超维回合无法发动该效果。\n·超维回合：进入超维回合后，将超维空间的所有卡牌置入手中以代替抽牌。超维回合造成的伤害、护盾、生命回复、银钥能量、狂气、力量变化、中毒、反击、出血减少 25%。\n·湮灭：每回合 1 次，能够移除超维空间最左侧的卡牌，将 1 张「灵感」置入手中。\n·超维精通：队伍每有 1 点界域精通，回合开始时有 0.125% 的概率获得 1 张「灵感」，概率超过 100% 可获得多张。\n·至纯超维：如果队伍中仅由超维唤醒体组成时，超维精通属性效果翻倍，且不再受到超维回合能力下降效果的影响。",
    SchoolBattleTipIcon = "UIResources/AtlasSource/UI_Battle_Icon/Battle_Job_2.png",
    StateList = {
      {
        "true",
        {
          3381,
          3383,
          72018,
          81022,
          126797,
          72023
        }
      },
      {
        "GetSpecialSchoolAwakerNum(NewDimensionSchoolAwakerList)>0",
        {
          126901,
          126900,
          72018,
          81022,
          126797,
          72023
        }
      }
    },
    StateTarget = "PlayerRole",
    StatePara = {
      {
        "true",
        {
          "math.ceil(PlayerRole.occupation_master_final*0.125)",
          "math.ceil(25*(1+PlayerRole.occupation_master_final*0.0005))"
        }
      }
    },
    IsolateStateTarget = "PlayerRole",
    Order = 5,
    DefaultCard = {
      101098,
      101098,
      101098,
      101098,
      101099,
      101099,
      101099,
      101099
    },
    SortID = 4,
    AwakeListBg = "UI_Awaker_CareerBg_1.png",
    Icon = "Icon/Career/Icon_Career_Chaowei.png",
    IconGlow = "Icon/Career/Icon_Career2_Chaowei.png",
    SummonPic = "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_Career_4.png",
    SummonLightPic = "UIResources/UIBigImages/UI_Large/UI_Summon_Image_Ligh_Pueple.png",
    SummonWeaponFrame = "UIResources/UIBigImages/UI_Large/UI_Summon_D_Line_BG4.png",
    SubplotCoverImage = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Dimension.png",
    SchoolFeature = "SchoolConfig_3_SchoolFeature|该界域的唤醒体需要仔细规划超维牌堆，每回合打出的第一张技能牌自动进入该牌堆，回合结束时若牌堆满则进入额外的回合并将该牌堆的牌置入手中。",
    SkillUpgradeConsumeItem = {
      10108,
      10044,
      9904,
      9543
    },
    SkillUpgradeConsumeNum = {
      {
        2000,
        0,
        0,
        0
      },
      {
        4000,
        15,
        0,
        0
      },
      {
        17500,
        0,
        18,
        0
      },
      {
        70000,
        0,
        60,
        1
      }
    },
    Difficulty = 5
  },
  [4] = {
    ID = 4,
    CnID = "职业@深海",
    BaseSortID = 3,
    Name = "SchoolConfig_4_Name|深海",
    NameEn = "Ocean",
    SchoolTipsName = "SchoolConfig_4_SchoolTipsName|沉渊之触",
    SchoolTips = "SchoolConfig_4_SchoolTips|独特的触腕，可以灵活切换姿态。",
    SchoolBattleTips = {
      {
        "true",
        "SchoolConfig_4_SchoolBattleTips_1|·触腕姿态：回合开始时为基础的「潮涌」姿态，「潮涌」姿态下可以点击触腕切换为「静海」姿态或「怒涛」姿态。若回合结束时仍处于「潮涌」姿态，下回合开始时生成 1 条触腕。\n·触腕集结：唤醒体使用狂气爆发后，获得 1 层触腕集结，有 <BlueQuality:[Arg5]％> 几率额外获得 1 层触腕集结。回合结束时，每有 1 层触腕集结就驱使 1 条触腕攻击前排敌人，随后清除触腕集结。\n·触腕暴击率：<BlueQuality:[Arg6]％>。\n·触腕暴击伤害：<BlueQuality:[Arg7]％>。\n·触腕满溢：永久触腕条数超出上限后，使 1 条触腕攻击 3 次，并提高 1 条触腕上限，每次触发该效果都会使提高触腕上限需要的次数提高 1。"
      },
      {
        "GetSpecialSchoolAwakerNum(NewOceanSchoolAwakerList)>0",
        "SchoolConfig_4_SchoolBattleTips_2|·触腕姿态：回合开始时为基础的「潮涌」姿态。\n·「潮涌」姿态下可以点击触腕切换为「静海」姿态或「怒涛」姿态，分别拥有 3 回合冷却。若回合结束时仍处于「潮涌」姿态，下回合开始时生成 1 条触腕。\n·界域精通变更为「晦瞑·深海精通」，不再拥有「触腕集结」效果，每点界域精通使「晦瞑·静海」的护盾提高 0.025% 最大生命，使「晦瞑·怒涛」的触腕伤害额外提高 0.025%。如果队伍中由深海或混沌唤醒体组成时，「晦瞑·界域精通」效果翻倍。\n·触腕暴击率：<BlueQuality:[Arg3]％>。\n·触腕暴击伤害：<BlueQuality:[Arg4]％>。\n·触腕满溢：永久触腕条数超出上限后，使 1 条触腕攻击 3 次，并提高 1 条触腕上限，每次触发该效果都会使提高触腕上限需要的次数提高 1。"
      }
    },
    DisplaySort = 2,
    Tips = "SchoolConfig_4_Tips|·触腕统御：战斗开始时，生成 1 条触腕，触腕在回合结束时会自动攻击前排敌人。\n·触腕姿态：回合开始时为基础的「潮涌」姿态，每回合可以切换 1 次触腕姿态。切换为「静海」立刻获得 8% 最大生命的护盾，每次触腕攻击时获得 0.2% 最大生命的护盾，但本回合触腕伤害变为 50%。切换为「怒涛」使本回合触腕伤害变为 125%，造成主动伤害后使 1 条触腕攻击目标敌方，造成 50％ 触腕伤害，但回合结束时失去 1 条触腕。若回合结束时仍处于「潮涌」姿态，下回合开始时生成 1 条触腕。\n·触腕集结：唤醒体使用狂气爆发后，获得 1 层触腕集结。回合结束时，每有 1 层触腕集结就驱使 1 条触腕攻击前排敌人，随后清除触腕集结。\n· 触腕暴击：触腕能够造成暴击，初始暴击率和暴击伤害为进入关卡时所有唤醒体暴击率和暴击伤害总和的 50％。关卡内每有 1 名唤醒体获得 1％暴击率和暴击伤害，触腕暴击率和暴击伤害提高 0.25％。\n·深海精通：队伍每有 1 点界域精通，唤醒体使用狂气爆发后就有 0.25% 的概率在回合结束时额外获得 1 层触腕集结(概率超过 100% 可获得多层)，切换为「静海」立刻获得的护盾就提高 0.01% 最大生命，使「怒涛」中因主动伤害触发的触腕攻击伤害提高 0.02％。\n·至纯深海：如果队伍中仅由深海唤醒体组成时，深海精通属性效果翻倍，且战斗开始时自动生成的触腕数翻倍。",
    SchoolBattleTipIcon = "UIResources/AtlasSource/UI_Battle_Icon/Battle_Job_1.png",
    StateList = {
      {
        "true",
        {
          2437,
          72033,
          72034,
          72018,
          81022,
          126797,
          72024
        }
      },
      {
        "GetSpecialSchoolAwakerNum(NewOceanSchoolAwakerList)>0",
        {
          120350,
          120357,
          120352,
          72018,
          81022,
          126797,
          72024
        }
      }
    },
    StateTarget = "PlayerRole",
    StatePara = {
      {
        "true",
        {
          "TeamAtk*GetAccountLevelArgByAccoutLevel(OceanDamageMultiplier)*0.2+math.ceil(PlayerRole.max_hp*0.01)*GetAwakerCountBySchool(1)",
          "math.ceil(PlayerRole.max_hp*0.01*(8+PlayerRole.occupation_master_final/100))",
          "math.ceil(PlayerRole.max_hp*0.002)",
          "50+math.ceil(PlayerRole.occupation_master_final/50)",
          "math.ceil(PlayerRole.occupation_master_final*0.25)",
          "PlayerRole.tentacle_crit",
          "PlayerRole.tentacle_crit_dmg"
        }
      },
      {
        "GetSpecialSchoolAwakerNum(NewOceanSchoolAwakerList)>0",
        {
          "math.ceil(PlayerRole.max_hp*(0.25+PlayerRole.occupation_master_final*0.00025))",
          "125+math.ceil(PlayerRole.occupation_master_final*0.025)",
          "PlayerRole.tentacle_crit",
          "PlayerRole.tentacle_crit_dmg"
        }
      }
    },
    IsolateStateTarget = "PlayerRole",
    Order = 2,
    DefaultCard = {
      101098,
      101098,
      101098,
      101098,
      101099,
      101099,
      101099,
      101099
    },
    SortID = 1,
    AwakeListBg = "UI_Awaker_CareerBg_1.png",
    Icon = "Icon/Career/Icon_Career_Shenhai.png",
    IconGlow = "Icon/Career/Icon_Career2_Shenhai.png",
    SummonPic = "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_Career_2.png",
    SummonLightPic = "UIResources/UIBigImages/UI_Large/UI_Summon_Image_Ligh_Blue.png",
    SummonWeaponFrame = "UIResources/UIBigImages/UI_Large/UI_Summon_D_Line_BG3.png",
    SubplotCoverImage = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Ocean.png",
    SchoolFeature = "SchoolConfig_4_SchoolFeature|该界域的唤醒体擅长掌控触腕，能熟练地生成、增强、并号令多条触腕攻击敌人。",
    SkillUpgradeConsumeItem = {
      10108,
      10030,
      9758,
      9543
    },
    SkillUpgradeConsumeNum = {
      {
        2000,
        0,
        0,
        0
      },
      {
        4000,
        15,
        0,
        0
      },
      {
        17500,
        0,
        18,
        0
      },
      {
        70000,
        0,
        60,
        1
      }
    },
    Difficulty = 3
  },
  [1] = {
    ID = 1,
    CnID = "职业@混沌",
    BaseSortID = 4,
    Name = "SchoolConfig_1_Name|混沌",
    NameEn = "Chaos",
    SchoolTipsName = "SchoolConfig_1_SchoolTipsName|宇宙万象",
    SchoolTips = "SchoolConfig_1_SchoolTips|更强的银钥能力，混编时能够最大发挥另一个界域的特色。",
    SchoolBattleTips = {
      {
        "true",
        "SchoolConfig_1_SchoolBattleTips_1|·银钥共鸣：回合结束时，获得 250 点银钥能量。使用钥令后，所有唤醒体获得 <BlueQuality:[Arg1]> 点狂气。释放第二次钥令时，改为释放「未至遗忘的黎明」：选择 1 个已解锁的钥令释放并使其生效 2 次，每个已解锁的钥令在本次探索中只能选择 1 次，不可选择初始携带的钥令。"
      },
      {
        "GetSpecialSchoolAwakerNum(NewChaosSchoolAwakerList)>0",
        "SchoolConfig_1_SchoolBattleTips_2|· 原初灌注：基础银钥能量提高为 2000 点，队伍伤害强效 +50%，所有唤醒体的攻击和防御提高 10%。如果队伍仅由混沌唤醒体组成，该效果获得的伤害强效翻倍。战斗开始时，获得 2000 点银钥能量。\n· 万钥同源：所有唤醒体的银钥充能等级变为队伍平均值。且不再根据算力消耗获得银钥能量，而是每名唤醒体每回合首张指令卡获得「该唤醒体银钥充能 * 3 + 100 的银钥能量」。\n·  未分之境：不再触发其他界域的至纯界域、精通效果翻倍、强效翻倍效果。\n·  原初回响：灵知觉醒获得预备 1，每回合首次打出时自动释放携带钥令。\n·  记忆碎片：钥令被替换为「原初·双生复演」和 「原初·三相天启」，本身携带的钥令无法释放。\n原初·双生复演和原初·三相天启中的钥令会包含八种「原初记忆」，分别为不同的单效果钥令。\n原初·双生复演和原初·三相天启仅视为释放 1 次钥令，在多次生效时，仅对首个生效的钥令有效。\n· 界域精通变为「原初·混沌精通」，每点界域精通使钥令强度提高 0.05%。\n· 每点钥令强度提高钥令造成的固定中毒、固定反击、固定力量、固定触腕伤害、固定旧日余烬 2%、提高固定护盾、固定生命回复、力量降低、暴击率、暴击伤害、伤害强效、界域精通、狂气、胚胎融合、银钥能量 1%\n· 如果队伍仅由混沌唤醒体组成，「原初·混沌精通」效果翻倍。"
      }
    },
    DisplaySort = 1,
    Tips = "SchoolConfig_1_Tips|·银钥共鸣：回合结束时，获得 250 点银钥能量。使用钥令后，所有唤醒体获得 5 点狂气。释放第二次钥令时，改为释放「未至遗忘的黎明」：选择 1 个已解锁的钥令释放并使其生效 2 次，每个已解锁的钥令在本次探索中只能选择 1 次，不可选择初始携带的钥令。\n·万象造物：若守密人等级达到 45 级，探索开始时发现 1 个白银造物。\n·混沌精通：队伍每有 1 点界域精通，使用钥令后，所有唤醒体额外获得 0.05 点狂气。\n·向死而生：任意队伍中，若存在混沌唤醒体，死亡抵抗+100%。\n·混沌共生：当与其他界域混编时，「银钥共鸣」、「万象造物」、「混沌精通」不再生效，始终触发其他界域的至纯天赋效果，并依据界域的不同获得不同的界域共生效果。\n·深海共生：队伍中每有 1 名混沌唤醒体，基础触腕伤害提高最大生命的 1％。混沌唤醒体释放狂气爆发后，回合结束时额外驱使 1 条触腕攻击敌方，并使所有深海唤醒体获得 10 点狂气。\n·血肉共生：混沌唤醒体使用狂气爆发后胚胎融合+35。\n·超维共生：战斗开始时，队伍中每有 1 名混沌唤醒体，永久提高 1% 最大生命的力量并降低所有敌人 0.5% 自身最大生命的力量，同时使所有超维唤醒体暴击伤害提高 10%。",
    SchoolBattleTipIcon = "UIResources/AtlasSource/UI_Battle_Icon/UI_Battle_White_Buff_005.png",
    StateList = {
      {
        "GetSpecialSchoolAwakerNum(NewChaosSchoolAwakerList)>0",
        {
          146534,
          72036,
          81022,
          72018,
          126797,
          145672
        }
      }
    },
    StateTarget = "PlayerRole",
    StatePara = {
      {
        "true",
        {
          "5+math.ceil(PlayerRole.occupation_master_final*0.05)"
        }
      }
    },
    IsolateStateList = {
      {
        "GetSpecialSchoolAwakerNum(NewChaosSchoolAwakerList)==0",
        {
          72036,
          3472,
          72018,
          81022,
          126797
        }
      }
    },
    IsolateStateTarget = "PlayerRole",
    Order = 1,
    DefaultCard = {
      101098,
      101098,
      101098,
      101098,
      101099,
      101099,
      101099,
      101099
    },
    SortID = 5,
    AwakeListBg = "UI_Awaker_CareerBg_1.png",
    Icon = "Icon/Career/Icon_Career_Hundun.png",
    IconGlow = "Icon/Career/Icon_Career2_Hundun.png",
    SummonPic = "UIResources/AtlasSource/UI_Summon_Image/UI_Summon_D_Image_Career_3.png",
    SummonLightPic = "UIResources/UIBigImages/UI_Large/UI_Summon_Image_Ligh_Yellow.png",
    SummonWeaponFrame = "UIResources/UIBigImages/UI_Large/UI_Summon_D_Line_BG2.png",
    SubplotCoverImage = "UIResources/UIBigImages/UI_Large/UI_Large_Chapter/UI_Bg_Subplot_Chaos.png",
    SchoolFeature = "SchoolConfig_1_SchoolFeature|该界域的唤醒体与其它界域混编时，能够增强对应界域的相关能力，全混沌编队时则会拥有更强大的银钥掌控能力。",
    SkillUpgradeConsumeItem = {
      10108,
      10030,
      9755,
      10044,
      9758,
      9740,
      9904,
      9543
    },
    SkillUpgradeConsumeNum = {
      {
        2000,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        4000,
        5,
        5,
        5,
        0,
        0,
        0,
        0
      },
      {
        17500,
        0,
        0,
        0,
        6,
        6,
        6,
        0
      },
      {
        70000,
        0,
        0,
        0,
        20,
        20,
        20,
        1
      }
    },
    Difficulty = 3
  }
})
return SchoolConfig
