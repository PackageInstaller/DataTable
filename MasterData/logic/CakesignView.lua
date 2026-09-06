-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cakesign/view/CakesignView.lua

module("logic.extensions.cakesign.view.CakesignView", package.seeall)

local CakesignView = class("CakesignView", ViewComponent)

function CakesignView:ctor()
	CakesignView.super.ctor(self)
end

function CakesignView:buildUI()
	CakesignView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._btnEat = self:getBtn("btnEat")
	self._btnShowPrizes = self:getBtn("btnShowPrizes")
	self._txtActivityTime = self:getTxt("txtActivityTime")
	self._txtBtnEat = self:getTxt("btnEat/Text")
	self._showPrizes = {}

	for i = 1, 10 do
		local cell = {}
		local go = self:getGo("showPrizes/prizeCell" .. i)
		local goBtn = goutil.findChild(go, "btn")

		cell.go = go
		cell.btn = GameUtil.asBtn(goBtn)
		cell.effPos = goutil.findChild(goBtn, "eff")
		cell.icon = goutil.findChild(goBtn, "iconItem")
		cell.markHasGain = goutil.findChild(go, "markHasGain")
		cell.txtNum = goutil.findChildTextComponent(go, "txtNum")
		cell.prizeStr = nil
		cell.isHasGain = false
		self._showPrizes[i] = cell
	end
end

function CakesignView:bindEvents()
	CakesignView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnEat:AddClickListener(self._onClickBtnEat, self)
	self._btnShowPrizes:AddClickListener(self._onClickBtnShowPrizes, self)

	for i = 1, 10 do
		self._showPrizes[i].btn:AddClickListener(function()
			self:_onClickPrizes(i)
		end, self)
	end
end

function CakesignView:unbindEvents()
	CakesignView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnEat:RemoveClickListener()
	self._btnShowPrizes:RemoveClickListener()

	for i = 1, 10 do
		self._showPrizes[i].btn:RemoveClickListener()
	end
end

function CakesignView:destroyUI()
	CakesignView.super.destroyUI(self)
end

function CakesignView:onEnter()
	CakesignView.super.onEnter(self)

	self._curActId = nil
	self._ableToClick = true

	self:_dailyReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)

	local effResPath = "fx_ui_jiuzhounian/fx_ui_kuang_jiuzhouniandangao.prefab"

	self._playEff = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(nil)
		eff:setLocalPos(0, 0, 0)
		eff:setVisible(false)

		eff.hideEffWhileNotOnTop = true
	end)
	effResPath = "fx_ui_jiuzhounian/fx_ui_kuang_chouzhong_jiuzhouniandangao.prefab"
	self._playEff2 = UIEffectManager.instance:playEffect(self, "fx_ui_jiuzhounian/fx_ui_kuang_chouzhong_jiuzhouniandangao.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(nil)
		eff:setLocalPos(0, 0, 0)
		eff:setVisible(false)

		eff.hideEffWhileNotOnTop = true
	end)
	effResPath = "fx_ui_jiuzhounian/fx_ui_jiemian_jiuzhouniandangao.prefab"
	self._bgEff = UIEffectManager.instance:playEffect(self, "fx_ui_jiuzhounian/fx_ui_jiemian_jiuzhouniandangao.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function CakesignView:onEnterFinished()
	CakesignView.super.onEnterFinished(self)
end

function CakesignView:onExit()
	CakesignView.super.onExit(self)
	removetimer(self._updateTime, self)
	removetimer(self._onEndPlayAni, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)

	for i = 1, 10 do
		MaterialMgr.clearIcon(self._showPrizes[i].icon)
	end

	UIEffectManager.instance:stopEffect(self._playEff)

	self._playEff = nil

	UIEffectManager.instance:stopEffect(self._playEff2)

	self._playEff2 = nil

	UIEffectManager.instance:stopEffect(self._bgEff)

	self._bgEff = nil

	self:_showCI()
end

function CakesignView:onExitFinished()
	CakesignView.super.onExitFinished(self)
end

function CakesignView:_onClickClose()
	if not self._ableToClick then
		FloatWordMgr.instance:show("吃蛋糕中")

		return
	end

	self:close()
end

function CakesignView:_onClickBtnEat()
	if not self._ableToClick then
		return
	end

	if self._isAllGain then
		FloatWordMgr.instance:show("全部奖励已领完")
	elseif self._isTodayHasGain then
		FloatWordMgr.instance:show("今日已领取，明天记得来哦！")
	else
		CakeSiginAgent.instance:sendPM_EatCakeReq(self._handleAfterEat, self)
	end
end

function CakesignView:_onClickBtnHelp()
	if not self._ableToClick then
		return
	end

	ViewMgr.instance:open(ViewName.RulesView, "cakesignview")
end

function CakesignView:_onClickBtnShowPrizes()
	if not self._ableToClick then
		return
	end

	UIStateManager.instance:push(ViewName.CakesignpreshowView, self._showPrizes)
end

function CakesignView:_onClickPrizes(id)
	if not self._ableToClick then
		return
	end

	if self._showPrizes[id].prizeStr and self._showPrizes[id].go then
		CommonTipsMgr.instance:openTipsByConfStr(self._showPrizes[id].go, self._showPrizes[id].prizeStr)
	end
end

function CakesignView:_dailyReset()
	if self._curActId and not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.CakeSign, self._curActId) then
		FloatWordMgr.instance:show("活动时间结束")
		self:close()

		return
	end

	CakeSiginAgent.instance:sendPM_CakeSiginGetInfoReq(self._handleGetInfo, self)
