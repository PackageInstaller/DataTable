YJSYZChooseBuffPanelBuffItem = {}
YJSYZChooseBuffPanelBuffItem.__index = YJSYZChooseBuffPanelBuffItem

local objs =
{
    enhanced = { path = "enhanced", type = "Image" },
    normal = { path = "normal", type = "Image" },
    icon = { path = "icon", type = "Image" },
    select = { path = "select", type = "Image"},
}

function YJSYZChooseBuffPanelBuffItem.New()
    local self = {}
    setmetatable(self, YJSYZChooseBuffPanelBuffItem)
    return self
end

function YJSYZChooseBuffPanelBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function YJSYZChooseBuffPanelBuffItem:SetData(d)
    self.data = d.data

    self.enhanced.gameObject:SetActive(self.data.is_enhanced == true)
    self.normal.gameObject:SetActive(self.data.is_enhanced ~= true)

    local buff_config = ConfigMgr.Config.buffMap[tostring(self.data.buff_id)]
    if buff_config ~= nil and buff_config.BuffIcon ~= nil then
        self.icon.sprite = LuaMgr.GetSprite("BuffIcon", buff_config.BuffIcon)
    end

    local function f()
        if self.data ~= nil and self.data.callback ~= nil then
            self.data.callback(self.data, self.gameObject)
        end
    end
    LuaMgr.RemoveClick(self.gameObject:GetComponent("Button"), f)
    LuaMgr.AddClick(self.gameObject:GetComponent("Button"), f)
end

function YJSYZChooseBuffPanelBuffItem:Clear()
    self.data = nil
end

function YJSYZChooseBuffPanelBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end