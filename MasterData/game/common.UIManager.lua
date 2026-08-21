local UIManager = {}

function UIManager:pushLayer(layer, callback)
  local function func()
    if callback then
      callback()
    end
  end
  
  stack:push({layer = layer, cb = func})
end

function UIManager:popLayer()
  local data = stack:pop()
  if data.func then
    data.func()
  end
end

return UIManager
