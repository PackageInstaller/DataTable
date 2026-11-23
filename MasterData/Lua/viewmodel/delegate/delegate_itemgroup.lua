Delegate_ItemGroup = {};

Delegate_ItemGroup.__index = Delegate_ItemGroup;

local objs = {
    itemRoot={path="itemRoot",type="Transform"},
}
function Delegate_ItemGroup.New()
    local self = {};
    setmetatable(self, Delegate_ItemGroup);
    return self;
end

function Delegate_ItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Delegate_ItemGroup:SetData(pdata)
    self.data = pdata;
    if NumTool.GetLen(pdata.data)==0 then return end;
    local item=GoodsDataItem.New(self.itemRoot)
    if pdata.data.type==1 then
        local itemConfig = ConfigMgr.Config.itemMap[pdata.data.id]
        itemConfig["count0"] = pdata.data.count
        item:SetData(1,itemConfig,pdata.data.type,false,Vector3(0.6,0.6,0.6),false)
    elseif pdata.data.type==2 then
        item:SetData(1,pdata.data,pdata.data.type,false,Vector3(0.6,0.6,0.6),false)
    end
    SetActive(itemRoot.gameObject,false)
end
function Delegate_ItemGroup:Clear()
    SetActive(itemRoot.gameObject,true)
end

function Delegate_ItemGroup:SetActive()
    
end



function Delegate_ItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end