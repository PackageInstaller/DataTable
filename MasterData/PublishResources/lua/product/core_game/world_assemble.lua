require("component_filter")
_staticClass("WorldAssembler")

function WorldAssembler.AssembleWorldComponentsBase(world)
  local game_mode = GameModeType.CommonBaseMode
  local running_position = world:GetRunningPosition()
  local gamemode_config = GameModeConfig[game_mode]
  if not gamemode_config then
    Log.debug("WorldAssembler.AssembleWorldComponents wrong game mode :", game_mode)
    return
  end
  for k, v in pairs(gamemode_config.UniqueComponents) do
    if not WorldAssembler["Init" .. k] then
      Log.fatal("AssembleWorldComponents " .. k .. " missing Init" .. k .. " func")
    elseif ComponentFilter:CheckComponent(k, running_position) then
      WorldAssembler["Init" .. k](world)
    end
  end
end

function WorldAssembler.AssembleWorldComponents(world, exConfig)
  local game_mode = world:GetGameMode()
  local running_position = world:GetRunningPosition()
  local gamemode_config = GameModeConfig[game_mode]
  if exConfig then
    gamemode_config = exConfig
  end
  if not gamemode_config then
    Log.debug("WorldAssembler.AssembleWorldComponents wrong game mode :", game_mode)
    return
  end
  for k, v in pairs(gamemode_config.UniqueComponents) do
    if not WorldAssembler["Init" .. k] then
      Log.fatal("AssembleWorldComponents " .. k .. " missing Init" .. k .. " func")
    elseif ComponentFilter:CheckComponent(k, running_position) then
      WorldAssembler["Init" .. k](world)
    end
  end
end

function WorldAssembler.InitInputMngComponent(world)
  world:AddInputMng()
end

function WorldAssembler.InitGameFSMComponent(world)
  world:AddGameFSM(world)
end

function WorldAssembler.InitMainCameraComponent(world)
  world:AddMainCamera(world)
end

function WorldAssembler.InitPlayerComponent(world)
  world:AddPlayer()
end

function WorldAssembler.InitInputComponent(world)
  world:AddInput(world)
end

function WorldAssembler.InitGridTouchComponent(world)
  world:AddGridTouch(world)
end

function WorldAssembler.InitSpawnMngComponent(world)
  world:AddSpawnMng(world)
end

function WorldAssembler.InitPickUpComponent(world)
  world:AddPickUp(world)
end

function WorldAssembler.InitBattleStatComponent(world)
  world:AddBattleStat(world)
end

function WorldAssembler.InitBattleRenderConfigComponent(world)
  world:AddBattleRenderConfig(world)
end

function WorldAssembler.InitBattleFlagsComponent(world)
  world:AddBattleFlags(world)
end

function WorldAssembler.InitRenderBattleStatComponent(world)
  world:AddRenderBattleStat(world)
end

function WorldAssembler.InitChessPickUpComponent(world)
  world:AddChessPickUp(world)
end

function WorldAssembler.InitMiragePickUpComponent(world)
  world:AddMiragePickUp(world)
end

function WorldAssembler.InitPopStarPickUpComponent(world)
  world:AddPopStarPickUp(world)
end

function WorldAssembler.InitBattleDamageStatisticsComponent(world)
  world:AddBattleDamageStatistics(world)
end

function WorldAssembler.InitBattleWorldEnterDataComponent(world)
  world:AddBattleWorldEnterData(world)
end

function WorldAssembler.InitSeasonMazeLogicComponent(world)
  world:AddSeasonMazeLogic(world)
end
