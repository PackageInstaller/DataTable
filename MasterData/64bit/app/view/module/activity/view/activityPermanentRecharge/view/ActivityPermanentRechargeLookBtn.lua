local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local ActivityPermanentRechargeLookBtn = class("ActivityPermanentRechargeLookBtn", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeLookBtn"))

function ActivityPermanentRechargeLookBtn:ctor()
	self._goods = nil

	self:addClickListener(handler(self, self._onClick))
end

function ActivityPermanentRechargeLookBtn:initButton(arg_2_1, arg_2_2)
	self.m_skinGroup:setVisible(arg_2_2 == var_0_0.TYPE_SKIN)

	self._goods = var_0_0:convert({
		type = arg_2_2,
		value = arg_2_1
	})

	if self._goods then
		self.m_qualityImg:setURL(var_0_1:getQualityArtTxtURL(self._goods.quality))
		self.m_qualityBg:setURL(var_0_1:getUserIconQualityStarBg(self._goods.quality))
		self.m_itemNameTxt:setText(self._goods.name)

		if arg_2_2 == var_0_0.TYPE_SKIN then
			self.m_skinNameTxt:setText(g.core.model.User.knightsData:getKnightByAdvanceId(g.core.config.skin_info.get(arg_2_1).knight_advance_id or 0):getName() .. g.core.lang:get(404505))
		end
	end
end

function ActivityPermanentRechargeLookBtn:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return ActivityPermanentRechargeLookBtn
