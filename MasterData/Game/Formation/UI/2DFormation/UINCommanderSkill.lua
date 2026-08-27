local UINCommanderSkill = class("UINCommanderSkill", UIBaseNode)
local base = UIBaseNode
local CSTUtil = require("Game.CommanderSkill.CSTUtil")

function UINCommanderSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCommanderSkill:InitCommanderSkill(skillId, resloader)
  local iconName = CSTUtil.GetCSTSkillIconById(skillId)
  if resloader ~= nil and iconName ~= nil then
    resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_SkillIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, iconName)
    end)
  end
end

function UINCommanderSkill:OnDelete()
  base.OnDelete(self)
end

return UINCommanderSkill
