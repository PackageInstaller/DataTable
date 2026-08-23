local PetHandBookNameComp = class("PetHandBookNameComp", require("app.fairyGUI.petHandBook.UI_PetHandBookNameComp"))

function PetHandBookNameComp:setData(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:getCfg()

	self.m_nameTxt:setText(var_1_0.name)

	for iter_1_0 = 1, 3 do
		self["m_qualityBaseIcon" .. iter_1_0]:setURL(g.core.common.Path:getHandBookTitleQuality(var_1_0.quality))
	end
end

return PetHandBookNameComp
