local BattleResultFogKnightHpComp = class("BattleResultFogKnightHpComp", require("app.fairyGUI.battleResult.UI_BattleResultFogKnightHpComp"))
local var_0_1 = g.core.model.User.fogNightmareData

function BattleResultFogKnightHpComp:ctor()
	self.m_knightList:setVirtual(self)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListItemRender))
end

function BattleResultFogKnightHpComp:update(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._params = arg_2_1
	self._knightHps = arg_2_1.content.kn_hps_after

	self.m_isWinController:setSelectedIndex((arg_2_1.isWin or false) and 1 or 0)

	self._knightList = var_0_1:getFormationData():getBattleFormation()
	self._battleList = self._knightList:getKnightPosList()
	self._posList = {}

	for iter_2_0, iter_2_1 in pairs(self._battleList) do
		table.insert(self._posList, {
			knight = iter_2_1,
			pos = iter_2_0
		})
	end

	self.m_knightList:setNumItems(#self._posList)
end

function BattleResultFogKnightHpComp:_onKnightListItemRender(arg_3_1, arg_3_2)
	arg_3_2:update({
		knight = self._posList[arg_3_1 + 1].knight,
		hp = self._knightHps[self._posList[arg_3_1 + 1].pos]
	})
end

return BattleResultFogKnightHpComp
