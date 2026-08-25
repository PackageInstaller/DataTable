local UIDefine = {}
local UILayer = CS.FrameWork.UILayer
UIDefine.LayerEnum2Layer = {
  [UILayer.NormalRoot] = "NormalRoot",
  [UILayer.FixedRoot] = "FixedRoot",
  [UILayer.PopUpRoot] = "PopUpRoot",
  [UILayer.TipPopRoot] = "TipPopRoot",
  [UILayer.TopRoot] = "TopRoot"
}
UIDefine.LayerCfg = {
  NormalRoot = {
    name = "NormalRoot",
    goName = "NormalRoot",
    index = 1
  },
  FixedRoot = {
    name = "FixedRoot",
    goName = "FixedRoot",
    index = 2
  },
  PopUpRoot = {
    name = "PopUpRoot",
    goName = "PopUpRoot",
    index = 3
  },
  TipPopRoot = {
    name = "TipPopRoot",
    goName = "TipPopRoot",
    index = 5
  },
  TopRoot = {
    name = "TopRoot",
    goName = "TopRoot",
    index = 6
  }
}
UIDefine.ViewType = {
  FullScreenView = "FullScreenView",
  WindowView = "WindowView",
  ChildTabView = "ChildTabView"
}
UIDefine.IgnoreCountUrls = {
  Urls.NewbieGuideView,
  Urls.CommonCardKeyWorldDescPanel,
  Urls.FeatureUnlockPanel,
  Urls.FeatureBottomTipsPanel
}
UIDefine.ExceptUrls = {
  Urls.GmPanel,
  Urls.GmParamPanel,
  Urls.GmParamEquipPanel,
  Urls.GmEntryPanel,
  Urls.PvPMatchRstPanel,
  Urls.PvpPasswordWaitingView,
  Urls.PvpPasswordRoleListView,
  Urls.ReqMaskPanel,
  Urls.LoadingPanel,
  Urls.PopMsgPanel,
  Urls.PvPSelectCreationPanel,
  Urls.PVPReplayBattlePanel,
  Urls.PVEReplayBattlePanel
}
UIDefine.IgnoreTraceBack = {
  [Urls.FuncBattleCardDisplayPanel] = true
}
UIDefine.TouchEndCloseUrls = {
  [Urls.AlertToolTipsPanel] = {upCheck = true, dragCheck = true},
  [Urls.AlertIconToolTipsPanel] = {upCheck = true, dragCheck = false},
  [Urls.BuffListPanelNew] = {upCheck = true, dragCheck = true}
}
return UIDefine
