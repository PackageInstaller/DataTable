local JointDrillLevelSelectCtrl = class("JointDrillLevelSelectCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillLevelSelectCtrl._mapNodeConfig = {
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgBg = {sComponentName = "Image"},
  goMain = {sNodeName = "---Main---"},
  btnAvg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Avg"
  },
  txtBtnAvg = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Story"
  },
  btnQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txtBtnQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Reward"
  },
  btnShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Shop"
  },
  txtBtnShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Shop"
  },
  btnRank = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rank"
  },
  txtBtnRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Rank"
  },
  redDotQuest = {},
  goActTime = {},
  txtActTimeCn = {sComponentName = "TMP_Text"},
  txtActTime = {sComponentName = "TMP_Text"},
  goLevelList = {},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Difficulty_Select"
  },
  levelListSv = {
    sComponentName = "UIScrollRect"
  },
  levelListContent = {
    sComponentName = "RectTransform"
  },
  goLevelItem = {},
  goLevelBattleItem = {},
  goTickets = {},
  btnTicketTip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tickets"
  },
  txtTicketCount = {sComponentName = "TMP_Text"},
  goTip = {sNodeName = "--Tips--"},
  btnTipsBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_TipsBg"
  },
  txtTipsName = {sComponentName = "TMP_Text"},
  txtTipsContent = {sComponentName = "TMP_Text"},
  txtRefreshTime = {sComponentName = "TMP_Text"},
  goChallengeEnd = {},
  txtChallengeEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Challenge_End"
  },
  goLevelInfo = {
    sNodeName = "---LevelInfo---"
  },
  goInBattle = {},
  goNormal = {},
  btnStart = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtBtnStart = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Start_Challenge"
  },
  animatorStart = {
    sNodeName = "AnimRootStart",
    sComponentName = "Animator"
  },
  btnContinue = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Continue"
  },
  txtBtnContinue = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Continue_Challenge"
  },
  animatorContinue = {
    sNodeName = "AnimRootContinue",
    sComponentName = "Animator"
  },
  btnSimulation = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Simulation"
  },
  txtBtnSimulation = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Start_Challenge_Simulate"
  },
  animatorSimulation = {
    sNodeName = "AnimRootSimulation",
    sComponentName = "Animator"
  },
  btnOver = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Over"
  },
  txtBtnOver = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Stop_Challenge"
  },
  animatorCancel = {
    sNodeName = "AnimRootCancel",
    sComponentName = "Animator"
  },
  btnFastBattle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastBattle"
  },
  animatorFastBattle = {
    sNodeName = "AnimRootFastBattle",
    sComponentName = "Animator"
  },
  txtBtnFastBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Battle_Fast_Battle"
  },
  imgFastBattleLock = {},
  txtChallengeCount = {sComponentName = "TMP_Text"},
  txtRecLevel = {sComponentName = "TMP_Text"},
  txtRecommend = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Recommend"
  },
  txtRecommendLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  imgRecommendBuild = {sComponentName = "Image"},
  txtRecommendBuild = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  goPropertyList = {nCount = 2, sComponentName = "Transform"},
  txtPropertyNone = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "EnemyInfo_Window_Property_None"
  },
  txtBossSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Boss_Info"
  },
  btnBossSkill = {
    nCount = 6,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  imgBossSkill = {nCount = 6, sComponentName = "Image"},
  btnSkillDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkillDetail"
  },
  txtBtnSkillDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_BossSkill_Detail"
  },
  txtRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Challenge_Reward"
  },
  btnReward = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  goRewardItem = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgTickets = {sComponentName = "Image"},
  txtTicketsCount = {sComponentName = "TMP_Text"},
  goChallengeTime = {},
  txtChallengeTime = {sComponentName = "TMP_Text"},
  goBossInfo = {nCount = 2},
  imgSimulation = {},
  txtSimulation = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Start_Challenge_Simulate"
  },
  txtBossName = {sComponentName = "TMP_Text", nCount = 2},
  imgBossIcon = {sComponentName = "Image", nCount = 2},
  imgBossMask = {sComponentName = "Image", nCount = 2},
  imgBossHpBar = {sComponentName = "Image", nCount = 2},
  txtBossHp = {sComponentName = "TMP_Text", nCount = 2},
  txtBossDie = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "JointDrill_Boss_Die"
  },
  goAvgWindow = {
    sNodeName = "---AVGWindow---"
  },
  goBlur = {sNodeName = "goBlurAVG"},
  goAvgRoot = {
    sNodeName = "goMainLineAvgRoot"
  },
  animWindowAVG = {sNodeName = "rtWindow", sComponentName = "Animator"},
  txtAvgTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_AVG_Title"
  },
  btnCloseWindow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseAvgWindow"
  },
  mainLineAvgLvName = {sComponentName = "TMP_Text"},
  mainLineAvgLvDes = {sComponentName = "TMP_Text"},
  btnCancelWindow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CancelAvgWindow"
  },
  txtBtnCancelWindow = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  btnStartAvg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StartAvg"
  },
  txtBtnStartAvg = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Enter_AVG"
  },
  goSmoke = {},
  goBossSkill = {
    sNodeName = "---BossSkill---"
  },
  goWindowBossSkill = {},
  animWindowSkill = {
    sNodeName = "goWindowBossSkill",
    sComponentName = "Animator"
  },
  goBlurSkill = {},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_BossSkill_Title"
  },
  btnCloseSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseSkill"
  },
  skillListLSV = {
    sComponentName = "LoopScrollView"
  }
}
JointDrillLevelSelectCtrl._mapEventConfig = {
  RefreshJointDrillLevel = "OnEvent_RefreshJointDrillLevel",
  SelectJointDrillLevel = "OnEvent_SelectJointDrillLevel",
  RefreshChallengeTime = "OnEvent_RefreshChallengeTime",
  RefreshJointDrillActTime = "OnEvent_RefreshJointDrillActTime",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  JointDrillChallengeFinishError = "OnEvent_JointDrillChallengeFinishError"
}
JointDrillLevelSelectCtrl._mapRedDotConfig = {
  [RedDotDefine.JointDrillQuest] = {
    sNodeName = "redDotQuest"
  }
}
local panelType_main = 1
local panelType_levelInfo = 2

