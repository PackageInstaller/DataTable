local this = L_BevTree:registClass("guide.changeMainControl", L_BevTree.action)

function this:param()
  self.useDefaultHero = 0
  self.heroId = ""
  self.freezeEnterSkill = 0
end

function this:parse()
  self.useDefaultHero = self:getParam("useDefaultHero", true)
  self.heroId = self:getParam("heroId", true)
  self.freezeEnterSkill = self:getParam("freezeEnterSkill", true)
  self.freezeLeaveSkill = self:getParam("freezeLeaveSkill", true)
end

function this:execute()
  local heroId
  if not math.isEmpty(self.useDefaultHero) then
    heroId = L_GameUtil.getDefaultHeroId()
  else
    heroId = self.heroId
  end
  if math.isEmpty(heroId) then
    errorf("新手引导changeMainControl节点未配置正确", 2)
    return L_BevTree.taskResult.Success
  end
  if self.result == L_BevTree.taskResult.Success then
    return self.result
  end
  self.result = L_BevTree.taskResult.Running
  local curForType = L_FormationManager:getCurFormationType()
  local posData = L_FormationStore:getFormationPosData(curForType)
  local heroGuid, index
  for i, guid in pairs(posData) do
    if not math.isEmpty(guid) then
      local hero = L_HeroStore:getHero(guid)
      if hero and L_HeroStore:getHeroConfigId(hero) == heroId then
        heroGuid = guid
        index = i
      end
    end
  end
  if index == AzurWorld.playerMgr.myPlayerData.formationMainControlIndex + 1 then
    self.result = L_BevTree.taskResult.Success
    return self.result
  end
  local freezeEnterSkill = not math.isEmpty(self.freezeEnterSkill) and self.freezeEnterSkill or 0
  if not math.isEmpty(index) then
    L_FormationManager:switchMyPlayerMainControl(index - 1, true, freezeEnterSkill ~= 0, false)
  end
  self.result = L_BevTree.taskResult.Success
  return self.result
end

return this
