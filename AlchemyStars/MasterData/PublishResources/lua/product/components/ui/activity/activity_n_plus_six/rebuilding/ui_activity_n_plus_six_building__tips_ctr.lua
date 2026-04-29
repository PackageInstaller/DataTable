_class("UIActivityNPlusSixBuildingTipsController", UIController)
UIActivityNPlusSixBuildingTipsController = UIActivityNPlusSixBuildingTipsController

function UIActivityNPlusSixBuildingTipsController:OnShow(uiParams)
  self._buildingData = uiParams[1]
  self._score = self:GetUIComponent("UILocalizationText", "Score")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._btnName = self:GetUIComponent("UILocalizationText", "BtnName")
  self._currentItemCount = self:GetUIComponent("UILocalizationText", "CurrentItemCount")
  self._targetItemCount = self:GetUIComponent("UILocalizationText", "TargetItemCount")
  self._itemCountPanel = self:GetGameObject("ItemCountPanel")
  self._itemNotEnuogh = self:GetGameObject("ItemNotEnough")
  self._notEnoughBtn = self:GetGameObject("NotEnoughBtn")
  local btnName = {
    [UIActivityNPlusSixBuildingStatus.CleanUp] = "str_n_plus_six_building_tips_cleanup_btn_name",
    [UIActivityNPlusSixBuildingStatus.CleanUpComplete] = "str_n_plus_six_building_tips_repair_btn_name",
    [UIActivityNPlusSixBuildingStatus.RepairComplete] = "str_n_plus_six_building_tips_decorate_btn_name"
  }
  local titleName = {
    [UIActivityNPlusSixBuildingStatus.CleanUp] = "str_n_plus_six_building_tips_cleanup_title",
    [UIActivityNPlusSixBuildingStatus.CleanUpComplete] = "str_n_plus_six_building_tips_repair_title",
    [UIActivityNPlusSixBuildingStatus.RepairComplete] = "str_n_plus_six_building_tips_decorate_title"
  }
  local status = self._buildingData:GetStatusType()
  local statusData = self._buildingData:GetStatus()
  local nextStatusData = self._buildingData:GetNextStatusData()
  local cost = self._buildingData:GetCost()
  self._cost = 0
  if cost and cost[1] and cost[1][2] then
    self._score:SetText(StringTable.Get("str_n_plus_six_build_cost_tips", cost[1][2], self._buildingData:GetName(), StringTable.Get(btnName[status])))
    self._cost = cost[1][2]
  else
    self._score:SetText(StringTable.Get("str_n_plus_six_build_cost_tips", 0, self._buildingData:GetName(), StringTable.Get(btnName[status])))
  end
  self._title.text = StringTable.Get(titleName[status], self._buildingData:GetName())
  self._btnName:SetText(StringTable.Get(btnName[status]))
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemCount = itemModule:GetItemCount(UIActivityNPlusSixConst.GetCoinItemId())
  self._currentItemCount:SetText(self:GetItemCountStr(itemCount))
  if itemCount >= self._cost then
    self._itemCountPanel:SetActive(true)
    self._itemNotEnuogh:SetActive(false)
    self._notEnoughBtn:SetActive(false)
    local targetItemCount = itemCount - self._cost
    self._targetItemCount:SetText(self:GetItemCountStr(targetItemCount))
  else
    self._itemCountPanel:SetActive(false)
    self._itemNotEnuogh:SetActive(true)
    self._notEnoughBtn:SetActive(true)
  end
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  local iconName = UIActivityNPlusSixConst.GetItemIconName()
  if iconName then
    self._iconLoader:LoadImage(iconName)
  end
end

function UIActivityNPlusSixBuildingTipsController:GetItemCountStr(count)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=#5e5e5e>%s</color><color=#f2c641>%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=#5e5e5e>%s</color>", pre)
  else
    return string.format("<color=#5e5e5e>%s</color><color=#ff0000>%s</color>", pre, count)
  end
end

function UIActivityNPlusSixBuildingTipsController:CloseBtnOnClick()
  self:CloseDialog()
end

function UIActivityNPlusSixBuildingTipsController:CancelBtnOnClick()
  self:CloseDialog()
end

function UIActivityNPlusSixBuildingTipsController:BuildingBtnOnClick()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemCount = itemModule:GetItemCount(UIActivityNPlusSixConst.GetCoinItemId())
  if itemCount < self._cost then
    ToastManager.ShowToast(StringTable.Get("str_n_plus_six_building_item_count_not_enouth"))
    return
  end
  GameGlobal.TaskManager():StartTask(self.Building, self)
end

function UIActivityNPlusSixBuildingTipsController:Building(TT)
  self:Lock("UIActivityNPlusSixBuildingTipsController_Building")
  local curStatus = self._buildingData:GetStatusType()
  local nextStatus = self._buildingData:GetNextStatus()
  if not nextStatus then
    self:CloseDialog()
    self:UnLock("UIActivityNPlusSixBuildingTipsController_Building")
    return
  end
  local buildingComponent = self._buildingData:GetBuildingComponent()
  local res = AsyncRequestRes:New()
  local result = buildingComponent:HandleBuild(TT, res, self._buildingData:GetBuildingId(), nextStatus)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6CommonBuilding)
  if result:GetSucc() then
    local storyType = self._buildingData:GetCompleteStoryType()
    local storyId = self._buildingData:GetCompleteStoryId()
    self._buildingData:BuildingLevelUp()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingAllBuildingComplete)
    if storyId and 0 < storyId then
      if storyType == 1 or storyType == 3 then
        self:ShowDialog("UIStoryBanner", storyId, StoryBannerShowType.HalfPortrait, function()
          GameGlobal.TaskManager():StartTask(self.CompleteStory, self, curStatus)
        end)
      elseif storyType == 2 then
        self:ShowDialog("UIStoryController", storyId, function()
          GameGlobal.TaskManager():StartTask(self.CompleteStory, self, curStatus)
        end)
      end
      self:UnLock("UIActivityNPlusSixBuildingTipsController_Building")
      self:CloseDialog()
      return
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6ShowBuilding)
    self:UnLock("UIActivityNPlusSixBuildingTipsController_Building")
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingBuildingComplete, self._buildingData)
    YIELD(TT, 200)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingMainRefresh)
  else
    Log.error("HandleBuild error")
    self:UnLock("UIActivityNPlusSixBuildingTipsController_Building")
    self:CloseDialog()
  end
end

function UIActivityNPlusSixBuildingTipsController:CompleteStory(TT, curStatus)
  self:Lock("UIActivityNPlusSixBuildingTipsController_CompleteStory")
  local buildComponent = self._buildingData:GetBuildingComponent()
  local res = AsyncRequestRes:New()
  buildComponent:HandleStory(TT, res, self._buildingData:GetBuildingId(), curStatus)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6ShowBuilding)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingBuildingComplete, self._buildingData)
  YIELD(TT, 200)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingMainRefresh)
  self:UnLock("UIActivityNPlusSixBuildingTipsController_CompleteStory")
end
