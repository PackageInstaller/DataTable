YJSYZChooseBuffPanelEnhancedBuffItem = {}
YJSYZChooseBuffPanelEnhancedBuffItem.__index = YJSYZChooseBuffPanelEnhancedBuffItem

local objs =
{
    icon = { path = "buff/icon", type = "Image" },
    text_buff_name = { path = "text_buff_name", type = "Text" },
    text_desc = { path = "text_desc", type = "Text" },
}

function YJSYZChooseBuffPanelEnhancedBuffItem.New()
    local self = {}
    setmetatable(self, YJSYZChooseBuffPanelEnhancedBuffItem)
    return self
end

function YJSYZChooseBuffPanelEnhancedBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function YJSYZChooseBuffPanelEnhancedBuffItem:SetData(d)
    self.data = d.data
    local buff_config = ConfigMgr.Config.buffMap[tostring(self.data.buff_id)]
    if buff_config == nil then
        return
    end

    if self.icon ~= nil then
        self.icon.sprite = LuaMgr.GetSprite("BuffIcon", buff_config.BuffIcon)
    end

    if self.text_buff_name ~= nil then
        self.text_buff_name.text = LuaMgr.GetLangText(buff_config.NameLan)
    end

    if self.text_desc ~= nil then
        self.text_desc.text = LuaMgr.GetLangText(buff_config.DescriptionLan)
    end
end

function YJSYZChooseBuffPanelEnhancedBuffItem:Clear()
    self.data = nil
end

function YJSYZChooseBuffPanelEnhancedBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end