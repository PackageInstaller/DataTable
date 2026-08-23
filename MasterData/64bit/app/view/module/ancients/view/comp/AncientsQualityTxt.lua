local AncientsQualityTxt = class("AncientsQualityTxt", require("app.fairyGUI.ancients.UI_AncientsQualityTxt"))
local var_0_1 = g.core.common.Path

function AncientsQualityTxt:updateTxtAndQuality(arg_1_1, arg_1_2)
	self.m_nameText:setText(arg_1_2)
	self.m_qualityLoader:setURL(var_0_1:getFormationKnightNameBg(arg_1_1))
end

function AncientsQualityTxt:updateByParams(arg_2_1)
	local var_2_0, var_2_1

	if arg_2_1 then
		var_2_0 = arg_2_1.quality or 1

		if arg_2_1 then
			var_2_1 = arg_2_1.text or ""
		end
	end

	self:updateTxtAndQuality(var_2_0, var_2_1)
end

function AncientsQualityTxt:updateUserName(arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1.user

	if not (arg_3_1 and arg_3_1.user) then
		return
	end

	self:updateTxtAndQuality(g.core.config.knight_info.get(var_3_0.base_id).quality, var_3_0.name)
end

return AncientsQualityTxt
