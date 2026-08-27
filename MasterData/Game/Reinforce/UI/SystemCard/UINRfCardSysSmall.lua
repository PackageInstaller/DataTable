local base = require("Game.Reinforce.UI.Card.UINReinforceCardBase")
local UINRfCardSysSmall = class("UINRfCardSysSmall", base)
local UINRfCdBuffItem = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local UINRfCardSetChipItem = require("Game.Reinforce.UI.CardSet.Card.UINRfCardSetChipItem")
local ChipData = require("Game.PlayerData.Item.ChipData")

function UINRfCardSysSmall:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  self.ui.btn_root.onPress:AddListener(BindCallback(self, self._OnPress))
end

function UINRfCardSysSmall:InitRfCardSysSmall(rfCardData, resloader)
  base.InitRfCardBase(self, rfCardData, resloader)
end

function UINRfCardSysSmall:SetRfCardSysSmallClickFunc(clickFunc)
  self._clickFunc = clickFunc
end

function UINRfCardSysSmall:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self, self._rfCardData)
  end
end

function UINRfCardSysSmall:_OnPress()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailSys, function(win)
    if win == nil then
      return
    end
    win:InitReinforceCardDetailSys(self._rfCardData)
  end)
end

function UINRfCardSysSmall:InitRfCDBaseSystem()
  base.InitRfCDBaseSystem(self)
  self:_UpdStar()
  self:_UpdateBonus()
  self:_UpdSmallBuffSys(self.ui.buffItemSys)
  self:_UpdChipSys(self.ui.chipItem)
end

function UINRfCardSysSmall:_UpdStar()
  local curStar = self._rfCardData:GetRfCardStar()
  self._starPool = self._starPool or UIItemPool.New(UIBaseNode, self.ui.starItem, false)
  self._starPool:HideAll()
  for i = 1, curStar do
    self._starPool:GetOne()
  end
end

function UINRfCardSysSmall:_UpdateBonus()
  local bonus = self._rfCardData:GetRfCdInfiniteCoe()
  self.ui.tex_BonusSys:SetIndex(0, tostring(bonus))
end

function UINRfCardSysSmall:_UpdSmallBuffSys(buffItem)
  self._buffItemPool = self._buffItemPool or UIItemPool.New(UINRfCdBuffItem, buffItem, false)
  self._buffItemPool:HideAll()
  local curStarCfg = self._rfCardData:GetRfCardStarCfg()
  local maxStarCfg = self._rfCardData:GetRfCardMaxStarCfg()
  if curStarCfg == nil or maxStarCfg == nil then
    return
  end
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

function UINRfCardSysSmall:_UpdChipSys(chipItem)
  self._chipItemPool = self._chipItemPool or UIItemPool.New(UINRfCardSetChipItem, chipItem, false)
  self._chipItemPool:HideAll()
  local curStarCfg = self._rfCardData:GetRfCardStarCfg()
  local maxStarCfg = self._rfCardData:GetRfCardMaxStarCfg()
  if curStarCfg == nil or maxStarCfg == nil then
    return
  end
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

function UINRfCardSysSmall:OnDelete()
  if self._buffItemPool then
    self._buffItemPool:DeleteAll()
  end
  if self._chipItemPool then
    self._chipItemPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINRfCardSysSmall
