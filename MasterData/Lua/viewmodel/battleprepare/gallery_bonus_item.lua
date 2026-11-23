Gallery_Bonus_Item = {}

Gallery_Bonus_Item.__index = Gallery_Bonus_Item

local objs = 
{
    icon        = {path = "icon", type = "Image"},
    name        = {path = "name", type = "Text"},
    value       = {path = "value", type = "Text"},
}

function Gallery_Bonus_Item.New()
    local obj = {}
    setmetatable(obj, Gallery_Bonus_Item)
    return obj
end

function Gallery_Bonus_Item:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function Gallery_Bonus_Item:SetData(d)
    local data = d.data
    self.icon.sprite    = LuaMgr.GetSprite("AttributeIcon",data.icon)
    self.name.text      = data.name
    
    local sort = ConfigMgr.Config.BestiarySSortMap[data.icon]
    if not TableIsNull(sort) then
        if sort.MaxValue > 0 and data.value > sort.MaxValue then
            self.value.text = "+" .. tostring(sort.MaxValue) .. data.type
        else
            self.value.text = "+" .. tostring(data.value) .. data.type
        end
    end
end

function Gallery_Bonus_Item:Clear()
    
end

function Gallery_Bonus_Item:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.icon       = nil
    self.name       = nil
    self.value      = nil
end