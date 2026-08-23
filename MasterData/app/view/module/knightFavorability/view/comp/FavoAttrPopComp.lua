local var_0_0 = g.core.model.User.knightFavoData
local FavoAttrPopComp = class("FavoAttrPopComp", require("app.fairyGUI.knightFavorability.UI_FavoAttrPopComp"))

function FavoAttrPopComp:ctor()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_totalAttrList:setIniter()
	self.m_totalAttrList:setItemRenderer(handler(self, self._onTotalAttrRenderer))
end

function FavoAttrPopComp:updateComp()
	self._levelIndexList = var_0_0:getTotalAttrIndexData()
	self._totalAttrList = var_0_0:getTotalLevelAttrs()
	self._totalLevel = var_0_0:getTotalFavoLevel()

	self.m_isMaxController:setSelectedIndex(self._totalLevel == var_0_0:getMaxTotalFavoLevel() and 1 or 0)
	self.m_attrList:setNumItems(#self._levelIndexList)
	self.m_attrList:scrollToView(self._totalLevel - 1)

	if #self._totalAttrList == 0 then
		self.m_showAttrController:setSelectedIndex(1)
	else
		self.m_showAttrController:setSelectedIndex(0)
	end

	self.m_totalAttrList:setNumItems(#self._totalAttrList)
	self.m_totalAttrList:resizeToFit(#self._totalAttrList)
end

function FavoAttrPopComp:_onItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateView(self._levelIndexList[arg_3_1 + 1], self._totalLevel)
end

function FavoAttrPopComp:_onTotalAttrRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateAttr(self._totalAttrList[arg_4_1 + 1])
end

return FavoAttrPopComp
