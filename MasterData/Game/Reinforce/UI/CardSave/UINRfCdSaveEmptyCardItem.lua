local base = UIBaseNode
local UINRfCdSaveEmptyCardItem = class("UINRfCdSaveEmptyCardItem", base)
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")

function UINRfCdSaveEmptyCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if self.ui.btn_root ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  end
end

function UINRfCdSaveEmptyCardItem:InitRfCdSaveEmptyCardItem(index, clickFunc)
  self._index = index
  self._clickFunc = clickFunc
  self.ui.tex_OrderFactor.text = ReinforceUtil.GetRfCdCactorOrderStr(index)
end

function UINRfCdSaveEmptyCardItem:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self._index, self.transform)
  end
end

function UINRfCdSaveEmptyCardItem:SetRfCdSaveEmptyCardItemSelect(isSelect)
  if self.ui.select ~= nil then
    self.ui.select:SetActive(not isSelect)
  end
end

function UINRfCdSaveEmptyCardItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCdSaveEmptyCardItem
