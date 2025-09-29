-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/ClimbingTowerMoonFragmentView.lua

module("logic.extensions.climbingtower.view.ClimbingTowerMoonFragmentView", package.seeall)

local M = class("ClimbingTowerMoonFragmentView", ClimbingTowerBasePage)

function M:buildUI()
	M.super.buildUI(self)

	local registry = self:getRegistry()

	self._guiAnimation = goutil.addComponentOnce(self:getMainGo(), typeof(Astral.GUITimelineAniLua))
	self._btnReturn = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_-878360263"))
	self._btnHome = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_1398742689"))
	self._btnExplain = UIComponentType.ButtonAdapter(registry:findUIElement("title_view_-636449388"))

	goutil.setActive(self._btnHome.gameObject, true)
	goutil.setActive(self._btnExplain.gameObject, true)

	local redFogRootBright = registry:findUIElement("climbing_tower_moon_panel_260429376", UIComponentType.RectTransform)

	self._redFogBright = {}

	for i = 0, redFogRootBright.childCount - 1 do
		local tmpTr = redFogRootBright:GetChild(i)

		table.insert(self._redFogBright, tmpTr.gameObject)
	end

	local redFogRootDark = registry:findUIElement("climbing_tower_moon_panel_-1833672019", UIComponentType.RectTransform)

	self._redFogDark = {}

	for i = 0, redFogRootDark.childCount - 1 do
		local tmpTr = redFogRootDark:GetChild(i)

		table.insert(self._redFogDark, tmpTr.gameObject)
	end

	self._btnDarkSideEntry = UIComponentType.ButtonAdapter(registry:findUIElement("climbing_tower_moon_panel_1394859842"))
	self._goDarkSideLockRoot = registry:findUIElement("climbing_tower_moon_panel_-2118593261")
	self._txtDarkSideLockDesc = registry:findUIElement("climbing_tower_moon_panel_-1912132851", UIComponentType.Text)
	self._txtDarkSideFinishTitle = registry:findUIElement("climbing_tower_moon_panel_-745367173", UIComponentType.Text)
	self._txtDarkSideFinishContent = registry:findUIElement("climbing_tower_moon_panel_-799164048", UIComponentType.Text)
	self._goDarkSideTimeRoot = registry:findUIElement("climbing_tower_moon_panel_-1140015162")
	self._txtDarkSideTime = registry:findUIElement("climbing_tower_moon_panel_-948361574", UIComponentType.Text)
	self._btnBrightSideEntry = UIComponentType.ButtonAdapter(registry:findUIElement("climbing_tower_moon_panel_-1900545383"))
	self._txtBrightSideFinishContent = registry:findUIElement("climbing_tower_moon_panel_-1126259920", UIComponentType.Text)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._btnReturn = nil
	self._btnHome = nil
	self._btnDarkSideEntry = nil
	self._goDarkSideLockRoot = nil
	self._txtDarkSideLockDesc = nil
	self._txtDarkSideFinishTitle = nil
	self._txtDarkSideFinishContent = nil
	self._txtDarkSideTime = nil
	self._btnBrightSideEntry = nil
	self._txtBrightSideFinishContent = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnDarkSideEntry:AddClickListener(self._onClickDarkSideEntry, self)
	self._btnBrightSideEntry:AddClickListener(self._onClickBrightSideEntry, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnDarkSideEntry:RemoveClickListener()
	self._btnBrightSideEntry:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshBrightSide()
	self:refreshDarkSide()
	self:_setEvent(true)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	if self._tweenDelayDefaultTab then
		self._tweenDelayDefaultTab:Kill(false)

		self._tweenDelayDefaultTab = nil
	end

	self._guiAnimation:StopTimelineAni()
	M.super.onExit(self)
	self:_setEvent(false)
	self:darkTimerControl(false)
	self:nextRoundTimerControl(false)

	self._cacheDarkRound = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE, self._handleClimbingTowerDarkRoundChange, self)
	end
end

function M:_handleClimbingTowerDarkRoundChange(e)
	self:refreshDarkSide()
end

function M:getPageTyp()
	return ClimbingTowerEnum.PageTyp.Moon
end

function M:_onClickReturn()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")

	self._tweenDelayDefaultTab = DoTweenUtil.DelayedCall(0.4, function()
		local handler = self:getHandler()

		if handler then
			handler:onClickReturn()
		end
	end)
end

function M:_onClickHome()
	local handler = self:getHandler()

	if handler then
		handler:onClickHome()
	end
end

function M:_onClickExplain()
	local handler = self:getHandler()

	if handler then
		handler:onClickExplain()
	end
