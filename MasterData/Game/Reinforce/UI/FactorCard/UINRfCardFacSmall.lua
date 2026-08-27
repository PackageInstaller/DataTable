local base = require("Game.Reinforce.UI.Card.UINReinforceCardBase")
local UINRfCardFacSmall = class("UINRfCardFacSmall", base)
local UINRfCdBuffItem = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINRfCardFacSmall:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  self.ui.btn_root.onPress:AddListener(BindCallback(self, self._OnPress))
end

function UINRfCardFacSmall:InitRfCardFacSmall(rfCardData, resloader, isFmt)
  base.InitRfCardBase(self, rfCardData, resloader, isFmt)
end

function UINRfCardFacSmall:SetRfCardFacSmallClickFunc(clickFunc)
  self._clickFunc = clickFunc
end

function UINRfCardFacSmall:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self, self._rfCardData)
  end
end

function UINRfCardFacSmall:_OnPress()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    win:InitRfCardDetailFac(self._rfCardData, self._isFmt)
  end)
end

function UINRfCardFacSmall:InitRfCDBaseFac()
  base.InitRfCDBaseFac(self)
  local bonus = self._rfCardData:GetRfCdInfiniteCoe()
  self.ui.tex_BonusFac:SetIndex(0, tostring(bonus))
  self:_UpdSmallBuff(self.ui.buffItemFac)
  self:_UpdChip(self.ui.uINChipItemFac)
end

function UINRfCardFacSmall:_UpdSmallBuff(buffItem)
  self._buffItemPool = self._buffItemPool or UIItemPool.New(UINRfCdBuffItem, buffItem, false)
  self._buffItemPool:HideAll()
  local buffList = self._rfCardData:GetRfCdBuffList()
  for k, epBuff in ipairs(buffList) do
    local buffItem = self._buffItemPool:GetOne()
    buffItem:InitRfCdBuffItem(epBuff:GetBuffCfg())
  end
end

function UINRfCardFacSmall:_UpdChip(chipItem)
  self._chipItemPool = self._chipItemPool or UIItemPool.New(UINChipItem, chipItem, false)
  self._chipItemPool:HideAll()
  local chipList = self._rfCardData:GetRfCdStartChipList()
  for k, chipData in ipairs(chipList) do
    local chip = self._chipItemPool:GetOne()
    chip:InitChipItem(chipData)
  end
end

function UINRfCardFacSmall:OnDelete()
  if self._buffItemPool then
    self._buffItemPool:DeleteAll()
  end
  if self._chipItemPool then
    self._chipItemPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINRfCardFacSmall
