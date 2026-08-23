local AncientsBattlePetComp = class("AncientsBattlePetComp", require("app.fairyGUI.ancients.UI_AncientsBattlePetComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0.ctor(arg_1_0)
	arg_1_0._petPic = nil
end

function var_0_0:updateView(arg_2_1, arg_2_2)
	self.m_Comp_spine:setScale(arg_2_1 and -1 or 1, 1)

	local var_2_0 = g.core.model.User.ancientsData:getTeamPetId(var_0_2.GET_TEAM_TYPE.CUSTOM_TEAM, arg_2_2)

	if var_2_0 == 0 then
		return
	end

	local var_2_1 = g.core.config.ancients_pet_info.get(var_2_0).advance_id
	local var_2_2 = self.m_Comp_spine:getChild("DrawPet")

	if var_2_2 and var_2_1 == var_2_2:getAdvId() then
		return
	end

	local var_2_3 = require("app.view.common.DrawPet").new({
		isShowBg = false,
		scale = 1,
		advId = var_2_1
	})

	self.m_Comp_spine:removeChildren()
	self.m_Comp_spine:addChild(var_2_3)

	local var_2_4 = self.m_Comp_spine:getSize()

	var_2_3:setPosition(var_2_4.width / 2, var_2_4.height / 2)
end

return var_0_0
