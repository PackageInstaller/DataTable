local QuestCtrl = class("QuestCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
QuestCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgQuestBg = {},
  role_offset01 = {sComponentName = "Transform"},
  role_offset02 = {sComponentName = "Transform"},
  role_offset03 = {sComponentName = "Transform"},
  animImgQuestBg = {sNodeName = "imgQuestBg", sComponentName = "Animator"},
  animActor = {sNodeName = "Actor", sComponentName = "Animator"},
  animMaskRoot = {sNodeName = "MaskRoot", sComponentName = "Animator"},
  goWorldClassBg = {},
  bgChess = {},
  bgChessUpMask = {},
  bgLock = {},
  btnTab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgLock = {nCount = 4},
  tabUnlock = {nCount = 4},
  cvTabLayout = {
    nCount = 4,
    sNodeName = "layoutOff",
    sComponentName = "CanvasGroup"
  },
  imgOn = {nCount = 4},
  trTabOff = {
    sComponentName = "RectTransform"
  },
  trTabOn = {
    sComponentName = "RectTransform"
  },
  txtTabOn = {nCount = 4, sComponentName = "TMP_Text"},
  txtTabOff = {nCount = 4, sComponentName = "TMP_Text"},
  rtImgMoveBar = {
    sNodeName = "imgMoveBar",
    sComponentName = "RectTransform"
  },
  layoutOff = {nCount = 4},
  redDot = {nCount = 4},
  rtLevel = {},
  imgExpBar = {sComponentName = "Image"},
  txtExp = {sComponentName = "TMP_Text"},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_WorldClass_Level"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  rtGuideQuest = {
    sCtrlName = "Game.UI.Quest.GuideQuest.GuideQuestCtrl"
  },
  rtDailyQuest = {
    sCtrlName = "Game.UI.Quest.DailyQuest.DailyQuestCtrl"
  },
  rtWorldClass = {
    sCtrlName = "Game.UI.Quest.WorldClass.QuestWorldClassCtrl"
  },
  rtWeeklyQuest = {
    sCtrlName = "Game.UI.Quest.WeeklyQuest.WeeklyQuestCtrl"
  },
  animWorldClass = {
    sNodeName = "rtWorldClass",
    sComponentName = "Animator"
  },
  goAssistant = {
    sCtrlName = "Game.UI.Quest.Assistant.AssistantCtrl"
  }
}
QuestCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  [EventId.TourQuestReceived] = "OnEvent_TourQuestReceived",
  [EventId.TourGroupReceived] = "OnEvent_TourGroupReceived",
  [EventId.DailyQuestReceived] = "OnEvent_DailyQuestReceived",
  [EventId.DailyQuestActiveReceived] = "OnEvent_DailyQuestActiveReceived",
  [EventId.WeeklyQuestReceived] = "OnEvent_WeeklyQuestReceived",
  [EventId.WeeklyQuestActiveReceived] = "OnEvent_WeeklyQuestActiveReceived",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  [EventId.QuestDataRefresh] = "OnEvent_QuestDataRefresh",
  RefreshWorldClassBg = "OnEvent_RefreshWorldClassBg",
  DemonAdvanceSuccess = "OnEvent_DemonAdvanceSuccess",
  Guide_SelectQuestPage = "OnEvent_SelectQuestPage"
}
QuestCtrl._mapRedDotConfig = {
  [RedDotDefine.Task_Guide] = {sNodeName = "redDot", nNodeIndex = 1},
  [RedDotDefine.Task_Daily] = {sNodeName = "redDot", nNodeIndex = 2},
  [RedDotDefine.Task_Weekly] = {sNodeName = "redDot", nNodeIndex = 3},
  [RedDotDefine.WorldClass] = {sNodeName = "redDot", nNodeIndex = 4}
}
local MoveBarPos = {
  [1] = -497,
  [2] = -163,
  [3] = 163,
  [4] = 497
}
local functionType = {
  [1] = 0,
  [2] = GameEnum.OpenFuncType.DailyQuest,
  [3] = GameEnum.OpenFuncType.WeeklyQuest,
  [4] = 0
}
local l2dCfg = {
  [1] = {
    male = {
      path = "UI/Quest/L2D_Tour_Male.prefab",
      anim = {
        animIn = "tourguide_m_in",
        animIdle = "tourguide_m_idle"
      }
    },
    female = {
      path = "UI/Quest/L2D_Tour_Female.prefab",
      anim = {
        animIn = "tourguide_f_in",
        animIdle = "tourguide_f_idle"
      }
    }
  },
  [2] = {
    male = {
      path = "UI/Quest/L2D_Daily_Male.prefab",
      anim = {
        animIn = "dailyquest_m_in",
        animIdle = "dailyquest_m_idle"
      }
    },
    female = {
      path = "UI/Quest/L2D_Daily_Female.prefab",
      anim = {
        animIn = "dailyquest_f_in",
        animIdle = "dailyquest_f_idle"
      }
    }
  },
  [3] = {
    male = {
      path = "UI/Quest/L2D_Weekly_Male.prefab",
      anim = {
        animIn = "weeklyquest_m_in",
        animIdle = "weeklyquest_m_idle"
      }
    },
    female = {
      path = "UI/Quest/L2D_Weekly_Female.prefab",
      anim = {
        animIn = "weeklyquest_f_in",
        animIdle = "weeklyquest_f_idle"
      }
    }
  }
}