end

function CakesignView:_handleGetInfo(msg)
	if self._curActId ~= checkint(msg.activityId) then
		self._curActId = checkint(msg.activityId)

		self:_updateViewByCfg()
	end

	self._isTodayHasGain = checkbool(msg.hasEatCake)

	for _, id in ipairs(msg.hasGainPrizeIndexs) do
		self._showPrizes[checkint(id)].isHasGain = true
	end

	self:_updateViewByState()
end

function CakesignView:_handleAfterEat(msg)
	self._curGetPrizeIndex = checkint(msg.hasGainPrizeIndex)
	self._showPrizes[self._curGetPrizeIndex].isHasGain = true
	self._isTodayHasGain = true

	local ci = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(ci)

	if ci then
		self.ciList = ci
	end

	self:_playRotateAni()
end

function CakesignView:_showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function CakesignView:_playRotateAni()
	self._ableToClick = false
	self.playEffPos = {}

	for i = 1, 10 do
		if not self._showPrizes[i].isHasGain then
			table.insert(self.playEffPos, i)
		end
	end

	table.insert(self.playEffPos, self._curGetPrizeIndex)

	self._stepTime = 0.2
	self._timer = 1
	self._totalTimer = #self.playEffPos

	self._playEff:setVisible(true)
	self._playEff:setParent(self._showPrizes[self.playEffPos[self._timer]].effPos.transform)
	self._playEff:setLocalPos(0, 0, 0)
	self._playEff:setScale(1)
	removetimer(self._updateTime, self)
	settimer(self._stepTime, self._updateTime, self)
end

function CakesignView:_updateTime()
	if self._timer >= self._totalTimer then
		removetimer(self._updateTime, self)
		self:_playAni(aniPath)
	else
		self._playEff:setVisible(false)
		self._playEff:setVisible(true)

		self._timer = self._timer + 1

		self._playEff:setParent(self._showPrizes[self.playEffPos[self._timer]].effPos.transform)
		self._playEff:setLocalPos(0, 0, 0)
		self._playEff:setScale(1)
	end
end

function CakesignView:_playAni(aniPath)
	self._playEff:setVisible(false)
	self._playEff:setVisible(true)
	self._playEff2:setParent(self._showPrizes[self._curGetPrizeIndex].effPos.transform)
	self._playEff2:setLocalPos(0, 0, 0)
	self._playEff2:setVisible(true)
	self._playEff2:setScale(1)
	removetimer(self._onEndPlayAni, self)
	settimer(1, self._onEndPlayAni, self, false)
end

function CakesignView:_onEndPlayAni()
	self._playEff:setVisible(false)
	self._playEff2:setVisible(false)
	self:_updateViewByState()

	self._ableToClick = true

	self:_showCI()
end

function CakesignView:_updateViewByCfg()
	local cfgs = CakeSignConfig.instance:getActCfgsById(self._curActId)

	for i = 1, 10 do
		local cfg = cfgs[i]

		if cfgs then
			self._showPrizes[i].prizeStr = cfg.prize

			MaterialMgr.clearIcon(self._showPrizes[i].icon)

			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)

			self._showPrizes[i].txtNum.text = matNum <= 1 and "" or "x" .. matNum

			MaterialMgr.updateItemByStr(self._showPrizes[i].icon, cfg.prize)
		end
	end

	local startDate, endDate = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.CakeSign, self._curActId)
	local startDateTable = GameUtil.time2date(startDate)
	local endDateTable = GameUtil.time2date(endDate)

	self._txtActivityTime.text = langPara("活动时间：%02d.%02d-%02d.%02d", startDateTable.month, startDateTable.day, endDateTable.month, endDateTable.day)
end

function CakesignView:_updateViewByState()
	self._isAllGain = true

	for i = 1, 10 do
		goutil.setActive(self._showPrizes[i].markHasGain, self._showPrizes[i].isHasGain)

		if not self._showPrizes[i].isHasGain then
			self._isAllGain = false
		end
	end

	self._txtBtnEat.text = self._isAllGain and "已吃完" or self._isTodayHasGain and "今日已吃" or "吃蛋糕"
end

return CakesignView
