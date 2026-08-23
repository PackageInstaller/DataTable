local AncientsBattlePetFightComp = class("AncientsBattlePetFightComp", require("app.fairyGUI.ancients.UI_AncientsBattlePetFightComp"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateView(arg_2_1)
	self.m_Loader_pet:setIcon((g.core.common.Path:getPetPictorialBook(g.core.config.ancients_pet_info.get(arg_2_1.petId).advance_id)))
	self.m_Txt_fight_value:setText(arg_2_1.fightValue)
	self.m_stateController:setSelectedIndex(arg_2_1.state)
end

return var_0_0
