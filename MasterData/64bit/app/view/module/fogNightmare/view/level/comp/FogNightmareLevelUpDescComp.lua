local FogNightmareLevelUpDescComp = class("FogNightmareLevelUpDescComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareLevelUpDescComp"))

function FogNightmareLevelUpDescComp:ctor()
	self._descList = {}
	self._isCurLevel = false

	self.m_descList:setVirtual()
	self.m_descList:setItemRenderer(handler(self, self._onRendererDescList))
end

function FogNightmareLevelUpDescComp:_onRendererDescList(arg_2_1, arg_2_2)
	arg_2_2:updateCell(arg_2_1, self._descList[arg_2_1 + 1])
end

function FogNightmareLevelUpDescComp:updateView(arg_3_1, arg_3_2)
	self._isCurLevel = arg_3_2 or false
	self._descList = arg_3_1 or {}

	self.m_descList:setNumItems(#self._descList)
end

return FogNightmareLevelUpDescComp
