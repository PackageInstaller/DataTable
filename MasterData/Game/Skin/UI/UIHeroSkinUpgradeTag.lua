local UIHeroSkinUpgradeTag = class("UIHeroSkinUpgradeTag", UIBaseNode)
local base = UIBaseNode

function UIHeroSkinUpgradeTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIHeroSkinUpgradeTag:InitHeroSkinUpgradeTag(skinId)
  self.skinId = skinId
  self:OnTimerUpdate()
end

function UIHeroSkinUpgradeTag:UpdateTime(day, hour, minute)
  if minute < 0 then
    self.gameObject:SetActive(false)
    return
  end
  if 0 < day then
    self.ui.text_skinUpTime:SetIndex(0, tostring(day))
  elseif 0 < hour then
    self.ui.text_skinUpTime:SetIndex(1, tostring(hour))
  elseif 0 <= minute then
    self.ui.text_skinUpTime:SetIndex(2, tostring(minute))
  end
end

function UIHeroSkinUpgradeTag:OnTimerUpdate()
  local skinId = self.skinId
  if skinId == nil then
    return
  end
  local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinId)
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
  skinUpOpen = isInTimeRange and skinUpOpen
  self.gameObject:SetActive(skinUpOpen)
  local day, hour, minute = PlayerDataCenter.skinData:GetSkinUpgradeLimitTime(skinId)
  self:UpdateTime(day, hour, minute)
end

function UIHeroSkinUpgradeTag:OnDelete()
  self.skinId = nil
  self.clickCallBack = nil
end

return UIHeroSkinUpgradeTag
