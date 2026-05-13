local Entity = class("Entity")
local sep = "_xxxed"
local table_concat = table.concat

function Entity:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  cc(self):addComponent("components.behavior.StateMachine"):exportMethods()
  self.hasPaused = false
  self._timeouts = {}
end

function Entity:pause()
  self.hasPaused = true
  self:onPause()
end

function Entity:resume()
  self.hasPaused = false
  self:onResume()
end

function Entity:onPause()
end

function Entity:onResume()
end

function Entity:timeout(delay, callback, params)
  if delay <= 0 then
    callback(params)
  else
    table.insert(self._timeouts, scheduler.performWithDelayGlobal(function()
      callback(params)
    end, delay))
  end
end

function Entity:removeTimeout(handler)
  scheduler.unscheduleGlobal(handler)
end

function Entity:clearTimeout()
  for _, handler in ipairs(self._timeouts) do
    self:removeTimeout(handler)
  end
  self._timeouts = {}
end

function Entity:setBattle(battle)
  self.battle = battle
end

function Entity:runAction(actions)
  self.battle.actionManager:addAction(self, actions)
end

return Entity
