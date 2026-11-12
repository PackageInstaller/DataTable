local LevelMenuCtrl = class("LevelMenuCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local PlayerBoardData = PlayerData.Board
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local ClientManager = CS.ClientManager.Instance
local LimitWidth = 392
LevelMenuCtrl._mapNodeConfig = {
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  imgPanelBg = {},
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnHome = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Home"
  },
  rtPhone = {
    sNodeName = "imgPhoneBg",
    sComponentName = "RectTransform"
  },
  PhoneContent = {
    sComponentName = "RectTransform"
  },
  LevelMenu = {},
  SecondMenu = {},
  StarTower = {},
  Resource = {},
  animStarTower = {sNodeName = "StarTower", sComponentName = "Animator"},
  btnStarTower = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StarTower"
  },
  TMPStartowerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Startower"
  },
  goStarTowerHint = {},
  goStarTowerHintLayout = {
    sNodeName = "imgContentBg",
    sComponentName = "HorizontalLayoutGroup"
  },
  layoutElement = {
    sNodeName = "imgContentBg",
    sComponentName = "LayoutElement"
  },
  TMPStarTowerLeave = {sComponentName = "TMP_Text"},
  btnBuild = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Build"
  },
  txtBuild = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Build"
  },
  btnPreselection = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preselection"
  },
  txtPreselection = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Preselection"
  },
  btnResource = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Resource"
  },
  TMPDailyInstaceTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Resource"
  },
  redDotResource = {},
  TMPDailyInstanceEnergy1 = {sComponentName = "TMP_Text"},
  imgResourceIcon1_ = {nCount = 3, sComponentName = "Image"},
  imgResourceIcon2_ = {nCount = 3, sComponentName = "Image"},
  imgDoubleDrop = {},
  btnInfinity = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Infinity"
  },
  TMPInfinitytowerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_InfinityTower"
  },
  UnlockInfinity = {},
  LockInfinity = {},
  TMPCondInfinity = {sComponentName = "TMP_Text"},
  redDotInfinity = {},
  btnWeeklyCopies = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_WeeklyCopies"
  },
  UnlockWeeklyCopies = {},
  LockWeeklyCopies = {},
  TMPCondWeeklyCopies = {sComponentName = "TMP_Text"},
  TMPWeeklyCopiesTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_WeeklyCopies"
  },
  redDotWeeklyCopies = {},
  btnVampire = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Vampire"
  },
  LockVampire = {},
  TMPCondVampire = {sComponentName = "TMP_Text"},
  UnlockVampire = {},
  TMPVampireTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Vampire"
  },
  redDotVampire = {},
  btnScoreBoss = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ScoreBoss"
  },
  UnlockScoreBoss = {},
  LockScoreBoss = {},
  TMPCondScoreBoss = {sComponentName = "TMP_Text"},
  TMPScoreBossTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_ScoreBoss"
  },
  redDotScoreBoss = {},
  btnTraceHunt = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TraceHunt"
  },
  UnlockTraceHunt = {},
  TMPTraceHunttowerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_TraceHunt"
  },
  LockTraceHunt = {},
  TraceHuntCountBg = {},
  TMPCondTraceHunt = {sComponentName = "TMP_Text"},
  txtHuntCountNum = {sComponentName = "TMP_Text"},
  imgLastTime = {},
  iconHunt = {sComponentName = "Image"},
  redDotTraceHuntGift = {},
  btnSoldier = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Soldier"
  },
  UnlockSoldier = {},
  TMPSoldiertowerTitle = {sComponentName = "TMP_Text"},
  LockSoldier = {},
  TMPCondSoldier = {sComponentName = "TMP_Text"},
  redDotSoldier = {},
  imgCover = {nCount = 2, sComponentName = "Image"},
  imgGoodsRoot = {nCount = 2, sComponentName = "Animator"},
  imgGoods = {nCount = 2, sComponentName = "Image"},
  txtStarTowerName = {nCount = 2, sComponentName = "TMP_Text"},
  btnStarTowerGoto = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StarTowerGoto"
  },
  txtBtnStarTowerGoto = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_StarTower_Goto"
  },
  imgSkillInstanceBg = {},
  imgRogueBossBg = {},
  imgDailyInstanceBg = {},
  imgEquipmentInstanceBg = {},
  txtResourceName = {sComponentName = "TMP_Text"},
  txtResourceDesc = {sComponentName = "TMP_Text"},
  btnResourceGoto = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ResourceGoto"
  },
  txtResourceBtnGoto = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_Resource_Goto"
  },
  txtDoubleDrop = {sComponentName = "TMP_Text"},
  TMPTime = {nCount = 2, sComponentName = "TMP_Text"},
  goStarTower = {
    sNodeName = "---StarTower---",
    sCtrlName = "Game.UI.LevelMenuEx.LevelMenuStarTowerCtrl"
  },
  goResource = {
    sNodeName = "---Resource---",
    sCtrlName = "Game.UI.LevelMenuEx.LevelMenuResourceCtrl"
  },
  panelAnimator = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  animTransition = {
    sNodeName = "TransitionRoot",
    sComponentName = "Animator"
  },
  activityList = {
    sNodeName = "---Activity---"
  },
  btnActivityEntrance = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ActivityEntrance"
  },
  activityRedDot_ = {nCount = 3},
  activityRedDotNew_ = {nCount = 3}
}
LevelMenuCtrl._mapEventConfig = {
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy",
  [EventId.TransAnimInClear] = "OnEvent_TransAnimInClear",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  Guide_GetGoGridByGroupTheme = "GetGoGridByGroupTheme",
  SelectResourceInstance = "OnEvent_SelectResourceInstance",
  SelectStarTowerGroup = "OnEvent_SelectStarTowerGroup"
}
LevelMenuCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_ScoreBoss] = {
    sNodeName = "redDotScoreBoss"
  },
  [RedDotDefine.Map_Infinity] = {
    sNodeName = "redDotInfinity"
  },
  [RedDotDefine.Map_Resource] = {
    sNodeName = "redDotResource"
  },
  [RedDotDefine.VampireQuest] = {
    sNodeName = "redDotVampire"
  },
  [RedDotDefine.TraceHunt_Reward] = {
    sNodeName = "redDotTraceHuntGift"
  },
  [RedDotDefine.Soldier] = {
    sNodeName = "redDotSoldier"
  }
}
local sumHeight = 563
local phone_page_main = 1
local phone_page_starTower = 2
local phone_page_resource = 3
local showActType = {
  Group = 1,
  TrekkerVersus = 2,
  JointDrill = 3
}

