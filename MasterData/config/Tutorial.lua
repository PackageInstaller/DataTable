local System = require("System.System")
local readonly = System.readonly
local Tutorial = readonly({
  [17806] = {
    ID = 17806,
    CnID = "教程@刻印",
    BaseSortID = 1,
    data_list = readonly({
      readonly({
        BaseSortID = 1,
        Type = "Challenge",
        TriggerTimeType = "FirstGetAnyEnchant",
        Title = "Tutorial_17806_Title_1|刻印",
        Desc = "Tutorial_17806_Desc_1|战胜敌人后可以选择<TutorialHighlight:刻印>，也可以在<TutorialHighlight:融痕>中花费<TutorialHighlight:黑印>进行购买。<TutorialHighlight:刻印>可以让指定卡获得不同的额外效果。每张指定卡最多只能刻印 <TutorialHighlight:1> 次。优先为更经常打出的指令卡进行刻印，可以提升刻印带来的收益。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_52.png",
        Prompt = 1
      })
    })
  },
  [17809] = {
    ID = 17809,
    CnID = "教程@造物",
    BaseSortID = 2,
    data_list = readonly({
      readonly({
        BaseSortID = 2,
        Type = "Challenge",
        TriggerTimeType = "FirstGetAnyRelic",
        Title = "Tutorial_17809_Title_1|造物",
        Desc = "Tutorial_17809_Desc_1|通过事件、融痕可以获得<TutorialHighlight:造物>，<TutorialHighlight:造物>可以强化我方队伍的作战能力。优秀守密人往往可以根据队伍的需要，选择更契合的<TutorialHighlight:造物>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_51.png",
        Prompt = 1
      })
    })
  },
  [17825] = {
    ID = 17825,
    CnID = "教程@共鸣",
    BaseSortID = 3,
    data_list = readonly({
      readonly({
        BaseSortID = 3,
        Type = "Challenge",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {
          "Material",
          "ResonanceParticle"
        },
        Title = "Tutorial_17825_Title_1|共鸣",
        Desc = "Tutorial_17825_Desc_1|首次完成调查行动后可以获得<TutorialHighlight:共鸣激活材料>，它们可用于激活强大的<TutorialHighlight:共鸣>，共鸣会在这一章的所有关卡中生效。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_50.png"
      })
    })
  },
  [17842] = {
    ID = 17842,
    CnID = "教程@黑印",
    BaseSortID = 4,
    data_list = readonly({
      readonly({
        BaseSortID = 4,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {12070},
        Title = "Tutorial_17842_Title_1|黑印",
        Desc = "Tutorial_17842_Desc_1|战胜敌人、调查事件可以获得<TutorialHighlight:黑印>，唤醒体的<TutorialHighlight:黑印掉落>属性可以提升获得的黑印数量。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_49.png",
        Prompt = 1
      }),
      readonly({
        Desc = "Tutorial_17842_Desc_2|在融痕中可以消耗<TutorialHighlight:黑印>购买刻印和造物，也可以用来觉醒唤醒体。在最终战前，请尽可能地花光所有的黑印强化我方队伍。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_48.png"
      })
    })
  },
  [17838] = {
    ID = 17838,
    CnID = "教程@联络处",
    BaseSortID = 5,
    data_list = readonly({
      readonly({
        BaseSortID = 5,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {11756},
        Title = "Tutorial_17838_Title_1|联络处",
        Desc = "Tutorial_17838_Desc_1|在联络点中，你可以选择恢复我方队伍已损失生命的50%，或指定觉醒 1 名唤醒体。当我方队伍生命较低时，推荐选择回复生命，否则推荐选择觉醒唤醒体。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_47.png"
      })
    })
  },
  [17834] = {
    ID = 17834,
    CnID = "教程@析出点",
    BaseSortID = 6,
    data_list = readonly({
      readonly({
        BaseSortID = 6,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {11971},
        Title = "Tutorial_17834_Title_1|析出点",
        Desc = "Tutorial_17834_Desc_1|仔细搜寻地图上微微发光的地点，前往调查说不定会有意外收获。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_46.png"
      })
    })
  },
  [20769] = {
    ID = 20769,
    CnID = "教程@门扉",
    BaseSortID = 7,
    data_list = readonly({
      readonly({
        BaseSortID = 7,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {12985},
        Title = "Tutorial_20769_Title_1|锈蚀门扉",
        Desc = "Tutorial_20769_Desc_1|<TutorialHighlight:锈蚀门扉>会阻挡重要的调查路线，尝试在地图中搜寻一种称为<TutorialHighlight:锈蚀钥匙>的物件，它可以用于开启<TutorialHighlight:锈蚀门扉>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_45.png",
        Prompt = 1
      })
    })
  },
  [20770] = {
    ID = 20770,
    CnID = "教程@钥匙",
    BaseSortID = 8,
    data_list = readonly({
      readonly({
        BaseSortID = 8,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {12693},
        Title = "Tutorial_20770_Title_1|锈蚀钥匙",
        Desc = "Tutorial_20770_Desc_1|<TutorialHighlight:锈蚀钥匙>可以开启阻挡你前进的<TutorialHighlight:锈蚀门扉>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_44.png",
        Prompt = 1
      })
    })
  },
  [17840] = {
    ID = 17840,
    CnID = "教程@幻象",
    BaseSortID = 9,
    data_list = readonly({
      readonly({
        BaseSortID = 9,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {12018, 12220},
        Title = "Tutorial_17840_Title_1|幻象",
        Desc = "Tutorial_17840_Desc_1|强行通过<TutorialHighlight:幻象>将会感染「症状」。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_43.png"
      })
    })
  },
  [17839] = {
    ID = 17839,
    CnID = "教程@融痕",
    BaseSortID = 10,
    data_list = readonly({
      readonly({
        BaseSortID = 10,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {12019},
        Title = "Tutorial_17839_Title_1|融痕",
        Desc = "Tutorial_17839_Desc_1|用于消耗黑印强化我方队伍的场所，一般会提供1栏刻印，1栏白银造物，1栏黄金造物。如果这里没有需要的物品，可以点击右上角的<TutorialHighlight:刷新>，融痕会提供新的物品。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_41.png",
        Prompt = 1
      })
    })
  },
  [17810] = {
    ID = 17810,
    CnID = "教程@驱雾结晶",
    BaseSortID = 11,
    data_list = readonly({
      readonly({
        BaseSortID = 11,
        Type = "Challenge",
        TriggerTimeType = "FirstMoveToNode",
        TriggerTimePara = {11863, 12773},
        Title = "Tutorial_17810_Title_1|探照灯",
        Desc = "Tutorial_17810_Desc_1|驱散迷雾，地图视野提升 <TutorialHighlight:2> 格，可以利用它做出更好的路线规划。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_42.png"
      })
    })
  },
  [23466] = {
    ID = 23466,
    CnID = "教程@守密人等级",
    BaseSortID = 12,
    data_list = readonly({
      readonly({
        BaseSortID = 12,
        Type = "System",
        Title = "Tutorial_23466_Title_1|守密人等级",
        Desc = "Tutorial_23466_Desc_1|随着守密人等级的提升，<TutorialHighlight:造物和刻印的强度>会跟随提升，唤醒体<TutorialHighlight:每点体质对队伍生命的影响>也会提升。通过调查行动、幕间演习可以获取大量的守密人经验。每消耗1点体力会获得1点守密人经验。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_59.png"
      })
    })
  },
  [17827] = {
    ID = 17827,
    CnID = "教程@升级",
    BaseSortID = 13,
    data_list = readonly({
      readonly({
        BaseSortID = 13,
        Type = "System",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {
          "Material",
          "ExpMaterial"
        },
        Title = "Tutorial_17827_Title_1|灵知制剂",
        Desc = "Tutorial_17827_Desc_1|消耗<TutorialHighlight:灵知制剂>可以提升唤醒体等级，唤醒体升级后属性将会提升。达到等级上限之后需要先进行升格，升格后会提高唤醒体等级上限。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_36.png"
      })
    })
  },
  [17821] = {
    ID = 17821,
    CnID = "教程@命轮",
    BaseSortID = 14,
    data_list = readonly({
      readonly({
        BaseSortID = 14,
        Type = "System",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {"Weapon", "Weapon"},
        Title = "Tutorial_17821_Title_1|命轮",
        Desc = "Tutorial_17821_Desc_1|为唤醒体装备<TutorialHighlight:命轮>，可以提升唤醒体的属性，还可以获得特殊能力。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_35.png"
      })
    })
  },
  [20773] = {
    ID = 20773,
    CnID = "教程@命轮叠位",
    BaseSortID = 15,
    data_list = readonly({
      readonly({
        BaseSortID = 15,
        Type = "System",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {"Weapon", "Weapon"},
        Title = "Tutorial_20773_Title_1|命轮叠位",
        Desc = "Tutorial_20773_Desc_1|消耗相同的<TutorialHighlight:命轮>进行叠位，或使用<TutorialHighlight:循环母版>对<TutorialHighlight:SSR命轮>进行叠位，可以提升<TutorialHighlight:命轮>的属性和特殊能力。叠位1次至3次时，命轮的效果会增强；叠位4次至15次时，命轮的属性会增强。可以在叠位界面点击「下一阶」按钮预览叠位后的变化。\n通过唤醒等途径获得已有命轮时，系统将会自动与已有命轮进行叠位，无需守密人单独操作。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_34.png"
      })
    })
  },
  [81371] = {
    ID = 81371,
    CnID = "教程@唤醒体升级",
    BaseSortID = 16,
    data_list = readonly({
      readonly({
        BaseSortID = 16,
        Type = "System",
        Title = "Tutorial_81371_Title_1|唤醒体升级",
        Desc = "Tutorial_81371_Desc_1|<TutorialHighlight:唤醒体升级>是最快速提升唤醒体属性的方式之一。消耗<TutorialHighlight:灵知制剂>可以提升唤醒体等级。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_01.png"
      }),
      readonly({
        Desc = "Tutorial_81371_Desc_2|唤醒体达到等级上限之后需要通过<TutorialHighlight:升格>来提升等级上限，不同界域的唤醒体需要不同的<TutorialHighlight:升格素材>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_02.png"
      })
    })
  },
  [17852] = {
    ID = 17852,
    CnID = "教程@技能强化",
    BaseSortID = 17,
    data_list = readonly({
      readonly({
        BaseSortID = 17,
        Type = "System",
        Title = "Tutorial_17852_Title_1|技能强化",
        Desc = "Tutorial_17852_Desc_1|<TutorialHighlight:技能升级>可以提升唤醒体属性，强化指令卡的效果。在唤醒体技能界面点击下一级可以预览升级后的效果。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_30.png"
      }),
      readonly({
        Desc = "Tutorial_17852_Desc_2|不同界域的唤醒体需要不同的<TutorialHighlight:技能升级素材>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_03.png"
      })
    })
  },
  [81372] = {
    ID = 81372,
    CnID = "教程@唤醒体启灵激活",
    BaseSortID = 18,
    data_list = readonly({
      readonly({
        BaseSortID = 18,
        Type = "System",
        Title = "Tutorial_81372_Title_1|启灵激活",
        Desc = "Tutorial_81372_Desc_1|<TutorialHighlight:启灵激活>可以极大的提升唤醒体的指令卡效果。启灵等级7级可以解锁<TutorialHighlight:超限爆发>，使唤醒体狂气爆发时获得额外效果。启灵等级11级和15级可以提高5级的唤醒体等级上限",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_29.png"
      })
    })
  },
  [17815] = {
    ID = 17815,
    CnID = "教程@启灵激活",
    BaseSortID = 19,
    data_list = readonly({
      readonly({
        BaseSortID = 19,
        Type = "System",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {"TopBarItem", "AwakerChip"},
        Title = "Tutorial_17815_Title_1|残片",
        Desc = "Tutorial_17815_Desc_1|重复获得唤醒体会将其转化为<TutorialHighlight:残片>。消耗<TutorialHighlight:残片>提升唤醒体启灵等级，可以使唤醒体的技能获得额外的特殊能力。唤醒体启灵等级已满时再获得对应残片，将转化为<TutorialHighlight:灵魂回溯碎片>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_29.png"
      })
    })
  },
  [17845] = {
    ID = 17845,
    CnID = "教程@派遣",
    BaseSortID = 20,
    data_list = readonly({
      readonly({
        BaseSortID = 20,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17075},
        Title = "Tutorial_17845_Title_1|派遣",
        Desc = "Tutorial_17845_Desc_1|派遣唤醒体完成研究任务，完成后可以获得相应的奖励。派遣唤醒体<TutorialHighlight:总等级>越高，奖励越丰富，最高按240总等级计算。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_27.png"
      })
    })
  },
  [17813] = {
    ID = 17813,
    CnID = "教程@重现",
    BaseSortID = 21,
    data_list = readonly({
      readonly({
        BaseSortID = 21,
        Type = "System",
        TriggerTimeType = "FirstUnlockReappear",
        Title = "Tutorial_17813_Title_1|重现",
        Desc = "Tutorial_17813_Desc_1|「融蚀之墟」、「禁忌纂录」、「超验存在」中关卡通关后，该关卡与更低难度的关卡可以进行<TutorialHighlight:重现>。通过<TutorialHighlight:重现>可以快速获得关卡奖励。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_28.png"
      })
    })
  },
  [81370] = {
    ID = 81370,
    CnID = "教程@唤醒体回溯",
    BaseSortID = 22,
    data_list = readonly({
      readonly({
        BaseSortID = 22,
        Type = "System",
        Title = "Tutorial_81370_Title_1|唤醒体回溯",
        Desc = "Tutorial_81370_Desc_1|<TutorialHighlight:唤醒体回溯>可以返还唤醒体的各种养成消耗。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_05.png"
      }),
      readonly({
        Desc = "Tutorial_81370_Desc_2|<TutorialHighlight:养成回溯>将会重置唤醒体的等级、升格、技能、灵知深化状态，消耗的材料和金券均会全数返还。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_06.png"
      }),
      readonly({
        Desc = "Tutorial_81370_Desc_3|<TutorialHighlight:启灵回溯>将会重置唤醒体的启灵状态，并重置启灵带来的等级上限，消耗的材料会全数返还。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_07.png"
      }),
      readonly({
        Desc = "Tutorial_81370_Desc_4|<TutorialHighlight:黑池归还>将会包含「养成回溯」的效果，还会额外将唤醒体本身也重置，变为未解锁状态。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Jp_08.png"
      })
    })
  },
  [17818] = {
    ID = 17818,
    CnID = "教程@灵知增幅器",
    BaseSortID = 23,
    data_list = readonly({
      readonly({
        BaseSortID = 23,
        Type = "System",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {
          "Material",
          "FastPromotion"
        },
        Title = "Tutorial_17818_Title_1|灵知增幅器",
        Desc = "Tutorial_17818_Desc_1|获得后可在<TutorialHighlight:物资中使用>，能按照预设值快速提升唤醒体等级和技能等级。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_55.png"
      })
    })
  },
  [17807] = {
    ID = 17807,
    CnID = "教程@密契",
    BaseSortID = 24,
    data_list = readonly({
      readonly({
        BaseSortID = 24,
        Type = "System",
        TriggerTimeType = "FirstGetSpecifiedItemType",
        TriggerTimePara = {"Trinket", "Trinket"},
        Title = "Tutorial_17807_Title_1|密契",
        Desc = "Tutorial_17807_Desc_1|为唤醒体提供多种属性，若组成<TutorialHighlight:套装>还会有特殊效果。共有6个部位，不同部位的<TutorialHighlight:主属性>不同，暴击率和暴击伤害会出现在I、II、III部位；狂气回充等级和银钥充能等级会出现在I、IV、V部位；界域精通和黑印掉落会出现在II、IV、VI部位；伤害强效和死亡抵抗会出现在III、V、VI部位。可以通过密契完成度来较为直观的感受密契与密契套装的强度。密契完成度可以通过升级与转录的方式进行强化。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_33.png"
      })
    })
  },
  [22247] = {
    ID = 22247,
    CnID = "教程@密契升级",
    BaseSortID = 25,
    data_list = readonly({
      readonly({
        BaseSortID = 25,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {16980},
        Title = "Tutorial_22247_Title_1|密契升级",
        Desc = "Tutorial_22247_Desc_1|<TutorialHighlight:密契升级>可以提升密契的属性强度，最高升至12级。密契分解可以获得对应的残本，在物资中进行材料置换可以获得<TutorialHighlight:千面印章>。密契升级需消耗<TutorialHighlight:千面印章>，分解已升级的密契也会返还升级消耗的<TutorialHighlight:千面印章>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_32.png"
      })
    })
  },
  [22248] = {
    ID = 22248,
    CnID = "教程@密契转录",
    BaseSortID = 26,
    data_list = readonly({
      readonly({
        BaseSortID = 26,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17043},
        Title = "Tutorial_22248_Title_1|密契转录",
        Desc = "Tutorial_22248_Desc_1|通过转录可以使<TutorialHighlight:密契>获得随机种类和强度的属性，副词条属性与部位无关，可能出现暴击率、暴击伤害、狂气回充等级、银钥充能等级、界域精通、黑印掉落、伤害强效、死亡抵抗这8种。在转录时，如果想要保留某项属性，可以选择<TutorialHighlight:锁定>，锁定的属性在转录时将不会发生变化。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_31.png"
      })
    })
  },
  [126878] = {
    ID = 126878,
    CnID = "教程@终极启灵",
    BaseSortID = 27,
    data_list = readonly({
      readonly({
        BaseSortID = 27,
        Type = "System",
        TriggerTimeType = "FirstGetMaxPotency",
        Title = "Tutorial_126878_Title_1|最终法则",
        Desc = "Tutorial_126878_Desc_1|部分唤醒体的人格深化达到 +12 时自动获得「最终法则」效果，每个唤醒体所获得的效果都有所不同。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_98.png",
        Prompt = 1
      }),
      readonly({
        Title = "Tutorial_126878_Title_2|专属讯息",
        Desc = "Tutorial_126878_Desc_2|唤醒体的「最终法则」解锁后，会收到一条相应唤醒体专属的通讯器讯息，请守密人记得查收。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_99.png"
      })
    })
  },
  [148475] = {
    ID = 148475,
    CnID = "教程@彼此为我",
    BaseSortID = 28,
    data_list = readonly({
      readonly({
        BaseSortID = 28,
        Type = "System",
        TriggerTimeType = "FirstGetPrestigeCard",
        Title = "Tutorial_148475_Title_1|彼此为我",
        Desc = "Tutorial_148475_Desc_1|唤醒体同调率达到 <TutorialHighlight:Lv20> 后，可获得专属 <TutorialHighlight:曜闪>。"
      }),
      readonly({
        Desc = "Tutorial_148475_Desc_2|<TutorialHighlight:曜闪>是你与唤醒体彼此为我的证明。"
      }),
      readonly({
        Desc = "Tutorial_148475_Desc_3|现在，该唤醒体的指令卡在战斗中将会特别呈现，并可在社交场合向其他守密人展示。"
      })
    })
  },
  [20771] = {
    ID = 20771,
    CnID = "教程@无光之境",
    BaseSortID = 29,
    data_list = readonly({
      readonly({
        BaseSortID = 29,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {16970},
        Title = "Tutorial_20771_Title_1|无光之境",
        Desc = "Tutorial_20771_Desc_1|<TutorialHighlight:无光之境>包含四个界域的系列关卡，通关后可以获得银芯、灵知制剂等奖励，累计星级达到指定要求后还可以额外获得银芯、无垢之芯等奖励！",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_02.png"
      }),
      readonly({
        Desc = "Tutorial_20771_Desc_2|不同界域的间隙关卡，会对调查队伍中的唤醒体界域做出要求， <TutorialHighlight:满足要求>的队伍才可以进行调查。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_54.png"
      })
    })
  },
  [17808] = {
    ID = 17808,
    CnID = "教程@幻梦深潜",
    BaseSortID = 30,
    data_list = readonly({
      readonly({
        BaseSortID = 30,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {16972},
        Title = "Tutorial_17808_Title_1|幻梦深潜",
        Desc = "Tutorial_17808_Desc_1|<TutorialHighlight:幻梦深潜>玩法中，每次挑战关卡会随机进入一张地图。挑战成功后，根据挑战的关卡难度、强化唤醒体与关卡内评分项获得相应积分。 每周挑战会有不同的初始造物与强化唤醒体。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_60.png"
      }),
      readonly({
        Desc = "Tutorial_17808_Desc_2|幻梦深潜通常每 28 天会更新赛季，在赛季内通关一次幻梦深潜即可参与<TutorialHighlight:赛季排行>，赛季结束时将会结算排名，并通过邮箱发送排名奖励。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_61.png"
      }),
      readonly({
        Desc = "Tutorial_17808_Desc_3|「深潜纪录」设立有多个目标，达成后可获得相应奖励。每次完成「深潜纪录」目标或深潜挑战胜利后都可获得<TutorialHighlight:深潜经验>。深潜经验达到一定值时<TutorialHighlight:深潜等级>会提升，可以获得丰富的奖励。可以通过界面左下角的「深潜纪录」与「深潜等级」进行查看。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_62.png"
      })
    })
  },
  [17831] = {
    ID = 17831,
    CnID = "教程@禁忌纂录",
    BaseSortID = 31,
    data_list = readonly({
      readonly({
        BaseSortID = 31,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {16985},
        Title = "Tutorial_17831_Title_1|禁忌纂录",
        Desc = "Tutorial_17831_Desc_1|战胜<TutorialHighlight:禁忌纂录>中的敌人，可以获得提升唤醒体能力的<TutorialHighlight:密契>。每通关一章主线会解锁新的<TutorialHighlight:禁忌纂录>关卡。密契还可以通过商店进行兑换。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_38.png"
      })
    })
  },
  [17817] = {
    ID = 17817,
    CnID = "教程@超验存在",
    BaseSortID = 32,
    data_list = readonly({
      readonly({
        BaseSortID = 32,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17072},
        Title = "Tutorial_17817_Title_1|超验存在",
        Desc = "Tutorial_17817_Desc_1|战胜<TutorialHighlight:超验存在>中的敌人，可以获得高阶的<TutorialHighlight:技能升级素材>，每周可以获取1次奖励。各种材料还可以在<TutorialHighlight:冶炼室>进行合成和置换。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_37.png"
      })
    })
  },
  [47538] = {
    ID = 47538,
    CnID = "教程@融灾禁区",
    BaseSortID = 33,
    data_list = readonly({
      readonly({
        BaseSortID = 33,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {25256},
        Title = "Tutorial_47538_Title_1|融灾禁区",
        Desc = "Tutorial_47538_Desc_1|融灾禁区是一个难度较高的玩法系统。守密人需要灵活搭配多个挑战队伍，尽可能地获取更多的特训值，从而获得更多的奖励。高警戒难度除了敌方单位变得更强，还会具有各种减益效果。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_66.png"
      }),
      readonly({
        Desc = "Tutorial_47538_Desc_2|在融灾禁区中有其独特的限制法则：同一唤醒体和钥令、同名命轮无法重复上场，守密人可以根据初始造物、怪物和推荐等级，灵活选择本次挑战的队伍，采用田忌赛马的策略尽可能获得更多的特训值。通过<TutorialHighlight:助战>方式上阵的唤醒体不受该限制影响。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_67.png"
      })
    })
  },
  [54392] = {
    ID = 54392,
    CnID = "教程@赛季（相位对弈）",
    BaseSortID = 34,
    data_list = readonly({
      readonly({
        BaseSortID = 34,
        Type = "System",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {128099},
        Title = "Tutorial_54392_Title_1|赛季",
        Desc = "Tutorial_54392_Desc_1|在一些特殊玩法中会有<TutorialHighlight:赛季>玩法，在赛季期间参与特殊玩法的排行榜即可在赛季结束时根据排行结算奖励。\n随着调查行动进度的推进，未来会有更多玩法参与<TutorialHighlight:赛季>玩法。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_92.png"
      }),
      readonly({
        Desc = "Tutorial_54392_Desc_2|每个赛季期间都会有<TutorialHighlight:赛季任务>，完成赛季任务即可领取丰富的奖励，赛季任务将会在赛季刷新时重置。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_100.png"
      })
    })
  },
  [17832] = {
    ID = 17832,
    CnID = "教程@超维",
    BaseSortID = 35,
    data_list = readonly({
      readonly({
        BaseSortID = 35,
        Type = "Battle",
        TriggerTimeType = "FirstFormDimensionTeam",
        Title = "Tutorial_17832_Title_1|超维",
        Desc = "Tutorial_17832_Desc_1|超维队伍每回合打出的<TutorialHighlight:第 1 张>指令卡的临时复制会进入<TutorialHighlight:超维空间>并触发强大的跃迁效果。当超维空间达到上限时，获得 1 个额外的<TutorialHighlight:超维回合>，<TutorialHighlight:超维回合能触发所有跃迁效果>。玩好超维队伍的基础秘诀：仔细规划每回合打出的第 1 张牌。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_24.png"
      })
    })
  },
  [17848] = {
    ID = 17848,
    CnID = "教程@深海",
    BaseSortID = 36,
    data_list = readonly({
      readonly({
        BaseSortID = 36,
        Type = "Battle",
        TriggerTimeType = "FirstFormOceanTeam",
        Title = "Tutorial_17848_Title_1|深海",
        Desc = "Tutorial_17848_Desc_1|深海队伍战斗开始时生成 1 条<TutorialHighlight:触腕>，<TutorialHighlight:触腕>在回合结束时攻击前排敌人，可以通过触腕图标下方的算式了解当前的触腕伤害和攻击次数。部分唤醒体可以提升触腕数量和触腕伤害，在回合结束时造成大量的伤害。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_26.png"
      })
    })
  },
  [17837] = {
    ID = 17837,
    CnID = "教程@血肉",
    BaseSortID = 37,
    data_list = readonly({
      readonly({
        BaseSortID = 37,
        Type = "Battle",
        TriggerTimeType = "FirstFormBloodTeam",
        Title = "Tutorial_17837_Title_1|血肉",
        Desc = "Tutorial_17837_Desc_1|血肉队伍的<TutorialHighlight:胚胎融合>达到上限时将会获得  1 张<TutorialHighlight:「胚胎」>，释放狂气爆发会消耗<TutorialHighlight:「胚胎」>触发强大<TutorialHighlight:吞噬>效果，因此尽可能地在手牌中有<TutorialHighlight:「胚胎」>时释放狂气爆发，否则无法发挥血肉队伍的最大实力。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_25.png"
      }),
      readonly({
        Desc = "Tutorial_17837_Desc_2|每场战斗结束后会积攒5%最大生命的回复量进入猩红熔炉，若有未使用的<TutorialHighlight:「胚胎」>，每个胚胎也会积攒5%最大生命的回复量进入熔炉。 猩红熔炉可用于回复我方队伍的生命，每回合可以转化熔炉为生命1次。守密人需合理规划猩红熔炉的使用时机，从而达到扭转战局的效果。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_65.png"
      })
    })
  },
  [17823] = {
    ID = 17823,
    CnID = "教程@混沌",
    BaseSortID = 38,
    data_list = readonly({
      readonly({
        BaseSortID = 38,
        Type = "Battle",
        TriggerTimeType = "FirstFormChaosTeam",
        Title = "Tutorial_17823_Title_1|混沌",
        Desc = "Tutorial_17823_Desc_1|混沌唤醒体可以<TutorialHighlight:突破界域限制>与其他界域的唤醒体编队，并且会有不同的共生效果。任意队伍中如果存在混沌唤醒体，可以额外获得 100% 死亡抵抗。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_23.png"
      }),
      readonly({
        Desc = "Tutorial_17823_Desc_2|相较于其他界域的队伍，混沌界域队伍获得银钥能量的速度更快，且释放第二次钥令时，能够在所有钥令中进行选择，并且选择的钥令会触发 2 次。因此混沌界域队伍更依赖与钥令间的协作，选择合适的钥令可以极大增强混沌界域队伍的实力！",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_63.png"
      })
    })
  },
  [17844] = {
    ID = 17844,
    CnID = "教程@力量",
    BaseSortID = 39,
    data_list = readonly({
      readonly({
        BaseSortID = 39,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {
          2900,
          3130,
          3095
        },
        Title = "Tutorial_17844_Title_1|力量",
        Desc = "Tutorial_17844_Desc_1|每拥有 1 点<TutorialHighlight:力量>，每次造成主动伤害时将额外提升 1 点伤害。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_22.png"
      })
    })
  },
  [17824] = {
    ID = 17824,
    CnID = "教程@戒备",
    BaseSortID = 40,
    data_list = readonly({
      readonly({
        BaseSortID = 40,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {
          2715,
          2403,
          3868
        },
        Title = "Tutorial_17824_Title_1|戒备",
        Desc = "Tutorial_17824_Desc_1|每拥有 1 点<TutorialHighlight:戒备>，每次获得护盾时将额外获得 1 点护盾。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_21.png"
      })
    })
  },
  [17843] = {
    ID = 17843,
    CnID = "教程@反击",
    BaseSortID = 41,
    data_list = readonly({
      readonly({
        BaseSortID = 41,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {3905, 3023},
        Title = "Tutorial_17843_Title_1|反击",
        Desc = "Tutorial_17843_Desc_1|受到攻击时，对攻击者造成等同于<TutorialHighlight:反击>层数的伤害。<TutorialHighlight:反击>伤害<TutorialHighlight:无法暴击>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_20.png"
      })
    })
  },
  [17811] = {
    ID = 17811,
    CnID = "教程@中毒",
    BaseSortID = 42,
    data_list = readonly({
      readonly({
        BaseSortID = 42,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {3068},
        Title = "Tutorial_17811_Title_1|中毒",
        Desc = "Tutorial_17811_Desc_1|处于<TutorialHighlight:中毒>状态的目标在回合结束时，受到等同于<TutorialHighlight:中毒>层数的伤害。<TutorialHighlight:中毒>伤害<TutorialHighlight:无法暴击>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_19.png"
      })
    })
  },
  [17822] = {
    ID = 17822,
    CnID = "教程@出血",
    BaseSortID = 43,
    data_list = readonly({
      readonly({
        BaseSortID = 43,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {2840},
        Title = "Tutorial_17822_Title_1|出血",
        Desc = "Tutorial_17822_Desc_1|处于<TutorialHighlight:出血>状态的目标在回合结束时，受到等同于<TutorialHighlight:出血>层数的伤害然后<TutorialHighlight:移除出血状态>。\n<TutorialHighlight:回复生命>时移除等同于<TutorialHighlight:回复量 2 倍>的出血层数。出血伤害<TutorialHighlight:无法暴击>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_18.png"
      })
    })
  },
  [17812] = {
    ID = 17812,
    CnID = "教程@易伤",
    BaseSortID = 44,
    data_list = readonly({
      readonly({
        BaseSortID = 44,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {2934},
        Title = "Tutorial_17812_Title_1|易伤",
        Desc = "Tutorial_17812_Desc_1|处于<TutorialHighlight:易伤>状态的目标，受到的伤害提升 50% ，回合结束时自动移除 1 层<TutorialHighlight:易伤>。利用敌人处于<TutorialHighlight:易伤>状态的时机，对其造成更多伤害。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_17.png"
      })
    })
  },
  [17830] = {
    ID = 17830,
    CnID = "教程@虚弱",
    BaseSortID = 45,
    data_list = readonly({
      readonly({
        BaseSortID = 45,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {3469},
        Title = "Tutorial_17830_Title_1|虚弱",
        Desc = "Tutorial_17830_Desc_1|处于<TutorialHighlight:虚弱>状态的目标，造成的伤害降低 25% ，回合结束时自动移除 1 层<TutorialHighlight:虚弱>。若我方队伍处于<TutorialHighlight:虚弱>状态，记得在进攻前想办法移除<TutorialHighlight:虚弱>状态，或者改变策略，在本回合中全力防守。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_16.png"
      })
    })
  },
  [17820] = {
    ID = 17820,
    CnID = "教程@脆弱",
    BaseSortID = 46,
    data_list = readonly({
      readonly({
        BaseSortID = 46,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {2564},
        Title = "Tutorial_17820_Title_1|脆弱",
        Desc = "Tutorial_17820_Desc_1|处于<TutorialHighlight:脆弱>状态的目标，获得的护盾降低 25% ，回合结束时自动移除 1 层<TutorialHighlight:脆弱>。若我方队伍处于<TutorialHighlight:脆弱>状态，记得在防守前想办法移除<TutorialHighlight:脆弱>状态，或者改变策略，在本回合中全力进攻。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_15.png"
      })
    })
  },
  [17829] = {
    ID = 17829,
    CnID = "教程@屏障",
    BaseSortID = 47,
    data_list = readonly({
      readonly({
        BaseSortID = 47,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {3638, 3589},
        Title = "Tutorial_17829_Title_1|屏障",
        Desc = "Tutorial_17829_Desc_1|每次受到伤害前，免疫伤害并移除 1 层<TutorialHighlight:屏障>。单次伤害越高，<TutorialHighlight:屏障>带来的收益越高。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_56.png"
      })
    })
  },
  [17828] = {
    ID = 17828,
    CnID = "教程@衰竭",
    BaseSortID = 48,
    data_list = readonly({
      readonly({
        BaseSortID = 48,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {
          3293,
          2619,
          3902
        },
        Title = "Tutorial_17828_Title_1|力量降低",
        Desc = "Tutorial_17828_Desc_1|<TutorialHighlight:力量>每降低 1 点，每次造成<TutorialHighlight:主动伤害>时将降低 1 点伤害。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_13.png"
      })
    })
  },
  [17826] = {
    ID = 17826,
    CnID = "教程@封印",
    BaseSortID = 49,
    data_list = readonly({
      readonly({
        BaseSortID = 49,
        Type = "Battle",
        TriggerTimeType = "FirstGetState",
        TriggerTimePara = {81341},
        Title = "Tutorial_17826_Title_1|狂气封印",
        Desc = "Tutorial_17826_Desc_1|我方队伍处于<TutorialHighlight:狂气封印>状态时，无法释放狂气爆发。在敌人即将造成<TutorialHighlight:狂气封印>前，可以释放狂气爆发避免浪费狂气。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_11.png"
      })
    })
  },
  [17814] = {
    ID = 17814,
    CnID = "教程@护盾",
    BaseSortID = 50,
    data_list = readonly({
      readonly({
        BaseSortID = 50,
        Type = "Battle",
        Title = "Tutorial_17814_Title_1|护盾",
        Desc = "Tutorial_17814_Desc_1|<TutorialHighlight:护盾>可以代替生命承担伤害，回合结束时<TutorialHighlight:自动移除>所有护盾，护盾的上限等于队伍的<TutorialHighlight:生命上限>。尽可能地<TutorialHighlight:让护盾等同于本回合所有敌人的伤害总量>，用最小的代价获得战斗胜利。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_12.png"
      })
    })
  },
  [17841] = {
    ID = 17841,
    CnID = "教程@狂气",
    BaseSortID = 51,
    data_list = readonly({
      readonly({
        BaseSortID = 51,
        Type = "Battle",
        Title = "Tutorial_17841_Title_1|狂气",
        Desc = "Tutorial_17841_Desc_1|通过指令卡可以让唤醒体获得<TutorialHighlight:狂气>，指令卡的技能等级越高，获得的狂气越多。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_09.png"
      })
    })
  },
  [17819] = {
    ID = 17819,
    CnID = "教程@狂气爆发",
    BaseSortID = 52,
    data_list = readonly({
      readonly({
        BaseSortID = 52,
        Type = "Battle",
        Title = "Tutorial_17819_Title_1|狂气爆发",
        Desc = "Tutorial_17819_Desc_1|当唤醒体狂气达到 <TutorialHighlight:100> 时可以释放<TutorialHighlight:狂气爆发>。不同唤醒体的狂气爆发效果不同，合理利用可以<TutorialHighlight:事半功倍>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_10.png"
      })
    })
  },
  [17816] = {
    ID = 17816,
    CnID = "教程@算力",
    BaseSortID = 53,
    data_list = readonly({
      readonly({
        BaseSortID = 53,
        Type = "Battle",
        Title = "Tutorial_17816_Title_1|算力",
        Desc = "Tutorial_17816_Desc_1|算力为<TutorialHighlight:全队共享>，打出卡牌需要消耗<TutorialHighlight:算力>。算力会在回合开始时<TutorialHighlight:自动恢复至上限>，在回合结束后<TutorialHighlight:自动清空>。为了提升算力利用效率，请尽量<TutorialHighlight:消耗所有算力后再结束回合>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_07.png"
      })
    })
  },
  [17833] = {
    ID = 17833,
    CnID = "教程@应急灵知体",
    BaseSortID = 54,
    data_list = readonly({
      readonly({
        BaseSortID = 54,
        Type = "Battle",
        Title = "Tutorial_17833_Title_1|应急灵知体",
        Desc = "Tutorial_17833_Desc_1|当我方队伍生命值耗尽时，可以启用<TutorialHighlight:应急灵知体>恢复所有状态。应急灵知体每天自动恢复 <TutorialHighlight:1 >个，上限 <TutorialHighlight:5 >个。合理地将应急灵知体应用在<TutorialHighlight:高难战斗>中，切勿随意浪费。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_08.png"
      })
    })
  },
  [17847] = {
    ID = 17847,
    CnID = "教程@死亡抵抗",
    BaseSortID = 55,
    data_list = readonly({
      readonly({
        BaseSortID = 55,
        Type = "Battle",
        Title = "Tutorial_17847_Title_1|死亡抵抗",
        Desc = "Tutorial_17847_Desc_1|受到致命伤害时，有<TutorialHighlight:等同于死亡抵抗的概率>免疫此伤害并保留 1 点生命，<TutorialHighlight:成功触发后死亡抵抗减半>。队伍的死亡抵抗等同于所有唤醒体死亡抵抗之和，提升队伍死亡抵抗有助于提升战斗时的容错率。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_06.png"
      })
    })
  },
  [17850] = {
    ID = 17850,
    CnID = "教程@手牌",
    BaseSortID = 56,
    data_list = readonly({
      readonly({
        BaseSortID = 56,
        Type = "Battle",
        Title = "Tutorial_17850_Title_1|手牌",
        Desc = "Tutorial_17850_Desc_1|打出手牌需消耗算力，回合结束时所有手牌将进入<TutorialHighlight:弃牌堆>。合理规划<TutorialHighlight:出牌顺序>将是战斗胜利的关键。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_57.png"
      })
    })
  },
  [17851] = {
    ID = 17851,
    CnID = "教程@敌方意图",
    BaseSortID = 57,
    data_list = readonly({
      readonly({
        BaseSortID = 57,
        Type = "Battle",
        Title = "Tutorial_17851_Title_1|敌方意图",
        Desc = "Tutorial_17851_Desc_1|代表敌人下回合即将要采取的行动，利用<TutorialHighlight:意图>进行本回合的决策是战斗的核心玩法。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_04.png"
      })
    })
  },
  [17805] = {
    ID = 17805,
    CnID = "教程@敌人状态",
    BaseSortID = 58,
    data_list = readonly({
      readonly({
        BaseSortID = 58,
        Type = "Battle",
        Title = "Tutorial_17805_Title_1|敌人状态",
        Desc = "Tutorial_17805_Desc_1|点击敌人可以查看它的所有状态。<TutorialHighlight:警示>状态需要更加重点关注，它代表敌人的特殊机制，守密人未能顺利完成调查的多数原因往往是未关注到敌人的特殊机制。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_53.png"
      })
    })
  },
  [17835] = {
    ID = 17835,
    CnID = "教程@敌方伤害总量",
    BaseSortID = 59,
    data_list = readonly({
      readonly({
        BaseSortID = 59,
        Type = "Battle",
        Title = "Tutorial_17835_Title_1|敌方伤害总量",
        Desc = "Tutorial_17835_Desc_1|代表所有敌人本回合的伤害总量。一条简单实用的守密人作战经验：<TutorialHighlight:尽可能让护盾等同于敌方伤害总量>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_05.png"
      })
    })
  },
  [20768] = {
    ID = 20768,
    CnID = "教程@银钥能量",
    BaseSortID = 60,
    data_list = readonly({
      readonly({
        BaseSortID = 60,
        Type = "Battle",
        Title = "Tutorial_20768_Title_1|银钥能量",
        Desc = "Tutorial_20768_Desc_1|唤醒体打出指令卡或灵知觉醒消耗算力时可以获得<TutorialHighlight:银钥能量>。唤醒体的<TutorialHighlight:银钥充能>属性可以提升获得的<TutorialHighlight:银钥能量>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_58.png"
      })
    })
  },
  [20772] = {
    ID = 20772,
    CnID = "教程@钥令",
    BaseSortID = 61,
    data_list = readonly({
      readonly({
        BaseSortID = 61,
        Type = "Battle",
        Title = "Tutorial_20772_Title_1|钥令",
        Desc = "Tutorial_20772_Desc_1|当银钥能量达到 <TutorialHighlight:1000> 时可以释放携带的<TutorialHighlight:钥令>。每回合可以释放 2 次钥令，但第二次释放钥令时会改为从 3 个随机钥令中选择 1 个释放，且选择的钥令在本次探索中无法再次被选择。在编队时为我方队伍选择合适的钥令，可以使调查过程更加顺利。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_03.png"
      })
    })
  },
  [74798] = {
    ID = 74798,
    CnID = "教程@关卡篇章",
    BaseSortID = 62,
    data_list = readonly({
      readonly({
        BaseSortID = 62,
        Type = "Battle",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {16972},
        Title = "Tutorial_74798_Title_1|关卡篇章",
        Desc = "Tutorial_74798_Desc_1|不同关卡会存在不同的 <TutorialHighlight:关卡篇章> 环境，大幅改变整体规则和造物效果。具体可在各个关卡界面点击相关页签查看。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_93.png"
      })
    })
  },
  [120371] = {
    ID = 120371,
    CnID = "教程@课时序逆行",
    BaseSortID = 63,
    data_list = readonly({
      readonly({
        BaseSortID = 63,
        Type = "Battle",
        TriggerTimeType = "FirstFightAfterBattlePassUnlocked",
        Title = "Tutorial_120371_Title_1|时序逆行",
        Desc = "Tutorial_120371_Desc_1|可在战斗中返回经历过的回合，可返回至战斗的前 25 回合中的任意一个回合。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_94.png"
      })
    })
  },
  [54706] = {
    ID = 54706,
    CnID = "教程@简介（相位对弈）",
    BaseSortID = 64,
    data_list = readonly({
      readonly({
        BaseSortID = 64,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54706_Title_1|对弈简介",
        Desc = "Tutorial_54706_Desc_1|<TutorialHighlight:相位对弈>是两人对抗游戏，双方使用各自预组队伍进行<TutorialHighlight:匹配对战>，在匹配时会就近匹配旗鼓相当的对手。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_68.png"
      }),
      readonly({
        Desc = "Tutorial_54706_Desc_2|通过对战可以获得<TutorialHighlight:预组经验>与<TutorialHighlight:轮选经验>，根据获得的经验，可以在<TutorialHighlight:预组等级>与<TutorialHighlight:轮选等级>中解锁<TutorialHighlight:一次性奖励>！",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_69.png"
      }),
      readonly({
        Desc = "Tutorial_54706_Desc_3|每赛季会根据积分排名获得<TutorialHighlight:头衔>，赛季结束时将会结算排名，并通过邮箱发送排名奖励。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_70.png"
      })
    })
  },
  [54390] = {
    ID = 54390,
    CnID = "教程@状态（相位对弈）",
    BaseSortID = 65,
    data_list = readonly({
      readonly({
        BaseSortID = 65,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54390_Title_1|状态",
        Desc = "Tutorial_54390_Desc_1|在<TutorialHighlight:相位对弈>模式中，战斗界面内敌我双方唤醒体所拥有的<TutorialHighlight:状态>都会显示在其生命及狂气的下方，点击即可查看具体的效果。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_73.png"
      }),
      readonly({
        Desc = "Tutorial_54390_Desc_2|属于<TutorialHighlight:正面状态>的如下（点击查看详情）：<TauntKeywords:嘲讽>、<PVPPowerIconKeywords:力量>、<EnergyStorageKeywords:蓄力>、<PVPProtectiveKeywords:屏障>、<PVPRetaliateIconKeywords:反击>、<ReinforceKeywords:加固>、<StrengthenKeywords:强化>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_75.png"
      }),
      readonly({
        Desc = "Tutorial_54390_Desc_3|属于<TutorialHighlight:负面状态>的如下（点击查看详情）：<PVPEntanglementKeywords:缠绕>、<PVPVulnerabilityIconKeywords:易伤>、<PVPSlowKeywords:迟缓>、<ComaKeywords:石化>、<DisarmKeywords:麻痹>、<PVPMethysisKeywords:中毒>、<PVPEmptinessKeywords:空虚>、<PVPBleedingKeywords:出血>、<PVPSeriousInjuryKeywords:重创>、<ComaKeywords:昏迷>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_76.png"
      })
    })
  },
  [54391] = {
    ID = 54391,
    CnID = "教程@词缀（相位对弈）",
    BaseSortID = 66,
    data_list = readonly({
      readonly({
        BaseSortID = 66,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54391_Title_1|词缀",
        Desc = "Tutorial_54391_Desc_1|在<TutorialHighlight:相位对弈>模式中，有些唤醒体的卡牌会有不同的<TutorialHighlight:词缀>效果，可以在<TutorialHighlight:收藏>系统中查看或战斗中长按卡牌查看。属于词缀的有（点击查看详情）：<PVPPenetrateKeywords:贯穿>、<PrepareKeywords:预备>、<PVPResurrectionKeywords:复活>、<PVPHoldingKeywords:持有>、<PhantomKeywords:幻影>、<PVPRaidKeywords:突袭>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_74.png"
      })
    })
  },
  [54398] = {
    ID = 54398,
    CnID = "教程@技能（相位对弈）",
    BaseSortID = 67,
    data_list = readonly({
      readonly({
        BaseSortID = 67,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54398_Title_1|技能",
        Desc = "Tutorial_54398_Desc_1|在<TutorialHighlight:相位对弈>模式中，每个唤醒体都有2张<TutorialHighlight:打击>牌，3张<TutorialHighlight:技能>牌。通常，不同的技能牌会有不同的算力消耗。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_77.png"
      })
    })
  },
  [54395] = {
    ID = 54395,
    CnID = "教程@狂气（相位对弈）",
    BaseSortID = 68,
    data_list = readonly({
      readonly({
        BaseSortID = 68,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54395_Title_1|狂气",
        Desc = "Tutorial_54395_Desc_1|在<TutorialHighlight:相位对弈>模式中，每个唤醒体也有<TutorialHighlight:狂气>以及<TutorialHighlight:狂气爆发>。可以通过使用<TutorialHighlight:打击>卡或特定<TutorialHighlight:技能>卡来获得狂气，受到伤害损失生命时也会获得狂气（每损失2%生命或等量护盾获得1点狂气），狂气满100后点击对应唤醒体即可选择释放狂气爆发。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_78.png"
      })
    })
  },
  [54394] = {
    ID = 54394,
    CnID = "教程@算力（相位对弈）",
    BaseSortID = 69,
    data_list = readonly({
      readonly({
        BaseSortID = 69,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54394_Title_1|算力",
        Desc = "Tutorial_54394_Desc_1|在<TutorialHighlight:相位对弈>模式中，在第1回合时双方都是3点<TutorialHighlight:算力>及上限，后手会补偿一张<TutorialHighlight:后发制人>卡牌。之后每回合开始时，算力上限及回复量都会增长1点直到10点。除自动增长外，也有其他手段可以提高或降低算力上限，算力上限达到10后再增加，则每1点溢出上限会替换为抽1张牌。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_79.png"
      })
    })
  },
  [54399] = {
    ID = 54399,
    CnID = "教程@手牌（相位对弈）",
    BaseSortID = 70,
    data_list = readonly({
      readonly({
        BaseSortID = 70,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54399_Title_1|手牌",
        Desc = "Tutorial_54399_Desc_1|在<TutorialHighlight:相位对弈>模式中，每回合自动抽牌数也是5张，默认<TutorialHighlight:手牌上限>也是10张，可以在战斗界面的右下角看到我方当前手牌数及手牌上限数，右上角看到对方的情况。可以通过其他方式来让每回合抽牌数及手牌上限发生变化。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_80.png"
      })
    })
  },
  [54393] = {
    ID = 54393,
    CnID = "教程@幻象（相位对弈）",
    BaseSortID = 71,
    data_list = readonly({
      readonly({
        BaseSortID = 71,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54393_Title_1|幻象",
        Desc = "Tutorial_54393_Desc_1|在<TutorialHighlight:相位对弈>模式中，唤醒体阵亡后，手牌中属于该唤醒体的卡牌会变为<TutorialHighlight:幻象>。将<TutorialHighlight:命轮>装备给已阵亡唤醒体也获得1张幻象，同时返还消耗的算力。幻象还可以被特定命轮的效果合成<TutorialHighlight:小小心愿>。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_81.png"
      })
    })
  },
  [54400] = {
    ID = 54400,
    CnID = "教程@定位（相位对弈）",
    BaseSortID = 72,
    data_list = readonly({
      readonly({
        BaseSortID = 72,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54400_Title_1|定位",
        Desc = "Tutorial_54400_Desc_1|在<TutorialHighlight:相位对弈>模式中，不同的唤醒体有不同的<TutorialHighlight:定位>，总共5个。具体分别是<TutorialHighlight:守护>、<TutorialHighlight:斗争>、<TutorialHighlight:灵智>、<TutorialHighlight:凶星>、<TutorialHighlight:祝福>。进行<TutorialHighlight:编队>时需要选出4名不同定位的唤醒体来组成队伍。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_83.png"
      })
    })
  },
  [54401] = {
    ID = 54401,
    CnID = "教程@编队（相位对弈）",
    BaseSortID = 73,
    data_list = readonly({
      readonly({
        BaseSortID = 73,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54401_Title_1|预组编队",
        Desc = "Tutorial_54401_Desc_1|在<TutorialHighlight:相位对弈-预组模式>中，点击界面右下角的「开始匹配」就会进入到编队界面。也可以在界面左侧的<TutorialHighlight:预组编队>中提前进行队伍构筑。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_84.png"
      }),
      readonly({
        Desc = "Tutorial_54401_Desc_2|编队预组支持保存多套，左上角还能编辑队伍名称，每支队伍由4名唤醒体，4件命轮，2件钥令组成。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_85.png"
      })
    })
  },
  [54396] = {
    ID = 54396,
    CnID = "教程@对弈纪录（相位对弈）",
    BaseSortID = 74,
    data_list = readonly({
      readonly({
        BaseSortID = 74,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54396_Title_1|对弈纪录",
        Desc = "Tutorial_54396_Desc_1|在<TutorialHighlight:相位对弈>模式中，在匹配对战中完成「对弈纪录」中的指定目标，可以领取对应的奖励。该奖励为一次性奖励，不随赛季重置，可以通过界面左下方的「对弈纪录」进行查看。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_86.png"
      })
    })
  },
  [54397] = {
    ID = 54397,
    CnID = "教程@收藏（相位对弈）",
    BaseSortID = 75,
    data_list = readonly({
      readonly({
        BaseSortID = 75,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54397_Title_1|收藏",
        Desc = "Tutorial_54397_Desc_1|在<TutorialHighlight:相位对弈>模式中，界面左侧的「收藏」页签内可以浏览全部唤醒体、命轮、钥令的信息。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_87.png"
      })
    })
  },
  [54705] = {
    ID = 54705,
    CnID = "教程@表情（相位对弈）",
    BaseSortID = 76,
    data_list = readonly({
      readonly({
        BaseSortID = 76,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_54705_Title_1|表情",
        Desc = "Tutorial_54705_Desc_1|在<TutorialHighlight:相位对弈>模式中，点击自己的<TutorialHighlight:头像>，选择想要发送的<TutorialHighlight:对战表情>，向你的对手表达心意吧！",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_71.png"
      })
    })
  },
  [124999] = {
    ID = 124999,
    CnID = "教程@轮选编队（相位对弈）",
    BaseSortID = 77,
    data_list = readonly({
      readonly({
        BaseSortID = 77,
        Type = "PVP",
        TriggerTimeType = "SystemUnlock",
        TriggerTimePara = {17054},
        Title = "Tutorial_124999_Title_1|轮选编队",
        Desc = "Tutorial_124999_Desc_1|在<TutorialHighlight:相位对弈-轮选模式>中，点击界面右下角的「开始匹配」进入匹配，无需预组队伍。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_95.png"
      }),
      readonly({
        Desc = "Tutorial_124999_Desc_2|对战前系统会随机选取一个<TutorialHighlight:造物>，在对战中生效。根据每局的造物效果，在随机出的有限选项的卡池中轮流选取所需的唤醒体、命轮、钥令，来构建自己的编队与对方进行对战。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_96.png"
      }),
      readonly({
        Desc = "Tutorial_124999_Desc_3|通过点击两个唤醒体进行位置互换，以此来调整自己队伍在对战中的站位。站位前后按1-4的顺序进行排列。",
        Picture = "UIResources/UIBigImages/UI_Large/UI_Large_Course_Bg/UI_Large_Course_Bg_97.png"
      })
    })
  }
})
return Tutorial
