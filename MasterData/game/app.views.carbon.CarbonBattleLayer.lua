local ChapterBattleCsv = require("csvdata.chapter_battle")
local BaseCarbonBattleLayer = game:loadView("carbon.BaseCarbonBattleLayer")
local CarbonBattleLayer = class("CarbonBattleLayer", BaseCarbonBattleLayer)

function CarbonBattleLayer:ctor(params)
  self.carbonData = ChapterBattleCsv[params.carbonId]
  self.modeType = params.modeType
  BaseCarbonBattleLayer.ctor(self, params)
end

function CarbonBattleLayer:getBattleData()
  return game.role.carbonBattle
end

function CarbonBattleLayer:getBattleInfo()
  return game.role.battleInfo
end

function CarbonBattleLayer:battleInfoCache(data, clear)
  if data then
    game.role.battleInfoCache = data
  end
  if clear then
    game.role.battleInfoCache = nil
  end
  return game.role.battleInfoCache
end

function CarbonBattleLayer:getActionCodes()
  return {
    modeType = self.modeType,
    battleType = BattleType.PvE,
    SelectRpc = actionCodes.Carbon_SelectRpc,
    arrangeCarbonRpc = actionCodes.Carbon_arrangeCarbonRpc,
    moveRpc = actionCodes.Carbon_moveRpc,
    actionEndRpc = actionCodes.Carbon_actionEndRpc,
    cancelMoveRpc = actionCodes.Carbon_cancelMoveRpc,
    endCarbonRpc = actionCodes.Carbon_endCarbonRpc,
    exitTeamRpc = actionCodes.Carbon_exitTeamRpc,
    supplyRpc = actionCodes.Carbon_supplyRpc,
    changePosRpc = actionCodes.Carbon_changePosRpc,
    treatHerosRpc = actionCodes.Carbon_treatHerosRpc
  }
end

function CarbonBattleLayer:showGuide()
  local carbon = game.role.carbons[self.carbonId]
  if carbon and carbon.score < 0 then
    local need = true
    local battleInfo = json.decode(game.role.battleInfo)
    if battleInfo and battleInfo.carbonId == self.carbonId then
      need = false
    end
    if need and self.carbonData.guidePic ~= "" then
      game:createView("common.CarbonGuideLayer", {
        guidePic = self.carbonData.guidePic
      })
    end
  end
end

function CarbonBattleLayer:showResultLayer(params)
  local layer = game:createView("carbon.NewCarbonResultLayer", {
    endResult = params.endResult,
    carbonId = params.carbonId,
    id = params.id
  })
  BackManager:push(function()
    if game.role.majorGuideStep == 12 then
      game:enterScene("MainScene")
    else
      local guideData = game.role:canShowFunctionGuide(self.carbonId)
      if self.endResult.bFirstWin and guideData then
        game:createView("common.ModuleGuideLayer", {
          guideData = guideData,
          cancelCall = function()
            layer:close()
            BackManager:pop()
            TopBar:show(TopBarType.full, "战斗")
          end
        })
      else
        layer:close()
        BackManager:pop()
        TopBar:show(TopBarType.full, "战斗")
      end
    end
  end)
end

function CarbonBattleLayer:showExitResultLayer(params)
  local layer = game:createView("carbon.NewCarbonResultLayer", {
    endResult = params.endResult,
    carbonId = params.carbonId,
    id = params.id
  })
  BackManager:push(function()
    layer:close()
    BackManager:pop()
  end)
end

return CarbonBattleLayer