function LevelMenuCtrl:RefreshResourceIcon()
  for k, v in ipairs(self._mapNode["imgResourceIcon" .. self.nCurResIconIndex .. "_"]) do
    if self.tbResourceIcon[k] ~= nil then
      local nRandom = self.tbResourceIcon[k].nLastIndex
      while nRandom == self.tbResourceIcon[k].nLastIndex do
        nRandom = math.random(1, #self.tbResourceIcon[k].iconList)
      end
      local sPath = self.tbResourceIcon[k].iconList[nRandom]
      self:SetPngSprite(v, sPath)
      self.tbResourceIcon[k].nLastIndex = nRandom
    end
  end
end

function LevelMenuCtrl:InitResourceIndex()
  if self.nSelectResourceType == 0 then
    for _, nType in ipairs(AllEnum.LevelMenuResourceList) do
      if PlayerData.Base:CheckFunctionUnlock(nType) then
        self.nSelectResourceType = nType
        break
      end
    end
  end
end

function LevelMenuCtrl:ChangePhonePage()
  if self._panel.panelType == phone_page_main then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenLevelMenuMain")
  end
  self._mapNode.LevelMenu.gameObject:SetActive(self._panel.panelType == phone_page_main)
  self._mapNode.SecondMenu.gameObject:SetActive(self._panel.panelType ~= phone_page_main)
  self._mapNode.StarTower.gameObject:SetActive(self._panel.panelType == phone_page_starTower)
  self._mapNode.Resource.gameObject:SetActive(self._panel.panelType == phone_page_resource)
  self._mapNode.goStarTower.gameObject:SetActive(self._panel.panelType == phone_page_starTower)
  self._mapNode.goResource.gameObject:SetActive(self._panel.panelType == phone_page_resource)
  self._mapNode.rawImgActor2D.gameObject:SetActive(self._panel.panelType == phone_page_main)
  self._mapNode.imgPanelBg.gameObject:SetActive(self._panel.panelType ~= phone_page_main)
end

function LevelMenuCtrl:RefreshEnergy()
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.TMPDailyInstanceEnergy1, nCurEnergy)
  self._mapNode.goResource:RefreshEnergy()
end

function LevelMenuCtrl:SelectResourceItem(nType)
  self._mapNode.imgDailyInstanceBg.gameObject:SetActive(nType == GameEnum.OpenFuncType.DailyInstance)
  self._mapNode.imgSkillInstanceBg.gameObject:SetActive(nType == GameEnum.OpenFuncType.SkillInstance)
  self._mapNode.imgRogueBossBg.gameObject:SetActive(nType == GameEnum.OpenFuncType.RegionBoss)
  self._mapNode.imgEquipmentInstanceBg.gameObject:SetActive(nType == GameEnum.OpenFuncType.CharGemInstance)
  local sName, sDesc = "", ""
  if nType == GameEnum.OpenFuncType.SkillInstance then
    sName = ConfigTable.GetUIText("LevelMenu_Skill")
    sDesc = ConfigTable.GetUIText("LevelMenu_Skill_Desc")
  elseif nType == GameEnum.OpenFuncType.RegionBoss then
    sName = ConfigTable.GetUIText("LevelMenu_Region")
    sDesc = ConfigTable.GetUIText("LevelMenu_Region_Desc")
  elseif nType == GameEnum.OpenFuncType.DailyInstance then
    sName = ConfigTable.GetUIText("LevelMenu_Time")
    sDesc = ConfigTable.GetUIText("LevelMenu_Time_Desc")
  elseif nType == GameEnum.OpenFuncType.CharGemInstance then
    sName = ConfigTable.GetUIText("LevelMenu_Equipment")
    sDesc = ConfigTable.GetUIText("LevelMenu_Equipment_Desc")
  end
  NovaAPI.SetTMPText(self._mapNode.txtResourceName, sName)
  NovaAPI.SetTMPText(self._mapNode.txtResourceDesc, sDesc)
  self._mapNode.txtDoubleDrop.gameObject:SetActive(false)
  if self.doubleActData ~= nil then
    local tbFuncType = self.doubleActData:GetDoubleFuncType()
    if table.indexof(tbFuncType, nType) > 0 then
      self._mapNode.txtDoubleDrop.gameObject:SetActive(true)
      local str = self.doubleActData:GetDropString()
      NovaAPI.SetTMPText(self._mapNode.txtDoubleDrop, str)
    end
  end
end

