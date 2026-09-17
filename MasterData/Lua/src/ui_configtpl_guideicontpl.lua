local this = class("guideIconTpl")

function this:init(config)
  self.data = {}
  for _, v in pairs(config) do
    self.data[v.keycode] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getKeycode(tpl)
  return tpl.keycode
end

function this:getHoldIcon(tpl)
  return tpl.holdIcon
end

function this:getTplByKeyCode(keyCode)
  for k, v in pairs(self.data) do
    if v.keycode == keyCode then
      return v
    end
  end
  return nil
end

function this:getDisName(tpl)
  return L_Config:provider(tpl.disName)
end

return this
