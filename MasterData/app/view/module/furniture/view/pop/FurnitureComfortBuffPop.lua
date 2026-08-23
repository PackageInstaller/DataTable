local var_0_0 = g.core.model.User.furnitureData
local FurnitureComfortBuffPop = class("FurnitureComfortBuffPop", require("app.fairyGUI.furniture.UI_FurnitureComfortBuffPop"), function()
	return fgui.GComponent:create({
		resName = "FurnitureComfortBuffPop",
		pkgPath = "ui/furniture/furniture",
		isFullScreen = false,
		pkgName = "furniture"
	}, ...)
end)

function FurnitureComfortBuffPop:ctor(arg_2_1)
	self:_initData(arg_2_1)
	self:_initView()
	self:showAtCenter()
end

function FurnitureComfortBuffPop:_initData(arg_3_1)
	self._dormId = arg_3_1

	local var_3_0 = var_0_0:getRoomInfo(arg_3_1)

	self._inactiveAttributeArr = var_3_0:getInactiveAttributeArr()
	self._activatedAttributeArr = var_3_0:getActivatedAttributeArr()

	table.sort(self._activatedAttributeArr, function(arg_4_0, arg_4_1)
		return arg_4_0.comfort > arg_4_1.comfort
	end)

	self._sumAttributeArr = var_3_0:getAttributesSumArr(self._activatedAttributeArr)
end

function FurnitureComfortBuffPop:_initView()
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
	self.m_attributeList:setVirtual()
	self.m_attributeList:setItemRenderer(handler(self, self._onAttributeListRenderer))
	self.m_activatedBuffList:setVirtual()
	self.m_activatedBuffList:setItemRenderer(handler(self, self._onActivatedBuffListRenderer))
	self.m_inactiveBuffList:setIniter()
	self.m_inactiveBuffList:doFairyBatching(true)
	self.m_inactiveBuffList:setItemRenderer(handler(self, self._onInactiveBuffListRenderer))
end

function FurnitureComfortBuffPop:onLoad()
	self:_updateView()
end

function FurnitureComfortBuffPop:_updateView()
	local var_7_0 = var_0_0:getRoomInfo(self._dormId)

	self.m_lvTxt:setText(g.core.lang:get(201577, {
		level = var_7_0:getLevel()
	}))
	self.m_dormIdTxt:setText(g.core.lang:get(112548, {
		dormId = self._dormId
	}))
	self.m_curComfortTxt:setText((var_7_0:getComfort()))
	self.m_maxComfortTxt:setText(g.core.lang:get(112532, {
		num = var_7_0:getComfortLimit()
	}))

	if #self._sumAttributeArr == 0 then
		self.m_attributeEmptyController:setSelectedIndex(1)
	else
		self.m_attributeList:setNumItems(#self._sumAttributeArr)
		self.m_attributeEmptyController:setSelectedIndex(0)
	end

	local var_7_1 = #self._activatedAttributeArr

	if #self._activatedAttributeArr == 0 then
		self.m_activatedBuffEmptyController:setSelectedIndex(1)
	else
		self.m_activatedBuffList:setNumItems(var_7_1)
		self.m_activatedBuffEmptyController:setSelectedIndex(0)
	end

	local var_7_2 = #self._inactiveAttributeArr

	if #self._inactiveAttributeArr == 0 then
		self.m_inactiveBuffEmptyController:setSelectedIndex(1)
	else
		self.m_inactiveBuffList:setNumItems(var_7_2)
		self.m_inactiveBuffEmptyController:setSelectedIndex(0)
	end

	self:_updateLeftRightBtn()
end

function FurnitureComfortBuffPop:_onClickLeftBtn()
	self:_initData(self._dormId - 1)
	self:_updateView()
end

function FurnitureComfortBuffPop:_onClickRightBtn()
	self:_initData(self._dormId + 1)
	self:_updateView()
end

function FurnitureComfortBuffPop:_onAttributeListRenderer(arg_10_1, arg_10_2)
	local var_10_0 = self._sumAttributeArr[self:_cppIdx2LuaIdx(arg_10_1)]

	arg_10_2:updateCell(var_10_0.attributeType, var_10_0.attributeValue)
end

function FurnitureComfortBuffPop:_onActivatedBuffListRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCell(self._activatedAttributeArr[self:_cppIdx2LuaIdx(arg_11_1)])
end

function FurnitureComfortBuffPop:_onInactiveBuffListRenderer(arg_12_1, arg_12_2)
	arg_12_2:setAlpha(0.5)
	arg_12_2:updateCell(self._inactiveAttributeArr[self:_cppIdx2LuaIdx(arg_12_1)])
end

function FurnitureComfortBuffPop:_updateLeftRightBtn()
	local var_13_0 = var_0_0:getDormMaxNum()

	self.m_leftBtn:setVisible(self._dormId > 1)
	self.m_rightBtn:setVisible(var_13_0 > self._dormId)
end

function FurnitureComfortBuffPop:_cppIdx2LuaIdx(arg_14_1)
	return arg_14_1 + 1
end

return FurnitureComfortBuffPop
