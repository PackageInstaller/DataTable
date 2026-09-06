-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementFailView.lua

module("logic.extensions.battlesettlement.view.BattleSettlementFailView", package.seeall)

local BattleSettlementFailView = class("BattleSettlementFailView", BattleSettlementBaseView)

function BattleSettlementFailView:ctor()
	BattleSettlementFailView.super.ctor(self)
end

function BattleSettlementFailView:buildUI()
	BattleSettlementFailView.super.buildUI(self)

	self._btnStatics = self:getBtn("part2/right/team/btnStatics")
	self._settlementTeam = SettlementTeam.New()

	self._settlementTeam:buildUI(self:getGo("part2/right/team"))

	self._settlementRecommend = SettlementRecommend.New()

	self._settlementRecommend:buildUI(self:getGo("part2/right/recommend"))

	self._settlementGiveBack = SettlementGiveBack.New()

	self._settlementGiveBack:buildUI(self:getGo("part2/right/giveBack"))
	table.insert(self._settlementList, self._settlementTeam)
	table.insert(self._settlementList, self._settlementRecommend)
	table.insert(self._settlementList, self._settlementGiveBack)

	self._isSuccess = false
end

function BattleSettlementFailView:destroyUI()
	BattleSettlementFailView.super.destroyUI(self)

	self._settlementTeam = nil
	self._settlementRecommend = nil
	self._settlementGiveBack = nil
end

function BattleSettlementFailView:bindEvents()
	BattleSettlementFailView.super.bindEvents(self)
	self._btnStatics:AddClickListener(self._onClickStatics, self)
end

function BattleSettlementFailView:unbindEvents()
	BattleSettlementFailView.super.unbindEvents(self)
	self._btnStatics:RemoveClickListener()
end

function BattleSettlementFailView:onExit()
	BattleSettlementFailView.super.onExit(self)

	if ViewMgr.instance:isOpen(ViewName.BattleStatics) then
		UIStateManager.instance:popByName(ViewName.BattleStatics)
	end
end

function BattleSettlementFailView:getAudioId()
	return 30202
end

function BattleSettlementFailView:_onEnumTypeIsDefault()
	local param1 = {}

	table.insert(param1, function()
		self:_onClickClose()
	end)

	local enumType = BattleSettlementModel.instance:getType()
	local params = BattleSettlementModel.instance:getParams()

	if params and params.isShowTeam then
		self:enqueueQueue(self._settlementTeam, {
			self
		})
	end

	if not params or not params.isHideRecommend then
		self:enqueueQueue(self._settlementRecommend, param1)
	end

	if BattleSettlementModel.instance:isGiveBackTili(enumType) and params and params.giveBackStrength and params.giveBackStrength > 0 then
		local param2 = {}

		table.insert(param2, function()
			self:_onClickClose()
		end)
		self:enqueueQueue(self._settlementGiveBack, param2)
	end

	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementFailView:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function BattleSettlementFailView:_onEnumTypeIsArena()
	self._settlementQueue:enqueue(self._settlementRank)
	self._settlementParam:enqueue(nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function BattleSettlementFailView:_onEnumTypeIsKingArena()
	self._settlementQueue:enqueue(self._settlementRank)
	self._settlementParam:enqueue(nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

return BattleSettlementFailView
