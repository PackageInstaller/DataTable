--[[
-- Lua侧UIToggle
--]]

local UIToggle = BaseClass("UIToggle", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_toggle)
    base.OnCreate(self, unity_toggle)
    -- Unity侧原生组件
    self.unity_toggle = unity_toggle
    if not IsNull(self.unity_toggle) and not IsNull(self.gameObject) then
        self.gameObject = self.unity_toggle.gameObject
        self.transform = self.unity_toggle.transform
        self.onValueChanged = self.unity_toggle.onValueChanged
    end
    self:RemoveToggleAllClicks()
    self._OnToggleClickHandle = Bind(self, self._OnToggleClick)
    self.onValueChanged:AddListener(self._OnToggleClickHandle)
end

-- callback(bool)
local function OnToggleClick(self, callback)
    -- body
    self._onValueChangeCallback = callback
end

local function _OnToggleClick(self, isOn)
    -- body
    if self._onValueChangeCallback then
        self._onValueChangeCallback(isOn)
    end
end

local function RemoveToggleAllClicks(self)
    -- body
    self.unity_toggle:RemoveToggleAllClicks()
end

local function GetIsOn(self)
    -- body
    return self.unity_toggle.isOn
end

local function SetIsOn(self, isOn, needCallback)
    -- body
    if needCallback == nil then
        needCallback = true
    end
    if needCallback then
        self.unity_toggle.isOn = isOn
    else
        self.unity_toggle:SetIsOnWithoutNotify(isOn)
    end
end

local function GetInteractable(self)
    -- body
    return self.unity_toggle.interactable
end

local function SetInteractable(self, isOn)
    -- body
    self.unity_toggle.interactable = isOn
end

local function onClick(self, ...)
    if IsNull(self.unity_toggle) then
        return
    end
    local arr = { ... }
    if #arr == 0 then
        self.unity_toggle:onClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.unity_toggle:onClick(self.__onclick)
end

-- 资源释放
local function OnDestroy(self)
    if not IsNull(self.unity_toggle.group) then
        self.unity_toggle.group:UnregisterToggle(self.unity_toggle)
    end
    if not IsNull(self.onValueChanged) then
        self.onValueChanged:RemoveListener(self._OnToggleClickHandle)
    end
    if self.__onclick and not IsNull(self.unity_toggle) then
        self.unity_toggle:onClick(nil)
    end
    self.unity_toggle.onValueChanged = nil
    self.onValueChanged = nil
    self._onValueChangeCallback = nil
    self._OnToggleClickHandle = nil
    self.__onclick = nil
    self.unity_toggle = nil
    base.OnDestroy(self)
end

UIToggle.OnCreate = OnCreate
UIToggle.OnDestroy = OnDestroy
UIToggle.OnToggleClick = OnToggleClick
UIToggle.RemoveToggleAllClicks = RemoveToggleAllClicks
UIToggle.GetInteractable = GetInteractable
UIToggle.SetInteractable = SetInteractable
UIToggle.GetIsOn = GetIsOn
UIToggle.SetIsOn = SetIsOn
UIToggle.GetIsOn = GetIsOn
UIToggle.onClick = onClick
UIToggle._OnToggleClick = _OnToggleClick

return UIToggle
