local UINCSTSkillFairyReplaceItem = class("UINCSTSkillFairyReplaceItem", UIBaseNode)
local base = UIBaseNode
local LineDefaultColor = Color.New(1, 1, 1, 0.2)
local LineEquipColor = Color.New(0.5882, 0.9882, 0.96, 1)

function UINCSTSkillFairyReplaceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCSTSkillFairyReplaceItem:RefreshCSTSkillFairyReplaceItem(treeData, fairyCSTSkillData, resLoader)
  self.fairyCSTSkillData = fairyCSTSkillData
  self.resLoader = resLoader
  local fairyData = treeData:GetFairy4CST()
  local headIconName = fairyData:GetFairyHeadIconStr()
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("FairySmallHeadIcon", headIconName, self.resLoader)
end

function UINCSTSkillFairyReplaceItem:SetCSTSkillItemEquipState(isEquip)
  self.ui.obj_equip:SetActive(isEquip)
  for k, imgLine in ipairs(self.ui.lineList) do
    imgLine.color = isEquip and LineEquipColor or LineDefaultColor
  end
end

function UINCSTSkillFairyReplaceItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillFairyReplaceItem
