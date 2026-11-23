





EquipAttrGroup = {}

EquipAttrGroup.__index = EquipAttrGroup

function EquipAttrGroup.New()
    local self = {}
    setmetatable(self, EquipAttrGroup)
    return self
end

function EquipAttrGroup:Init()
    self.itemList = {}
end

function EquipAttrGroup:SetData(data)
    self.data = data.data
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.attrs do
        if i > #self.itemList then
            tempItem = EquipAttrItem.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * 240 + 8
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.attrs[i],self.data.callback,self.data.attrOptions)
    end
end

function EquipAttrGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function EquipAttrGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end