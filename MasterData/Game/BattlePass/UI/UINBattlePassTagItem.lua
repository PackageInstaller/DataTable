local UINBattlePassItem = require("Game.BattlePass.UI.UINBattlePassItem")
local UINBattlePassTagItem = class("UINBattlePassTagItem", UINBattlePassItem)
local UINBaseItemWithLock = require("Game.CommonUI.Item.UINBaseItemWithLock")

function UINBattlePassTagItem:OnInit()
  UINBattlePassItem.OnInit(self)
  self.baseItemPool = UIItemPool.New(UINBaseItemWithLock, self.ui.baseItem)
end

function UINBattlePassTagItem:__InitPassItemUI(passLevelCfg)
  self.ui.tex_Level.text = tostring(passLevelCfg.level)
  self.baseItemPool:HideAll()
  local basepacked, baselocked, baseEnable = self:__GetPassRewardStateBase(self.passInfo)
  local seniorpacked, seniorlocked, seniorEnable = self:__GetPassRewardStateSenior(self.passInfo)
  self.ui.obj_SeniorBlack:SetActive(not self.passInfo.unlockSenior)
  for index, itemId in pairs(passLevelCfg.base_item_ids) do
    local itemCount = passLevelCfg.base_item_nums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self.baseItemPool:GetOne()
      baseItem.transform:SetParent(self.ui.btn_Base.transform)
      baseItem.transform.anchoredPosition3D = Vector3.zero
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, basepacked, baselocked)
    end
  end
  for index, itemId in pairs(passLevelCfg.senior_item_ids) do
    local itemCount = passLevelCfg.senior_item_nums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self.baseItemPool:GetOne()
      baseItem.transform:SetParent(self.ui.btn_Advance.transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, seniorpacked, seniorlocked)
    end
  end
end

return UINBattlePassTagItem
