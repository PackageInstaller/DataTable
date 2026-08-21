_class("UIAircraftEvilResearchRoomItem", UICustomWidget)
UIAircraftEvilResearchRoomItem = UIAircraftEvilResearchRoomItem

function UIAircraftEvilResearchRoomItem:OnShow(uiParams)
  self:InitWidget()
  self.roomInfoWidget = self.roomInfo:SpawnObject("UIAircraftRoomInfoItem")
end

function UIAircraftEvilResearchRoomItem:InitWidget()
  self.textResearchTime = self:GetUIComponent("Text", "TextResearchTime")
  self.roomInfo = self:GetUIComponent("UISelectObjectPath", "RoomInfo")
  self.textName = self:GetUIComponent("UILocalizationText", "TextName")
end

function UIAircraftEvilResearchRoomItem:Refresh(_roomData)
  self.roomData = _roomData
  self:GetGameObject():SetActive(true)
  self.roomInfoWidget:SetData(self.roomData)
  self.textName.text = string.format("%s/%s", self.roomData:Level(), self.roomData:MaxLevel())
end

function UIAircraftEvilResearchRoomItem:Close()
  self:GetGameObject():SetActive(false)
  self.roomInfoWidget:OnClose()
end

function UIAircraftEvilResearchRoomItem:ButtonSearchOnClick(go)
end
