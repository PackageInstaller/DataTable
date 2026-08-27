local base = require("Game.Reinforce.UI.Card.UINReinforceCardBase")
local UINRfCardFacBig = class("UINRfCardFacBig", base)
local UINRfCdBuffItem = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ChipData = require("Game.PlayerData.Item.ChipData")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")

function UINRfCardFacBig:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Switch, self, self._OnClickSwitch)
  UIUtil.AddButtonListener(self.ui.btn_ChipLibFac, self, self._OnClickCheck)
  UIUtil.AddButtonListener(self.ui.btn_CheckChipFmt, self, self._OnClickCheck)
end

function UINRfCardFacBig:InitRfCardFacBig(rfCardData, resloader, isFmt, hideSwitch)
  base.InitRfCardBase(self, rfCardData, resloader, isFmt)
  self.ui.btn_Switch.gameObject:SetActive(not hideSwitch)
end

function UINRfCardFacBig:SetRfCardFacBigDetailFunc(detailFunc)
  self._detailFunc = detailFunc
end

function UINRfCardFacBig:_OnClickCheck(isUpd)
  if self._detailFunc then
    self._detailFunc(self._rfCardData, self._isFmt, isUpd)
  end
end

function UINRfCardFacBig:HideRfCardFacBigDetailBtn()
  self.ui.btn_ChipLibFac.gameObject:SetActive(false)
  self.ui.btn_CheckChipFmt.gameObject:SetActive(false)
end

function UINRfCardFacBig:InitRfCDBaseFac()
  base.InitRfCDBaseFac(self)
  self.ui.tex_Switch:SetIndex(1)
  local bonus = self._rfCardData:GetRfCdInfiniteCoe()
  self.ui.tex_BonusFac:SetIndex(0, tostring(bonus))
  self._buffItemPool = self._buffItemPool or UIItemPool.New(UINRfCdBuffItem, self.ui.buffItemFac, false)
  self._buffItemPool:HideAll()
  local buffList = self._rfCardData:GetRfCdBuffList()
  for k, epBuff in ipairs(buffList) do
    local buffItem = self._buffItemPool:GetOne()
    buffItem:InitRfCdBuffItem(epBuff:GetBuffCfg())
  end
  self._chipItemPool = self._chipItemPool or UIItemPool.New(UINChipItem, self.ui.chipItemFac, false)
  self._chipItemPool:HideAll()
  local chipList = self._rfCardData:GetRfCdStartChipList()
  for k, chipData in ipairs(chipList) do
    local chip = self._chipItemPool:GetOne()
    chip:InitChipItem(chipData)
  end
end

function UINRfCardFacBig:SetRfCdFacSwitchNotTween()
  self._notSwitchTween = true
end

function UINRfCardFacBig:_OnClickSwitch()
  if self._notSwitchTween then
    self._isFmt = not self._isFmt
  else
    ReinforceUtil.SwitchRfCardTween(self.ui.canvasGroup, function()
      self:InitRfCardFacBig(self._rfCardData, self._resloader, not self._isFmt)
    end)
  end
  self:_OnClickCheck(true)
end

function UINRfCardFacBig:InitRfCDBaseFacFmt()
  base.InitRfCDBaseFacFmt(self)
  self.ui.tex_Switch:SetIndex(0)
  self._buffFmtItemPool = self._buffFmtItemPool or UIItemPool.New(UINRfCdBuffItem, self.ui.buffItemFmt, false)
  self._buffFmtItemPool:HideAll()
  local buffList = self._rfCardData:GetRfCdFacFmtBuffList()
  for k, epBuff in ipairs(buffList) do
    local buffItem = self._buffFmtItemPool:GetOne()
    buffItem:InitRfCdBuffItem(epBuff:GetBuffCfg())
  end
  self._chipFmtItemPool = self._chipFmtItemPool or UIItemPool.New(UINChipItem, self.ui.chipItemFmt, false)
  self._chipFmtItemPool:HideAll()
  local chipList = self._rfCardData:GetRfCdFacFmtChipList()
  for k, chipData in ipairs(chipList) do
    local chip = self._chipFmtItemPool:GetOne()
    chip:InitChipItem(chipData)
  end
end

function UINRfCardFacBig:OnDelete()
  if self._buffItemPool then
    self._buffItemPool:DeleteAll()
  end
  if self._chipItemPool then
    self._chipItemPool:DeleteAll()
  end
  if self._buffFmtItemPool then
    self._buffFmtItemPool:DeleteAll()
  end
  if self._chipFmtItemPool then
    self._chipFmtItemPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINRfCardFacBig
