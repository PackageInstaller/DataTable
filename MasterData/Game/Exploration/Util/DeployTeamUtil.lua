local DeployTeamUtil = {}
local autoDeployListPool = CommonPool.New(function()
  return {}
end, function(p)
  table.removeall(p)
  return true
end)
local banchPosArray = {
  1,
  3,
  2,
  0,
  4
}
DeployTeamUtil.banchPosArray = banchPosArray

function DeployTeamUtil.FinalDeployRole(defendRoles, longRangeRoles, benchRoles, deployDic, mapDeployX, mapSizeY, benchX)
  if 0 < #defendRoles then
    for x = mapDeployX - 1, 0, -1 do
      for y = 0, mapSizeY - 1 do
        if #defendRoles == 0 then
          break
        end
        local coord = x << 16 | y
        if not deployDic[coord] then
          deployDic[coord] = true
          local role = table.remove(defendRoles)
          role:SetCoordXY(x, y, benchX)
        end
      end
    end
  end
  if 0 < #longRangeRoles then
    for x = 0, mapDeployX - 1 do
      for y = 0, mapSizeY - 1 do
        if #longRangeRoles == 0 then
          break
        end
        local coord = x << 16 | y
        if not deployDic[coord] then
          deployDic[coord] = true
          local role = table.remove(longRangeRoles)
          role:SetCoordXY(x, y, benchX)
        end
      end
    end
  end
  DeployTeamUtil._DeloyBenchHero(benchRoles, benchX)
end

function DeployTeamUtil._DeloyBenchHero(benchRoles, benchX)
  local index = 1
  for k, role in pairs(benchRoles) do
    local benchy = banchPosArray[index]
    if benchy ~= nil then
      role:SetCoordXY(benchX, benchy, benchX)
      index = index + 1
    end
  end
end

