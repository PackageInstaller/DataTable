
UIPracticeShopGroupItem = {}
UIPracticeShopGroupItem.__index = UIPracticeShopGroupItem
require("CollectorPractice/Common/UIPracticeShopItem")
function UIPracticeShopGroupItem.New()
    local self = {};
    setmetatable(self, UIPracticeShopGroupItem);
    return self;
end

function UIPracticeShopGroupItem:Init()
    self.CloneItem={};
    self.transform=self.gameObject:GetComponent("RectTransform");
    return self
end




















function UIPracticeShopGroupItem:SetData(data)
    self.data=data.data;
    for i = 1, #self.data, 1 do
        if i>#self.CloneItem then
            local temp=UIPracticeShopItem.New(self.data[i].prefab,self.transform)
            table.insert(self.CloneItem,temp);
        end
        self.CloneItem[i]:SetData(self.data[i]);
    end
    for i = #self.data+1,#self.CloneItem , 1 do
        self.CloneItem[i]:Clear();
    end
end

function UIPracticeShopGroupItem:ShowAnimation()
    for index, value in ipairs(self.CloneItem) do
        value:ShowAnimation();
    end
end

function UIPracticeShopGroupItem:Clear()
    SetActive(self.gameObject, false);
end

function UIPracticeShopGroupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
end