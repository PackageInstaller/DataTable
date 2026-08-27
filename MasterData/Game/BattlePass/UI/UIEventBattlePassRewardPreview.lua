local base = UIBaseWindow
local UIEventBattlePassRewardPreview = class("UIEventBattlePassRewardPreview", base)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UIEventBattlePassRewardPreview:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self._OnClickClose)
  self.rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem, false)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.baseItem)
end

function UIEventBattlePassRewardPreview:InitBPRewardPreview(itemId, rewardIds, rewardNums)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("item cfg is null,id:" .. tostring(itemId))
    return
  end
  self.baseItem:InitBaseItem(itemCfg)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_ItemDes.text = LanguageUtil.GetLocaleText(itemCfg.describe)
  self.rewardPool:HideAll()
  for index, id in pairs(rewardIds) do
    local itemCfg = ConfigData.item[id]
    if itemCfg ~= nil then
      local num = rewardNums[index]
      local rewardItem = self.rewardPool:GetOne()
      rewardItem:InitItemWithCount(itemCfg, num)
    end
  end
end

function UIEventBattlePassRewardPreview:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventBattlePassRewardPreview:OnDelete()
  base.OnDelete(self)
end

return UIEventBattlePassRewardPreview
