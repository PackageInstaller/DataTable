local FogNightmareTalentAdditionComp = class("FogNightmareTalentAdditionComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareTalentAdditionComp"))
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareTalentAdditionComp:ctor()
	self.m_totalList:setVirtual(self)
	self.m_totalList:setItemRendererAsync1(handler(self, self._onTotalListItemRender), 0.02, false)
	self.m_levelList:setVirtual(self)
	self.m_levelList:setItemRendererAsync1(handler(self, self._onLevelListItemRender, 0.02, false))
end

function FogNightmareTalentAdditionComp:updateView(arg_2_1)
	self._curLv = arg_2_1
	self._totalData = var_0_1:getTalentData():getTotalAddition(arg_2_1)

	self.m_totalList:setNumItems1(#self._totalData, handler(self, function()
		self.m_totalList:resizeToFit(#self._totalData)
	end))

	self._levelData = var_0_1:getTalentData():getLevelAddition()

	self.m_levelList:setNumItems1(#self._levelData, handler(self, function()
		self.m_levelList:resizeToFit(#self._levelData)
	end))
end

function FogNightmareTalentAdditionComp:_onTotalListItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateAttr({
		type = self._totalData[arg_5_1 + 1].key,
		value = self._totalData[arg_5_1 + 1].value
	})
end

function FogNightmareTalentAdditionComp:_onLevelListItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateView({
		data = self._levelData[arg_6_1 + 1],
		lv = self._curLv
	})
end

return FogNightmareTalentAdditionComp