function LevelMenuCtrl:RefreshActivityList()
  if self.tbActivityShowList ~= nil then
    for index, v in ipairs(self.tbActivityShowList) do
      if v.countDownTimer ~= nil then
        v.countDownTimer:Cancel()
        if v.bRegisterNode then
          if v.nType == showActType.Group and v.data.actGroupData ~= nil then
            RedDotManager.UnRegisterNode(RedDotDefine.Activity_Group, {
              v.data.actGroupData:GetActGroupId()
            }, self._mapNode.activityRedDot_[index])
            RedDotManager.UnRegisterNode(RedDotDefine.Activity_Group, {
              v.data.actGroupData:GetActGroupId()
            }, self._mapNode.activityRedDotNew_[index])
          elseif v.nType == showActType.TrekkerVersus then
            RedDotManager.UnRegisterNode(RedDotDefine.TrekkerVersus, {
              v.data:GetActId()
            }, self._mapNode.activityRedDot_[index])
          end
        end
      end
      if v.countDownEnterTimer ~= nil then
        v.countDownEnterTimer:Cancel()
      end
    end
  end
  self.tbActivityShowList = {}
  local tbActGroupList = PlayerData.Activity:GetMainviewShowActivityGroup()
  for _, v in ipairs(tbActGroupList) do
    table.insert(self.tbActivityShowList, {
      nType = showActType.Group,
      data = v
    })
  end
  local tbActList = PlayerData.Activity:GetActivityList()
  for nId, v in pairs(tbActList) do
    if v:CheckActShow() then
      local nActType = v:GetActType()
      local actCfg = v:GetActCfgData()
      local bShow = actCfg ~= nil and actCfg.EnterRes ~= nil and actCfg.EnterRes ~= ""
      if nActType == GameEnum.activityType.JointDrill then
        local nChallengeStartTime = v:GetChallengeStartTime()
        local nChallengeEndTime = v:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        if bShow and nChallengeStartTime <= nCurTime and nChallengeEndTime > nCurTime then
          table.insert(self.tbActivityShowList, {
            nType = showActType.JointDrill,
            data = v
          })
        end
      elseif nActType == GameEnum.activityType.TrekkerVersus then
        local nChallengeStartTime = v:GetChallengeStartTime()
        local nChallengeEndTime = v:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        if bShow and nChallengeStartTime <= nCurTime and nChallengeEndTime > nCurTime then
          table.insert(self.tbActivityShowList, {
            nType = showActType.TrekkerVersus,
            data = v
          })
        end
      end
    end
  end
  table.sort(self.tbActivityShowList, function(a, b)
    return a.nType < b.nType
  end)
  for i = 1, 3 do
    local btnTrans = self._mapNode.btnActivityEntrance[i].gameObject.transform
    btnTrans.gameObject:SetActive(self.tbActivityShowList[i] ~= nil)
    if self.tbActivityShowList[i] ~= nil then
      do
        local imgEnd = btnTrans:Find("AnimRoot/imgEnd")
        local txtEnd = btnTrans:Find("AnimRoot/imgEnd/txtEnd"):GetComponent("TMP_Text")
        local imgActivityTime = btnTrans.transform:Find("AnimRoot/imgActivityTime")
        local imgOpenBg = btnTrans:Find("AnimRoot/imgBg"):GetComponent("Image")
        local imgMaskBg = btnTrans:Find("AnimRoot/imgBgMask"):GetComponent("Image")
        local txtActRemainTime = btnTrans:Find("AnimRoot/imgActivityTime/txtActivityTime"):GetComponent("TMP_Text")
        imgMaskBg.gameObject:SetActive(false)
        if self.tbActivityShowList[i].nType == showActType.Group then
          local actGroupData = self.tbActivityShowList[i].data
          local actGroupCfg = actGroupData:GetActGroupCfgData()
          local bOpened = actGroupData:CheckActivityGroupOpen()
          local isUnlock, txtLock = actGroupData:IsUnlock()
          local remainTime = actGroupData:GetActGroupRemainTime()
          local bShowCountDown = 0 < remainTime and remainTime <= 259200
          self:SetPngSprite(imgOpenBg, actGroupCfg.EnterRes)
          self:SetPngSprite(imgMaskBg, actGroupCfg.EnterRes)
          if bOpened and bShowCountDown then
            local strTime = self:RefreshTimeout(remainTime)
            NovaAPI.SetTMPText(txtActRemainTime, strTime)
            self.tbActivityShowList[i].countDownTimer = self:AddTimer(0, 1, function()
              if 0 < remainTime then
                local strTime = self:RefreshTimeout(remainTime)
                NovaAPI.SetTMPText(txtActRemainTime, strTime)
                remainTime = remainTime - 1
              else
                self.tbActivityShowList[i].countDownTimer:Cancel()
                imgEnd.gameObject:SetActive(true)
                imgActivityTime.gameObject:SetActive(false)
              end
            end, true, true, true)
          end
          local endEnterTime = actGroupData:GetActGroupEnterEndTime()
          local curTime = CS.ClientManager.Instance.serverTimeStamp
          endEnterTime = endEnterTime - curTime
          local strEndTime = self:RefreshExchangeTimeout(endEnterTime)
          NovaAPI.SetTMPText(txtEnd, strEndTime)
          self.tbActivityShowList[i].countDownEnterTimer = self:AddTimer(0, 1, function()
            if 0 < endEnterTime then
              local strTime = self:RefreshExchangeTimeout(endEnterTime)
              NovaAPI.SetTMPText(txtEnd, strTime)
              endEnterTime = endEnterTime - 1
            else
              self.tbActivityShowList[i].countDownEnterTimer:Cancel()
              btnTrans.gameObject:SetActive(false)
            end
          end, true, true, true)
          imgEnd.gameObject:SetActive(not bOpened)
          imgActivityTime.gameObject:SetActive(bOpened and bShowCountDown)
          imgMaskBg.gameObject:SetActive(not isUnlock)
          if isUnlock then
            self.tbActivityShowList[i].bRegisterNode = true
            do
              local HasRedDot = RedDotManager.GetValid(RedDotDefine.Activity_Group, {
                actGroupData:GetActGroupId()
              })
              local HasNew = RedDotManager.GetValid(RedDotDefine.Activity_GroupNew, {
                actGroupData:GetActGroupId()
              })
              self._mapNode.activityRedDot_[i].gameObject:SetActive(HasRedDot)
              self._mapNode.activityRedDotNew_[i].gameObject:SetActive(HasNew and not HasRedDot)
            end
          end
        elseif self.tbActivityShowList[i].nType == showActType.TrekkerVersus then
          local actData = self.tbActivityShowList[i].data
          local actCfg = actData:GetActCfgData()
          self:SetPngSprite(imgOpenBg, actCfg.EnterRes)
          imgEnd.gameObject:SetActive(false)
          imgActivityTime.gameObject:SetActive(false)
          local nActId = actData:GetActId()
          local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(nActId)
          RedDotManager.RegisterNode(RedDotDefine.TrekkerVersus, {nActGroupId, nActId}, self._mapNode.activityRedDot_[i], nil, nil, true)
          self._mapNode.activityRedDotNew_[i].gameObject:SetActive(false)
        elseif self.tbActivityShowList[i].nType == showActType.JointDrill then
          do
            local actCfg = self.tbActivityShowList[i].data:GetActCfgData()
            self:SetPngSprite(imgOpenBg, actCfg.EnterRes)
            imgEnd.gameObject:SetActive(false)
            imgActivityTime.gameObject:SetActive(false)
            self._mapNode.activityRedDot_[i].gameObject:SetActive(false)
            self._mapNode.activityRedDotNew_[i].gameObject:SetActive(false)
          end
        end
      end
    end
  end
