local var_0_0 = {
	CONTROL = 5,
	TANK = 4,
	HEAL = 3,
	ASSIST = 2,
	ATTACK = 1,
	ALL = 0
}
local var_0_1 = {
	CRYSTAL = 2,
	ALL = 0,
	PHYSICS = 1
}
local var_0_2 = {
	THUNDER = 4,
	WIND = 3,
	FIRE = 2,
	WATER = 1,
	ALL = 0,
	EARTH = 5
}
local KnightBagScreenComp = class("KnightBagScreenComp", require("app.fairyGUI.knightBag.UI_KnightBagScreenComp"))

function KnightBagScreenComp:ctor()
	self._professionIndex = 0
	self._damageTypeIndex = 0
	self._elementIndex = 0

	self:_initList()
end

function KnightBagScreenComp:_initList()
	self.m_professionList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickProfessionList))
	self.m_professionList:setSelectedIndex(var_0_0.ALL)
	self.m_damageTypeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickDamageTypeList))
	self.m_damageTypeList:setSelectedIndex(var_0_1.ALL)
	self.m_elementList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickElementList))
	self.m_elementList:setSelectedIndex(var_0_2.ALL)
end

function KnightBagScreenComp:_onClickProfessionList(arg_3_1)
	local var_3_0 = arg_3_1:getDataValue()

	if var_3_0 == self._professionIndex then
		return
	end

	self._professionIndex = var_3_0

	self:dispatchCompEvent("changeProfession", {
		index = var_3_0
	})
end

function KnightBagScreenComp:_onClickDamageTypeList(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	if var_4_0 == self._damageTypeIndex then
		return
	end

	self._damageTypeIndex = var_4_0

	self:dispatchCompEvent("changeDamageType", {
		index = var_4_0
	})
end

function KnightBagScreenComp:_onClickElementList(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()

	if var_5_0 == self._elementIndex then
		return
	end

	self._elementIndex = var_5_0

	self:dispatchCompEvent("changeElement", {
		index = var_5_0
	})
end

return KnightBagScreenComp
