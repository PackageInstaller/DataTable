_class("UIN25VampireLevel", UIController)
UIN25VampireLevel = UIN25VampireLevel

function UIN25VampireLevel:Constructor()
end

function UIN25VampireLevel:LoadDataOnEnter(TT, res, uiParams)
  self._activityConst = UIActivityN25Const:New()
  self._activityConst:LoadData(TT, res)
  self._selectItemId = self._activityConst:GetShowFirstTaskIndex()
  self.mCampaign = self:GetModule(CampaignModule)
  self._data = self.mCampaign:GetN25Data()
  self._data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N25, res)
  YIELD(TT)
end

function UIN25VampireLevel:OnShow(uiParams)
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self.infoContent = self:GetUIComponent("UISelectObjectPath", "InfoContent")
  self.items = self:GetUIComponent("UISelectObjectPath", "item")
  self.titletxt = self:GetUIComponent("UILocalizationText", "titletxt")
  self.btntxt = self:GetUIComponent("UILocalizationText", "btntxt")
  local TopBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtns = TopBtn:SpawnObject("UINewCommonTopButton")
  self.sv = self:GetUIComponent("ScrollRect", "sv")
  self.passed = self:GetGameObject("passed")
  self.infoObj = self:GetGameObject("info")
  self.itemname = self:GetUIComponent("UILocalizationText", "itemname")
  self.itemcount = self:GetUIComponent("UILocalizationText", "itemcount")
  self.iteminfo = self:GetUIComponent("UILocalizationText", "iteminfo")
  self.infoitems = self:GetUIComponent("UISelectObjectPath", "infoitem")
  backBtns:SetData(function()
    local isOpen = self._data:GetActivityCampaign():CheckCampaignOpen()
    if not isOpen then
      ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
      self:SwitchState(UIStateType.UIMain)
    else
      self:SwitchState(UIStateType.UIN25VampireMain)
    end
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self:Flush()
  self:ShowItemInfo()
end

function UIN25VampireLevel:OnHide()
  self:_PlayAnimOut()
end

function UIN25VampireLevel:_PlayAnimOut()
  self.anim = self:GetUIComponent("Animation", "ani")
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "_PlayAnimOut()"
    self:Lock(lockName)
    self.anim:Play("uieffanim_UIN25VampireLevel_out")
    YIELD(TT, 1000)
    self:UnLock(lockName)
    self:CloseDialog()
  end, self)
end

function UIN25VampireLevel:Flush()
  local comp, compInfo = self._activityConst:GetBloodSuckerComponent()
  self.data = Cfg.cfg_component_bloodsucker({
    ComponentID = comp:GetComponentCfgId()
  })
  table.sort(self.data, function(a, b)
    return a.Index < b.Index
  end)
  self._selectItemId = self._selectItemId > #self.data and #self.data or self._selectItemId
  while self._selectItemId > 1 do
    if self:CheckIsTimeLock(self.data[self._selectItemId].UnLockTime) then
      self._selectItemId = self._selectItemId - 1
    else
      break
    end
  end
  local len = table.count(self.data)
  self.poolContent:SpawnObjects("UIN25VampireLevelItem", len)
  local uis = self.poolContent:GetAllSpawnList()
  local index = 0
  self:StartTask(function(TT)
    local lockName = self:GetName() .. "Flush"
    self:Lock(lockName)
    for i, data in pairs(self.data) do
      index = index + 1
      local ui = uis[index]
      ui:Flush(data, self, self._activityConst, self.sv, self._selectItemId == index)
      YIELD(TT)
    end
    YIELD(TT)
    self:UnLock(lockName)
    if self._selectItemId > 5 and 5 < len then
      self.sv:DOVerticalNormalizedPos(0, 0.1, false)
    end
  end, self)
  self.titletxt:SetText(StringTable.Get("str_n25_level_info"))
  self.btntxt:SetText(StringTable.Get("str_n25_level_btn"))
end

function UIN25VampireLevel:ShowItemInfo()
  self.info = self.data[self._selectItemId]
  self.infoContent:SpawnObjects("UIN25VampireLevelInfoItem", 1)
  local uis = self.infoContent:GetAllSpawnList()
  for i, item in pairs(uis) do
    item:Flush(self.info)
  end
  self.items:SpawnObjects("UIItem", #self.info.FirstPassRewards)
  uis = self.items:GetAllSpawnList()
  for i, item in pairs(uis) do
    item:SetForm(UIItemForm.Base)
    local award = self.info.FirstPassRewards
    local cfgItem = Cfg.cfg_item[award[1][1]]
    local itemId = cfgItem.ID
    local icon = cfgItem.Icon
    local quality = cfgItem.Color
    local count = award[1][2]
    local text1 = count <= 1 and "" or StringTable.Get("str_shop_good_count") .. count
    item:SetData({
      icon = icon,
      quality = quality,
      text1 = text1,
      itemId = itemId
    })
    item:SetClickCallBack(function(go)
      self:OnItemClick()
    end)
  end
  local missionId = self.data[self._selectItemId].CampaignMissionID
  self.passed:SetActive(self._activityConst:CheckBloodSuckerMissionPassed(missionId))
end

function UIN25VampireLevel:BtnChallengeOnClick(go)
  self:StartTask(function(TT)
    if self:CheckIsTimeLock(self.data[self._selectItemId].UnLockTime) then
      self._selectItemId = self._selectItemId - 1
    end
    local missionId = self.data[self._selectItemId].CampaignMissionID
    UIN25VampireUtil.EnterBattle(TT, missionId)
  end)
end

function UIN25VampireLevel:CheckIsTimeLock(UnLockTime)
  if not UnLockTime then
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local unLockTime = loginModule:GetTimeStampByTimeStr(UnLockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  return curTime < unLockTime
end

function UIN25VampireLevel:OnSelectItem(id)
  self._selectItemId = id
  self:ShowItemInfo()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnVampireChallengeTaskItemClick, id)
end

function UIN25VampireLevel:CloseOnClick(id)
end

function UIN25VampireLevel:InfoOnClick(id)
  self.infoObj:SetActive(false)
end

function UIN25VampireLevel:OnItemClick()
  self.infoObj:SetActive(true)
  self.infoitems:SpawnObjects("UIItem", #self.info.FirstPassRewards)
  local award = self.info.FirstPassRewards
  local cfgItem = Cfg.cfg_item[award[1][1]]
  local uis = self.infoitems:GetAllSpawnList()
  for i, item in pairs(uis) do
    item:SetForm(UIItemForm.Base)
    local itemId = cfgItem.ID
    local icon = cfgItem.Icon
    local quality = cfgItem.Color
    item:SetData({
      icon = icon,
      quality = quality,
      text1 = "",
      itemId = itemId
    })
  end
  local count = award[1][2]
  local text1 = count <= 1 and "" or StringTable.Get("str_shop_good_count") .. count
  self.itemname:SetText(StringTable.Get(cfgItem.Name))
  self.itemcount:SetText(text1)
  self.iteminfo:SetText(StringTable.Get(cfgItem.Intro))
end
