local var_0_0 = g.core.const.ConstMgr.RedCliffConst
local RedCliffHeartMask = class("RedCliffHeartMask", require("app.fairyGUI.redCliff.UI_RedCliffHeartMask"))

function RedCliffHeartMask:ctor()
	return
end

function RedCliffHeartMask:updateMask(arg_2_1)
	self.m_mask:setScaleY(arg_2_1 / 100)

	if arg_2_1 >= var_0_0.HP_THRESHOLD.GREEN then
		self.m_colorController:setSelectedIndex(var_0_0.HP_COLOR.GREEN)
	elseif arg_2_1 >= var_0_0.HP_THRESHOLD.YELLOW then
		self.m_colorController:setSelectedIndex(var_0_0.HP_COLOR.YELLOW)
	else
		self.m_colorController:setSelectedIndex(var_0_0.HP_COLOR.RED)
	end
end

return RedCliffHeartMask
