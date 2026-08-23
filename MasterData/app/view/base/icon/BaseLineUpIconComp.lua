local var_0_0 = {
	EMPTY = 1,
	IN_BATTLE = 2,
	LOCK = 0
}
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local BaseLineUpIconComp = class("BaseLineUpIconComp", require("app.fairyGUI.base_new.UI_BaseLineUpIconComp"))

function BaseLineUpIconComp:updateComp(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	arg_1_3 = arg_1_3 or g.core.common.ModuleUnlock:isModuleUnlock(var_0_1["KNIGHT_LINE_UP_" .. arg_1_1 - 1])

	if arg_1_1 == 1 then
		arg_1_3 = true
	end

	if arg_1_3 then
		if not arg_1_2 then
			self.m_iconComp:updateIcon({
				empty = true
			})
			self.m_lineUpStateController:setSelectedIndex(var_0_0.EMPTY)
			self:setShowLevel(0)
		else
			self.m_iconComp:updateIcon(arg_1_2)

			if arg_1_4 ~= nil then
				self.m_iconComp:setShowInfoEnable(arg_1_4)
			end

			self:setShowLevel(arg_1_6)

			if arg_1_7 then
				self.m_iconComp:setAdvanceLevel(arg_1_7)
			end

			self.m_lineUpStateController:setSelectedIndex(var_0_0.IN_BATTLE)
		end
	else
		if arg_1_5 then
			self.m_iconComp:updateIcon({
				empty = true
			})
			self.m_lineUpStateController:setSelectedIndex(var_0_0.EMPTY)
		else
			self.m_iconComp:updateIcon({
				empty = true
			})
			self.m_lineUpStateController:setSelectedIndex(var_0_0.LOCK)
		end

		self:setShowLevel(0)
	end
end

function BaseLineUpIconComp:setShowLevel(arg_2_1)
	if self.m_showLevelController then
		if arg_2_1 and arg_2_1 > 0 then
			self.m_showLevelController:setSelectedIndex(1)
			self.m_levelText:setText(g.core.lang:get(100535, {
				lv = arg_2_1
			}))
		else
			self.m_showLevelController:setSelectedIndex(0)
		end
	elseif self.m_iconComp.setLevel then
		self.m_iconComp:setLevel(arg_2_1)
	end
end

return BaseLineUpIconComp
