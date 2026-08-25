local RedType = RedPointDataUtils.RedType
local RedAttrType = RedPointDataUtils.RedAttrType
local AwakerPage = CommonDefine.AwakerPage
local typeof = _ENV.typeof
local Z1ToggleGroup = CS.Z1Client.Z1ToggleGroup
local AwakerMiniListComp, Super = System.NewComponent("AwakerMiniListComp")

function AwakerMiniListComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Minihead_ListResource(uiNode)
  self.model = model
end

function AwakerMiniListComp:OnBind(binder)
  self.binder = binder
  self.toggleGroup = self.ui.Group_Tab_Toggle_List:GetComponent(typeof(Z1ToggleGroup))
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_Head_List, function()
    return self.model.awakerList
  end, function(itemBinder, obj, index)
    local data = self.model.awakerList[index]
    
    local function clickCallback(tid)
      if not tid then
        return
      end
      RedPointDataUtils.ReqRemoveData(RedType.Awaker, RedAttrType.IsNew, tid)
      self.model:SetSelectAwakerId(tid)
      if not self.model:HasOwnedAwaker(tid) then
        local page = self.model.page
        if page == AwakerPage.Weapon or page == AwakerPage.Trinket then
          self.model:SetAwakerPage(AwakerPage.Detail)
        end
      end
    end
    
    local itemData = {
      awakerData = data,
      callback = clickCallback,
      model = self.model
    }
    itemBinder:BindComponent(AwakerMiniListItem(obj, itemData))
  end)
  binder:BindToRaw(function(_, nPage, oPage)
    if not nPage then
      return
    end
    if oPage and nPage == AwakerPage.List and oPage >= AwakerPage.Detail then
      self.toggleGroup.allowSwitchOff = true
    end
    if nPage >= AwakerPage.Detail then
      if self.toggleGroup.allowSwitchOff then
        self.toggleGroup.allowSwitchOff = false
      end
      if oPage and oPage == AwakerPage.List and nPage == AwakerPage.Detail then
        binder:SetZ1Toggle(self.ui.Toggle_Detail, true)
      end
    end
  end, function()
    return self.model.page
  end)
  
  local function IsPageCorrect()
    return self.model.page >= AwakerPage.Detail
  end
  
  binder:SetZ1Toggle(self.ui.Toggle_Detail, true)
  binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Detail, function()
    local awakerTid = self.model.selectAwakerId
    local breakthroughRedData = AwakerRedUtils.GetBreakthroughRedData(awakerTid)
    if breakthroughRedData and 1 == breakthroughRedData.red then
      do return RedPointDataUtils.ShowRedPointState end
      return RedPointDataUtils.ShowRedPointState, breakthroughRedData, nil, nil
    end
    local state = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.AwakerBreakthrough, {awakerTid})
    if state then
      return state
    end
    if RedPointDataUtils.HasAwakerAffectionRedShow(awakerTid) then
      return "red"
    end
    if RedPointDataUtils.IsAwakerAffectionBreakthroughRedShow(awakerTid) then
      return "red"
    end
    if self.model:GetShowOriginBtn() and RedPointDataUtils.CanUnlock_OriAwaker(awakerTid) then
      return "red"
    end
    if self:_NeedShowPotentialBtn(self.model.selectAwakerId) and AwakerDataUtils.CheckCostItemEnough(self.model.selectAwakerId) then
      return "red"
    end
    return false
  end))
  binder:BindToZ1Toggle(self.ui.Toggle_Detail, nil, function(isOn)
    if not IsPageCorrect() then
      return
    end
    if isOn then
      self.model:SetAwakerPage(AwakerPage.Detail)
    end
  end, function()
    return self.model.page == AwakerPage.Detail
  end)
  binder:SetZ1Toggle(self.ui.Toggle_Skill, false)
  binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Skill, function()
    return false
  end))
  binder:BindToZ1Toggle(self.ui.Toggle_Skill, nil, function(isOn)
    if not IsPageCorrect() then
      return
    end
    if isOn then
      self.model:SetAwakerPage(AwakerPage.Skill)
    end
  end, function()
    return self.model.page == AwakerPage.Skill
  end)
  binder:SetZ1Toggle(self.ui.Toggle_Potency, false)
  binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Potency, function()
    local awakerTid = self.model.selectAwakerId
    do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.AwakerPotency end
    return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.AwakerPotency, {awakerTid}, awakerTid
  end))
  binder:BindToZ1Toggle(self.ui.Toggle_Potency, nil, function(isOn)
    if not IsPageCorrect() then
      return
    end
    if isOn then
      self.model:SetAwakerPage(AwakerPage.Potency)
    end
  end, function()
    return self.model.page == AwakerPage.Potency
  end)
  binder:SetZ1Toggle(self.ui.Toggle_Talent, false)
  binder:BindToZ1Toggle(self.ui.Toggle_Talent, nil, function(isOn)
    if not IsPageCorrect() then
      return
    end
    if isOn then
      self.model:SetAwakerPage(AwakerPage.Talent)
    end
  end, function()
    return self.model.page == AwakerPage.Talent
  end)
  binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Talent, function()
    local awakerTid = self.model.selectAwakerId
    local isShowRed = RedPointDataUtils.IsShowAwakerTalentRed(awakerTid)
    return isShowRed and RedPointDataUtils.RedAttrType.Red
  end))
  if self.ui.Toggle_Trinket then
    binder:SetZ1Toggle(self.ui.Toggle_Trinket, false)
    binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Trinket, function()
      return false
    end))
    binder:BindToZ1Toggle(self.ui.Toggle_Trinket, nil, function(isOn)
      if not IsPageCorrect() then
        return
      end
      if isOn then
        self.model:SetAwakerPage(AwakerPage.TrinketBind)
      end
    end, function()
      return self.model.page == AwakerPage.TrinketBind
    end)
    binder:BindToVisible(self.ui.Toggle_Trinket, function()
      do return self.model.IsOpenTrinketBind end
      return self.model.IsOpenTrinketBind, self.model
    end)
  end
  binder:SetZ1Toggle(self.ui.Toggle_Story, false)
  binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Story, function()
    return false
  end))
  binder:BindToZ1Toggle(self.ui.Toggle_Story, nil, function(isOn)
    if not IsPageCorrect() then
      return
    end
    if isOn then
      self.model:SetAwakerPage(AwakerPage.Story)
    end
  end, function()
    return self.model.page == AwakerPage.Story
  end)
  binder:SetZ1Toggle(self.ui.Toggle_Backtrace, false)
  binder:BindComponent(AwakerMiniListToggleItem(self.ui.Toggle_Backtrace, function()
    local awakerTid = self.model.selectAwakerId
    if RedPointDataUtils.IsBackTrackShowRed(awakerTid) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end))
  binder:BindToZ1Toggle(self.ui.Toggle_Backtrace, nil, function(isOn)
    if not IsPageCorrect() then
      return
    end
    if isOn then
      local awakerTid = self.model.selectAwakerId
      RedPointDataUtils.RemoveBackTrackOnceRed(awakerTid)
      self.model:SetAwakerPage(AwakerPage.BackTrack)
    end
  end, function()
    return self.model.page == AwakerPage.BackTrack
  end)
  self:SetCameraPerspective()
  
  local function BacktrackToggleVisibleFunc()
    do return self.model.IsOpenBacktrack end
    return self.model.IsOpenBacktrack, self.model
  end
  
  if self.model.page == AwakerPage.BackTrack then
    local awakerTid = self.model.selectAwakerId
    RedPointDataUtils.RemoveBackTrackOnceRed(awakerTid)
  end
  binder:BindToVisible(self.ui.Toggle_Backtrace, BacktrackToggleVisibleFunc)
