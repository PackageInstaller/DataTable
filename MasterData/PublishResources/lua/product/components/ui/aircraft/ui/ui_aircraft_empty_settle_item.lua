_class("UIAircraftEmptySettleItem", UICustomWidget)
UIAircraftEmptySettleItem = UIAircraftEmptySettleItem

function UIAircraftEmptySettleItem:OnShow(uiParams)
  self:InitWidget()
  self._pstid = 0
  self._index = 0
end

function UIAircraftEmptySettleItem:InitWidget()
end

function UIAircraftEmptySettleItem:SetData(_roomData, index)
  self.roomData = _roomData
  self._index = index
end

function UIAircraftEmptySettleItem:UIAircraftEmptySettleItemOnClick(go)
  self:ShowDialog("UIAircraftEnterBuildController", self.roomData, self._pstid, self._index)
end
