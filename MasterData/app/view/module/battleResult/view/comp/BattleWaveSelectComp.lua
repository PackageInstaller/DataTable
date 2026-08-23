local BattleWaveSelectComp = class("BattleWaveSelectComp", require("app.fairyGUI.battleResult.UI_BattleWaveSelectComp"))

function BattleWaveSelectComp:ctor()
	self.m_selectList:setVirtual(self)
	self.m_selectList:setItemRenderer(handler(self, self._onRenderSelectList))
	self.m_selectList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickWave))
	self:addClickListener(handler(self, self._onClickOpenSelection))
end

function BattleWaveSelectComp:_onClickWave()
	local var_2_0 = self.m_selectList:getSelectedIndex()

	self.m_title:setText(self._selectMap[var_2_0 + 1])
	self:dispatchCompEvent("onCheckBattleWave", {
		index = var_2_0 + 1
	})
end

function BattleWaveSelectComp:setSelectionData(arg_3_1)
	self._selectMap = arg_3_1

	self.m_title:setText(self._selectMap[1])
	self.m_selectList:setNumItems(#arg_3_1)
	self.m_selectList:setSelectedIndex(0)
end

function BattleWaveSelectComp:_onClickOpenSelection()
	self.m_stateController:setSelectedIndex(self.m_stateController:getSelectedIndex() == 0 and 1 or 0)
end

function BattleWaveSelectComp:_onRenderSelectList(arg_5_1, arg_5_2)
	arg_5_2:setTitle(self._selectMap[arg_5_1 + 1])
end

return BattleWaveSelectComp
