local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryJigsawBtn = class("AnniversaryJigsawBtn", require("app.fairyGUI.anniversary.UI_AnniversaryJigsawBtn"))

function AnniversaryJigsawBtn:ctor()
	self.m_effLoop:addEffectSpine({
		isLoop = true,
		name = (var_0_0:getActivityId() > 1 or nil) and "eff_ui_anniversaryJigsaw_btnlight" .. var_0_0:getAnniversaryInfo().file_type,
		anim = "play_" .. self.m_typeController:getSelectedIndex() + 1
	})
end

function AnniversaryJigsawBtn:updateBtn()
	local var_2_0 = var_0_0:getAnniversaryInfo()

	self.m_costImg:setURL((g.core.common.Path:getIconByTypeValue(var_2_0.recruited_type, var_2_0.recruited_value)))
	self.m_numTxt:setText(g.core.lang:get(109066, {
		num = var_2_0.recruited_size
	}))
	self:getChild("title"):setColor(var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().jigsaw_draw_card_font_color))
	self.m_isEnoughController:setSelectedIndex(g.core.model.User.bagData:getCountById(var_2_0.recruited_type, var_2_0.recruited_value) >= var_2_0.recruited_size and 1 or 0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

return AnniversaryJigsawBtn
