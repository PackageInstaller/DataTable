









JZQWRecollectionItem = {}
JZQWRecollectionItem.__index = JZQWRecollectionItem

local objs = {
    button = {path = "Group", type = UITool.Button},
    lineObj = {path = "Line", type = UITool.GameObject},
    groupObj = {path = "Group", type = UITool.GameObject},
    flagObjRepeat = {path = "Group/FlagObjRepeat", type = UITool.GameObject},
    flagObjOther = {path = "Group/FlagObjOther", type = UITool.GameObject},
    flagObjNovel = {path = "Group/FlagObjNovel", type = UITool.GameObject},
    name = {path = "Group/Name", type = UITool.Text}
}

JZQWRecollectionItem.New = function()

    local self = {}
    setmetatable(self, JZQWRecollectionItem)
    return self
end

function JZQWRecollectionItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnclickItemBtn = function ()
        if self.data.OnClickCallback ~= nil then
            self.data.OnClickCallback(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnclickItemBtn)
end

function JZQWRecollectionItem:SetData(data)
    self.data = data.data
    SetActive(self.groupObj, self.data.EventType ~= nil)
    SetActive(self.lineObj, self.data.EventType == nil)
    if self.data.EventType ~= nil then
        SetActive(self.flagObjRepeat, self.data.EventType == JZQWConst.EventType.Repeat)
        local isOther = self.data.EventType ~= JZQWConst.EventType.Repeat and self.data.EventType ~= JZQWConst.EventType.Novel
        SetActive(self.flagObjOther, isOther)
        SetActive(self.flagObjNovel, self.data.EventType == JZQWConst.EventType.Novel)
        self.name.text = self.data.Name
    end
end

function JZQWRecollectionItem:ClearItems()
end

function JZQWRecollectionItem:Clear()
    self:ClearItems()
end

function JZQWRecollectionItem:Destroy()
    self:Clear()
    self.gameObject = nil
    self.data = nil
end