function QuestCtrl:InitTab()
  self._mapNode.rtImgMoveBar.localPosition = Vector3(MoveBarPos[self._panel.nCurTab], 4.5, 0)
  for i = 1, 4 do
    NovaAPI.SetTMPText(self._mapNode.txtTabOn[i], ConfigTable.GetUIText("QuestPanel_Tab_" .. i))
    NovaAPI.SetTMPText(self._mapNode.txtTabOff[i], ConfigTable.GetUIText("QuestPanel_Tab_" .. i))
    self._mapNode.imgOn[i]:SetActive(self._panel.nCurTab == i)
    self._mapNode.txtTabOn[i].gameObject:SetActive(self._panel.nCurTab == i)
    self._mapNode.layoutOff[i].gameObject:SetActive(self._panel.nCurTab ~= i)
  end
end

function QuestCtrl:RefreshTabUnlock()
  for i = 1, 4 do
    local nFuncType = functionType[i]
    local bUnlock = false
    if nFuncType == 0 then
      bUnlock = true
    else
      bUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType, false)
    end
    self._mapNode.imgLock[i].gameObject:SetActive(not bUnlock)
    self._mapNode.tabUnlock[i].gameObject:SetActive(bUnlock)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cvTabLayout[i], bUnlock and 1 or 0.5)
  end
end

function QuestCtrl:LoadL2d()
  if not self.bLoadL2d then
    self.bIsMale = PlayerData.Base:GetPlayerSex() == true
    self.tbL2DAnim = {}
    if self.bIsMale then
      self.role01 = self:CreatePrefabInstance(l2dCfg[1].male.path, self._mapNode.role_offset01)
      self.role02 = self:CreatePrefabInstance(l2dCfg[2].male.path, self._mapNode.role_offset02)
      self.role03 = self:CreatePrefabInstance(l2dCfg[3].male.path, self._mapNode.role_offset03)
      self.tbL2DAnim[1] = l2dCfg[1].male.anim
      self.tbL2DAnim[2] = l2dCfg[2].male.anim
      self.tbL2DAnim[3] = l2dCfg[3].male.anim
    else
      self.role01 = self:CreatePrefabInstance(l2dCfg[1].female.path, self._mapNode.role_offset01)
      self.role02 = self:CreatePrefabInstance(l2dCfg[2].female.path, self._mapNode.role_offset02)
      self.role03 = self:CreatePrefabInstance(l2dCfg[3].female.path, self._mapNode.role_offset03)
      self.tbL2DAnim[1] = l2dCfg[1].female.anim
      self.tbL2DAnim[2] = l2dCfg[2].female.anim
      self.tbL2DAnim[3] = l2dCfg[3].female.anim
    end
    if self.role01 and self.role02 then
      self.roleModle01 = self.role01.transform:Find("root/----live2d_modle----").transform:GetChild(0)
      self.roleModle02 = self.role02.transform:Find("root/----live2d_modle----").transform:GetChild(0)
      self.roleModle03 = self.role03.transform:Find("root/----live2d_modle----").transform:GetChild(0)
    end
  end
  self.bLoadL2d = true
