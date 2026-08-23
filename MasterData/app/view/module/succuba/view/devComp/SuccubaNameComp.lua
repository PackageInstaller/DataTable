local var_0_0 = g.core.common.Path
local SuccubaNameComp = class("SuccubaNameComp", require("app.fairyGUI.succuba.UI_SuccubaNameComp"))

function SuccubaNameComp:ctor()
	return
end

function SuccubaNameComp:updateComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1:getCurCfg()

	self.m_nameText:setText(var_2_0.name)
	self.m_charmText:setText(arg_2_1:getCharm())
	self.m_starComp:initStar({
		index = 3,
		style = 2,
		gap = -1,
		num = arg_2_1:getStar()
	})
	self.m_nameBgLoader:setURL(var_0_0:getPetNameQualityBg(var_2_0.quality))
	self.m_qualityLoader:setURL(var_0_0:getQualityArtTxtURLNew(var_2_0.quality))

	local var_2_1 = arg_2_1:getStage()

	if var_2_1 > 0 then
		self.m_advLevel:setText(g.core.lang:get(2050, {
			level = var_2_1
		}))
	else
		self.m_advLevel:setText("")
	end
end

return SuccubaNameComp
