-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/TweenUtil.lua

module("logic.common.util.TweenUtil", package.seeall)

local TweenUtil = _M
local ID = 0
local allTween = setmetatable({}, {
	__mode = "v"
})

function TweenUtil.tweenNumber(updateCallback, updateCallbackSelf, startValue, endValue, duration)
	if duration <= 0 then
		if updateCallbackSelf then
			updateCallback(updateCallbackSelf, endValue)
		else
			updateCallback(endValue)
		end

		return 0
	end

	local totalTimes = math.ceil(duration * 30)
	local times = 0
	local isFinish = false
	local delta = (endValue - startValue) / totalTimes
	local updateValue = startValue
	local listener

	function listener()
		isFinish = false
		times = times + 1
		updateValue = updateValue + delta

		if times == totalTimes then
			isFinish = true
			updateValue = endValue

			Scheduler.removeListener(listener)
		end

		if updateCallbackSelf then
			updateCallback(updateCallbackSelf, updateValue, isFinish)
		else
			updateCallback(updateValue, isFinish)
		end
	end

	local tweenId = TweenUtil._getNextId()

	allTween[tweenId] = listener

	Scheduler.addListener(0, listener, nil, true)

	return tweenId
end

function TweenUtil.killTween(tweenId)
	if allTween[tweenId] then
		Scheduler.removeListener(allTween[tweenId])

		allTween[tweenId] = nil
	end
end

function TweenUtil._getNextId()
	ID = ID + 1

	return ID
end

return TweenUtil
