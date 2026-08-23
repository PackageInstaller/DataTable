local var_0_0 = g.core.model.User.knightTissueData
local KnightTissuePassiveAttrPop = class("KnightTissuePassiveAttrPop", require("app.fairyGUI.knightTissue.UI_KnightTissuePassiveAttrPop"), function()
	return fgui.GComponent:create({
		pkgName = "knightTissue",
		resName = "KnightTissuePassiveAttrPop",
		pkgPath = "ui/knightTissue/knightTissue"
	})
end)

function KnightTissuePassiveAttrPop:ctor(arg_2_1)
	if arg_2_1 then
		self._tissueId = arg_2_1.id or 0
	end

	self:showAtCenter()
	self:_initMainView()
end

function KnightTissuePassiveAttrPop:_initMainView()
	self._attrData = var_0_0:getTissueLevelPassive(self._tissueId)

	self.m_attrList:setIniter()
	self.m_attrList:setItemRenderer(handler(self, self._onPassiveAttrItemRender))
	self.m_attrList:setNumItems(#self._attrData)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self._attrData) do
		local var_3_1, var_3_2 = g.core.utils.String.formatPassiveSkillDesc(iter_3_1.skill_id)

		if #var_3_2 > 0 and var_3_2 ~= "0" and not table.indexof(var_3_0, var_3_2) then
			table.insert(var_3_0, var_3_2)
		end
	end

	if #var_3_0 > 0 then
		self.m_buffDescLabel:getChild("title"):enableRich()
		self.m_buffDescLabel:setTitle(table.concat(var_3_0, "\n"))
		self.m_buffDescLabel:setVisible(true)
	else
		self.m_buffDescLabel:setVisible(false)
	end
end

function KnightTissuePassiveAttrPop:_onPassiveAttrItemRender(arg_4_1, arg_4_2)
	if self._attrData[arg_4_1 + 1] then
		arg_4_2:updatePassive(self._attrData[arg_4_1 + 1])
	end
end

return KnightTissuePassiveAttrPop