end

function AwakerMiniListComp:ScrollToCurrentAwaker()
  for index, awakerData in ipairs(self.model.awakerList) do
    if awakerData and awakerData.tid == self.model.selectAwakerId then
      self.binder:CircularScrollTo(self.ui.ScrollView_Awaker_Head_List, index)
      break
    end
  end
end

function AwakerMiniListComp:SetCameraPerspective()
  if CameraManager:IsOrthographic() then
    CameraManager:SetUICameraModel(false)
    self.binder:onDestroy(function()
      CameraManager:SetUICameraModel(true)
    end)
  end
end

function AwakerMiniListComp:ResetScrollRect()
  if not self.ui then
    return
  end
  self.binder:CircularScrollTo(self.ui.ScrollView_Awaker_Head_List, 1)
end

function AwakerMiniListComp:_NeedShowPotentialBtn(awakerTid)
  local needShow = not table.next(AwakerDataUtils.GetMockAwakerMap())
  if not needShow then
    return false
  end
  local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
  local currStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
  if self.model:HasOwnedAwaker(awakerTid) and self.model.page == AwakerPage.Detail and self.model:GetAwakerReachLevelLimit(awakerTid) and maxStar > currStars then
    return false
  end
  local awakerLevel = AwakerDataUtils.GetAwakerLevel(awakerTid)
  return self.model:HasOwnedAwaker(awakerTid) and self.model.page == AwakerPage.Detail and awakerLevel == AwakerDataUtils.GetAwakerMaxLevelWithLimitIncrease(awakerTid) and awakerLevel < AwakerDataUtils.GetAwakerMaxLimitIncreaseLevel(awakerTid)
end

function AwakerMiniListComp:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerMiniListComp
