local var_0_0 = g.core.const.ConstMgr.PetHandBookConst
local PetHandbookGroupAttrComp = class("PetHandbookGroupAttrComp", require("app.fairyGUI.petHandBook.UI_PetHandbookGroupAttrComp"))

function PetHandbookGroupAttrComp:ctor()
	return
end

function PetHandbookGroupAttrComp:updateAttrComp(arg_2_1)
	local var_2_0 = arg_2_1:getUpgradeType()
	local var_2_1 = {}

	if var_2_0 == var_0_0.GROUP_UPGRADE_TYPE.ACTIVATE then
		self.m_title:setText(g.core.lang:get(428005))

		var_2_1 = arg_2_1:getNextAttrList()
	elseif var_2_0 == var_0_0.GROUP_UPGRADE_TYPE.UPGRADE then
		self.m_title:setText(g.core.lang:get(428006))

		var_2_1 = arg_2_1:getNextAttrList()
	else
		self.m_title:setText(g.core.lang:get(428008))

		var_2_1 = arg_2_1:getSumAttrList(arg_2_1:getBaseId())
	end

	self:_updateAttr(var_2_1)
end

function PetHandbookGroupAttrComp:_updateAttr(arg_3_1)
	for iter_3_0 = 1, 6 do
		self["m_attr" .. iter_3_0]:setVisible(checkbool(arg_3_1[iter_3_0]))
		self["m_attr" .. iter_3_0]:updateAttr(arg_3_1[iter_3_0])
	end
end

return PetHandbookGroupAttrComp
