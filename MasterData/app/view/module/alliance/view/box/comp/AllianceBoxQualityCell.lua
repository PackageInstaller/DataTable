local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.allianceData
local AllianceBoxQualityCell = class("AllianceBoxQualityCell", require("app.fairyGUI.alliance.UI_AllianceBoxQualityCell"))

function AllianceBoxQualityCell:ctor()
	self._lastNum = -1

	self:initView()
end

function AllianceBoxQualityCell:initView()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_alliance_cube",
		isLoop = true
	})
end

function AllianceBoxQualityCell:updateBoxCell(arg_3_1)
	self:setIcon(var_0_0:getAllianceBox128(arg_3_1.box_pic))

	local var_3_0 = var_0_1:getBoxData():getOpenBoxCount(arg_3_1.id)

	self:setTitle(g.core.lang:get(428511, {
		num = var_3_0
	}))
	self.m_qualityBg:setURL(var_0_0:getAllianceBoxQualityBg(arg_3_1.quality))

	if self._lastNum >= 0 and var_3_0 > self._lastNum then
		self:showGetEff(arg_3_1.id)
	end

	self._lastNum = var_3_0

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			boxId = arg_3_1.id
		}
	})
end

function AllianceBoxQualityCell:showGetEff(arg_4_1)
	self.m_effGet:addEffectSpine({
		name = "eff_ui_alliance_get",
		remove = true,
		isLoop = false,
		anim = "play" .. arg_4_1
	})
end

return AllianceBoxQualityCell
