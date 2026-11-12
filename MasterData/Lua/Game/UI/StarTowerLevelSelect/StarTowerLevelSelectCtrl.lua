local StarTowerLevelSelectCtrl = class("StarTowerLevelSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local mapToggle = {
  [1] = GameEnum.diffculty.Diffculty_1,
  [2] = GameEnum.diffculty.Diffculty_2,
  [3] = GameEnum.diffculty.Diffculty_3,
  [4] = GameEnum.diffculty.Diffculty_4,
  [5] = GameEnum.diffculty.Diffculty_5,
  [6] = GameEnum.diffculty.Diffculty_6,
  [7] = GameEnum.diffculty.Diffculty_7,
  [8] = GameEnum.diffculty.Diffculty_8
}
StarTowerLevelSelectCtrl._mapNodeConfig = {
  bgLevelInfo = {sNodeName = "----Bg----"},
  rt_StarTowerSelect = {},
  rt_StarTowerInfo = {},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  btnResearch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Research"
  },
  txtBtnResearch = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_ResearchPreview"
  },
  goBtnCoin = {},
  imgCoinIcon = {sComponentName = "Image"},
  svStarTower = {
    sComponentName = "LoopScrollView"
  },
  imgElementInfo = {sComponentName = "Image", nCount = 3},
  TMPStarTowerDesc = {sComponentName = "TMP_Text"},
  TMPStarTowerName = {sComponentName = "TMP_Text"},
  txtRecommendLevel = {sComponentName = "TMP_Text"},
  ImgStarTowerInfo = {sComponentName = "Image"},
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 6
  },
  ItemBtn = {
    sComponentName = "UIButton",
    nCount = 6,
    callback = "OnBtnClick_RewardItem"
  },
  tog = {
    sComponentName = "UIButton",
    nCount = 8,
    callback = "OnBtnClick_Tog"
  },
  imgLockMask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTips",
    nCount = 8
  },
  rt_LockMsg = {nCount = 8},
  txtLockCondition = {sComponentName = "TMP_Text", nCount = 8},
  togCtrl = {
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 8
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  AnimCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  },
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardList"
  },
  txtCoinCount = {sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  goSweep = {
    sNodeName = "---Sweep---"
  },
  btnSweep = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Sweep"
  },
  txtSweepBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Sweep_Btn"
  },
  goBtnSweepTickets = {},
  SweepLockRoot = {},
  txtSweepBtnLock = {sComponentName = "TMP_Text"},
  imgTickets = {sComponentName = "Image", nCount = 2},
  txtTicketsCount = {sComponentName = "TMP_Text", nCount = 2},
  btnSweepTickets = {
    sNodeName = "goSweepTickets",
    sComponentName = "UIButton",
    callback = "OnBtnClick_SweepTickets"
  },
  rt_Toggle = {sComponentName = "ScrollRect"},
  rt_ToggleContent = {
    sComponentName = "RectTransform"
  },
  txtBtnEnemyInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Rank_Enemy_Info"
  },
  txtTitleReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  txtBtnAllReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "FixedRoguelike_Depot_Btn_All"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  ListConditions = {},
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  txtBtnLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_SatisfyConditions_UnLock"
  },
  Conditions_ = {nCount = 3},
  imgFirstPassIcon = {},
  TMPFirstPassHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_FirstPassHint"
  },
  StarTowerGrowthPreviewWindow = {
    sCtrlName = "Game.UI.StarTowerGrowth.StarTowerGrowthPreviewWindowCtrl"
  },
  btnAutoBattle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoBattle"
  },
  autoDecisionPhone = {
    sNodeName = "btnAutoBattle",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionPhoneCtrl"
  }
}
StarTowerLevelSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  [EventId.CoinResChange] = "OnEvent_RefreshRes"
}
StarTowerLevelSelectCtrl._mapRedDotConfig = {}

function StarTowerLevelSelectCtrl:Awake()
  self.tbGridCtrl = {}
  self.nTopBarId = self._mapNode.TopBarPanel.gameObject:GetInstanceID()
  self:RefreshTogText()
end

function StarTowerLevelSelectCtrl:FadeIn()
end

function StarTowerLevelSelectCtrl:FadeOut()
end

function StarTowerLevelSelectCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if 0 < #tbParam then
    if tbParam[3] == nil then
    end
    self.bJumpto = tbParam[3]
    self.nJumptoHard = tbParam[1] == nil and 0 or tbParam[1]
    self.nJumptoGroup = tbParam[2] == nil and 0 or tbParam[2]
  end
  if self.nJumptoHard >= 8 then
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.rt_Toggle, 0)
  else
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.rt_Toggle, 1)
  end
  self._mapNode.rt_StarTowerSelect:SetActive(true)
  self._mapNode.rt_StarTowerInfo:SetActive(false)
  self._mapNode.bgLevelInfo:SetActive(false)
  self._mapNode.goSweep.gameObject:SetActive(false)
  self.curState = 1
  self.curStarTowerHard = GameEnum.diffculty.Diffculty_1
  self.nCurGroupId = 0
  self.mapAllStarTower = {}
  self.mapStarTowerGroup = {}
  
  local function forEachStarTower(mapData)
    local nGroupId = mapData.GroupId
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
    if groupCfgA == nil then
      return false
    end
    if groupCfgB == nil then
      return false
    end
    return groupCfgA.Sort < groupCfgB.Sort
  end)
  if self.nJumptoGroup ~= 0 and self.nJumptoGroup ~= nil then
    if self.nJumptoHard ~= 0 and self.nJumptoHard ~= nil then
      self:OpenJumptoHard()
    else
      self:OpenJumptoGroup()
    end
    self:AddTimer(1, 0.1, function()
      EventManager.Hit("Guide_OpenStarTowerLevelGroup", self.nJumptoGroup)
    end, true, true, true)
  end
end

function StarTowerLevelSelectCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function StarTowerLevelSelectCtrl:OnDestroy()
end

function StarTowerLevelSelectCtrl:OnRelease()
end

function StarTowerLevelSelectCtrl:RefreshTogText()
  for k, v in pairs(mapToggle) do
    local sTitle = ConfigTable.GetUIText("Diffculty_" .. k)
    if sTitle == nil then
      sTitle = "需要配置语言表Diffculty_" .. k
    end
    self._mapNode.togCtrl[k]:SetText(sTitle)
  end
end

function StarTowerLevelSelectCtrl:RefreshLevelUnlock()
  if self.nCurGroupId ~= 0 then
    for index, hardBtn in ipairs(self._mapNode.tog) do
      local bActive = self.mapStarTowerGroup[self.nCurGroupId][mapToggle[index]] ~= nil
      hardBtn.gameObject:SetActive(bActive)
      if bActive then
        local nStarTowerId = self.mapStarTowerGroup[self.nCurGroupId][mapToggle[index]].Id
        local bUnlock, _, param1, param2 = PlayerData.StarTower:IsStarTowerUnlock(nStarTowerId)
        self._mapNode.imgLockMask[index].gameObject:SetActive(false)
        self._mapNode.rt_LockMsg[index]:SetActive(not bUnlock)
        if not bUnlock then
          if param1 == 2 then
            NovaAPI.SetTMPText(self._mapNode.txtLockCondition[index], orderedFormat(ConfigTable.GetUIText("RegusBoss_Unlock_LvHand"), param2))
          else
            NovaAPI.SetTMPText(self._mapNode.txtLockCondition[index], ConfigTable.GetUIText("Unlocked_By_PreLevel"))
          end
        end
      end
    end
  end
end

function StarTowerLevelSelectCtrl:RefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerLevelSelect.StarTowerGroupItemCtrl")
  end
  local mapGroupData = self.mapAllStarTower[nIndex]
  self.tbGridCtrl[nInstanceID]:SetStarTowerGroup(mapGroupData)
  if PlayerData.Guide:GetGuideState() and mapGroupData.nGroupId == 4 then
    EventManager.Hit("StarTower_Grid_Name", goGrid.name)
  end
end

function StarTowerLevelSelectCtrl:OpenJumptoGroup()
  self.curState = 2
  self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_info")
  self._mapNode.rt_StarTowerSelect:SetActive(false)
  self._mapNode.rt_StarTowerInfo:SetActive(true)
  self._mapNode.bgLevelInfo:SetActive(true)
  self.nCurGroupId = self.nJumptoGroup
  self:RefreshLevelUnlock()
  self:RefreshStarTowerInfo(self.nCurGroupId, GameEnum.diffculty.Diffculty_1, true)
