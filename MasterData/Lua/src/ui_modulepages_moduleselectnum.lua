local this = class("moduleSelectNum", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    max = nil,
    min = nil,
    func = nil,
    num = 1
  }
end

function this.bind()
  return {
    txt_num = "",
    interactable_btn_add = false,
    interactable_btn_decrease = false,
    interactable_btn_max = false,
    interactable_btn_min = false
  }
end

function this.methods()
  return {
    onEditEnd_num = function(self, text)
      self:changeNum(tonumber(text))
    end,
    onClick_add = function(self)
      self:changeNum(self.data.num + 1)
      self:emit("onClick_add", self.bind)
    end,
    onClick_decrease = function(self)
      self:changeNum(self.data.num - 1)
      self:emit("onClick_decrease", self.bind)
    end,
    onClick_max = function(self)
      self:changeNum(math.maxinteger)
      self:emit("onClick_max", self.bind)
    end,
    onClick_min = function(self)
      self:changeNum(math.mininteger)
      self:emit("onClick_min", self.bind)
    end
  }
end

function this:open()
  this.super.open(self)
  self._inputActionBinding = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UIInputActionBinding))
end

function this:close()
  self:setGamepadShortCutEnable(false)
  if not self._inputActionBinding or not self._inputActionBinding.hasInputBindConfigs then
    self:unregisterShortCut("moduleSelectNum")
  end
  this.super.close(self)
end

function this:initModule(func, max, min, defaultSelectNum)
  min = min or 1
  self.data.max = max or 1
  self.data.min = min
  self.data.func = func
  self.data.num = defaultSelectNum or 1
  local maxNum = type(self.data.max) == "number" and self.data.max or self.data.max()
  local minNum = type(self.data.min) == "number" and self.data.min or self.data.min()
  if maxNum < self.data.num then
    self:changeNum(maxNum)
  elseif minNum > self.data.num then
    self:changeNum(minNum)
  else
    self:showNum()
  end
  if not self._inputActionBinding or not self._inputActionBinding.hasInputBindConfigs then
    self:registerShortCut("moduleSelectNum")
  end
  self:setGamepadShortCutEnable(true)
end

function this:changeNum(num)
  local max = self.data.max
  if type(self.data.max) ~= "number" then
    max = self.data.max()
  end
  local min = self.data.min
  if type(self.data.min) ~= "number" then
    min = self.data.min()
  end
  num = num or min
  self.data.num = math.clamp(num, min, max)
  self:showNum()
  if self.data.func then
    self.data.func(self.data.num)
  end
end

function this:getNum()
  return self.data.num
end

function this:showNum()
  self.bind.txt_num = tostring(self.data.num)
  self:refreshBtnStatus()
end

function this:refreshBtnStatus()
  local max = self.data.max
  if type(self.data.max) ~= "number" then
    max = self.data.max()
  end
  local min = self.data.min
  if type(self.data.min) ~= "number" then
    min = self.data.min()
  end
  self.bind.interactable_btn_add = max > self.data.num
  self.bind.interactable_btn_decrease = min < self.data.num
  self.bind.interactable_btn_max = max > self.data.num
  self.bind.interactable_btn_min = min < self.data.num
end

function this:setEnable(bEnable)
end

function this:setGamepadShortCutEnable(bEnable)
  self._gamepadShortCutEnable = bEnable
  if self._inputActionBinding and self._inputActionBinding.hasInputBindConfigs then
    self._inputActionBinding.inputEnabled = bEnable
    self._inputActionBinding.inputIconEnabled = bEnable
  elseif self._gamepadShortCutEnable then
    self:addShortKeyFlag()
  else
    self:clearShortKeyFlag()
  end
end

function this:registerShortCut(pageName)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumDec, function()
    if self.gameObject.activeInHierarchy and self._gamepadShortCutEnable then
      self:changeNum(self.data.num - 1)
      self:emit("onClick_decrease", self.bind)
    end
  end)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumInc, function()
    if self.gameObject.activeInHierarchy and self._gamepadShortCutEnable then
      self:changeNum(self.data.num + 1)
      self:emit("onClick_add", self.bind)
    end
  end)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumMin, function()
    if self.gameObject.activeInHierarchy and self._gamepadShortCutEnable then
      self:changeNum(math.mininteger)
      self:emit("onClick_min", self.bind)
    end
  end)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumMax, function()
    if self.gameObject.activeInHierarchy and self._gamepadShortCutEnable then
      self:changeNum(math.maxinteger)
      self:emit("onClick_max", self.bind)
    end
  end)
end

function this:unregisterShortCut(pageName)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumDec)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumInc)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumMin)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EModuleSelectNumMax)
end

function this:addShortKeyFlag()
  L_ShortCutManager:addShortKeyFlag(self, "UI_ModuleSelectNumDec", L_Const.AnchorType.Left, self.gameObject.transform, L_Vector3.new(0, 0), 1.2)
  L_ShortCutManager:addShortKeyFlag(self, "UI_ModuleSelectNumInc", L_Const.AnchorType.Right, self.gameObject.transform, L_Vector3.new(0, 0), 1.2)
end

function this:clearShortKeyFlag()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
