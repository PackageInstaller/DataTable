-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionUtil.lua

module("logic.extensions.controlaction.view.ControlActionUtil", package.seeall)

local guideIds = {
	11220,
	11221,
	11222,
	11223
}
local guideBattle = false

function formatNumber(num)
	if num < 10 then
		return string.format("0%s", num)
	end

	return num
end

function getTimeStr(time)
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(tonumber(time))
	local timestr = string.format("%s:%s:%s", formatNumber(hour), formatNumber(minute), formatNumber(second))
	local date1 = TimeUtil.instance:formatUnixTime2Date(AirtightRoomModel.instance:getServerTime())
	local date2 = TimeUtil.instance:formatUnixTime2Date(tonumber(time))
	local days = date1.day - date2.day

	if days >= 1 then
		if date1.hour < date2.hour then
			days = days - 1
		end

		if days >= 1 then
			timestr = string.format("%s天前", days)
		end
	end

	return timestr
end

function isInGuide()
	local isGuide = false
	local guideId = GuideController.instance:getCurGuideId()

	for i, v in ipairs(guideIds) do
		if guideId == v then
			isGuide = true
		end
	end

	return GuideController.instance:isGuiding() and isGuide
end

function isInGuideFirst()
	local isGuide = false
	local guideId = GuideController.instance:getCurGuideId()

	if guideId == guideIds[1] then
		isGuide = true
	end

	return GuideController.instance:isGuiding() and isGuide
end

function isInGuideSecond()
	local isGuide = false
	local guideId = GuideController.instance:getCurGuideId()

	if guideId == guideIds[2] then
		isGuide = true
	end

	return GuideController.instance:isGuiding() and isGuide or guideBattle
end

function isGuideFinished()
	local isFinish = GuideModel.instance:isGuideFinish(guideIds[4])

	return isFinish
end

function setGuideBattle()
	guideBattle = true
end

function getGuideBattle()
	return guideBattle
end

function clearGuideBattle()
	guideBattle = false
end

function isControlActionDungeon(dungeonType)
	return DungeonUtil.isControlAction(dungeonType)
end

function isProtomerDungeon(dungeonId, protomerType)
	local protomerCO = ControlActionConfig.instance:getMonitorDungeonGroupCfg(protomerType)

	return protomerCO and table.indexof(protomerCO.dungeonCodes, dungeonId) or false
end

function isDoomForecastDungeon(dungeonId)
	return isProtomerDungeon(dungeonId, ControlActionEnum.ProtomerType.DoomForecast)
end

function isStatusDungeon(dungeonId)
	return isProtomerDungeon(dungeonId, ControlActionEnum.ProtomerType.Statue)
end

function isPianoDungeon(dungeonId)
	return isProtomerDungeon(dungeonId, ControlActionEnum.ProtomerType.Piano)
end
