SawPuzzle_RewardItem = {};

SawPuzzle_RewardItem.__index = SawPuzzle_RewardItem;

local objs = {
    root={path="root",type="Transform"},
    reward={path="reward",type="GameObject"},
}



function SawPuzzle_RewardItem.New()
    local self = {};
    setmetatable(self, SawPuzzle_RewardItem);
    return self;
end


function SawPuzzle_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function SawPuzzle_RewardItem:SetData(pdata)
    self.data=pdata.data
    if self.item==nil then
        self.item=GoodsDataItem.New(self.root);
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.id]
    itemConfig["count0"] = self.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,1),false)
    SetActive(self.reward,self.data.isReward)
end



function SawPuzzle_RewardItem:Clear()
    self.data=nil
end


function SawPuzzle_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.root=nil;
    self.reward=nil;
end

