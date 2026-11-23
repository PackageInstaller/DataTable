Passes_RewardItem = {};

Passes_RewardItem.__index = Passes_RewardItem;

local objs = {
    goodRoot={path="good",type="Transform"},
    lockObj={path="lock",type="GameObject"},
    rewardedObj={path="rewarded",type="GameObject"},
    redObj={path="red",type="GameObject"},
  
    
}
function Passes_RewardItem.New()
    local self = {};
    setmetatable(self, Passes_RewardItem);
    return self;
end

function Passes_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    
end

function Passes_RewardItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.lockObj,self.data.isLock)
    SetActive(self.rewardedObj,self.data.isRewarded)
    SetActive(self.redObj,self.data.isRed)
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.item.id]
    itemConfig["count0"] = self.data.item.count
    
    local locScale=Vector3.one;
    if self.data.scale~=nil then
        locScale=locScale*self.data.scale;
    end
    self.item:SetData(1,itemConfig,1,false,locScale,true)
   
end
function Passes_RewardItem:Clear()
   self.data=nil
end
function Passes_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

