local RaidCountCtrl = class("RaidCountCtrl", BaseCtrl)
RaidCountCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Title_Raid"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtRaidCountCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_RaidCount"
  },
  txtRaidCount = {sComponentName = "TMP_Text"},
  txtRaidTip = {sComponentName = "TMP_Text", sLanguageId = "Raid_Tip"},
  imgEnergy = {sComponentName = "Image"},
  txtEnergyCount = {sComponentName = "TMP_Text"},
  Slider = {
    sComponentName = "Slider",
    callback = "OnValueChange_Slider"
  },
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnMin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Min"
  },
  btnMax = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Max"
  },
  btnGrayAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MaxGray"
  },
  btnGrayReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MinGray"
  },
  btnGrayMax = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MaxGray"
  },
  btnGrayMin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_MinGray"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Raid"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  imgDoubleDrop = {},
  txtDoubleDrop = {sComponentName = "TMP_Text"},
  rtReengagement = {},
  txtReengagementTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_DoubleDrop_Count"
  },
  txtReengagement = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_DoubleDrop_Tip"
  }
}
RaidCountCtrl._mapEventConfig = {
  [EventId.UpdateEnergy] = "OnEvent_Energy"
}

function RaidCountCtrl:Open(nId, nEnergy, nType, nActId)
  self.nId = nId
  self.nEnergy = nEnergy
  self.nSelectCount = 1
  self.nType = nType
  self.nActId = nActId
  self.nRemainDoubleCount = 0
  for i = 1, 2 do
    self:SetSprite_Coin(self._mapNode.imgEnergy, AllEnum.CoinItemId.Energy)
  end
  self:RefreshDoubleCount()
  self:RefreshData()
  self:RefreshCount()
  self:RefreshBar()
  self:PlayInAni()
end

function RaidCountCtrl:RefreshData()
  self.nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  local nCount = math.floor(self.nCurEnergy / self.nEnergy)
  if self.nRemainDoubleCount > 0 then
    self.nMaxCount = self.nRemainDoubleCount
  else
    self.nMaxCount = 1 < nCount and nCount or 1
  end
  NovaAPI.SetSliderMaxValue(self._mapNode.Slider, self.nMaxCount)
  NovaAPI.SetSliderMinValue(self._mapNode.Slider, 1)
  NovaAPI.SetSliderInteractable(self._mapNode.Slider, self.nMaxCount > 1)
end

function RaidCountCtrl:RefreshCount()
  local nCost = self.nSelectCount * self.nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtRaidCount, self.nSelectCount)
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, nCost)
  NovaAPI.SetTMPColor(self._mapNode.txtEnergyCount, nCost > self.nCurEnergy and Red_Unable or Blue_Normal)
  self:RefreshAddButton(self.nSelectCount < self.nMaxCount)
  self:RefreshReduceButton(self.nSelectCount > 1)
end

function RaidCountCtrl:RefreshAddButton(bAble)
  self._mapNode.btnGrayAdd.gameObject:SetActive(not bAble)
  self._mapNode.btnAdd.gameObject:SetActive(bAble)
  self._mapNode.btnGrayMax.gameObject:SetActive(not bAble)
  self._mapNode.btnMax.gameObject:SetActive(bAble)
end

function RaidCountCtrl:RefreshReduceButton(bAble)
  self._mapNode.btnGrayReduce.gameObject:SetActive(not bAble)
  self._mapNode.btnReduce.gameObject:SetActive(bAble)
  self._mapNode.btnGrayMin.gameObject:SetActive(not bAble)
  self._mapNode.btnMin.gameObject:SetActive(bAble)
end

function RaidCountCtrl:RefreshBar()
  NovaAPI.SetSliderValue(self._mapNode.Slider, self.nSelectCount)
end

function RaidCountCtrl:RefreshDoubleCount()
  self._mapNode.txtRaidTip.gameObject:SetActive(true)
  self._mapNode.rtReengagement.gameObject:SetActive(false)
  self._mapNode.imgDoubleDrop.gameObject:SetActive(false)
  local actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Double)
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount() or 0
  local bShowNormalDouble = false
  if actData ~= nil and actData:CheckActShow() then
    local tbInstanceType = actData:GetInstanceType()
    if 0 < table.indexof(tbInstanceType, self.nType) then
      local nDoubleCount, nMaxDoubleCount = actData:GetDoubleDropsTimes()
      bShowNormalDouble = 0 < nMaxDoubleCount - nDoubleCount
    end
  end
  if bShowNormalDouble then
    self._mapNode.imgDoubleDrop.gameObject:SetActive(true)
    local nDoubleCount, nMaxDoubleCount = actData:GetDoubleDropsTimes()
    local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
    local nCount = math.floor(nCurEnergy / self.nEnergy)
    local nRemainDoubleCount = nMaxDoubleCount - nDoubleCount
    if 0 < nRemainDoubleCount then
      self.nRemainDoubleCount = math.max(math.min(nRemainDoubleCount, nCount), 1)
    else
      self.nRemainDoubleCount = 0
    end
    local str = actData:GetDropString()
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDrop, str)
  elseif 0 < nReengagementCount then
    local tbInstanceType = PlayerData.Reengagement:GetDoubleFuncType()
    if 0 < table.indexof(tbInstanceType, self.nType) then
      self._mapNode.txtRaidTip.gameObject:SetActive(false)
      self._mapNode.rtReengagement.gameObject:SetActive(true)
      local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
      local nCount = math.floor(nCurEnergy / self.nEnergy)
      self.nRemainDoubleCount = math.max(math.min(nReengagementCount, nCount), 1)
      local sStr = ConfigTable.GetUIText("Reengagement_DoubleDrop_Count") .. nReengagementCount
      NovaAPI.SetTMPText(self._mapNode.txtReengagementTip, sStr)
    end
  end
