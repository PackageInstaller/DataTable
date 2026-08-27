local UINBattlePassItem = require("Game.BattlePass.UI.UINBattlePassItem")
local base = UINBattlePassItem
local UINBattlePassItemActivity = class("UINBattlePassItemActivity", base)

function UINBattlePassItemActivity:InitBattlePassItem(passLevelCfg, passInfo, clickEvent)
  base.InitBattlePassItem(self, passLevelCfg, passInfo, clickEvent)
  self.passInfoCfg = passInfo:GetPassCfg()
  local color = self.passInfoCfg.color
  self.mainColor = Color.New(color[1] / 255, color[2] / 255, color[3] / 255)
  self.ui.img_Head.color = self.mainColor
  self.ui.img_Complete.color = self.mainColor
end

function UINBattlePassItemActivity:__InitPassItemUI(passLevelCfg)
  self.__baseItemPool:HideAll()
  local basepacked, baselocked, baseEnable = self:__GetPassRewardStateBase(self.passInfo)
  local seniorpacked, seniorlocked, seniorEnable = self:__GetPassRewardStateSenior(self.passInfo)
  self.ui.obj_SeniorBlack:SetActive(not self.passInfo.unlockSenior)
  self.ui.baseReward:SetActive(baseEnable)
  self.ui.advReward:SetActive(seniorEnable)
  self.ui.baseTouch.raycastTarget = baseEnable
  self.ui.advTouch.raycastTarget = seniorEnable
  self.ui.tex_Level.text = tostring(passLevelCfg.level)
  self.ui.img_Line:SetActive(self.level <= self.passInfo.level)
  self.ui.img_Complete.gameObject:SetActive(self.level <= self.passInfo.level)
  self.ui.img_Base:SetIndex(basepacked and 0 or 1)
  self.ui.img_Advance:SetIndex(seniorpacked and 0 or 1)
  self.ui.obj_Arrow:SetActive(self.level == self.passInfo.level)
  for index, itemId in pairs(passLevelCfg.base_item_ids) do
    local itemCount = passLevelCfg.base_item_nums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self:__CreatePassRewardItem(self.ui.obj_BaseItemHolder.transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, basepacked, baselocked)
    end
  end
  for index, itemId in pairs(passLevelCfg.senior_item_ids) do
    local itemCount = passLevelCfg.senior_item_nums[index]
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self:__CreatePassRewardItem(self.ui.obj_AdvanceItemHolder.transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, seniorpacked, seniorlocked)
    end
  end
  self.ui.baseTouch.transform:SetAsLastSibling()
  self.ui.advTouch.transform:SetAsLastSibling()
end

return UINBattlePassItemActivity
