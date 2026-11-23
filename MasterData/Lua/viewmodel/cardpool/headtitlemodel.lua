





HeadTitleModel = {}

HeadTitleModel.__index = HeadTitleModel

local objs = {
    up = {path = "Up",type = "GameObject"},
    upText = {path = "Up/Text",type = "Text"},
    star = {path = "Star",type = "GameObject"},
    starText = {path = "Star/Text",type = "Text"},
}

function HeadTitleModel.New()
    local self = {}
    setmetatable(self, HeadTitleModel)
    return self
end

function HeadTitleModel:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function HeadTitleModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    SetActive(self.up,self.data.type == 1)
    self.upText.text = self:SetRareStr()
    SetActive(self.star,self.data.type ~= 1)
    self.starText.text = self:SetRareStr()
end

function HeadTitleModel:SetRareStr()
    if self.data.type == 1 then
        return LuaMgr.GetLangText("HeadTitleModel_0")
    elseif self.data.type == 2 then
        self.starText.color = UnityEngine.Color(210 / 225, 56 / 225, 55 / 225, 1)
        return LuaMgr.GetLangText("HeadTitleModel_1")
    elseif self.data.type == 3 then
        self.starText.color = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1)
        return LuaMgr.GetLangText("HeadTitleModel_2")
    elseif self.data.type == 4 then
        self.starText.color = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1)
        return LuaMgr.GetLangText("HeadTitleModel_3")
    end
end

function HeadTitleModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function HeadTitleModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end