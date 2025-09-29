-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentUserItemView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentUserItemView", package.seeall)

local M = class("BattleCampAdjustmentUserItemView", UIReusableLuaBehavior)

function M:buildUI()
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtPlayerName")
	self._imgHead = goutil.findChildImageComponent(self.mainGO, "imgHead")
	self._userId = 0
	self._startTimeStamp = 0
	self._timelimit = 0
	self._remainSeconds = 0
end

function M:destroyUI()
	self._txtContent = false
	self._txtName = false
	self._imgHead = false
end

function M:onExit()
	self:stopCountDown()
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function M:getUserId()
	return self._userId
end

function M:setStartTimeStamp(timeStamp)
	self._startTimeStamp = timeStamp
end

function M:setTimelimit(timelimit)
	self._timelimit = timelimit
	self._txtContent.text = timelimit
end

function M:setUserInfoMO(userInfoMO)
	self._userId = userInfoMO.userId
	self._txtName.text = userInfoMO.nickname

	IconLoader.setSprite(self._imgHead, IconType.HeadIcon, userInfoMO:getIconName())
end

function M:startCountDown()
	self._remainSeconds = self._timelimit - (ServerTime.now() - self._startTimeStamp)
	self._txtContent.text = self._remainSeconds

	settimer(1, self._onSecondTick, self, true)
end

function M:stopCountDown()
	removetimer(self._onSecondTick, self)
end

function M:setPrepared()
	self:stopCountDown()

	self._txtContent.text = "已准备"
end

function M:_onSecondTick()
	self._remainSeconds = self._remainSeconds - 1

	if self._remainSeconds <= 0 then
		self:_handleTimeout()
	end

	self._txtContent.text = self._remainSeconds
end

function M:_handleTimeout()
	self:stopCountDown()

	local netStateMgr = BattleMgr.instance:getMultiPlayerNetStateMgr()

	if not netStateMgr:isUserOnline(self._userId) then
		self._txtContent.text = "等待重连"
	end
end

return M
