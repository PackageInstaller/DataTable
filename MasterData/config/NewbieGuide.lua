local System = require("System.System")
local readonly = System.readonly
local NewbieGuide = readonly({
  [81502] = {
    ID = 81502,
    CnID = "新手引导@初次唤醒",
    BaseSortID = 1,
    data_list = readonly({
      readonly({
        BaseSortID = 1,
        Name = "唤醒指引1",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        Unlock = {1, 7998},
        End = {1, 8128},
        TriggerPriority = 1,
        ViewName = "MainPanel",
        NodeName = "UI_Main_Panel_1(Clone).Btn_Recruit",
        Content = "NewbieGuide_81502_Content_1|平安回来了呢，做得很好，守密人。为了之后的行动更加顺利，现在请来到黑池中，使用银芯链接一些新的伙伴吧。"
      }),
      readonly({
        Name = "唤醒指引2",
        IsForcible = 1,
        GuideDirection = "GO_RIGHT",
        ViewName = "SummonPanel",
        NodeName = "GuideGo_NormalSummonBtn"
      }),
      readonly({
        Name = "唤醒指引3",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        ViewName = "GuidePanel_NormalSummon",
        NodeName = "GuideGo_SummonFiveBtn",
        Content = "NewbieGuide_81502_Content_3|这次链接使用的银芯会由校方提供，点击唤醒按钮，尝试一口气唤醒五次吧！",
        ContentOffset = {0, 60}
      }),
      readonly({
        Name = "唤醒指引4",
        IsForcible = 1,
        GuideDirection = "GO_DOWN",
        ViewName = "UI.Summon.Panel.SummonedAwakerPanel",
        NodeName = "UI_Summon_Popup_Total_Show(Clone).UI_Common_Btn_Back3.Image_Icon",
        KeyNode = true,
        Content = "NewbieGuide_81502_Content_4|确认结果后，就可以离开了。"
      }),
      readonly({
        Name = "唤醒指引5",
        IsForcible = 1,
        GuideDirection = "GO_DOWN",
        ViewName = "SummonPanel",
        NodeName = "UI_Summon_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon",
        Content = "NewbieGuide_81502_Content_5|下次获得足够的银芯之后，再来进行唤醒吧。"
      })
    })
  },
  [81499] = {
    ID = 81499,
    CnID = "新手引导@唤醒体升级",
    BaseSortID = 2,
    data_list = readonly({
      readonly({
        BaseSortID = 2,
        Name = "唤醒体升级1",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        Unlock = {1, 7998},
        End = {1, 8128},
        TriggerPriority = 2,
        ViewName = "MainPanel",
        NodeName = "UI_Main_Panel_1(Clone).Btn_Awaker",
        Content = "NewbieGuide_81499_Content_1|积累了经验与资源后，记得及时提升唤醒体的等级，以应对更危险的敌人，点击唤醒体按钮。",
        MinRequirementSkip = 1
      }),
      readonly({
        Name = "唤醒体升级2",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        ViewName = "AwakerBasePanel",
        NodeName = "GuideGo_EnterAwakerDetailBtn",
        Content = "NewbieGuide_81499_Content_2|进入唤醒体详情界面。",
        ContentOffset = {0, 60}
      }),
      readonly({
        Name = "唤醒体升级3",
        IsForcible = 0,
        GuideDirection = "GO_UP",
        ViewName = "GuidePanel_AwakerInfoDetail",
        NodeName = "UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Info.Btn_Level_Up",
        KeyNode = true,
        Content = "NewbieGuide_81499_Content_3|进入升级界面。",
        ContentOffset = {0, 60}
      }),
      readonly({
        Name = "唤醒体升级4",
        IsForcible = 0,
        GuideDirection = "GO_CENTER",
        ViewName = "GuidePanel_AwakerLevelDetail",
        NodeName = "UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Topped_DetailUp.UI_Awaker_Button_Addition",
        Content = "NewbieGuide_81499_Content_4|点击自动置入，就可以放入最大化的资源。"
      }),
      readonly({
        Name = "唤醒体升级5",
        IsForcible = 0,
        GuideDirection = "GO_UP",
        ViewName = "GuidePanel_AwakerLevelDetail",
        NodeName = "UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Topped_DetailUp.Btn_Breakthrough.Group_High",
        Content = "NewbieGuide_81499_Content_5|点击升级，唤醒体的力量就会变得更加强大。",
        ContentOffset = {0, 60}
      }),
      readonly({
        Name = "唤醒体升级6",
        IsForcible = 0,
        GuideDirection = "GO_DOWN",
        NodeName = "GuideGo_AwakerLvUpBackBtn",
        Content = "NewbieGuide_81499_Content_6|做得很好，等到满足新的条件后，再来升级吧。"
      }),
      readonly({
        Name = "唤醒体升级7",
        IsForcible = 0,
        GuideDirection = "GO_DOWN",
        ViewName = "GuidePanel_AwakerInfoDetail",
        NodeName = "GuideGo_AwakerBackBtn",
        Content = "NewbieGuide_81499_Content_7|合理分配手中的资源，培养适合的唤醒体，组织起自己的王牌队伍吧！"
      }),
      readonly({
        Name = "唤醒体升级8",
        IsForcible = 0,
        GuideDirection = "GO_CENTER",
        ViewName = "AwakerBasePanel",
        NodeName = "GuideGo_AwakerCloseBtn",
        Content = "NewbieGuide_81499_Content_8|唤醒体升级的方法就是这样，现在返回宿舍，好好准备之后的任务吧。"
      })
    })
  },
  [81500] = {
    ID = 81500,
    CnID = "新手引导@编队",
    BaseSortID = 3,
    data_list = readonly({
      readonly({
        BaseSortID = 3,
        Name = "编队1",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        Unlock = {1, 7998},
        End = {
          1,
          8128,
          3,
          "TeamFormationCompleted",
          3,
          "ThreeOrMoreSchoolAwaker"
        },
        TriggerPriority = 3,
        ViewName = "MainPanel",
        NodeName = "UI_Main_Panel_1(Clone).Btn_Formation",
        Content = "NewbieGuide_81500_Content_1|为了在战斗时快速集合，守密人可以将常用的唤醒体组合保存成固定的编队，点击进入编队界面。",
        MinRequirementSkip = 1
      }),
      readonly({
        Name = "编队2",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        ViewName = "DBGTeamBuildMainPanel",
        NodeName = "UI_Team_Panel_Main(Clone).Btn_Fast.Group_High.bg",
        Content = "NewbieGuide_81500_Content_2|点击快速编队。",
        ContentOffset = {0, 40}
      }),
      readonly({
        Name = "编队3",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "GuidePanel_QuickTeamBuild",
        NodeName = "GuideGo_QuickBuildAwaker1",
        Content = "NewbieGuide_81500_Content_3|选择队伍中的四位成员。"
      }),
      readonly({
        Name = "编队4",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "GuidePanel_QuickTeamBuild",
        NodeName = "GuideGo_QuickBuildAwaker2"
      }),
      readonly({
        Name = "编队5",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "GuidePanel_QuickTeamBuild",
        NodeName = "GuideGo_QuickBuildAwaker3"
      }),
      readonly({
        Name = "编队6",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "GuidePanel_QuickTeamBuild",
        NodeName = "GuideGo_QuickBuildAwaker4"
      }),
      readonly({
        Name = "编队7",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        ViewName = "DBGTeamBuildMainPanel",
        NodeName = "GuideGo_QuickSaveBtn",
        KeyNode = true,
        Content = "NewbieGuide_81500_Content_7|保存你熟悉的队伍。",
        ContentOffset = {0, 40}
      })
    })
  },
  [81501] = {
    ID = 81501,
    CnID = "新手引导@命轮",
    BaseSortID = 4,
    data_list = readonly({
      readonly({
        BaseSortID = 4,
        Name = "命轮1",
        IsForcible = 1,
        GuideDirection = "GO_LEFT",
        Unlock = {1, 7998},
        End = {1, 8128},
        TriggerPriority = 4,
        ViewName = "DBGTeamBuildMainPanel",
        NodeName = "GuideGo_AwakerWeapon1",
        Content = "NewbieGuide_81501_Content_1|在固定的编队中，也可以提前确定成员们所携带的命轮，点击第一个唤醒体的命轮空位。",
        MinRequirementSkip = 1
      }),
      readonly({
        Name = "命轮2",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "TeamWeaponEquipView",
        NodeName = "GuideGo_EquipWeapon1",
        Content = "NewbieGuide_81501_Content_2|选择你想要为其装备的命轮。"
      }),
      readonly({
        Name = "命轮3",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        ViewName = "TeamWeaponEquipView",
        NodeName = "GuideGo_EquipWeaponSave",
        KeyNode = true,
        Content = "NewbieGuide_81501_Content_3|点击装备，保存固定的命轮配置。"
      }),
      readonly({
        Name = "命轮4",
        IsForcible = 0,
        GuideDirection = "GO_DOWN",
        ViewName = "TeamWeaponEquipView",
        NodeName = "GuideGo_EquipWeaponClose",
        Content = "NewbieGuide_81501_Content_4|好了，准备完全，这样在作战时就可以让大家一键出击了。"
      })
    })
  },
  [81504] = {
    ID = 81504,
    CnID = "新手引导@钥令",
    BaseSortID = 5,
    data_list = readonly({
      readonly({
        BaseSortID = 5,
        Name = "钥令1",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        Unlock = {1, 7998},
        End = {1, 8128},
        TriggerPriority = 5,
        ViewName = "DBGTeamBuildMainPanel",
        NodeName = "UI_Team_Panel_Main(Clone).Btn_Skill",
        Content = "NewbieGuide_81504_Content_1|这一次来为队伍配置合适的钥令吧，不同的钥令可以让守密人的银钥匙爆发出不同的力量，点击钥令按钮。",
        ContentOffset = {0, 70},
        MinRequirementSkip = 1
      }),
      readonly({
        Name = "钥令2",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "KeeperSkillView",
        NodeName = "UI_Keeper_Skill_Panel(Clone).UI_Keeper_Skill_Item(Clone)",
        Content = "NewbieGuide_81504_Content_2|选择你想要使用的钥令。"
      }),
      readonly({
        Name = "钥令3",
        IsForcible = 1,
        GuideDirection = "GO_UP",
        ViewName = "KeeperSkillView",
        NodeName = "GuideGo_KeeperSkillSave",
        KeyNode = true,
        Content = "NewbieGuide_81504_Content_3|确定选择的钥令。",
        ContentOffset = {0, 60}
      }),
      readonly({
        Name = "钥令4",
        IsForcible = 0,
        GuideDirection = "GO_CENTER",
        ViewName = "DBGTeamBuildMainPanel",
        NodeName = "UI_Team_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon",
        Content = "NewbieGuide_81504_Content_4|如果想要体验不同的银钥力量，可以随时来这里更换钥令，尝试不同的组合乐趣。"
      })
    })
  },
  [81503] = {
    ID = 81503,
    CnID = "新手引导@调查",
    BaseSortID = 6,
    data_list = readonly({
      readonly({
        BaseSortID = 6,
        Name = "调查1",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        Unlock = {1, 7998},
        End = {1, 8128},
        TriggerPriority = 6,
        ViewName = "MainPanel",
        NodeName = "UI_Main_Panel_1(Clone).Btn_MQ",
        Content = "NewbieGuide_81503_Content_1|面对融蚀，弥萨格的师生每时每刻都在肩负使命前行，到了出任务的时候了，守密人，点击进入调查界面。",
        MinRequirementSkip = 1
      }),
      readonly({
        Name = "调查2",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "CopyMainChapterView",
        NodeName = "GuideGo_BtnChapter1",
        Content = "NewbieGuide_81503_Content_2|这是你的第一个任务，也是你第一次正式面对敌人，如论如何，记住弥萨格与你同在。"
      }),
      readonly({
        Name = "调查3",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "MainCopyChapterPanel",
        NodeName = "UI_Chapter_Panel_Main(Clone).UI_Chaper_Item_Level_Content(Clone)",
        KeyNode = true,
        Content = "NewbieGuide_81503_Content_3|点击进入故事的第一个篇章，祝福你，守密人，愿银钥指引前路。"
      })
    })
  },
  [147749] = {
    ID = 147749,
    CnID = "新手引导@实战教学",
    BaseSortID = 7,
    data_list = readonly({
      readonly({
        BaseSortID = 7,
        Name = "实战教学1",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        Unlock = {1, 7982},
        End = {
          1,
          90490,
          1,
          94464,
          1,
          94465,
          1,
          94466
        },
        TriggerPriority = 7,
        ViewName = "MainPanel",
        NodeName = "UI_Main_Panel_1(Clone).Btn_Mission",
        Content = "NewbieGuide_147749_Content_1|守密人，弥萨格将你的指挥历程记录在学籍档案中。",
        MinRequirementSkip = 1
      }),
      readonly({
        Name = "实战教学2",
        IsForcible = 1,
        GuideDirection = "GO_CENTER",
        ViewName = "TaskCareerView",
        NodeName = "UI_Task_Panel_Main_New(Clone).Btn_Task7",
        Content = "NewbieGuide_147749_Content_2|实战教学中，可以体验各界域独特的效果。"
      }),
      readonly({
        Name = "实战教学3",
        IsForcible = -1,
        GuideDirection = "GO_UP",
        ViewName = "DungeonBattleTeachingView",
        NodeName = "UI_Dungeons_BattleTeaching_View.GuideRoot",
        KeyNode = true,
        Content = "NewbieGuide_147749_Content_3|今天先自由选择界域练习吧。"
      }),
      readonly({
        Name = "实战教学4",
        IsForcible = -1,
        GuideDirection = "GO_UP",
        ViewName = "DungeonBattleTeachingView",
        NodeName = "UI_Dungeons_BattleTeaching_View.Btn_Enter",
        Content = "NewbieGuide_147749_Content_4|想要训练的时候，就来这里吧。"
      })
    })
  }
})
return NewbieGuide
