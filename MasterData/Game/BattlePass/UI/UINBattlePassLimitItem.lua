local UINBattlePassLimitItem = class("UINBattlePassLimitItem", UIBaseNode)
local base = UIBaseNode
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINBattlePassLimitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Pick, self, self.OnPassBaseItemClicked)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.baseItem)
end

function UINBattlePassLimitItem:UpdatePassLimitItemUI(passInfo, clickEvent)
  local passCfg = passInfo.passCfg
  self.clickEvent = clickEvent
  self.passInfo = passInfo
  local availableCount = passInfo:GetNoTakenLimitRewardCount()
  self._availableCount = availableCount
  self.ui.obj_CanRecive:SetActive(0 < availableCount)
  self.ui.obj_lock:SetActive(not passInfo:IsPassFullLevel())
  if 0 < availableCount then
    self.ui.tex_Count.text = tostring(availableCount)
  end
  local itemId = passCfg.limit_reward_id
  local itemCount = passCfg.limit_reward_num
  local itemCfg = ConfigData.item[itemId]
  self.baseItem:InitItemWithCount(itemCfg, itemCount, nil)
end

function UINBattlePassLimitItem:OnPassBaseItemClicked()
  if self._availableCount <= 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassRewardPreview, function(window)
      if window == nil then
        return
      end
      local passCfg = self.passInfo.passCfg
      window:InitBPRewardPreview(passCfg.limit_reward_id, passCfg.preview_reward_ids, passCfg.preview_reward_nums)
    end)
    return
  end
  if self.clickEvent ~= nil then
    self.clickEvent()
  end
end

function UINBattlePassLimitItem:OnDelete()
  base.OnDelete(self)
end

return UINBattlePassLimitItem
