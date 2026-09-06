-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/view/CantoneseoperaView.lua

module("logic.extensions.cantoneseopera.view.CantoneseoperaView", package.seeall)

local CantoneseoperaView = class("CantoneseoperaView", ViewComponent)

function CantoneseoperaView:ctor()
	CantoneseoperaView.super.ctor(self)
end

function CantoneseoperaView:unbindEvents()
	CantoneseoperaView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnMove)

	for i, v in ipairs(self.btnList) do
		GameUtil.rmClickHandler(v)
	end
end

function CantoneseoperaView:bindEvents()
	CantoneseoperaView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickHelp, self)
	GameUtil.addClickHandler(self.btnMove, self.onClickMove, self)

	for i, v in ipairs(self.btnList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self.onClickBtn, self, i))
	end
end

function CantoneseoperaView:buildUI()
	CantoneseoperaView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.roadPoints = {}

	local road = self:getGo("road")
	local childCount = road.transform.childCount

	for i = 1, childCount do
		local selectGo = self:getGo("road/road_" .. i .. "/select")

		GameUtil.SetActive(selectGo, false)
		table.insert(self.roadPoints, selectGo)
	end

	self.btnList = {}

	for i = 1, 5 do
		local btn = self:getGo("cells/btn_" .. i)

		table.insert(self.btnList, btn)
	end

	self.txtBubble = self:getTxt("cells/bubble/txtDesc")
	self.btnMove = self:getGo("btnMove")
	self.txtTime = self:getTxt("time/txt")
end

function CantoneseoperaView:onExit()
	CantoneseoperaView.super.onExit(self)
	removetimer(self.onTimer, self)
	self:clearAllEff()
	GlobalDispatcher:removeListener(GlobalNotify.OnCantoneseOperaMove, self.onMoveNext, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnCantoneseOperaInfo, self.refreshUI, self)
end

function CantoneseoperaView:onEnter()
	CantoneseoperaView.super.onEnter(self)

	self.isTimeRunning = false
	self.targetIdx = 0
	self.curRoadIdx = 0
	self.targetRoadIdx = 0
	self.activityId = CantoneseOperaController.instance:getActivityId()
	self.effectList = {}

	GlobalDispatcher:addListener(GlobalNotify.OnCantoneseOperaMove, self.onMoveNext, self)
	GlobalDispatcher:addListener(GlobalNotify.OnCantoneseOperaInfo, self.refreshUI, self)
	CantoneseOperaController.instance:getInfo()
	self:refreshUI()
end

local btnEffectPath = "fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab"

function CantoneseoperaView:refreshUI()
	self.targetIdx = CantoneseOperaController.instance.curNodeId

	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
	local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, self.targetIdx) or {}
	local curRoadIdx = checknumber(planCfg.roadIdx)

	self.curRoadIdx = checknumber(curRoadIdx)

	for i, select in ipairs(self.roadPoints) do
		GameUtil.SetActive(select, i <= self.curRoadIdx)
	end

	self:clearAllEff()

	for i, btn in ipairs(self.btnList) do
		GameUtil.SetGray(btn, i > checknumber(self.targetIdx))

		local txt = goutil.findChildTextComponent(btn, "txt")
		local tmp = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, i) or {}

		txt.text = tmp.name

		if i <= checknumber(self.targetIdx) then
			local hasGet = CantoneseOperaController.instance:checkHasGetPrize(i)

			if not hasGet then
				local eff = goutil.findChild(btn, "eff")
				local btnUIEffect = UIEffectManager.instance:playEffect(self, btnEffectPath, eff.transform, 0, 0, true, false)

				btnUIEffect:setParent(eff.transform)
				btnUIEffect:setScale(1)
				btnUIEffect:setLocalPos(0, 0, 0)
				table.insert(self.effectList, btnUIEffect)
			end
		end
	end

	self.txtBubble.text = langPara("全服已有\n<color=#20b376>%s</color>人达成", CantoneseOperaController.instance.userEndNum)

	GameUtil.SetGray(self.btnMove, CantoneseOperaController.instance.hasGoTimeToday > 0)
	self:setMoveBtnState()

	local activityType = math.floor(checknumber(self.activityId) / 1000)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self.activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self.txtTime.text = langPara("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function CantoneseoperaView:clearAllEff()
	for i, eff in ipairs(self.effectList or {}) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self.effectList = {}
end

function CantoneseoperaView:setMoveBtnState()
	GameUtil.SetActive(self.btnMove, true)

	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
	local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, self.targetIdx) or {}

	if planCfg.isLast == 1 then
		local hasGet = CantoneseOperaController.instance:checkHasGetPrize(self.targetIdx)

		if hasGet then
			GameUtil.SetActive(self.btnMove, false)
		end
	end
end

function CantoneseoperaView:onClickHelp()
	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}

	UIStateManager.instance:push(ViewName.RulesView, infoCfg.ruleId)
end

function CantoneseoperaView:onClickBtn(idx)
	if self.isTimeRunning == false then
		if idx > checknumber(self.targetIdx) then
			TipsFacade.instance:openCommonTips(lang("本文化节点尚未解锁，继续前进即可解锁"))
		else
			local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
			local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, idx) or {}

			if planCfg.isLast == 1 then
				local hasGet = CantoneseOperaController.instance:sendGainPrize(idx)

				if hasGet then
					TipsFacade.instance:openCommonTips(lang("恭喜你探索完成粤剧文化之路，成功领取【粤剧大使】称号哦~"))
				end
			else
				UIStateManager.instance:push(ViewName.CantoneseoperadetailView, idx)
			end
		end
	else
		TipsFacade.instance:openCommonTips(lang("请稍候~"))
	end
end

function CantoneseoperaView:onClickMove()
	CantoneseOperaController.instance:moveNext()
end

function CantoneseoperaView:onMoveNext()
	GameUtil.SetGray(self.btnMove, CantoneseOperaController.instance.hasGoTimeToday > 0)
	self:moveToIdx(CantoneseOperaController.instance.curNodeId)
end

function CantoneseoperaView:moveToIdx(targetIdx)
	self.targetIdx = targetIdx

	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
	local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, self.targetIdx) or {}
	local curRoadIdx = planCfg.roadIdx

	self.targetRoadIdx = checknumber(curRoadIdx)

	self:setMoveBtnState()

	if self.isTimeRunning == false then
		self.isTimeRunning = true

		settimer(0.3, self.onTimer, self)
	end
end

function CantoneseoperaView:onTimer()
	if self.curRoadIdx == self.targetRoadIdx then
		self.isTimeRunning = false

		removetimer(self.onTimer, self)

		for i, btn in ipairs(self.btnList) do
			GameUtil.SetGray(btn, i > checknumber(self.targetIdx))
		end
	else
		self.curRoadIdx = self.curRoadIdx + 1

		for i, select in ipairs(self.roadPoints) do
			GameUtil.SetActive(select, i <= checknumber(self.curRoadIdx))
		end
	end
end

return CantoneseoperaView
