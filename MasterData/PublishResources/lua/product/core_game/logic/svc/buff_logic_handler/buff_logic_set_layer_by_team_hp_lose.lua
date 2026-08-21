_class("BuffLogicSetLayerByTeamHpLose", BuffLogicBase)
BuffLogicSetLayerByTeamHpLose = BuffLogicSetLayerByTeamHpLose

function BuffLogicSetLayerByTeamHpLose:Constructor(buffInstance, logicParam)
  self._eachTeamHpLose = logicParam.eachTeamHpLose
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._entity = buffInstance._entity
end

function BuffLogicSetLayerByTeamHpLose:DoLogic()
  local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  local calcDamageService = self._world:GetService("CalcDamage")
  local curHp, maxHp = calcDamageService:GetTeamLogicHP(teamEntity)
  if self._world:MatchType() == MatchType.MT_Maze or self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local attrCmpt = self._entity:Attributes()
    maxHp = attrCmpt:CalcMaxHp()
    curHp = attrCmpt:GetCurrentHP()
  end
  local losePercent = 1 - curHp / maxHp
  local layerCount = math.floor(losePercent / self._eachTeamHpLose)
  local svc = self._world:GetService("BuffLogic")
  svc:SetBuffLayer(self._entity, self._layerType, layerCount)
  local buffResult = BuffResultAddLayer:New(layerCount)
  return buffResult
end
