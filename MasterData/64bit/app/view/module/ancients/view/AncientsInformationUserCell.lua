local AncientsInformationUserCell = class("AncientsInformationUserCell", require("app.fairyGUI.ancients.UI_AncientsInformationUserCell"))

function AncientsInformationUserCell:ctor()
	self._itemDataStruct = nil

	self:_initView()
end

function AncientsInformationUserCell:_initView()
	return
end

function AncientsInformationUserCell:updateCell(arg_3_1, arg_3_2)
	self.m_Comp_promot_icon:updateAsUser(arg_3_2[arg_3_1.user_id])
	self.m_Txt_player_power:setText(arg_3_1.fight_value)
	self.m_Comp_promot_name:setText(arg_3_2[arg_3_1.user_id].name)
	self.m_Txt_player_level:setText(g.core.lang:get(2052, {
		level = arg_3_2[arg_3_1.user_id].level
	}))
	self.m_Txt_player_points:setText(arg_3_1.score or 0)
end

return AncientsInformationUserCell
