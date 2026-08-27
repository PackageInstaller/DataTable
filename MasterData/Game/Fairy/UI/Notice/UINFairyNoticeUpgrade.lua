local UINFairyNoticeUpgrade = class("UINFairyNoticeUpgrade", UIBaseNode)
local base = UIBaseNode
local UINFairyNoticeSkillItem = require("Game.Fairy.UI.Notice.UINFairyNoticeSkillItem")
local UINCommonStars = require("Game.Fairy.UI.UINCommonStars")

function UINFairyNoticeUpgrade:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.noticeSkillItemPool = UIItemPool.New(UINFairyNoticeSkillItem, self.ui.noticeSkillItem, false)
  self.commonStars = UINCommonStars.New()
  self.commonStars:Init(self.ui.stars)
end

function UINFairyNoticeUpgrade:InitFairyNoticeUpgrade(fairyData, resloader)
  self.resloader = resloader
  self.fairyData = fairyData
  self.commonStars:RefreshStarsByNum(fairyData:GetFairyCurStar())
  self.ui.tex_CurLimit.text = tostring(fairyData:GetFairyCurLevel())
  self.ui.tex_NextLimit:SetIndex(0, tostring(fairyData:GetCurStarMaxLevel()))
  local nowSkillNum = fairyData:GetMaxSkillNum()
  local lastSkillNum = fairyData:GetLastMaxSkillNum()
  for i = 1, lastSkillNum do
    local item = self.noticeSkillItemPool:GetOne(true)
    item:InitFairyNoticeSkillItem(fairyData:GetFairySkillBySlotIndex(i), false, self.resloader)
  end
  for i = lastSkillNum + 1, nowSkillNum do
    local item = self.noticeSkillItemPool:GetOne(true)
    item:InitFairyNoticeSkillItem(fairyData:GetFairySkillBySlotIndex(i), true, self.resloader)
  end
end

function UINFairyNoticeUpgrade:OnDelete()
  self.noticeSkillItemPool:DeleteAll()
end

return UINFairyNoticeUpgrade
