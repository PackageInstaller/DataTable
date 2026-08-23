local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local OutpostFormationArenaComp = class("OutpostFormationArenaComp", require("app.fairyGUI.outpost.UI_OutpostFormationArenaComp"))

function OutpostFormationArenaComp:ctor()
	self._arenaInfo = nil
	self._knightList = {}

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightRenderer))
	self.m_selArenaBtn:addClickListener(handler(self, self.onClickChangeArena))
	self:addListen(self.m_knightList)
end

function OutpostFormationArenaComp:updateArenaInfo(arg_2_1)
	self.m_unlockController:setSelectedIndex(arg_2_1.isOpen and 1 or 0)

	if not arg_2_1.isOpen then
		self.m_unlockStr:setText(g.core.model.User.outpostData:getArenaUnlockTipStr(arg_2_1.cfg))
	end

	self._arenaInfo = arg_2_1

	self:setTitle(arg_2_1.name)
	self.m_selArenaBtn:setTitle(g.core.lang:get(432603) .. arg_2_1.name)
	self.m_unlockController:setSelectedIndex(arg_2_1.isOpen and 1 or 0)
	self.m_bgController:setSelectedIndex(arg_2_1.arena == 1 and 0 or 1)
end

function OutpostFormationArenaComp:onClickChangeArena()
	self:dispatchCompEvent("OutpostFormationArenaComp_changeArena", {
		arena = self._arenaInfo.arena
	})
end

function OutpostFormationArenaComp:_onKnightRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateKnight(self._knightList[arg_4_1 + 1], self._arenaInfo.arena, self._needClear)
end

function OutpostFormationArenaComp:updateArenaState(arg_5_1, arg_5_2, arg_5_3)
	self._knightList = arg_5_1

	if arg_5_3 then
		self.m_stateController:setSelectedIndex(0)

		self._needClear = arg_5_3
	elseif arg_5_2 then
		self.m_stateController:setSelectedIndex(arg_5_2 == self._arenaInfo.arena and 0 or 1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_knightList:setNumItems(#self._knightList)

	if #self._knightList > 0 then
		self.m_fightValueTxt:setText(OutpostCommon.calcKnightFightValue(self._knightList))
	else
		self.m_fightValueTxt:setText(0)
	end

	self._needClear = false
end

return OutpostFormationArenaComp
