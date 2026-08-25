local UIChangeAudioUtils = {}
UIChangeAudioUtils.ChangeUI = {
  [Urls.MainPanel] = {
    [Urls.CopyMainView] = "ANIM_INTERFACE_TRANS_STORY_EXIT",
    [Urls.DungeonsMainView] = "ANIM_INTERFACE_TRANS_MATERIAL_EXIT",
    [Urls.BattlePassMainPanel] = "ANIM_INTERFACE_TRANS_TOPIC_EXIT",
    [Urls.TaskMainPanel] = "ANIM_INTERFACE_TRANS_NOTE_EXIT",
    [Urls.BagView] = "ANIM_INTERFACE_TRANS_OBJECT_EXIT",
    [Urls.SummonPanel] = "ANIM_INTERFACE_TRANS_AWAKING_EXIT",
    [Urls.MainShopPanel] = "ANIM_INTERFACE_TRANS_MYTHAGSTORE_EXIT",
    [Urls.AwakerBasePanel] = "ANIM_INTERFACE_TRANS_AWAKER_EXIT"
  }
}
UIChangeAudioUtils.PanelWwiseEvts = {
  [Urls.AlertConfirm2Panel] = {
    OpenEvent = "POPUP_CM_WND_CONFIRM_LV2_ON",
    CloseEvent = "POPUP_CM_WND_CONFIRM_LV2_OFF"
  },
  [Urls.PopMsgPanel] = {
    OpenEvent = "POPUP_CM_BAR_INFO_LV1"
  },
  [Urls.CommonillustrateView] = {
    OpenEvent = "POPUP_CM_WND_INFO_LV2_ON",
    CloseEvent = "POPUP_CM_WND_INFO_LV2_OFF"
  },
  [Urls.MailView] = {
    OpenEvent = "ANIM_MAILBOX_ENTER",
    CloseEvent = "ANIM_MAILBOX_EXIT"
  },
  [Urls.TutorialMainView] = {
    OpenEvent = "Set_State_Aa_Interface_Tutorial"
  },
  [Urls.TaskDispatchView] = {
    OpenEvent = "Set_State_Aa_Interface_Dispatch"
  },
  [Urls.BattlePassMainPanel] = {
    OpenEvent = "Set_State_Aa_Interface_Lab"
  },
  [Urls.AwakerBasePanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_AWAKER"
  },
  [Urls.DungeonsMainView] = {
    OpenEvent = "SET_STATE_A_INTERFACE_MATERIAL"
  },
  [Urls.MainShopPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_STORE_EXCHANGE"
  },
  [Urls.TaskMainPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_NOTE"
  },
  [Urls.BagView] = {
    OpenEvent = "SET_STATE_A_INTERFACE_OBJECT"
  },
  [Urls.CopyMainView] = {
    OpenEvent = "SET_STATE_A_INTERFACE_STORY"
  },
  [Urls.MainCopyChapterPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_STORY"
  },
  [Urls.MainShopPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_STORE_MYTHAG"
  },
  [Urls.SummonPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_AWAKING"
  },
  [Urls.AnnouncementPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_PINBOARD"
  },
  [Urls.SettingMainPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_SETTING"
  },
  [Urls.SettingMainPanel] = {
    OpenEvent = "SET_STATE_A_INTERFACE_SETTING"
  },
  [Urls.WorldStageCardPanelEx] = {
    OpenEvent = "SET_STATE_A_FT_CARDVIEW",
    CloseEvent = "SET_STATE_A_FT_CARDVIEW_END"
  },
  [Urls.BattleCardPanel] = {
    OpenEvent = "SET_STATE_A_FT_CARDVIEW",
    CloseEvent = "SET_STATE_A_FT_CARDVIEW_END"
  },
  [Urls.ChargeMainPanel] = {
    OpenEvent = "Set_State_Aa_Interface_Store_Charge"
  },
  [Urls.MainPanel] = {
    OpenEvent = "MAININTERFACE_MUSIC"
  },
  [Urls.MainPanelPVP] = {
    OpenEvent = "Set_State_Aa_Interface_PVP"
  },
  [Urls.ActivityMainPanel] = {
    OpenEvent = "Set_State_Aa_Interface_Welfare"
  },
  [Urls.TeamTrinketEquipView] = {
    OpenEvent = "UI_AWAKER_COVENANT_PAGE_ENTER"
  },
  [Urls.PvPMatchRstPanel] = {
    OpenEvent = "Play_Trans_PVP_Battleinfo_Enter"
  },
  [Urls.ArtCollectionView] = {
    OpenEvent = "Set_State_Aa_Interface_Library"
  },
  [Urls.ArtCollectionStoryView] = {
    OpenEvent = "Set_State_Aa_Interface_Library"
  },
  [Urls.OrganizationListView] = {
    OpenEvent = "Set_State_Aa_Interface_Library"
  },
  [Urls.OrganizationDetailView] = {
    OpenEvent = "Set_State_Aa_Interface_Library"
  },
  [Urls.ArtCollectionOSTView] = {
    OpenEvent = "Set_State_Aa_Interface_Library"
  },
  [Urls.ArtCollectionCGView] = {
    OpenEvent = "Set_State_Aa_Interface_Library"
  },
  [Urls.ArtCollectionOSTMusicView] = {
    OpenEvent = "Set_State_Aa_Interface_OST"
  }
}

function UIChangeAudioUtils.GetEventByUrl(url)
  local eventCfg = UIChangeAudioUtils.PanelWwiseEvts[url]
  if eventCfg then
    return eventCfg
  end
  return nil
end

function UIChangeAudioUtils.GetOpenEventByUrl(url)
  local eventCfg = UIChangeAudioUtils.PanelWwiseEvts[url]
  if eventCfg and eventCfg.OpenEvent then
    return eventCfg.OpenEvent
  end
  return nil
end

function UIChangeAudioUtils.GetCloseEventByUrl(url)
  local eventCfg = UIChangeAudioUtils.PanelWwiseEvts[url]
  if eventCfg and eventCfg.CloseEvent then
    return eventCfg.CloseEvent
  end
  return nil
end

return UIChangeAudioUtils
