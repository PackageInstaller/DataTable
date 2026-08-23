local FogNightmareLevelDescComp = class("FogNightmareLevelDescComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareLevelDescComp"))

function FogNightmareLevelDescComp:ctor()
	self._descList = {}
	self._isCurLevel = false

	self.m_descList:setVirtual()
	self.m_descList:setItemRenderer(handler(self, self._onRendererDescList))
end

function FogNightmareLevelDescComp:_onRendererDescList(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._descList[arg_2_1 + 1], self._isCurLevel, arg_2_1)
end

function FogNightmareLevelDescComp:updateView(arg_3_1, arg_3_2)
	self._isCurLevel = arg_3_2 or false
	self._descList = arg_3_1 or {}

	self.m_descList:setNumItems(#self._descList)
end

return FogNightmareLevelDescComp
