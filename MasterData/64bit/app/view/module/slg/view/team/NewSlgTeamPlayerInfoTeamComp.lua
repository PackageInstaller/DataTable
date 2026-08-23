local NewSlgTeamPlayerInfoTeamComp = class("NewSlgTeamPlayerInfoTeamComp", require("app.fairyGUI.newSlg.UI_NewSlgTeamPlayerInfoTeamComp"))

function NewSlgTeamPlayerInfoTeamComp:updateTeamComp(arg_1_1, arg_1_2)
	self.m_title:setText(g.core.lang:get(429535, {
		index = arg_1_2
	}))

	if arg_1_1 and arg_1_1.authority then
		self.m_authority:setText(arg_1_1.authority)
		self.m_authorityGroup:setVisible(true)
	else
		self.m_authorityGroup:setVisible(false)
	end

	local var_1_0

	if arg_1_1 then
		var_1_0 = arg_1_1.characters or {}
	end

	local var_1_1 = {}

	for iter_1_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX do
		self["m_knight" .. iter_1_0]:updateKnightIcon(var_1_0[iter_1_0])

		if var_1_0[iter_1_0] then
			local var_1_2 = g.core.config.knight_info.get(var_1_0[iter_1_0].base_id)

			if var_1_2.classical ~= 0 then
				var_1_1[#var_1_1 + 1] = var_1_2.classical
			end
		end
	end

	local var_1_3 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_1_1)

	if var_1_3 ~= 0 then
		self.m_elemIcon:setIcon((g.core.common.Path:getKnightElementIcon(var_1_3)))
		self.m_hasElemController:setSelectedIndex(1)
	else
		self.m_hasElemController:setSelectedIndex(0)
	end
end

return NewSlgTeamPlayerInfoTeamComp
