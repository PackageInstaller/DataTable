local UINEpOverclockListPanel = class("UINEpOverclockListPanel", UIBaseNode)
local base = UIBaseNode
local UINEpOverclockListItem = require("Game.Exploration.UI.Overclock.UINEpOverclockListItem")

function UINEpOverclockListPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.overclockItem:SetActive(false)
  self.clockItemPool = UIItemPool.New(UINEpOverclockListItem, self.ui.overclockItem)
end

function UINEpOverclockListPanel:InitOverclockListUI(overclockCtrl, clockSelectAction)
  local clockOptionList = overclockCtrl:GetOverclockOptions()
  self.clockItemPool:HideAll()
  for k, clockOptionData in pairs(clockOptionList) do
    local clockItem = self.clockItemPool:GetOne()
    clockItem:InitOverclockListItem(clockOptionData, overclockCtrl, clockSelectAction)
  end
end

function UINEpOverclockListPanel:OnDelete()
  base.OnDelete(self)
end

return UINEpOverclockListPanel
