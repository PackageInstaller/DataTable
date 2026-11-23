




SSYXWaterRecordItem = {}
SSYXWaterRecordItem.__index = SSYXWaterRecordItem

local objs = {
    desc = {path = "Group/Desc", type = UITool.Text},
    time = {path = "Group/Time", type = UITool.Text}
}

SSYXWaterRecordItem.New = function()

    local self = {}
    setmetatable(self, SSYXWaterRecordItem)
    return self
end

function SSYXWaterRecordItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function SSYXWaterRecordItem:SetData(data)
    self.data = data.data
    self.time.text = os.date("%Y-%m-%d", self.data.CrtTime)
    local lanText = LuaMgr.GetLangText(SSYXConst.LanText.LanText23)
    self.desc.text = string.format(lanText, self.data.Name)
end

function SSYXWaterRecordItem:ClearItems()
end

function SSYXWaterRecordItem:Clear()
    self:ClearItems()
end

function SSYXWaterRecordItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end