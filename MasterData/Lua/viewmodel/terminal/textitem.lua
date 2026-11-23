





TextItem = {}
TextItem.__index = TextItem

TextItem.New = function(container,prefab)
    local self = {}
    setmetatable(self, TextItem)
    self.object = LuaMgr.InstantiateGO(prefab)
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.text = self.transform:GetComponent("Text")
    return self
end

function TextItem:SetData(data)
    self.text.text = data
    local preferredHeight = self.text.preferredHeight
    self.transform.sizeDelta = Vector2(self.text.transform.sizeDelta.x,preferredHeight)
    self.object.gameObject:SetActive(true)
end

function TextItem:Hide()
    self.text.text = ""
    self.object.gameObject:SetActive(false)
end

function TextItem:Clear()
    self.text = nil
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end