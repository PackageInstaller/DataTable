local base = UIBaseNode
local UINRfCdSysLvInfo = class("UINRfCdSysLvInfo", base)
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local UINRfCdDetailChipItem = require("Game.Reinforce.UI.FactorCard.Detail.UINRfCdDetailChipItem")
local UINRfCdBuffItem = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local UINRfCdStarItem = require("Game.Reinforce.UI.SystemCard.LvUp.UINRfCdStarItem")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
local cs_MessageCommon = CS.MessageCommon

function UINRfCdSysLvInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_FxLibCheck, self, self._OnClickChipLib)
  self._starItemPool = UIItemPool.New(UINRfCdStarItem, self.ui.lvlItem, false)
  self._chipItem = UINRfCdDetailChipItem.New()
  self._chipItem:Init(self.ui.chip)
  self._buffItemPool = UIItemPool.New(UINRfCdBuffItem, self.ui.buffItem, false)
  self._OnChipClickFunc = BindCallback(self, self._OnChipClick)
  self._OnClickBuffFunc = BindCallback(self, self._OnClickBuff)
end

function UINRfCdSysLvInfo:InitRfCdSysLvInfo(starCfg, rfCdData, isLvUp)
  self._starCfg = starCfg
  self._rfCardData = rfCdData
  self._isLvUp = isLvUp
  self._starItemPool:HideAll()
  for i = 1, starCfg.star do
    self._starItemPool:GetOne()
  end
  if self.ui.img_LvlBg then
    self.ui.img_LvlBg:SetIndex(starCfg.star - 1)
  end
  if isLvUp then
    local minStar = ReinforceUtil.GetCardLowestStar(starCfg.id)
    if minStar == starCfg.star then
      self.ui.tex_Bonus:SetIndex(1, tostring(starCfg.infinite_coe))
    else
      local minStarCfg = ConfigData.reinforce_card_card_star[starCfg.id][minStar]
      local baseValue = minStarCfg.infinite_coe
      local addValue = starCfg.infinite_coe - baseValue
      self.ui.tex_Bonus:SetIndex(starCfg.star, tostring(baseValue), addValue)
    end
  else
    self.ui.tex_Bonus:SetIndex(0, tostring(starCfg.infinite_coe))
  end
  local maxStar = ConfigData.reinforce_card_card_star.rfcdSysMaxStarDic[starCfg.id]
  local maxStarCfg = ConfigData.reinforce_card_card_star[starCfg.id][maxStar]
  if #maxStarCfg.startFuncId == 0 then
    self._chipItem:Hide()
    self.ui.emptyChip:SetActive(true)
  else
    self._chipItem:Show()
    self.ui.emptyChip:SetActive(false)
    local chipId = maxStarCfg.startFuncId[1]
    local num = maxStarCfg.startFuncLv[1]
    local isLock = not table.contain(starCfg.startFuncId, chipId)
    if not isLock then
      num = starCfg.startFuncLv[1]
    end
    local unlockStar = self._rfCardData:GetRfCdChipUnlockStar(chipId)
    local chipData = ChipData.New(chipId, num)
    self._chipItem:InitRfCdDetailChipItem(chipData, self._OnChipClickFunc)
    self._chipItem:SetRfCdDetailChipItemLock(isLock, unlockStar)
  end
  self._buffItemPool:HideAll()
  for k, buffId in ipairs(maxStarCfg.proto_list) do
    local islock = not table.contain(starCfg.proto_list, buffId)
    local buffCfg = ConfigData.exploration_buff[buffId]
    if buffCfg == nil then
      error("exploration buff cfg is null,id:" .. tostring(self.dataId))
      return
    end
    local unlockStar = self._rfCardData:GetRfCdBuffUnlockStar(buffCfg.id)
    local buffItem = self._buffItemPool:GetOne()
    buffItem:InitRfCdBuffItem(buffCfg)
    buffItem:SetRfCdBuffItemLock(islock)
    buffItem:SetRfCdBuffItemUnlockStar(unlockStar)
    buffItem:SetRfCdBuffItemClickFunc(self._OnClickBuffFunc)
  end
  self.ui.emptyBuff:SetActive(#maxStarCfg.proto_list == 0)
end

function UINRfCdSysLvInfo:UpdRfCdSysLvInfo(curStar)
  local isCurStar = curStar >= self._starCfg.star
  for k, starItem in ipairs(self._starItemPool.listItem) do
    starItem:InitRfCdStarItem(isCurStar)
  end
  self.ui.img_LvlBg.image.color = self.ui.lvbgColor[isCurStar and 1 or 2]
  if self._isLvUp then
    self.ui.canvasGroup.alpha = isCurStar and 1 or 0.7
  end
end

function UINRfCdSysLvInfo:_OnClickChipLib()
  local funcGroupId = self._starCfg.func_group
  local groupCfg = ConfigData.reinforce_card_func_group[funcGroupId]
  if groupCfg == nil then
    error("Cant get reinforce_card_func_group, id:" .. tostring(funcGroupId))
    return
  end
  local chipDataList = {}
  for k, cfg in pairs(groupCfg) do
    local chipData = ChipData.New(cfg.func_id, cfg.func_level)
    table.insert(chipDataList, chipData)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
    window:InitCurrentChip(chipDataList)
    window:SetCurrentChipTitleIdx(1)
  end)
end

function UINRfCdSysLvInfo:SetRfCdRfCdSysLvInfoCardTransfrom(cardTransfrom)
  self._cardTransfrom = cardTransfrom
end

function UINRfCdSysLvInfo:_OnClickBuff(buffCfg)
  local curStar = self._rfCardData:GetRfCardStar()
  local unlockStar = self._rfCardData:GetRfCdBuffUnlockStar(buffCfg.id)
  if curStar < unlockStar then
    cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(59001), unlockStar))
  end
end

function UINRfCdSysLvInfo:_OnChipClick(chipData)
  if self._cardTransfrom == nil then
    error("self._cardTransfrom == nil")
    return
  end
  
  local function hideFunc(hideChipData)
    self._chipItem:SetSelectedRfCdDetailChipItem(false)
    self._seleteChip = false
  end
  
  if self._seleteChip then
    UIManager:HideWindow(UIWindowTypeID.ChipDetailFloat)
  else
    self._chipItem:SetSelectedRfCdDetailChipItem(true)
    self._seleteChip = true
    ReinforceUtil.ShowRfCdDetailChipFloat(chipData, self._cardTransfrom, self.transform, 20, hideFunc)
  end
  local curStar = self._rfCardData:GetRfCardStar()
  local unlockStar = self._rfCardData:GetRfCdChipUnlockStar(chipData.dataId)
  if curStar < unlockStar then
    cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(59001), unlockStar))
  end
end

function UINRfCdSysLvInfo:OnDelete()
  self._chipItem:Delete()
  self._buffItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINRfCdSysLvInfo
