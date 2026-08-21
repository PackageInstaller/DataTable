_class("UIAircraftConfirmDialogController", UIController)
UIAircraftConfirmDialogController = UIAircraftConfirmDialogController

function UIAircraftConfirmDialogController:OnShow(uiParams)
  self._module = self:GetModule(AircraftModule)
  self:InitWidget()
  self.roomData = uiParams[1]
  self._spaceID = self.roomData:SpaceId()
  self.textName.text = StringTable.Get(self.roomData:GetRoomName())
  local icon
  local roomType = self.roomData:GetRoomType()
  local room_cfg = Cfg.cfg_aircraft_room({})
  for id, room_cfg in pairs(room_cfg) do
    if room_cfg.Level == 1 and room_cfg.RoomType == roomType then
      icon = room_cfg.RoomTypeIcon1
    end
  end
  self.imageBg:LoadImage(icon)
  local currency = self:GetUIComponent("UISelectObjectPath", "currency")
  self._topTips = currency:SpawnObject("UICurrencyMenu")
  self._topTips:SetData({
    RoleAssetID.RoleAssetFirefly,
    CurrenyTypeId.StarPoint,
    RoleAssetID.RoleAssetGold
  })
  local fireFly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  fireFly:CloseAddBtn()
  self:OnFireflyChanged()
  local power = self._topTips:GetItemByTypeId(CurrenyTypeId.StarPoint)
  local powerAvai = self._module:GetPower()
  local powerMax = self._module:GetMaxPower()
  power:SetText(powerAvai .. "/" .. powerMax)
  self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.OnFireflyChanged)
end

function UIAircraftConfirmDialogController:OnFireflyChanged()
  local fireFly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  fireFly:SetText(self._module:GetFirefly() .. "/" .. math.floor(self._module:GetMaxFirefly()))
end

function UIAircraftConfirmDialogController:InitWidget()
  self.textName = self:GetUIComponent("UILocalizationText", "TextName")
  self.imageBg = self:GetUIComponent("RawImageLoader", "Imagebg")
end

function UIAircraftConfirmDialogController:ButtonCancelOnClick(go)
  self:CloseDialog()
end

function UIAircraftConfirmDialogController:ButtonConfirmOnClick(go)
  GameGlobal.TaskManager():StartTask(self.RequestDown, self)
end

function UIAircraftConfirmDialogController:RequestDown(TT)
  local module = GameGlobal.GameLogic():GetModule(AircraftModule)
  self:Lock(self:GetName())
  local result = module:RequestRoomDegrade(TT, self._spaceID)
  self:UnLock(self:GetName())
  if result:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSettledPetChanged)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftPlayDoorAnim, AircraftDoorAnim.TearDown, self._spaceID)
    self:CloseDialog()
  else
    ToastManager.ShowToast(module:GetErrorMsg(result:GetResult()))
  end
end
