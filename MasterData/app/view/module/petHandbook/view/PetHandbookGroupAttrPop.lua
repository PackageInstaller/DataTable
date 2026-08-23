local var_0_0 = g.core.model.User.petHandBookData
local PetHandbookGroupAttrPop = class("PetHandbookGroupAttrPop", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupAttrPop"), function()
	return fgui.GComponent:create({
		resName = "PetHandbookGroupAttrPop",
		pkgPath = "ui/petHandBook/petHandBook",
		pkgName = "petHandBook"
	})
end)

function PetHandbookGroupAttrPop:ctor()
	self:showAtCenter()
	self:_updateAttr()
end

function PetHandbookGroupAttrPop:_updateAttr()
	local var_3_0 = var_0_0:getAllGroupAttrList()

	self.m_emptyComp:setVisible(#var_3_0 == 0)

	for iter_3_0 = 1, 6 do
		self["m_attr" .. iter_3_0]:setVisible(checkbool(var_3_0[iter_3_0]))

		if var_3_0[iter_3_0] then
			self["m_attr" .. iter_3_0]:updateAttr(var_3_0[iter_3_0])
		end
	end
end

return PetHandbookGroupAttrPop
