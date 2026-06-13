--[[
-- Lua侧UIText
-- 使用方式：
-- self.xxx_text = self:AddComponent(UIInput, var_arg)--添加孩子，各种重载方式查看UIBaseContainer
-- TODO：本地化支持
--]]

local UIText = BaseClass("UIText", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self,unity_text)
	base.OnCreate(self,unity_text)
	self.unity_uitext = unity_text
	-- Unity侧原生组件
	if self.unity_uitext == nil then 
		self.unity_uitext = UIUtil.FindText(self.transform)
	end
	
	if IsNull(self.unity_uitext) and not IsNull(self.gameObject) then
		self.gameObject = self.unity_uitext.gameObject
		self.transform = self.unity_uitext.transform
	end
	self._text = self:GetText()
end

local function onClick(self, ...)
    local arr = {...}
    if #arr == 0 then
        self.unity_uitext:onClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.unity_uitext:onClick(self.__onclick)
end

-- 获取文本
local function GetText(self)
	if self._text then 
		return self._text
	end
	if not IsNull(self.unity_uitext) then
		return self.unity_uitext.text
	end
end

-- 设置文本
local function SetText(self, text)
	if not IsNull(self.unity_uitext) then
		self.unity_uitext:SetText(text)
		self._text = text 
	end
end

-- 销毁
local function OnDestroy(self)
	self.unity_uitext = nil
	base.OnDestroy(self)
end

UIText.OnCreate = OnCreate
UIText.onClick = onClick
UIText.GetText = GetText
UIText.SetText = SetText
UIText.OnDestroy = OnDestroy

return UIText