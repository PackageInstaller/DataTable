_class("UIAircraftRoomLevelUpController", UIController)
UIAircraftRoomLevelUpController = UIAircraftRoomLevelUpController

function UIAircraftRoomLevelUpController:OnShow(uiParams)
  self:InitWidget()
  self.roomData = uiParams[1]
  self._spaceID = self.roomData:SpaceId()
  self.airData = GameGlobal.GameLogic():GetModule(AircraftModule)
  self.roomType = self.roomData:GetRoomType()
  self.topBarWidget = self.topbar:SpawnObject("UIAircraftTopBarItem")
  self.topBarWidget:SetData(false, nil, nil, nil, true)
  self.rawImageRoomIcon:LoadImage(self.roomData:GetRoomIcon1())
  self.textRoomName.text = StringTable.Get(self.roomData:GetRoomName())
  local strNeedPower = StringTable.Get("str_aircraft_tip_levelup_needpower")
  local strNeedTime = StringTable.Get("str_aircraft_tip_levelup_needtime")
  self.textNeedPower.text = strNeedPower .. math.ceil(self.roomData:GetUpgradeNeedPower() - self.roomData:GetCurrentPower())
  self.textNeedTime.text = strNeedTime .. HelperProxy:GetInstance():FormatTime(self.roomData:GetUpgradeNeedTime() * 60)
  self._matWidgets = {}
  self:FlushMat()
  if #self.mats <= 4 then
    self:GetUIComponent("ScrollRect", "ScrollViewNeedMats").enabled = false
    self.scrollViewNeedMats.enabled = false
    local rect = self:GetUIComponent("RectTransform", "MatContent")
    rect.anchorMin = Vector2(0, 0)
    rect.anchorMax = Vector2(1, 1)
    rect.offsetMin = Vector2(0, 0)
    rect.offsetMax = rect.parent:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta
    self.matContent.enabled = true
  end
  if not self.roomData:EnoughPowerToUpgrade() then
    local atlas = self:GetAsset("UIAircraftLevel.spriteatlas", LoadType.SpriteAtlas)
    self.powerBg.sprite = atlas:GetSprite("wind_shengjiang_gezi3")
  end
  self:SetRoomMsg()
  self:CheckPrecondition()
end

function UIAircraftRoomLevelUpController:OnHide()
end

function UIAircraftRoomLevelUpController:InitWidget()
  self.topbar = self:GetUIComponent("UISelectObjectPath", "Topbar")
  self.rawImageRoomIcon = self:GetUIComponent("RawImageLoader", "RawImageRoomIcon")
  self.textRoomName = self:GetUIComponent("UILocalizationText", "TextRoomName")
  self.imageRoomProperties = self:GetUIComponent("UISelectObjectPath", "ImageRoomProperties")
  self.textNeedPower = self:GetUIComponent("UILocalizationText", "TextNeedPower")
  self.textNeedTime = self:GetUIComponent("UILocalizationText", "TextNeedTime")
  self.scrollViewNeedMats = self:GetUIComponent("UIDynamicScrollView", "ScrollViewNeedMats")
  self.powerBg = self:GetUIComponent("Image", "powerBg")
  self.matContent = self:GetUIComponent("HorizontalLayoutGroup", "MatContent")
end

function UIAircraftRoomLevelUpController:NewMatItem(_scrollView, _index)
  if _index < 0 then
    return nil
  end
  local item = _scrollView:NewListViewItem("mat")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local mat = rowPool:SpawnObject("UIItemsWidget")
  local matData = self.mats[_index + 1]
  local id = matData[1]
  local need = matData[2]
  mat:SetData(id, need, function(_id, pos)
    self:OnMatClick(_id, pos)
  end, false)
  self._matWidgets[_index + 1] = mat
  return item
end

function UIAircraftRoomLevelUpController:OnMatClick(matId, pos)
  self:ShowDialog("UIItemGetPathController", matId)
end

function UIAircraftRoomLevelUpController:SetRoomMsg()
  local uiInfos = UIAircraftRoomLevelUpController.HandleDataToUI(true, self.roomData)
  self.imageRoomProperties:SpawnObjects("UIAircraftLevelInfoItem", #uiInfos)
  local items = self.imageRoomProperties:GetAllSpawnList()
  for i = 1, #items do
    local msg = uiInfos[i]
    items[i]:SetData(msg.title, true, msg.first, msg.second)
  end
end

function UIAircraftRoomLevelUpController:CheckPrecondition()
  local conds = self.airData:GetRoomLevelUpPreCondition(self._spaceID)
  local count = #conds
  if 0 < count then
    self:ShowDialog("UIAircraftPreconditionController", self.roomData, conds)
    return false
  end
  return true
end

function UIAircraftRoomLevelUpController:ButtonCancelOnClick(go)
  self:CloseDialog()
end

function UIAircraftRoomLevelUpController:ButtonLevelUpOnClick(go)
  if not self:CheckPrecondition() then
    return
  end
  if not self.roomData:EnoughPowerToUpgrade() then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_star_power_is_not_enough"))
    return
  end
  local enough = true
  for _, widget in ipairs(self._matWidgets) do
    if not widget:IsMatEnough() then
      enough = false
      widget:ShakeAndHighlight()
      break
    end
  end
  if not enough then
    return
  end
  GameGlobal.TaskManager():StartTask(self.RequestUp, self)
end

function UIAircraftRoomLevelUpController:ButtonConditionConfirmOnClick(go)
  self:CloseDialog()
end

function UIAircraftRoomLevelUpController:ButtonConditionCancelOnClick(go)
  self:CloseDialog()
end

function UIAircraftRoomLevelUpController:RequestUp(TT)
  self:Lock(self:GetName())
  local result = self.airData:RequestRoomUpgrade(TT, self._spaceID)
  if result:GetSucc() then
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSettledPetChanged)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftPlayDoorAnim, AircraftDoorAnim.LevelUp, self._spaceID)
    ToastManager.ShowToast(StringTable.Get("str_aircraft_upgrade_success"))
  else
    ToastManager.ShowToast(self.airData:GetErrorMsg(result:GetResult()))
  end
  self:UnLock(self:GetName())
