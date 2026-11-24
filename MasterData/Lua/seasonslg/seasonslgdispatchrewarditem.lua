SeasonSLGDispatchRewardItem = {};

SeasonSLGDispatchRewardItem.__index = SeasonSLGDispatchRewardItem;
local objs = {
    isDoneObj={ path = "doneMask", type = "GameObject" },
    rewardItem = { path = "GoodsItem", type = "GoodsViewModel" },
};

function SeasonSLGDispatchRewardItem.New()
    local self = {};
    setmetatable(self, SeasonSLGDispatchRewardItem);
    return self;
end

function SeasonSLGDispatchRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function SeasonSLGDispatchRewardItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end


    SetActive(self.isDoneObj,false)
    if self.rewardItem ~= nil then
        self.rewardItem:SetData(self.data.ItemId, self.data.ItemCount, 1, 0.6, true)
    end
end

function SeasonSLGDispatchRewardItem:Clear()
    self.data = nil;
end

function SeasonSLGDispatchRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end