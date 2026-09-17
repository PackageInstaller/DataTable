local this = L_BevTree:registClass("guide.checkMainControlEntity", L_BevTree.action)

function this:param()
  self.useDefaultHero = 0
  self.heroId = ""
  self.isReverse = 0
  self.isQuickCheck = 0
end

function this:parse()
  self.useDefaultHero = self:getParam("useDefaultHero", true)
  self.heroId = self:getParam("heroId", true)
  local isReverse = self:getParam("isReverse", true) or 0
  self.isReverse = isReverse ~= 0
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:execute()
  local heroId
  if not math.isEmpty(self.useDefaultHero) then
    heroId = L_GameUtil.getDefaultHeroId()
  else
    heroId = self.heroId
  end
  local target = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local id = target.data.configId
  if self.isReverse and heroId ~= id then
    return L_BevTree.taskResult.Success
  end
  if not self.isReverse and heroId == id then
    return L_BevTree.taskResult.Success
  end
  if self.isQuickCheck then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Running
end

return this
