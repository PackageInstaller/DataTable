local RedType = RedPointDataUtils.RedType
local AwakerPotencyState = CommonDefine.AwakerPotencyState
local AwakerPage = CommonDefine.AwakerPage
local AwakerPotencyComp, Super = System.NewComponent("AwakerPotencyComp", AwakerBasePageComp)

function AwakerPotencyComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Potency_MainResource(uiNode)
  self.model = model
end

function AwakerPotencyComp:OnBind(binder)
  self.binder = binder
  self.potencyModel = binder:createModel(AwakerPotencyModel, self.model)
  self.skillModel = binder:createModel(AwakerSkillModel, self.model)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerTitle(tid)
    return name
  end)
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Career_Name, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    do return self.model.GetSchoolName, self.model end
    return self.model.GetSchoolName, self.model, config.School
  end)
  binder:BindRawTable(function()
    return self.potencyModel.potencyList
  end, function(cb, n, _, index)
    if type(index) ~= "number" then
      return
    end
    local obj = self.ui["UI_Awaker_Item_Potency_Point_Small_" .. index]
    if not obj then
      return
    end
    
    local function OnClick(potency, potencyIndex)
      local page = self.model.page
      if page ~= AwakerPage.Potency and page ~= AwakerPage.PotencyDetail then
        return
      end
      if not potency then
        return
      end
      local curPotency = self.potencyModel:GetSelectPotency()
      local curPotencyIndex = self.potencyModel:GetSelectPotencyIndex()
      if curPotency ~= potency or curPotencyIndex ~= potencyIndex then
        AudioManager.Instance:PostSoundEvent("UI_AWAKER_SKILL_TESTCHANGE")
      end
      self.potencyModel:SetSelectPotency(potency)
      self.potencyModel:SetSelectPotencyIndex(potencyIndex)
      self.potencyModel:SetSelectAttrPotency(false)
      self.model:SetAwakerPage(AwakerPage.PotencyDetail)
    end
    
    local resource = self.potencyModel:GetPotencyItemResource()
    local itemData = {
      potencyModel = self.potencyModel,
      potency = n.tid,
      index = n.index,
      clickCb = OnClick
    }
    cb:BindComponent(AwakerPotencyListItem(obj, resource, itemData))
  end)
  binder:BindToRaw(function(cb, n, o)
    if nil == n then
      return
    end
    if nil == o then
      return
    end
    local nPage = n[1]
    local nSelectAwakerId = n[2]
    if not nPage or not nSelectAwakerId then
      return
    end
    local oPage = o[1]
    local oSelectAwakerId = o[2]
    if not oPage or not oSelectAwakerId then
      return
    end
    if nPage == AwakerPage.Potency and oPage <= AwakerPage.Story then
      cb:ListViewJumpToIndex(self.ui.ScrollView_Potency_List, self.potencyModel.nextActivePotencyIndex)
    elseif nPage == AwakerPage.Potency and nSelectAwakerId ~= oSelectAwakerId then
      cb:ListViewJumpToIndex(self.ui.ScrollView_Potency_List, self.potencyModel.nextActivePotencyIndex)
    end
  end, function()
    local selectAwakerId = self.model.selectAwakerId
    return {
      self.model.page,
      selectAwakerId
    }
  end)
  self.ui.UI_Awaker_Item_Potency_Detail:SetActive(false)
  binder:BindComponent(AwakerPotencyDetailComp(self.ui.UI_Awaker_Item_Potency_Detail, self.potencyModel, self.skillModel))
  self:_BindAttrPotencyComponents(binder)
end

function AwakerPotencyComp:_BindAttrPotencyComponents(binder)
  self.ui.Fulllevel:SetActive(true)
  binder:BindToText(self.ui.Text_Name, System.fn(self, self._GetAttrPotencyName))
  binder:BindToTextColor(self.ui.Text_Name, System.fn(self, self._GetAttrPotencyTextNameColor))
  binder:BindToText(self.ui.Text_Value, System.fn(self, self._GetAttrPotencyActiveNum))
  binder:BindToVisible(self.ui.Text_Value, function()
    return not self:_IsPotencyMax() or not AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.potencyModel.selectAwakerId)
  end)
  binder:BindToVisible(self.ui.Image_Max, function()
    return self:_IsPotencyMax() and AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.potencyModel.selectAwakerId)
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.potencyModel.hasSelectAttrPotency
  end)
  binder:BindToVisible(self.ui.Image_Lock, System.fn(self, self._ShowAttrPotencyLocked))
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClickPromoteAttrPotency))
  self:_BindPotencyRedComp()
  binder:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self.OnUpdateBagEvent))
end

function AwakerPotencyComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerPotencyComp:OnUpdateBagEvent()
  self:RefreshAwakerRed()
end

function AwakerPotencyComp:RefreshAwakerRed()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return
  end
  local awakerData = AwakerDataUtils.GetAwakerData(self.potencyModel.selectAwakerId)
  if not awakerData then
    return
  end
  RedPointDataUtils.UpdateAwakerRed(awakerData, true)
end

function AwakerPotencyComp:_BindPotencyRedComp()
  local isFirstOpen = true
  self.binder:BindToRaw(function(cbinder, redValue)
    local delayTime = CommonDefine.AwakerRedUpdateDelay + 0.1
    if not redValue then
      delayTime = 0
    end
    if isFirstOpen then
      isFirstOpen = false
      delayTime = 0
    end
    cbinder:BindTimer(delayTime, 0, nil, function()
      cbinder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
        return redValue
      end))
    end)
  end, function()
    do return self._GetAttrPotencyRed end
    return self._GetAttrPotencyRed, self
  end)
