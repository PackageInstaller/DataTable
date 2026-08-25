local FeatureId = CommonDefine.FeatureId
local MainPanelDefine = {}
MainPanelDefine.BtnCfg = {
  Btn_MQ = {
    Name = "Btn_MQ",
    PanelUrls = Urls.CopyMainView,
    ChildItems = {
      {
        ChildItemName = "Text_MQ",
        TextFunc = "GetCurMainCopyNameFirst"
      },
      {
        ChildItemName = "Text_MQ_Level",
        LangId = nil,
        TextFunc = "GetCurMainCopyNameSecond"
      }
    }
  },
  Btn_Dbg = {
    PanelUrls = Urls.DungeonsMainView,
    FeatureId = FeatureId.DBGCopyGroup,
    LockUI = "Group_Dbg_Lock",
    BtnClickFunc = nil,
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Dbg",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetDbgRedValue"
      }
    }
  },
  Btn_Pvp = {
    PanelUrls = Urls.MainPanelPVP,
    FeatureId = FeatureId.PVP,
    LockUI = "Group_Pvp_Lock",
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Pvp",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetPVPRedValue"
      }
    }
  },
  Btn_Awaker = {
    PanelUrls = Urls.AwakerBasePanel,
    ChildItems = {
      {
        ChildItemName = "Group_Shop_Lock",
        VisbleFunc = "GetShopLocked"
      },
      {
        ChildItemName = "Com_RedDot_Awaker",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetAwakerRedValue"
      }
    }
  },
  Btn_Mission = {
    PanelUrls = Urls.TaskMainPanel,
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Mission",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetMissionRedValue"
      }
    }
  },
  Btn_Password = {AlertID = 10389},
  Btn_Diving = {
    BtnClickFunc = "OnBtnDiving",
    FeatureId = FeatureId.DailyChallenge,
    LockUI = "Group_Diving_Lock"
  },
  Btn_Abyss = {
    BtnClickFunc = "OnBtnAbyss",
    FeatureId = FeatureId.AbyssChallenge,
    LockUI = "Group_Abyss_Lock",
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Abyss",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetAbyssRedValue"
      }
    }
  },
  Btn_Lesson = {
    BtnClickFunc = "OnBtnBp",
    FeatureId = FeatureId.BattlePass,
    LockUI = "Group_Lesson_Lock",
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Lesson",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetBpRedValue"
      }
    }
  },
  Btn_GamePassport = {
    BtnClickFunc = "OnBtnPassport"
  },
  Btn_Recall = {
    BtnClickFunc = "OnBtnRecall",
    FeatureId = FeatureId.Activity,
    LockUI = "Group_Recall_Lock"
  },
  Btn_Collection = {
    BtnClickFunc = "OnBtnCollection",
    FeatureId = FeatureId.CollectionHall,
    LockUI = "Group_Collection_Lock"
  },
  Btn_Bag = {
    PanelUrls = Urls.BagView,
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Bag",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetBagRedValue"
      }
    }
  },
  Btn_Store = {
    BtnClickFunc = "OnBtnStore",
    FeatureId = FeatureId.Shop,
    LockUI = "Group_Store_Lock"
  },
  Btn_DungeonNote = {
    BtnClickFunc = "OnBtnDungeonNote",
    FeatureId = FeatureId.GuideNote,
    LockUI = "Group_DungeonNote_Lock"
  },
  Btn_Recruit = {
    PanelUrls = Urls.SummonPanel,
    FeatureId = FeatureId.DrawCard,
    LockUI = "Group_Recruit_Lock",
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Recruit",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetSummonRedValue"
      }
    }
  },
  Btn_Publicity = {
    PanelUrls = Urls.SummonPanel,
    FeatureId = FeatureId.DrawCard
  },
  Btn_Settings = {
    PanelUrls = Urls.SettingMainPanel,
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Mailbox",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetMailBoxRedValue"
      }
    }
  },
  Btn_Friends = {
    BtnClickFunc = "OnBtnSocial",
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Social",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetSocialRedValue"
      }
    }
  },
  Btn_Guest = {BtnClickFunc = "OnBtnGuest"},
  Btn_Notice = {
    BtnClickFunc = "OnBtnNotice"
  },
  Btn_Mailbox = {
    PanelUrls = Urls.MailView,
    FeatureId = FeatureId.Mail,
    LockUI = "Group_Mailbox_Lock",
    ChildItems = {
      {
        ChildItemName = "Com_RedDot_Mailbox",
        ChildClsName = "UI.Common.RedDotComponent",
        ChildClsValueFunc = "GetMailBoxRedValue"
      }
    }
  },
  Btn_Click = {
    BtnClickFunc = "OnClickPlayerLevel"
  },
  Btn_Activity = {
    BtnClickFunc = "OnBtnActivity",
    FeatureId = FeatureId.Activity,
    LockUI = "Group_Activity_Lock"
  },
  Btn_Address = {
    FeatureId = FeatureId.Communicator,
    LockUI = "Group_Address_Lock",
    SkipBindButton = true
  }
}
MainPanelDefine.ItemUICfg = {
  {
    ChildItemName = "Text_Player_Name",
    TextFunc = "GetRoleName"
  },
  {
    ChildItemName = "Image_Player_Level_Progress",
    FillAmoutFunc = "GetExpFillAmount"
  },
  {
    ChildItemName = "Text_Awaker_Name",
    TextFunc = "GetAwakerName"
  },
  {
    ChildItemName = "Text_Player_Level",
    TextFunc = "GetPlayerLevel"
  },
  {
    ChildItemName = "Text_ATK",
    TextFunc = "GetPlayerATK"
  },
  {ChildItemName = "Text_Exp", TextFunc = "GetExp"}
}
return MainPanelDefine
