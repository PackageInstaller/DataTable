Qin2_RewardItem = {};

Qin2_RewardItem.__index = Qin2_RewardItem;
local objs = {
    goodsTF={ path = "root/good", type = "Transform" },
    rewardedObj={ path = "root/Image", type = "GameObject" }
}

function Qin2_RewardItem.New()
    local self = {};
    setmetatable(self, Qin2_RewardItem);
    self.isActive=false;
    return self;
end

function Qin2_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
  
end

function Qin2_RewardItem:SetData(pdata)
    self.data = pdata.data
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsTF)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.id]
    itemConfig["count0"] = self.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*self.data.scale,false)
    SetActive(self.rewardedObj,self.data.isReward)
end
    


function Qin2_RewardItem:Clear()
    self.data = nil;
end

function Qin2_RewardItem:Destroy()
    self.goodsTF=nil;
    self.rewardedObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end