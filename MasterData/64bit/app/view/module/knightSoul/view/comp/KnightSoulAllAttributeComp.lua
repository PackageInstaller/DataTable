local var_0_0 = g.core.model.User.knightSoulData
local KnightSoulAllAttributeComp = class("KnightSoulAllAttributeComp", require("app.fairyGUI.knightSoul.UI_KnightSoulAllAttributeComp"))

function KnightSoulAllAttributeComp:ctor()
	self._allAttrList = {}
	self._bookAttrList = {}
	self._honorAttrList = {}

	self.m_allAttrList:setVirtual()
	self.m_allAttrList:setItemRenderer(handler(self, self._onRenderAllAttrList))
	self.m_bookAttrList:setVirtual()
	self.m_bookAttrList:setItemRenderer(handler(self, self._onRenderBookAttrList))
	self.m_honorAttrList:setVirtual()
	self.m_honorAttrList:setItemRenderer(handler(self, self._onRenderHonorAttrList))
end

function KnightSoulAllAttributeComp:updateAttribute()
	self._allAttrList, self._bookAttrList, self._honorAttrList = var_0_0:getAllAttrList()

	local var_2_0 = #self._allAttrList

	self.m_hasAllController:setSelectedIndex(#self._allAttrList > 0 and 1 or 0)

	if var_2_0 > 0 then
		self.m_allAttrList:setNumItems(var_2_0)
		self.m_allAttrList:resizeToFit(var_2_0)
	end

	local var_2_1 = #self._bookAttrList

	self.m_hasBookController:setSelectedIndex(#self._bookAttrList > 0 and 1 or 0)

	if var_2_1 > 0 then
		self.m_bookAttrList:setNumItems(var_2_1)
		self.m_bookAttrList:resizeToFit(var_2_1)
	end

	local var_2_2 = #self._honorAttrList

	self.m_hasHonorController:setSelectedIndex(#self._honorAttrList > 0 and 1 or 0)

	if var_2_2 > 0 then
		self.m_honorAttrList:setNumItems(var_2_2)
		self.m_honorAttrList:resizeToFit(var_2_2)
	end
end

function KnightSoulAllAttributeComp:_onRenderAllAttrList(arg_3_1, arg_3_2)
	arg_3_2:updateAttr({
		isAll = true,
		type = self._allAttrList[arg_3_1 + 1].attrType,
		value = self._allAttrList[arg_3_1 + 1].attrValue
	})
end

function KnightSoulAllAttributeComp:_onRenderBookAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateAttr({
		isAll = true,
		type = self._bookAttrList[arg_4_1 + 1].attrType,
		value = self._bookAttrList[arg_4_1 + 1].attrValue
	})
end

function KnightSoulAllAttributeComp:_onRenderHonorAttrList(arg_5_1, arg_5_2)
	arg_5_2:updateAttr({
		isAll = true,
		type = self._honorAttrList[arg_5_1 + 1].attrType,
		value = self._honorAttrList[arg_5_1 + 1].attrValue
	})
end

return KnightSoulAllAttributeComp
