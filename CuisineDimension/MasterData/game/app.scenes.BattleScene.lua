local BattleScene = class("BattleScene", function()
  return display.newScene("BattleScene")
end)

function BattleScene:ctor(params)
  self.params = params
  ResourceMgr.inBattle = true
end

function BattleScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  local viewTypeHandlers = {
    [BattleType.PvE] = function()
      local layer = game:createView("battle.PveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Tower] = function()
      local layer = game:createView("battle.TowerBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.PvP] = function()
      local layer = game:createView("battle.PvpBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Moon] = function()
      local layer = game:createView("battle.MoonPveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Lty] = function()
      local layer = game:createView("battle.LtyBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Paradise] = function()
      local layer = game:createView("battle.ParadisePveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.MJ] = function()
      local layer = game:createView("battle.MJPveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Sauce] = function()
      local layer = game:createView("battle.SaucePveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.EJ] = function()
      local layer = game:createView("battle.EJPveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.ActCarbon] = function()
      local layer = game:createView("battle.ActPveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.NewWorldboss] = function()
      local layer = game:createView("battle.NewWorldbossBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Worldboss] = function()
      local layer = game:createView("battle.WorldbossBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.Union] = function()
      local layer = game:createView("battle.UnionBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.ShenYuan] = function()
      local layer = game:createView("battle.SYPveBattleLayer", self.params)
      layer:addTo(self):showView()
    end,
    [BattleType.RouGe] = function()
      local layer = game:createView("battle.RouGeBattleLayer", self.params)
      layer:addTo(self):showView()
    end
  }
  viewTypeHandlers[self.params.type]()
  if DEBUG > 0 then
    local timeLabel = display.newTTFLabel({
      text = CommonHelper.date(nil, "c"),
      size = 30,
      color = display.COLOR_WHITE
    })
    timeLabel:anch(1, 0):pos(display.width - 20, 20):addTo(self, 10000)
    
    local function refreshTime()
      timeLabel:setString(CommonHelper.date(nil, "YmdX"))
      timeLabel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          refreshTime()
        end)
      }))
    end
    
    refreshTime()
  end
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function BattleScene:onCleanup()
  GameState.save(UserData)
  NetManager:removeEventListenersByEvent("networkLogin")
  cc.Director:getInstance():getScheduler():setTimeScale(1)
  ResourceMgr.inBattle = false
  ResourceMgr:clear()
  display.removeUnusedSpriteFrames()
  collectgarbage("collect")
end

return BattleScene
