local var_0_0 = g.core.model.User.wushData
local WushDepthComp = class("WushDepthComp", require("app.fairyGUI.wush.UI_WushDepthComp"))
local var_0_2 = g.core.config.dead_battle_floor_info

WushDepthComp.DEPTH_UPDOWN_NUM = 5

function WushDepthComp:ctor()
	self._curFloor = 1
end

function WushDepthComp:updataDepth(arg_2_1)
	self._curFloor = arg_2_1 or 1

	self.m_curDepthTxt:setText(g.core.lang:get(303040, {
		floor = self._curFloor
	}))

	local var_2_0 = var_0_2.getLength()

	for iter_2_0 = 1, WushDepthComp.DEPTH_UPDOWN_NUM do
		if self["m_preDepthTxt" .. iter_2_0] then
			self["m_preDepthTxt" .. iter_2_0]:setText(g.core.lang:get(303040, {
				floor = self._curFloor - iter_2_0
			}))
			self["m_preDepthTxt" .. iter_2_0]:setVisible(self._curFloor - iter_2_0 >= 0)
		end

		self["m_nextDepthTxt" .. iter_2_0]:setText(g.core.lang:get(303040, {
			floor = self._curFloor + iter_2_0
		}))
		self["m_nextDepthTxt" .. iter_2_0]:setVisible(var_2_0 >= self._curFloor + iter_2_0)
	end
end

function WushDepthComp:playRollUpTransition()
	self.m_curDepthTxt:setColor(g.core.common.Color.A2)
	self.m_nextDepthTxt1:setColor(g.core.common.Color.A6)
	self:updataDepth(var_0_0:getCurFloorId() - 1)
	self.m_rollupTransition:play()
end

return WushDepthComp
