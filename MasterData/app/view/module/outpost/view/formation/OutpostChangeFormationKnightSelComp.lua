local var_0_0 = g.core.model.User.outpostData
local OutpostChangeFormationKnightSelComp = class("OutpostChangeFormationKnightSelComp", require("app.fairyGUI.outpost.UI_OutpostChangeFormationKnightSelComp"))

function OutpostChangeFormationKnightSelComp:ctor()
	self._struct = nil

	self:addClickListener(handler(self, self.onClickChangeState))
end

function OutpostChangeFormationKnightSelComp:onClickChangeState()
	if self._struct then
		if self._struct:isOwn() then
			if self._struct:isLineUp() then
				g.core.network.GameNetProxy:send_C2S_Outpost_Knight_Exit({
					knights = {
						self._struct:toProtoOutpostKnight()
					}
				})
			elseif var_0_0:getKnightsData():isCanLineUp() then
				g.core.network.GameNetProxy:send_C2S_Outpost_Knight_Entrance({
					advance_ids = var_0_0:getLineupAdvanceIdPosMap({
						self._struct:getCfg().advance_id
					})
				})
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(432601))
			end
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(432644))
		end
	end
end

function OutpostChangeFormationKnightSelComp:updateKnight(arg_3_1)
	self._struct = arg_3_1

	self.m_knightComp:updateKnightWithStruct(arg_3_1)

	if arg_3_1:isOwn() then
		self.m_stateController:setSelectedIndex(self._struct:isLineUp() and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(2)
	end
end

return OutpostChangeFormationKnightSelComp
