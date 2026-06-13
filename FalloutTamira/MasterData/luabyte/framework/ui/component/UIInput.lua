--[[
-- Lua侧UIInput
--]]

local UIInput = BaseClass("UIInput", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_uiinput)
    base.OnCreate(self, unity_uiinput)
    -- Unity侧原生组件
    self.unity_uiinput = unity_uiinput
    
    if not IsNull(self.unity_uiinput) and IsNull(self.gameObject) then
        self.gameObject = self.unity_uiinput.gameObject
        self.transform = self.unity_uiinput.transform
    end
end

-- 获取文本
local function GetText(self)
    if not IsNull(self.unity_uiinput) then
        self._text = self.unity_uiinput.text
        return self.unity_uiinput.text
    end
end

-- 设置字数限制
local function SetCharacterLimit(self, limitNum)
    if not IsNull(self.unity_uiinput) then
        self.unity_uiinput.characterLimit = limitNum
    end
end

--设置文本输入类型限制
local function SetContentType(self, type)
    if not IsNull(self.unity_uiinput) then
        self.unity_uiinput.contentType = type
    end
end

-- 设置文本
local function SetText(self, text)
    if not IsNull(self.unity_uiinput) then
        self.unity_uiinput.text = text
    end
end

--输入结束函数
local function onEndEdit(self, ...)
    local arr = {...}
	if #arr == 0 then 
		self.unity_uiinput:onEndEdit(nil)
		return 
	end
	-- body
	self.__onEndEdit = BindCallback(...)
	self.unity_uiinput:onEndEdit(self.__onEndEdit)
end

-- 销毁
local function OnDestroy(self)
    if self.unity_uiinput and self.unity_uiinput.onEndEdit then 
        self.unity_uiinput:onEndEdit(nil)
    end
    self.unity_uiinput.onEndEdit = nil 

    self.__onEndEdit = nil 
    self.unity_uiinput = nil
    base.OnDestroy(self)
end

UIInput.OnCreate = OnCreate
UIInput.GetText = GetText
UIInput.SetText = SetText
UIInput.OnDestroy = OnDestroy
UIInput.SetCharacterLimit = SetCharacterLimit
UIInput.SetContentType = SetContentType
UIInput.onEndEdit = onEndEdit

return UIInput