end

function LevelMenuCtrl:RefreshTraceHunt(bUnLock)
  self._mapNode.TraceHuntCountBg:SetActive(bUnLock)
  self._mapNode.imgLastTime:SetActive(bUnLock)
  if not bUnLock then
    return
  end
  local nTraceItemId = ConfigTable.GetConfigNumber("TraceHuntRequestItemTid")
  self:SetSprite_Coin(self._mapNode.iconHunt, nTraceItemId)
  local tbMax = ConfigTable.GetConfigArray("TraceHuntRequestItem")
  local nHasCoin = PlayerData.TraceHunt:GetTraceTokenCount()
  local bMax = nHasCoin > tbMax[3]
  if bMax then
    NovaAPI.SetTMPText(self._mapNode.txtHuntCountNum, ConfigTable.GetUIText("TraceHunt_HuntCountNumMax"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtHuntCountNum, self:ThousandsNumber(nHasCoin) .. "/" .. tbMax[3])
  end
  self:RefreshTraceHuntTime()
end

function LevelMenuCtrl:RefreshTraceHuntTime()
  local nControlId = PlayerData.TraceHunt:GetCurControlId()
  local nShowDay = ConfigTable.GetConfigNumber("TraceHuntControlEmergencyTime")
  local nRemainTime = PlayerData.TraceHunt:GetControlLeftTime()
  local bCountDown = 0 < nControlId and nRemainTime <= nShowDay * 86400
  self._mapNode.imgLastTime:SetActive(bCountDown)
end

function LevelMenuCtrl:RefreshTimeout(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function LevelMenuCtrl:RefreshExchangeTimeout(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_OnlyMin") or "", min)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_OnlyHour") or "", hour)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_OnlyDay") or "", day)
  end
  return ConfigTable.GetUIText("Activity_End_Exchange") .. " " .. sTimeStr
end

function LevelMenuCtrl:InitBoardActor()
  local curBoardData = PlayerBoardData:GetCurBoardData()
  if nil == curBoardData then
    curBoardData = PlayerBoardData:GetTempBoardData()
  end
  if nil == curBoardData then
    printError("菜单界面看板数据为空！！！")
    return
  end
  local charId, skinId
  if curBoardData:GetType() == GameEnum.handbookType.SKIN then
    charId = curBoardData:GetCharId()
    skinId = curBoardData:GetSkinId()
  else
    charId, skinId = PlayerData.Board:GetUsableBoardCharId()
  end
  if charId == nil then
    printError("菜单界面看板随机角色失败！！！")
  else
    Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, charId, skinId)
  end
end

function LevelMenuCtrl:StartPhoneTimer()
  if self.phoneTimer ~= nil then
    self.phoneTimer:Cancel()
    self.phoneTimer = nil
  end
  local curTime = ClientManager.serverTimeStamp
  NovaAPI.SetTMPText(self._mapNode.TMPTime[1], (os.date("%H:%M", curTime)))
  NovaAPI.SetTMPText(self._mapNode.TMPTime[2], (os.date("%H:%M", curTime)))
  self.phoneTimer = self:AddTimer(0, 1, function()
    local curTime = ClientManager.serverTimeStamp
    NovaAPI.SetTMPText(self._mapNode.TMPTime[1], (os.date("%H:%M", curTime)))
    NovaAPI.SetTMPText(self._mapNode.TMPTime[2], (os.date("%H:%M", curTime)))
  end, true, true, true)
end

function LevelMenuCtrl:RefreshFuncOpen()
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.ScoreBoss)
    self._mapNode.LockScoreBoss:SetActive(true)
    self._mapNode.UnlockScoreBoss:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPCondScoreBoss, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockScoreBoss:SetActive(false)
    self._mapNode.UnlockScoreBoss:SetActive(true)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.InfinityTower) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.InfinityTower)
    NovaAPI.SetTMPText(self._mapNode.TMPCondInfinity, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
    self._mapNode.LockInfinity:SetActive(true)
    self._mapNode.UnlockInfinity:SetActive(false)
  else
    self._mapNode.LockInfinity:SetActive(false)
    self._mapNode.UnlockInfinity:SetActive(true)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.VampireSurvivor) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.VampireSurvivor)
    self._mapNode.LockVampire:SetActive(true)
    self._mapNode.UnlockVampire:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPCondVampire, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockVampire:SetActive(false)
    self._mapNode.UnlockVampire:SetActive(true)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.WeeklyCopies) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.WeeklyCopies)
    self._mapNode.LockWeeklyCopies:SetActive(true)
    self._mapNode.UnlockWeeklyCopies:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPCondWeeklyCopies, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
  else
    self._mapNode.LockWeeklyCopies:SetActive(false)
    self._mapNode.UnlockWeeklyCopies:SetActive(true)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.TraceHunt) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.TraceHunt)
    NovaAPI.SetTMPText(self._mapNode.TMPCondTraceHunt, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
    self._mapNode.LockTraceHunt:SetActive(true)
    self._mapNode.UnlockTraceHunt:SetActive(false)
    self:RefreshTraceHunt(false)
  else
    self._mapNode.LockTraceHunt:SetActive(false)
    self._mapNode.UnlockTraceHunt:SetActive(true)
    self:RefreshTraceHunt(true)
  end
  if not PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Soldier) then
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.Soldier)
    NovaAPI.SetTMPText(self._mapNode.TMPCondSoldier, UTILS.ParseParamDesc(mapLockCfgData.Tips, mapLockCfgData))
    self._mapNode.LockSoldier:SetActive(true)
    self._mapNode.UnlockSoldier:SetActive(false)
  else
    local mapLockCfgData = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.Soldier)
    self._mapNode.LockSoldier:SetActive(false)
    self._mapNode.UnlockSoldier:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPSoldiertowerTitle, UTILS.ParseParamDesc(mapLockCfgData.Name, mapLockCfgData))
  end
  self._mapNode.goResource:RefreshFuncOpen()
