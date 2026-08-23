local var_0_0 = {
	ALL = 0,
	ATTACK = 1,
	ASSIST = 2,
	HEAL = 3,
	TANK = 4,
	CONTROL = 5
}
local var_0_1 = {
	ALL = 0,
	CRYSTAL = 2,
	PHYSICS = 1
}
local LineUpScreenComp = class("LineUpScreenComp", require("app.fairyGUI.lineUp.UI_LineUpScreenComp"))

function LineUpScreenComp:ctor()
	self._professionIndex = 0
	self._damageTypeIndex = 0

	self:_initList()
end

function LineUpScreenComp:_initList()
	self.m_professionList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickProfessionList))
	self.m_professionList:setSelectedIndex(var_0_0.ALL)
	self.m_damageTypeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickDamageTypeList))
	self.m_damageTypeList:setSelectedIndex(var_0_1.ALL)
end

function LineUpScreenComp:_onClickProfessionList(arg_3_1)
	local var_3_0 = arg_3_1:getDataValue()

	self._professionIndex = var_3_0

	self:dispatchCompEvent("changeProfession", {
		index = var_3_0
	})
end

function LineUpScreenComp:_onClickDamageTypeList(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	self._professionIndex = var_4_0

	self:dispatchCompEvent("changeDamageType", {
		index = var_4_0
	})
end

return LineUpScreenComp
