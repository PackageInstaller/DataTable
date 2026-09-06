-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaSweepSelectView.lua

module("logic.extensions.arena.view.ArenaSweepSelectView", package.seeall)

local ArenaSweepSelectView = class("ArenaSweepSelectView", ViewComponent)

function ArenaSweepSelectView:ctor()
	ArenaSweepSelectView.super.ctor(self)
end

function ArenaSweepSelectView:destroyUI()
	ArenaSweepSelectView.super.destroyUI(self)
end

function ArenaSweepSelectView:onExitFinished()
	ArenaSweepSelectView.super.onExitFinished(self)
end

function ArenaSweepSelectView:onEnterFinished()
	ArenaSweepSelectView.super.onEnterFinished(self)
end

function ArenaSweepSelectView:unbindEvents()
	ArenaSweepSelectView.super.unbindEvents(self)
	self.closeButton:RemoveClickListener()
	self.btnSweepOne:RemoveClickListener()
	self.btnSweepMul:RemoveClickListener()
end

function ArenaSweepSelectView:bindEvents()
	ArenaSweepSelectView.super.bindEvents(self)
	self.closeButton:AddClickListener(self._onClickClose, self)
	self.btnSweepOne:AddClickListener(GameUtil.handler(self._onClickSweep, self, 1))
	self.btnSweepMul:AddClickListener(GameUtil.handler(self._onClickSweep, self, 5))
end

function ArenaSweepSelectView:onExit()
	ArenaSweepSelectView.super.onExit(self)
	ArenaController.instance:unregisterLocalNotify("RefreshArenaInfo", self.refresh, self)
	ArenaController.instance:unregisterLocalNotify(ArenaController.RefreshChallengeTimes, self._refreshChallengeTimes, self)
end

function ArenaSweepSelectView:buildUI()
	ArenaSweepSelectView.super.buildUI(self)

	self.closeButton = self:getBtn("btnClose")
	self.btnSweepOne = self:getBtn("btnSweepOne")
	self.btnSweepMul = self:getBtn("btnSweepMul")
	self.txtOne = goutil.findChildTextComponent(self.mainGO, "txtOne")
	self.txtMul = goutil.findChildTextComponent(self.mainGO, "txtMul")
	self.txtTimes = goutil.findChildTextComponent(self.mainGO, "txtTimes")
	self.txtTips = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self.txtTips.text = "每次扫荡都可获得 <color=#3E81CCFF>" .. ArenaConfig.instance:getValue("WIN_ADD_ARENA_SCORE") .. "</color>         竞技币"
end

function ArenaSweepSelectView:onEnter()
	ArenaSweepSelectView.super.onEnter(self)
	ArenaController.instance:registerLocalNotify("RefreshArenaInfo", self.refresh, self)
	ArenaController.instance:registerLocalNotify(ArenaController.RefreshChallengeTimes, self._refreshChallengeTimes, self)
	self:refresh()
end

function ArenaSweepSelectView:_refreshChallengeTimes()
	self:refresh()
end

function ArenaSweepSelectView:_onClickClose()
	self:close()
end

function ArenaSweepSelectView:_onClickSweep(time)
	local leftTime = ArenaModel.instance:getLeftChallengeTimes()

	if leftTime <= 0 then
		local buyTimes = ArenaModel.instance:getChallengeBuyTime()
		local totalCanBuyTimes = VipModel.instance:getAbleToBuyTimesOfArena()
		local leftBuyCnt = totalCanBuyTimes - buyTimes

		if leftBuyCnt > 0 then
			ArenaController.instance:buyClgTime()

			return
		end
	end

	ArenaController.instance:trySweepInSelectView(time)
end

function ArenaSweepSelectView:refresh()
	local canClgCount = ArenaModel.instance:getLeftChallengeTimes()
	local totalCnt = ArenaModel.instance:getChallengeMaxTimes()

	self.txtTimes.text = "挑战次数：" .. canClgCount .. "/" .. totalCnt
end

return ArenaSweepSelectView
