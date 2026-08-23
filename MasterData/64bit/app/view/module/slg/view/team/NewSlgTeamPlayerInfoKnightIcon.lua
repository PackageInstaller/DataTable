local var_0_0 = g.core.config.knight_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local NewSlgTeamPlayerInfoKnightIcon = class("NewSlgTeamPlayerInfoKnightIcon", require("app.fairyGUI.newSlg.UI_NewSlgTeamPlayerInfoKnightIcon"))

function NewSlgTeamPlayerInfoKnightIcon:ctor()
	self._knight = nil
	self._matchInfos = nil
	self._isSelf = false
end

function NewSlgTeamPlayerInfoKnightIcon:updateKnightIcon(arg_2_1)
	if not arg_2_1 then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	self.m_isEmptyController:setSelectedIndex(0)

	local var_2_0 = var_0_0.get(arg_2_1.base_id)
	local var_2_1 = KnightStruct.new(var_2_0.advance_id)

	var_2_1:addCfgInfo(var_2_0)
	self.m_knightIcon:updateIcon({
		type = arg_2_1.tp,
		struct = var_2_1,
		star = var_2_0.star
	})
end

return NewSlgTeamPlayerInfoKnightIcon