end

function M:_onClickBrightSideEntry()
	local handler = self:getHandler()

	if handler then
		handler:changePage(ClimbingTowerEnum.PageTyp.BrightSide)
	end
end

function M:_onClickDarkSideEntry()
	if not self._darkSideActive then
		FloatWordMgr.instance:show(lang("tip_dark_not_work"))
		ClimbingTowerController.instance:checkDarkTower()

		return
	end

	if self._lockDarkSide then
		local unlockCode = ClimbingTowerConfig.instance:getDarkSideUnLockCondition()

		FloatWordMgr.instance:show(string.format(lang("tip_dark_can_not_enter"), ClimbingTowerConfig.instance:getTowerIndexNameBrightSide(unlockCode)))

		return
	end

	if ServerTime.nowServerLook() >= self._curDarkSideEndTime then
		FloatWordMgr.instance:show(lang("tip_dark_not_work"))
		ClimbingTowerController.instance:checkDarkTower()

		return
	end

	local handler = self:getHandler()

	if handler then
		handler:changePage(ClimbingTowerEnum.PageTyp.DarkSide)
	end
end

function M:_darkSideLockByBrightSide()
	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()
	local darkSideUnlockCondition = ClimbingTowerConfig.instance:getDarkSideUnLockCondition()

	return clearCount < darkSideUnlockCondition
end

function M:refreshBrightSide()
	local maxStorey = ClimbingTowerConfig.instance:getBrightSideMaxStorey()
	local clearCount = ClimbingTowerModel.instance:getClearDungeonCount()

	self._txtBrightSideFinishContent.text = string.format("%s/%s", clearCount, maxStorey)

	self:updateRedFogBright(clearCount / maxStorey)
end

function M:refreshDarkSide()
	local darkRemainedTime = 0
	local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()
	local darkRoundCO
	local show = darkRound > 0

	print("暗面轮数：", darkRound)

	if show then
		darkRoundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)
	else
		if self._cacheDarkRound and self._cacheDarkRound ~= darkRound then
			ClimbingTowerController.instance:checkDarkTower()
		end

		self._cacheDarkRound = darkRound
	end

	if darkRoundCO == nil then
		show = false
	end

	if show and darkRoundCO:isExpired() then
		show = false

		printWarn(string.format("暗面[%s]已失效", darkRound))
	end

	self._nextDarkCO = nil

	if show then
		local maxStorey = darkRoundCO:getDungeonCount()
		local clearCount = ClimbingTowerDarkModel.instance:getClearDungeonCount(darkRound)

		self._txtDarkSideFinishContent.text = string.format("%s/%s", clearCount, maxStorey)

		self:updateRedFogDark(clearCount / maxStorey)

		local endTimeStamp = darkRoundCO:getEndTimeStamp()

		darkRemainedTime = endTimeStamp - ServerTime.now()
	else
		self._nextDarkCO = self:_tryAnnounceNextDarkTowerTime()

		self:updateRedFogDark(0)
	end

	self._lockDarkSide = self:_darkSideLockByBrightSide()
	self._darkSideActive = show
	self._darkSideRemainedTime = darkRemainedTime
	self._curDarkSideEndTime = darkRoundCO and darkRoundCO:getEndTimeStamp() or 0
	self._nextDarkSideBeginTime = self._nextDarkCO and self._nextDarkCO:getStartTimeStamp() or 0

	if self._lockDarkSide then
		local unlockCode = ClimbingTowerConfig.instance:getDarkSideUnLockCondition()
		local str = string.format(lang("tip_dark_can_not_enter"), ClimbingTowerConfig.instance:getTowerIndexNameBrightSide(unlockCode))

		self._txtDarkSideLockDesc.text = str
	end

	goutil.setActive(self._goDarkSideLockRoot, self._lockDarkSide)
	goutil.setActive(self._goDarkSideTimeRoot, show and not self._lockDarkSide or self._nextDarkSideBeginTime > 0)
	goutil.setActive(self._txtDarkSideFinishTitle.gameObject, show and not self._lockDarkSide)
	goutil.setActive(self._txtDarkSideFinishContent.gameObject, show and not self._lockDarkSide)
	self:darkTimerControl(show)
end

