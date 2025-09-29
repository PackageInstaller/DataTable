-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/multiple_drop/MultipleDropModel.lua

module("logic.extensions.welfare.model.multiple_drop.MultipleDropModel", package.seeall)

local M = class("MultipleDropModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
	self:onInit()
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._configIDList = {}
	self._moList = {}
end

function M:setConfigLst(cfgId, finishNumber)
	self._configIDList[cfgId] = finishNumber

	local mo = MultipleDropMo.New()
	local motable = {
		cfgid = cfgId,
		finishNumber = finishNumber
	}

	mo:setMultipleMo(motable)

	self._moList[cfgId] = mo
end

function M:getConfigLst()
	return self._configIDList
end

function M:getShowList()
	local moShowList = {}
	local mt = {}
	local count1 = 0

	for k, v in pairs(self._moList) do
		count1 = count1 + 1
		mt[count1] = v
	end

	table.sort(mt, function(a, b)
		if a:getConfigId() < b:getConfigId() then
			return true
		end

		return false
	end)

	local count = 0

	for k, v in pairs(mt) do
		local activityData = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.DUNGEON_REWARD_UP, v:getConfigId())

		if activityData and activityData:getIsOpen() then
			count = count + 1
			moShowList[count] = v
		end
	end

	return moShowList
end

function M:getSameTypeList(type)
	local tempList = self:getShowList()
	local list = {}

	for k, v in pairs(tempList) do
		if v:getTypeList() then
			for j, h in pairs(v:getTypeList()) do
				if type == h then
					list[v:getConfigId()] = v

					break
				end
			end
		end
	end

	return list
end

function M:getLeftNumberByType(type)
	local tableT = {
		left = "",
		times = ""
	}
	local tempList = self:getSameTypeList(type)

	for k, v in pairs(tempList) do
		tableT.times = v:getTimes() .. "次数"
		tableT.left = v:getLeftNumber() .. "/" .. v:getCount()

		break
	end

	return tableT
end

function M:getLeftNumberByTypeAndReward(type, rewradList)
	local tableT = {
		leftNumber = 1,
		left = "",
		times = ""
	}
	local tempList = self:getSameTypeList(type)
	local isHas = false

	rewradList = rewradList or {}

	for k, v in pairs(tempList) do
		if v:getRewardList() then
			isHas = true

			for _, h in pairs(v:getRewardList()) do
				for _, y in pairs(rewradList) do
					if y == h then
						tableT.times = v:getTimes() .. lang("tip_multipleDrop_times")

						if v:getCount() == 0 then
							tableT.left = " "
						else
							tableT.leftNumber = v:getLeftNumber()
							tableT.left = v:getLeftNumber() .. "/" .. v:getCount()
						end

						return tableT
					end
				end
			end
		end
	end

	if isHas then
		return tableT
	end

	for k, v in pairs(tempList) do
		tableT.times = v:getTimes() .. "次数"
		tableT.left = v:getLeftNumber() .. "/" .. v:getCount()

		break
	end

	return tableT
end

function M:setMultipleDropController(msg)
	local mo = self._moList[msg.actConfigId]

	mo:setFinishNumber(msg.count)
end

M.instance = M.New()

return M
