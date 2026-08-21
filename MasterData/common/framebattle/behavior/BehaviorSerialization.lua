-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Behavior\\BehaviorSerialization.lua

local BehaviorState = require("Common/FrameBattle/Behavior/BehaviorState")
local BhDataPath = "ClientData/BehaviorData/"
local BehaviorSerialization = {}

BehaviorSerialization.BH_Cache = {}

function BehaviorSerialization.init(parentSM, weaponType, overrideType)
	local bhStateDict = {}

	if BehaviorSerialization.BH_Cache[weaponType] then
		local cacheBhData = BehaviorSerialization.BH_Cache[weaponType]

		for stateName, stateBhData in pairs(cacheBhData) do
			local tempState = BehaviorState(parentSM, stateName, nil, stateBhData)

			bhStateDict[stateName] = tempState
		end
	else
		local bhDataFullPath = BhDataPath .. weaponType
		local BHData = require(bhDataFullPath)

		if BHData == nil then
			return
		end

		local cacheBhData = {}

		for stateName, stateInfo in pairs(BHData) do
			local tempName = stateName
			local tempState = BehaviorState(parentSM, stateName, stateInfo)

			bhStateDict[tempName] = tempState
			cacheBhData[tempName] = tempState:getCacheData()
		end

		BehaviorSerialization.BH_Cache[weaponType] = cacheBhData
	end

	parentSM.mStateDict = bhStateDict
end

function BehaviorSerialization.clearCache(weaponType)
	BehaviorSerialization.BH_Cache[weaponType] = nil
end

return BehaviorSerialization
