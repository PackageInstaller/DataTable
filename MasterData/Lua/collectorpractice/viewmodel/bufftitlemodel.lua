





BuffTitleModel = {}

BuffTitleModel.__index = BuffTitleModel

local objs = {
    text = {path = "Text",type = "Text"},
}

function BuffTitleModel.New()
    local self = {}
    setmetatable(self, BuffTitleModel)
    return self
end

function BuffTitleModel:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function BuffTitleModel:SetData(data)
    self.data = data.data
    self.text.text = self.data.titleStr
end

function BuffTitleModel:Clear()
    self.data = nil
end

function BuffTitleModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end