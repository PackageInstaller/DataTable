Timer = {frameCount = 0}
local m_controllerList = {}

function Timer.updateAll()
  Timer.frameCount = C_Time.frameCount
  local dt = C_Time.deltaTime
  local udt = C_Time.unscaledDeltaTime
  for _, v in ipairs(m_controllerList) do
    v:onUpdate(dt, udt)
  end
end

function Timer.getController()
  local controller = require("core.timer.timerController").new()
  table.insert(m_controllerList, controller)
  return controller
end

local m_default = Timer.getController()

function Timer.new(func, duration, loop, scale, binder)
  return m_default:getTimer(func, duration, loop, scale, binder)
end

function Timer.once(time, func, binder, obj, scale)
  return m_default:once(time, func, binder, obj, scale)
end

function Timer.repeated(time, func, binder, obj)
  return m_default:repeated(time, func, binder, obj)
end

function Timer.remove(timer)
  m_default:remove(timer)
end
