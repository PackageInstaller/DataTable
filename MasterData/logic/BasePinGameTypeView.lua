-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/BasePinGameTypeView.lua

module("logic.extensions.pingame.view.BasePinGameTypeView", package.seeall)

local BasePinGameTypeView = class("BasePinGameTypeView", ViewComponent)

function BasePinGameTypeView:ctor()
	return
end

function BasePinGameTypeView:buildUI()
	BasePinGameTypeView.super.buildUI(self)

	self._obstacle = self:getGo("obstacle")
	self._needle = self:getGo("needle")

	goutil.setActive(self._obstacle, false)
	goutil.setActive(self._needle, false)

	self._rootCellList = {}

	local root1 = self:getGo("root1")
	local root2 = self:getGo("root2")

	table.insert(self._rootCellList, PinGameRootCell.New(root1, self._obstacle, self._needle))

	if root2 then
		table.insert(self._rootCellList, PinGameRootCell.New(root2, self._obstacle, self._needle))
	end

	self._btnShoot = self:getBtn("btnShoot")
	self._txtLeftCount = self:getTxt("txtLeftCount")
end

function BasePinGameTypeView:bindEvents()
	BasePinGameTypeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShoot, self._onClickShoot, self)
end

function BasePinGameTypeView:unbindEvents()
	BasePinGameTypeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShoot)
end

function BasePinGameTypeView:onEnter()
	BasePinGameTypeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._mode = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._isLocalGame = checkbool(params[3])
	self._activityId = checknumber(params[4])

	if self._isLocalGame and self._activityId > 0 then
		local cfg = PinGameConfig.instance:getGameMode(self._activityId, self._mode)

		self._stagePlanId = cfg.stagePlanId
	else
		self._stagePlanId = params[1]
	end

	PinGameController.instance:registerLocalNotify(PinGameController.StartGameEvent, self._onStartGame, self)
	PinGameController.instance:registerLocalNotify(PinGameController.ClickExitEvent, self._onExitGame, self)
	PinGameController.instance:registerLocalNotify(PinGameController.UpdateNeedleLeftNumEvent, self._onUpdateNeedleLeftNum, self)
	self.addGEvent(self, GlobalNotify.PinGameRecoverRes, self._onPinGameRecoverRes, self)
	PinGameController.instance:localNotify(PinGameController.ReadyGoEvent)

	self._reviveData = {
		maxNum = 0,
		curNum = 0
	}

	if self._isLocalGame and self._activityId > 0 then
		local cfgs = PinGameConfig.instance:getRecoverCost(self._activityId)

		self._reviveData.maxNum = #cfgs
	end

	self:_initGameData()
	self:_initGameState()
end

function BasePinGameTypeView:onExit()
	BasePinGameTypeView.super.onExit(self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.StartGameEvent, self._onStartGame, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.ClickExitEvent, self._onExitGame, self)
	PinGameController.instance:unregisterLocalNotify(PinGameController.UpdateNeedleLeftNumEvent, self._onUpdateNeedleLeftNum, self)
	self:_onExitGame()
end

function BasePinGameTypeView:_onClickShoot()
	printInfo("test BasePinGameTypeView:_onClickShoot")
	PinGameController.instance:localNotify(PinGameController.ClickShootEvent)
end

function BasePinGameTypeView:_onStartGame()
	printInfo("test BasePinGameTypeView:_onStartGame 开始游戏")
	self:_startGame()
end

function BasePinGameTypeView:_onExitGame()
	printInfo("test BasePinGameTypeView:_onExitGame")

	for i, v in ipairs(self._rootCellList) do
		v:clearGameState()
	end
end

function BasePinGameTypeView:_onUpdateNeedleLeftNum(num)
	self._txtLeftCount.text = string.format("%d", num)
end

function BasePinGameTypeView:_onPinGameRecoverRes()
	printInfo("test BasePinGameTypeView:_onPinGameRecoverRes")

	self._reviveData.curNum = self._reviveData.curNum + 1

	self:_playFromPause()
end

function BasePinGameTypeView:_getGameData()
	return (PinGameConfig.instance:getStageParam(self._stagePlanId, self._stageId))
end

function BasePinGameTypeView:_initGameData()
	self._gameData = self:_getGameData()
end

function BasePinGameTypeView:_initGameState()
	GameUtil.SetActive(self._obstacle, false)
	GameUtil.SetActive(self._needle, false)

	for i, v in ipairs(self._rootCellList) do
		if self._gameData[i] then
			v:initGameState(self._gameData[i], self._mode, self._stagePlanId, self._stageId, self._isLocalGame, self._activityId, self._reviveData)
		else
			printError("BasePinGameTypeView:_initGameState 游戏数据缺失:", "stagePlanId = ", self._stagePlanId, "stageId = ", self._stageId)
		end
	end
end

function BasePinGameTypeView:_startGame()
	for i, v in ipairs(self._rootCellList) do
		v:startGameState()
	end
end

function BasePinGameTypeView:_resetGame()
	printInfo("test BasePinGameTypeView:_resetGame")
	self:_initGameState()
	self:_startGame()
end

function BasePinGameTypeView:_playFromPause()
	printInfo("test BasePinGameTypeView:_playFromPause")

	for i, v in ipairs(self._rootCellList) do
		v:playFromPause()
	end
end

return BasePinGameTypeView
