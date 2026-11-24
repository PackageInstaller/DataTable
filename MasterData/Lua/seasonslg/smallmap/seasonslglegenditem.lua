



SeasonSLGLegendItem = {}
SeasonSLGLegendItem.__index = SeasonSLGLegendItem

local objs = {
    icon = {path = "Icon", type = UITool.Image},
    text = {path = "Name", type = UITool.Text},
}

SeasonSLGLegendItem.New = function()

    local self = {}
    setmetatable(self, SeasonSLGLegendItem)
    return self
end

function SeasonSLGLegendItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function SeasonSLGLegendItem:SetData(data)
    self.data = data.data
    self.icon.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas2, self.data.Icon)
    self.text.text = string.format("<color=%s>%s</color>", self.data.Color, self.data.Name)
end

function SeasonSLGLegendItem:ClearItems()
end

function SeasonSLGLegendItem:Clear()
    self:ClearItems()
end

function SeasonSLGLegendItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end