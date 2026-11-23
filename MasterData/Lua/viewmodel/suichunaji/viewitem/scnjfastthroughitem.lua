


SCNJFastThroughItem = {}
SCNJFastThroughItem.__index = SCNJFastThroughItem

local objs = {
    teamNumber = {path = "TeamNumber", type = UITool.Text},
    scoreText = {path = "ScoreText", type = UITool.Text},
}

SCNJFastThroughItem.New = function()

    local self = {}
    setmetatable(self, SCNJFastThroughItem)
    return self
end

function SCNJFastThroughItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function SCNJFastThroughItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function SCNJFastThroughItem:SetItem()
    self.teamNumber.text = self.data.IndexName
    self.scoreText.text = tostring(self.data.Score)
end

function SCNJFastThroughItem:ClearItems()
end

function SCNJFastThroughItem:Clear()
    self:ClearItems()
end

function SCNJFastThroughItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end