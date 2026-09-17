local this = class("soulessenceTpl")

function this:init(config)
  self.data = config
  self.hasStoryIDList = {}
  self.handbooksoulessences = {}
  for key, value in pairs(self.data) do
    if math.isEmpty(value.story) == false then
      table.insert(self.hasStoryIDList, value.id)
    end
    if value.handbooksoulessence == 1 then
      table.insert(self.handbooksoulessences, value.id)
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getAttribute(tpl)
  return tpl.attribute
end

function this:getReishiSkill(tpl)
  return tpl.reishiSkill
end

function this:getId(tpl)
  return tpl.id
end

function this:getReishiExp(tpl)
  return tpl.reishiExp
end

function this:getValidProfession(tpl)
  return tpl.validProfession
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getUIPath(tpl)
  return tpl.uiPath
end

function this:getSpinePath(tpl)
  return tpl.resourcePath
end

function this:getCgPath(tpl)
  return tpl.cgPath
end

function this:getVideo(tpl)
  return tpl.video
end

function this:getVideoSound(tpl)
  return tpl.videoSound
end

function this:getStartAnimation(tpl)
  return tpl.startAnimation
end

function this:getAnimationSound(tpl)
  return tpl.animationSound
end

function this:getAnimationBgm(tpl)
  return tpl.animationBgm
end

function this:getAvatarTexture(tpl, index)
  if tpl == nil or tpl.icon == nil then
    return "UI/Atlas/Item/tex_icon_soulessences_default.png"
  end
  local icon = tpl.icon[index]
  if string.isEmpty(icon) then
    return "UI/Atlas/Item/tex_icon_soulessences_default.png"
  end
  return icon
end

function this:getProperty(id, level, rank)
  local soulessenceRankTpl = L_GameTpl:getSoulessenceRankTpl()
  local rankData = soulessenceRankTpl:getChildren(id)
  if rankData == nil or rankData[rank] == nil then
    return {}
  end
  local rankUpAttribute = rankData[rank].rankUpAttributeAll
  local soulEssenceAttribute = self:getAttribute(self:getTplById(id))
  if soulEssenceAttribute then
    local soulessenceValueTpl = L_GameTpl:getSoulessenceValueTpl()
    local property = soulessenceValueTpl:getBaseAttribute(soulessenceValueTpl:getTplById(soulEssenceAttribute * 1000 + level))
    local tab = {}
    for i, v in pairs(property) do
      tab[i] = v
    end
    if not table.isEmpty(rankUpAttribute) then
      tab = self:add(tab, rankUpAttribute)
    end
    local proList = {}
    for k, v in pairs(tab) do
      proList[k] = math.floor(v)
    end
    return proList
  end
  return {}
end

function this:getSkill(id, star)
  local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
  local skillId = self:getSkillId(id)
  if skillId then
    local tpl = skillLevelTpl:getTplByIdAndLevel(skillId, star)
    local skill = skillLevelTpl:getSkillDescribe(tpl) or ""
    local valueList = skillLevelTpl:getValue(tpl) or {}
    return skill, valueList
  end
  return "", {}
end

function this:getSkillId(id)
  local reishiSkill = self:getReishiSkill(self:getTplById(id))
  return reishiSkill
end

function this:add(myTable, otherTable)
  for i, v in pairs(otherTable) do
    if myTable[i] then
      myTable[i] = v + myTable[i]
    else
      myTable[i] = v
    end
  end
  return myTable
end

function this:getTask(tpl)
  return tpl.task
end

function this:getStory(tpl)
  return tpl.story
end

function this:getStoryLock(tpl)
  return tpl.storyLock
end

function this:getHasStoryIDList()
  return self.hasStoryIDList
end

function this:isValid(configId)
  return self:getTplById(configId).isValid == 1
end

function this:getTimetag(tpl)
  return tpl.timetag
end

function this:getHandbooksoulessence(tpl)
  return tpl.handbooksoulessence
end

function this:getHandbooksoulessences()
  return self.handbooksoulessences
end

function this:getUnlockHandBookSoulessenceNum()
  local handbooksoulessences = self:getHandbooksoulessences()
  local currNum = 0
  local _soulEssenceMgr = C_SoulEssenceMgr
  for _, id in ipairs(handbooksoulessences) do
    if _soulEssenceMgr:getHasSoulEssence(id) then
      currNum = currNum + 1
    end
  end
  return currNum, #handbooksoulessences
end

return this
