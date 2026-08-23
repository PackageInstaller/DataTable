local var_0_0 = g.core.model.User.recruitData
local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitUniteTokenLimitPoisonComp = class("RecruitUniteTokenLimitPoisonComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenLimitPoisonComp"), RecruitLimitCompBase)

function RecruitUniteTokenLimitPoisonComp:ctor()
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_stateController = self:getController("state")

	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitUniteTokenLimitPoisonComp)
		RecruitLimitCompBase.ctor(self)
	end

	self.m_recruitOneBtn:setTitle(g.core.lang:get(108107))
	self.m_recruitTenBtn:setTitle(g.core.lang:get(108108))

	if self.m_recruitTwentyBtn then
		self.m_recruitTwentyBtn:setTitle(g.core.lang:get(108428))
	end

	self._multiNum = 5
end

function RecruitUniteTokenLimitPoisonComp:_onShowUniteTokenInfo()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new(self._uniteTokenId1))
end

function RecruitUniteTokenLimitPoisonComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = self._recruitType,
		title = g.core.lang:get(108106),
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitUniteTokenLimitPoisonComp:_playShowSound()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_UI_SHOW)
end

function RecruitUniteTokenLimitPoisonComp:_initKnightTipBtn()
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
end

return RecruitUniteTokenLimitPoisonComp
