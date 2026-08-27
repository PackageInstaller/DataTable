local UINHomeSideBuildingItem = class("UINHomeSideBuildingItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")

function UINHomeSideBuildingItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_buildingItem, self, self.OnClick)
end

function UINHomeSideBuildingItem:RefreshBuildingItem(buildData, isSector)
  if self.buildData ~= buildData then
    self.buildData = buildData
    self.isSector = isSector
    local name = buildData.name
    local sectorName = buildData:GetSectorName()
    if sectorName == nil then
      self.ui.textName:SetIndex(0, name)
    else
      self.ui.textName:SetIndex(1, sectorName, name)
    end
  end
  local time = buildData.remainSecond
  if 0 < time then
    self.ui.textTime.text = TimeUtil:TimestampToTime(time)
    self.ui.complete:SetActive(false)
  else
    self.ui.complete:SetActive(true)
  end
end

function UINHomeSideBuildingItem:OnClick()
  if self.isSector then
    JumpManager:Jump(JumpManager.eJumpTarget.SectorBuilding, nil, nil, {
      self.buildData.sectorId
    })
  else
    JumpManager:Jump(JumpManager.eJumpTarget.OasisBuilding, nil, nil, {
      self.buildData.id
    })
  end
end

function UINHomeSideBuildingItem:OnDelete()
  base.OnDelete(self)
end

return UINHomeSideBuildingItem
