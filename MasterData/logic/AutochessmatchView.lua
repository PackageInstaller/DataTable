-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmatchView.lua

module("logic.extensions.autochess.view.AutochessmatchView", package.seeall)

local AutochessmatchView = class("AutochessmatchView", ViewComponent)

function AutochessmatchView:ctor()
	AutochessmatchView.super.ctor(self)
end

function AutochessmatchView:unbindEvents()
	AutochessmatchView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
end

function AutochessmatchView:bindEvents()
	AutochessmatchView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function AutochessmatchView:buildUI()
	AutochessmatchView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
	self._btnCancel = self:getBtn("btnCancel")
	self._effectGo = self:getGo("effect")
end

function AutochessmatchView:onExit()
	AutochessmatchView.super.onExit(self)
	removetimer(self._setTimer, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function AutochessmatchView:onEnter()
	AutochessmatchView.super.onEnter(self)

	self._activityType = GameEnum.ActivityType.AutoChess
	self._activityId = AutochessModel.instance:getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("匹配失败")
		self:_onClickbtnCancel()

		return
	end

	self._targetTickTime = ServerTime.now() + AutochessConfig.instance:getMatchingWaitSec(self._activityId)

	settimer(1, self._setTimer, self, true)

	self._timeCount = 0

	self:_setTimer()
	self:_setEffect()
end

function AutochessmatchView:_onClickbtnCancel()
	AutoChessAgent.instance:sendPM_ACCancelMatchReq(self._activityId)
	self:close()
end

function AutochessmatchView:_setTimer()
	self._timeCount = self._timeCount + 1

	local min = math.floor(self._timeCount / 60)
	local sec = self._timeCount % 60

	self._txtTime.text = string.format("%02d:%02d", min, sec)

	self:_checkActOver()
end

function AutochessmatchView:_checkActOver()
	if self._timeCount % 10 == 0 then
		if ServerTime.now() >= self._targetTickTime then
			FloatWordMgr.instance:show("匹配失败")
			self:_onClickbtnCancel()

			return
		end

		local isActActive = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

		if not isActActive then
			FloatWordMgr.instance:show("不在活动时间内")
			self:_onClickbtnCancel()

			return
		end

		local isOpen = AutochessController.instance:isOpenTime(self._activityId)

		if not isOpen then
			FloatWordMgr.instance:show("不在匹配开放时间内")
			self:_onClickbtnCancel()

			return
		end
	end
end

function AutochessmatchView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_pipeizhong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return AutochessmatchView
