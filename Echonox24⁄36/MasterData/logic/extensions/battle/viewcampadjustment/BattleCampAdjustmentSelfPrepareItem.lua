-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentSelfPrepareItem.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentSelfPrepareItem", package.seeall)

local M = class("BattleCampAdjustmentSelfPrepareItem", UIReusableLuaBehavior)

function M:buildUI()
	self._goPrepare = goutil.findChild(self.mainGO, "btnPVPPrepare")
	self._goCancelPrepare = goutil.findChild(self.mainGO, "prepared")
	self._btnPrepare = UIComponentType.ButtonAdapter(self._goPrepare)
	self._btnCancelPrepare = UIComponentType.ButtonAdapter(self._goCancelPrepare)
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "btnPVPPrepare/txtTime")
	self._startTimeStamp = 0
	self._timelimit = 0
	self._remainSeconds = 0
end

function M:destroyUI()
	self._goPrepare = false
	self._goCancelPrepare = false
	self._btnPrepare = false
	self._btnCancelPrepare = false
	self._txtTime = false
end

function M:bindEvents()
	self._btnPrepare:AddClickListener(self._onClickPrepare, self)
	self._btnCancelPrepare:AddClickListener(self._onClickCancelPrepare, self)
end

function M:unbindEvents()
	self._btnPrepare:RemoveClickListener()
	self._btnCancelPrepare:RemoveClickListener()
end

function M:onExit()
	self:stopCountDown()
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function M:setStartTimeStamp(timeStamp)
	self._startTimeStamp = timeStamp
end

function M:setTimelimit(timelimit)
	self._timelimit = timelimit
	self._txtTime.text = timelimit
end

function M:startCountDown()
	self._remainSeconds = self._timelimit - (ServerTime.now() - self._startTimeStamp)
	self._txtTime.text = self._remainSeconds

	settimer(1, self._onSecondTick, self, true)
end

function M:stopCountDown()
	removetimer(self._onSecondTick, self)
end

function M:_onSecondTick()
	self._remainSeconds = self._remainSeconds - 1

	if self._remainSeconds <= 0 then
		self:stopCountDown()
		self:_onTimeout()
	end

	self._txtTime.text = self._remainSeconds
end

function M:_onTimeout()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local bornUnionIndexList = BattleCampAdjustmentModel.instance:getBornUnionIndexList()

	for _, unionIndex in pairs(bornUnionIndexList) do
		if not unitMgr:getUnitOnUnionIndex(unionIndex) then
			local heroMO = self:_getNextAvailableHeroMO()

			if heroMO then
				BattleCampAdjustmentUtil.requestPlaceEntity(heroMO:getId(), unionIndex)
			end
		end
	end

	self:_onConfirmPrepare()
end

function M:_getNextAvailableHeroMO()
	local heroMOList = BattleCampAdjustmentModel.instance:getAvailableHeroMOList()

	for _, heroMO in ipairs(heroMOList) do
		if not BattleCampAdjustmentModel.instance:isForbiddenCharacterCode(heroMO:getId()) then
			return heroMO
		end
	end

	return false
end

function M:_onClickPrepare()
	local currentTeamCharacterCount = #BattleCampAdjustmentModel.instance:getCurrentTeamCharacterCodeList()
	local limitCount = BattleCampAdjustmentModel.instance:getEntityCountLimit()

	if currentTeamCharacterCount < limitCount then
		Dialog.showNotifyMessage(lang("tip_role_not_enough"), string.format(lang("tip_must_assign_role"), limitCount))

		return
	end

	self:_onConfirmPrepare()
end

function M:_onClickCancelPrepare()
	BattleAgent.instance:sendCancelReadyRequest()
	goutil.setActive(self._goPrepare, true)
	goutil.setActive(self._goCancelPrepare, false)
	self:startCountDown()
end

function M:_onConfirmPrepare()
	BattleAgent.instance:sendEndReadyRequest()
	goutil.setActive(self._goPrepare, false)
	goutil.setActive(self._goCancelPrepare, true)
	self:stopCountDown()
end

return M
