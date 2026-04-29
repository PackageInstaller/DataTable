require("scope_base")
_class("SkillScopeCalculator_BuffLayerMostAndHighestHPAndNearest", SkillScopeCalculator_Base)
SkillScopeCalculator_BuffLayerMostAndHighestHPAndNearest = SkillScopeCalculator_BuffLayerMostAndHighestHPAndNearest

function SkillScopeCalculator_BuffLayerMostAndHighestHPAndNearest:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local targetBuffEffect = scopeParam[1]
  local world = self._hub._gridFilter._world
  local targetEntityList = {}
  local es = {}
  local monsters = world:GetGroupEntities(world.BW_WEMatchers.AliveMonster)
  for _, monster in ipairs(monsters) do
    local buffComponent = monster:BuffComponent()
    if buffComponent and buffComponent:HasBuffEffect(targetBuffEffect) then
      table.insert(es, monster)
    end
  end
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  if table.count(es) > 0 then
    local buffLogicService = world:GetService("BuffLogic")
    table.sort(es, function(a, b)
      local buffLayerA = buffLogicService:GetBuffLayer(a, targetBuffEffect)
      local buffLayerB = buffLogicService:GetBuffLayer(b, targetBuffEffect)
      if buffLayerA == buffLayerB then
        local hpA = a:Attributes():GetCurrentHP()
        local hpB = b:Attributes():GetCurrentHP()
        return hpA > hpB
      end
      return buffLayerA > buffLayerB
    end)
    local mostBuffLayer = 0
    local randomEntityList = {}
    for i, e in ipairs(es) do
      local curBuffLayer = buffLogicService:GetBuffLayer(e, targetBuffEffect)
      if i == 1 then
        if curBuffLayer == 0 then
          break
        end
        mostBuffLayer = curBuffLayer
      end
      if mostBuffLayer == curBuffLayer then
        table.insert(targetEntityList, e)
      end
    end
    if table.count(targetEntityList) == 1 then
    else
      do
        local mostHP = 0
        for i, e in ipairs(es) do
          local curHP = e:Attributes():GetCurrentHP()
          if i == 1 then
            mostHP = curHP
          end
          if mostHP == curHP then
            table.insert(randomEntityList, e)
          end
        end
        table.sort(randomEntityList, function(a, b)
          local distanceA = Vector2.Distance(a:GetGridPosition(), centerPos)
          local distanceB = Vector2.Distance(b:GetGridPosition(), centerPos)
          return distanceA < distanceB
        end)
        targetEntityList = {}
        table.insert(targetEntityList, randomEntityList[1])
      end
    end
  end
  if table.count(targetEntityList) == 0 then
    table.sort(monsters, function(a, b)
      local distanceA = Vector2.Distance(a:GetGridPosition(), centerPos)
      local distanceB = Vector2.Distance(b:GetGridPosition(), centerPos)
      return distanceA < distanceB
    end)
    table.insert(targetEntityList, monsters[1])
  end
  local scopeList = {}
  for _, targetEntity in ipairs(targetEntityList) do
    local targetGridPos = targetEntity:GridLocation():GetGridPos()
    local targetBodyArea = targetEntity:BodyArea():GetArea()
    for i, area in ipairs(targetBodyArea) do
      local posWork = targetGridPos + area
      table.insert(scopeList, posWork)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.BuffLayerMostAndHighestHPAndNearest, casterPos, scopeList, scopeList)
  return result
end
