local this = L_BevTree:registClass("guide.freezeSkillAction", L_BevTree.action)

function this:param()
  self.isFreeze = 0
  self.skillSlot = ""
  self.heroId = ""
end

function this:parse()
  self.isFreeze = self:getParam("isFreeze", true)
  self.skillSlot = self:getParam("skillSlot", true)
  self.heroId = self:getParam("heroId", true)
end

function this:execute()
  local heroId = self.heroId
  if math.isEmpty(heroId) then
    errorf("新手引导freezeSkillAction节点未配置正确", 2)
    return L_BevTree.taskResult.Success
  end
  if self.result == L_BevTree.taskResult.Success then
    return self.result
  end
  self.result = L_BevTree.taskResult.Running
  local curForType = L_FormationManager:getCurFormationType()
  local posData = L_FormationStore:getFormationPosData(curForType)
  local index, heroGuid
  for i, guid in pairs(posData) do
    if not math.isEmpty(guid) then
      local hero = L_HeroStore:getHero(guid)
      if hero and L_HeroStore:getHeroConfigId(hero) == heroId then
        index = i
        heroGuid = guid
      end
    end
  end
  local hero = C_EntityManager.GetAliveEntityByUUIDFast(heroGuid)
  if not hero then
    return L_BevTree.taskResult.Success
  end
  if hero == nil then
    return L_BevTree.taskResult.Success
  end
  local controlProperty = hero.data.controlProperty
  local isFreeze = not math.isEmpty(self.isFreeze) and self.isFreeze or 0
  controlProperty:SetFreezeSkillSlot(self.skillSlot, isFreeze == 0)
  self.result = L_BevTree.taskResult.Success
  return self.result
end

return this
