local uiData = {
  csbFile = "ui/equip/FilterEquipConditionLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    btn1 = "mainBg/btn1",
    btn2 = "mainBg/btn2",
    btn3 = "mainBg/btn3",
    btn4 = "mainBg/btn4",
    cancel = "mainBg/cancel",
    ok = "mainBg/ok"
  }
}
local FilterEquipConditionLayer = class("FilterEquipConditionLayer", UIBase)

function FilterEquipConditionLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FilterEquipConditionLayer:init(params)
  local callback = params.callback
  local professions = params.profession or {}
  self.cancel:setTouchScale()
  self.ok:setTouchScale()
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.ok:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.btn1:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#6d2b15"), 1)
  if not next(professions) then
    self.btn1:setState(2)
  end
  for i = 1, 3 do
    local btn = self["btn" .. i + 1]
    local state = professions[i] and 2 or 1
    btn:setState(state)
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      if not professions[i] then
        professions[i] = 1
        btn:setState(2)
      else
        professions[i] = nil
        btn:setState(1)
      end
      if not next(professions) then
        self.btn1:setState(2)
      else
        self.btn1:setState(1)
      end
      if table.nums(professions) == 3 then
        professions = {}
        for index = 2, 4 do
          self["btn" .. index]:setState(1)
        end
        self.btn1:setState(2)
      end
    end)
  end
  self.btn1:setCallback(function()
    for index, _ in pairs(professions) do
      self["btn" .. index + 1]:setState(1)
      professions[index] = nil
    end
    self.btn1:setState(2)
  end)
  self.cancel:setCallback(function()
    self:close()
  end)
  self.ok:setCallback(function()
    if callback then
      local res = callback(professions)
      if not res then
        self:close()
      end
    end
  end)
end

return FilterEquipConditionLayer
