
UITrammelsGroupItem = {}
UITrammelsGroupItem.__index = UITrammelsGroupItem
require("CollectorPractice/Common/UITrammelsItem")
function UITrammelsGroupItem.New()
    local self = {};
    setmetatable(self, UITrammelsGroupItem);
    return self;
end

function UITrammelsGroupItem:Init()
    self.CloneItem={};
    self.transform=self.gameObject:GetComponent("RectTransform");
    return self
end

function UITrammelsGroupItem:SetData(data)
    self.data=data.data;
    for i = 1, #self.data, 1 do
        if i>#self.CloneItem then
            local temp=UITrammelsItem.New(self.data[i].prefab,self.transform)
            table.insert(self.CloneItem,temp);
        end
        self.CloneItem[i]:SetData(self.data[i]);
    end
    for i = #self.data+1,#self.CloneItem , 1 do
        self.CloneItem[i]:Clear();
    end
end


function UITrammelsGroupItem:Clear()
    SetActive(self.gameObject, false);
end

function UITrammelsGroupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
end