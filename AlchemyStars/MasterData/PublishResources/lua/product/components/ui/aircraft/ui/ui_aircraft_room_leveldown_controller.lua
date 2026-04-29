_class("UIAircraftRoomLevelDownController", UIController)
UIAircraftRoomLevelDownController = UIAircraftRoomLevelDownController

function UIAircraftRoomLevelDownController:OnShow(uiParams)
  self:InitWidget()
  self.roomData = uiParams[1]
  self._spaceID = self.roomData:SpaceId()
  self.roomType = self.roomData:GetRoomType()
  self.topBarWidget = self.topbar:SpawnObject("UIAircraftTopBarItem")
  self.topBarWidget:SetData(false, nil, nil, nil, true)
  self.rawImageRoomIcon:LoadImage(self.roomData:GetRoomIcon1())
  self.textRoomName.text = StringTable.Get(self.roomData:GetRoomName())
  self:SetRoomMsg()
  self.mats = self.roomData:GetDegradeRecycle()
  self.scrollViewReturnMats:InitListView(#self.mats, function(_scrollView, _index)
    return self:NewMatItem(_scrollView, _index)
  end)
  if #self.mats <= 4 then
    self:GetUIComponent("ScrollRect", "ScrollViewReturnMats").enabled = false
    self.scrollViewReturnMats.enabled = false
    local rect = self:GetUIComponent("RectTransform", "MatContent")
    rect.anchorMin = Vector2(0, 0)
    rect.anchorMax = Vector2(1, 1)
    rect.offsetMin = Vector2(0, 0)
    rect.offsetMax = rect.parent:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta
    self.matContent.enabled = true
  end
end

function UIAircraftRoomLevelDownController:OnHide()
end

function UIAircraftRoomLevelDownController:InitWidget()
  self.topbar = self:GetUIComponent("UISelectObjectPath", "Topbar")
  self.rawImageRoomIcon = self:GetUIComponent("RawImageLoader", "RawImageRoomIcon")
  self.textRoomName = self:GetUIComponent("UILocalizationText", "TextRoomName")
  self.imageRoomProperties = self:GetUIComponent("UISelectObjectPath", "ImageRoomProperties")
  self.textPowerFrom = self:GetUIComponent("UILocalizationText", "TextPowerFrom")
  self.textPowerTo = self:GetUIComponent("UILocalizationText", "TextPowerTo")
  self.scrollViewReturnMats = self:GetUIComponent("UIDynamicScrollView", "ScrollViewReturnMats")
  self.matContent = self:GetUIComponent("HorizontalLayoutGroup", "MatContent")
end

function UIAircraftRoomLevelDownController:NewMatItem(_scrollView, _index)
  if _index < 0 then
    return nil
  end
  local item = _scrollView:NewListViewItem("mat")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  local mat = rowPool:SpawnObject("UIItemsWidgetSingle")
  local matData = self.mats[_index + 1]
  local id = matData[1]
  local need = matData[2]
  mat:SetData(id, need, function(_id, pos)
    self:OnMatClick(_id, pos)
  end)
  return item
end

function UIAircraftRoomLevelDownController:OnMatClick(matId, pos)
  self:ShowDialog("UIItemGetPathController", matId)
end

function UIAircraftRoomLevelDownController:SetRoomMsg()
  local uiInfos = UIAircraftRoomLevelUpController.HandleDataToUI(false, self.roomData)
  self.imageRoomProperties:SpawnObjects("UIAircraftLevelInfoItem", #uiInfos)
  local items = self.imageRoomProperties:GetAllSpawnList()
  for i = 1, #items do
    local msg = uiInfos[i]
    items[i]:SetData(msg.title, false, msg.first, msg.second)
  end
  self.textPowerFrom.text = math.ceil(self.roomData:GetCurrentPower())
  self.textPowerTo.text = math.ceil(self.roomData:GetDegradeNeedPower())
end

function UIAircraftRoomLevelDownController:ButtonCancelOnClick(go)
  self:CloseDialog()
end

function UIAircraftRoomLevelDownController:ButtonLevelDownOnClick(go)
  if self.roomData:GetRoomType() == AirRoomType.CentralRoom then
    ToastManager.ShowToast(StringTable.Get("str_toast_manager_main_room_cant_down_lv"))
    return
  end
  if self.roomData:Level() <= 1 then
    Log.exception("降级界面不处理拆除：", self._spaceID)
    return
  end
  GameGlobal.TaskManager():StartTask(self.RequestDown, self)
end

function UIAircraftRoomLevelDownController:RequestDown(TT)
  self:Lock(self:GetName())
  local module = GameGlobal.GameLogic():GetModule(AircraftModule)
  local result = module:RequestRoomDegrade(TT, self._spaceID)
  if result:GetSucc() then
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSettledPetChanged)
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftPlayDoorAnim, AircraftDoorAnim.LevelDown, self._spaceID)
  else
    ToastManager.ShowToast(module:GetErrorMsg(result:GetResult()))
  end
  self:UnLock(self:GetName())
end
