local SpireChallengeBuffItem = class("SpireChallengeBuffItem", require("app.fairyGUI.spire.UI_SpireChallengeBuffItem"))

function SpireChallengeBuffItem:ctor()
	self._buffInfo = nil
	self._isLock = false
end

function SpireChallengeBuffItem:updateBuffItem(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_2 < arg_2_1.cfg.unlock
	local var_2_1, var_2_2 = g.core.utils.String.formatPassiveSkillDesc(arg_2_1.cfg.buff)

	self.m_desTxtAuto:setText(var_2_1)
	self.m_desTxtShort:setText(var_2_1)

	local var_2_3 = self.m_txtSizeIcon:getSize()

	var_2_3.height = math.max(24, self.m_desTxtAuto:getSize().height)

	self.m_txtSizeIcon:setSize(var_2_3)
	self.m_numTxt:setText(g.core.lang:get(110411, {
		num = arg_2_1.cfg.point
	}))

	if arg_2_1.isSelect then
		self.m_isSelectedController:setSelectedIndex(1)
	else
		self.m_isSelectedController:setSelectedIndex(0)
	end

	if var_2_0 then
		self.m_isLockController:setSelectedIndex(1)
	else
		self.m_isLockController:setSelectedIndex(0)
	end

	if arg_2_3 % 2 == 0 then
		self.m_isShowBgController:setSelectedIndex(1)
	else
		self.m_isShowBgController:setSelectedIndex(0)
	end
end

return SpireChallengeBuffItem
