TeamRelay2DelegateResultItem = {}

TeamRelay2DelegateResultItem.__index = TeamRelay2DelegateResultItem

local objs = {
    animGo = { path = "Group", type = UITool.GameObject },
    indexTxt = { path = "Group/Index", type = UITool.Text },
    valueTxt = { path = "Group/Value", type = UITool.Text },
}

function TeamRelay2DelegateResultItem.New()
    local self = {}
    setmetatable(self, TeamRelay2DelegateResultItem)
    return self
end

function TeamRelay2DelegateResultItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.animGo, false)
end

function TeamRelay2DelegateResultItem:SetData(pdata)
    self.data = pdata.data
    self.indexTxt.text = tostring(self.data.index)
    self.valueTxt.text = tostring(self.data.value)
    SetActive(self.animGo, self.data.animBool)
end

function TeamRelay2DelegateResultItem:Clear()
    SetActive(self.animGo, false)
    self.data = nil
end

function TeamRelay2DelegateResultItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end