end

function AwakerPotencyComp:_GetAttrPotencyRed()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  local awakerTid = self.potencyModel.selectAwakerId
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(awakerTid)
  if attrPotencyStartIndex > self.potencyModel.nextActivePotencyIndex then
    return false
  end
  do return RedPointDataUtils.GetRedPointState, RedType.AwakerPotency end
  return RedPointDataUtils.GetRedPointState, RedType.AwakerPotency, {awakerTid}, awakerTid
end

function AwakerPotencyComp:_GetAttrPotencyName()
  local selectAwakerId = self.potencyModel.selectAwakerId
  if 0 == selectAwakerId then
    return
  end
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  local potencyData
  if attrPotencyStartIndex >= self.potencyModel.nextActivePotencyIndex then
    potencyData = self.potencyModel.totalPotencyList[attrPotencyStartIndex]
  else
    potencyData = self.potencyModel.totalPotencyList[self.potencyModel.curActivePotencyIndex]
  end
  if not potencyData then
    return
  end
  do return self.potencyModel.GetPotencyName, self.potencyModel end
  return self.potencyModel.GetPotencyName, self.potencyModel, potencyData.tid
end

function AwakerPotencyComp:_GetAttrPotencyTextNameColor()
  local selectAwakerId = self.potencyModel.selectAwakerId
  if 0 == selectAwakerId then
    return CommonDefine.ColorType.Dark
  end
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  local potencyState = self.potencyModel:GetPotencyActiveState(attrPotencyStartIndex)
  if potencyState == AwakerPotencyState.Active then
    return CommonDefine.ColorType.Light
  end
  return CommonDefine.ColorType.Dark
end

function AwakerPotencyComp:_GetAttrPotencyActiveNum()
  local selectAwakerId = self.potencyModel.selectAwakerId
  if 0 == selectAwakerId then
    return
  end
  local activeNum = self.potencyModel:GetAwakerAttrPotencyActiveNum(selectAwakerId)
  if activeNum <= 0 then
    return
  end
  return activeNum
end

function AwakerPotencyComp:_ShowAttrPotencyLocked()
  local page = self.model.page
  if page ~= AwakerPage.Potency and page ~= AwakerPage.PotencyDetail then
    return true
  end
  local selectAwakerId = self.potencyModel.selectAwakerId
  if 0 == selectAwakerId then
    return true
  end
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(selectAwakerId)
  return attrPotencyStartIndex > self.potencyModel.curActivePotencyIndex
end

function AwakerPotencyComp:_OnClickPromoteAttrPotency()
  local page = self.model.page
  if page ~= AwakerPage.Potency and page ~= AwakerPage.PotencyDetail then
    return
  end
  local selectAwakerId = self.potencyModel.selectAwakerId
  if 0 == selectAwakerId then
    return
  end
  self.potencyModel:SetSelectAttrPotency(true)
  local startIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(self.potencyModel.selectAwakerId)
  local nextActivePotencyIndex = math.max(startIndex, self.potencyModel.nextActivePotencyIndex)
  local list = AwakerDataUtils.GetAwakerPotencyList(selectAwakerId)
  local nextActivePotency = list[nextActivePotencyIndex]
  if not nextActivePotency then
    return
  end
  local curPotency = self.potencyModel:GetSelectPotency()
  local curPotencyIndex = self.potencyModel:GetSelectPotencyIndex()
  if curPotency ~= nextActivePotency.tid or curPotencyIndex ~= nextActivePotencyIndex then
    AudioManager.Instance:PostSoundEvent("UI_AWAKER_SKILL_TESTCHANGE")
  end
  self.potencyModel:SetSelectPotency(nextActivePotency.tid)
  self.potencyModel:SetSelectPotencyIndex(nextActivePotencyIndex)
  if page ~= AwakerPage.PotencyDetail then
    self.model:SetAwakerPage(AwakerPage.PotencyDetail)
  end
end

function AwakerPotencyComp:OnOpen()
  if self:_IsPotencyMax() and AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.potencyModel.selectAwakerId) then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name .. 126878, 126878, true)
  end
  if self.model:HasOwnedSelectAwaker() then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name, 81372)
  end
end

function AwakerPotencyComp:GetOpenAnim()
  return "UI_Awaker_Panel_Main_Potency_Open", nil
end

function AwakerPotencyComp:GetCloseAnim()
  return "UI_Awaker_Panel_Main_Potency_Close", nil
end

function AwakerPotencyComp:GetEnterDetailAnim()
  return "UI_Awaker_Panel_Main_PotencyDetail_Open", nil
end

function AwakerPotencyComp:GetExitDetailAnim()
  return "UI_Awaker_Panel_Main_PotencyDetail_Close", nil
end

function AwakerPotencyComp:_IsPotencyMax()
  local maxPassivePotencyNum = AwakerDataUtils.GetAwakerPassivePotencyMaxNum(self.potencyModel.selectAwakerId)
  local maxPotencyIndex = AwakerDataUtils.GetMaxPotencyIndex(self.potencyModel.selectAwakerId)
  return maxPotencyIndex <= (self:_GetAttrPotencyActiveNum() or 0) + maxPassivePotencyNum
end

function AwakerPotencyComp:OnExitDetail()
  if self:_IsPotencyMax() and AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(self.potencyModel.selectAwakerId) then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name .. 126878, 126878, true)
  end
  self.potencyModel:SetSelectPotency(0)
  self.potencyModel:SetSelectAttrPotency(false)
end

return AwakerPotencyComp
