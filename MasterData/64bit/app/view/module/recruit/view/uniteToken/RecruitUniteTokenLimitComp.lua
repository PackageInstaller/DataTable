local var_0_1 = g.core.model.User.recruitData
local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitUniteTokenLimitComp = class("RecruitUniteTokenLimitComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenLimitComp"), RecruitLimitCompBase)

function RecruitUniteTokenLimitComp:ctor()
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_stateController = self:getController("state")

	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitUniteTokenLimitComp)
		RecruitLimitCompBase.ctor(self)
	end

	self.m_recruitOneBtn:setTitle(g.core.lang:get(108107))
	self.m_recruitTenBtn:setTitle(g.core.lang:get(108108))

	if self.m_recruitTwentyBtn then
		self.m_recruitTwentyBtn:setTitle(g.core.lang:get(108428))
	end

	self._multiNum = 5
end

function RecruitUniteTokenLimitComp:_onShowUniteTokenInfo()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new(self._uniteTokenId1))
end

function RecruitUniteTokenLimitComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = self._recruitType,
		title = g.core.lang:get(108106),
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitUniteTokenLimitComp:_playShowSound()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_UI_SHOW)
end

function RecruitUniteTokenLimitComp:_updateLuck()
	local var_5_0 = g.core.model.User.recruitData:getGuaranteedInfos(self._recruitType, true, true)

	if var_5_0 then
		if self._subComps.curLuckText then
			self._subComps.curLuckText:setText(var_5_0.totalTimes - var_5_0.times)
		end

		if self._subComps.maxLuckText then
			self._subComps.maxLuckText:setText("/" .. var_5_0.totalTimes)
		end

		if self._subComps.extLuckProg then
			self._subComps.extLuckProg:setSize(cc.size((var_5_0.totalTimes - var_5_0.times) / var_5_0.totalTimes * 192, 4))
		end

		if self._subComps.extLuckText then
			local var_5_1 = g.core.model.User.recruitData:getGuaranteedInfoByGuaranteedType(self._recruitType, 7) or {
				totalTimes = 0,
				times = 0
			}
			local var_5_2 = var_5_1.totalTimes - var_5_1.times

			self._subComps.extLuckText:setText(var_5_1.totalTimes - var_5_1.times)
			self._subComps.extLuckIcon:setVisible(false)

			if self._subComps.extLuckLight then
				local var_5_3 = self._subComps.extLuckLight

				self._subComps.extLuckLight:setVisible(var_5_2 > 0)

				self._effLoop = self._effLoop or var_5_3:addEffectSpine({
					isLoop = true,
					name = "eff_ui_recruit_guarantee"
				})
			end
		end
	end
end

function RecruitUniteTokenLimitComp:_updateTalk()
	return
end

function RecruitUniteTokenLimitComp:_initKnightTipBtn()
	local var_7_0 = ""

	for iter_7_0, iter_7_1 in ipairs(var_0_1:getDisplayInfoById(self._recruitCfg.id).displays) do
		if not self["m_uniteTokenBtn" .. iter_7_0] then
			break
		end

		self["_uniteTokenId" .. iter_7_0] = iter_7_1.knight_id

		if self["m_uniteTokenBtn" .. iter_7_0] then
			self["m_uniteTokenBtn" .. iter_7_0]:updateBtnView(iter_7_1)

			var_7_0 = g.core.config.unite_token_info.get(iter_7_1.knight_id).name
		end
	end

	self:getChild("n73"):setText(g.core.lang:get(108455, {
		name = var_7_0
	}))
	self.m_leftLoader:setURL("pic/recruit/uniteToken/pic_zm_shenmidi_1.png")
	self.m_rightLoader:setURL("pic/recruit/uniteToken/pic_zm_shenmidi_2.png")
	self.m_titleEnTextLoader:setURL("pic/recruit/uniteToken/pic_zm_titlezs_2.png")
	self.m_limitTipLoader:setURL("pic/recruit/uniteToken/bg_zm_jiandingbide.png")
end

function RecruitUniteTokenLimitComp:_continueRecruit(arg_8_1)
	if arg_8_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_8_1 == 5 then
		self:_onRecruitTen()
	elseif arg_8_1 == 20 then
		self:_onRecruitTwentyBtnClick()
	end
end

return RecruitUniteTokenLimitComp
