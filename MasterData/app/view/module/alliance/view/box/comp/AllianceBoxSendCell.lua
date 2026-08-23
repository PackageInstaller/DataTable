local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.allianceData
local AllianceBoxSendCell = class("AllianceBoxSendCell", require("app.fairyGUI.alliance.UI_AllianceBoxSendCell"))

function AllianceBoxSendCell:ctor()
	self:initView()
end

function AllianceBoxSendCell:initView()
	self.m_effDown:addEffectSpine({
		anim = "play",
		name = "eff_ui_alliance_selectDown",
		isLoop = true
	})
	self.m_effUp:addEffectSpine({
		anim = "play",
		name = "eff_ui_alliance_selectUp",
		isLoop = true
	})
end

function AllianceBoxSendCell:updateSendBoxCell(arg_3_1)
	self.m_numText:setText((var_0_1:getBoxData():getSendBoxCount(arg_3_1.id)))
	self:setIcon(var_0_0:getAllianceBox400(arg_3_1.box_pic))
	self.m_left:setURL(var_0_0:getAllianceSendQuality(arg_3_1.quality))
	self.m_right:setURL(var_0_0:getAllianceSendQuality(arg_3_1.quality))
end

return AllianceBoxSendCell