end

function StarTowerLevelSelectCtrl:OpenJumptoHard()
  self.curState = 2
  self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_info")
  self._mapNode.rt_StarTowerSelect:SetActive(false)
  self._mapNode.rt_StarTowerInfo:SetActive(true)
  self._mapNode.bgLevelInfo:SetActive(true)
  self.nCurGroupId = self.nJumptoGroup
  local nJumptoRoguelikeId = self.mapStarTowerGroup[self.nCurGroupId][self.nJumptoHard].Id
  if not PlayerData.StarTower:IsStarTowerUnlock(nJumptoRoguelikeId) then
    self.nJumptoHard = GameEnum.diffculty.Diffculty_1
  end
  self:RefreshLevelUnlock()
  self:RefreshStarTowerInfo(self.nCurGroupId, self.nJumptoHard, true)
end

function StarTowerLevelSelectCtrl:OnBtnClick_Grid(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local mapData = self.mapAllStarTower[nIdx]
  if mapData == nil then
    return
  end
  local nGroupId = mapData.nGroupId
  local mapStarTower = self.mapStarTowerGroup[nGroupId][GameEnum.diffculty.Diffculty_1]
  local bGridUnlock, sTip = PlayerData.StarTower:IsStarTowerUnlock(mapStarTower.Id)
  if not bGridUnlock then
    if sTip == nil then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_NotOpen"))
      return
    else
      EventManager.Hit(EventId.OpenMessageBox, sTip)
      return
    end
  end
  self.curState = 2
  self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_info")
  self._mapNode.rt_StarTowerSelect:SetActive(false)
  self._mapNode.rt_StarTowerInfo:SetActive(true)
  self._mapNode.bgLevelInfo:SetActive(true)
  self.nCurGroupId = nGroupId
  self._panel._tbParam[2] = nGroupId
  local nHard = PlayerData.StarTower:GetMaxDifficult(self.nCurGroupId)
  self:RefreshLevelUnlock()
  self:RefreshStarTowerInfo(nGroupId, nHard, true)
end

function StarTowerLevelSelectCtrl:RefreshStarTowerInfo(nGroupId, nHard, bSetTog)
  if bSetTog then
    for k, v in ipairs(self._mapNode.togCtrl) do
      v:SetDefault(k == nHard)
    end
  end
  self.curStarTowerHard = nHard
  self._panel._tbParam[1] = self.curStarTowerHard
  local mapStarTower = self.mapStarTowerGroup[nGroupId][nHard]
  self.curStarTowerId = mapStarTower.Id
  if mapStarTower == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPStarTowerName, mapStarTower.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPStarTowerDesc, mapStarTower.Desc)
  self:SetPngSprite(self._mapNode.ImgStarTowerInfo, mapStarTower.Image)
  for i = 1, 3 do
    if mapStarTower.EET == nil or mapStarTower.EET[i] == nil then
      self._mapNode.imgElementInfo[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfo[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfo[i], "12_rare", AllEnum.ElementIconType.Icon .. mapStarTower.EET[i])
    end
  end
  local bShowHint = PlayerData.StarTower:GetShowHintRewardReward(self.curStarTowerId)
  local bFirstRewardReceive = PlayerData.StarTower:GetFirstPassReward(self.curStarTowerId)
  self._mapNode.imgFirstPassIcon:SetActive(bShowHint)
  local tbReward = decodeJson(mapStarTower.RewardPreview)
  self.tbReward = tbReward
  local nRewardPlusIdx = 0
  for index = 1, 6 do
    self._mapNode.item[index]:SetItem(nil)
    self._mapNode.ItemBtn[index].interactable = false
  end
  for index = 1, 6 do
    if tbReward[index] ~= nil then
      if bFirstRewardReceive and tbReward[index][3] == 1 then
        nRewardPlusIdx = nRewardPlusIdx + 1
      else
        self._mapNode.item[index - nRewardPlusIdx]:SetItem(tbReward[index][1], nil, tbReward[index][3] == 1 and tbReward[index][2] or nil, nil, false, tbReward[index][3] == 1, tbReward[index][3] == 2)
        self._mapNode.ItemBtn[index - nRewardPlusIdx].interactable = true
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapStarTower.Recommend)
  self._mapNode.goBtnCoin.gameObject:SetActive(false)
  local bUnlock, _, param1, param2 = PlayerData.StarTower:IsStarTowerUnlock(self.curStarTowerId)
  if not bUnlock then
    local mapStarTowerCfgData = ConfigTable.GetData("StarTower", self.curStarTowerId)
    local tbCond = decodeJson(mapStarTowerCfgData.PreConditions)
    for i = 1, 3 do
      if tbCond[i] ~= nil then
        local tbCondInfo = tbCond[i]
        local sTip = ""
        local isUnlock = true
        if tbCondInfo[1] == 1 then
          local nCondLevelId = tbCondInfo[2]
          local mapStarTower = ConfigTable.GetData("StarTower", nCondLevelId)
          if mapStarTower ~= nil then
            sTip = orderedFormat(ConfigTable.GetUIText("Rogue_UnlockStarTower"), mapStarTower.Name)
          end
          if 1 > table.indexof(PlayerData.StarTower.tbPassedId, nCondLevelId) then
            isUnlock = false
          end
        elseif tbCondInfo[1] == 2 then
          local nWorldCalss = PlayerData.Base:GetWorldClass()
          local nCondClass = tbCondInfo[2]
          sTip = orderedFormat(ConfigTable.GetUIText("Rogue_UnlockWorldLv"), nCondClass)
          if nWorldCalss < nCondClass then
            isUnlock = false
          end
        elseif tbCondInfo[1] == 3 then
          local nMainlineId = tbCondInfo[2]
          local nStar = PlayerData.Mainline:GetMianlineLevelStar(nMainlineId)
          local storyConfig = ConfigTable.GetData("Story", nMainlineId, "not have this story ID")
          if storyConfig ~= nil then
            sTip = orderedFormat(ConfigTable.GetUIText("Rogue_UnlockMainLine"), storyConfig.Title)
          end
          if nStar <= 0 then
            isUnlock = false
          end
        elseif tbCondInfo[1] == 4 then
          local nDifficulty = tbCondInfo[2]
          local tbStarTower = CacheTable.GetData("_StarTowerDifficulty", nDifficulty)
          sTip = orderedFormat(ConfigTable.GetUIText("Rogue_UnlockDifficulty"), nDifficulty - 1)
          local _lock = false
          for _, v in ipairs(tbStarTower) do
            local nId = v.Id
            if 1 <= table.indexof(PlayerData.StarTower.tbPassedId, nId) then
              _lock = true
              break
            end
          end
          if not _lock then
            isUnlock = false
          end
        end
        local imgConditions_Lock = self._mapNode.Conditions_[i].transform:Find("imgConditions_Lock").gameObject
        local imgConditions_UnLock = self._mapNode.Conditions_[i].transform:Find("imgConditions_UnLock").gameObject
        local tex_ConditionsTips = self._mapNode.Conditions_[i].transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
        imgConditions_Lock:SetActive(not isUnlock)
        imgConditions_UnLock:SetActive(isUnlock)
        NovaAPI.SetTMPText(tex_ConditionsTips, sTip)
        NovaAPI.SetTMPColor(tex_ConditionsTips, isUnlock and Color(0.3686274509803922, 0.5372549019607843, 0.7058823529411765) or Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764))
        self._mapNode.Conditions_[i]:SetActive(true)
      else
        self._mapNode.Conditions_[i]:SetActive(false)
      end
    end
    self._mapNode.ListConditions:SetActive(true)
    self._mapNode.btnLock.gameObject:SetActive(true)
    self._mapNode.btnResearch.gameObject:SetActive(false)
    self._mapNode.btnGo.gameObject:SetActive(false)
    self._mapNode.btnSweep.gameObject:SetActive(false)
    self._mapNode.btnAutoBattle.gameObject:SetActive(false)
  else
    self._mapNode.ListConditions:SetActive(false)
    self._mapNode.btnLock.gameObject:SetActive(false)
    self._mapNode.btnResearch.gameObject:SetActive(true)
    self._mapNode.btnGo.gameObject:SetActive(true)
    self._mapNode.btnSweep.gameObject:SetActive(true)
  end
  
  local function callback()
    self._mapNode.goSweep.gameObject:SetActive(true)
    self:RefreshSweep()
  end
  
  PlayerData.StarTower:SendTowerGrowthDetailReq(callback)
