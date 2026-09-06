-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessbattleresultView.lua

module("logic.extensions.autochess.view.AutochessbattleresultView", package.seeall)

local AutochessbattleresultView = class("AutochessbattleresultView", BattleSettlementSuccessView)

function AutochessbattleresultView:buildUI()
	AutochessbattleresultView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
end

function AutochessbattleresultView:onEnter()
	self._isSuccess = BattleModel.instance.battleResult == GameEnum.BattleResult.Success

	AutochessbattleresultView.super.onEnter(self)

	local activityId = AutochessModel.instance:getActivityId()
	local time = AutochessConfig.instance:getSettleTimeSec(activityId)

	self._targetTickTime = ServerTime.now() + time

	settimer(1, self._tick, self, true)
	self:_tick()
end

function AutochessbattleresultView:onExit()
	AutochessbattleresultView.super.onExit(self)
	removetimer(self._tick, self)
end

function AutochessbattleresultView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtTime.text = string.format("%ss后自动关闭", leftTime)

	if leftTime <= 0 then
		self._txtTime.text = "点击任意空白区域关闭界面"

		self:_onClickClose()
	end
end

function AutochessbattleresultView:_onAnimEnd()
	AutochessbattleresultView.super._onAnimEnd(self)
	goutil.setActive(self._txtContinue, false)
end

function AutochessbattleresultView:_closeBattle()
	local msg = AutochessController.instance:hasGameEndMsg()

	if msg then
		if msg.state < 0 then
			AutochessbattleresultView.super._closeBattle(self)
		else
			UIStateManager.instance:push(ViewName.AutochessrankresultView)
			self:close()
		end
	else
		AutochessbattleresultView.super._closeBattle(self)
	end
end

return AutochessbattleresultView
