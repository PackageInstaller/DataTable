local UINMiniGameTaskActiveItem = class("UINMiniGameTaskActiveItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINMiniGameTaskActiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.OnClickReview)
  self._rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINMiniGameTaskActiveItem:InitMiniGameTaskOnceItem(actTinyData, pointCfg, callback)
  self._actTinyData = actTinyData
  self._pointCfg = pointCfg
  self._callback = callback
  self.ui.tex_CupLevel:SetIndex(0, tostring(self._pointCfg.level))
  self.ui.tex_Requirement:SetIndex(0, tostring(self._pointCfg.need_point))
  self._rewardPool:HideAll()
  for i, itemId in ipairs(self._pointCfg.level_reward_ids) do
    local count = self._pointCfg.level_reward_nums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._rewardPool:GetOne()
    item:InitItemWithCount(itemCfg, count)
  end
  self:RefreshMiniGameTaskOnceItem()
end

function UINMiniGameTaskActiveItem:RefreshMiniGameTaskOnceItem()
  local hasPicked = self._actTinyData:IsTinyGameActiveHasReward(self._pointCfg.level)
  if hasPicked then
    self.ui.img_Background.color = self.ui.color_hasReview
    self.ui.btn_Receive.gameObject:SetActive(false)
    self.ui.finished:SetActive(true)
    self.ui.cupItem.alpha = 0.7
    self.ui.icon.color = Color.white
    self.ui.tex_CupLevel.text.color = Color.white
    self.ui.tex_Requirement.text.color = Color.white
    return
  end
  self.ui.cupItem.alpha = 1
  local isCanReceive = self._actTinyData:IsTinyGameActiveCanReward(self._pointCfg.level)
  self.ui.img_Background.color = self.ui.color_normal
  self.ui.btn_Receive.gameObject:SetActive(isCanReceive)
  self.ui.finished:SetActive(false)
  if isCanReceive then
    self.ui.receive:SetIndex(0)
    self.ui.img_Background.color = Color.white
    self.ui.icon.color = self.ui.color_black_text
    self.ui.tex_CupLevel.text.color = self.ui.color_black_text
    self.ui.tex_Requirement.text.color = self.ui.color_black_text
  else
    self.ui.img_Background.color = self.ui.color_hasReview
    self.ui.icon.color = Color.white
    self.ui.tex_CupLevel.text.color = Color.white
    self.ui.tex_Requirement.text.color = Color.white
  end
end

function UINMiniGameTaskActiveItem:OnClickReview()
  if self._callback ~= nil then
    self._callback(self._pointCfg.level)
  end
end

return UINMiniGameTaskActiveItem