function JointDrillLevelSelectCtrl:PlayAvg(callback)
  local function avgEndCallback()
    EventManager.Remove("StoryDialog_DialogEnd", self, avgEndCallback)
    
    LocalData.SetPlayerLocalData("JointDrillAvgId", self.nActId)
    if callback ~= nil then
      callback()
    end
  end
  
  EventManager.Add("StoryDialog_DialogEnd", self, avgEndCallback)
  local mapCfg = ConfigTable.GetData("JointDrillControl", self.nActId)
  if mapCfg ~= nil then
    EventManager.Hit("StoryDialog_DialogStart", mapCfg.DrillPlotId)
  end
end

function JointDrillLevelSelectCtrl:RefreshAvgInfo()
  local mapCfg = ConfigTable.GetData("JointDrillControl", self.nActId)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvName, mapCfg.PlotTitle)
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvDes, mapCfg.PlotDesc)
  end
end

function JointDrillLevelSelectCtrl:Refresh()
  self.bInBattle = PlayerData.JointDrill_2:CheckJointDrillInBattle()
  self.nCurLevelId = PlayerData.JointDrill_2:GetJointDrillLevelId()
  if self.nPanelType == panelType_main then
    self:RefreshLevelList()
  elseif self.nPanelType == panelType_levelInfo then
    self:RefreshLevelInfo()
  end
  local nAvgId = LocalData.GetPlayerLocalData("JointDrillAvgId")
  self._mapNode.btnAvg.gameObject:SetActive(false)
end

