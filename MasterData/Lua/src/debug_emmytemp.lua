local tab = {}
tab.isIn = false
tab.interType = nil
tab.entity = nil
tab.onClick = nil
tab.name = nil
tab.node = nil
local addedInteractOption = {interactType = nil, arg = nil}
local interactExecuter = {}

function interactExecuter:checkCondition(entity, param)
end

function interactExecuter:executeInteract(entity, param)
end

function interactExecuter:getDisplayName(entity, param)
end

local sortData = {}
sortData.key = {}
sortData.isDesc = {}
local standRewardOutPut = {}
standRewardOutPut.rewardId = 1
standRewardOutPut.time = 1
standRewardOutPut.limit = 1
local rewards = {}
rewards.rewards = {}
rewards.src = nil
