-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/control/ClimbingTowerController.lua

module("logic.extensions.climbingtower.control.ClimbingTowerController", package.seeall)

local M = class("ClimbingTowerController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
	self:_setEvent(true)
end

function M:onReset()
	self._isShowBright = false
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ENTERY_ISSHOWBRIGHT, self._setIsShowBrightPanel, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ENTERY_ISSHOWBRIGHT, self._setIsShowBrightPanel, self)
	end
end

function M:checkDarkTower()
	self:_handleClockTickDailyRefresh(nil)
end

function M:_setIsShowBrightPanel(e, isShow)
	self._isShowBright = isShow
end

function M:getIsShowBrightPanel()
	return self._isShowBright
end

function M:_handleClockTickDailyRefresh(e, enum)
	local nowTime = ServerTime.now()

	printWarn(string.format("<color=#45e6f9>服务器时间[%s] %s</color>", nowTime, TimeUtil.instance:stampToDateStr(nowTime)))

	local needReqNewDungeonInfo = false
	local curDarkRound = ClimbingTowerDarkModel.instance:getDarkRound()

	if curDarkRound and curDarkRound > 0 then
		local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(curDarkRound)
		local isExpired = true

		if roundCO then
			isExpired = roundCO:isExpired()
		end

		if isExpired then
			needReqNewDungeonInfo = true
		end

		printWarn(string.format("<color=#45e6f9>上次暗塔轮数[%s].失效[%s]</color>", curDarkRound, isExpired))
	else
		printWarn(string.format("<color=#45e6f9>上次无暗塔</color>"))

		local roundLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.DarkRound)

		if roundLst and #roundLst > 0 then
			for _, cfgRound in ipairs(roundLst) do
				local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(cfgRound.round)

				if roundCO and not roundCO:isExpired() then
					needReqNewDungeonInfo = true

					printWarn(string.format("<color=#45e6f9>匹配到符合暗塔[%s]</color>", cfgRound.round))

					break
				end
			end
		end
	end

	printWarn(string.format("<color=#45e6f9>上次暗塔[%s].需要重新请求副本数据[%s]</color>", curDarkRound, needReqNewDungeonInfo))

	if needReqNewDungeonInfo then
		DungeonAgent.instance:sendGetDungeonInfoRequest()
	end
end

function M:startNextBattleLevel(dungeonCode, gamePlay)
	local dungeonMO = ClimbingTowerModel.instance:getDungeonMoById(dungeonCode)
	local nextDungeonCode = dungeonMO:getNextDungeonId()

	if not nextDungeonCode then
		return
	end

	DungeonAgent.instance:sendStartDungeonRequest(nextDungeonCode, 1, false, gamePlay)

	return true
end

M.instance = M.New()

return M
