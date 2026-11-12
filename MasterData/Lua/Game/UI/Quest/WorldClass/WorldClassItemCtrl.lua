local WorldClassItemCtrl = class("WorldClassItemCtrl", BaseCtrl)
WorldClassItemCtrl._mapNodeConfig = {
  rtLevelUp = {},
  txtLevelUp = {sComponentName = "TMP_Text"},
  txtLevelUpDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_LevelUp_Cur"
  },
  imgProgressBarBg = {
    sComponentName = "RectTransform"
  },
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  rtAdvance = {},
  txtAdvance = {sComponentName = "TMP_Text"},
  txtAdvanceDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Advance_Cur"
  },
  imgMissionBg = {nCount = 8},
  btnRewardItem = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  goRewardItem = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  goingTip = {},
  txtGoing = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Cur"
  },
  rtImgArrow = {
    sNodeName = "imgArrow",
    sComponentName = "RectTransform"
  },
  imgComplete = {},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Lock"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Receive_All"
  },
  redDot = {}
}
WorldClassItemCtrl._mapEventConfig = {
  ReceiveWorldClassLevelReward = "OnEvent_ReceiveWorldClassLevelReward"
}
WorldClassItemCtrl._mapRedDotConfig = {}
local worldClass_Lock = 1
local worldClass_Going = 2
local worldClass_CanReceive = 3
local worldClass_Received = 4
local totalLength = 674
local totalHeight = 37

function WorldClassItemCtrl:SetItem(itemData, goBtnFastReceive, goBtnFastReceiveGray, rtLevelLsv)
  self.itemData = itemData
  self.goBtnFastReceive = goBtnFastReceive or nil
  self.goBtnFastReceiveGray = goBtnFastReceiveGray or nil
  self.rtLevelLsv = rtLevelLsv or nil
  if self.nLsvDefaultHeight == nil and rtLevelLsv ~= nil then
    self.nLsvDefaultHeight = rtLevelLsv.offsetMin
  end
  self.nCurWorldClass = PlayerData.Base:GetWorldClass()
  if itemData.nType == AllEnum.WorldClassType.LevelUp then
    self:SetLevelUpItem()
  else
    self:SetAdvanceItem()
  end
end

function WorldClassItemCtrl:SetLevelUpItem()
  self.nState = 0
  self._mapNode.rtAdvance.gameObject:SetActive(false)
  self._mapNode.rtLevelUp.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtBtnReceive, ConfigTable.GetUIText("WorldClass_Level_Receive_All"))
  local nCurStageId = PlayerData.Base:GetCurWorldClassStageId()
  local bAllReceived = true
  local bCanReceive = false
  for i = self.itemData.nMinLevel, self.itemData.nMaxLevel do
    if i > self.nCurWorldClass then
      bAllReceived = false
    end
    local bUnReceive = PlayerData.Base:GetWorldClassState(i) and i <= self.nCurWorldClass
    if bUnReceive then
      bAllReceived = false
    end
    bCanReceive = bCanReceive or bUnReceive
  end
  if nCurStageId ~= self.itemData.nId and self.nCurWorldClass < self.itemData.nMinLevel then
    self.nState = worldClass_Lock
  elseif bAllReceived then
    self.nState = worldClass_Received
  elseif bCanReceive then
    self.nState = worldClass_CanReceive
  else
    self.nState = worldClass_Going
  end
  local mapCfg = ConfigTable.GetData("DemonAdvance", self.itemData.nId)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtLevelUp, orderedFormat(ConfigTable.GetUIText("WorldClass_Level_LevelUp_Title"), mapCfg.AdvanceName))
    local nAllProgress = self.itemData.nMaxLevel - self.itemData.nMinLevel + 1
    local nCurProgress = 0
    if self.nState == worldClass_Received then
      nCurProgress = nAllProgress
    elseif self.nState == worldClass_Lock then
      nCurProgress = 0
    else
      nCurProgress = math.min(self.nCurWorldClass - self.itemData.nMinLevel + 1, nAllProgress)
    end
    self._mapNode.rtBarFill.sizeDelta = Vector2(totalLength * (nCurProgress / nAllProgress), totalHeight)
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%s/%s", nCurProgress, nAllProgress))
  end
  self:RefreshRewardState()
  RedDotManager.RegisterNode(RedDotDefine.WorldClass_LevelUp, self.itemData.nId, self._mapNode.redDot, nil, nil, true)
end

function WorldClassItemCtrl:SetAdvanceItem()
  self.nState = 0
  self._mapNode.rtAdvance.gameObject:SetActive(true)
  self._mapNode.rtLevelUp.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtBtnReceive, ConfigTable.GetUIText("WorldClass_Level_Advance"))
  local mapCfg = ConfigTable.GetData("DemonAdvance", self.itemData.nId)
  if mapCfg ~= nil then
    local tbQuestList = PlayerData.Quest:GetDemonQuestData(mapCfg.AdvanceQuestGroup, self.itemData.nId)
    local nAllProgress = #tbQuestList
    local nCurProgress = 0
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nCurStageId = PlayerData.Base:GetCurWorldClassStageId()
    if nCurStageId == self.itemData.nId and nCurWorldClass == self.itemData.nMaxLevel then
      for _, v in ipairs(tbQuestList) do
        if v.nStatus ~= 0 then
          nCurProgress = nCurProgress + 1
        end
      end
      if nAllProgress <= nCurProgress then
        self.nState = worldClass_CanReceive
      else
        self.nState = worldClass_Going
      end
    elseif nCurWorldClass < self.itemData.nMinLevel then
      nCurProgress = 0
      self.nState = worldClass_Lock
    elseif nCurWorldClass >= self.itemData.nMinLevel then
      nCurProgress = nAllProgress
      self.nState = worldClass_Received
    end
    for k, v in ipairs(self._mapNode.imgMissionBg) do
      v.gameObject:SetActive(k <= nAllProgress)
      if k <= nAllProgress then
        local imgMission = v.gameObject.transform:Find("imgMission")
        imgMission.gameObject:SetActive(k <= nCurProgress)
      end
    end
    NovaAPI.SetTMPText(self._mapNode.txtAdvance, orderedFormat(ConfigTable.GetUIText("WorldClass_Level_Advance_Title"), mapCfg.AdvanceName))
    self.tbReward = {}
    for i = 1, 4 do
      local itemId = mapCfg["Item" .. i]
      local nRarity = 0
      local mapCfg = ConfigTable.GetData_Item(itemId)
      if mapCfg ~= nil then
        nRarity = mapCfg.Rarity
      end
      self._mapNode.btnRewardItem[i].gameObject:SetActive(0 < itemId)
      if itemId ~= 0 then
        local itemCount = mapCfg["Qty" .. i]
        table.insert(self.tbReward, {
          nId = itemId,
          nCount = itemCount,
          nRarity = nRarity
        })
        self._mapNode.goRewardItem[i]:SetItem(itemId, nil, itemCount, nil, self.nState == worldClass_Received, nil, nil, true)
      end
    end
    table.sort(self.tbReward, function(a, b)
      if a.nRarity == b.nRarity then
        return a.nId < b.nId
      end
      return a.nRarity < b.nRarity
    end)
  end
  self:RefreshRewardState()
  RedDotManager.RegisterNode(RedDotDefine.WorldClass_Advance, self.itemData.nId, self._mapNode.redDot, nil, nil, true)
end

function WorldClassItemCtrl:RefreshRewardState()
  self._mapNode.goingTip.gameObject:SetActive(self.nState == worldClass_Going or self.nState == worldClass_CanReceive)
  self._mapNode.imgComplete.gameObject:SetActive(self.nState == worldClass_Received)
  self._mapNode.txtLock.gameObject:SetActive(self.nState == worldClass_Lock)
  if self.goBtnFastReceive == nil then
    return
  end
  if self.handlerBtn == nil then
    self.handlerBtn = {}
  end
  self.goBtnFastReceive.gameObject:SetActive(self.nState == worldClass_CanReceive)
  self.goBtnFastReceive.onClick:RemoveAllListeners()
  self.handlerBtn[1] = ui_handler(self, self.OnBtnClick_Receive)
  self.goBtnFastReceive.onClick:AddListener(self.handlerBtn[1])
  self.goBtnFastReceiveGray.gameObject:SetActive(self.nState ~= worldClass_CanReceive)
  self.goBtnFastReceiveGray.onClick:RemoveAllListeners()
  self.handlerBtn[2] = ui_handler(self, self.OnBtnClick_ReceiveGray)
  self.goBtnFastReceiveGray.onClick:AddListener(self.handlerBtn[2])
  if self.nState == worldClass_Received then
    self.rtLevelLsv.offsetMin = self.nLsvDefaultHeight
    self.goBtnFastReceive.gameObject:SetActive(false)
    self.goBtnFastReceiveGray.gameObject:SetActive(false)
  else
    local v2 = Vector2(self.nLsvDefaultHeight.x, self.nLsvDefaultHeight.y + 100)
    self.rtLevelLsv.offsetMin = v2
  end
end

function WorldClassItemCtrl:Awake()
end

function WorldClassItemCtrl:OnEnable()
end

function WorldClassItemCtrl:OnDisable()
  if self.goBtnFastReceive ~= nil then
    self.handlerBtn[1] = nil
    self.handlerBtn[2] = nil
    self.handlerBtn = {}
  end
end

function WorldClassItemCtrl:OnDestroy()
end

function WorldClassItemCtrl:OnBtnClick_Receive()
  if self.itemData.nType == AllEnum.WorldClassType.LevelUp then
    local function callback()
      local nMaxLevel = math.min(self.nCurWorldClass, self.itemData.nMaxLevel)
      
      PlayerData.State:ResetIntervalWorldClassRewardState(self.itemData.nMinLevel, nMaxLevel)
      EventManager.Hit("ReceiveWorldClassLevelReward")
    end
    
    PlayerData.Base:SendPlayerWorldClassRewardReceiveReq(nil, self.itemData.nId, callback, self.itemData.nMinLevel)
  else
    PlayerData.Base:SendPlayerWorldClassAdvanceReq(self.itemData.nId)
  end
end

function WorldClassItemCtrl:OnBtnClick_ReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
end

function WorldClassItemCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nTid = self.tbReward[nIndex].nId
  UTILS.ClickItemGridWithTips(nTid, btn.gameObject.transform, false, true, false)
end

function WorldClassItemCtrl:OnEvent_ReceiveWorldClassLevelReward()
  if self.itemData ~= nil and self.itemData.nType == AllEnum.WorldClassType.LevelUp then
    self:SetLevelUpItem()
  end
end

return WorldClassItemCtrl