function DeployTeamUtil.DeployHeroTeam(heroList, size_row, size_col, deploy_rows, lastDeployDic)
  local benchX = ConfigData.buildinConfig.BenchX
  local longRangeRoles = autoDeployListPool:PoolGet()
  local defendRoles = autoDeployListPool:PoolGet()
  local benchRoles = autoDeployListPool:PoolGet()
  local deployDic = {}
  lastDeployDic = lastDeployDic or {}
  for k, heroData in pairs(heroList) do
    if heroData.onBench then
      table.insert(benchRoles, heroData)
    elseif lastDeployDic[heroData.dataId] ~= nil then
      local coord = lastDeployDic[heroData.dataId]
      local x, y = BattleUtil.Pos2XYCoord(coord)
      heroData:SetCoordXY(x, y, benchX)
      deployDic[coord] = true
    elseif heroData.attackRange <= 1 then
      table.insert(defendRoles, heroData)
    else
      table.insert(longRangeRoles, heroData)
    end
  end
  local mapDeployX = deploy_rows
  local mapSizeY = size_col
  local totalHeroCount = #heroList
  local defendRoleCount = #defendRoles
  local longRangeRoleCount = #longRangeRoles
  if 3 < defendRoleCount or 3 < longRangeRoleCount then
    DeployTeamUtil.FinalDeployRole(defendRoles, longRangeRoles, benchRoles, deployDic, mapDeployX, mapSizeY, benchX)
    autoDeployListPool:PoolPut(longRangeRoles)
    autoDeployListPool:PoolPut(defendRoles)
    autoDeployListPool:PoolPut(benchRoles)
    return
  end
  if 0 < defendRoleCount then
    local curRow = mapDeployX - 1
    if totalHeroCount <= defendRoleCount then
      curRow = 0
    end
    if 2 < defendRoleCount then
      for c = mapSizeY - 1, 0, -1 do
        if c % 2 == 0 then
          if #defendRoles == 0 then
            break
          end
          local coord = curRow << 16 | c
          if not deployDic[coord] then
            deployDic[coord] = true
            local role = table.remove(defendRoles)
            role:SetCoordXY(curRow, c, benchX)
          end
        end
      end
    elseif defendRoleCount == 2 then
      if totalHeroCount - defendRoleCount == 3 then
        local role = table.remove(defendRoles)
        role:SetCoordXY(1, 0, benchX)
        role = table.remove(defendRoles)
        role:SetCoordXY(1, 4, benchX)
      else
        for c = mapSizeY - 1, 0, -1 do
          if c % 2 == 1 then
            if #defendRoles == 0 then
              break
            end
            local coord = curRow << 16 | c
            if not deployDic[coord] then
              deployDic[coord] = true
              local role = table.remove(defendRoles)
              role:SetCoordXY(curRow, c, benchX)
            end
          end
        end
      end
    elseif defendRoleCount == 1 then
      local curCow = (mapSizeY - 1) // 2
      local coord = curRow << 16 | curCow
      if not deployDic[coord] then
        deployDic[coord] = true
        local role = table.remove(defendRoles)
        role:SetCoordXY(curRow, curCow, benchX)
      end
    end
  end
  if 0 < longRangeRoleCount then
    local curRow = 0
    if 5 <= longRangeRoleCount then
      for c = mapSizeY - 1, 0, -1 do
        if #longRangeRoles == 0 then
          break
        end
        local coord = curRow << 16 | c
        if not deployDic[coord] then
          deployDic[coord] = true
          local role = table.remove(longRangeRoles)
          role:SetCoordXY(curRow, c, benchX)
        end
      end
    elseif longRangeRoleCount == 4 then
      for c = 0, 1 do
        if #longRangeRoles == 0 then
          break
        end
        local coord = curRow << 16 | c
        if not deployDic[coord] then
          deployDic[coord] = true
          local role = table.remove(longRangeRoles)
          role:SetCoordXY(curRow, c, benchX)
        end
      end
      for c = mapSizeY - 1, 3, -1 do
        if #longRangeRoles == 0 then
          break
        end
        local coord = curRow << 16 | c
        if not deployDic[coord] then
          deployDic[coord] = true
          local role = table.remove(longRangeRoles)
          role:SetCoordXY(curRow, c, benchX)
        end
      end
    elseif longRangeRoleCount == 3 then
      for c = mapSizeY - 1, 0, -1 do
        if c % 2 == 0 then
          if #longRangeRoles == 0 then
            break
          end
          local coord = curRow << 16 | c
          if not deployDic[coord] then
            deployDic[coord] = true
            local role = table.remove(longRangeRoles)
            role:SetCoordXY(curRow, c, benchX)
          end
        end
      end
    elseif longRangeRoleCount == 2 then
      if 0 < defendRoleCount then
        if 0 < #longRangeRoles then
          local coord = curRow << 16 | 0
          if not deployDic[coord] then
            deployDic[coord] = true
            local role = table.remove(longRangeRoles)
            role:SetCoordXY(curRow, 0, benchX)
          end
        end
        if 0 < #longRangeRoles then
          local coord = curRow << 16 | mapSizeY - 1
          if not deployDic[coord] then
            deployDic[coord] = true
            local role = table.remove(longRangeRoles)
            role:SetCoordXY(curRow, mapSizeY - 1, benchX)
          end
        end
      else
        for c = mapSizeY - 1, 0, -1 do
          if c % 2 == 1 then
            if #longRangeRoles == 0 then
              break
            end
            local coord = curRow << 16 | c
            if not deployDic[coord] then
              deployDic[coord] = true
              local role = table.remove(longRangeRoles)
              role:SetCoordXY(curRow, c, benchX)
            end
          end
        end
      end
    elseif longRangeRoleCount == 1 and 0 < #longRangeRoles then
      local curCow = (mapSizeY - 1) // 2
      local coord = curRow << 16 | curCow
      if not deployDic[coord] then
        deployDic[coord] = true
        local role = table.remove(longRangeRoles)
        role:SetCoordXY(curRow, curCow, benchX)
      end
    end
  end
  DeployTeamUtil.FinalDeployRole(defendRoles, longRangeRoles, benchRoles, deployDic, mapDeployX, mapSizeY, benchX)
  autoDeployListPool:PoolPut(longRangeRoles)
  autoDeployListPool:PoolPut(defendRoles)
  autoDeployListPool:PoolPut(benchRoles)
end

