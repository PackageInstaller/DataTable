local this = {}
local m_controller = Timer.getController()

function this.new(func, time, loop, binder)
  return m_controller:getTimer(func, time, loop, false, binder)
end

function this.once(time, func, binder, obj)
  return m_controller:once(time, func, binder, obj)
end

function this.repeated(time, func, binder, obj)
  return m_controller:repeated(time, func, binder, obj)
end

function this.pause()
  m_controller:pause()
end

function this.resume()
  m_controller:resume()
end

function this.translateUpdate(isUpdate)
  if isUpdate then
    this.resume()
  else
    this.pause()
  end
end

function this.remove(this)
  m_controller:remove(this)
end

return this
