local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.pet_info
local PetHandbookGroupUpgradeIcon = class("PetHandbookGroupUpgradeIcon", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupUpgradeIcon"))

function PetHandbookGroupUpgradeIcon:updatePetIcon(arg_1_1, arg_1_2)
	local var_1_0 = var_0_1.get(arg_1_1)

	if var_1_0 then
		self.m_petIcon:setURL((arg_1_2 or nil) and (var_0_0:getPetDrawing(var_1_0.resource) or var_0_0:getPetPictorialBook(var_1_0.resource)))
		self.m_qualityLoader:setURL("ui://base_new/pic_yzs_" .. var_1_0.quality + 1 .. "_tujian_zs1")
	end
end

return PetHandbookGroupUpgradeIcon