end

function LevelMenuCtrl:SetHintLayout(bEnabled)
  self._mapNode.goStarTowerHintLayout.enabled = bEnabled
  self._mapNode.layoutElement.enabled = not bEnabled
end

function LevelMenuCtrl:ClearTimer()
  if self.phoneTimer ~= nil then
    self.phoneTimer:Cancel()
    self.phoneTimer = nil
  end
end

function LevelMenuCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nType = tbParam[1]
    self.nInitType = tbParam[1]
  end
  self.nSelectStarTowerIndex = 0
  self.nSelectStarTowerGroupId = 0
  self.nSelectResourceType = 0
  self.bPlayActorAnim = true
  self.mapAllStarTower = {}
  self.mapStarTowerGroup = {}
  self.nTransType = 0
  
  local function forEachStarTower(mapData)
    local nGroupId = mapData.GroupId
    local mapGroupData = ConfigTable.GetData("StarTowerGroup", nGroupId)
    if mapGroupData == nil then
      return
    end
    if nil == self.mapStarTowerGroup[nGroupId] then
      local mapData = {}
      mapData.nGroupId = nGroupId
      table.insert(self.mapAllStarTower, mapData)
      self.mapStarTowerGroup[nGroupId] = {}
    end
    self.mapStarTowerGroup[nGroupId][mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(DataTable.StarTower, forEachStarTower)
  table.sort(self.mapAllStarTower, function(a, b)
    local groupCfgA = ConfigTable.GetData("StarTowerGroup", a.nGroupId)
    local groupCfgB = ConfigTable.GetData("StarTowerGroup", b.nGroupId)
    if groupCfgA == nil or groupCfgB == nil then
      return false
    end
    local unlockGroupA = PlayerData.StarTower:IsStarTowerGroupUnlock(a.nGroupId) and 1 or 0
    local unlockGroupB = PlayerData.StarTower:IsStarTowerGroupUnlock(b.nGroupId) and 1 or 0
    if unlockGroupA ~= unlockGroupB then
      return unlockGroupA > unlockGroupB
    end
    return groupCfgA.Sort < groupCfgB.Sort
  end)
  self.tbAllCharList = {}
  local tbList = PlayerData.Char:GetDataForCharList()
  for nCharId, v in pairs(tbList) do
    local mapCfg = ConfigTable.GetData_Character(nCharId)
    if mapCfg ~= nil and mapCfg.Visible then
      table.insert(self.tbAllCharList, nCharId)
    end
  end
  self.nCurResIconIndex = 1
  self.tbResourceIcon = {}
  for i = 1, 4 do
    self.tbResourceIcon[i] = {}
    self.tbResourceIcon[i].iconList = ConfigTable.GetConfigArray("LevelMenu_Resource_IconGroup_" .. i, ",")
    self.tbResourceIcon[i].nLastIndex = 0
  end
end

function LevelMenuCtrl:UpdateStartTowerHint()
  local scrollerCS = self._mapNode.TMPStarTowerLeave.gameObject:GetComponent("TextScroll")
  self._mapNode.goStarTowerHint:SetActive(false)
  scrollerCS:StopScroll()
  local mapStarTowerState = PlayerData.State:GetStarTowerState()
  if mapStarTowerState.Id ~= 0 then
    local mapStarTowerCfgData = ConfigTable.GetData("StarTower", mapStarTowerState.Id)
    if mapStarTowerCfgData == nil then
      return
    end
    self._mapNode.goStarTowerHint:SetActive(true)
    self:SetHintLayout(true)
    local s = orderedFormat(ConfigTable.GetUIText("StarTowerLevel_Hint") or "", mapStarTowerCfgData.Name, mapStarTowerCfgData.Difficulty, mapStarTowerState.Floor)
    NovaAPI.SetTMPText(self._mapNode.TMPStarTowerLeave, s)
    local rectTra = self._mapNode.TMPStarTowerLeave.gameObject:GetComponent("RectTransform")
    LayoutRebuilder.ForceRebuildLayoutImmediate(rectTra)
    
    local function refreshUI()
      local width = rectTra.sizeDelta.x
      if width >= LimitWidth then
        rectTra.anchoredPosition = Vector2(20, rectTra.anchoredPosition.y)
        self:SetHintLayout(false)
        scrollerCS:StartScroll(self._mapNode.TMPStarTowerLeave)
      else
        self:SetHintLayout(true)
        scrollerCS:StopScroll()
      end
    end
    
    self:AddTimer(1, 0.2, refreshUI, true, true)
  end
end

function LevelMenuCtrl:OnEnable()
  self._mapNode.panelAnimator.gameObject:SetActive(false)
  
  local function callback()
    EventManager.Hit(EventId.SetTransition)
    self:RefreshEnergy()
    self:InitBoardActor()
    if self._panel.panelType == nil and self.nType ~= nil then
      self._panel.panelType = self.nType
      self.nType = nil
    end
    local screenHeight = self._mapNode.safeAreaRoot.rect.size.y
    local phoneContentHeight = screenHeight / 2 + sumHeight
    local width = self._mapNode.PhoneContent.sizeDelta.x
    self._mapNode.PhoneContent.sizeDelta = Vector2(width, phoneContentHeight)
    self:UpdateStartTowerHint()
    self:StartPhoneTimer()
    self:RefreshFuncOpen()
    self:RefreshActivityList()
    self.nCurResIconIndex = 1
    self:RefreshResourceIcon()
    for k, v in ipairs(self._mapNode.imgResourceIcon1_) do
      NovaAPI.ImageDoFade(v, 1, 0, true)
    end
    for k, v in ipairs(self._mapNode.imgResourceIcon2_) do
      NovaAPI.ImageDoFade(v, 0, 0, true)
    end
    if self.resourceTimer == nil then
      self.resourceTimer = self:AddTimer(0, 5, function()
        if self.resourceSequence ~= nil then
          self.resourceSequence:Kill()
        end
        self.resourceSequence = DOTween.Sequence()
        for k, v in ipairs(self._mapNode["imgResourceIcon" .. self.nCurResIconIndex .. "_"]) do
          self.resourceSequence:Join(NovaAPI.ImageDoFade(v, 0, 0.5, true))
        end
        self.nCurResIconIndex = self.nCurResIconIndex == 1 and 2 or 1
        self:RefreshResourceIcon()
        for k, v in ipairs(self._mapNode["imgResourceIcon" .. self.nCurResIconIndex .. "_"]) do
          self.resourceSequence:Join(NovaAPI.ImageDoFade(v, 1, 0.5, true))
        end
        self.resourceSequence:SetUpdate(true)
      end, true, true, true)
    end
    self.doubleActData = nil
    local actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Double)
    if actData ~= nil and actData:CheckActShow() then
      self.doubleActData = actData
    end
    local nReengagementDouble = PlayerData.Reengagement:GetDoubleDropCount() or 0
    self._mapNode.imgDoubleDrop.gameObject:SetActive(self.doubleActData ~= nil or 0 < nReengagementDouble)
    self._mapNode.goResource:RefreshDropUp(self.doubleActData)
    if self._panel.panelType == nil then
      self._panel.panelType = phone_page_main
    elseif self._panel.panelType == phone_page_starTower then
      local bState = PlayerData.State:CheckStarTowerState()
      if bState then
        self._panel.panelType = phone_page_main
      end
    end
    if self.bPlayActorAnim then
      self.bPlayActorAnim = false
      Actor2DManager.PlayActor2DAnim("Actor2D_middle_left")
    end
    self:AddTimer(1, 0.1, function()
      self._mapNode.panelAnimator.gameObject:SetActive(true)
      self:ChangePhonePage()
      local sAnim = ""
      if self._panel.panelType == phone_page_main then
        sAnim = "levelmenu_t_in"
      elseif self._panel.panelType == phone_page_starTower then
        sAnim = "levelmenu_t_StarTower_in"
        self._mapNode.goStarTower:InitStarTower(self.mapAllStarTower, self.mapStarTowerGroup)
      elseif self._panel.panelType == phone_page_resource then
        sAnim = "levelmenu_t_btnResource_in"
        self:InitResourceIndex()
        self._mapNode.goResource:InitResource(self.nSelectResourceType)
        self:SelectResourceItem(self.nSelectResourceType)
      end
      local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.panelAnimator, {sAnim})
      self._mapNode.panelAnimator:Play(sAnim)
      EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
      EventManager.Hit("Guide_LevelMenuOpen")
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  end
  
  NovaAPI.SetTMPText(self._mapNode.txtStarTowerName[1], "")
  NovaAPI.SetTMPText(self._mapNode.txtStarTowerName[2], "")
  PlayerData.StarTower:SendTowerGrowthDetailReq(callback)
