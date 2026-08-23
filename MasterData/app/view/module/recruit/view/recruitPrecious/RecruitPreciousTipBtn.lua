local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local RecruitPreciousTipBtn = class("RecruitPreciousTipBtn", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousTipBtn"))

function RecruitPreciousTipBtn:ctor()
	self._suitCfg = nil

	self:addClickListener(handler(self, self._onClickSearchBtn))
end

function RecruitPreciousTipBtn:updateComp(arg_2_1)
	self._suitCfg = g.core.config.precious_suit_info.match(function(arg_3_0)
		return arg_3_0.suit_group == arg_2_1.knight_id
	end)[1]

	self:setTitle(self._suitCfg.name)
	self.m_titleRight:setText(self._suitCfg.name)
	self:_updateSuitIcon()

	if self._suitCfg.quality > var_0_0.SSR then
		self.m_qualityBg:setURL("ui://base_new/pic_zm_gzp_yuan_" .. self._suitCfg.quality + 1)
	else
		self.m_qualityBg:setURL("ui://base_new/pic_zm_gzp_yuan_4")
	end
end

function RecruitPreciousTipBtn:_updateSuitIcon()
	for iter_4_0 = 1, 99 do
		if not self["m_preciousComp" .. iter_4_0] then
			break
		end

		self["m_preciousComp" .. iter_4_0]:updatePreciousComp(self._suitCfg["precious_id_" .. iter_4_0])
	end
end

function RecruitPreciousTipBtn:_onClickSearchBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.precious.view.PreciousSuitInfoPop").new({
		suitStruct = g.core.model.User.preciousData:getPreciousSuitByGroup(self._suitCfg.suit_group)
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

return RecruitPreciousTipBtn
