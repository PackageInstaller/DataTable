-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignpagetourView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignpagetourView", package.seeall)

local BirthdaywelfaresignpagetourView = class("BirthdaywelfaresignpagetourView", ViewComponent)

function BirthdaywelfaresignpagetourView:ctor()
	BirthdaywelfaresignpagetourView.super.ctor(self)
end

function BirthdaywelfaresignpagetourView:unbindEvents()
	BirthdaywelfaresignpagetourView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPgetour)
end

function BirthdaywelfaresignpagetourView:bindEvents()
	BirthdaywelfaresignpagetourView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPgetour, self._onClickPagetour, self)
end

function BirthdaywelfaresignpagetourView:buildUI()
	BirthdaywelfaresignpagetourView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._btnPgetour = self:getBtn("btnPagetour")
	self._cellUp = self:getGo("cell_up")
	self._cellDown = self:getGo("cell_down")
	self._tableviewUp = self:getGo("tableview_up")
	self._tableviewDown = self:getGo("tableview_down")
	self._scrollViewUp = ScrollerList.create(self._tableviewUp, self._cellUp, GameUtil.handler(self._updateUpCell, self), GameUtil.handler(self._clearUpView, self))
	self._scrollViewDown = ScrollerList.create(self._tableviewDown, self._cellDown, GameUtil.handler(self._updateDownCell, self), GameUtil.handler(self._clearDownView, self))
end

function BirthdaywelfaresignpagetourView:onExit()
	BirthdaywelfaresignpagetourView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshUI, self)
	self._scrollViewUp:dispose()
	self._scrollViewDown:dispose()
end

function BirthdaywelfaresignpagetourView:onEnter()
	BirthdaywelfaresignpagetourView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

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

	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshUI, self)
	ActivitySummaryController.instance:sendGetSignInfo(self._activityId)
	self._scrollViewDown:reloadData(self._cfg)
end

function BirthdaywelfaresignpagetourView:_onRefreshUI()
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

function BirthdaywelfaresignpagetourView:_updateUpCell(view, cell, data)
	local _offset = goutil.findChildRectTransformComponent(cell, "offset")
	local top = goutil.findChild(cell, "offset/top")
	local effectRoot = goutil.findChild(cell, "offset/effectRoot")
	local receive = goutil.findChild(cell, "offset/receive")
	local lock = goutil.findChild(cell, "offset/lock")
	local item = goutil.findChild(cell, "offset/item")
	local txtTitle = goutil.findChildTextComponent(cell, "offset/txtTitle")
	local txtNum = goutil.findChildTextComponent(cell, "offset/txtNum")
	local btnExchangeCode = goutil.findChild(cell, "offset/btnExchangeCode")

	txtTitle.text = "第" .. data.signInDays .. "天"

	local index

	for i, v in ipairs(self._cfg) do
		if v == data then
			index = i

			break
		end
	end

	if not string.nilorempty(data.showPrize) then
		local prizeStr = MaterialMgr.changeItemStrArr(data.showPrize)
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr[1])

		txtNum.text = "x" .. checknumber(matNum)

		MaterialMgr.setIcon(item, matType, matId)

		local isUnlockAsSignDay = ActivitySummaryController.instance:isUnlockAsSignDay(self._activityId, data.signInDays)

		GameUtil.SetActive(lock, not isUnlockAsSignDay)

		local canGetSignReward = data.signInDays <= self._onlineDay and self._signInMap[data.signInDays] == nil and isUnlockAsSignDay

		if canGetSignReward then
			local scrollRect = self._tableviewUp:GetComponent(ComponentType.ScrollRect)

			local function loadedHandler(handlerTarget, eff)
				eff:setScrollRectClipping(scrollRect)
			end

			self:playViewEffectUniGo("fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab", effectRoot, nil, true, nil, loadedHandler)
		else
			self:stopViewEffectUniGo(effectRoot)
		end

		GameUtil.addClickHandler(top, function()
			if data.signInDays <= self._onlineDay and self._signInMap[data.signInDays] == nil then
				ActivitySummaryController.instance:sendGetSignInPrize(self._activityId, data.signInDays)
			elseif prizeStr and prizeStr[1] then
				CommonTipsMgr.instance:openTipsByConfStr(item, prizeStr[1])
			end
		end)
		GameUtil.SetActive(receive, self._signInMap[data.signInDays] ~= nil)
		GameUtil.SetActive(btnExchangeCode, self._signInMap[data.signInDays] ~= nil)
		GameUtil.addClickHandler(btnExchangeCode, function()
			UIStateManager.instance:push(ViewName.BirthdaytipsView, self._codeMap[data.signInDays])

			if checknumber(data.reportBehavior) > 0 then
				SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
			end
		end)
	end
end

function BirthdaywelfaresignpagetourView:_clearUpView(cell)
	local top = goutil.findChild(cell, "offset/top")
	local effectRoot = goutil.findChild(cell, "offset/effectRoot")
	local item = goutil.findChildImageComponent(cell, "offset/item")
	local btnExchangeCode = goutil.findChild(cell, "offset/btnExchangeCode")

	self:stopViewEffectUniGo(effectRoot)
	GameUtil.rmClickHandler(top)
	GameUtil.rmClickHandler(btnExchangeCode)
	MaterialMgr.clearIcon(item)
end

function BirthdaywelfaresignpagetourView:_updateDownCell(view, cell, data)
	local item = goutil.findChildImageComponent(cell, "item")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local top = goutil.findChild(cell, "top")

	if not string.nilorempty(data.showPagePrize) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.showPagePrize)

		MaterialMgr.setIcon(item, matType, matId)

		txtNum.text = "x" .. checknumber(matNum)

		GameUtil.addClickHandler(top, function()
			CommonTipsMgr.instance:openTipsByConfStr(item, data.showPagePrize)
		end, self)
	end
end

function BirthdaywelfaresignpagetourView:_clearDownView(cell)
	local item = goutil.findChildImageComponent(cell, "item")
	local top = goutil.findChild(cell, "top")

	MaterialMgr.clearIcon(item)
	GameUtil.rmClickHandler(top)
end

function BirthdaywelfaresignpagetourView:_onClickPagetour()
	local isOffical = SDKManager.isOfficial()

	if isOffical then
		local str = XiaonuoBirthConfig.instance:getCommonValue("H5_URL")

		UnityEngine.Application.OpenURL(str)
	else
		TipsFacade.instance:openTipWindow("提示", lang("浏览器搜索【奥奇传说H5】或登录百田网，即可登录奥奇传说页游，领取超多福利！"), function()
			ViewMgr.instance:close(ViewName.Popupwindow)
		end)
	end
end

return BirthdaywelfaresignpagetourView
