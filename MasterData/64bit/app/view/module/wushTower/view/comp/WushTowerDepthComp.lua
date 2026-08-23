local var_0_0 = g.core.model.User.wushTowerData
local var_0_1 = g.core.const.ConstMgr.WushTowerConst
local WushTowerDepthComp = class("WushTowerDepthComp", require("app.fairyGUI.wushTower.UI_WushTowerDepthComp"))

function WushTowerDepthComp:ctor()
	self._curFloor = 1
end

function WushTowerDepthComp:updateTowerDepth(arg_2_1)
	self._curFloor = arg_2_1 or 1

	self.m_curDepthTxt:setText(g.core.lang:get(303040, {
		floor = self._curFloor
	}))

	local var_2_0 = var_0_0:getMaxZoneId()

	for iter_2_0 = 1, var_0_1.DEPTH_UPDOWN_NUM do
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

function WushTowerDepthComp:playRollUpTransition()
	self.m_curDepthTxt:setColor(g.core.common.Color.A2)
	self.m_nextDepthTxt1:setColor(g.core.common.Color.A6)
	self:updateTowerDepth(var_0_0:getZoneId() - 1)
	self.m_rollupTransition:play()
end

return WushTowerDepthComp
