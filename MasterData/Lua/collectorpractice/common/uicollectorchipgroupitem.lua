
UICollectorChipGroupItem = {}
UICollectorChipGroupItem.__index = UICollectorChipGroupItem
require("CollectorPractice/Common/UICollectorChipItem")
function UICollectorChipGroupItem.New()
    local self = {};
    setmetatable(self, UICollectorChipGroupItem);
    return self;
end

function UICollectorChipGroupItem:Init()
    self.CloneItem={};
    self.transform=self.gameObject:GetComponent("RectTransform");
    return self
end






function UICollectorChipGroupItem:SetData(data)
    self.data=data.data;
    for i = 1, #self.data, 1 do
        if i>#self.CloneItem then
            local temp=UICollectorChipItem.New(self.transform)
            table.insert(self.CloneItem,temp);
        end
        local tempData={};
        table.insert(tempData,self.data[i].id);
        table.insert(tempData,1);
        self.CloneItem[i]:SetData(tempData,true,false);
    end
    for i = #self.data+1,#self.CloneItem , 1 do
        self.CloneItem[i]:Clear();
    end
end


function UICollectorChipGroupItem:ShowDissolveAnimation()
    for index, value in ipairs(self.data) do
        if value.isTran then
            self.CloneItem[index]:ShowDissolveAnimation()
        end
    end
end

function UICollectorChipGroupItem:ResetAnimation()
    for index, value in ipairs(self.data) do
        self.CloneItem[index]:ResetAnimation()
    end
end

function UICollectorChipGroupItem:Clear()
    SetActive(self.gameObject, false);
end

function UICollectorChipGroupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
end