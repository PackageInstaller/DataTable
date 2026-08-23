local var_0_0 = g.core.model.User.recruitData
local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitComonUIUniteTokenCfg = require("app.view.module.recruit.const.RecruitLimitComonUIUniteTokenCfg")
local RecruitUniteTokenComLimitComp = class("RecruitUniteTokenComLimitComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenComLimitComp"), RecruitLimitCompBase)

function RecruitUniteTokenComLimitComp:ctor()
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_stateController = self:getController("state")

	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitUniteTokenComLimitComp)
		RecruitLimitCompBase.ctor(self)
	end

	self.m_recruitOneBtn:setTitle(g.core.lang:get(108107))
	self.m_recruitTenBtn:setTitle(g.core.lang:get(108108))

	if self.m_recruitTwentyBtn then
		self.m_recruitTwentyBtn:setTitle(g.core.lang:get(108428))
	end

	self._multiNum = 5
end

function RecruitUniteTokenComLimitComp:_initOtherUI()
	local var_2_0 = RecruitLimitComonUIUniteTokenCfg.getUICfg(self._recruitCfg.id)

	self.m_titleLoader:setURL(var_2_0.titleRes)
	self.m_titleLoader:setPosition(cc.pAdd(self.m_titleLoader:getPosition(), var_2_0.titleOffset))
	self.m_titleEnTextLoader:setURL(var_2_0.titleEnTextRes)
	self.m_titleEnTextShadowLoader:setURL(var_2_0.titleEnShadowTextRes)
	self.m_limitTipLoader:setURL(var_2_0.limitTimesTipBgRes)
	self.m_limitTipLoader:setPosition(cc.pAdd(self.m_limitTipLoader:getPosition(), var_2_0.limitTimesTipBgOffset))
	self.m_leftLoader:setURL(var_2_0.leftBgRes)
	self.m_rightLoader:setURL(var_2_0.rightBgRes)
	self.m_limitFragmentLoader:setURL(var_2_0.limitTimesTipFragmentRes)
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.UNITE_TAB)
end

function RecruitUniteTokenComLimitComp:_onShowUniteTokenInfo()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new(self._uniteTokenId1))
end

function RecruitUniteTokenComLimitComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = self._recruitType,
		title = g.core.lang:get(108106),
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitUniteTokenComLimitComp:_playShowSound()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_UI_SHOW)
end

function RecruitUniteTokenComLimitComp:_initKnightTipBtn()
	local var_6_0 = var_0_0:getDisplayInfoById(self._recruitCfg.id)
	local var_6_1 = ""

	for iter_6_0, iter_6_1 in ipairs(var_6_0.displays) do
		if not self["m_uniteTokenBtn" .. iter_6_0] then
			break
		end

		self["_uniteTokenId" .. iter_6_0] = iter_6_1.knight_id

		if self["m_uniteTokenBtn" .. iter_6_0] then
			self["m_uniteTokenBtn" .. iter_6_0]:updateBtnView(iter_6_1, var_6_0.cfg)

			var_6_1 = g.core.config.unite_token_info.get(iter_6_1.knight_id).name
		end
	end

	self:getChild("n73"):setText(g.core.lang:get(108455, {
		name = var_6_1
	}))
end

function RecruitUniteTokenComLimitComp:_updateLuck()
	local var_7_0 = g.core.model.User.recruitData:getGuaranteedInfos(self._recruitType, true, true)

	if var_7_0 then
		if self._subComps.curLuckText then
			self._subComps.curLuckText:setText(var_7_0.totalTimes - var_7_0.times)
		end

		if self._subComps.maxLuckText then
			self._subComps.maxLuckText:setText("/" .. var_7_0.totalTimes)
		end

		if self._subComps.extLuckProg then
			self._subComps.extLuckProg:setSize(cc.size((var_7_0.totalTimes - var_7_0.times) / var_7_0.totalTimes * 192, 4))
		end

		if self._subComps.extLuckText then
			local var_7_1 = g.core.model.User.recruitData:getGuaranteedInfoByGuaranteedType(self._recruitType, 7) or {
				times = 0,
				totalTimes = 0
			}
			local var_7_2 = var_7_1.totalTimes - var_7_1.times

			self._subComps.extLuckText:setText(var_7_1.totalTimes - var_7_1.times)
			self._subComps.extLuckIcon:setVisible(false)

			if self._subComps.extLuckLight then
				local var_7_3 = self._subComps.extLuckLight

				self._subComps.extLuckLight:setVisible(var_7_2 > 0)

				self._effLoop = self._effLoop or var_7_3:addEffectSpine({
					isLoop = true,
					name = "eff_ui_recruit_guarantee"
				})
			end
		end
	end
end

function RecruitUniteTokenComLimitComp:_continueRecruit(arg_8_1)
	if arg_8_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_8_1 == 5 then
		self:_onRecruitTenBtnClick()
	elseif arg_8_1 == 20 then
		self:_onRecruitTwentyBtnClick()
	end
end

return RecruitUniteTokenComLimitComp