function M:_tryAnnounceNextDarkTowerTime()
	local nextRoundCO
	local nowTime = ServerTime.now()
	local roundLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.DarkRound)

	if roundLst and #roundLst > 0 then
		local minTimeOffset

		for _, cfgRound in ipairs(roundLst) do
			local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(cfgRound.round)
			local startTS = roundCO:getStartTimeStamp()
			local setUp = true

			if nowTime < startTS then
				local offset = startTS - nowTime

				if minTimeOffset and minTimeOffset < offset then
					setUp = false
				end

				if setUp then
					minTimeOffset = offset
					nextRoundCO = roundCO
				end
			end
		end
	end

	local timeStr, colorStr

	if nextRoundCO then
		self._txtDarkSideFinishContent.text = ""

		local strLst = string.split(nextRoundCO:getStartTime(), "T")

		timeStr = string.format("%s:%s", lang("tip_next_open"), strLst and strLst[1] or nextRoundCO:getStartTime())
		self._nextRoundRemainedTime = nextRoundCO:getStartTimeStamp() - nowTime

		self:nextRoundTimerControl(true)
	else
		self._txtDarkSideFinishContent.text = ""
		timeStr = ""
	end

	self:_setDarkSideTimeStr(timeStr, colorStr)

	return nextRoundCO
end

function M:updateRedFogBright(percentFloat)
	local count = #self._redFogBright
	local step = ClimbingTowerEnum.ClearStepBright
	local hideCount = 0

	if percentFloat <= 0 then
		-- block empty
	elseif percentFloat >= 1 then
		hideCount = count
	else
		local stepCount = math.floor(count / step)
		local reachStep = math.floor(math.floor(percentFloat * 100) / math.floor(1 / step * 100))

		hideCount = reachStep * stepCount
	end

	for index, obj in ipairs(self._redFogBright) do
		local hide = index <= hideCount

		goutil.setActive(obj, not hide)
	end
end

function M:updateRedFogDark(percentFloat)
	local count = #self._redFogDark
	local step = ClimbingTowerEnum.ClearStepDark
	local hideCount = 0

	if percentFloat <= 0 then
		-- block empty
	elseif percentFloat >= 1 then
		hideCount = count
	else
		local stepCount = math.floor(count / step)
		local reachStep = math.floor(math.floor(percentFloat * 100) / math.floor(1 / step * 100))

		hideCount = reachStep * stepCount
	end

	for index, obj in ipairs(self._redFogDark) do
		local hide = index <= hideCount

		goutil.setActive(obj, not hide)
	end
end

function M:nextRoundTimerControl(startTimer)
	if startTimer then
		removetimer(self._timerForNextRound, self)
		settimer(1, self._timerForNextRound, self, true)
	else
		removetimer(self._timerForNextRound, self)
	end
end

function M:_timerForNextRound()
	local remainedTime = self._nextRoundRemainedTime

	remainedTime = remainedTime - 1
	self._nextRoundRemainedTime = remainedTime

	if remainedTime < 0 then
		self:nextRoundTimerControl(false)
		self:refreshDarkSide()
	end
end

function M:darkTimerControl(startTimer)
	if startTimer then
		self:_timerForDarkSide()
		removetimer(self._timerForDarkSide, self)
		settimer(1, self._timerForDarkSide, self, true)
	else
		removetimer(self._timerForDarkSide, self)
	end
end

function M:_timerForDarkSide()
	local remainedTime = self._darkSideRemainedTime

	remainedTime = remainedTime - 1
	remainedTime = remainedTime < 0 and 0 or remainedTime
	self._darkSideRemainedTime = remainedTime

	self:_updateRemainedTime(self._darkSideRemainedTime)
end

function M:_updateRemainedTime(remainedTimeStamp)
	local day, hour, min, sec = 0, 0, 0, 0
	local timeStr, colorStr

	day = math.floor(remainedTimeStamp / 86400)

	if day > 0 then
		timeStr = string.format(lang("tip_left_xx_day"), day)
	else
		day, hour, min, sec = self:formatRemainedTime(remainedTimeStamp)

		if remainedTimeStamp < 3600 then
			colorStr = "#ff3e48"
		end

		timeStr = string.format("%02d:%02d:%02d", hour, min, sec)
	end

	self:_setDarkSideTimeStr(timeStr, colorStr)
end

function M:_setDarkSideTimeStr(strContent, colorStr)
	colorStr = colorStr or "#FFFFFF"

	TextUtils.SetColor(self._txtDarkSideTime, colorStr)

	self._txtDarkSideTime.text = strContent
end

function M:formatRemainedTime(leftTime)
	local day = math.floor(leftTime / 86400)
	local hour = math.floor((leftTime - day * 86400) / 3600)
	local minute = math.floor((leftTime - day * 86400 - hour * 3600) / 60)
	local second = leftTime - day * 86400 - hour * 3600 - minute * 60

	return day, hour, minute, second
end

return M
