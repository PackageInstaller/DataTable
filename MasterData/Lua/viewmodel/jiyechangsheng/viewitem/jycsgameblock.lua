





JYCSGameBlock = {}
JYCSGameBlock.__index = JYCSGameBlock

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    icon = {path = "Icon", type = UITool.Image},
    iconRect = {path = "Icon", type = UITool.RectTransform}
}

JYCSGameBlock.New = function()

    local self = {}
    setmetatable(self, JYCSGameBlock)
    return self
end

function JYCSGameBlock:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function JYCSGameBlock:SetData(data)
    self.data = data
    SetActive(self.icon.gameObject, self.data ~= nil)
    if self.data == nil then
        return
    end
    SetActive(self.icon.gameObject, true)
    if self.data.Config.Icon == nil or self.data.Config.Icon == "" then
        SetActive(self.icon.gameObject, false)
    else
        SetActive(self.icon.gameObject, true)
        self.icon.sprite = LuaMgr.GetSprite(JYCSConst.AtlasName, self.data.Config.Icon)
        self.icon:SetNativeSize()
    end
end

function JYCSGameBlock:GetAnchoredPos()
    return self.rectTrans.anchoredPosition
end

function JYCSGameBlock:ClearItems()
end

function JYCSGameBlock:Clear()
    self:ClearItems()
end

function JYCSGameBlock:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end