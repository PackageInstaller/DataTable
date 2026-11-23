







SSYXEmployingItem = {}
SSYXEmployingItem.__index = SSYXEmployingItem

local objs = {
    button = {path = "", type = UITool.Button},
    employeeInfo = {path = "Group/EmployeeInfo", type = UITool.Transform},
    heroIcon = {path = "Group/EmployeeInfo/Icon", type = UITool.RawImage},
    heroLevel = {path = "Group/EmployeeInfo/Level", type = UITool.Text},
    noneObj = {path = "Group/NoneObj", type = UITool.GameObject},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject}
}

SSYXEmployingItem.New = function(obj)

    local self = {}
    setmetatable(self, SSYXEmployingItem)
    if obj ~= nil then
        self.gameObject = obj
        self:Init()
    end
    return self
end

function SSYXEmployingItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data.OnClickGridCallback ~= nil then
            self.data.OnClickGridCallback(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickBtn)
end

function SSYXEmployingItem:SetData(data)
    self.data = data
    if self.data == nil then
        return
    end
    SetActive(self.employeeInfo.gameObject, self.data.IsEmploying == true)
    SetActive(self.noneObj, self.data.IsEmploying == false and self.data.IsUnlock == true)
    SetActive(self.lockObj, self.data.IsUnlock == false)
    if self.data.IsEmploying == true then
        self.heroIcon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data.EmployingData.ID, self.data.EmployingData.ID .. "001"))
        self.heroLevel.text = string.format("lv.%s", self.data.EmployingData.Level)
    end
end

function SSYXEmployingItem:ClearItems()
end

function SSYXEmployingItem:Clear()
    self:ClearItems()
end

function SSYXEmployingItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end