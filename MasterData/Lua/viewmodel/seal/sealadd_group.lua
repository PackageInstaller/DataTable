SealAdd_Group = {};

SealAdd_Group.__index = SealAdd_Group;
local objs = {
    
}

function SealAdd_Group.New()
    local self = {};
    setmetatable(self, SealAdd_Group);
    self.isActive=false;
    return self;
end

function SealAdd_Group:Init()
    UITool.Parse(self.gameObject, self, objs);
    require("ViewModel/Seal/SealAdd_GroupItem")
    self.UIList=UIListView.New(self.transform)
   
end




function SealAdd_Group:SetData(pdata)
    self.data = pdata.data
    self.UIList:Clear();
    local list={}
    for i,v in ipairs(self.data) do
        local item={
            itemData=v;
        }
        local itemData=UIListData.GetData(v.itemObj,"SealAdd_GroupItem",item)
        table.insert(list,itemData)
    end
    self.UIList:SetData(list);
    
end



function SealAdd_Group:Clear()
    self.data = nil;
    self.UIList:Clear();
end

function SealAdd_Group:Destroy()
   
    LuaMgr.DestroyImmediateGO(self.gameObject);
end