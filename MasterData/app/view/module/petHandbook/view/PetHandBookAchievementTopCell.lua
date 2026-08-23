local var_0_0 = g.core.model.User.petHandBookData
local PetHandBookAchievementTopCell = class("PetHandBookAchievementTopCell", require("app.fairyGUI.petHandBook.UI_PetHandBookAchievementTopCell"))

function PetHandBookAchievementTopCell:ctor()
	self._collectAttr = {}
	self._collectOwnNum = 0
	self._collectMaxNum = 0
end

function PetHandBookAchievementTopCell:init()
	self:_initAttr()
	self:updateAttrValue()
end

function PetHandBookAchievementTopCell:_initAttr()
	self._collectOwnNum = var_0_0:getActivatedNum()
	self._collectMaxNum = var_0_0:getMaxPetNum()
	self._collectAttr = var_0_0:getCollectAttr()
end

function PetHandBookAchievementTopCell:updateAttrValue()
	self.m_attrCollectAddList:setVirtual()
	self.m_attrCollectAddList:setItemRenderer(handler(self, self._onBookAttrAddListRender))
	self.m_collectOwnTxt:setText("(" .. self._collectOwnNum)
	self.m_collectMaxTxt:setText("/" .. self._collectMaxNum .. ")")

	if #self._collectAttr > 0 then
		self.m_attrCollectAddList:setNumItems(#self._collectAttr)
		self.m_attrCollectAddList:setHeight(math.ceil(#self._collectAttr / 2) * 33 + 10)
		self.m_hadAdditionController:setSelectedIndex(1)
	else
		self.m_hadAdditionController:setSelectedIndex(0)
	end
end

function PetHandBookAchievementTopCell:_onBookAttrAddListRender(arg_5_1, arg_5_2)
	arg_5_2:setWidth(248)
	arg_5_2:updateAttr({
		isAll = true,
		type = self._collectAttr[arg_5_1 + 1].type,
		value = self._collectAttr[arg_5_1 + 1].value
	})
end

return PetHandBookAchievementTopCell