function JointDrillLevelSelectCtrl:RefreshLevelList()
  self._mapNode.goMain.gameObject:SetActive(true)
  self._mapNode.goLevelInfo.gameObject:SetActive(false)
  self.animRoot:Play("JointDrill_Main_in", 0, 0)
  local nLocationIndex = 0
  if self.bInBattle or self.nActStatus == AllEnum.JointDrillActStatus.Start then
    self._mapNode.goLevelList.gameObject:SetActive(true)
    self._mapNode.goChallengeEnd.gameObject:SetActive(false)
    local mapLevelList = CacheTable.GetData("_JointDrill_2_Level", self.nGroupId)
    if self.nCurLevelId == 0 and self.battleItemCtrl ~= nil then
      destroy(self.battleItemCtrl.gameObject)
      self:UnbindCtrlByNode(self.battleItemCtrl)
      self.battleItemCtrl = nil
    end
    if mapLevelList ~= nil then
      for _, v in ipairs(self.tbLevelItemCtrl) do
        v.gameObject:SetActive(false)
      end
      local nIndex = 1
      for k, v in ipairs(mapLevelList) do
        local itemCtrl
        local nLevelId = v.Id
        if self.nCurLevelId == nLevelId then
          if self.battleItemCtrl == nil then
            local itemObj = instantiate(self._mapNode.goLevelBattleItem, self._mapNode.levelListContent)
            self.battleItemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.JointDrill.JointDrill_2.JointDrillLevelItemCtrl")
          end
          self.battleItemCtrl.gameObject:SetActive(true)
          self.battleItemCtrl:SetItem(v, self.nCurLevelId)
          nLocationIndex = k
        else
          if self.tbLevelItemCtrl[nIndex] == nil then
            local itemObj = instantiate(self._mapNode.goLevelItem, self._mapNode.levelListContent)
            itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.JointDrill.JointDrill_2.JointDrillLevelItemCtrl")
            table.insert(self.tbLevelItemCtrl, itemCtrl)
          else
            itemCtrl = self.tbLevelItemCtrl[nIndex]
          end
          if itemCtrl ~= nil then
            itemCtrl.gameObject:SetActive(true)
            itemCtrl:SetItem(v)
          end
          nIndex = nIndex + 1
        end
      end
    end
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if nLocationIndex == 0 then
        for k, v in ipairs(mapLevelList) do
          local bUnlock = PlayerData.JointDrill_2:IsJointDrillUnlock(v.Id)
          if bUnlock then
            nLocationIndex = k
          end
        end
      end
      NovaAPI.UIScrollRectScrollTo(self._mapNode.levelListSv, nLocationIndex - 1, false)
    end
    
    cs_coroutine.start(wait)
  else
    self._mapNode.goLevelList.gameObject:SetActive(false)
    self._mapNode.goChallengeEnd.gameObject:SetActive(true)
  end
  local nCurCount = PlayerData.Item:GetItemCountByID(self.nTicketId)
  NovaAPI.SetTMPText(self._mapNode.txtTicketCount, orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Ticket"), nCurCount, self.nMaxTicketCount))
end

function JointDrillLevelSelectCtrl:RefreshLevelInfo()
  self._mapNode.goMain.gameObject:SetActive(false)
  self._mapNode.goLevelInfo.gameObject:SetActive(true)
  self._mapNode.goInBattle.gameObject:SetActive(self.bInBattle)
  self._mapNode.goNormal.gameObject:SetActive(not self.bInBattle)
  self.animRoot:Play("JointDrill_LevelInfo_in", 0, 0)
  if self.bInBattle then
    self._mapNode.animatorContinue:Play("JointDrill_Btn_Continue", 0, 0)
    self._mapNode.animatorCancel:Play("JointDrill_Btn_Cancel", 0, 0)
  else
    self._mapNode.animatorStart:Play("JointDrill_Btn_Start", 0, 0)
    self._mapNode.animatorSimulation:Play("JointDrill_Btn_Small", 0, 0)
    self._mapNode.animatorFastBattle:Play("JointDrill_Btn_Small", 0, 0)
  end
  local mapLevelCfg = ConfigTable.GetData("JointDrill_2_Level", self.nSelectLevelId)
  if mapLevelCfg == nil then
    return
  end
  local bSimulate = PlayerData.JointDrill_2:GetBattleSimulate()
  local nDiff = mapLevelCfg.Difficulty
  if self.bInBattle then
    local bossInfo = PlayerData.JointDrill_2:GetCurBossInfo()
    local nIndex = 1
    for _, v in ipairs(bossInfo) do
      if v.nBossCfgId ~= 0 then
        local mapBossCfg = PlayerData.JointDrill_2:GetMonsterCfg(v.nBossCfgId)
        if mapBossCfg ~= nil then
          NovaAPI.SetTMPText(self._mapNode.txtBossName[nIndex], string.format("%s/%s", mapBossCfg.Name, ConfigTable.GetUIText("JointDrill_Difficulty_Name_" .. nDiff)))
          self:SetPngSprite(self._mapNode.imgBossIcon[nIndex], mapBossCfg.Icon)
          self:SetPngSprite(self._mapNode.imgBossMask[nIndex], mapBossCfg.Icon)
        end
        if v.nHp == 0 then
          self._mapNode.txtBossHp[nIndex].gameObject:SetActive(false)
          self._mapNode.txtBossDie[nIndex].gameObject:SetActive(true)
          self._mapNode.imgBossMask[nIndex].gameObject:SetActive(true)
          NovaAPI.SetImageFillAmount(self._mapNode.imgBossHpBar[nIndex], 0)
        else
          self._mapNode.txtBossHp[nIndex].gameObject:SetActive(true)
          self._mapNode.txtBossDie[nIndex].gameObject:SetActive(false)
          self._mapNode.imgBossMask[nIndex].gameObject:SetActive(false)
          NovaAPI.SetTMPText(self._mapNode.txtBossHp[nIndex], string.format("%s/%s", self:ThousandsNumber(v.nHp), self:ThousandsNumber(v.nHpMax)))
          NovaAPI.SetImageFillAmount(self._mapNode.imgBossHpBar[nIndex], v.nHp / v.nHpMax)
        end
        nIndex = nIndex + 1
      end
    end
    local tbTeams = PlayerData.JointDrill_2:GetJointDrillBuildList()
    local nChallengeCount = #tbTeams
    self.nAllChallengeCount = PlayerData.JointDrill_2:GetMaxChallengeCount(self.nSelectLevelId)
    NovaAPI.SetTMPText(self._mapNode.txtChallengeCount, orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Count"), self.nAllChallengeCount - nChallengeCount))
    self:RefreshChallengeTime()
  else
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, "-1")
    local bPassed = self.actDataIns:CheckPassedId(self.nSelectLevelId)
    self._mapNode.imgFastBattleLock.gameObject:SetActive(not bPassed)
    local tbMonsterList = mapLevelCfg.BossId
    for nIndex, nBossId in ipairs(tbMonsterList) do
      local mapBossCfg = PlayerData.JointDrill_2:GetMonsterCfg(nBossId)
      if mapBossCfg ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtBossName[nIndex], string.format("%s/%s", mapBossCfg.Name, ConfigTable.GetUIText("JointDrill_Difficulty_Name_" .. nDiff)))
        self:SetPngSprite(self._mapNode.imgBossIcon[nIndex], mapBossCfg.Icon)
        self:SetPngSprite(self._mapNode.imgBossMask[nIndex], mapBossCfg.Icon)
      end
      local nHpMax = PlayerData.JointDrill_2:GetMonsterMaxHp(nBossId, nDiff)
      NovaAPI.SetTMPText(self._mapNode.txtBossHp[nIndex], string.format("%s/%s", self:ThousandsNumber(nHpMax), self:ThousandsNumber(nHpMax)))
      NovaAPI.SetImageFillAmount(self._mapNode.imgBossHpBar[nIndex], nHpMax / nHpMax)
      self._mapNode.txtBossHp[nIndex].gameObject:SetActive(true)
      self._mapNode.txtBossDie[nIndex].gameObject:SetActive(false)
      self._mapNode.imgBossMask[nIndex].gameObject:SetActive(false)
    end
  end
  self._mapNode.imgSimulation.gameObject:SetActive(bSimulate)
  NovaAPI.SetTMPText(self._mapNode.txtRecLevel, mapLevelCfg.RecommendLv)
  local sScoreIcon = "Icon/BuildRank/BuildRank_" .. mapLevelCfg.RecommendBuildRank
  self:SetPngSprite(self._mapNode.imgRecommendBuild, sScoreIcon)
  local tbEET1, tbEET2 = {}, {}
  local tbMonsterId = mapLevelCfg.BossId
  if 0 < #tbMonsterId then
    local nMonsterId = tbMonsterId[1]
    local mapMonsterCfgData = ConfigTable.GetData("Monster", nMonsterId)
    if mapMonsterCfgData ~= nil then
      local nTempleteId = mapMonsterCfgData.Templete
      local mapTemplete = ConfigTable.GetData("MonsterValueTempleteAdjust", nTempleteId)
      if mapTemplete ~= nil then
        tbEET1 = clone(mapTemplete.WeakEET)
        tbEET2 = clone(mapTemplete.ResistEET)
      end
    end
  end
  self._mapNode.goPropertyList[1].gameObject:SetActive(0 < #tbEET1)
  self._mapNode.goPropertyList[2].gameObject:SetActive(0 < #tbEET2)
  self._mapNode.txtPropertyNone[1].gameObject:SetActive(#tbEET1 == 0)
  self._mapNode.txtPropertyNone[2].gameObject:SetActive(#tbEET2 == 0)
  for i = 1, 5 do
    local goProperty1 = self._mapNode.goPropertyList[1]:Find("goEmpty" .. i)
    if goProperty1 then
      goProperty1.gameObject:SetActive(tbEET1[i] ~= nil)
      if tbEET1[i] ~= nil then
        local img = goProperty1:Find("imgProperty"):GetComponent("Image")
        local sName = AllEnum.ElementIconType.Icon .. tbEET1[i]
        self:SetAtlasSprite(img, "12_rare", sName)
      end
    end
    local goProperty2 = self._mapNode.goPropertyList[2]:Find("goEmpty" .. i)
    if goProperty2 then
      goProperty2.gameObject:SetActive(tbEET2[i] ~= nil)
      if tbEET2[i] ~= nil then
        local img = goProperty2:Find("imgProperty"):GetComponent("Image")
        local sName = AllEnum.ElementIconType.Icon .. tbEET2[i]
        self:SetAtlasSprite(img, "12_rare", sName)
      end
    end
  end
  self.tbBossSkill = mapLevelCfg.BossAffix
  for k, v in ipairs(self._mapNode.imgBossSkill) do
    v.gameObject:SetActive(mapLevelCfg.BossAffix[k] ~= nil)
    if mapLevelCfg.BossAffix[k] ~= nil then
      local mapSkillCfg = ConfigTable.GetData("JointDrillAffix", mapLevelCfg.BossAffix[k])
      if mapSkillCfg ~= nil then
        self:SetPngSprite(v, mapSkillCfg.Icon)
      end
    end
  end
  self:RefreshBossSkill()
  local rewardData = mapLevelCfg.RewardPreview
  self.tbReward = decodeJson(rewardData)
  for i = 1, 3 do
    local bReceived = false
    if self.tbReward[i] ~= nil then
      if self.tbReward[i][3] == 1 then
        bReceived = self.actDataIns:CheckPassedId(self.nSelectLevelId)
      end
      self._mapNode.goRewardItem[i]:SetItem(self.tbReward[i][1], nil, self.tbReward[i][2], nil, bReceived, self.tbReward[i][3] == 1)
    else
      self._mapNode.goRewardItem[i]:SetItem(0)
    end
  end
end

function JointDrillLevelSelectCtrl:ActEnd()
  local function confirmCallback()
    EventManager.Hit(EventId.CloesCurPanel)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Alert,
    sContent = ConfigTable.GetUIText("JointDrill_Act_End_Tip"),
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function JointDrillLevelSelectCtrl:SetChallengeTime(nRemainTime)
  local tbTime = timeFormat_Table(nRemainTime)
  local sTime = ""
  if tbTime.min > 0 then
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_3"), tbTime.min, tbTime.sec)
  else
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_4"), tbTime.sec)
  end
  NovaAPI.SetTMPText(self._mapNode.txtChallengeTime, orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_Left"), sTime))
end

function JointDrillLevelSelectCtrl:RefreshChallengeTime()
  local nStartTime = PlayerData.JointDrill_2:GetJointDrillStartTime()
  local nCloseTime = math.floor(nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max"))
  local nCurTime = ClientManager.serverTimeStamp
  local nRemainTime = nCloseTime - nCurTime
  self:SetChallengeTime(nRemainTime)
end

function JointDrillLevelSelectCtrl:RefreshActTime()
  local nRemainTime = 0
  local nCurTime = ClientManager.serverTimeStamp
  if self.nActStatus == AllEnum.JointDrillActStatus.Start then
    local nChallengeEndTime = self.actDataIns:GetChallengeEndTime()
    nRemainTime = nChallengeEndTime - nCurTime
  elseif self.nActStatus == AllEnum.JointDrillActStatus.WaitClose then
    local nActEndTime = self.actDataIns:GetActEndTime()
    nRemainTime = nActEndTime - nCurTime
  end
  self:SetActTime(nRemainTime)
end

function JointDrillLevelSelectCtrl:SetActTime(nRemainTime)
  if self.nActStatus == AllEnum.JointDrillActStatus.Start then
    NovaAPI.SetTMPText(self._mapNode.txtActTimeCn, ConfigTable.GetUIText("JointDrill_Challenge_Time_Text"))
  elseif self.nActStatus == AllEnum.JointDrillActStatus.WaitClose then
    NovaAPI.SetTMPText(self._mapNode.txtActTimeCn, ConfigTable.GetUIText("JointDrill_Act_Time_Text"))
  end
  if nRemainTime <= 0 then
    if self.nPanelType == panelType_main then
      self:RefreshLevelList()
    end
    if self.nActStatus == AllEnum.JointDrillActStatus.Closed then
      self:ActEnd()
    end
  end
  local tbTime = timeFormat_Table(nRemainTime)
  local sTime = ""
  if 0 < tbTime.day then
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_1"), tbTime.day, tbTime.hour)
  elseif 0 < tbTime.hour then
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_2"), tbTime.hour, tbTime.min)
  elseif 0 < tbTime.min then
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_3"), tbTime.min, tbTime.sec)
  else
    sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_4"), tbTime.sec)
  end
  NovaAPI.SetTMPText(self._mapNode.txtActTime, sTime)
end

function JointDrillLevelSelectCtrl:StartTicketsRefreshTimer()
  if self.ticketRefreshTimer ~= nil then
    self.ticketRefreshTimer:Cancel()
    self.ticketRefreshTimer = nil
  end
  local nCurTime = ClientManager.serverTimeStamp
  local nNextRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
  
  local function refreshTime()
    nCurTime = ClientManager.serverTimeStamp
    local nRemainTime = nNextRefreshTime - nCurTime
    local sTime = timeFormat_HMS(nRemainTime)
    NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, orderedFormat(ConfigTable.GetUIText("JointDrill_Tickets_Refresh_Time"), sTime))
  end
  
  refreshTime()
  self.ticketRefreshTimer = self:AddTimer(0, 1, function()
    refreshTime()
  end, true, true, true)
end

function JointDrillLevelSelectCtrl:RefreshBossSkill()
  if self.tbBossSkill == nil or #self.tbBossSkill == 0 then
    return
  end
  self._mapNode.skillListLSV:Init(#self.tbBossSkill, self, self.OnSkillGridRefresh)
end

function JointDrillLevelSelectCtrl:OnSkillGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nAffixId = self.tbBossSkill[nIndex]
  local mapSkillCfg = ConfigTable.GetData("JointDrillAffix", nAffixId)
  if mapSkillCfg ~= nil then
    local imgSkill = goGrid.transform:Find("btnGrid/AnimRoot/imgSkill"):GetComponent("Image")
    local txtSkillName = goGrid.transform:Find("btnGrid/AnimRoot/txtSkillName"):GetComponent("TMP_Text")
    local txtSkillDesc = goGrid.transform:Find("btnGrid/AnimRoot/txtSkillDesc"):GetComponent("TMP_Text")
    self:SetPngSprite(imgSkill, mapSkillCfg.Icon)
    NovaAPI.SetTMPText(txtSkillName, mapSkillCfg.Name)
    NovaAPI.SetTMPText(txtSkillDesc, mapSkillCfg.Desc)
  end
end

function JointDrillLevelSelectCtrl:OpenBossSkill()
  self._mapNode.goWindowBossSkill.gameObject:SetActive(false)
  self._mapNode.goBlurSkill.gameObject:SetActive(true)
  self._mapNode.goBossSkill.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goWindowBossSkill.gameObject:SetActive(true)
    self._mapNode.animWindowSkill:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function JointDrillLevelSelectCtrl:Awake()
  self.nPanelType = panelType_main
  self.nSelectLevelId = 0
  self.nTicketId = ConfigTable.GetConfigNumber("JointDrill_Challenge_Tickets_Id")
  self.nMaxTicketCount = ConfigTable.GetConfigNumber("JointDrill_Challenge_Tickets_Max")
  local mapItemCfg = ConfigTable.GetData_Item(self.nTicketId)
  if mapItemCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgTickets, mapItemCfg.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtTipsName, mapItemCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtTipsContent, ConfigTable.GetUIText("JointDrill_Tickets_Desc"))
  end
end

function JointDrillLevelSelectCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  local bReset = PlayerData.JointDrill_2:GetResetLevelSelect()
  if bReset then
    self.nPanelType = panelType_main
  end
  PlayerData.JointDrill_2:SetResetLevelSelect(false)
  self._mapNode.goAvgWindow.gameObject:SetActive(false)
  self._mapNode.goBossSkill.gameObject:SetActive(false)
  self._mapNode.goSmoke.gameObject:SetActive(false)
  self._mapNode.goLevelItem.gameObject:SetActive(false)
  self._mapNode.goLevelBattleItem.gameObject:SetActive(false)
  self._mapNode.goTip.gameObject:SetActive(false)
  self.tbLevelItemCtrl = {}
  self.nRankReqCount = 0
  self.nActStatus = 0
  local tbParam = self:GetPanelParam()
  if 0 < #tbParam then
    self.nActId = tbParam[1]
    self.actDataIns = PlayerData.Activity:GetActivityDataById(self.nActId)
    local mapCfg = ConfigTable.GetData("JointDrillControl", self.nActId)
    if mapCfg == nil or self.actDataIns == nil then
      return
    end
    self.nGroupId = mapCfg.DrillLevelGroupId
    self:SetPngSprite(self._mapNode.imgBg, mapCfg.BG)
  end
  
  local function callback()
  end
  
  if self.actDataIns == nil then
    return
  end
  self.actDataIns:MarkEnteredToday()
  PlayerData.Build:GetAllBuildBriefData(callback)
  self.nActStatus = self.actDataIns:GetActStatus()
  self._mapNode.goSmoke.gameObject:SetActive(false)
  self._mapNode.goSmoke.gameObject:SetActive(true)
  self:RefreshActTime()
  self:Refresh()
  self:StartTicketsRefreshTimer()
  self:RefreshAvgInfo()
  if self.nActStatus == AllEnum.JointDrillActStatus.Start then
    PlayerData.JointDrill_2:SendJointDrillRankMsg()
  end
end

function JointDrillLevelSelectCtrl:OnDisable()
  if self.ticketRefreshTimer ~= nil then
    self.ticketRefreshTimer:Cancel()
    self.ticketRefreshTimer = nil
  end
  if self.battleItemCtrl ~= nil then
    destroy(self.battleItemCtrl.gameObject)
    self:UnbindCtrlByNode(self.battleItemCtrl)
  end
  self.battleItemCtrl = nil
  for _, v in ipairs(self.tbLevelItemCtrl) do
    destroy(v.gameObject)
    self:UnbindCtrlByNode(v)
  end
  self.tbLevelItemCtrl = {}
end

function JointDrillLevelSelectCtrl:OnDestroy()
end

function JointDrillLevelSelectCtrl:OnBtnClick_Avg()
end

function JointDrillLevelSelectCtrl:OnBtnClick_Quest()
  PlayerData.JointDrill_2:SendJointDrillRankMsg(function()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Quest"), self.nActId)
  end)
end

function JointDrillLevelSelectCtrl:OnBtnClick_Shop()
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPanel, 3)
end

function JointDrillLevelSelectCtrl:OnBtnClick_Rank()
  PlayerData.JointDrill_2:SendJointDrillRankMsg(function()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Ranking"), self.nActId)
  end)
end

function JointDrillLevelSelectCtrl:OnBtnClick_Tickets()
  if self.nTicketId ~= nil then
    self._mapNode.goTip.gameObject:SetActive(true)
    local mapItemCfg = ConfigTable.GetData_Item(self.nTicketId)
    if mapItemCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtTipsContent, mapItemCfg.Desc)
    end
  end
end

function JointDrillLevelSelectCtrl:OnBtnClick_TipsBg()
  self._mapNode.goTip.gameObject:SetActive(false)
end

function JointDrillLevelSelectCtrl:OnBtnClick_LevelBack()
  self.nPanelType = panelType_main
  self:RefreshLevelList()
end

function JointDrillLevelSelectCtrl:OnBtnClick_LevelHome()
  PanelManager.Home()
end

function JointDrillLevelSelectCtrl:OnBtnClick_Start()
  local bInChallengeTime = PlayerData.JointDrill_2:CheckActChallengeTime()
  if not bInChallengeTime then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Challenge_End_Tip"))
    self.nPanelType = panelType_main
    self:RefreshLevelList()
    return
  end
  local nCurCount = PlayerData.Item:GetItemCountByID(self.nTicketId)
  if nCurCount <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Tickets_NotEnough"))
    return
  end
  if self.nSelectLevelId == 0 then
    printError("LevelId 错误")
    return
  end
  
  local function callback()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "BuildList"), self.nSelectLevelId, false)
  end
  
  callback()
end

function JointDrillLevelSelectCtrl:OnBtnClick_Continue()
  local function callback()
    self.bInBattle = PlayerData.JointDrill_2:CheckJointDrillInBattle()
    
    self.nPanelType = panelType_main
    self:RefreshLevelList()
  end
  
  local nStartTime = PlayerData.JointDrill_2:GetJointDrillStartTime()
  local nCloseTime = math.floor(nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max"))
  if nCloseTime <= ClientManager.serverTimeStamp then
    PlayerData.JointDrill_2:JointDrillGameOver(callback, true)
    return
  end
  local bInChallengeTime = PlayerData.JointDrill_2:CheckActChallengeTime()
  if not bInChallengeTime then
    PlayerData.JointDrill_2:JointDrillGameOver(callback, true)
    return
  end
  local bSimulate = PlayerData.JointDrill_2:GetBattleSimulate()
  EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "BuildList"), self.nSelectLevelId, bSimulate)
