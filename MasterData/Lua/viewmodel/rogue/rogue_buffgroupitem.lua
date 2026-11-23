require("ViewModel/Rogue/Rogue_BagBuffItem")

Rogue_BuffGroupItem = {}
Rogue_BuffGroupItem.__index = Rogue_BuffGroupItem
function Rogue_BuffGroupItem.New()
    local self = {};
    setmetatable(self, Rogue_BuffGroupItem);
    return self;
end

function Rogue_BuffGroupItem:Init()
    self.CloneItem = {};
    self.transform = self.gameObject:GetComponent("RectTransform");
    return self
end

function Rogue_BuffGroupItem:SetData(data)
    self.data = data.data;
    for i = 1, #self.data, 1 do
        if i > #self.CloneItem then
            local obj = LuaMgr.InstantiateGO(self.data[i].prefab)
            local objTF = obj.transform
            objTF:SetParent(self.transform, false)
            local temp = Rogue_BagBuffItem.New()
            temp.gameObject = obj
            temp.transform = objTF
            temp:Init()
            table.insert(self.CloneItem, temp);
        end
        self.CloneItem[i]:SetData(self.data[i]);
    end
    for i = #self.data + 1, #self.CloneItem, 1 do
        self.CloneItem[i]:Clear();
    end
end

function Rogue_BuffGroupItem:SetSelect(selectIndex)
    for i = 1, #self.data, 1 do
        self.CloneItem[i]:SetSelect(self.data[i].data.index == selectIndex)
    end
end

function Rogue_BuffGroupItem:Clear()
    SetActive(self.gameObject, false);
end

function Rogue_BuffGroupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
end