end

function QuestCtrl:RefreshWorldClass()
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevel, nWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtExp, string.format("%d/%d", nCurExp, nFullExp))
  NovaAPI.SetImageFillAmount(self._mapNode.imgExpBar, nCurExp / nFullExp)
  local tbWorldClass = CacheTable.Get("_DemonAdvance")
  local mapData = tbWorldClass[#tbWorldClass]
  local bMax = mapData.nMaxLevel == nWorldClass
  self._mapNode.txtExp.gameObject:SetActive(not bMax)
end

function QuestCtrl:RefreshContent()
  self._mapNode.rtGuideQuest.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.GuideQuest)
  self._mapNode.rtDailyQuest.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.DailyQuest)
  self._mapNode.rtWorldClass.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.WorldClass)
  self._mapNode.rtWeeklyQuest.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.WeeklyQuest)
  self._mapNode.goWorldClassBg.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.WorldClass)
  self._mapNode.rtLevel.gameObject:SetActive(self._panel.nCurTab ~= AllEnum.QuestPanelTab.WorldClass)
  self._mapNode.goAssistant.gameObject:SetActive(self._panel.nCurTab ~= AllEnum.QuestPanelTab.WorldClass)
  self.role01.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.GuideQuest)
  self.role02.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.DailyQuest)
  self.role03.gameObject:SetActive(self._panel.nCurTab == AllEnum.QuestPanelTab.WeeklyQuest)
  if self._panel.nCurTab == AllEnum.QuestPanelTab.GuideQuest then
    self._mapNode.rtGuideQuest:Refresh(self.mapGuideQuest, self.nCurGuideGroup)
    if self.nLastTab == AllEnum.QuestPanelTab.WorldClass then
      self.animRoot:Play("QuestPanel_switch2", 0, 0)
    end
    self._mapNode.animImgQuestBg:Play("imgQuestBg_in", 0, 0)
    self._mapNode.animActor:Play("Actor_in", 0, 0)
    self._mapNode.animMaskRoot:Play("MaskRoot_in", 0, 0)
    Actor2DManager.PlayL2DAnim(self.roleModle01.transform, self.tbL2DAnim[1].animIn, false, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  elseif self._panel.nCurTab == AllEnum.QuestPanelTab.DailyQuest then
    self._mapNode.rtDailyQuest:Refresh(self.tbDailyQuest)
    if self.nLastTab == AllEnum.QuestPanelTab.WorldClass then
      self.animRoot:Play("QuestPanel_switch2", 0, 0)
    end
    self._mapNode.animImgQuestBg:Play("imgQuestBg_in", 0, 0)
    self._mapNode.animActor:Play("Actor_in", 0, 0)
    self._mapNode.animMaskRoot:Play("MaskRoot_in", 0, 0)
    Actor2DManager.PlayL2DAnim(self.roleModle02.transform, self.tbL2DAnim[2].animIn, false, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  elseif self._panel.nCurTab == AllEnum.QuestPanelTab.WorldClass then
    local curType = self._mapNode.rtWorldClass:Refresh() or 0
    local sAnimName = curType == AllEnum.WorldClassType.Advance and "rtWorldClass_switch1" or "rtWorldClass_in"
    self._mapNode.animWorldClass:Play(sAnimName, 0, 0)
    local nAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
      "QuestPanel_switch1"
    })
    self.animRoot:Play("QuestPanel_switch1", 0, 0)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  elseif self._panel.nCurTab == AllEnum.QuestPanelTab.WeeklyQuest then
    self._mapNode.rtWeeklyQuest:Refresh(self.tbWeeklyQuest)
    if self.nLastTab == AllEnum.QuestPanelTab.WorldClass then
      self.animRoot:Play("QuestPanel_switch2", 0, 0)
    end
    self._mapNode.animImgQuestBg:Play("imgQuestBg_in", 0, 0)
    self._mapNode.animActor:Play("Actor_in", 0, 0)
    self._mapNode.animMaskRoot:Play("MaskRoot_in", 0, 0)
    Actor2DManager.PlayL2DAnim(self.roleModle03.transform, self.tbL2DAnim[3].animIn, false, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  end
  self.nLastTab = self._panel.nCurTab
end

function QuestCtrl:RefreshQuestList()
  local tbDaily, mapGuide, tbWeekly = PlayerData.Quest:GetAllQuestData()
  self.mapGuideQuest = {}
  self.tbDailyQuest = tbDaily
  self.tbWeeklyQuest = tbWeekly
  local curGuideGroup = PlayerData.Quest:GetCurTourGroup()
  if curGuideGroup == 0 then
    print("无当前任务组 手册任务可能已全部完成")
  end
  self.nCurGuideGroup = curGuideGroup
  for _, v in pairs(mapGuide) do
    local mapCfg = ConfigTable.GetData("TourGuideQuest", v.nTid)
    if mapCfg ~= nil and mapCfg.Order == curGuideGroup then
      table.insert(self.mapGuideQuest, v)
    end
  end
  if self._panel.nCurTab == AllEnum.QuestPanelTab.GuideQuest then
    self._mapNode.rtGuideQuest:Refresh(self.mapGuideQuest, curGuideGroup)
  elseif self._panel.nCurTab == AllEnum.QuestPanelTab.DailyQuest then
    self._mapNode.rtDailyQuest:Refresh(self.tbDailyQuest)
  elseif self._panel.nCurTab == AllEnum.QuestPanelTab.WeeklyQuest then
    self._mapNode.rtWeeklyQuest:Refresh(self.tbWeeklyQuest)
  end
end

function QuestCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function QuestCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function QuestCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nJumpTab = 0
  if nil ~= next(tbParam) then
    nJumpTab = tbParam[1]
  end
  local tbDaily, mapGuide, tbWeekly = PlayerData.Quest:GetAllQuestData()
  self.tbDailyQuest = tbDaily
  self.tbWeeklyQuest = tbWeekly
  self.mapGuideQuest = {}
  local curGuideGroup = PlayerData.Quest:GetCurTourGroup()
  if curGuideGroup == 0 then
    print("无当前任务组 手册任务可能已全部完成")
  end
  self.nCurGuideGroup = curGuideGroup
  local nMaxGuideGroup = PlayerData.Quest:GetMaxTourGroup()
  if mapGuide ~= nil then
    for _, v in pairs(mapGuide) do
      local mapCfg = ConfigTable.GetData("TourGuideQuest", v.nTid)
      if mapCfg ~= nil and mapCfg.Order == curGuideGroup then
        table.insert(self.mapGuideQuest, v)
      end
    end
  end
  local bAllGuideReward = false
  if self.nCurGuideGroup == nMaxGuideGroup then
    bAllGuideReward = true
    for _, v in ipairs(self.mapGuideQuest) do
      if v.nStatus ~= 2 then
        bAllGuideReward = false
        break
      end
    end
    local mapGroupCfg = ConfigTable.GetData("TourGuideQuestGroup", nMaxGuideGroup)
    if mapGroupCfg ~= nil then
      local bGroupReward = PlayerData.Quest:CheckTourGroupReward(mapGroupCfg.Order)
      bAllGuideReward = bAllGuideReward and bGroupReward
    end
  end
  if self._panel.nCurTab == nil then
    local bDailyUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyQuest)
    local bWeeklyUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyQuest)
    local bDaily = RedDotManager.GetValid(RedDotDefine.Task_Daily) and bDailyUnlock
    local bWeekly = RedDotManager.GetValid(RedDotDefine.Task_Weekly) and bWeeklyUnlock
    local bTourGuide = RedDotManager.GetValid(RedDotDefine.Task_Guide)
    local bWorldClass = RedDotManager.GetValid(RedDotDefine.WorldClass)
    if bDaily then
      self._panel.nCurTab = AllEnum.QuestPanelTab.DailyQuest
    elseif bWeekly then
      self._panel.nCurTab = AllEnum.QuestPanelTab.WeeklyQuest
    elseif bTourGuide then
      self._panel.nCurTab = AllEnum.QuestPanelTab.GuideQuest
    elseif bWorldClass then
      self._panel.nCurTab = AllEnum.QuestPanelTab.WorldClass
    elseif bDailyUnlock then
      self._panel.nCurTab = AllEnum.QuestPanelTab.DailyQuest
    elseif bWeeklyUnlock then
      self._panel.nCurTab = AllEnum.QuestPanelTab.WeeklyQuest
    else
      self._panel.nCurTab = AllEnum.QuestPanelTab.GuideQuest
    end
  end
  self.nLastTab = 0
  if nJumpTab ~= 0 then
    self._panel.nCurTab = nJumpTab
  end
  local sAnimName = ""
  if self._panel.nCurTab == AllEnum.QuestPanelTab.GuideQuest or self._panel.nCurTab == AllEnum.QuestPanelTab.DailyQuest or self._panel.nCurTab == AllEnum.QuestPanelTab.WeeklyQuest then
    sAnimName = "QuestPanel_in1"
  else
    sAnimName = "QuestPanel_in2"
  end
  local nAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {sAnimName})
  self.animRoot:Play(sAnimName, 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  self:LoadL2d()
  self:InitTab()
  self:RefreshTabUnlock()
  self:RefreshWorldClass()
  self:RefreshContent()
end

function QuestCtrl:OnDisable()
  local sPath1 = self.bIsMale and l2dCfg[1].male.path or l2dCfg[1].female.path
  local sPath2 = self.bIsMale and l2dCfg[2].male.path or l2dCfg[2].female.path
  local sPath3 = self.bIsMale and l2dCfg[3].male.path or l2dCfg[3].female.path
  self:DestroyPrefabInstance(sPath1)
  self:DestroyPrefabInstance(sPath2)
  self:DestroyPrefabInstance(sPath3)
  self.bLoadL2d = false
end

function QuestCtrl:OnDestroy()
end

function QuestCtrl:OnBtnClick_Tab(btn, nIndex)
  if self._panel.nCurTab == nIndex then
    return
  end
  local nFuncType = functionType[nIndex]
  if nFuncType ~= 0 then
    local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType, true)
    if not bFuncUnlock then
      return
    end
  end
  self._mapNode.imgOn[self._panel.nCurTab]:SetActive(false)
  self._mapNode.rtImgMoveBar:DOLocalMoveX(MoveBarPos[nIndex], 0.1):SetUpdate(true)
  self._mapNode.txtTabOn[self._panel.nCurTab].gameObject:SetActive(false)
  self._mapNode.layoutOff[self._panel.nCurTab].gameObject:SetActive(true)
  self._mapNode.imgOn[nIndex]:SetActive(true)
  self._mapNode.txtTabOn[nIndex].gameObject:SetActive(true)
  self._mapNode.layoutOff[nIndex].gameObject:SetActive(false)
  self._panel.nCurTab = nIndex
  self:RefreshContent()
