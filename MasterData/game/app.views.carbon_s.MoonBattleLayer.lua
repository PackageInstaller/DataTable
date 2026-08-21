local ChapterBattleCsv = require("csvdata.moon_chapter_battle")
local BaseCarbonBattleLayer = game:loadView("carbon.BaseCarbonBattleLayer")
local MoonBattleLayer = class("MoonBattleLayer", BaseCarbonBattleLayer)

function MoonBattleLayer:ctor(params)
  self.carbonData = ChapterBattleCsv[params.carbonId]
  BaseCarbonBattleLayer.ctor(self, params)
  table.insert(self.handlers, game.role:addEventListener("set_activityBackStatus", function(event)
    if not game.role:carbonActivityIsOpen() then
      MDialog:single({
        text = "活动已结束，请点击“确定”退出"
      }, function()
        game:enterScene("MainScene")
      end)
    end
  end))
end

function MoonBattleLayer:getBattleData()
  return game.role.moonBattle
end

function MoonBattleLayer:getBattleInfo()
  return game.role.moonBattleInfo
end

function MoonBattleLayer:battleInfoCache(data, clear)
  if data then
    game.role.moonBattleInfoCache = data
  end
  if clear then
    game.role.moonBattleInfoCache = nil
  end
  return game.role.moonBattleInfoCache
end

function MoonBattleLayer:getActionCodes()
  return {
    battleType = BattleType.Moon,
    SelectRpc = actionCodes.Moon_SelectRpc,
    arrangeCarbonRpc = actionCodes.Moon_arrangeCarbonRpc,
    moveRpc = actionCodes.Moon_moveRpc,
    actionEndRpc = actionCodes.Moon_actionEndRpc,
    cancelMoveRpc = actionCodes.Moon_cancelMoveRpc,
    endCarbonRpc = actionCodes.Moon_endCarbonRpc,
    exitTeamRpc = actionCodes.Moon_exitTeamRpc,
    supplyRpc = actionCodes.Moon_supplyRpc,
    changePosRpc = actionCodes.Moon_changePosRpc,
    treatHerosRpc = actionCodes.Moon_treatHerosRpc
  }
end

function MoonBattleLayer:showGuide()
  if game.role.midBattleCount:getv(self.carbonId, -1) < 0 then
    local need = true
    local battleInfo = json.decode(game.role.moonBattleInfo)
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

function MoonBattleLayer:showExitResultLayer(params)
  local layer = game:createView("carbon_s.NewMoonResultLayer", {
    endResult = params.endResult,
    carbonId = params.carbonId,
    id = params.id
  })
  BackManager:push(function()
    layer:close()
    BackManager:pop()
    TopBar:show(TopBarType.full, "战斗")
  end)
end

function MoonBattleLayer:showResultLayer(params)
  local layer = game:createView("carbon_s.NewMoonResultLayer", {
    endResult = params.endResult,
    carbonId = params.carbonId,
    id = params.id
  })
  BackManager:push(function()
    layer:close()
    BackManager:pop()
    TopBar:show(TopBarType.full, "战斗")
  end)
end

return MoonBattleLayer
