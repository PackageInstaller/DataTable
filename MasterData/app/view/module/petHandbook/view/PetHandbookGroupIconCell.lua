local var_0_0 = g.core.model.User.petsData
local var_0_1 = g.core.common.Path
local PetHandbookGroupIconCell = class("PetHandbookGroupIconCell", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupSingleIcon"))

function PetHandbookGroupIconCell:ctor()
	return
end

function PetHandbookGroupIconCell:updateGroupIconCell(arg_2_1, arg_2_2)
	local var_2_0 = var_0_0:getPetByAdvanceId(arg_2_1)

	if var_2_0 and var_2_0:isPut() then
		local var_2_1 = var_2_0:getCfg()

		self.m_name:setText(var_2_1.name)
		self.m_petIcon:setURL(var_0_1:getPetPictorialBook(var_2_1.resource))

		if var_2_0 then
			self.m_star:setText(var_2_0:getStarNum())

			local var_2_2 = var_2_0:getQuality() + 1

			if self:getChild("leftQualityLoader") then
				self:getChild("leftQualityLoader"):setURL("ui://base_new/pic_" .. var_2_2 .. "_tjdi_1_2")
			end

			if self:getChild("rightQualityLoader") then
				self:getChild("rightQualityLoader"):setURL("ui://base_new/pic_" .. var_2_2 .. "_tjdi_2_2")
			end

			if self:getChild("singleQualityLoader") then
				self:getChild("singleQualityLoader"):setURL("ui://base_new/pic_" .. var_2_2 .. "_tjdi_3_2")
			end

			if var_2_0:isOwn() then
				self.m_petIcon:setAlpha(1)
				self.m_petIcon:setColor(cc.WHITE)
			else
				self.m_petIcon:setAlpha(0.5)
				self.m_petIcon:setColor(cc.BLACK)
			end
		end

		self.m_isPutController:setSelectedIndex(1)
	else
		self.m_name:setText(g.core.lang:get(428009))
		self.m_isPutController:setSelectedIndex(0)
		self.m_isActiveController:setSelectedIndex(0)
	end
end

return PetHandbookGroupIconCell