function DeployTeamUtil.AutoBattleDeploy(roomData, heroList, size_row, size_col, deploy_rows, deployStage)
  local benchX = ConfigData.buildinConfig.BenchX
  local needSpecilDeploy = DeployTeamUtil._NeedBattleSpecilDeploy(roomData, deployStage, heroList, benchX)
  if roomData == nil or roomData.effectGridList == nil or #roomData.effectGridList == 0 then
    if needSpecilDeploy then
      DeployTeamUtil.BattleSpecilDeploy(roomData, heroList, benchX, nil, nil)
    end
    return
  end
  local benchRoles = autoDeployListPool:PoolGet()
  local stageRoles = autoDeployListPool:PoolGet()
  local roleAttrDics = {}
  local succCoordDic = {}
  for coord, v in pairs(roomData.occupyCoords) do
    succCoordDic[coord] = true
  end
  for _, dynHero in pairs(heroList) do
    if dynHero.onBench then
      table.insert(benchRoles, dynHero)
    elseif deployStage or needSpecilDeploy then
      table.insert(stageRoles, dynHero)
    end
    local attrDic = dynHero:GetDynBattleRoleAttrDic()
    roleAttrDics[dynHero.dataId] = attrDic
  end
  if #benchRoles == 0 and #stageRoles == 0 then
    autoDeployListPool:PoolPut(benchRoles)
    autoDeployListPool:PoolPut(stageRoles)
    return
  end
  if needSpecilDeploy then
    DeployTeamUtil.__DeployEffectGridStage(roomData, benchX, deploy_rows, benchRoles, stageRoles, succCoordDic, roleAttrDics)
    local undeployRoleList = autoDeployListPool:PoolGet()
    for k, dynHero in pairs(stageRoles) do
      local curHero = succCoordDic[dynHero.coord]
      if curHero == nil or curHero ~= dynHero then
        table.insert(undeployRoleList, dynHero)
      end
    end
    DeployTeamUtil.BattleSpecilDeploy(roomData, undeployRoleList, benchX, succCoordDic, benchRoles)
    DeployTeamUtil._DeployEffectGridBench(roomData, benchX, benchRoles, roleAttrDics, succCoordDic)
    DeployTeamUtil._DealBenchConflict(benchRoles, succCoordDic, benchX)
    autoDeployListPool:PoolPut(undeployRoleList)
  else
    DeployTeamUtil._DeployEffectGridBench(roomData, benchX, benchRoles, roleAttrDics, succCoordDic)
    DeployTeamUtil.__DeployEffectGridStage(roomData, benchX, deploy_rows, benchRoles, stageRoles, succCoordDic, roleAttrDics)
    DeployTeamUtil._DealBenchConflict(benchRoles, succCoordDic, benchX)
    if deployStage then
      local defendRoles = autoDeployListPool:PoolGet()
      local longRangeRoles = autoDeployListPool:PoolGet()
      for k, dynHero in pairs(stageRoles) do
        local curHero = succCoordDic[dynHero.coord]
        if curHero == nil then
          succCoordDic[dynHero.coord] = dynHero
        elseif curHero ~= dynHero then
          if dynHero.attackRange <= 1 then
            table.insert(defendRoles, dynHero)
          else
            table.insert(longRangeRoles, dynHero)
          end
        end
      end
      DeployTeamUtil:_DefaultDeploy(deploy_rows, size_col, defendRoles, longRangeRoles, succCoordDic, benchX)
      autoDeployListPool:PoolPut(longRangeRoles)
      autoDeployListPool:PoolPut(defendRoles)
    end
  end
  autoDeployListPool:PoolPut(benchRoles)
  autoDeployListPool:PoolPut(stageRoles)
end

