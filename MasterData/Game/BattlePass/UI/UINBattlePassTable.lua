local UINBattlePassTable = class("UINBattlePassTable", UIBaseNode)
local base = UIBaseNode
local UINBattlePassItem = require("Game.BattlePass.UI.UINBattlePassItem")
local UINBattlePassLimitItem = require("Game.BattlePass.UI.UINBattlePassLimitItem")
local UINBattlePassTagItem = require("Game.BattlePass.UI.UINBattlePassTagItem")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")

function UINBattlePassTable:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loopScrollRect.onInstantiateItem = BindCallback(self, self.__OnPassNewItem)
  self.ui.loopScrollRect.onChangeItem = BindCallback(self, self.__OnPasItemChanged)
  self.ui.loopScrollRect.onValueChanged:AddListener(BindCallback(self, self.OnScrollValueChanged))
  self.__passItemDic = {}
  self.passTagItem = UINBattlePassTagItem.New()
  self.passTagItem:Init(self.ui.tagBattlePassItem)
  self.passTagValueOffset = 0.5
  self.__OnBattlePassItemClicked = BindCallback(self, self.OnBattlePassItemClicked)
  self.__onLimitsItemClicked = BindCallback(self, self.OnBattlePassLimitItemClicked)
end

function UINBattlePassTable:InitBattlePassTable(passInfo, overLimitReward)
  self.passInfo = passInfo
  self._overLimitReward = overLimitReward or false
  if self._overLimitReward then
    if self.passLimitItem == nil then
      self.passLimitItem = UINBattlePassLimitItem.New()
      self.passLimitItem:Init(self.ui.spBattlePassItem)
    end
    self.passLimitItem:UpdatePassLimitItemUI(passInfo, self.__onLimitsItemClicked)
  end
  local baseItemWidth = self.ui.ly_battlePassItem.preferredWidth
  local itemSpaceWidth = self.ui.layout_rect.spacing
  local limitItemWidth = 0
  local limitItemCount = 0
  if self._overLimitReward then
    limitItemCount = 2
    limitItemWidth = (baseItemWidth + itemSpaceWidth) * limitItemCount
  end
  local baseItemTotalWidth = baseItemWidth * passInfo.maxlevel + (passInfo.maxlevel - 1) * itemSpaceWidth
  local totalWidth = baseItemTotalWidth + limitItemWidth
  local scrollWidth = self.ui.loopScrollRect.transform.rect.width
  self.offsetRatio = scrollWidth / (totalWidth - scrollWidth)
  self.baseScrollRatioUint = (totalWidth - limitItemWidth) / (totalWidth - scrollWidth) / passInfo.maxlevel
  local defaultLevel = self.passInfo:GetPassDefaultShowLevel()
  self.ui.loopScrollRect.totalCount = passInfo.maxlevel + limitItemCount
  self.ui.loopScrollRect:RefillCells(math.clamp(defaultLevel - 2, 0, passInfo.maxlevel - 1 - limitItemCount))
  if defaultLevel + 3 >= self.passInfo.maxlevel then
    self.ui.loopScrollRect.horizontalNormalizedPosition = 1
  end
  self:__OnPassTableValueChanged(self.ui.loopScrollRect.horizontalNormalizedPosition)
end

function UINBattlePassTable:UpdateBattlePassTable(passInfo)
  self.ui.loopScrollRect:RefreshCells()
  if self.passLimitItem ~= nil then
    self.passLimitItem:UpdatePassLimitItemUI(passInfo, self.__onLimitsItemClicked)
  end
  if self.passTagItem.active then
    self.passTagItem:UpdatePassItemUI(passInfo)
  end
end

function UINBattlePassTable:__OnPassNewItem(go)
  local passItem = UINBattlePassItem.New()
  passItem:Init(go)
  self.__passItemDic[go] = passItem
end

function UINBattlePassTable:__OnPasItemChanged(go, index)
  local passItem = self.__passItemDic[go]
  if passItem == nil then
    error("Can't find passItem by gameObject")
    return
  end
  local level = index + 1
  if level > self.passInfo.maxlevel then
    local offset = level - self.passInfo.maxlevel
    if offset == 1 then
      passItem:InitBattlePassSepcItem(self.passLimitItem)
    else
      passItem:InitBattlePassEmptyItem()
    end
    return
  end
  local passLevelCfg = ConfigData.battlepass[self.passInfo.id][level]
  if passLevelCfg == nil then
    error(string.format("battle pass cfg is null,id:%d level:%d", self.passInfo.id, level))
    return
  end
  passItem:InitBattlePassItem(passLevelCfg, self.passInfo, self.__OnBattlePassItemClicked)
end

function UINBattlePassTable:OnScrollValueChanged(vec2)
  local x = vec2.x
  if math.abs(self.__lastX - x) < 0.001 then
    return
  end
  self:__OnPassTableValueChanged(x)
end

function UINBattlePassTable:__OnPassTableValueChanged(x)
  self.__lastX = x
  local tag_level = ConfigData.battlepass.tag_levels[self.passInfo.id]
  local useLevel = tag_level[#tag_level]
  local offset = self.offsetRatio
  local level = math.floor((x + offset) / self.baseScrollRatioUint + self.passTagValueOffset)
  for i = 1, #tag_level do
    local cur_level = tag_level[i]
    if level < cur_level then
      useLevel = cur_level
      break
    end
  end
  local finalLevel = tag_level[#tag_level]
  if useLevel == finalLevel and self._overLimitReward and level > finalLevel - 2 then
    useLevel = 0
  end
  if self.__lastTagLevel ~= useLevel then
    self:UpdatePassTagItem(useLevel)
  end
end

function UINBattlePassTable:UpdatePassTagItem(level)
  self.__lastTagLevel = level
  if level == 0 then
    self.passTagItem:Hide()
    return
  end
  local passLevelCfg = ConfigData.battlepass[self.passInfo.id][level]
  if passLevelCfg == nil then
    error(string.format("battle pass cfg is null,id:%d level:%d", self.passInfo.id, level))
  end
  self.passTagItem:InitBattlePassItem(passLevelCfg, self.passInfo)
  self.passTagItem:Show()
end

function UINBattlePassTable:LocationPassItemByLevel(level)
end

function UINBattlePassTable:OnBattlePassItemClicked(level, isSenior)
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  local takeway = BattlePassEnum.TakeWay.Base
  if isSenior then
    takeway = BattlePassEnum.TakeWay.Senior
  end
  battlepassCtrl:TakeBattlePassReward(self.passInfo.id, level, takeway)
end

function UINBattlePassTable:OnBattlePassLimitItemClicked()
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:TakeBattlePassReward(self.passInfo.id, 0, BattlePassEnum.TakeWay.Overflow)
end

function UINBattlePassTable:OnDelete()
  base.OnDelete(self)
end

return UINBattlePassTable
