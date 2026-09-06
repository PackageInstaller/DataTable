-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManJumpFloorGameView.lua

module("logic.extensions.jumpfloor.view.BeastRichManJumpFloorGameView", package.seeall)

local BeastRichManJumpFloorGameView = class("BeastRichManJumpFloorGameView", JumpFloorGameView)

function BeastRichManJumpFloorGameView:_initGame()
	if self._gameMode == JumpFloorModel.LevelMode then
		goutil.setActive(self._slider.gameObject, true)
		goutil.setActive(self._endlessNum, false)

		self._baseJumpFloorGame = self._levelJumpFloorGame

		local cfg = JumpFloorConfig.instance:getStageById(self._stagePlanId, self._stageId)

		self._baseJumpFloorGame:init(cfg.stageJsonData, cfg.limitTime)
	else
		goutil.setActive(self._slider.gameObject, false)
		goutil.setActive(self._endlessNum, true)

		self._baseJumpFloorGame = self._endlessJumpFloorGame

		local countdown = 60

		self._baseJumpFloorGame:init(self:getJsonDataList(), countdown)
	end

	self._baseJumpFloorGame:addListener(BaseJumpFloorGame.UpdateStageMap, self._updateStageMap, self)
	self._baseJumpFloorGame:addListener(BaseJumpFloorGame.UpdateShield, self._updateShield, self)
	self._baseJumpFloorGame:addListener(BaseJumpFloorGame.TriggerTrap, self._onTriggerTrap, self)
	self:_initStageMap()
end

function BeastRichManJumpFloorGameView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.RULES_VIEW_EXIT, self._onRuleViewExit, self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onHandleGridRes, self)

	self._params = self:getOpenParam()
	self._richManActivityId = checknumber(self._params[1])
	self._zoneId = checknumber(self._params[2])
	self._gridId = checknumber(self._params[3])
	self._gameMode = JumpFloorModel.EndlessMode
	self._activityId = 235005
	self._stagePlanId = 1
	self._stageId = 0
	self._clientKey = self:_getRandomNum()
	self._serverKey = 0
	self._floorCellList = {}
	self._floorCellDic = {}
	self._delCellList = {}
	self._addCellList = {}
	self._curCellData = nil
	self._curFloorCell = nil
	self._isFinishGame = false
	self._isCanClick = true

	self:_initGameObjectState()
	self:_initGame()
	settimer(0.2, self._onUpdate, self)
end

function BeastRichManJumpFloorGameView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.RULES_VIEW_EXIT, self._onRuleViewExit, self)
	self._baseJumpFloorGame:removeListener(BaseJumpFloorGame.UpdateStageMap, self._updateStageMap, self)
	self._baseJumpFloorGame:removeListener(BaseJumpFloorGame.UpdateShield, self._updateShield, self)
	self._baseJumpFloorGame:removeListener(BaseJumpFloorGame.TriggerTrap, self._onTriggerTrap, self)
	self._baseJumpFloorGame:reset()
	self:_recycleFloorCells()
	self:_clearTweens()
	self:_clearFloorCellDic()
	self._roleCell:reset()
	removetimer(self._onUpdate, self)
end

function BeastRichManJumpFloorGameView:_onClickBeginGame()
	if self._gameMode == JumpFloorModel.LevelMode then
		if self._activityId > 0 then
			JumpFloorController.instance:sendLevelGameStartReq(self._activityId, self._stageId, self._clientKey)
		else
			self:_startGame()
		end
	else
		self:_startGame()
	end
end

function BeastRichManJumpFloorGameView:_sendEndGameReq()
	if self._activityId <= 0 then
		return
	end

	local totalScore = self._baseJumpFloorGame:getCurPassFloors()
	local tb = {
		onekey = false,
		annual = false,
		score = totalScore
	}
	local param = GameUtil.jsonToString(tb)

	BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._richManActivityId, self._zoneId, self._gridId, param)
end

function BeastRichManJumpFloorGameView:_onGameOver()
	local curCol = self._curCellData:getCol()

	if curCol == self._baseJumpFloorGame:getDestinationFloorCol() then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)

		local str = self:_getPopupStr(true, self._gameMode)

		self:_showPopupView(str)

		return
	end

	if self._curCellData:getCellType() == JumpFloorCellData.ECellType.Empty then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)

		local str = self:_getPopupStr(false, self._gameMode)

		self:_showPopupView(str)

		return
	end

	if self._baseJumpFloorGame:getCountdown() <= 0 then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)

		local str = self:_getPopupStr(false, self._gameMode)

		self:_showPopupView(str)

		return
	end

	if self._baseJumpFloorGame:isForceEnd() then
		self._baseJumpFloorGame:gameEnd()
		removetimer(self._onUpdate, self)
		self:_sendEndGameReq()

		local isPass = true
		local passFloors = self._baseJumpFloorGame:getCurPassFloors()

		self:_doFinfishCallBack(isPass, passFloors)

		return
	end

	self._isCanClick = true

	self._baseJumpFloorGame:handleBuff()
end

function BeastRichManJumpFloorGameView:_showPopupView(text, callback)
	local isPass = true
	local passFloors = self._baseJumpFloorGame:getCurPassFloors()

	self:_sendEndGameReq()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), text, function()
		GameUtil.callBack(callback)
		self:_doFinfishCallBack(isPass, passFloors)
	end)
end

function BeastRichManJumpFloorGameView:_onHandleGridRes()
	BeastRichmanController.instance:tryPopCurScore(self._richManActivityId)
	self:close()
end

function BeastRichManJumpFloorGameView:_showPopupView(text, callback)
	local isPass = true
	local passFloors = self._baseJumpFloorGame:getCurPassFloors()

	self:_sendEndGameReq()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), text, function()
		GameUtil.callBack(callback)
		self:_doFinfishCallBack(isPass, passFloors)
	end)
end

return BeastRichManJumpFloorGameView
