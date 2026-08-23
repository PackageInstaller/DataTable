local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversarySignCell = class("AnniversarySignCell", require("app.fairyGUI.anniversary.UI_AnniversarySignCell"))

function AnniversarySignCell:updateSignCell(arg_1_1)
	self.m_dayTxt:setText(g.core.utils.Number.getFormatNum(2, arg_1_1.num))
	self.m_dayTxt:setColor(var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().jigsaw_draw_number_color))
	self.m_iconLoader:setURL(g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_ITEM, arg_1_1.jigsaw_id))
	self.m_isGetController:setSelectedIndex(var_0_0:getCurSignDay() >= arg_1_1.num and 1 or 0)
end

function AnniversarySignCell:playGetSignEff()
	self.m_effGet:addEffectSpine({
		anim = "get",
		name = "eff_ui_anniversaryJigsaw_rollcube",
		remove = true,
		isLoop = false
	})
	self.m_getTodayTransition:play()
	self.m_isGetController:setSelectedIndex(1)
end

return AnniversarySignCell
