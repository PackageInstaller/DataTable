Delegate_GoodsItemGroup = {};

Delegate_GoodsItemGroup.__index = Delegate_GoodsItemGroup;

local objs = {
    goodRoot={path = "_good", type = "Transform"},
    tagRate={path="tag_rate",type="GameObject"},
}

function Delegate_GoodsItemGroup.New()
    local self = {};
    setmetatable(self, Delegate_GoodsItemGroup);
    return self;
end

function Delegate_GoodsItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function Delegate_GoodsItemGroup:SetData(pdata)
    self.data=pdata
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[pdata.data.id]
    itemConfig["count0"] = pdata.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
    SetActive(self.tagRate,pdata.data.isPossible)
end

function Delegate_GoodsItemGroup:Clear()
    self.data=nil
end


function Delegate_GoodsItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.item=nil
    self.goodRoot=nil
    self.tagRate=nil
    self.gameObject = nil;
end

