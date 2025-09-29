-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/util/HousePerformUtil.lua

module("logic.extensions.house.util.HousePerformUtil", package.seeall)

local HousePerformUtil = {}

function HousePerformUtil.addDelimiterPosToArray(sourceStr, delimiter, array)
	local pos = 0

	for st, sp in function()
		return string.find(sourceStr, delimiter, pos, true)
	end do
		pos = sp + 1

		if #array < 1 then
			table.insert(array, st)
		else
			local isInsert = false

			for idx, delPos in ipairs(array) do
				if st < delPos then
					table.insert(array, idx, st)

					isInsert = true

					break
				end
			end

			if not isInsert then
				table.insert(array, st)
			end
		end
	end
end

function HousePerformUtil.canUnitTriggerPerform(unit, isSingle)
	local isManualWalk = unit.navMesh:getIsManualWalk()
	local isDraging = unit.model:judgeStatus(HouseEnum.PlayerStatus.Draging)
	local isEating = unit.model:judgeStatus(HouseEnum.PlayerStatus.Eating)
	local isSleeping = unit.model:judgeStatus(HouseEnum.PlayerStatus.Sleeping)
	local isBathing = unit.model:judgeStatus(HouseEnum.PlayerStatus.Bathing)
	local isElevator = unit.model:judgeStatus(HouseEnum.PlayerStatus.Elevator)
	local isWaitingElevator = unit.model:judgeStatus(HouseEnum.PlayerStatus.WaitingElevator)
	local isShelterInvalid = unit.model:judgeBehaviorStatus(HouseEnum.BehaviorStatus.ShelterInvalid)
	local runningCtrl = unit.performCtrl:getRunningCtrl()
	local isForbid = unit.performCtrl:getForbid()
	local isInActiveZone = HouseSceneUtil.isHeroInActiveZone(unit)

	if isSingle then
		return not isManualWalk and not isDraging and not isBathing and not isShelterInvalid and not isForbid and isInActiveZone and runningCtrl == nil
	end

	return not isManualWalk and not isDraging and not isEating and not isElevator and not isWaitingElevator and not isSleeping and not isBathing and not isShelterInvalid and not isForbid and isInActiveZone and runningCtrl == nil
end

function HousePerformUtil.setBehaviorData(data, playerUnit)
	local setFunc = BehaviorAiDataCreator[string.format("setAiData_%s", data:getType())]
	local success = setFunc(data, playerUnit)

	if not success then
		printWarn(string.format("创建行为树数据失败，角色id：%s，行为类型：%s", playerUnit.heroId, data:getType()))
	end
end

return HousePerformUtil
