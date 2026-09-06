-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfarefestivalsignView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfarefestivalsignView", package.seeall)

local BirthdaywelfarefestivalsignView = class("BirthdaywelfarefestivalsignView", ViewComponent)

function BirthdaywelfarefestivalsignView:ctor()
	BirthdaywelfarefestivalsignView.super.ctor(self)
end

function BirthdaywelfarefestivalsignView:unbindEvents()
	BirthdaywelfarefestivalsignView.super.unbindEvents(self)
end

function BirthdaywelfarefestivalsignView:bindEvents()
	BirthdaywelfarefestivalsignView.super.bindEvents(self)
end

function BirthdaywelfarefestivalsignView:buildUI()
	BirthdaywelfarefestivalsignView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._cellUp = self:getGo("cell_up")
	self._tableviewUp = self:getGo("tableview_up")
	self._scrollViewUp = ScrollerList.create(self._tableviewUp, self._cellUp, GameUtil.handler(self._updateUpCell, self), GameUtil.handler(self._clearUpView, self))
end

function BirthdaywelfarefestivalsignView:onExit()
	BirthdaywelfarefestivalsignView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshUI, self)
	self._scrollViewUp:dispose()
end

function BirthdaywelfarefestivalsignView:onEnter()
	BirthdaywelfarefestivalsignView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam().parameter)

	print("传入的 actId：", self._activityId)

	local timeStr = XiaonuoBirthConfig.instance:getCommonValue("SIGN_IN_TWOTIME_LIMIT")
	local cfgList = XiaonuoBirthConfig.instance:getSignInList(self._activityId)

	self._cfg = {}

	for i, v in pairs(cfgList) do
		if checknumber(i) > 0 then
			table.insert(self._cfg, v)
		end
	end

	table.sort(self._cfg, function(a, b)
		return a.signInDays < b.signInDays
	end)

	self._txtTime.text = timeStr
	self._effList = {}

	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshUI, self)
	ActivitySummaryController.instance:sendGetSignInfo(self._activityId)
end

function BirthdaywelfarefestivalsignView:_onRefreshUI()
	local info = ActivitySummaryModel.instance:getSignInfo(self._activityId) or {}

	self._onlineDay = checknumber(info.onlineDay)
	self._signInList = info.hasGainPrizeDays or {}
	self._signInMap = {}
	self._codeMap = {}

	for _, cfg in pairs(self._signInList) do
		self._signInMap[cfg] = true
	end

	for _, info in ipairs(info.exchangeCodes or {}) do
		self._codeMap[info.day] = info.exchangeCode
	end

	self._scrollViewUp:reloadData(self._cfg)
end

function BirthdaywelfarefestivalsignView:_updateUpCell(view, cell, data)
	local _offset = goutil.findChildRectTransformComponent(cell, "offset")
	local top = goutil.findChild(cell, "offset/top")
	local effect = goutil.findChild(cell, "offset/effect")
	local receive = goutil.findChild(cell, "offset/receive")
	local lock = goutil.findChild(cell, "offset/lock")
	local item = goutil.findChildImageComponent(cell, "offset/item")
	local txtTitle = goutil.findChildTextComponent(cell, "offset/txtTitle")
	local txtNum = goutil.findChildTextComponent(cell, "offset/txtNum")
	local btnExchangeCode = goutil.findChildButtonComponent(cell, "offset/btnExchangeCode")

	txtTitle.text = "第" .. data.signInDays .. "天"

	local index

	for i, v in ipairs(self._cfg) do
		if v == data then
			index = i

			break
		end
	end

	_offset.anchoredPosition = index % 2 == 0 and UnityEngine.Vector2.New(0, -30) or UnityEngine.Vector2.New(0, 0)

	if not string.nilorempty(data.showPrize) then
		local prizeStr = MaterialMgr.changeItemStrArr(data.showPrize)
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr[1])

		txtNum.text = "x" .. checknumber(matNum)

		MaterialMgr.setIcon(item, matType, matId)

		local isUnlockAsSignDay = ActivitySummaryController.instance:isUnlockAsSignDay(self._activityId, data.signInDays)

		GameUtil.SetActive(lock, not isUnlockAsSignDay)
		goutil.setActive(effect, (data.signInDays <= self._onlineDay and self._signInMap[data.signInDays] == nil and isUnlockAsSignDay or nil) and true)
		GameUtil.addClickHandler(top, function()
			if data.signInDays <= self._onlineDay and self._signInMap[data.signInDays] == nil then
				ActivitySummaryController.instance:sendGetSignInPrize(self._activityId, data.signInDays)
			elseif prizeStr and prizeStr[1] then
				CommonTipsMgr.instance:openTipsByConfStr(item, prizeStr[1])
			end
		end)
		GameUtil.SetActive(receive, self._signInMap[data.signInDays] ~= nil)
		GameUtil.SetActive(btnExchangeCode, not string.nilorempty(self._codeMap[data.signInDays]))
		GameUtil.addClickHandler(btnExchangeCode, function()
			UIStateManager.instance:push(ViewName.BirthdaytipsView, self._codeMap[data.signInDays])

			if checknumber(data.reportBehavior) > 0 then
				SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
			end
		end)
	end
end

function BirthdaywelfarefestivalsignView:_clearUpView(cell)
	if self._effList[cell] then
		UIEffectManager.instance:stopEffect(self._effList[cell])

		self._effList[cell] = nil
	end

	MaterialMgr.resetAll(cell)
end

return BirthdaywelfarefestivalsignView
