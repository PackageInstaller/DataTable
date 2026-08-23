local var_0_0 = g.core.model.User.preciousData
local PreciousSiftComp = class("PreciousSiftComp", require("app.fairyGUI.precious.UI_PreciousSiftComp"))

function PreciousSiftComp:ctor()
	self._qualityIdx = 0
	self._activateIdx = 0

	self.m_qualityController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onQualityChange))
	self.m_stateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onActivateChange))
	self.m_resetBtn:addClickListener(handler(self, self._onClickResetBtn))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSaveBtn))
end

function PreciousSiftComp:_onQualityChange()
	local var_2_0 = self.m_qualityController:getSelectedIndex()

	if var_2_0 == self._qualityIdx then
		return
	end

	self._qualityIdx = var_2_0
end

function PreciousSiftComp:_onActivateChange()
	local var_3_0 = self.m_stateController:getSelectedIndex()

	if var_3_0 == self._activateIdx then
		return
	end

	self._activateIdx = var_3_0
end

function PreciousSiftComp:onLoad()
	self._qualityIdx, self._activateIdx = var_0_0:getSiftMarkIdx()

	self.m_qualityController:setSelectedIndex(self._qualityIdx)
	self.m_stateController:setSelectedIndex(self._activateIdx)
end

function PreciousSiftComp:_onClickResetBtn()
	self._activateIdx = 0
	self._qualityIdx = 0

	self.m_qualityController:setSelectedIndex(self._qualityIdx)
	self.m_stateController:setSelectedIndex(self._activateIdx)
end

function PreciousSiftComp:_onClickSaveBtn()
	var_0_0:setSiftMarkIdx(self._qualityIdx, self._activateIdx)
	self:dispatchCompEvent("SAVE_QUALITY_ACTIVATE_IDX")
end

return PreciousSiftComp
