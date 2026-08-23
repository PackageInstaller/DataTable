local PetHandbookGroupPicComp = class("PetHandbookGroupPicComp", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupPicComp"))

function PetHandbookGroupPicComp:ctor()
	return
end

function PetHandbookGroupPicComp:updatePicComp(arg_2_1)
	local var_2_0 = arg_2_1:getPetNum()

	self.m_petNumController:setSelectedIndex(var_2_0)

	local var_2_1 = arg_2_1:isGroupActive()

	self.m_isActiveController:setSelectedIndex(var_2_1 and 1 or 0)
	self.m_qualityLoader:setURL("ui://base_new/pic_yzs_" .. arg_2_1:getQuality() + 1 .. "_tujian_zs4")

	local var_2_2, var_2_3 = arg_2_1:getPetAdvanceId()

	if var_2_0 == 1 then
		self.m_singleIcon:updateGroupIconCell(var_2_2, var_2_1)
	elseif var_2_0 == 2 then
		self.m_leftIcon:updateGroupIconCell(var_2_2, var_2_1)
		self.m_rightIcon:updateGroupIconCell(var_2_3, var_2_1)
	end
end

return PetHandbookGroupPicComp
