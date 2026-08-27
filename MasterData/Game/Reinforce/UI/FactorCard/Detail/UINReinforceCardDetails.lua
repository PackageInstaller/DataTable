local base = UIBaseNode
local UINReinforceCardDetails = class("UINReinforceCardDetails", base)
local UINRfCdDetailChipItem = require("Game.Reinforce.UI.FactorCard.Detail.UINRfCdDetailChipItem")
local UINRfCdBuffItem = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local ChipData = require("Game.PlayerData.Item.ChipData")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")

function UINReinforceCardDetails:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CheckDetails, self, self._OnClickCheckDetails)
  self._buffItemPool = UIItemPool.New(UINRfCdBuffItem, self.ui.buffItem, false)
  self._chipItemPool = UIItemPool.New(UINRfCdDetailChipItem, self.ui.chipItem, false)
  self._OnChipClickFunc = BindCallback(self, self._OnChipClick)
end

function UINReinforceCardDetails:InitReinforceCardDetails(rfCardData, isFmt)
  self._rfCardData = rfCardData
  self._isFmt = isFmt
  self.ui.tex_Title:SetIndex(isFmt and 0 or 1)
  self._buffItemPool:HideAll()
  local buffList = isFmt and self._rfCardData:GetRfCdFacFmtBuffList() or self._rfCardData:GetRfCdBuffList()
  for k, epBuff in ipairs(buffList) do
    local buffItem = self._buffItemPool:GetOne()
    buffItem:InitRfCdBuffItem(epBuff:GetBuffCfg())
  end
  self.ui.emptyBuff:SetActive(#buffList == 0)
  self.ui.scrollBuff.verticalNormalizedPosition = 1
  self._chipItemDic = {}
  self._chipItemPool:HideAll()
  local chipList = isFmt and self._rfCardData:GetRfCdFacFmtChipList() or self._rfCardData:GetRfCdStartChipList()
  for k, chipData in ipairs(chipList) do
    local chip = self._chipItemPool:GetOne()
    chip:InitRfCdDetailChipItem(chipData, self._OnChipClickFunc)
    self._chipItemDic[chipData] = chip
  end
  self.ui.emptyChip:SetActive(#chipList == 0)
  self.ui.scrollChip.verticalNormalizedPosition = 1
end

function UINReinforceCardDetails:_OnClickCheckDetails()
  local chipDataList
  if self._isFmt then
    chipDataList = self._rfCardData:GetRfCdFacFmtChipList()
  else
    chipDataList = self._rfCardData:GetRfCardLibChipList()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
    window:InitCurrentChip(chipDataList)
    window:SetCurrentChipTitleIdx(1)
  end)
end

function UINReinforceCardDetails:SetRfCdDetailsCardTransfrom(cardTransfrom)
  self._cardTransfrom = cardTransfrom
end

function UINReinforceCardDetails:_OnChipClick(chipData)
  if self._cardTransfrom == nil then
    error("self._cardTransfrom == nil")
    return
  end
  
  local function hideFunc(hideChipData)
    self:_ShowChipSelect(hideChipData, false)
    self._showChipData = nil
  end
  
  if self._showChipData == chipData then
    UIManager:HideWindow(UIWindowTypeID.ChipDetailFloat)
  else
    self:_ShowChipSelect(chipData, true)
    self._showChipData = chipData
    ReinforceUtil.ShowRfCdDetailChipFloat(chipData, self._cardTransfrom, self.transform, 25, hideFunc)
  end
end

function UINReinforceCardDetails:_ShowChipSelect(chipData, isSelect)
  local chipItem = self._chipItemDic[chipData]
  if chipItem then
    chipItem:SetSelectedRfCdDetailChipItem(isSelect)
  end
end

function UINReinforceCardDetails:OnDelete()
  self._buffItemPool:DeleteAll()
  self._chipItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINReinforceCardDetails
