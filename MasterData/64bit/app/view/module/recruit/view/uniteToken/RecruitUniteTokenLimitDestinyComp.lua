local var_0_0 = g.core.model.User.recruitData
local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitUniteTokenLimitDestinyComp = class("RecruitUniteTokenLimitDestinyComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenLimitDestinyComp"), RecruitLimitCompBase)

function RecruitUniteTokenLimitDestinyComp:ctor()
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_stateController = self:getController("state")

	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitUniteTokenLimitDestinyComp)
		RecruitLimitCompBase.ctor(self)
	end

	self.m_recruitOneBtn:setTitle(g.core.lang:get(108107))
	self.m_recruitTenBtn:setTitle(g.core.lang:get(108108))

	if self.m_recruitTwentyBtn then
		self.m_recruitTwentyBtn:setTitle(g.core.lang:get(108428))
	end

	self._multiNum = 5
end

function RecruitUniteTokenLimitDestinyComp:_onShowUniteTokenInfo()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new(self._uniteTokenId1))
end

function RecruitUniteTokenLimitDestinyComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = self._recruitType,
		title = g.core.lang:get(108106),
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitUniteTokenLimitDestinyComp:_playShowSound()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_UI_SHOW)
end

function RecruitUniteTokenLimitDestinyComp:_initKnightTipBtn()
	local var_5_0 = ""

	for iter_5_0, iter_5_1 in ipairs(var_0_0:getDisplayInfoById(self._recruitCfg.id).displays) do
		if not self["m_uniteTokenBtn" .. iter_5_0] then
			break
		end

		self["_uniteTokenId" .. iter_5_0] = iter_5_1.knight_id

		if self["m_uniteTokenBtn" .. iter_5_0] then
			self["m_uniteTokenBtn" .. iter_5_0]:updateBtnView(iter_5_1)

			var_5_0 = g.core.config.unite_token_info.get(iter_5_1.knight_id).name
		end
	end

	self:getChild("n73"):setText(g.core.lang:get(108455, {
		name = var_5_0
	}))
	self.m_leftLoader:setURL("pic/recruit/uniteToken/pic_zm_shenmidi_1.png")
	self.m_rightLoader:setURL("pic/recruit/uniteToken/pic_zm_shenmidi_2.png")
	self.m_titleEnTextLoader:setURL("pic/recruit/uniteToken/pic_zm_titlezs_2.png")
	self.m_limitFragmentLoader:setURL("pic/recruit/uniteToken/txt_zm_gailv_5.png")
	self.m_limitTipLoader:setURL("pic/recruit/uniteToken/bg_zm_jiandingbide.png")
end

return RecruitUniteTokenLimitDestinyComp
