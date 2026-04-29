_class("UIAircraftEvilCaptureRoomItem", UICustomWidget)
UIAircraftEvilCaptureRoomItem = UIAircraftEvilCaptureRoomItem

function UIAircraftEvilCaptureRoomItem:OnShow(uiParams)
  self:InitWidget()
  self.roomInfoWidget = self.roomInfo:SpawnObject("UIAircraftRoomInfoItem")
end

function UIAircraftEvilCaptureRoomItem:InitWidget()
  self.textSpiritCeiling = self:GetUIComponent("Text", "TextStoreCeiling")
  self.textFireflyRecover = self:GetUIComponent("Text", "TextEvilGrade")
  self.roomInfo = self:GetUIComponent("UISelectObjectPath", "RoomInfo")
  self.textName = self:GetUIComponent("UILocalizationText", "TextName")
end

function UIAircraftEvilCaptureRoomItem:Refresh(_roomData)
  self.roomData = _roomData
  self:GetGameObject():SetActive(true)
  self.roomInfoWidget:SetData(self.roomData)
  self.textName.text = string.format("%s/%s", self.roomData:Level(), self.roomData:MaxLevel())
end

function UIAircraftEvilCaptureRoomItem:Close()
  self:GetGameObject():SetActive(false)
  self.roomInfoWidget:OnClose()
end

function UIAircraftEvilCaptureRoomItem:ButtonSearchOnClick(go)
end
