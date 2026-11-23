




EquipGroupModel = {}

EquipGroupModel.__index = EquipGroupModel

function EquipGroupModel.New()
    local self = {}
    setmetatable(self, EquipGroupModel)
    return self
end

function EquipGroupModel:Init()
    self.itemList = {}
end

function EquipGroupModel:SetData(data)
    self.data = data.data
    self.transform.sizeDelta = Vector2(data.width,self.transform.sizeDelta.y)
    local tempItem = nil
    local posx = 0
    for i = 1, #self.data.equip do
        if i > #self.itemList then
            tempItem = EquipItemModel.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        posx = (i - 1) * (128 + self.data.spaceX)
        self.itemList[i].transform.anchoredPosition = Vector2(posx, 0)
        self.itemList[i]:SetData(self.data.equip[i])
    end
end

function EquipGroupModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function EquipGroupModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end