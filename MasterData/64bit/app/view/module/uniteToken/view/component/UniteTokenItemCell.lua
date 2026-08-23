local var_0_0 = g.core.config.unite_token_info
local UniteTokenItemCell = class("UniteTokenItemCell", require("app.fairyGUI.uniteToken.UI_UniteTokenItemCell"))

function UniteTokenItemCell:ctor()
	self.m_buttonController = self:getController("button")
	self._viewData = nil

	self.getSharedTrans(self, "leftIn", "TapAnimationList", self)
	self:addClickListener(handler(self, self._onSelfClicked))
end

function UniteTokenItemCell:_onSelfClicked()
	if self.m_buttonController:getSelectedIndex() == 1 then
		return
	end

	local var_2_0 = self:getSize()

	self:addEffectSpine({
		isLoop = false,
		name = "eff_ui_lineup_iconcell_" .. self._quality + 1,
		x = var_2_0.width / 2,
		y = var_2_0.height / 2
	})
end

function UniteTokenItemCell:updateView(arg_3_1)
	self._viewData = arg_3_1

	local var_3_0 = self._viewData:getAdvanceId()

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = var_3_0
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp1,
		customData = {
			advId = var_3_0
		}
	})

	if self._viewData then
		self.m_levelTxt:setText("LV." .. self._viewData._level)

		local var_3_1 = var_0_0.get(self._viewData._baseId)

		self.m_itemIcon:setURL((g.core.common.Path:getUniteTokenIconById(var_3_1.res_id)))
		self.m_starComp:initStar({
			style = 2,
			index = 3,
			max = 5,
			num = var_3_1.star
		})

		self._quality = var_3_1.quality

		local var_3_2, var_3_3 = g.core.common.Path:getEquipIconQualityBg1(var_3_1.quality)

		self.m_qualityIcon:setURL(var_3_2)
		self.m_quality2Icon:setURL(var_3_3)
	end
end

return UniteTokenItemCell
