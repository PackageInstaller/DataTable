local CompetitionDetailBtn = class("CompetitionDetailBtn", require("app.fairyGUI.competition.UI_CompetitionDetailBtn"))

function CompetitionDetailBtn:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function CompetitionDetailBtn:initBtnInfo(arg_2_1)
	self._goods = g.core.common.Goods:convert(arg_2_1)

	if arg_2_1 and arg_2_1.type == g.core.common.Goods.TYPE_SKIN then
		self.m_isSkinController:setSelectedIndex(1)
		self.m_descTxt:setText(g.core.config.knight_info.get(g.core.config.skin_info.fetch(arg_2_1.value).knight_advance_id).name .. g.core.lang:get(408713))
	else
		self.m_isSkinController:setSelectedIndex(0)
	end

	self.m_nameText:setText(self._goods.name)
	self.m_bgLoader:setURL("ui://base_new/bg_zm_pinzhi_" .. self._goods.quality + 1)
	self.m_qualityTextLoader:setURL("ui://text_new/pic_pinzhi_" .. self._goods.quality + 1)
end

function CompetitionDetailBtn:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return CompetitionDetailBtn