end

function LevelMenuCtrl:OnDisable()
  self:ClearTimer()
  Actor2DManager.UnsetActor2D()
  if self.resourceTimer ~= nil then
    self.resourceTimer:Cancel()
    self.resourceTimer = nil
  end
  if self.resourceSequence ~= nil then
    self.resourceSequence:Kill()
    self.resourceSequence = nil
  end
end

function LevelMenuCtrl:OnBtnClick_StarTower(btn)
  local function AffinityCallback()
    local bState = PlayerData.State:CheckStarTowerState()
    
    if not bState then
      CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
      
      local function callback()
        local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.panelAnimator, {
          "levelmenu_t_out"
        })
        self._mapNode.panelAnimator:Play("levelmenu_t_out", 0, 0)
        self:AddTimer(1, nAnimLen, function()
          self._mapNode.panelAnimator:Play("levelmenu_t_StarTower_in", 0, 0)
          self._panel.panelType = phone_page_starTower
          self:ChangePhonePage()
          self._mapNode.goStarTower:InitStarTower(self.mapAllStarTower, self.mapStarTowerGroup)
          EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenLevelMenuStarTower")
        end, true, true, true)
        EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
      end
      
      PlayerData.StarTower:SendTowerGrowthDetailReq(callback)
    end
  end
  
  PlayerData.StarTower:GetAffinity(AffinityCallback)
end

function LevelMenuCtrl:OnBtnClick_Build(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildBriefList)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, func)
end

function LevelMenuCtrl:OnBtnClick_Preselection()
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionList)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, func)
end

function LevelMenuCtrl:OnBtnClick_Resource(btn)
  CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.panelAnimator, {
    "levelmenu_t_out"
  })
  self._mapNode.panelAnimator:Play("levelmenu_t_out", 0, 0)
  self:AddTimer(1, nAnimLen, function()
    self._panel.panelType = phone_page_resource
    self:ChangePhonePage()
    self:InitResourceIndex()
    self._mapNode.goResource:InitResource(self.nSelectResourceType)
    self:SelectResourceItem(self.nSelectResourceType)
    self._mapNode.panelAnimator:Play("levelmenu_t_btnResource_in", 0, 0)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
end

function LevelMenuCtrl:OnBtnClick_StarTowerGoto()
  for _, v in ipairs(self.mapAllStarTower) do
    if v.nGroupId == self.nSelectStarTowerGroupId then
      local nHard = PlayerData.StarTower:GetMaxDifficult(v.nGroupId)
      EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerLevelSelect, nHard, v.nGroupId, true)
    end
  end
end

function LevelMenuCtrl:OnBtnClick_ResourceGoto()
  if self.nSelectResourceType == GameEnum.OpenFuncType.SkillInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillInstanceLevelSelect)
  elseif self.nSelectResourceType == GameEnum.OpenFuncType.RegionBoss then
    EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossLevel)
  elseif self.nSelectResourceType == GameEnum.OpenFuncType.DailyInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceLevelSelect)
  elseif self.nSelectResourceType == GameEnum.OpenFuncType.CharGemInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInstanceLevelSelect)
  end
