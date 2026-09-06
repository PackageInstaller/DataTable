-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushMatchView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushMatchView", package.seeall)

local AbyssGoldRushMatchView = class("AbyssGoldRushMatchView", ViewComponent)

function AbyssGoldRushMatchView:ctor()
	AbyssGoldRushMatchView.super.ctor(self)
end

function AbyssGoldRushMatchView:unbindEvents()
	AbyssGoldRushMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBubble)
	self._customInput:RemoveListener()
end

function AbyssGoldRushMatchView:bindEvents()
	AbyssGoldRushMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBubble, self._onClickShowBubble, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AbyssGoldRushMatchView:buildUI()
	AbyssGoldRushMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._txtTime = self:getTxt("matching/imgTitle/txtTime")
	self._btnCancel = self:getGo("matching/btnCancel")
	self._txtHolyStripePrize = self:getTxt("floorInfo_3/holyStripePrize/txt")
	self._prizeDesc = {}

	for i = 1, 3 do
		self._prizeDesc[i] = self:getTxt("bubblePrize/txtPrizeDesc_" .. i)
	end

	self._bubblePrize = self:getGo("bubblePrize")
	self._customInput = UICustomInput.Get(self._bubblePrize)
	self._btnClose = self:getGo("btnClose")
	self._btnBubble = self:getGo("btnBubble")
	self._matchCon = self:getGo("matchCon")
end

function AbyssGoldRushMatchView:onExit()
	AbyssGoldRushMatchView.super.onExit(self)
	removetimer(self._updateTimer, self)

	if self._matchObj then
		RoleObjectPool.instance:removeRole(self._matchObj)
	end
end

function AbyssGoldRushMatchView:onEnter()
	AbyssGoldRushMatchView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	self._holyStripeIds = params[2] or {}

	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushStartGameRes, self._handleStartGameRes, self)

	for i = 1, 3 do
		local roundCfg = AbyssGoldRushConfig.instance:getRoundCfg(self._activityId, i)

		self._prizeDesc[i].text = roundCfg.prizeDesc
	end

	local scoreLevel = AbyssGoldRushController.instance:getCurScoreLevel(self._activityId)
	local scoreCfg = AbyssGoldRushConfig.instance:getScoreLevelCfg(self._activityId, scoreLevel)

	self._txtHolyStripePrize.text = scoreCfg.holyStripeDropDesc

	self:_startMatch()

	local path = "character/shenyuantaojin_pipei/shenyuantaojin_pipei-ui_p.prefab"

	RoleObjectPool.instance:addSpineToParent(self._matchObj, path, self._matchCon, 1, nil, 0, 0)
end

function AbyssGoldRushMatchView:_startMatch()
	goutil.setActive(self._matching, true)

	self._timer = 0
	self._timeCount = 0
	self._hasSendStart = false
	self._timeStepLegth = math.random(8, 12)
	self._txtTime.text = langPara("正在匹配中...%ds", self._timer)

	settimer(1, self._updateTimer, self, true)
end

function AbyssGoldRushMatchView:_updateTimer()
	self._timer = self._timer + 1

	local timeStep = math.floor(self._timer / self._timeStepLegth)

	if not self._hasSendStart and timeStep > self._timeCount then
		self._timeCount = timeStep
		self._hasSendStart = true

		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushStartGameReq(self._activityId, self._holyStripeIds)
	end

	self._txtTime.text = langPara("正在匹配中...%ds", self._timer)
end

function AbyssGoldRushMatchView:_handleStartGameRes(msg)
	if checknumber(msg.activityId) ~= self._activityId then
		return
	end

	removetimer(self._updateTimer, self)
	self:close()
	UIStateManager.instance:push(ViewName.AbyssGoldRushMatchSucView, self._activityId)
end

function AbyssGoldRushMatchView:_onClickShowBubble()
	GameUtil.SetActive(self._bubblePrize, true)
end

function AbyssGoldRushMatchView:_onCustomInputCallback(hover, index)
	if not hover then
		GameUtil.SetActive(self._bubblePrize, false)
	end
end

return AbyssGoldRushMatchView
