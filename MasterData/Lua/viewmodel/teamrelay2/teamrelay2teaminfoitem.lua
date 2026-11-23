TeamRelay2TeamInfoItem = {}

TeamRelay2TeamInfoItem.__index = TeamRelay2TeamInfoItem

local objs = {
    animGo = { path = "Group", type = UITool.GameObject },
    BgGo_1 = { path = "Group/Bg_1", type = UITool.GameObject },
    Name_1 = { path = "Group/Bg_1/Name", type = UITool.Text },
    Text_1 = { path = "Group/Bg_1/Text", type = UITool.Text },
    BgGo_2 = { path = "Group/Bg_2", type = UITool.GameObject },
    Name_2 = { path = "Group/Bg_2/Name", type = UITool.Text },
    Text_2 = { path = "Group/Bg_2/Text", type = UITool.Text },
}

function TeamRelay2TeamInfoItem.New(obj)
    local self = {}
    setmetatable(self, TeamRelay2TeamInfoItem)
    if obj then
        self.gameObject = obj
        self:Init()
    end
    return self
end

function TeamRelay2TeamInfoItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.animGo, false)
end

function TeamRelay2TeamInfoItem:SetData(pdata)
    self.data = pdata
    self.Name_1.text = self.data.name
    self.Name_2.text = self.data.name
    self.Text_1.text = self.data.value
    self.Text_2.text = self.data.value
    SetActive(self.BgGo_1, not self.data.isSelected)
    SetActive(self.BgGo_2, self.data.isSelected)
    SetActive(self.animGo, self.data.animBool)
end

function TeamRelay2TeamInfoItem:Clear()
    SetActive(self.animGo, false)
    self.data = nil
end

function TeamRelay2TeamInfoItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end