local UINewButton = BaseClass("UINewButton", UIBaseContainer)
local base = UIBaseContainer

-- 创建
local function OnCreate(self, unity_button)
    base.OnCreate(self)
    -- Unity侧原生组件
    self.unity_uibutton = unity_button
    -- 记录点击回调（非基类）
    self.__onClick = nil

    if not IsNull(self.unity_uibutton) and not IsNull(self.gameObject) then
        self.gameObject = self.unity_uibutton.gameObject
        self.transform = self.unity_uibutton.transform
        self.m_onClick = self.unity_uibutton.onClick
    end

    self.m_OnButtonClickHandle = Bind(self, self.OnVirtualClick)
    self.m_onClick:AddListener(self.m_OnButtonClickHandle)
end

-- 虚拟点击
local function OnVirtualClick(self)
    if self.__onClick then
        self.__onClick()
    end
end

-- 设置回调
local function SetOnClick(self, ...)
    self.__onClick = BindCallback(...)
end

local function SetState(self, state)
    self.unity_uibutton:SetState(state)
end

-- 移除回调
local function RemoveOnClick(self)
    if self.__onClick ~= nil then
        self.__onClick = nil
    end
end

-- 移除所有回调
local function RemoveAllOnClicks(self)
    self:RemoveOnClick()
end

-- 资源释放
local function OnDestroy(self)
    if not IsNull(self.m_onClick) then
        self.m_onClick:RemoveListener(self.m_OnButtonClickHandle)
    end
    self.unity_uibutton.onClick = nil
    self.m_OnButtonClickHandle = nil
    self.unity_uibutton = nil
    self.__onClick = nil
    self.m_onClick = nil
    base.OnDestroy(self)
end

UINewButton.OnCreate = OnCreate
UINewButton.SetOnClick = SetOnClick
UINewButton.SetState = SetState
UINewButton.RemoveOnClick = RemoveOnClick
UINewButton.RemoveAllOnClicks = RemoveAllOnClicks
UINewButton.OnVirtualClick = OnVirtualClick
UINewButton.OnDestroy = OnDestroy

return UINewButton