end

function StarTowerLevelSelectCtrl:RefreshSweep()
  if not PlayerData.Guide:CheckGuideFinishById(48) then
    local tmpBAble = PlayerData.StarTower:CheckUnlockTowerSweep()
    if tmpBAble then
      local tmpCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.StarTowerSweepTick) + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.StarTowerSweepTickLimit)
      if 1 <= tmpCount then
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_StarTowerSweep")
        
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
          EventManager.Hit("Guide_SelectTowerSweepHard", 1)
        end
        
        cs_coroutine.start(wait)
      end
    end
  end
  local bSweepUnlock = PlayerData.StarTower:CheckUnlockTowerSweep()
  local bUnlock = PlayerData.StarTower:IsStarTowerUnlock(self.curStarTowerId)
  local bShowAutoBattle = bUnlock and bSweepUnlock or false
  self._mapNode.btnAutoBattle.gameObject:SetActive(bShowAutoBattle)
  if bShowAutoBattle then
    self._mapNode.autoDecisionPhone:Refresh()
  end
  local bAble, _, sLockTip = PlayerData.StarTower:CheckCanSweep(self.nCurGroupId, self.curStarTowerId)
  if bAble then
    self._mapNode.txtSweepBtn.gameObject:SetActive(true)
    self._mapNode.goBtnSweepTickets:SetActive(true)
    self._mapNode.SweepLockRoot:SetActive(false)
  else
    self._mapNode.txtSweepBtn.gameObject:SetActive(false)
    self._mapNode.goBtnSweepTickets:SetActive(false)
    self._mapNode.SweepLockRoot:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtSweepBtnLock, sLockTip)
  end
  self:RefreshSweepTicket()