end

function JointDrillLevelSelectCtrl:OnBtnClick_Simulation()
  local bInChallengeTime = PlayerData.JointDrill_2:CheckActChallengeTime()
  if not bInChallengeTime then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Challenge_End_Tip"))
    self.nPanelType = panelType_main
    self:RefreshLevelList()
    return
  end
  if self.nSelectLevelId == 0 then
    printError("LevelId 错误")
    return
  end
  EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "BuildList"), self.nSelectLevelId, true)
end

function JointDrillLevelSelectCtrl:OnBtnClick_Over()
  local sTip = ConfigTable.GetUIText("JointDrill_Give_Up_Tip")
  local sTip2
  local bSimulate = PlayerData.JointDrill_2:GetBattleSimulate()
  if not bSimulate then
    sTip2 = ConfigTable.GetUIText("JointDrill_Give_Up_Tip_2")
  end
  
  local function callback()
    local function gameOverCallback()
      self.bInBattle = PlayerData.JointDrill_2:CheckJointDrillInBattle()
      
      self.nPanelType = panelType_main
      self:RefreshLevelList()
    end
    
    PlayerData.JointDrill_2:JointDrillGameOver(gameOverCallback, true)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    sContentSub = sTip2,
    callbackConfirm = callback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function JointDrillLevelSelectCtrl:OnBtnClick_FastBattle()
  local bInChallengeTime = PlayerData.JointDrill_2:CheckActChallengeTime()
  if not bInChallengeTime then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Challenge_End_Tip"))
    self.nPanelType = panelType_main
    self:RefreshLevelList()
    return
  end
  if not self.actDataIns:CheckPassedId(self.nSelectLevelId) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Fast_Battle_Tip"))
    return
  end
  local nCurTicketCount = PlayerData.Item:GetItemCountByID(self.nTicketId)
  if nCurTicketCount <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Tickets_NotEnough"))
    return
  end
  PlayerData.JointDrill_2:SendJointDrillRankMsg(function()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Raid"), self.nSelectLevelId)
  end)
