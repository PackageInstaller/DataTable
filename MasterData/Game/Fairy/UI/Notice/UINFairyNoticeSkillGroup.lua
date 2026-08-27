local UINFairyNoticeSkillGroup = class("UINFairyNoticeSkillReset", UIBaseNode)
local base = UIBaseNode
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local cs_Ease = CS.DG.Tweening.Ease
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local FairyHelper = require("Game.Fairy.FairyHelper")

function UINFairyNoticeSkillGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItemPool = UIItemPool.New(UINFairySkillUpgradeItem, self.ui.uINFairySkillCard, false)
  self.isBelow = false
end

function UINFairyNoticeSkillGroup:InitFairyNoticeSkillGroup(fairyData, resloader, isPreview, isResetSkill, startStar)
  self.resloader = resloader
  self.fairyData = fairyData
  self.isPreview = isPreview
  self.isResetSkill = isResetSkill
  self._startStar = startStar
  self:RefreshSkillItemList()
  self:RefreshSkillTitle()
end

function UINFairyNoticeSkillGroup:RefreshSkillTitle()
  if not self.isPreview then
    self.ui.tex_title:SetIndex(4)
    return
  end
  if self.skillList == nil then
    self.ui.tex_title:SetIndex(self.isResetSkill and 2 or 0)
  end
  local isUp = FairyHelper.IsSelectAllBetterSkills(self.orginSkillList, self.skillList)
  local index
  if isUp then
    if self.isResetSkill then
      index = 2
    else
      index = 0
    end
  else
    if self.isResetSkill then
      index = 3
    else
      index = 1
    end
    self.isBelow = true
  end
  self.ui.tex_title:SetIndex(index)
end

function UINFairyNoticeSkillGroup:SetSkillList(skillList, orginSkillList)
  self.skillList = skillList
  self.orginSkillList = orginSkillList
end

function UINFairyNoticeSkillGroup:RefreshSkillItemList()
  local nowSkillNum = not (self.isPreview or self.isResetSkill) and self.fairyData:GetLastMaxSkillNum() or self.fairyData:GetMaxSkillNum()
  if self._startStar ~= nil then
    nowSkillNum = self.fairyData:GetFyStarSkillNum(self._startStar)
  end
  local nextSkillNum = not self.isPreview and self.fairyData:GetMaxSkillNum() or self.fairyData:GetNextMaxSkillNum()
  for i = 1, nowSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    local skillData = self.skillList and self.skillList[i] or self.fairyData:GetFairySkillBySlotIndex(i)
    skillItem:InitFairySkillUpgradeItem(skillData, self.resloader)
  end
  if nowSkillNum < nextSkillNum then
    for i = nowSkillNum + 1, nextSkillNum do
      local skillItem = self.skillItemPool:GetOne(true)
      if self.isPreview then
        skillItem:InitFairySkillUpgradeItemEmpty(2)
      else
        skillItem:InitFairySkillUpgradeItem(self.fairyData:GetFairySkillBySlotIndex(nextSkillNum), self.resloader)
        if self._startStar == nil then
          skillItem:SetNewOpen()
        end
      end
    end
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
  for index, item in pairs(self.skillItemPool.listItem) do
    item.transform:DOLocalMoveY(-60, 0.75):From():SetLink(self.gameObject):SetEase(cs_Ease.OutExpo):SetDelay(0.1 + 0.05 * index)
    item.ui.canvas_FairySkillCard:DOFade(0, 0.75):From():SetLink(self.gameObject):SetEase(cs_Ease.OutExpo):SetDelay(0.1 + 0.05 * index)
  end
end

function UINFairyNoticeSkillGroup:OnDelete()
  self.skillItemPool:DeleteAll()
end

return UINFairyNoticeSkillGroup
