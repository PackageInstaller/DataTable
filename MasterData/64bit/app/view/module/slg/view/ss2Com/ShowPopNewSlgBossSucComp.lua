local ShowPopNewSlgBossSucComp = class("ShowPopNewSlgBossSucComp")

function ShowPopNewSlgBossSucComp:ctor()
	self._listRank = self:getChild("List_rank")

	self._listRank:setVirtual(self)
	self._listRank:setItemRenderer(handler(self, self._onRenderListRankCell))

	self._listAward = self:getChild("list_award")

	self._listAward:setVirtual(self)
	self._listAward:setItemRenderer(handler(self, self._onRenderListAwardCell))
end

function ShowPopNewSlgBossSucComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.onUpdateSnapShot, self)
end

function ShowPopNewSlgBossSucComp:update(arg_3_1)
	self._params = arg_3_1 or self._params

	if not arg_3_1.result then
		return
	end

	local var_3_0 = arg_3_1.result.boss_battle_result

	self._awards = arg_3_1.result.awards or {}

	self._listAward:setNumItems(#self._awards)

	self._rankArr = var_3_0.units or {}

	self._listRank:setNumItems(#self._rankArr)
end

function ShowPopNewSlgBossSucComp:onUpdateSnapShot()
	self:update(self._params)
end

function ShowPopNewSlgBossSucComp:_onRenderListRankCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._rankArr[arg_5_1 + 1])
end

function ShowPopNewSlgBossSucComp:_onRenderListAwardCell(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._awards[arg_6_1 + 1])
end

return ShowPopNewSlgBossSucComp
