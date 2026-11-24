YJSYZEnemyDetailEnhancedBuffItem = {}

YJSYZEnemyDetailEnhancedBuffItem.__index = YJSYZEnemyDetailEnhancedBuffItem

local objs =
{
    icon = { path = "buff/icon", type = "Image" },
    text_buff_name = { path = "text_buff_name", type = "Text" },
    text_desc = { path = "text_desc", type = "Text" },
}

function YJSYZEnemyDetailEnhancedBuffItem.New()
    local self = {}
    setmetatable(self, YJSYZEnemyDetailEnhancedBuffItem)
    return self
end

function YJSYZEnemyDetailEnhancedBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function YJSYZEnemyDetailEnhancedBuffItem:SetData(d)
    local data = d.data

    if self.icon ~= nil then
        self.icon.sprite = LuaMgr.GetSprite("BuffIcon", data.buff_icon)
    end

    if self.text_buff_name ~= nil then
        self.text_buff_name.text = LuaMgr.GetLangText(data.buff_name_lan)
    end

    if self.text_desc ~= nil then
        self.text_desc.text = LuaMgr.GetLangText(data.buff_des_lan)
    end
end

function YJSYZEnemyDetailEnhancedBuffItem:Clear()
    self.data = nil
end

function YJSYZEnemyDetailEnhancedBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end