end

function QuestCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._panel._tbParam[1] = nil
  EventManager.Hit(EventId.CloesCurPanel)
end

function QuestCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._panel._tbParam[1] = nil
  PanelManager.Home()
end

function QuestCtrl:OnEvent_TourQuestReceived(mapRewardInfo, mapChangeInfo)
  local function refreshFunc()
    self:RefreshQuestList()
  end
  
  local function openWorldClassTip()
    local bOpenUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpenUpgrade then
      refreshFunc()
    end
    EventManager.Hit("Guide_CloseGuideQuestReward")
  end
  
  local mapTrans = PlayerData.Item:ProcessTransChangeInfo(mapChangeInfo)
  local tbQuestReward, tbQuestSpReward = PlayerData.Item:ProcessRewardDisplayItem(mapRewardInfo, mapTrans)
  local mapQuestReward = {tbReward = tbQuestReward, tbSpReward = tbQuestSpReward}
  UTILS.OpenReceiveByReward(mapQuestReward, openWorldClassTip)
end

function QuestCtrl:OnEvent_TourGroupReceived(mapRewardInfo, mapChangeInfo)
  local function refreshFunc()
    self:RefreshQuestList()
  end
  
  local function openWorldClassTip()
    local bOpenUpgrade = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpenUpgrade then
      refreshFunc()
    end
  end
  
  local mapTrans = PlayerData.Item:ProcessTransChangeInfo(mapChangeInfo)
  local tbQuestReward, tbQuestSpReward = PlayerData.Item:ProcessRewardDisplayItem(mapRewardInfo, mapTrans)
  local mapQuestReward = {tbReward = tbQuestReward, tbSpReward = tbQuestSpReward}
  UTILS.OpenReceiveByReward(mapQuestReward, openWorldClassTip)
