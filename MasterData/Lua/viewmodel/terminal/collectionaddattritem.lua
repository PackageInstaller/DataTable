





CollectionAddAttrItem = {}

CollectionAddAttrItem.__index = CollectionAddAttrItem

local objs = {
    attrIcon = {path = "AttrIcon", type = "Image"},
    attrName = {path = "AttrName", type = "Text"},
    attrValue = {path = "AttrValue", type = "Text"},
    notMax = {path = "NotMax", type = "GameObject"},
    isMax = {path = "IsMax", type = "GameObject"},
    infinite = {path = "Infinite", type = "GameObject"},
    isClick = {path = "Btn", type = "Button"},
}

function CollectionAddAttrItem.New(prefab, parent)
    local self = {}
    setmetatable(self, CollectionAddAttrItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.clickCommand = function()
        if self.callback ~= nil then
            self.callback(self.data,self.sort,self.transform.position)
        end
    end
    LuaMgr.AddClick(self.isClick,self.clickCommand)
    return self
end

function CollectionAddAttrItem:SetData(data,callback)
    self.data = data
    self.callback = callback
    self.attrIcon.sprite = LuaMgr.GetSprite("AttributeIcon",self.data.icon)
    self.attrName.text = self.data.name
    self.attrValue.text = "+"..self.data.value..self.data.type
    
    self.sort = ConfigMgr.Config.BestiarySSortMap[self.data.icon]
    if not TableIsNull(self.sort) then
        SetActive(self.infinite,self.sort.MaxValue <= 0)
        SetActive(self.notMax,self.sort.MaxValue > 0 and self.data.value < self.sort.MaxValue)
        SetActive(self.isMax,self.sort.MaxValue > 0 and self.data.value >= self.sort.MaxValue)
    end
    self.gameObject:SetActive(true)
end

function CollectionAddAttrItem:Clear()
    self.data = nil
    self.callback = nil
    self.sort = nil
    self.gameObject:SetActive(false)
end

function CollectionAddAttrItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.isClick, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end