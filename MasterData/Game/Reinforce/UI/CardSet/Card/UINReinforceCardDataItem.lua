local base = UIBaseNode
local UINReinforceCardDataItem = class("UINReinforceCardDataItem", base)
local UINRfCardSetChipItem = require("Game.Reinforce.UI.CardSet.Card.UINRfCardSetChipItem")
local UINRfCdBuffItem = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local ChipData = require("Game.PlayerData.Item.ChipData")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")

function UINReinforceCardDataItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINReinforceCardDataItem:InitCardDataItem(card, resloader)
  self._rfCardData = card
  self._resloader = resloader
  self.ui.obj_notSet:SetActive(self._rfCardData == nil)
  self.ui.obj_isSet:SetActive(self._rfCardData ~= nil)
  if self._rfCardData == nil then
    return
  end
  self:RefreshCardData()
end

function UINReinforceCardDataItem:RefreshSysCardData()
  self:_UpdStar()
  self:_UpdSmallBuffSys(self.ui.buffItem)
  self:_UpdChipSys(self.ui.uINChipItem)
end

function UINReinforceCardDataItem:RefreshFacCardData()
  self:_UpdSmallBuffFac(self.ui.buffItem)
  self:_UpdChipFac(self.ui.uINChipItem)
end

function UINReinforceCardDataItem:RefreshCardData()
  self.ui.obj_lvlGroup:SetActive(self._rfCardData:GetRfCdType() == eReinforce.eRfCardType.System)
  if self._rfCardData:GetRfCdType() == eReinforce.eRfCardType.System then
    self:RefreshSysCardData()
  else
    self:RefreshFacCardData()
  end
  local bonus = self._rfCardData:GetRfCdInfiniteCoe()
  self.ui.tex_BonusSys:SetIndex(0, tostring(bonus))
  self:LoadRfCdBg(self.ui.img_BgPic)
end

function UINReinforceCardDataItem:_UpdStar()
  local curStar = self._rfCardData:GetRfCardStar()
  self._starPool = self._starPool or UIItemPool.New(UIBaseNode, self.ui.starItem, false)
  self._starPool:HideAll()
  for i = 1, curStar do
    self._starPool:GetOne()
  end
end

function UINReinforceCardDataItem:_UpdSmallBuffSys(buffItem)
  self._buffItemPool = self._buffItemPool or UIItemPool.New(UINRfCdBuffItem, buffItem, false)
  self._buffItemPool:HideAll()
  local curStarCfg = self._rfCardData:GetRfCardStarCfg()
  local maxStarCfg = self._rfCardData:GetRfCardMaxStarCfg()
  self.ui.obj_emptyBuff:SetActive(#maxStarCfg.proto_list == 0)
  for k, buffId in ipairs(maxStarCfg.proto_list) do
    local islock = not table.contain(curStarCfg.proto_list, buffId)
    local buffCfg = ConfigData.exploration_buff[buffId]
    if buffCfg == nil then
      error("exploration buff cfg is null,id:" .. tostring(self.dataId))
      return
    end
    local buffItem = self._buffItemPool:GetOne()
    buffItem:InitRfCdBuffItem(buffCfg)
    buffItem:SetRfCdBuffItemLock(islock)
  end
end

function UINReinforceCardDataItem:_UpdChipSys(chipItem)
  self._chipItemPool = self._chipItemPool or UIItemPool.New(UINRfCardSetChipItem, chipItem, false)
  self._chipItemPool:HideAll()
  local curStarCfg = self._rfCardData:GetRfCardStarCfg()
  local maxStarCfg = self._rfCardData:GetRfCardMaxStarCfg()
  self.ui.obj_emptyFxBuff:SetActive(#maxStarCfg.startFuncId == 0)
  for k, chipId in ipairs(maxStarCfg.startFuncId) do
    local num = curStarCfg.startFuncLv[k]
    local chipData = ChipData.New(chipId, num)
    local isLock = not table.contain(curStarCfg.startFuncId, chipId)
    if not isLock then
      num = curStarCfg.startFuncLv[k]
    end
    local chip = self._chipItemPool:GetOne()
    chip:InitRfCardSetChipItem(chipData, isLock)
  end
end

function UINReinforceCardDataItem:_UpdSmallBuffFac(buffItem)
  self._buffItemPool = self._buffItemPool or UIItemPool.New(UINRfCdBuffItem, buffItem, false)
  self._buffItemPool:HideAll()
  local buffList = self._rfCardData:GetRfCdBuffList()
  self.ui.obj_emptyBuff:SetActive(#buffList == 0)
  for k, epBuff in ipairs(buffList) do
    local buffItem = self._buffItemPool:GetOne()
    buffItem:InitRfCdBuffItem(epBuff:GetBuffCfg())
    buffItem:SetRfCdBuffItemLock(false)
  end
end

function UINReinforceCardDataItem:_UpdChipFac(chipItem)
  self._chipItemPool = self._chipItemPool or UIItemPool.New(UINRfCardSetChipItem, chipItem, false)
  self._chipItemPool:HideAll()
  local chipList = self._rfCardData:GetRfCdStartChipList()
  self.ui.obj_emptyFxBuff:SetActive(#chipList == 0)
  for k, chipData in ipairs(chipList) do
    local chip = self._chipItemPool:GetOne()
    chip:InitRfCardSetChipItem(chipData)
  end
end

function UINReinforceCardDataItem:LoadRfCdBg(rawImg)
  local path = self._rfCardData:GetRfCardBgPath()
  rawImg.enabled = false
  self._resloader:LoadABAssetAsync(PathConsts:GetReinforceCardBgPath(path), function(texture)
    if IsNull(texture) then
      return
    end
    rawImg.texture = texture
    rawImg.enabled = true
  end)
end

function UINReinforceCardDataItem:GetRfCdBgTexture()
  return self.ui.img_BgPic.texture
end

function UINReinforceCardDataItem:OnDelete()
end

return UINReinforceCardDataItem
