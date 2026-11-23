

















CommonToggleItem = {}
CommonToggleItem.__index = CommonToggleItem

local objs = {
    toggle = {path = "", type = UITool.Toggle},
    nocheckText = {path = "Background/NoCheckText", type = UITool.Text},
    checkText = {path = "Background/Checkmark/CheckText", type = UITool.Text},
    checkMarkObj = {path = "Background/Checkmark", type = UITool.GameObject}
}
function CommonToggleItem.New(prefab, parent, isInstantiate, index, callback, toggleGroup)

    local self = {}
    setmetatable(self, CommonToggleItem)
    self.callback = callback
    self.index = index
    if isInstantiate then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    else
        self.gameObject = prefab
    end
    self.toggleGroup = toggleGroup
    self:Init()
    SetActive(self.gameObject, true)
    return self
end

function CommonToggleItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    if self.toggleGroup ~= nil then
        self.toggle.group = self.toggleGroup
    end
    self.noCheckBG = self.gameObject.transform:Find("Background/NoCheckBG")
    local callback = function(value)
        if self.callback ~= nil then
            self.callback(self.index, value)
        end
    end
    self.toggle.onValueChanged:AddListener(callback)
end

function CommonToggleItem:SetData(data)
    self.data = data.data
    if self.data == nil and data ~= nil then
        self.data = data
    end
    if not self.data.noSetText then
        self:SetText()
    end
end

function CommonToggleItem:SetText()
    if IsObjectNull(self.nocheckText) == false and self.data.nocheckText ~= nil then
        self.nocheckText.text = self.data.nocheckText
    end
    if IsObjectNull(self.checkText) == false and self.data.checkText ~= nil then
        self.checkText.text = self.data.checkText
    end
end

function CommonToggleItem:SetIsOn(value)
    SetActive(self.checkMarkObj, self.toggle.isOn == true)
    SetActive(self.nocheckText.gameObject, self.toggle.isOn == false)
    if self.noCheckBG ~= nil then
        SetActive(self.noCheckBG.gameObject, self.toggle.isOn == false)
    end
end