end

function StarTowerLevelSelectCtrl:RefreshSweepTicket()
  local ticketCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.StarTowerSweepTick) + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.StarTowerSweepTickLimit)
  for i = 1, 2 do
    self:SetSprite_Coin(self._mapNode.imgTickets[i], AllEnum.CoinItemId.StarTowerSweepTick)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount[i], ticketCount < 1 and Red_Unable or Blue_Normal)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCount[1], 1)
  NovaAPI.SetTMPText(self._mapNode.txtTicketsCount[2], ticketCount)
end

function StarTowerLevelSelectCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bJumpto then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  if self.curState == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_list")
    self._mapNode.rt_StarTowerSelect:SetActive(true)
    self._mapNode.rt_StarTowerInfo:SetActive(false)
    self._mapNode.bgLevelInfo:SetActive(false)
    self._mapNode.goSweep.gameObject:SetActive(false)
    self.curStarTowerHard = GameEnum.diffculty.Diffculty_1
    self.nCurGroupId = 0
    self.curState = 1
    self._panel._tbParam[1] = 0
    self._panel._tbParam[2] = 0
    self._panel._tbParam[4] = 0
  end
end

function StarTowerLevelSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function StarTowerLevelSelectCtrl:OnEvent_UpdateWorldClass()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  self:RefreshLevelUnlock()
end

function StarTowerLevelSelectCtrl:OnEvent_RefreshRes(nId)
  if nId == AllEnum.CoinItemId.StarTowerSweepTick then
    self:RefreshSweepTicket()
  end
end

function StarTowerLevelSelectCtrl:OnBtnClick_Sweep()
  local bAble, sLockTip = PlayerData.StarTower:CheckCanSweep(self.nCurGroupId, self.curStarTowerId)
  if bAble then
    local ticketCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.StarTowerSweepTick)
    ticketCount = ticketCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.StarTowerSweepTickLimit)
    if ticketCount <= 0 then
      local name = ConfigTable.GetData_Item(AllEnum.CoinItemId.StarTowerSweepTick).Title
      local sTip = ConfigTable.GetUIText("StarTower_Sweep_Tickets_NotEnough")
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(sTip, name))
      return
    end
    
    local function OpenPanel()
      EventManager.Hit(EventId.OpenPanel, PanelId.MainlineFormation, AllEnum.FormationEnterType.StarTower, self.curStarTowerId, false, true)
    end
    
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  else
    EventManager.Hit(EventId.OpenMessageBox, sLockTip)
  end
