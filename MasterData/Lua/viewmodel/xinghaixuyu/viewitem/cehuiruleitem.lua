





CeHuiRuleItem = {}
CeHuiRuleItem.__index = CeHuiRuleItem

CeHuiRuleItem.IconCache = {}

local objs = {
    name = {path = "Name", type = UITool.Text},
    animator = {path = "", type = UITool.Animator}
}
local maxRewardCount = 2
function CeHuiRuleItem.New(item, index)
    local self = {}
    setmetatable(self, CeHuiRuleItem)
    self.gameObject = item
    self.index = index
    self.rewardCountIcons = {}
    for i = 1, maxRewardCount do
        local name = "Reward" .. i
        local path = "RewardGroup/" .. name
        local data = {path = path, type = UITool.GameObject}
        objs[name] = data
    end
    UITool.Parse(self.gameObject, self, objs)
    for i = 1, maxRewardCount do
        local name = "Reward" .. i
        local obj = self[name]
        local rewardCountIcon = CommonItemCountIcon.New(obj, i)
        self.rewardCountIcons[i] = rewardCountIcon
    end
    return self
end

function CeHuiRuleItem:SetData(data)
    self.data = data
    for i = 1, maxRewardCount do
        local rewardCountIcon = self.rewardCountIcons[i]
        local itemConfig = data[i]
        if itemConfig ~= nil then
            SetActive(rewardCountIcon.gameObject, true)
            rewardCountIcon:SetData(itemConfig)
        else
            SetActive(rewardCountIcon.gameObject, false)
        end
    end
end

function CeHuiRuleItem:PlayAnim(isDobleSpeed)
    self.animator.speed = isDobleSpeed == true and 2 or 1
    self.animator:Play("ani_XingZhiCeHuiPanel_RuleItem")
end