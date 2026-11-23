TeamRelay2BuffItem = {}

TeamRelay2BuffItem.__index = TeamRelay2BuffItem

local objs = {
    ClickBtn = { path = "Group/Bg_1", type = UITool.Button },
    bgGo_2 = { path = "Group/Bg_2", type = UITool.GameObject },
    buffIcon = { path = "Group/Icon", type = UITool.Image },
    buffName = { path = "Group/Name", type = UITool.Text },
}

function TeamRelay2BuffItem.New()
    local self = {}
    setmetatable(self, TeamRelay2BuffItem)
    return self
end

function TeamRelay2BuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        if self.data.buffDescId ~= nil then
            LuaMgr.ShowLuaPanel(UIName.TeamRelay2BuffDetailPopup, self.data.buffDescId);
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem)
end

function TeamRelay2BuffItem:SetData(pdata)
    self.data = pdata.data
    self.buffIcon.sprite = self.data.icon
    self.buffName.text = self.data.name
    SetActive(self.bgGo_2, self.data.iconType == 1)
    SetActive(self.gameObject, true)
end

function TeamRelay2BuffItem:Clear()
    self.data = nil
end

function TeamRelay2BuffItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end