end

function StarTowerLevelSelectCtrl:OnBtnClick_Go(btn)
  local nEnterType = AllEnum.FormationEnterType.StarTower
  
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.MainlineFormation, nEnterType, self.curStarTowerId, false, false)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function StarTowerLevelSelectCtrl:OnBtnClick_Tog(btn)
  local nHard = table.indexof(self._mapNode.tog, btn:GetComponent("UIButton"))
  local togIdx = table.indexof(self._mapNode.tog, btn)
  if nHard == nil then
    return
  end
  if self.curStarTowerHard ~= nHard then
    for idx, value in pairs(mapToggle) do
      if value == self.curStarTowerHard then
        self._mapNode.togCtrl[idx]:SetTrigger(false)
      end
    end
    self._mapNode.togCtrl[togIdx]:SetTrigger(true)
    self:RefreshStarTowerInfo(self.nCurGroupId, nHard)
  end
end

function StarTowerLevelSelectCtrl:OnBtnClick_EnemyInfo(btn)
  EventManager.Hit("OpenFixedRoguelikeMonsterInfo", self.curStarTowerId)
end

function StarTowerLevelSelectCtrl:OnBtnClick_RewardList(btn)
  local mapLevel = ConfigTable.GetData("StarTower", self.curStarTowerId)
  if mapLevel ~= nil then
    local tbReward = decodeJson(mapLevel.RewardPreview)
    local bFirstRewardReceive = PlayerData.StarTower:GetFirstPassReward(self.curStarTowerId)
    for _, tbRewardData in ipairs(tbReward) do
      if tbRewardData[3] == 1 and bFirstRewardReceive then
        tbRewardData[4] = true
      else
        tbRewardData[4] = false
      end
      tbRewardData[5] = tbRewardData[3] == 1
    end
    self._mapNode.goRewardList:OpenPanel(tbReward)
  end
end

function StarTowerLevelSelectCtrl:OnBtnClick_RewardItem(btn)
  local nIdx = table.indexof(self._mapNode.ItemBtn, btn)
  local mapLevel = ConfigTable.GetData("StarTower", self.curStarTowerId)
  if mapLevel ~= nil then
    local tbReward = decodeJson(mapLevel.RewardPreview)
    local rtBtn = btn.transform:Find("AnimRoot")
    local bFirstRewardReceive = PlayerData.StarTower:GetFirstPassReward(self.curStarTowerId)
    local tempIdx = 0
    local bRealIdx = 0
    for i = 1, #tbReward do
      if not bFirstRewardReceive or tbReward[i][3] ~= 1 then
        tempIdx = tempIdx + 1
        if tempIdx == nIdx then
          bRealIdx = i
        end
      end
    end
    if tbReward[bRealIdx] ~= nil then
      local nTid = tbReward[bRealIdx][1]
      UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
    end
  end
end

function StarTowerLevelSelectCtrl:OnBtnClick_TogTips(btn, nIndex)
  local nStarTowerId = self.mapStarTowerGroup[self.nCurGroupId][mapToggle[nIndex]].Id
  local bLock, sTip = PlayerData.StarTower:IsStarTowerUnlock(nStarTowerId)
  if not bLock and sTip ~= nil then
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function StarTowerLevelSelectCtrl:OnBtnClick_Lock()
  self:OnBtnClick_TogTips(nil, self.curStarTowerHard)
end

function StarTowerLevelSelectCtrl:OnBtnClick_SweepTickets(btn)
  local mapData = {
    nTid = 29,
    bShowDepot = false,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function StarTowerLevelSelectCtrl:OnBtnClick_Research(btn)
  local nDifficulty = mapToggle[self.curStarTowerHard]
  local nMaxDifficulty = PlayerData.StarTower:GetGlobalMaxDifficult()
  self._mapNode.StarTowerGrowthPreviewWindow:OpenPanel(nDifficulty, nMaxDifficulty)
end

function StarTowerLevelSelectCtrl:OnBtnClick_AutoBattle(btn)
  local bSweepUnlock = PlayerData.StarTower:CheckUnlockTowerSweep()
  if not bSweepUnlock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_Sweep_NodeAlert"))
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerAutoDecisionSettingPanel)
end

return StarTowerLevelSelectCtrl
