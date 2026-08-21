local ChapterBattleCsv = require("csvdata.leyuan_battle")
local BattleRes = "ui/carbon/battle/"
local BaseCarbonBattleLayer = game:loadView("carbon.BaseCarbonBattleLayer")
local ParadiseBattleLayer = class("ParadiseBattleLayer", BaseCarbonBattleLayer)

function ParadiseBattleLayer:ctor(params)
  self.carbonData = ChapterBattleCsv[params.carbonId]
  BaseCarbonBattleLayer.ctor(self, params)
end

function ParadiseBattleLayer:getBattleData()
  return game.role.paradiseBattle
end

function ParadiseBattleLayer:getBattleInfo()
  return game.role.paradiseBattleInfo
end

function ParadiseBattleLayer:battleInfoCache(data, clear)
  if data then
    game.role.paradiseBattleInfoCache = data
  end
  if clear then
    game.role.paradiseBattleInfoCache = nil
  end
  return game.role.paradiseBattleInfoCache
end

function ParadiseBattleLayer:getActionCodes()
  return {
    battleType = BattleType.Paradise,
    SelectRpc = actionCodes.Paradise_SelectRpc,
    arrangeCarbonRpc = actionCodes.Paradise_arrangeCarbonRpc,
    moveRpc = actionCodes.Paradise_moveRpc,
    actionEndRpc = actionCodes.Paradise_actionEndRpc,
    cancelMoveRpc = actionCodes.Paradise_cancelMoveRpc,
    endCarbonRpc = actionCodes.Paradise_endCarbonRpc,
    exitTeamRpc = actionCodes.Paradise_exitTeamRpc,
    supplyRpc = actionCodes.Paradise_supplyRpc,
    changePosRpc = actionCodes.Paradise_changePosRpc,
    treatHerosRpc = actionCodes.Paradise_treatHerosRpc
  }
end

function ParadiseBattleLayer:showGuide()
  if game.role.paradiseBattlePass:getv(self.carbonId, -1) < 0 then
    local need = true
    local battleInfo = json.decode(game.role.paradiseBattleInfo)
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

function ParadiseBattleLayer:canNewGameArrange()
  return true
end

function ParadiseBattleLayer:showResetDay()
end

function ParadiseBattleLayer:refreshRightAngle()
  if not self.newGame then
    if self.zbInfo then
      self.zbInfo:removeFromParent()
      self.zbInfo = nil
    end
    self.btnNode:hide()
  end
end

function ParadiseBattleLayer:refreashLastTime()
  self.timeSlot:hide()
  self.activeBg:hide()
end

function ParadiseBattleLayer:showRightPanel(move, btn)
  if btn then
    if not self.btnOk:isVisible() then
      self.btnSpine:setToSetupPose()
      self.btnSpine:setAnimation(1, "noStart", false)
      self.btnSpine:addAnimation(1, "start", true)
      self.btnOk:show()
    else
      self.btnOk:hide()
    end
  else
    self.btnOk:hide()
  end
end

local function getHpPercent(index, heroInfo)
  local formation = game.role.formation[tostring(index)]
  local hpPercent, num = 0, 0
  for _, id in pairs(formation.list) do
    local hero = game.role.heros[id]
    num = num + 1
    hpPercent = hpPercent + (heroInfo[tostring(id)] or 1000) / 1000
  end
  return hpPercent / num * 100
end

function ParadiseBattleLayer:updateMaterialBar(player)
  local materialbar = player.materialNode
  materialbar:removeAllChildren()
  local percent3 = getHpPercent(player.format, self:getBattleData().heroList or {})
  display.newTTFLabel({
    text = "套餐" .. player.format,
    size = 14,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(51, 79):addTo(materialbar)
  display.newSprite(BattleRes .. "small_1.png"):pos(96, 79):addTo(materialbar)
  local bar3 = display.newProgressTimer(BattleRes .. "small_2.png", display.PROGRESS_TIMER_BAR)
  bar3:pos(96, 79):addTo(materialbar)
  bar3:setMidpoint(cc.p(0, 0.5))
  bar3:setBarChangeRate(cc.p(1, 0))
  bar3:setPercentage(percent3)
end

function ParadiseBattleLayer:decMovePoint()
end

function ParadiseBattleLayer:isPassTime()
  return false
end

function ParadiseBattleLayer:showResultLayer(params)
  local layer = game:createView("carbon.NewHappyResultLayer", {
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

function ParadiseBattleLayer:showExitResultLayer(params)
  local layer = game:createView("carbon.NewHappyResultLayer", {
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

return ParadiseBattleLayer
