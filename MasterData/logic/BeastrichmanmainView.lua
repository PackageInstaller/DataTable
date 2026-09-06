-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanmainView.lua

module("logic.extensions.beastrichman.view.BeastrichmanmainView", package.seeall)

local BeastrichmanmainView = class("BeastrichmanmainView", ViewComponent)

function BeastrichmanmainView:ctor()
	BeastrichmanmainView.super.ctor(self)
end

function BeastrichmanmainView:unbindEvents()
	BeastrichmanmainView.super.unbindEvents(self)
	self._btnPrize:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSHHJ:RemoveClickListener()

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	for i, v in ipairs(self._btnEnterGos) do
		GameUtil.rmClickHandler(v)
	end
end

function BeastrichmanmainView:bindEvents()
	BeastrichmanmainView.super.bindEvents(self)
	self._btnPrize:AddClickListener(self._onClickbtnPrize, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSHHJ:AddClickListener(self._onClickbtnSHHJ, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end

	for i, v in ipairs(self._btnEnterGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnEnter, self, i))
	end
end

function BeastrichmanmainView:buildUI()
	BeastrichmanmainView.super.buildUI(self)

	self._btnPrize = self:getBtn("btnPrize")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtScore = self:getTxt("txtScore")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._btnSHHJ = self:getBtn("btnSHHJ")
	self._glodbarGo = self:getGo("glodbar")
	self._jumpBtnGos = {}

	local jumpBtnCol = self:getGo("jumpBtnCol")

	for i = 1, jumpBtnCol.transform.childCount do
		local go = jumpBtnCol.transform:GetChild(i - 1).gameObject

		table.insert(self._jumpBtnGos, go)
	end

	self._btnEnterGos = {}

	for i = 1, 3 do
		table.insert(self._btnEnterGos, self:getGo("btnEnter" .. i))
	end

	self._gainGo = self:getGo("btnPrize/gain")
	self._btnTaskRedPoint = self:getGo("jumpBtnCol/btnJump3/redPoint")
end

function BeastrichmanmainView:onExit()
	BeastrichmanmainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._btnTaskRedPoint)
end

function BeastrichmanmainView:onEnter()
	BeastrichmanmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManInfoRes, self._onBeastRichManInfoRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManGainDailyPrizeRes, self._updateBtnPrize, self)

	self._activityId = 558001

	local activityId = checknumber(self:getFirstParam())

	if activityId > 0 then
		self._activityId = activityId
	end

	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._paramTable = GameUtil.jsonToTable(self._actCfg.paramStr)

	local key = string.format("BeastrichmanmainView%s", self._activityId)

	local function firstCallback()
		self:_showPlayRule()
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback)
	self:_setSpeMainTopGoldBar()
	self:_updateUI()
	BeastRichmanAgent.instance:sendPM_BeastRichManInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._btnTaskRedPoint, 476)
end

function BeastrichmanmainView:_onClickbtnSHHJ()
	UIStateManager.instance:push(ViewName.BeastRichManCollectView, self._activityId)
end

function BeastrichmanmainView:_onClickbtnPrize()
	if not self._info then
		return
	end

	if self._info.gainedDailyPrize then
		FloatWordMgr.instance:show("今日礼包已领取")
	else
		BeastRichmanAgent.instance:sendPM_BeastRichManGainDailyPrizeReq(self._activityId)
	end
end

function BeastrichmanmainView:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function BeastrichmanmainView:_onClickbtnClose()
	self:close()
end

function BeastrichmanmainView:_onClickBtnJump(idx)
	if self._paramTable["jumpStr" .. idx] then
		GotoMgr.gotoByString(self._paramTable["jumpStr" .. idx])
	end
end

function BeastrichmanmainView:_onClickBtnEnter(zoneId)
	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, zoneId)

	if zoneCfg then
		local openTime = GameUtil.string2time(zoneCfg.openDateTime)

		if openTime > ServerTime.now() then
			FloatWordMgr.instance:show("暂未开放")

			return
		end

		UIStateManager.instance:push(ViewName.BeastRichManGameView, self._activityId, zoneId)
	end
end

function BeastrichmanmainView:_onBeastRichManInfoRes()
	self:_updateUI()

	if self._info and not self._info.gainedDailyPrize then
		self:_onClickbtnPrize()
	end
end

function BeastrichmanmainView:_setSpeMainTopGoldBar()
	local diceCfgs = BeastRichmanConfig.instance:getDiceCfgs(self._activityId)
	local btn_list = {}

	for i, v in ipairs(diceCfgs) do
		table.insert(btn_list, {
			showAdd = true,
			id = v.cost
		})
	end

	MainUIController.instance:showGlodBar(self._glodbarGo, self._viewPresentor, btn_list, false)
end

function BeastrichmanmainView:_updateUI()
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)

	self:_updateZones()
	self:_updateBtnPrize()

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	if self._info then
		self._txtScore.text = self._info.score or 0
	end
end

function BeastrichmanmainView:_updateBtnPrize()
	goutil.setActive(self._gainGo, (self._info or nil) and self._info.gainedDailyPrize)
end

function BeastrichmanmainView:_updateZones()
	local zoneCfgs = BeastRichmanConfig.instance:getZoneCfgs(self._activityId)

	for i, v in ipairs(zoneCfgs) do
		local go = self._btnEnterGos[i]

		if go then
			local openTime = GameUtil.string2time(v.openDateTime)
			local isOpen = openTime <= ServerTime.now()
			local txtOpenTime = goutil.findChildTextComponent(go, "lock/txtOpenTime")
			local txtName = goutil.findChildTextComponent(go, "txtName")
			local goLock = goutil.findChild(go, "lock")

			goutil.setActive(goLock, not isOpen)

			txtName.text = v.name

			if isOpen then
				txtOpenTime.text = ""
			else
				local date = GameUtil.string2date(v.openDateTime)

				txtOpenTime.text = string.format("%s.%s %s:00后解锁", date.month, date.day, date.hour)
			end
		end
	end
end

function BeastrichmanmainView:_showPlayRule()
	local ruleCfg = BeastRichmanConfig.instance:getRuleCfg(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
end

return BeastrichmanmainView