function DeployTeamUtil.__DeployEffectGridStage(roomData, benchX, deploy_rows, benchRoles, stageRoles, succCoordDic, roleAttrDics)
  for _, dynGrid in pairs(roomData.effectGridList) do
    local roles
    if dynGrid.x == benchX then
      roles = benchRoles
    elseif not (deploy_rows <= dynGrid.x) then
      roles = stageRoles
      if #roles ~= 0 and succCoordDic[dynGrid.coord] == nil then
        local auto_career = dynGrid:GetGridAutoCareer()
        local validRoles = autoDeployListPool:PoolGet()
        local maxCareerKey = -1
        for _, dynHero in pairs(roles) do
          local careerKey = auto_career[dynHero:GetCareer()] or auto_career[0]
          if careerKey ~= nil and maxCareerKey <= careerKey and dynGrid:GetGridNecessaryFormulaValue(roleAttrDics[dynHero.dataId]) then
            if maxCareerKey < careerKey then
              maxCareerKey = careerKey
            end
            table.insert(validRoles, dynHero)
          end
        end
        if #validRoles == 0 then
          autoDeployListPool:PoolPut(validRoles)
        else
          local bestRole
          if 1 < #validRoles then
            if dynGrid:GetAutoIsMax() then
              local bestValue = CommonUtil.Int64Min
              for _, dynHero in pairs(validRoles) do
                local careerKey = auto_career[dynHero:GetCareer()] or auto_career[0]
                if maxCareerKey <= careerKey then
                  local value = dynGrid:GetGridAttrFormulaValue(roleAttrDics[dynHero.dataId])
                  if bestValue < value then
                    bestValue = value
                    bestRole = dynHero
                  end
                end
              end
            else
              local bestValue = CommonUtil.Int64Max
              for _, dynHero in pairs(validRoles) do
                local careerKey = auto_career[dynHero:GetCareer()] or auto_career[0]
                if maxCareerKey <= careerKey then
                  local value = dynGrid:GetGridAttrFormulaValue(roleAttrDics[dynHero.dataId])
                  if bestValue > value then
                    bestValue = value
                    bestRole = dynHero
                  end
                end
              end
            end
          else
            bestRole = validRoles[1]
          end
          if bestRole == nil then
            error("DeployTeamUtil.AutoBattleDeploy get bestRole is null!")
            autoDeployListPool:PoolPut(validRoles)
          else
            for index, dynHero in pairs(roles) do
              if dynHero == bestRole then
                table.remove(roles, index)
                break
              end
            end
            bestRole:SetCoord(dynGrid.coord, benchX)
            succCoordDic[dynGrid.coord] = bestRole
            autoDeployListPool:PoolPut(validRoles)
          end
        end
      end
    end
  end
end

function DeployTeamUtil._DeployEffectGridBench(roomData, benchX, roles, roleAttrDics, succCoordDic)
  for _, dynGrid in pairs(roomData.effectGridList) do
    if dynGrid.x == benchX then
      local validRoles = autoDeployListPool:PoolGet()
      local career = dynGrid:GetGridCareerPriority()
      for _, dynHero in pairs(roles) do
        if career == dynHero:GetCareer() and dynGrid:GetGridNecessaryFormulaValue(roleAttrDics[dynHero.dataId]) then
          table.insert(validRoles, dynHero)
        end
      end
      if #validRoles == 0 then
        autoDeployListPool:PoolPut(validRoles)
      else
        local bestRole
        if 1 < #validRoles then
          if dynGrid:GetAutoIsMax() then
            local bestValue = CommonUtil.Int64Min
            for _, dynHero in pairs(validRoles) do
              local value = dynGrid:GetGridAttrFormulaValue(roleAttrDics[dynHero.dataId])
              if bestValue < value then
                bestValue = value
                bestRole = dynHero
              end
            end
          else
            local bestValue = CommonUtil.Int64Max
            for _, dynHero in pairs(validRoles) do
              local value = dynGrid:GetGridAttrFormulaValue(roleAttrDics[dynHero.dataId])
              if bestValue > value then
                bestValue = value
                bestRole = dynHero
              end
            end
          end
        else
          bestRole = validRoles[1]
        end
        if bestRole == nil then
          error("DeployTeamUtil.AutoBattleDeploy get bestRole is null!")
          autoDeployListPool:PoolPut(validRoles)
        else
          for index, dynHero in pairs(roles) do
            if dynHero == bestRole then
              table.remove(roles, index)
              break
            end
          end
          bestRole:SetCoord(dynGrid.coord, benchX)
          succCoordDic[dynGrid.coord] = bestRole
          autoDeployListPool:PoolPut(validRoles)
        end
      end
    end
  end
end

function DeployTeamUtil._DealBenchConflict(benchRoles, succCoordDic, benchX)
  local conflictRoles = autoDeployListPool:PoolGet()
  for k, dynHero in pairs(benchRoles) do
    local curHero = succCoordDic[dynHero.coord]
    if curHero == nil then
      succCoordDic[dynHero.coord] = dynHero
    elseif curHero ~= dynHero then
      table.insert(conflictRoles, dynHero)
    end
  end
  local index = 1
  for k, role in pairs(conflictRoles) do
    local coord
    repeat
      coord = BattleUtil.XYCoord2Pos(benchX, banchPosArray[index])
      index = index + 1
    until succCoordDic[coord] == nil
    role:SetCoord(coord, benchX)
  end
  autoDeployListPool:PoolPut(conflictRoles)
end

function DeployTeamUtil:_DefaultDeploy(deploy_rows, size_col, defendRoles, longRangeRoles, succCoordDic, benchX)
  local mapDeployX = deploy_rows
  local mapSizeY = size_col
  if defendRoles and 0 < #defendRoles then
    for x = mapDeployX - 1, 0, -1 do
      for y = 0, mapSizeY - 1 do
        if #defendRoles == 0 then
          break
        end
        local coord = BattleUtil.XYCoord2Pos(x, y)
        if succCoordDic[coord] == nil then
          local role = table.remove(defendRoles)
          succCoordDic[coord] = role
          role:SetCoordXY(x, y, benchX)
        end
      end
    end
  end
  if longRangeRoles and 0 < #longRangeRoles then
    for x = 0, mapDeployX - 1 do
      for y = 0, mapSizeY - 1 do
        if #longRangeRoles == 0 then
          break
        end
        local coord = BattleUtil.XYCoord2Pos(x, y)
        if succCoordDic[coord] == nil then
          local role = table.remove(longRangeRoles)
          succCoordDic[coord] = role
          role:SetCoordXY(x, y, benchX)
        end
      end
    end
  end
end

function DeployTeamUtil._NeedBattleSpecilDeploy(roomData, deployStage, heroList, benchX)
  if roomData ~= nil and roomData.roomSpecialDeployCfg ~= nil and (deployStage or roomData.reSpecialDeploy) then
    return true
  end
  return false
end

local careerSortList = {
  1,
  3,
  4,
  2,
  5
}

function DeployTeamUtil.BattleSpecilDeploy(roomData, deployHeroList, benchX, succCoordDic, externalBenchRoles)
  local deployGridWeightDic = {}
  local deployGridList = autoDeployListPool:PoolGet()
  for x, tab in pairs(roomData.roomSpecialDeployCfg.deployGridDic) do
    for y, _ in pairs(tab) do
      local coord = BattleUtil.XYCoord2Pos(x, y)
      deployGridWeightDic[coord] = 0
      if succCoordDic == nil or succCoordDic[coord] == nil then
        table.insert(deployGridList, coord)
      end
    end
  end
  for k, dynMonster in ipairs(roomData.monsterList) do
    if dynMonster.cat == BattleUtil.battleRoleCat.monster and not dynMonster:IsStageMonster() then
      local coord = BattleUtil.XYCoord2Pos(dynMonster.targetDeployPosX, dynMonster.targetDeployPosY)
      if deployGridWeightDic[coord] == nil then
        error("monster's target delpoy pos is nil, monsterId:" .. tostring(dynMonster.dataId))
      else
        deployGridWeightDic[coord] = deployGridWeightDic[coord] + 1
      end
    end
  end
  table.sort(deployGridList, function(a, b)
    if deployGridWeightDic[a] ~= deployGridWeightDic[b] then
      return deployGridWeightDic[a] > deployGridWeightDic[b]
    end
    return a < b
  end)
  local benchRoles
  if externalBenchRoles == nil then
    benchRoles = autoDeployListPool:PoolGet()
  end
  local careerHeroDic = {}
  for k, dynHero in ipairs(deployHeroList) do
    if dynHero.onBench then
      if externalBenchRoles == nil then
        table.insert(benchRoles, dynHero)
      else
        table.insert(externalBenchRoles, dynHero)
      end
    else
      local career = dynHero:GetCareer()
      careerHeroDic[career] = careerHeroDic[career] or autoDeployListPool:PoolGet()
      table.insert(careerHeroDic[career], dynHero)
    end
  end
  for k, career in ipairs(careerSortList) do
    local heroList = careerHeroDic[career]
    if heroList ~= nil then
      for k2, dynHero in ipairs(heroList) do
        if #deployGridList == 0 then
          if externalBenchRoles == nil then
            table.insert(benchRoles, dynHero)
          else
            table.insert(externalBenchRoles, dynHero)
          end
        else
          local coord = table.remove(deployGridList, 1)
          local x, y = BattleUtil.Pos2XYCoord(coord)
          dynHero:SetCoordXY(x, y, benchX)
          if succCoordDic then
            succCoordDic[coord] = dynHero
          end
        end
      end
    end
  end
  if externalBenchRoles == nil then
    if #benchRoles > #banchPosArray then
      error("bench hero num above bench num!!! pls check map config")
    end
    DeployTeamUtil._DeloyBenchHero(benchRoles, benchX)
    autoDeployListPool:PoolPut(benchRoles)
  end
  for k, list in pairs(careerHeroDic) do
    autoDeployListPool:PoolPut(list)
  end
  autoDeployListPool:PoolPut(deployGridList)
end

return DeployTeamUtil
