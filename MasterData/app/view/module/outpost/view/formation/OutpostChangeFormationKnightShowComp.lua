local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.model.User.outpostData
local OutpostChangeFormationKnightShowComp = class("OutpostChangeFormationKnightShowComp", require("app.fairyGUI.outpost.UI_OutpostChangeFormationKnightShowComp"))

function OutpostChangeFormationKnightShowComp:ctor()
	self._selPosIndex = 0
	self._struct = nil

	self:addClickListener(handler(self, self.onKnightLineDownClick))
end

function OutpostChangeFormationKnightShowComp:onKnightLineDownClick()
	if self._struct then
		g.core.network.GameNetProxy:send_C2S_Outpost_Knight_Exit({
			knights = {
				self._struct:toProtoOutpostKnight()
			}
		})
	end
end

function OutpostChangeFormationKnightShowComp:updateWithPosStation(arg_3_1, arg_3_2)
	self._selPosIndex = arg_3_2

	if arg_3_1 < arg_3_2 then
		self.m_stateController:setSelectedIndex(2)

		if arg_3_2 - arg_3_1 == 1 then
			self.m_lockStrTxt:setText(g.core.lang:get(432606, {
				level = var_0_1:getBuildData():getBuild({
					type = var_0_0.BuildType.Main
				}):getKnightPosLevel(self._selPosIndex)
			}))
		end
	else
		local var_3_0 = var_0_1:getKnightsData():getKnightIdByPos(arg_3_2)

		if var_3_0 then
			self.m_stateController:setSelectedIndex(1)

			local var_3_1 = var_0_1:getKnightsData():getKnightBySid(var_3_0)

			self._struct = var_3_1

			self.m_knightLoader:setURL(g.core.common.Path:getKnightCartoonById(var_3_1:getCfg().advance_id))
		else
			self.m_stateController:setSelectedIndex(0)
		end
	end
end

return OutpostChangeFormationKnightShowComp
