local base = require("Game.PlayerData.Hero.HeroData")
local FixedFmtHeroData = class("FixedFmtHeroData", base)
local attrIdOffset = ConfigData.buildinConfig.AttrIdOffset
local cs_GameData_ins = CS.GameData.instance

function FixedFmtHeroData.FixedFmtHeroData(heroId, assisLvCfg, skinId, heroName)
  local heroData = FixedFmtHeroData._GenHeroDataBase(FixedFmtHeroData, heroId, assisLvCfg)
  if skinId then
    heroData:UpdateSkin(skinId)
  end
  heroData:SetHeroOverrideName(heroName)
  heroData.isFixedFmtHero = true
  return heroData
end

function FixedFmtHeroData._GenHeroDataBase(classTab, heroId, assisLvCfg)
  local msgData = FixedFmtHeroData.__GetFakeMsgData(heroId, assisLvCfg)
  local heroData = classTab.New(msgData)
  local attrDic = DeepCopy(assisLvCfg.attrDic)
  heroData:_SetAttrDic(attrDic)
  heroData._assisLvCfg = assisLvCfg
  heroData.isRemoveAllBounce = true
  return heroData
end

function FixedFmtHeroData.__GetFakeMsgData(heroId, assisLvCfg)
  local msgData = {
    basic = {
      id = heroId,
      level = assisLvCfg.hero_level,
      exp = 0,
      star = assisLvCfg.hero_rank,
      potentialLvl = assisLvCfg.hero_potential,
      skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
    },
    skill = {
      data = {}
    }
  }
  local heroCfg = ConfigData.hero_data[heroId]
  for k, skillId in ipairs(heroCfg.skill_list) do
    msgData.skill.data[skillId] = assisLvCfg.hero_skill_level
    local skillCfg = ConfigData.hero_skill[skillId]
    if skillCfg.type ~= eHeroSkillType.LifeSkill then
      local battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(skillId)
      if battleSkillCfg == nil then
        error("battle_skill cfg is null,Id:" .. tostring(skillId))
      elseif battleSkillCfg:IsUltSkill() then
        msgData.skill.data[skillId] = ConfigData.hero_rank[msgData.basic.star].ultimateskill_level
      end
    end
  end
  if 0 < #assisLvCfg.spec_weapon_level then
    local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(heroId)
    if weaponId ~= nil then
      local step = assisLvCfg.spec_weapon_level[1]
      local level = assisLvCfg.spec_weapon_level[2]
      msgData.spWeapon = {
        {
          id = weaponId,
          step = step,
          level = level
        }
      }
      step = math.min(step, ConfigData.spec_weapon_step.stepDic[weaponId])
      local stepListCfg = ConfigData.spec_weapon_step[weaponId]
      local stepCfg = stepListCfg[step]
      if stepCfg ~= nil then
        for oriSkillId, newSkillId in pairs(stepCfg.replaceSkillDic) do
          msgData.skill.data[newSkillId] = msgData.skill.data[oriSkillId]
        end
      end
    end
  end
  return msgData
end

function FixedFmtHeroData:_SetAttrDic(attrDic)
  self.customeAttrDic = attrDic
end

function FixedFmtHeroData:__CalBaseAttr(attrId, withoutAth, athHeroId)
  local baseAttrId = attrId + attrIdOffset
  local customeAttr = self.customeAttrDic[baseAttrId] or 0
  if self._assisLvCfg.attribute_type == true then
    return customeAttr
  end
  local atrValue = base.__CalBaseAttr(self, attrId, withoutAth, athHeroId)
  return customeAttr + atrValue
end

function FixedFmtHeroData:__CalRatioAttr(atrValue, attrId, withoutAth, athHeroId, extrValue)
  local ratioAttrId = attrId + attrIdOffset * 2
  local customeAttr = self.customeAttrDic[ratioAttrId] or 0
  if self._assisLvCfg.attribute_type == true then
    return base.__CalRatioAttr(self, atrValue, attrId, withoutAth, athHeroId, extrValue, customeAttr)
  end
  extrValue = customeAttr + (extrValue or 0)
  return base.__CalRatioAttr(self, atrValue, attrId, withoutAth, athHeroId, extrValue)
end

function FixedFmtHeroData:__CalExtraAttr(atrValue, attrId, withoutAth, athHeroId)
  local customeAttr = self.customeAttrDic[attrId] or 0
  if self._assisLvCfg.attribute_type == true then
    return atrValue + customeAttr
  end
  return base.__CalExtraAttr(self, atrValue, attrId, withoutAth, athHeroId) + customeAttr
end

function FixedFmtHeroData:GetAthSlotList(isFull)
  return base.GetAthSlotList(self, isFull)
end

function FixedFmtHeroData:GetAthSlotInfo(index)
  return nil
end

function FixedFmtHeroData:GetAthSuit()
  return table.emptytable
end

return FixedFmtHeroData
