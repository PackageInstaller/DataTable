SeasonSLGBuffFixItem = {}

SeasonSLGBuffFixItem.__index = SeasonSLGBuffFixItem

local function FindComponent(gameObject, path, componentName)
    if gameObject == nil or path == nil then
        return nil
    end
    local transform = gameObject.transform:Find(path)
    if transform == nil then
        return nil
    end
    return transform:GetComponent(componentName)
end

SeasonSLGBuffFixItem.New = function()
    local self = {}
    setmetatable(self, SeasonSLGBuffFixItem)
    return self
end

function SeasonSLGBuffFixItem:Init()
    SetActive(self.gameObject, true)
    self.buffIcon = FindComponent(self.gameObject, "buffIcon", "Image")
    self.txtBuffDesc = FindComponent(self.gameObject, "buffDesc", "Text")
end

function SeasonSLGBuffFixItem:SetData(pdata)
    local data = pdata.data
    if self.buffIcon ~= nil then
        self.buffIcon.sprite = data.buffIcon
    end
    if self.txtBuffDesc ~= nil then
        self.txtBuffDesc.text = data.buffDesc
    end
end

function SeasonSLGBuffFixItem:Clear()
end

function SeasonSLGBuffFixItem:Destroy()
    self.buffIcon = nil
    self.txtBuffDesc = nil
end