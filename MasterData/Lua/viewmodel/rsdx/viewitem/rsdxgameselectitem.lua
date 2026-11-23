






RSDXGameSelectItem = {}
RSDXGameSelectItem.__index = RSDXGameSelectItem

local objs = {
    selectBtn = {path = "", type = UITool.Button},
    rectTrans = {path = "", type = UITool.RectTransform},
    selectObj = {path = "IconSelect", type = UITool.Image},
    icon = {path = "Icon", type = UITool.Image}
}

RSDXGameSelectItem.New = function(obj)

    local self = {}
    setmetatable(self, RSDXGameSelectItem)
    self.gameObject = obj
    self:Init()
    return self
end

function RSDXGameSelectItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data ~= nil and self.data.OnClickElementItem ~= nil then
            self.data.OnClickElementItem(self)
        end
    end
    LuaMgr.AddClick(self.selectBtn, self.OnClickBtn)
end

function RSDXGameSelectItem:SetData(data)
    self.data = data
    local elementIDStr = tostring(self.data.ElementID)
    local elementConfig = ConfigMgr.Config.ColorGameElementMap[elementIDStr]
    if elementConfig.Element == nil or elementConfig.Element == "" then
        self.icon.color = RSDXConst.ElementColor[self.data.ElementID] or UnityEngine.Color.white
        self.selectObj.color = RSDXConst.ElementColor[self.data.ElementID] or UnityEngine.Color.white
    else
        self.icon.sprite = LuaMgr.GetSprite(RSDXConst.GameSpriteAtlaName, elementConfig.ElementHead)
        self.selectObj.sprite = LuaMgr.GetSprite(RSDXConst.GameSpriteAtlaName, elementConfig.ElementHead .. "_xz")
    end
end

function RSDXGameSelectItem:ClearItems()
end

function RSDXGameSelectItem:Clear()
    self:ClearItems()
end

function RSDXGameSelectItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end