end

function LevelMenuCtrl:OnBtnClick_ActivityEntrance(btn, nIndex)
  local mapData = self.tbActivityShowList[nIndex]
  if mapData ~= nil then
    if mapData.nType == showActType.Group then
      local actGroupData = mapData.data
      if actGroupData == nil then
        return
      end
      local isUnlock, txtUnlock = actGroupData:IsUnlock()
      if not isUnlock then
        EventManager.Hit(EventId.OpenMessageBox, txtUnlock)
        return
      end
      local cfg = actGroupData:GetActGroupCfgData()
      if cfg ~= nil then
        PlayerData.Activity:SendActivityDetailMsg()
        if cfg.TransitionId ~= nil and cfg.TransitionId > 0 then
          local function callback()
            EventManager.Hit(EventId.OpenPanel, cfg.PanelId, cfg.Id, true)
          end
          
          EventManager.Hit(EventId.SetTransition, cfg.TransitionId, callback)
        else
          EventManager.Hit(EventId.OpenPanel, cfg.PanelId, cfg.Id, true)
        end
      end
    else
      local actData = mapData.data
      if not actData:CheckActivityOpen() then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
        self:RefreshActivityList()
        return
      end
      if mapData.nType == showActType.TrekkerVersus then
        local nChallengeEndTime = actData:GetChallengeEndTime()
        local nCurTime = CS.ClientManager.Instance.serverTimeStamp
        if nChallengeEndTime < nCurTime then
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Invalid_Tip_3"))
          self:RefreshActivityFastEntrance()
          return
        end
        
        local function func()
          EventManager.Hit(EventId.OpenPanel, PanelId.TrekkerVersus, actData:GetActId())
        end
        
        EventManager.Hit(EventId.SetTransition, 30, func)
      elseif mapData.nType == showActType.JointDrill then
        do
          local bPlayCond = actData:CheckActJumpCond(true)
          if not bPlayCond then
            return
          end
          local nActId = actData.nActId
          EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(nActId, "LevelSelect"), nActId)
        end
      end
    end
  end
end

function LevelMenuCtrl:OnBtnClick_Soldier(btn)
  local function openSoldierPanel()
    local animLen = NovaAPI.GetAnimClipLength(self._mapNode.animTransition, {
      "TransitionRoot_btnSoldier"
    })
    self._mapNode.animTransition:Play("TransitionRoot_btnSoldier", 0, 0)
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
    self.nTransType = 53
    self:AddTimer(1, animLen, function()
      EventManager.Hit(EventId.SetTransition, 53)
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, animLen)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.Soldier, openSoldierPanel, "ui_systerm_locked")
end

function LevelMenuCtrl:OnBtnClick_TraceHunt(btn)
  local function openTraceHuntPanel()
    local animLen = NovaAPI.GetAnimClipLength(self._mapNode.animTransition, {
      "TransitionRoot_btnTraceHunt"
    })
    self._mapNode.animTransition:Play("TransitionRoot_btnTraceHunt", 0, 0)
    self.nTransType = 49
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
    self:AddTimer(1, animLen, function()
      EventManager.Hit(EventId.SetTransition, 49)
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, animLen)
  end
  
  local function callbackCheck()
    local function afterReq()
      if PlayerData.TraceHunt:GetControlLeftTime() <= 0 then
        self:RefreshTraceHuntTime()
        
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TraceHunt_Tips_ControlInterrupt"))
        return
      end
      openTraceHuntPanel()
    end
    
    PlayerData.TraceHunt:SendTraceHuntInfoReq(afterReq)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.TraceHunt, callbackCheck, "ui_systerm_locked")
end

function LevelMenuCtrl:OnBtnClick_ScoreBoss(btn)
  local function openScoreBossPanel()
    local function callbackCheck()
      local animLen = NovaAPI.GetAnimClipLength(self._mapNode.animTransition, {
        "TransitionRoot_btnTravelerDuel"
      })
      self._mapNode.animTransition:Play("TransitionRoot_btnTravelerDuel", 0, 0)
      self.nTransType = 24
      CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
      self:AddTimer(1, animLen, function()
        EventManager.Hit(EventId.SetTransition, 24)
      end, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, animLen)
    end
    
    PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.ScoreBoss, callbackCheck, "ui_systerm_locked")
  end
  
  local bFuncUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, false)
  if bFuncUnlock then
    if not PlayerData.ScoreBoss:GetInitInfoState() then
      PlayerData.ScoreBoss:GetScoreBossInstanceData(openScoreBossPanel)
    else
      openScoreBossPanel()
    end
  else
    openScoreBossPanel()
  end
end

function LevelMenuCtrl:OnBtnClick_Vampire(btn)
  local function stateCallback(bReEnter)
    if not bReEnter then
      local animLen = NovaAPI.GetAnimClipLength(self._mapNode.animTransition, {
        "TransitionRoot_btnVampire"
      })
      self._mapNode.animTransition:Play("TransitionRoot_btnVampire", 0, 0)
      CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
      self.nTransType = 13
      self:AddTimer(1, animLen, function()
        EventManager.Hit(EventId.SetTransition, 13)
      end, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, animLen)
    end
  end
  
  local function callbackCheck()
    PlayerData.State:CheckVampireState(stateCallback)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.VampireSurvivor, callbackCheck, "ui_systerm_locked")
end

function LevelMenuCtrl:OnBtnClick_WeeklyCopies(btn)
  local function callbackCheck()
    local animLen = NovaAPI.GetAnimClipLength(self._mapNode.animTransition, {
      "TransitionRoot_btnWeeklyCopies"
    })
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
    self.nTransType = 23
    EventManager.Hit(EventId.SetTransition, 23)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.WeeklyCopies, callbackCheck, "ui_systerm_locked")
end

