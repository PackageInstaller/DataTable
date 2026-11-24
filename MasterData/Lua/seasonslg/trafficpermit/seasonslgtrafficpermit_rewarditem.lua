SeasonSLGTrafficPermit_RewardItem = {};

SeasonSLGTrafficPermit_RewardItem.__index = SeasonSLGTrafficPermit_RewardItem;

local objs = {
    goodRoot={path="good",type="Transform"},
    lockObj={path="lock",type="GameObject"},
    rewardedObj={path="rewarded",type="GameObject"},
    redObj={path="red",type="GameObject"},
    alphaCanvas={path="good",type="CanvasGroup"},
}

function SeasonSLGTrafficPermit_RewardItem.New()
    local self = {};
    setmetatable(self, SeasonSLGTrafficPermit_RewardItem);
    return self;
end

function SeasonSLGTrafficPermit_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function SeasonSLGTrafficPermit_RewardItem:SetData(pdata)
    self.data=pdata.data
    self.alphaCanvas.alpha=self.data.alpha
    SetActive(self.lockObj,self.data.isLock)
    SetActive(self.rewardedObj,self.data.isRewarded)
    SetActive(self.redObj,self.data.isRed)
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.item.id]
    itemConfig["count0"] = self.data.item.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.6,0.6,0.6),true)
end

function SeasonSLGTrafficPermit_RewardItem:Clear()
   self.data=nil
end

function SeasonSLGTrafficPermit_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end