end

function JointDrillLevelSelectCtrl:OnEvent_RefreshJointDrillLevel()
  self:Refresh()
end

function JointDrillLevelSelectCtrl:OnEvent_SelectJointDrillLevel(nLevelId)
  if self.nPanelType == panelType_main then
    local bInChallengeTime = PlayerData.JointDrill_2:CheckActChallengeTime()
    if not bInChallengeTime then
      local function gameOverCallback()
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Challenge_End_Tip"))
        
        self.nPanelType = panelType_main
        self:RefreshLevelList()
      end
      
      if self.bInBattle then
        PlayerData.JointDrill_2:JointDrillGameOver(gameOverCallback, true)
      else
        gameOverCallback()
      end
      return
    end
    local nAnimTime = NovaAPI.GetAnimClipLength(self.animRoot, {
      "JointDrill_Main_out"
    })
    self.animRoot:Play("JointDrill_Main_out")
    self._mapNode.goSmoke.gameObject:SetActive(false)
    self._mapNode.goSmoke.gameObject:SetActive(true)
    self:AddTimer(1, nAnimTime, function()
      self.nPanelType = panelType_levelInfo
      self.nSelectLevelId = nLevelId
      self:RefreshLevelInfo()
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  end
end

function JointDrillLevelSelectCtrl:OnEvent_RefreshChallengeTime(nRemainTime)
  self:SetChallengeTime(nRemainTime)
end

function JointDrillLevelSelectCtrl:OnEvent_RefreshJointDrillActTime(nStatus, nRemainTime)
  self.nActStatus = nStatus
  self:SetActTime(nRemainTime)
end

function JointDrillLevelSelectCtrl:OnEvent_JointDrillChallengeFinishError()
  local function callback()
    if PlayerData.JointDrill_2:CheckJointDrillInBattle() then
      PlayerData.JointDrill_2:JointDrillGameOver(nil, true)
    else
      EventManager.Hit("RefreshJointDrillLevel")
    end
  end
  
  PlayerData.Activity:SendActivityDetailMsg(callback, true)
end

function JointDrillLevelSelectCtrl:OnBtnClick_Skill(btn, nIndex)
  if self.tbBossSkill[nIndex] ~= nil then
    local nSkillId = self.tbBossSkill[nIndex]
    if nSkillId ~= 0 then
      local mapData = {nSkillId = nSkillId, bJointDrill = true}
      EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
    end
  end
end

function JointDrillLevelSelectCtrl:OnBtnClick_SkillDetail()
  self:OpenBossSkill()
end

function JointDrillLevelSelectCtrl:OnBtnClick_Reward(btn, nIndex)
  if self.tbReward[nIndex] ~= nil then
    local nTid = self.tbReward[nIndex][1]
    UTILS.ClickItemGridWithTips(nTid, btn.transform, true, true, false)
  end
end

function JointDrillLevelSelectCtrl:OnBtnClick_CloseAvgWindow()
  self._mapNode.animWindowAVG:Play("t_window_04_t_out")
  
  local function closeWindow()
    self._mapNode.goAvgWindow.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.3, closeWindow, true, true, true, false)
