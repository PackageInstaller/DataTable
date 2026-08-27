local UINBattlePassTable = require("Game.BattlePass.UI.UINBattlePassTable")
local base = UINBattlePassTable
local UINBattlePassTableActivity = class("UINBattlePassTableActivity", base)
local UINBattlePassItemActivity = require("Game.BattlePass.UI.UINBattlePassItemActivity")
local UINBattlePassTagItemActivity = require("Game.BattlePass.UI.UINBattlePassTagItemActivity")

function UINBattlePassTableActivity:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loopScrollRect.onInstantiateItem = BindCallback(self, self.__OnPassNewItem)
  self.ui.loopScrollRect.onChangeItem = BindCallback(self, self.__OnPasItemChanged)
  self.ui.loopScrollRect.onValueChanged:AddListener(BindCallback(self, self.OnScrollValueChanged))
  self.__passItemDic = {}
  self.passTagItem = UINBattlePassTagItemActivity.New()
  self.passTagItem:Init(self.ui.tagBattlePassItem)
  self.passTagValueOffset = 0.5
  self.__OnBattlePassItemClicked = BindCallback(self, self.OnBattlePassItemClicked)
  self.__onLimitsItemClicked = BindCallback(self, self.OnBattlePassLimitItemClicked)
end

function UINBattlePassTableActivity:InitBattlePassTable(passInfo, overLimitReward)
  self.passInfo = passInfo
  self.passInfoCfg = passInfo:GetPassCfg()
  local color = self.passInfoCfg.color
  self.mainColor = Color.New(color[1] / 255, color[2] / 255, color[3] / 255)
  self.ui.img_Head.color = self.mainColor
  local baseItemWidth = self.ui.ly_battlePassItem.preferredWidth
  local itemSpaceWidth = self.ui.layout_rect.spacing
  local baseItemTotalWidth = baseItemWidth * passInfo.maxlevel + (passInfo.maxlevel - 1) * itemSpaceWidth
  local totalWidth = baseItemTotalWidth
  local scrollWidth = self.ui.loopScrollRect.transform.rect.width
  self.offsetRatio = scrollWidth / (totalWidth - scrollWidth)
  self.baseScrollRatioUint = totalWidth / (totalWidth - scrollWidth) / passInfo.maxlevel
  local defaultLevel = self.passInfo:GetPassDefaultShowLevel()
  self.ui.loopScrollRect.totalCount = passInfo.maxlevel
  self.ui.loopScrollRect:RefillCells(math.clamp(defaultLevel - 2, 0, passInfo.maxlevel - 1))
  if defaultLevel + 3 >= self.passInfo.maxlevel then
    self.ui.loopScrollRect.horizontalNormalizedPosition = 1
  end
  self:__OnPassTableValueChanged(self.ui.loopScrollRect.horizontalNormalizedPosition)
end

function UINBattlePassTableActivity:__OnPassNewItem(go)
  local passItem = UINBattlePassItemActivity.New()
  passItem:Init(go)
  self.__passItemDic[go] = passItem
end

function UINBattlePassTableActivity:__OnPasItemChanged(go, index)
  local passItem = self.__passItemDic[go]
  if passItem == nil then
    error("Can't find passItem by gameObject")
    return
  end
  local level = index + 1
  local passLevelCfg = ConfigData.battlepass[self.passInfo.id][level]
  if passLevelCfg == nil then
    error(string.format("battle pass cfg is null,id:%d level:%d", self.passInfo.id, level))
    return
  end
  passItem:InitBattlePassItem(passLevelCfg, self.passInfo, self.__OnBattlePassItemClicked)
end

return UINBattlePassTableActivity
