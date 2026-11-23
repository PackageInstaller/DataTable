DHSurveyDrawRewardItem = {};

DHSurveyDrawRewardItem.__index = DHSurveyDrawRewardItem;

local objs = {
    iconGet = { path = "IconGet", type = "GameObject" },
    rewardTras = { path = "RewardTras", type = "Transform" },
};

function DHSurveyDrawRewardItem.New()
    local self = {};
    setmetatable(self, DHSurveyDrawRewardItem);   
    return self;
end

function DHSurveyDrawRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemReward = GoodsDataItem.New(self.rewardTras);
end

function DHSurveyDrawRewardItem:SetData(_data)
    local data = _data.data
    local showGet = PlayerDHMgr.CheckCurDrawMapReward(data.Type,data.Id)
    SetActive(self.iconGet,showGet)   
    local scale = Vector3(0.49, 0.49, 1);
    local itemData = table.Copy(ConfigMgr.Config.itemMap[data.Reward[1].id]);
    itemData.count0 = data.Reward[1].count;
    self.itemReward:SetData(1, itemData, 1, false, scale, false, false);    
    self.itemReward:SetIconBg(false);
    self.gameObject.name = data.Id
end

function DHSurveyDrawRewardItem:Clear()
    
end

function DHSurveyDrawRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end