require("buff_logic_base")
_class("BuffLogicAddLayerByDamageOfTeamHp", BuffLogicBase)
BuffLogicAddLayerByDamageOfTeamHp = BuffLogicAddLayerByDamageOfTeamHp

function BuffLogicAddLayerByDamageOfTeamHp:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._mulValue = logicParam.mulValue or 1
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddLayerByDamageOfTeamHp:DoLogic(notify)
  if not notify.GetDamage then
    return
  end
  local damage = notify:GetDamage()
  if damage <= 0 then
    return
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local calcDamageService = self._world:GetService("CalcDamage")
  local curHp, maxHp = calcDamageService:GetTeamLogicHP(teamEntity)
  if self._world:MatchType() == MatchType.MT_Maze or self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local attrCmpt = self._entity:Attributes()
    maxHp = attrCmpt:CalcMaxHp()
    curHp = attrCmpt:GetCurrentHP()
  end
  local losePercent = damage / maxHp
  local addLayer = math.ceil(losePercent / self._mulValue) + self._addValue
  if addLayer == 0 then
    return
  end
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer, buffinst = svc:AddBuffLayer(self._entity, self._layerType, addLayer)
  local buffResult = BuffResultAddLayerByDamageOfTeamHp:New(curMarkLayer, buffinst:BuffSeq(), addLayer)
  return buffResult
end
