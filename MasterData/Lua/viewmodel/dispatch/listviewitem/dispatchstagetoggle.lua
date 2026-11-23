















DispatchStageToggle = {}
DispatchStageToggle.__index = DispatchStageToggle

local objs = {
    toggle = {path = "", type = UITool.Toggle},
    nocheckText = {path = "Background/NoCheckText", type = UITool.Text},
    checkText = {path = "Background/Checkmark/CheckText", type = UITool.Text},
    checkMarkObj = {path = "Background/Checkmark", type = UITool.GameObject}
}
function DispatchStageToggle.New(prefab, parent, isInstantiate, index, callback)
    local self = {}
    setmetatable(self, DispatchStageToggle)
    self.callback = callback
    self.index = index
    if isInstantiate then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        self:Init()
    end
    SetActive(self.gameObject, true)
    return self
end

function DispatchStageToggle:Init()
    UITool.Parse(self.gameObject, self, objs)
    local callback = function(value)
        if self.callback ~= nil then
            self.callback(self.index, value)
        end
    end
    self.toggle.onValueChanged:AddListener(callback)
end

function DispatchStageToggle:SetData(data)
    self.data = data.data
    if self.data == nil and data ~= nil then
        self.data = data
    end
    self.nocheckText.text = self.data.nocheckText
    self.checkText.text = self.data.checkText
end

function DispatchStageToggle:SetIsOn(value)
    SetActive(self.checkMarkObj, self.toggle.isOn == true)
    SetActive(self.nocheckText.gameObject, self.toggle.isOn == false)
end