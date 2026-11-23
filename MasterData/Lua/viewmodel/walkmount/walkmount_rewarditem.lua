WalkMount_RewardItem = {};

WalkMount_RewardItem.__index = WalkMount_RewardItem;
local objs = {
    textName={ path = "name", type = "Text" },
    goodsRoot = { path = "goods", type = "Transform" },
    rewardedObj = { path = "rewarded", type = "GameObject" },
}

function WalkMount_RewardItem.New()
    local self = {};
    setmetatable(self, WalkMount_RewardItem);
    return self;
end

function WalkMount_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.LotteryMap=ConfigMgr.Config.LotteryMap
end

function WalkMount_RewardItem:SetData(pdata)
    self.data = pdata;
    local rewardData=self.LotteryMap[pdata.data.id]
    self.textName.text=LuaMgr.GetLangText("WalkMount_RewardItem_0")..LuaMgr.GetLangText(rewardData.NameLan)..LuaMgr.GetLangText("WalkMount_RewardItem_1")
    local reward=rewardData.Reward[1]
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
    SetActive(self.rewardedObj,not pdata.data.isRewarded)
end




function WalkMount_RewardItem:Clear()
    self.data = nil;
end

function WalkMount_RewardItem:Destroy()
    self.textName=nil;
    self.goodsRoot=nil;
    self.rewardedObj=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
end