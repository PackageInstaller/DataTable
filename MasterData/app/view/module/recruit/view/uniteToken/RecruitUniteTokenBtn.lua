local var_0_0 = g.core.common.Path
local RecruitUniteTokenBtn = class("RecruitUniteTokenBtn", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenBtn"))

function RecruitUniteTokenBtn:ctor()
	self.m_icon = self:getChild("icon")
	self._midPos = self.m_icon:getPosition()
	self._uniteTokenId = nil

	self:addClickListener(handler(self, self._onShowUniteTokenDetail))
end

function RecruitUniteTokenBtn:updateBtnView(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = g.core.config.unite_token_info.get(arg_2_1.knight_id)

	self:setIcon((g.core.common.Path:getPicRes(g.core.common.Goods.TYPE_UNITETOKEN, arg_2_1.knight_id)))
	self:setTitle(var_2_0.name)
	self.m_qualityTextLoader:setURL("ui://text_new/pic_pinzhi_" .. var_2_0.quality + 1)
	self.m_qualityBg:setURL((arg_2_3 or nil) and (var_0_0:getActRecruitQualitySquareBg(var_2_0.quality) or var_0_0:getRecruitQualitySquareBg(var_2_0.quality)))
	self.m_icon:setPosition(cc.p(self._midPos.x + arg_2_1.x, self._midPos.y + arg_2_1.y))

	self._uniteTokenId = arg_2_1.knight_id

	if arg_2_2 then
		self.m_showFeatureController:setSelectedIndex(arg_2_2.feature ~= "0" and 1 or 0)
		self.m_featureText1:setText(arg_2_2.feature)
	else
		self.m_showFeatureController:setSelectedIndex(0)
	end
end

function RecruitUniteTokenBtn:_onShowUniteTokenDetail()
	if self._uniteTokenId then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new(self._uniteTokenId))
	end
end

return RecruitUniteTokenBtn
