TaskRewardItem = {};

TaskRewardItem.__index = TaskRewardItem;
local objs = {
    isDoneObj={ path = "done", type = "GameObject" },
    rewardItem = { path = "GoodsItem", type = "GoodsViewModel" },
};

function TaskRewardItem.New()
    local self = {};
    setmetatable(self, TaskRewardItem);
    return self;
end

function TaskRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function TaskRewardItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    SetActive(self.isDoneObj, self.data.currentProgress ~= nil and self.data.currentProgress >= self.data.targetProgress)
    if self.rewardItem ~= nil then
        local reward = self.data.reward
        if reward == nil and self.data.config ~= nil and self.data.config.Reward ~= nil then
            reward = self.data.config.Reward[1]
        end
        if reward ~= nil then
            self.rewardItem:SetData(reward.id, reward.count, 1, 0.6, false)
        end
    end
end

function TaskRewardItem:Clear()
    self.data = nil;
end

function TaskRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end