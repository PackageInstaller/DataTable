local UINBattlePassTagItem = require("Game.BattlePass.UI.UINBattlePassTagItem")
local base = UINBattlePassTagItem
local UINBattlePassTagItemActivity = class("UINBattlePassTagItemActivity", base)
local UINBaseItemWithLock = require("Game.CommonUI.Item.UINBaseItemWithLock")

function UINBattlePassTagItemActivity:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__baseItemPool = UIItemPool.New(UINBaseItemWithLock, self.ui.baseItem)
  self.baseItemPool = UIItemPool.New(UINBaseItemWithLock, self.ui.baseItem)
  self.ui.baseItem.gameObject:SetActive(false)
  self._lastItemType = 0
end

function UINBattlePassTagItemActivity:InitBattlePassItem(passLevelCfg, passInfo, clickEvent)
  base.InitBattlePassItem(self, passLevelCfg, passInfo, clickEvent)
  self.passInfoCfg = passInfo:GetPassCfg()
  local color = self.passInfoCfg.color
  self.mainColor = Color.New(color[1] / 255, color[2] / 255, color[3] / 255)
  self.ui.img_Head.color = self.mainColor
  self.ui.img_Line.color = self.mainColor
  self.ui.img_Lock.color = self.mainColor
end

function UINBattlePassTagItemActivity:__InitPassItemUI(passLevelCfg)
  base.__InitPassItemUI(self, passLevelCfg)
  local basepacked, baselocked, baseEnable = self:__GetPassRewardStateBase(self.passInfo)
  local seniorpacked, seniorlocked, seniorEnable = self:__GetPassRewardStateSenior(self.passInfo)
  self.ui.tex_State:SetIndex(self.passInfo.level < passLevelCfg.level and 0 or 1)
end

return UINBattlePassTagItemActivity
