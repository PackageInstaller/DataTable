local UINCSTLvUpSkillItem = class("UINCSTLvUpSkillItem", UIBaseNode)
local base = UIBaseNode

function UINCSTLvUpSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCSTLvUpSkillItem:InitCSTLvUpSkillItem(resLoader, cmdSkillData, treeLevel, skillLevel)
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cmdSkillData:GetIcon())
    self.ui.img_Icon.enabled = true
  end)
  self.ui.tex_Name.text = cmdSkillData:GetName()
  if cmdSkillData.type == cmdSkillData.skillType.active then
    if cmdSkillData:IsCmdSkillUltimate() then
      self.ui.tex_Type:SetIndex(2)
      self.ui.img_TypeBg.color = self.ui.color_ultimate
    else
      self.ui.tex_Type:SetIndex(0)
      self.ui.img_TypeBg.color = self.ui.color_active
    end
  elseif cmdSkillData.type == cmdSkillData.skillType.passive then
    self.ui.tex_Type:SetIndex(1)
    self.ui.img_TypeBg.color = self.ui.color_passive
  end
  local unlockLevel = cmdSkillData.unlockLevelList[skillLevel]
  self.ui.obj_Lock:SetActive(treeLevel < unlockLevel)
  self.ui.tex_UnlockLevel:SetIndex(0, tostring(unlockLevel))
  local showAdv = cmdSkillData.type == cmdSkillData.skillType.active and 1 < skillLevel
  self.ui.obj_Level:SetActive(showAdv)
  if showAdv then
    self.ui.tex_Level:SetIndex(0, tostring(skillLevel))
    local iconName = cmdSkillData.levelIconList[skillLevel]
    self.ui.img_Level.enabled = false
    resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_Level.sprite = AtlasUtil.GetResldSprite(spriteAtlas, iconName)
      self.ui.img_Level.enabled = true
    end)
  end
  self.ui.tex_Desc.text = cmdSkillData:GetDescribe(1)
end

function UINCSTLvUpSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTLvUpSkillItem
