


SCNJBattlePrepareBuffItem = {}
SCNJBattlePrepareBuffItem.__index = SCNJBattlePrepareBuffItem

local objs = {}

SCNJBattlePrepareBuffItem.New = function()

    local self = {}
    setmetatable(self, SCNJBattlePrepareBuffItem)
    return self
end

function SCNJBattlePrepareBuffItem:BatchInitNode()
    for i = 1, 2 do
        local objName = "BuffItem_" .. i
        local objPath = "Group/" .. objName
        objs[objName] = {path = objPath, type = UITool.GameObject}

        local nameName = "Name" .. i
        local namePath = string.format("%s/Name", objPath)
        objs[nameName] = {path = namePath, type = UITool.Text}

        local iconName = "Icon" .. i
        local iconPath = string.format("%s/Icon", objPath)
        objs[iconName] = {path = iconPath, type = UITool.Image}

        local buttonName = string.format("%s_Button", objName)
        local objPath = "Group/" .. objName
        objs[buttonName] = {path = objPath, type = UITool.Button}
    end
end

function SCNJBattlePrepareBuffItem:Init()
    self:BatchInitNode()
    UITool.Parse(self.gameObject, self, objs)
    self.onClickBuff1 = function()
        local buffData = self.data.buffData1
        if buffData ~= nil then
            LuaMgr.ShowLuaPanel(UIName.SCNJBuffInfoPopup, buffData)
        end
    end

    self.onClickBuff2 = function()
        local buffData = self.data.buffData2
        if buffData ~= nil then
            LuaMgr.ShowLuaPanel(UIName.SCNJBuffInfoPopup, buffData)
        end
    end
    LuaMgr.AddClick(self["BuffItem_1_Button"], self.onClickBuff1)
    LuaMgr.AddClick(self["BuffItem_2_Button"], self.onClickBuff2)
end

function SCNJBattlePrepareBuffItem:SetData(data)
    SetActive(self.gameObject, true)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function SCNJBattlePrepareBuffItem:SetItem()
    local data1 = self.data.buffData1
    local data2 = self.data.buffData2
    SetActive(self["BuffItem_2"], data2 ~= nil)
    if data1 ~= nil then
        self["Name1"].text = data1.Name
        self["Icon1"].sprite = LuaMgr.GetSprite(SCNJConst.BuffIconAtlaName, data1.BuffIcon)
    end
    if data2 ~= nil then
        self["Name2"].text = data2.Name
        self["Icon2"].sprite = LuaMgr.GetSprite(SCNJConst.BuffIconAtlaName, data2.BuffIcon)
    end
end

function SCNJBattlePrepareBuffItem:ClearItems()
end

function SCNJBattlePrepareBuffItem:Clear()
    self:ClearItems()
end

function SCNJBattlePrepareBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end