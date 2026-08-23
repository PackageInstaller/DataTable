local var_0_0 = g.core.config.outpost_attribute_info
local OutpostKnightSuitDetailPop = class("OutpostKnightSuitDetailPop", require("app.fairyGUI.outpost.UI_OutpostKnightSuitDetailPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostKnightSuitDetailPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostKnightSuitDetailPop:ctor(arg_2_1)
	self._struct = arg_2_1.struct
	self._talentDesc = {}

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRenderer))
	self:showAtCenter()
	self:updateSuitDetail()
end

function OutpostKnightSuitDetailPop:updateSuitDetail()
	self.m_equipComp:updateEquip(self._struct)
	self.m_bgPanel:setTitle(self._struct:getCfg().name)

	local var_3_0 = self._struct:getCfg()

	self.m_starComp:initStar({
		gap = -7,
		style = 1,
		index = self._struct:getStarIndex(),
		num = self._struct:getStar()
	})

	local var_3_1 = var_0_0.get(var_3_0.attribute_type)
	local var_3_2

	if var_3_1.value_format == 1 then
		var_3_2 = var_3_0.attribute_value or var_3_0.attribute_value / 1000 .. "%"
	end

	self.m_attrNameTxt:setText(var_3_1.name)
	self.m_defValueTxt:setText(var_3_2)

	self._talentDesc = {
		self._struct:getTalentCfg().description
	}

	self.m_attrList:setNumItems(#self._talentDesc)
end

function OutpostKnightSuitDetailPop:_onAttrRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateAttr(self._talentDesc[arg_4_1 + 1])
end

return OutpostKnightSuitDetailPop
