--[[
-- Lua侧UIImage
--]]
local UIRawImage = BaseClass("UIRawImage", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_rawimage)
    base.OnCreate(self, unity_rawimage)
    -- Unity侧原生组件
    self.unity_rawimage = unity_rawimage

    if IsNull(self.unity_rawimage) and not IsNull(self.gameObject) then
        self.gameObject = self.unity_rawimage.gameObject
        self.transform = self.unity_rawimage.transform
    end
    self.texture = self.unity_rawimage.texture
    self.material = self.unity_rawimage.material
end

-- 虚拟点击
local function OnVirtualClick(self)
    if self.__onclick ~= nil then
        self.__onclick()
    end
end

-- 设置回调
local function SetOnClick(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_rawimage:onClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.unity_rawimage:onClick(self.__onclick)
end

--用于兼容原生的
local function onClick(self, ...)
    SetOnClick(self, ...)
end

local function onPolygonClick(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_rawimage:onPolygonClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.unity_rawimage:onPolygonClick(self.__onclick)
end

local function SetPic(self, path, isNative)
    if isNative == nil then
        isNative = false
    end
    if IsNull(self.unity_rawimage) then
        return
    end
    self.unity_rawimage:SetPic(path, isNative)
    self.texture = self.unity_rawimage.texture
end

local function SetColor(self, r, g, b, a)
    if IsNull(self.unity_rawimage) then
        return
    end
    a = a or 255
    self.unity_rawimage:SetColor(r / 255, g / 255, b / 255, a / 255)
end

local function SetColorByColor(self, color)
    if IsNull(self.unity_rawimage) then
        return
    end
    return self.unity_rawimage:SetColor(color.r / 1, color.g / 1, color.b / 1, color.a / 1)
end

local function SetMaterial(self, material)
    if IsNull(self.unity_rawimage) then
        return
    end
    self.unity_rawimage.material = material
    self.material = material
end

local function SetRaycastTarget(self, enable)
    if IsNull(self.unity_rawimage) then
        return
    end
    if self.unity_rawimage.raycastTarget ~= enable then
        self.unity_rawimage.raycastTarget = enable
    end
end

local function GetRectTransform(self)
    if IsNull(self.unity_rawimage) then
        return
    end
    return self.unity_rawimage:GetRectTransform()
end

-- 销毁
local function OnDestroy(self)
    if not IsNull(self.unity_rawimage) then
        self.unity_rawimage:onClick(nil)
    end
    self.unity_rawimage = nil
    self.__onclick = nil
    base.OnDestroy(self)
end

UIRawImage.OnCreate = OnCreate
UIRawImage.SetOnClick = SetOnClick
UIRawImage.onClick = onClick
UIRawImage.onPolygonClick = onPolygonClick
UIRawImage.OnVirtualClick = OnVirtualClick
UIRawImage.SetPic = SetPic
UIRawImage.SetColor = SetColor
UIRawImage.SetColorByColor = SetColorByColor
UIRawImage.SetMaterial = SetMaterial
UIRawImage.SetRaycastTarget = SetRaycastTarget
UIRawImage.GetRectTransform = GetRectTransform
UIRawImage.OnDestroy = OnDestroy

return UIRawImage
