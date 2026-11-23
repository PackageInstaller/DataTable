




EquipExchangeGroup = {}

EquipExchangeGroup.__index = EquipExchangeGroup

function EquipExchangeGroup.New()
    local self = {}
    setmetatable(self, EquipExchangeGroup)
    return self
end

function EquipExchangeGroup:Init()
    self.itemList = {}
end

function EquipExchangeGroup:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.equip do
        if i > #self.itemList then
            tempItem = EquipExchangeItem.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (102 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, -2)
        self.itemList[i]:SetData(self.data.equip[i],data.id)
    end
end

function EquipExchangeGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function EquipExchangeGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end