local base = UIBaseWindow
local UIBondDetails = class("UIBondDetails", base)
local cs_ResLoader = CS.ResLoader
local UINBondDetailsTog = require("Game.ActivityBond.UI.BondDetail.UINBondDetailsTog")
local UINBondDetailsItem = require("Game.ActivityBond.UI.BondDetail.UINBondDetailsItem")
local ActivityBondEnum = require("Game.ActivityBond.Data.ActivityBondEnum")

function UIBondDetails:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  self._resloader = cs_ResLoader.Create()
  self.togglePool = UIItemPool.New(UINBondDetailsTog, self.ui.Toggle, false)
  self.itemPool = UIItemPool.New(UINBondDetailsItem, self.ui.Item, false)
  self.__refreshBondItem = BindCallback(self, self.__RefreshBondItem)
end

function UIBondDetails:InitBondDetail(bondData)
  self.__bondData = bondData
  self:__RefreshTog()
end

function UIBondDetails:__RefreshTog()
  self.togglePool:HideAll()
  local togList = {
    ActivityBondEnum.eBondType.career,
    ActivityBondEnum.eBondType.company
  }
  for _, type in ipairs(togList) do
    local togItem = self.togglePool:GetOne()
    togItem:InitBondDetailTog(type, self.__refreshBondItem)
  end
  local isAllOff = true
  for _, togItem in ipairs(self.togglePool.listItem) do
    if togItem.ui.toggle.isOn then
      isAllOff = false
      break
    end
  end
  if isAllOff then
    local togItem = self.togglePool.listItem[1]
    togItem.ui.toggle.isOn = true
  end
end

function UIBondDetails:__RefreshBondItem(type)
  local cfgList = self.__bondData:GetActBond_Bonds(type)
  self.itemPool:HideAll()
  for _, cfg in ipairs(cfgList) do
    local item = self.itemPool:GetOne(true)
    item:InitBondDetailItem(cfg, self._resloader)
  end
end

function UIBondDetails:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.Delete(self)
end

return UIBondDetails
