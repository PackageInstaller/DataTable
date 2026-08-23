local ShowPopNewSlgBossFailComp = class("ShowPopNewSlgBossFailComp")

function ShowPopNewSlgBossFailComp:ctor()
	self._listRank = self:getChild("List_rank")

	self._listRank:setVirtual(self)
	self._listRank:setItemRenderer(handler(self, self._onRenderListRankCell))
end

function ShowPopNewSlgBossFailComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.onUpdateSnapShot, self)
end

function ShowPopNewSlgBossFailComp:update(arg_3_1)
	self._params = arg_3_1 or self._params

	if not arg_3_1.result then
		return
	end

	self._rankArr = arg_3_1.result.boss_battle_result.units or {}

	self._listRank:setNumItems(#self._rankArr)
end

function ShowPopNewSlgBossFailComp:onUpdateSnapShot()
	self:update(self._params)
end

function ShowPopNewSlgBossFailComp:_onRenderListRankCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._rankArr[arg_5_1 + 1])
end

return ShowPopNewSlgBossFailComp
