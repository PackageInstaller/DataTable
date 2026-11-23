




CGTitleModel = {}

CGTitleModel.__index = CGTitleModel

local objs = {
    text = {path = "Text",type = "Text"},
}

function CGTitleModel.New()
    local self = {}
    setmetatable(self, CGTitleModel)
    return self
end

function CGTitleModel:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function CGTitleModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    if self.data.titleStr == 0 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5600"].NameLan) end
    if self.data.titleStr == 101 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5601"].NameLan) end
    if self.data.titleStr == 102 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5602"].NameLan) end
    if self.data.titleStr == 103 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5603"].NameLan) end
    if self.data.titleStr == 104 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5604"].NameLan) end
    if self.data.titleStr == 105 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5605"].NameLan) end
    if self.data.titleStr == 106 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5606"].NameLan) end
    if self.data.titleStr == 107 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5607"].NameLan) end
    if self.data.titleStr == 201 then self.text.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5701"].NameLan) end
end

function CGTitleModel:Clear()
    self.data = nil
end

function CGTitleModel:Destroy()
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end