end

function QuestCtrl:OnEvent_DailyQuestReceived(mapChangeInfo)
  local function refreshFunc()
    self:RefreshQuestList()
  end
  
  local function tipCallback()
    local bOpen = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpen then
      refreshFunc()
    end
  end
  
  UTILS.OpenReceiveByChangeInfo(mapChangeInfo, tipCallback)
end

function QuestCtrl:OnEvent_DailyQuestActiveReceived(tbReward)
  local function refreshFunc()
    self:RefreshQuestList()
  end
  
  local function tipCallback()
    local bOpen = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpen then
      refreshFunc()
    end
  end
  
  local mapReward = {tbReward = tbReward}
  UTILS.OpenReceiveByReward(mapReward, tipCallback)
end

function QuestCtrl:OnEvent_WeeklyQuestReceived(mapChangeInfo)
  local function refreshFunc()
    self:RefreshQuestList()
  end
  
  local function tipCallback()
    local bOpen = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpen then
      refreshFunc()
    end
  end
  
  UTILS.OpenReceiveByChangeInfo(mapChangeInfo, tipCallback)
end

function QuestCtrl:OnEvent_WeeklyQuestActiveReceived(tbReward)
  local function refreshFunc()
    self:RefreshQuestList()
  end
  
  local function tipCallback()
    local bOpen = PlayerData.Base:TryOpenWorldClassUpgrade(refreshFunc)
    if not bOpen then
      refreshFunc()
    end
  end
  
  local mapReward = {tbReward = tbReward}
  UTILS.OpenReceiveByReward(mapReward, tipCallback)
end

function QuestCtrl:OnEvent_UpdateWorldClass()
  self:RefreshWorldClass()
  self:RefreshTabUnlock()
end

function QuestCtrl:OnEvent_QuestDataRefresh(questType)
  if questType == "TourGuide" or questType == "Daily" or questType == "Weekly" then
    self:RefreshQuestList()
  end
end

function QuestCtrl:OnEvent_RefreshWorldClassBg(bLevelUp)
  self._mapNode.bgChess.gameObject:SetActive(bLevelUp)
  self._mapNode.bgChessUpMask.gameObject:SetActive(bLevelUp)
  self._mapNode.bgLock.gameObject:SetActive(not bLevelUp)
end

function QuestCtrl:OnEvent_DemonAdvanceSuccess()
  self._mapNode.goWorldClassBg.gameObject:SetActive(false)
  self._mapNode.goWorldClassBg.gameObject:SetActive(true)
  self._mapNode.animWorldClass:Play("rtWorldClass_switch2", 0, 0)
end

function QuestCtrl:OnEvent_SelectQuestPage(nIndex)
  self:OnBtnClick_Tab(nil, nIndex)
end

return QuestCtrl
