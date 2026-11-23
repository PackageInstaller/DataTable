




MonsterTitleModel = {}

MonsterTitleModel.__index = MonsterTitleModel

local objs = {
    text = {path = "Text",type = "Text"},
}

function MonsterTitleModel.New()
    local self = {}
    setmetatable(self, MonsterTitleModel)
    return self
end

function MonsterTitleModel:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function MonsterTitleModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    self.text.text = self.data.titleStr
end

function MonsterTitleModel:Clear()
    self.data = nil
end

function MonsterTitleModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end