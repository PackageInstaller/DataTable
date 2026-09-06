-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/view/AixinmmGameStartView.lua

module("logic.extensions.aixinmmgame.view.AixinmmGameStartView", package.seeall)

local AixinmmGameStartView = class("AixinmmGameStartView", ViewComponent)

function AixinmmGameStartView:buildUI()
	AixinmmGameStartView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTimes = self:getTxt("guideBg/txtTimes")
	self._btnStart = self:getGo("guideBg/btnStart")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._itemAmout = goutil.findChild(playerRoot, "itemAmout")
	self._txtAmout = goutil.findChildTextComponent(playerRoot, "txtAmout")
	self._con = goutil.findChild(self.mainGO, "con")
end

function AixinmmGameStartView:bindEvents()
	AixinmmGameStartView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickGame, self)
end

function AixinmmGameStartView:unbindEvents()
	AixinmmGameStartView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function AixinmmGameStartView:onEnter()
	AixinmmGameStartView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = AixinmmGameController.instance:getActivityId()
	end

	self:setViewByCfg()
	self:refreshViewByInfo()
	AixinmmGameModel.instance:ShowCI()
	AixinmmGameController.instance:getInfo(self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.AixinmmGameUpdateInfo, self.refreshViewByInfo, self)
	AixinmmGameModel.instance:setDailyOpen(ViewName.AixinmmGameStartView)

	local skinId = self._actCfg.skinId

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

		if not self._actCfg.pos then
			if not self._actCfg.pos[3] then
				local posX, posY, scaleX = checknumber(self._actCfg.pos[1]), checknumber(self._actCfg.pos[2]), 1

				GameUtil.setLocalPos(self._con, posX, posY)
				GameUtil.setLocalScale(self._con, self._actCfg.pos[3], self._actCfg.pos[3])
			end
		end
	end
end

function AixinmmGameStartView:onExit()
	AixinmmGameStartView.super.onExit(self)
	self._playerSliderMo:onExit()
	MaterialMgr.resetAll(self._itemAmout)
	GlobalDispatcher:removeListener(GlobalNotify.AixinmmGameUpdateInfo, self.refreshViewByInfo, self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function AixinmmGameStartView:setViewByCfg()
	self._actCfg = AixinmmGameConfig.instance:getActCfg(self._activityId)

	MaterialMgr.setCellByCfg(self._actCfg.gameItemId, self._itemAmout)
	self:_initPlayerParams()
end

function AixinmmGameStartView:refreshViewByInfo()
	local leftTimes = AixinmmGameModel.instance:getLeftGameTimes(self._activityId)

	self._txtTimes.text = langPara("今日剩余<color=#e99a02>%s</color>次", leftTimes)

	GameUtil.SetGray(self._btnStart, leftTimes <= 0)
	self._playerSliderMo:updatePlayerReward()

	self._txtAmout.text = MaterialMgr.getMatCount(self._actCfg.gameItemId)
end

function AixinmmGameStartView:_initPlayerParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = AixinmmGameConfig.instance:getGamePrizeCfgs(self._actCfg.gamePrizePlanId)

	function playerParam.getPlayerProgress()
		return MaterialMgr.getMatCount(self._actCfg.gameItemId)
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.needScore <= MaterialMgr.getMatCount(self._actCfg.gameItemId) and not AixinmmGameModel.instance:isPlayerGameRewardGeted(rewardCfg.id)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return AixinmmGameModel.instance:isPlayerGameRewardGeted(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		AixinmmGameController.instance:getGamePrize(self._activityId, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function AixinmmGameStartView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "aixinmmgamestartview_rule")
end

function AixinmmGameStartView:_onClickGame()
	local hasUseTime = AixinmmGameModel.instance:getUseGameTimes()

	if hasUseTime < self._actCfg.dailyTimes then
		UIStateManager.instance:push(ViewName.AixinmmGameMainView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("今日没有游戏次数了。"))
	end
end

return AixinmmGameStartView
