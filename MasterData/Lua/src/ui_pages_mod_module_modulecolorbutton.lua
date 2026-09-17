local module = class("moduleColorButton", G_UIModuleBase)

function module.bind()
  return {
    colorText = "",
    color = Unity.Color.white,
    sanJiaoEulre = L_Vector3.zero
  }
end

function module.methods()
  return {
    OnClick = function(self)
      if self.bind.colorIndex then
        self:emit("toggleColorArea", self.bind.colorIndex)
      end
    end
  }
end

function module:setColorAreaActive(isActive)
  self.bind.sanJiaoEulre = isActive and L_Vector3.zero or L_Vector3.new(0, 0, 90)
end

function module:setData(...)
  local data = (...)
  for i, v in pairs(data) do
    self.bind[i] = v
  end
end

function module:refresh()
  self.bind.color = C_LuaUtility.ParseHtmlStringColor(self.bind.colorValue)
end

return module
