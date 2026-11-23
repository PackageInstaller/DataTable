




DelegatedItem = {}
DelegatedItem.__index = DelegatedItem

DelegatedItem.FlagName = {
    [2] = "RepeatFlag",
    [3] = "GameFlag",
    [4] = "MainStoryFlag"
}
local objs = {
    clickBtn = {path = "", type = UITool.Button},
    selectedObj = {path = "Group/SelectGroup", type = UITool.GameObject},
    unSelectedObj = {path = "Group/UnSelectGroup", type = UITool.GameObject},
    name = {path = "Group/Name", type = UITool.Text}
}

function DelegatedItem.New()

    local self = {}
    setmetatable(self, DelegatedItem)
    return self
end

function DelegatedItem:Init()
    for key, value in pairs(DelegatedItem.FlagName) do
        local data1 = {}
        data1.path = "Group/SelectGroup/" .. value
        data1.type = UITool.GameObject
        local name1 = "select" .. value
        objs[name1] = data1

        local data2 = {}
        data2.path = "Group/UnSelectGroup/" .. value
        data2.type = UITool.GameObject
        local name2 = "unselect" .. value
        objs[name2] = data2
    end
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject.transform
    local onClickItem = function()
        if self.data.clickCallback ~= nil then
            self.data.clickCallback(self)
        end
    end
    LuaMgr.AddClick(self.clickBtn, onClickItem)
end

function DelegatedItem:SetData(data)
    self.data = data.data
    for key, value in pairs(DelegatedItem.FlagName) do
        local name1 = "select" .. value
        SetActive(self[name1], key == self.data.type)
        local name2 = "unselect" .. value
        SetActive(self[name2], key == self.data.type)
    end
    self.name.text = self.data.name
    self:SetSelected()
end

function DelegatedItem:SetSelected()
    local curSelectedID = ManagementData.GetDelegateSeletedID()
    SetActive(self.selectedObj, curSelectedID == self.data.ID)
    SetActive(self.unSelectedObj, curSelectedID ~= self.data.ID)
end

function DelegatedItem:Clear()
    self.data = nil
end

function DelegatedItem:Destroy()
    LuaMgr.Destroy(self.gameObject)
    self.data = nil
    self.gameObject = nil
end