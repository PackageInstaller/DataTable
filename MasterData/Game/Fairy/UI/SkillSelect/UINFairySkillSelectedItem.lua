local UINFairySkillSelectedItem = class("UINFairySkillSelectedItem", UIBaseNode)
local base = UIBaseNode
local UINCommonStars = require("Game.Fairy.UI.UINCommonStars")
local UINFairySkillInfoBaseItem = require("Game.Fairy.UI.SkillSelect.UINFairySkillInfoBaseItem")
local UINFairyQualityItem = require("Game.Fairy.UI.UINFairyQualityItem")

function UINFairySkillSelectedItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.commonStars = UINCommonStars.New()
  self.commonStars:Init(self.ui.stars)
  self.skillInfoItemPool = UIItemPool.New(UINFairySkillInfoBaseItem, self.ui.skillItem, false)
  self.fairyQualityItem = UINFairyQualityItem.New()
  self.fairyQualityItem:Init(self.ui.uINFairyQualityItem)
end

function UINFairySkillSelectedItem:InitFairySkillSelectedItem(fairyData, resloader, checkSelectCallback, selectCallback, skillUpgradeNode)
  self.fairyData = fairyData
  self.resloader = resloader
  self.checkSelectCallback = checkSelectCallback
  self.selectCallback = selectCallback
  self.skillUpgradeNode = skillUpgradeNode
  self:RefreshFairyInfoUI()
  self:RefreshFairySkillList()
end

function UINFairySkillSelectedItem:RefreshFairyInfoUI()
  self.ui.tex_Lvl:SetIndex(0, tostring(self.fairyData:GetFairyCurLevel()))
  self.ui.tex_Name.text = self.fairyData:GetFairyCurName()
  self.fairyQualityItem:InitFairyQualityItem(self.fairyData:GetCurFairyQuality())
  local headIconName = self.fairyData:GetFairyHeadIconStr()
  self.ui.img_ElfPic.sprite = AtlasUtil.GetSpriteFromAtlas("FairySmallHeadIcon", headIconName, self.resloader)
  self.commonStars:RefreshStarsByNum(self.fairyData:GetFairyCurStar())
end

function UINFairySkillSelectedItem:RefreshFairySkillList()
  self.skillInfoItemPool:HideAll()
  local nowSkillNum = self.fairyData:GetMaxSkillNum()
  for i = 1, nowSkillNum do
    local item = self.skillInfoItemPool:GetOne(true)
    local skillData = self.fairyData:GetFairySkillBySlotIndex(i)
    local normalSelected = self.skillUpgradeNode:CheckAlreadyClick(skillData, self.fairyData)
    item:InitFairySkillInfoBaseItem(skillData, self.resloader, self.checkSelectCallback, self.selectCallback, normalSelected)
  end
end

function UINFairySkillSelectedItem:OnDelete()
  self.skillInfoItemPool:DeleteAll()
end

return UINFairySkillSelectedItem
