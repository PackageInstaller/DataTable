





InsetItem = {}
InsetItem.__index = InsetItem

InsetItem.New = function(container,prefab)
    local self = {}
    setmetatable(self, InsetItem)
    self.object = LuaMgr.InstantiateGO(prefab)
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.rawImage = self.transform:GetComponent("RawImage")
    return self
end

function InsetItem:SetData(data)
    self.rawImage.texture = LuaMgr.GetTexture(Path.NovelCgPath..data..".png")
    self.object.gameObject:SetActive(true)
end

function InsetItem:Hide()
    self.rawImage.texture = nil
    self.object.gameObject:SetActive(false)
end

function InsetItem:Clear()
    self.rawImage = nil
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end