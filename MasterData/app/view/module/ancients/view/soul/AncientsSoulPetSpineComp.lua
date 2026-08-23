local AncientsSoulPetSpineComp = class("AncientsSoulPetSpineComp", require("app.fairyGUI.ancients.UI_AncientsSoulPetSpineComp"))

function AncientsSoulPetSpineComp:updateView()
	local var_1_0 = g.core.model.User.ancientsData:getPetBaseId()

	if var_1_0 == 0 then
		return
	end

	self:_updatePetSpine(g.core.config.ancients_pet_info.get(var_1_0).advance_id)
end

function AncientsSoulPetSpineComp:_updatePetSpine(arg_2_1)
	local var_2_0 = self.m_Comp_PlaceHolder:getChild("DrawPet")

	if var_2_0 and arg_2_1 == var_2_0:getAdvId() then
		return
	end

	local var_2_1 = require("app.view.common.DrawPet").new({
		isShowBg = false,
		scale = 1,
		advId = arg_2_1
	})

	self.m_Comp_PlaceHolder:removeChildren()
	self.m_Comp_PlaceHolder:addChild(var_2_1)

	local var_2_2 = self.m_Comp_PlaceHolder:getSize()

	var_2_1:setPosition(var_2_2.width / 2, var_2_2.height / 2)
end

return AncientsSoulPetSpineComp
