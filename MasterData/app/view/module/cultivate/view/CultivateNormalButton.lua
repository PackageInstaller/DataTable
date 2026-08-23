local CultivateNormalButton = class("CultivateNormalButton", require("app.fairyGUI.cultivate.UI_CultivateNormalButton1"))

function CultivateNormalButton:updateFinishIcon(arg_1_1)
	self.m_finishIcon:setURL(arg_1_1)
end

function CultivateNormalButton:setBtnIcon(arg_2_1)
	self:setIcon(arg_2_1)
	self.m_iconColor:setURL(arg_2_1)
	self.m_iconColor:setColor(cc.c3b(0, 0, 0))
end

function CultivateNormalButton:updateTitleBg(arg_3_1)
	if self:getChild("titleBg") then
		self:getChild("titleBg"):setURL(arg_3_1)
	end
end

function CultivateNormalButton:setSelfRedPointId(arg_4_1, arg_4_2)
	self.m_redPointComp:setId(arg_4_1)

	self._redPointId = arg_4_1
	self._actId = arg_4_2

	self:updateRedPoint()
end

function CultivateNormalButton:updateRedPoint()
	if self._redPointId and self.m_redPointComp then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				actValue = self._actId
			}
		})
	end
end

function CultivateNormalButton:setBtnState(arg_6_1)
	self.m_stateController:setSelectedIndex(arg_6_1)
end

return CultivateNormalButton
