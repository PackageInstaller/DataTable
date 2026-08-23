local AllianceHallLogCell = class("AllianceHallLogCell", require("app.fairyGUI.alliance.UI_AllianceHallLogCell"))

function AllianceHallLogCell:ctor()
	self.m_logInfoList:setIniter()
	self.m_logInfoList:setItemRenderer(handler(self, self._onHallLogCellItemRender))
end

function AllianceHallLogCell:_onHallLogCellItemRender(arg_2_1, arg_2_2)
	arg_2_2:setTitle(self._logData[arg_2_1 + 1].logDesc)
end

function AllianceHallLogCell:setData(arg_3_1)
	self._logData = arg_3_1

	self.m_dateTxt:setText((g.core.common.ServerTime:getDateMDFormat(arg_3_1[1].time)))
	self.m_logInfoList:setNumItems(#self._logData)
	self.m_logInfoList:resizeToFit(#self._logData)
end

return AllianceHallLogCell