end

function UIAircraftRoomLevelUpController.HandleDataToUI(levelUp, roomData)
  local level = roomData:Level()
  local infos
  local uiInfos = {}
  if levelUp then
    infos = roomData:GetUpgradeInfo()
    local uiinfo = {}
    uiinfo.title = StringTable.Get(AirLevelInfoTitle.RoomLevel, StringTable.Get(roomData:GetRoomName()))
    uiinfo.isLevelup = true
    uiinfo.first = "Lv." .. level
    uiinfo.second = "Lv." .. level + 1
    table.insert(uiInfos, uiinfo)
  else
    infos = roomData:GetDegradeInfo()
    local uiinfo = {}
    uiinfo.title = StringTable.Get(AirLevelInfoTitle.RoomLevel, StringTable.Get(roomData:GetRoomName()))
    uiinfo.isLevelup = false
    uiinfo.first = "Lv." .. level
    uiinfo.second = "Lv." .. level - 1
    table.insert(uiInfos, uiinfo)
  end
  for i = 1, #infos do
    local data = infos[i]
    local title = data[1]
    local type = data[2]
    local value1 = data[3]
    local value2 = data[4]
    if type == AirRoomChangeLevelDataType.NumberInt then
      if value1 ~= value2 then
        local uiinfo = {}
        uiinfo.title = StringTable.Get(title)
        uiinfo.isLevelup = levelUp
        uiinfo.first = value1
        uiinfo.second = value2
        table.insert(uiInfos, uiinfo)
      end
    elseif type == AirRoomChangeLevelDataType.NumberFloat then
      if value1 ~= value2 then
        local uiinfo = {}
        uiinfo.title = StringTable.Get(title)
        uiinfo.isLevelup = levelUp
        uiinfo.first = string.format("%.2f", value1)
        uiinfo.second = string.format("%.2f", value2)
        table.insert(uiInfos, uiinfo)
      end
    elseif type == AirRoomChangeLevelDataType.TextData then
      local uiinfo = {}
      uiinfo.isLevelup = levelUp
      if value1 then
        uiinfo.title = StringTable.Get(title, value1)
      else
        uiinfo.title = StringTable.Get(title)
      end
      table.insert(uiInfos, uiinfo)
    elseif type == AirRoomChangeLevelDataType.NumberPercent then
      if value1 ~= value2 then
        local uiinfo = {}
        uiinfo.title = StringTable.Get(title)
        uiinfo.isLevelup = levelUp
        uiinfo.first = math.floor(value1 * 100) .. "%"
        uiinfo.second = math.floor(value2 * 100) .. "%"
        table.insert(uiInfos, uiinfo)
      end
    elseif type == AirRoomChangeLevelDataType.CurAndLimit then
      local value3 = data[5]
      local value4 = data[6]
      if value1 ~= value3 or value2 ~= value4 then
        local uiinfo = {}
        uiinfo.title = StringTable.Get(title)
        uiinfo.isLevelup = levelUp
        uiinfo.first = value1 .. "/" .. value2
        uiinfo.second = value3 .. "/" .. value4
        table.insert(uiInfos, uiinfo)
      end
    elseif type == AirRoomChangeLevelDataType.Time then
      if value1 ~= value2 then
        local uiinfo = {}
        uiinfo.title = StringTable.Get(title)
        uiinfo.isLevelup = levelUp
        uiinfo.first = HelperProxy:GetInstance():FormatTime_2(value1)
        uiinfo.second = HelperProxy:GetInstance():FormatTime_2(value2)
        table.insert(uiInfos, uiinfo)
      end
    elseif type == AirRoomChangeLevelDataType.Hour and value1 ~= value2 then
      local uiinfo = {}
      uiinfo.title = StringTable.Get(title)
      uiinfo.isLevelup = levelUp
      uiinfo.first = StringTable.Get("str_aircraft_level_hour_formate", string.format("%.1f", value1 / 3600))
      uiinfo.second = StringTable.Get("str_aircraft_level_hour_formate", string.format("%.1f", value2 / 3600))
      table.insert(uiInfos, uiinfo)
    end
  end
  return uiInfos
end

function UIAircraftRoomLevelUpController:FlushMat()
  self.mats = self.roomData:GetUpgradeNeed()
  self.scrollViewNeedMats:InitListView(#self.mats, function(_scrollView, _index)
    return self:NewMatItem(_scrollView, _index)
  end)
end
