Simulate_BlessingListRewardItem = {};

Simulate_BlessingListRewardItem.__index = Simulate_BlessingListRewardItem;

local objs = {
    itemTF={path="root/itemTF",type="Transform"},
    goGet={path="root/get",type="GameObject"},
    canvasGroup={path="root/itemTF",type="CanvasGroup"},
}



function Simulate_BlessingListRewardItem.New()
    local self = {};
    setmetatable(self, Simulate_BlessingListRewardItem);
    return self;
end

function Simulate_BlessingListRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Simulate_BlessingListRewardItem:SetData(pdata)
    self.data=pdata.data
    local reward=self.data.item;
    if self.firstRewardVM==nil then
        self.firstRewardVM=GoodsDataItem.New(self.itemTF);
    end
    local itemData = ConfigMgr.Config.itemMap[reward.id];
    itemData.count0 = reward.count;
    self.firstRewardVM:SetData(1, itemData, 1, false, Vector3(0.5,0.5,0.5), false,true);
    SetActive(self.goGet,self.data.isGet)
    self.canvasGroup.alpha=self.data.isGet and 0.6 or 1.0
end


function Simulate_BlessingListRewardItem:Clear()
    self.data=nil
end


function Simulate_BlessingListRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

