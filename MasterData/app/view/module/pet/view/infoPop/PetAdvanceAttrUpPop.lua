local PetAdvanceAttrUpPop = class("PetAdvanceAttrUpPop", require("app.fairyGUI.pet.UI_PetAdvanceAttrUpPop"), function()
	return fgui.GComponent:create({
		resName = "PetAdvanceAttrUpPop",
		pkgPath = "ui/pet/pet",
		pkgName = "pet"
	}, ...)
end)

function PetAdvanceAttrUpPop:ctor(arg_2_1)
	self:showAtCenter()

	self._petStruct = arg_2_1

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrItemRender))
	self.m_maxAttrList:setIniter()
	self.m_maxAttrList:setItemRenderer(handler(self, self._onMaxAttrItemRender))
end

function PetAdvanceAttrUpPop:_onAttrItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateAttrCell(self._nextArrs[arg_3_1 + 1], self._curArrs[arg_3_1 + 1])
end

function PetAdvanceAttrUpPop:_onMaxAttrItemRender(arg_4_1, arg_4_2)
	self._maxAttrs[arg_4_1 + 1].isAll = true

	arg_4_2:updateAttr(self._maxAttrs[arg_4_1 + 1])
end

function PetAdvanceAttrUpPop:onLoad()
	local var_5_0 = self._petStruct:isFullStage()

	if var_5_0 then
		self._maxAttrs = self._petStruct:getTalentTotalAttrByAdvanceId((self._petStruct:getMaxAdvanceId()))

		self.m_maxAttrList:setNumItems(#self._maxAttrs)
	else
		self._curArrs = self._petStruct:getTalentTotalAttrByAdvanceId(self._petStruct:getAdvCfg().id)
		self._nextArrs = self._petStruct:getTalentTotalAttrByAdvanceId(self._petStruct:getNextStageAdvCfg().id)

		self.m_attrList:setNumItems(#self._nextArrs)
	end

	self.m_isMaxController:setSelectedIndex(var_5_0 and 1 or 0)
end

return PetAdvanceAttrUpPop
