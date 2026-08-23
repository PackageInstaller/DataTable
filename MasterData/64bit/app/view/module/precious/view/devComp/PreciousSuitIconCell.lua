local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.PreciousConst
local PreciousSuitIconCell = class("PreciousSuitIconCell", require("app.fairyGUI.precious.UI_PreciousSuitIconCell"))

function PreciousSuitIconCell:ctor()
	self._quality = 0
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
end

function PreciousSuitIconCell:updateSuitIconCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1:getCfg()

	self._quality = arg_2_1:getQuality()

	self.m_suitIconLoader:setURL(var_0_0:getPreciousSuitIconByResId(var_2_0.icon))
	self.m_suitNameText:setText(var_2_0.name)
	self.m_starComp:initStar({
		style = 2,
		index = 3,
		gap = 4,
		max = var_0_2.SUIT_MAX_STAR_NUM,
		num = arg_2_1:getStar()
	})

	local var_2_1, var_2_2, var_2_3 = var_0_0:getLineUpQualityBg(self._quality)

	self.m_qualityBg:setURL(var_2_1)
	self.m_qualitySelectBgLeft:setURL(var_2_2)
	self.m_qualitySelectBgRight:setURL(var_2_3)

	local var_2_4 = arg_2_1:isActivate()

	self.m_isActiveController:setSelectedIndex(var_2_4 and 1 or 0)

	if not var_2_4 then
		local var_2_5 = arg_2_1:getOwnPreciousNum()

		for iter_2_0 = 1, 3 do
			self["m_haveLoader" .. iter_2_0]:setURL(iter_2_0 <= var_2_5 and "ui://precious/pic_gzp_dianliang1" or "ui://precious/pic_gzp_dianliang2")
		end
	end

	local var_2_6 = 0

	if arg_2_1:isCanActivate() then
		var_2_6 = 1
	elseif arg_2_1:isCanStarUp() then
		var_2_6 = 2
	end

	self.m_stateController:setSelectedIndex(var_2_6)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			group = arg_2_1:getSuitGroup()
		}
	})
end

function PreciousSuitIconCell:_onButtonStateChange()
	if self.m_buttonController:getSelectedIndex() ~= 0 then
		self.m_effectHolder:addEffectSpine({
			isLoop = false,
			remove = true,
			name = "eff_ui_lineup_iconcell_" .. math.clamp(self._quality, var_0_1.QUALITY_TYPE.NONE, var_0_1.QUALITY_TYPE.MAX_QUALITY) + 1
		})
	end
end

return PreciousSuitIconCell
