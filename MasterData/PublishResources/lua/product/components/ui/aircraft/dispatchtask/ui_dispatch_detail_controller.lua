_class("UIDispatchDetailController", UIController)
UIDispatchDetailController = UIDispatchDetailController

function UIDispatchDetailController:LoadDataOnEnter(TT, res, uiParams)
  self._aircraftModule = GameGlobal.GetModule(AircraftModule)
  self._roomData = self._aircraftModule:GetRoomByRoomType(AirRoomType.DispatchRoom)
  self._pointDatas = {}
  self._petModule = GameGlobal.GetModule(PetModule)
  local maxPointCount = self._roomData:GetSiteMaxNum()
  for i = 1, maxPointCount do
    local siteInfo = self._roomData:GetSiteInfo(i - 1)
    if siteInfo and (siteInfo.state == DispatchTaskStateType.DTST_New or siteInfo.state == DispatchTaskStateType.DTST_Doing) then
      self._pointDatas[#self._pointDatas + 1] = i - 1
    end
  end
  self._maxPointCount = #self._pointDatas
  self._dispatchPets = {}
  for i = 1, maxPointCount do
    local pointIndex = i - 1
    if self._dispatchPets[pointIndex] == nil then
      self._dispatchPets[pointIndex] = {}
    end
    local siteInfo = self._roomData:GetSiteInfo(pointIndex)
    if siteInfo then
      local teamMembers = siteInfo.teamMember
      if teamMembers then
        for j = 1, #teamMembers do
          local pet = self._petModule:GetPet(teamMembers[j])
          self._dispatchPets[pointIndex][#self._dispatchPets[pointIndex] + 1] = pet
        end
      end
    end
  end
  self._workingPets = {}
  local spaces = Cfg.cfg_aircraft_space({})
  for i = 1, #spaces do
    local room = self._aircraftModule:GetRoom(i)
    if room then
      local pets = room:GetPets()
      if pets then
        for _, pet in pairs(pets) do
          self._workingPets[pet:GetPstID()] = i
        end
      end
    end
  end
end

function UIDispatchDetailController:OnShow(uiParams)
  self._leftBtnGo = self:GetGameObject("LeftBtn")
  self._rightBtnGo = self:GetGameObject("RightBtn")
  self._suggestDesPanel = self:GetGameObject("SuggestDesPanel")
  self._topBarLoader = self:GetUIComponent("UISelectObjectPath", "TopBarLoader")
  self.topButtonWidget = self._topBarLoader:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:OnBack()
  end, function()
    self:OnHelp()
  end, function()
    self:OnHome()
  end)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  local pointIndex = uiParams[1]
  for i = 1, self._maxPointCount do
    if self._pointDatas[i] == pointIndex then
      self._currentIndex = i
      break
    end
  end
  if not self._currentIndex then
    return
  end
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "InfoScroll", "UIDispatchDetailItem", function(index, uiwidget, currentIndex)
    return self:OnShowItem(index, uiwidget, currentIndex)
  end)
  self._scrollViewHelper:Init(self._maxPointCount, self._currentIndex, Vector2(0, 0))
  self._isMoving = false
  self:_RefreshButtonStatus()
end

function UIDispatchDetailController:OnHide()
  if self._scrollViewHelper then
    self._scrollViewHelper:Dispose()
  end
  self._isMoving = false
end

function UIDispatchDetailController:OnShowItem(index, uiwidget, currentIndex)
  uiwidget:Refresh(self._pointDatas[index], self)
end

function UIDispatchDetailController:_RefreshButtonStatus()
  if self._currentIndex == 1 then
    self._leftBtnGo:SetActive(false)
  else
    self._leftBtnGo:SetActive(true)
  end
  if self._currentIndex == self._maxPointCount then
    self._rightBtnGo:SetActive(false)
  else
    self._rightBtnGo:SetActive(true)
  end
end

function UIDispatchDetailController:BgOnClick(go)
  self:CloseDialog()
end

function UIDispatchDetailController:LeftBtnOnClick(go)
  if self._isMoving then
    return
  end
  if not self._currentIndex then
    return
  end
  if self._currentIndex > 1 then
    self._isMoving = true
    local tempIndex = self._currentIndex - 1
    self._scrollViewHelper:MovePanelToIndex(tempIndex, function()
      self:ResetDispatchPets()
      self._currentIndex = self._currentIndex - 1
      self:_RefreshButtonStatus()
      self._isMoving = false
    end)
  end
end

function UIDispatchDetailController:RightBtnOnClick(go)
  if self._isMoving then
    return
  end
  if not self._currentIndex then
    return
  end
  if self._currentIndex < self._maxPointCount then
    self._isMoving = true
    local tempIndex = self._currentIndex + 1
    self._scrollViewHelper:MovePanelToIndex(tempIndex, function()
      self._currentIndex = self._currentIndex + 1
      self:ResetDispatchPets()
      self:_RefreshButtonStatus()
      self._isMoving = false
    end)
  end
end

function UIDispatchDetailController:ShowTips(itemId, pos, des)
  self._tips:SetData(itemId, pos, des)
end

function UIDispatchDetailController:GetDispatchPets(index)
  return self._dispatchPets[index]
end

function UIDispatchDetailController:ResetDispatchPets()
  local maxPointCount = self._roomData:GetSiteMaxNum()
  self._dispatchPets = {}
  for i = 1, maxPointCount do
    local pointIndex = i - 1
    if self._dispatchPets[pointIndex] == nil then
      self._dispatchPets[pointIndex] = {}
    end
    local siteInfo = self._roomData:GetSiteInfo(pointIndex)
    if siteInfo then
      local teamMembers = siteInfo.teamMember
      if teamMembers then
        for j = 1, #teamMembers do
          local pet = self._petModule:GetPet(teamMembers[j])
          self._dispatchPets[pointIndex][#self._dispatchPets[pointIndex] + 1] = pet
        end
      end
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDispatchPetList)
end

function UIDispatchDetailController:GetExcludePets()
  local pets = {}
  for _, v in pairs(self._dispatchPets) do
    for _, pet in pairs(v) do
      pets[#pets + 1] = pet
    end
  end
  return pets
end

function UIDispatchDetailController:GetWorkingPets()
  return self._workingPets
end

function UIDispatchDetailController:OnBack()
  self:CloseDialog()
end

function UIDispatchDetailController:OnHome()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
end

function UIDispatchDetailController:OnHelp()
  self:ShowDialog("UIHelpController", "UIDispatchDetailController")
end

function UIDispatchDetailController:Close()
  self:CloseDialog()
end

function UIDispatchDetailController:SuggestDesPanelOnClick(go)
  self._suggestDesPanel:SetActive(false)
end

function UIDispatchDetailController:ShowSuggestDesPanel()
  self._suggestDesPanel:SetActive(true)
end

local id2name = {
  "StarPanel",
  "RewardGuideFrame",
  "SuggestPetGuideFrame",
  "TaskTimePanel",
  "AutoSelectBtn",
  "DispatchtBtn"
}

function UIDispatchDetailController:GetCurrentItemGameObject(name)
  local curWidget = self._scrollViewHelper:GetUseItem(self._currentIndex)
  if curWidget then
    local uiName = id2name[name]
    return curWidget:GetGameObject(uiName)
  end
end

function UIDispatchDetailController:GetCurrentItemExtraRewardItem()
  local curWidget = self._scrollViewHelper:GetUseItem(self._currentIndex)
  if curWidget then
    return curWidget:GetExtraRewardItem():GetGameObject("Mask_Guide")
  end
end
