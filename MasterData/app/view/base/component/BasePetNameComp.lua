local var_0_0 = g.core.common.Path
local BasePetNameComp = class("BasePetNameComp", require("app.fairyGUI.base_new.UI_BasePetNameComp"))

function BasePetNameComp:updateComp(arg_1_1)
	local var_1_0 = arg_1_1:getCfg()

	self.m_nameText:setText(var_1_0.name)

	local var_1_1 = arg_1_1:getBigSmallStage()
	local var_1_2

	if var_1_1 > 0 then
		self.m_stageText:setText("+" .. var_1_1)
	else
		self.m_stageText:setText("")

		var_1_2 = {
			index = 3,
			style = 2,
			gap = -1
		}
	end

	var_1_2.num = arg_1_1:getStarNum()

	self.m_starComp:initStar(var_1_2)
	self.m_nameBgLoader:setURL((var_0_0:getPetNameQualityBg(var_1_0.quality)))
	self.m_qualityLoader:setURL((var_0_0:getQualityArtTxtURLNew(var_1_0.quality)))
end

return BasePetNameComp