function LevelMenuCtrl:OnBtnClick_Infinity()
  local function callback()
    PlayerData.InfinityTower:SetPageState(1)
    
    local animLen = NovaAPI.GetAnimClipLength(self._mapNode.animTransition, {
      "TransitionRoot_btnInfinity"
    })
    self._mapNode.animTransition:Play("TransitionRoot_btnInfinity", 0, 0)
    self.nTransType = 8
    CS.WwiseAudioManager.Instance:PlaySound("ui_level_select")
    self:AddTimer(1, animLen, function()
      EventManager.Hit(EventId.SetTransition, 8)
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, animLen)
  end
  
  PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.InfinityTower, callback, "ui_systerm_locked")
end

function LevelMenuCtrl:OnBtnClick_Close(btn)
  if self._panel.panelType == phone_page_starTower or self._panel.panelType == phone_page_resource then
    if self.nInitType ~= nil and (self.nInitType == phone_page_starTower or self.nInitType == phone_page_resource) then
      EventManager.Hit(EventId.ClosePanel, PanelId.LevelMenu)
    else
      local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.panelAnimator, {
        "levelmenu_t_in"
      })
      self._mapNode.panelAnimator:Play("levelmenu_t_in")
      self._panel.panelType = phone_page_main
      self:ChangePhonePage()
      self:UpdateStartTowerHint()
      EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
      Actor2DManager.PlayActor2DAnim("Actor2D_middle_left")
    end
  else
    self._mapNode.panelAnimator:Play("levelmenu_t_out")
    local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.panelAnimator, {
      "levelmenu_t_out"
    })
    self:AddTimer(1, nAnimLen, function()
      EventManager.Hit(EventId.ClosePanel, PanelId.LevelMenu)
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  end
end

function LevelMenuCtrl:OnBtnClick_Home(btn)
  PanelManager.Home()
end

function LevelMenuCtrl:OnEvent_UpdateWorldClass()
  self:RefreshFuncOpen()
end

function LevelMenuCtrl:OnEvent_TransAnimInClear()
  if self.nTransType == 13 then
    self.nTransType = 0
    
    local function success(bSuccess)
      if bSuccess then
        EventManager.Remove("GetTalentDataVampire", self, success)
        EventManager.Hit(EventId.OpenPanel, PanelId.VampireSurvivorLevelSelectPanel)
      else
        EventManager.Hit(EventId.SetTransition)
      end
    end
    
    EventManager.Add("GetTalentDataVampire", self, success)
    local ret, _, _ = PlayerData.VampireSurvivor:GetTalentData()
    if ret ~= nil then
      success(true)
    end
  elseif self.nTransType == 8 then
    self.nTransType = 0
    EventManager.Hit(EventId.OpenPanel, PanelId.InfinityTowerSelectTower)
  elseif self.nTransType == 24 then
    self.nTransType = 0
    EventManager.Hit(EventId.OpenPanel, PanelId.ScoreBossSelectPanel)
  elseif self.nTransType == 23 then
    self.nTransType = 0
    EventManager.Hit(EventId.OpenPanel, PanelId.WeeklyCopiesPanel)
  elseif self.nTransType == 49 then
    self.nTransType = 0
    EventManager.Hit(EventId.OpenPanel, PanelId.TraceHunt)
  elseif self.nTransType == 53 then
    self.nTransType = 0
    PlayerData.SoldierData:SetCurSelectSeasonId(1)
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierMainViewPanel)
  end
end

function LevelMenuCtrl:OnEvent_SelectResourceInstance(nType)
  if self.nSelectResourceType == nType then
    return
  end
  self.nSelectResourceType = nType
  self:SelectResourceItem(nType)
  WwiseAudioMgr:PlaySound("ui_level_daily_tog_whoosh")
  self._mapNode.panelAnimator:Play("levelmenu_t_btnResource_in1", 0, 0)
end

function LevelMenuCtrl:OnEvent_SelectStarTowerGroup(nGroupId, bInit)
  if self.nSelectStarTowerGroupId == nGroupId and not bInit then
    return
  end
  self.nSelectStarTowerGroupId = nGroupId
  local nSelectIndex = 0
  for k, v in ipairs(self.mapAllStarTower) do
    if v.nGroupId == self.nSelectStarTowerGroupId then
      nSelectIndex = k
      break
    end
  end
  
  local function setLevelInfo(nIdx, bPlayAnim)
    local mapGroupCfg = ConfigTable.GetData("StarTowerGroup", nGroupId)
    if mapGroupCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtStarTowerName[nIdx], mapGroupCfg.Name)
      self:SetPngSprite(self._mapNode.imgCover[nIdx], mapGroupCfg.CoverImage)
      if bPlayAnim then
        local nRandomIdx = math.random(1, #self.tbAllCharList)
        local nCharId = self.tbAllCharList[nRandomIdx]
        local nCharSkinId = ConfigTable.GetData_Character(nCharId).DefaultSkinId
        local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
        if mapCharSkin ~= nil then
          self:SetPngSprite(self._mapNode.imgGoods[nIdx], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.GOODS)
        end
        if not bInit then
          self._mapNode.imgGoodsRoot[nIdx]:Play("Goods_switch", 0, 0)
          WwiseAudioMgr:PlaySound("ui_level_rogue_tog_sign")
        end
      end
    end
  end
  
  local bChangeUp = nSelectIndex > self.nSelectStarTowerIndex
  local nCurIndex = bChangeUp and 2 or 1
  local nLastIndex = bChangeUp and 1 or 2
  if self.nSelectStarTowerIndex ~= 0 then
    local sAnim = bChangeUp and "StarTowerSwitch_up" or "StarTowerSwitch_down"
    self._mapNode.animStarTower:Play(sAnim, 0, 0)
    local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animStarTower, {sAnim})
    self:AddTimer(1, nAnimLen, function()
      setLevelInfo(nLastIndex)
    end, true, true, true)
  end
  self._mapNode.imgGoodsRoot[nCurIndex].gameObject:SetActive(true)
  self._mapNode.imgGoodsRoot[nLastIndex].gameObject:SetActive(false)
  setLevelInfo(nCurIndex, true)
  self.nSelectStarTowerIndex = nSelectIndex
end

function LevelMenuCtrl:OnEvent_UpdateEnergy()
  self:RefreshEnergy()
end

return LevelMenuCtrl