end

function JointDrillLevelSelectCtrl:OnBtnClick_CancelAvgWindow()
  self._mapNode.animWindowAVG:Play("t_window_04_t_out")
  
  local function closeWindow()
    self._mapNode.goAvgWindow.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.3, closeWindow, true, true, true, false)
end

function JointDrillLevelSelectCtrl:OnBtnClick_StartAvg()
  self:PlayAvg()
end

function JointDrillLevelSelectCtrl:OnBtnClick_CloseSkill()
  self._mapNode.animWindowSkill:Play("t_window_04_t_out")
  
  local function closeWindow()
    self._mapNode.goBossSkill.gameObject:SetActive(false)
  end
  
  self:AddTimer(1, 0.3, closeWindow, true, true, true, false)
end

function JointDrillLevelSelectCtrl:OnEvent_Back()
  if self.nPanelType == panelType_levelInfo then
    local nAnimTime = NovaAPI.GetAnimClipLength(self.animRoot, {
      "JointDrill_LevelInfo_out"
    })
    self.animRoot:Play("JointDrill_LevelInfo_out")
    self._mapNode.goSmoke.gameObject:SetActive(false)
    self._mapNode.goSmoke.gameObject:SetActive(true)
    self:AddTimer(1, nAnimTime, function()
      self.nPanelType = panelType_main
      self:RefreshLevelList()
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  else
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function JointDrillLevelSelectCtrl:OnEvent_BackHome()
  PanelManager.Home()
end

return JointDrillLevelSelectCtrl
