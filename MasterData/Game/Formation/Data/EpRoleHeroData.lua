local base = require("Game.PlayerData.Hero.HeroData")
local EpRoleHeroData = class("EpRoleHeroData", base)
local attrIdOffset = ConfigData.buildinConfig.AttrIdOffset

function EpRoleHeroData:ctor(data)
  self.isEpRoleHero = true
end

function EpRoleHeroData:SetEpRoleHeroData(heroElem)
  self.heroElem = heroElem
  self.originAttr = {}
  for i = 2, eHeroAttr.max_property_count + 1 do
    self.originAttr[i - 1] = heroElem.attr[i]
  end
  for skillId, skillLevel in pairs(heroElem.skillGroup) do
    local skillData = self.skillDic[skillId]
    if skillData == nil then
    else
      skillData:UpdateSkill(skillLevel)
    end
  end
end

function EpRoleHeroData:GetAttr(attrId, withoutAth, dontWarning, onlyBaseAttr, fairyData)
  return self.originAttr[attrId] or 0
end

function EpRoleHeroData:GetAthSlotInfo(index)
  return nil
end

function EpRoleHeroData:GetAthSuit()
  return table.emptytable
end

return EpRoleHeroData