end

function RaidCountCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function RaidCountCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  
  local function closeCall()
    self:Close()
  end
  
  self:AddTimer(1, 0.2, closeCall, true, true, true)
end

function RaidCountCtrl:Close()
  self.gameObject:SetActive(false)
end

function RaidCountCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function RaidCountCtrl:OnEnable()
end

function RaidCountCtrl:OnDisable()
end

function RaidCountCtrl:OnDestroy()
end

function RaidCountCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("RaidShowPop", false)
end

function RaidCountCtrl:OnValueChange_Slider(_, value)
  self.nSelectCount = math.ceil(value)
  self:RefreshCount()
end

function RaidCountCtrl:OnBtnClick_Add(btn)
  local nRemain = self.nMaxCount - self.nSelectCount
  if nRemain <= 0 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nSelectCount = self.nSelectCount + 1
  elseif btn.Operate_Type == 3 then
    local nAdd = 2 ^ btn.CurrentGear
    local nAfterRemain = nRemain - nAdd
    if nAfterRemain < 0 then
      nAdd = nRemain
    end
    self.nSelectCount = math.floor(self.nSelectCount + nAdd)
  end
  self:RefreshCount()
  self:RefreshBar()
end

function RaidCountCtrl:OnBtnClick_Min(btn)
  self.nSelectCount = 1
  self:RefreshCount()
  self:RefreshBar()
end

function RaidCountCtrl:OnBtnClick_Max(btn)
  self.nSelectCount = self.nMaxCount
  self:RefreshCount()
  self:RefreshBar()
end

function RaidCountCtrl:OnBtnClick_Reduce(btn)
  if self.nSelectCount <= 1 then
    return
  end
  if btn.Operate_Type == 0 then
    self.nSelectCount = self.nSelectCount - 1
  elseif btn.Operate_Type == 3 then
    self.nSelectCount = math.floor(self.nSelectCount - 2 ^ btn.CurrentGear)
  end
  if self.nSelectCount < 1 then
    self.nSelectCount = 1
  end
  self:RefreshCount()
  self:RefreshBar()
end

function RaidCountCtrl:OnBtnClick_Confirm(btn)
  local nCost = self.nSelectCount * self.nEnergy
  if nCost > self.nCurEnergy then
    function self.closeCallback()
      local function callback()
        EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
        
        EventManager.Hit(EventId.ClosePanel, PanelId.Raid)
      end
      
      EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
    end
    
    self.closeCallback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
    return
  end
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = mapCfg and mapCfg.Exp or 0
  local mapBefore = {
    nLevel = nWorldClass,
    nExp = PlayerData.Base:GetWorldExp(),
    nMaxLevel = PlayerData.Base:GetMaxWorldClass(),
    nMaxExp = nFullExp
  }
  
  local function callback(mapData, mapChangeInfo)
    EventManager.Hit("RaidSuccess")
    EventManager.Hit("RaidShowReward", mapData, mapBefore, mapChangeInfo)
  end
  
  if self.nType == GameEnum.instanceType.DailyInstance then
    PlayerData.DailyInstance:SendDailyInstanceRaidReq(self.nId, self.nSelectCount, callback)
  elseif self.nType == GameEnum.instanceType.RegionBoss then
    PlayerData.RogueBoss:Sweep(self.nId, self.nSelectCount, callback)
  elseif self.nType == GameEnum.instanceType.CharGemInstance then
    PlayerData.EquipmentInstance:SendEquipmentInstanceRaidReq(self.nId, self.nSelectCount, callback)
  elseif self.nType == GameEnum.instanceType.SkillInstance then
    PlayerData.SkillInstance:SendSkillInstanceRaidReq(self.nId, self.nSelectCount, callback)
  elseif self.nType == 0 then
    local activityLevelsData = PlayerData.Activity:GetActivityDataById(self.nActId)
    activityLevelsData:SendActivityLevelsSweepReq(self.nActId, self.nId, self.nSelectCount, callback)
  end
end

function RaidCountCtrl:OnBtnClick_MinGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Count_Min"))
end

function RaidCountCtrl:OnBtnClick_MaxGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Crafting_Count_Max"))
end

function RaidCountCtrl:OnEvent_Energy()
  if self.nId == nil then
    return
  end
  self:RefreshDoubleCount()
  self:RefreshData()
  self:RefreshCount()
end

return RaidCountCtrl
