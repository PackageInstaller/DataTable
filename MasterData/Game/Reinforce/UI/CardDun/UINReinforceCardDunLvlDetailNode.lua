local base = UIBaseNode
local UINReinforceCardDunLvlDetailNode = class("UINReinforceCardDunLvlDetailNode", base)
local UINReinforceCardDunLvlDetailNodeItem = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunLvlDetailNodeItem")

function UINReinforceCardDunLvlDetailNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  self.itemPool = UIItemPool.New(UINReinforceCardDunLvlDetailNodeItem, self.ui.Item, false)
end

function UINReinforceCardDunLvlDetailNode:RefreshLevelDetail(levelData, actData, curLevel)
  UIUtil.SetTopStatus(self, self.Hide)
  self.itemPool:HideAll()
  local stageId = levelData:GetStageId()
  local layerGroupId = levelData:GetLayerGroupId()
  local cfgList = ConfigData.reinforce_exploration_layer_group[layerGroupId]
  for levelIndex, cfg in ipairs(cfgList) do
    if not string.IsNullOrEmpty(cfg.tip_name) then
      local item = self.itemPool:GetOne(true)
      local isUnlock = (cfg.unlock_layer or 0) <= (actData:GetHightestLevelByStageId(stageId) or 0)
      local nextItemIndex = #cfgList
      for i = levelIndex + 1, #cfgList do
        local nextCfg = cfgList[i]
        if not string.IsNullOrEmpty(nextCfg.tip_name) then
          nextItemIndex = i
          break
        end
      end
      local isCurrent = levelIndex <= curLevel and curLevel <= nextItemIndex
      item:RefreshLevelItem(cfg, isUnlock, isCurrent)
    end
  end
end

function UINReinforceCardDunLvlDetailNode:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINReinforceCardDunLvlDetailNode:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardDunLvlDetailNode
