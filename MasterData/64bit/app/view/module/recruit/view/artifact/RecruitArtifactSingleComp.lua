local RecruitArtifactSingleComp = class("RecruitArtifactSingleComp", require("app.fairyGUI.recruitArtifact.UI_RecruitArtifactSingleComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local var_0_6 = g.core.const.ConstMgr.SoundConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitArtifactSingleComp:ctor()
	self._wishInfos = {}

	self:_addListeners()
	self:_init()
end

function RecruitArtifactSingleComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_detailGroupComp:setHideFunc(handler(self, self._hideUpDetail))
	self.m_upGroupBtn:addClickListener(handler(self, self._showDetail))
	RecruitFuncCfg.addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.ARTIFACT_TAB)
end

function RecruitArtifactSingleComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		title = g.core.lang:get(108412),
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.ARTIFACT_BASE,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitArtifactSingleComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		justShow = true,
		knightId = 400040
	}))
end

function RecruitArtifactSingleComp:_onRecruitOneBtnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_5_0 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)
	local var_5_1 = var_5_0:getDailyLimitNum()

	if var_5_0:getDailyCount() >= var_5_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108414, {
			num = var_5_1
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if var_0_2:checkIsFull(self._cfg) then
		local var_5_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_5_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_6_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_6_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function RecruitArtifactSingleComp:_doRecruitOneTimes()
	local var_7_0, var_7_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_7_2 = g.core.model.User.recruitData:getBuyHelper()

	var_7_2:setRecruitType(self._cfg.type)
	var_7_2:setRecruitId(self._cfg.id)
	var_7_2:setRecruitNum(1)

	local var_7_3 = var_7_2:getCurBuyItemInfo()
	local var_7_4 = {
		num = 1,
		itemInfo = var_7_3,
		recruitType = self._cfg.type,
		consumeType = var_7_1.requestType
	}

	if self:_isFree() then
		var_7_4.consumeType = 0
		var_7_4.itemInfo = nil
		var_7_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_7_3, var_7_4, 1, 0)
end

function RecruitArtifactSingleComp:_onRecruitGetTaskAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
end

function RecruitArtifactSingleComp:_onRecruitTenBtnClick()
	local var_9_0 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)
	local var_9_1 = var_9_0:getDailyLimitNum()

	if var_9_1 < var_9_0:getDailyCount() + 10 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108414, {
			num = var_9_1
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if var_0_2:checkIsFull(self._cfg) then
		local var_9_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_9_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_10_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_10_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function RecruitArtifactSingleComp:_doRecruitTenTimes()
	local var_11_0, var_11_1 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_11_2 = g.core.model.User.recruitData:getBuyHelper()

	var_11_2:setRecruitNum(10)
	var_11_2:setRecruitType(self._cfg.type)
	var_11_2:setRecruitId(self._cfg.id)

	local var_11_3 = var_11_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_11_3, {
		itemInfo = var_11_3,
		recruitType = self._cfg.type,
		consumeType = var_11_1.requestType,
		num = 10
	}, 1, 0)
end

function RecruitArtifactSingleComp:_isFree()
	return false
end

function RecruitArtifactSingleComp:_reqRecruitNetWork(arg_13_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_13_1.consumeType,
		num = arg_13_1.num
	})
end

function RecruitArtifactSingleComp:_init()
	self:addListen(self.m_wishComp)

	self._cfg = var_0_2:getRecruitKnightCfgById(100007)
	self._displayCfg = var_0_2:getDisplayInfoById(100007)

	self.m_arrowNode:addEffectSpine({
		anim = "play2",
		isLoop = true,
		name = "eff_ui_recruitPrimary_qianwang"
	})
	self:_showDetail()
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitArtifactSingleComp:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitArtifactSingleComp:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitArtifactWishPop").new(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE, self._cfg.id))

		return true
	end

	return false
end

function RecruitArtifactSingleComp:_resRecruit()
	return
end

function RecruitArtifactSingleComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)

	self.m_wishComp:updateComp(self._wishInfos, var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)
	self:_updateRecruitNum()
	self:_updateCost()
	self.m_minimumText:setText(g.core.model.User.recruitData:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE).times)
	self.m_detailGroupComp:updateComp((g.core.model.User.recruitData:getAllWishArtifactById()))

	if self.m_detailGroupComp:getUpListNum() > 0 then
		self.m_openWishController:setSelectedIndex(1)
	else
		self.m_openWishController:setSelectedIndex(0)
	end

	local var_18_0 = g.core.model.User.recruitData:getLimitNearTime()

	if var_18_0 > 0 then
		self:newScheduleOnce(handler(self, self._syncWishInfo), var_18_0 - g.core.common.ServerTime:getTime())
	end
end

function RecruitArtifactSingleComp:setLuckTimeText(arg_19_1, arg_19_2)
	self._curLuckText = arg_19_1
	self._maxLuckText = arg_19_2
end

function RecruitArtifactSingleComp:_updateRecruitNum()
	return
end

function RecruitArtifactSingleComp:_updateCost()
	local var_21_0, var_21_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_21_0,
		isFree = self:_isFree(),
		goods = var_21_1
	})

	local var_21_2, var_21_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_21_2,
		goods = var_21_3
	})
end

function RecruitArtifactSingleComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitArtifactSingleComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_UI_SHOW)
end

function RecruitArtifactSingleComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function RecruitArtifactSingleComp:playHide(arg_25_1)
	self.m_backTransition:play(arg_25_1)
end

function RecruitArtifactSingleComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitArtifactSingleComp:updateByCfg(arg_27_1)
	self._tabType = arg_27_1.ownerType

	self.m_leftLoader:setURL("ui://recruit/bg_zm_zw_dc_" .. arg_27_1.knightCtrlCfg.res .. "_2")
	self.m_rightLoader:setURL("ui://recruit/bg_zm_zw_dc_" .. arg_27_1.knightCtrlCfg.res .. "_3")
	self.m_txtLoader1:setURL("ui://text_new/txt_zm_zw_dc_" .. arg_27_1.knightCtrlCfg.res .. "_1")
	self.m_txtLoader2:setURL("ui://recruit/txt_zm_zw_dc_" .. arg_27_1.knightCtrlCfg.res .. "_2")

	if self.m_knightBtn1 then
		self.m_knightBtn1:updateComp({
			knight_id = arg_27_1.knightCtrlCfg.up_content_value,
			x = arg_27_1.knightCtrlCfg.artifact_x_1,
			y = arg_27_1.knightCtrlCfg.artifact_y_1
		}, false, true)
	end
end

function RecruitArtifactSingleComp:playRecruitAction(arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	if arg_28_5 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_28_1
	self._highQuality = 0

	for iter_28_0 = 1, #arg_28_1.awards do
		local var_28_0 = g.core.common.Goods:convert(arg_28_1.awards[iter_28_0])

		self._highQuality = math.max(self._highQuality, var_28_0.quality)
		arg_28_1.awards[iter_28_0].isNew = g.core.model.User.recruitData:checkIsNewArtifact(arg_28_1.awards[iter_28_0].value)
		arg_28_1.awards[iter_28_0].quality = var_28_0.quality
		arg_28_1.awards[iter_28_0].id = iter_28_0
	end

	arg_28_3:playShow(self._highQuality, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function RecruitArtifactSingleComp:_getMovieList()
	local var_29_0 = {}
	local var_29_1 = g.core.model.User.recruitData:isNewPlayer()

	if (self._content.recruit_type == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.Base and "daily" or "night") == "night" then
		if self._actionsParams.numStr == "Ten" then
			local var_29_2 = {
				sound = var_0_6.Sound.RECRUIT_RAINY
			}

			var_29_2.moduleName = "recruit"
			var_29_2.movieName = "recruitPremiumBase_1648x1000_5770"
			var_29_2.id = "enter"
			var_29_2.fullScreenState = 2

			table.insert(var_29_0, var_29_2)

			local var_29_3 = {}

			var_29_3.moduleName = "recruit"
			var_29_3.movieName = "recruitPremiumLoop_1648x1000_5130"
			var_29_3.id = "push"
			var_29_3.fullScreenState = 2

			table.insert(var_29_0, var_29_3)
		else
			local var_29_4 = {
				sound = var_0_6.Sound.RECRUIT_SUNNY
			}

			var_29_4.moduleName = "recruit"
			var_29_4.movieName = "recruitPremiumBase_1648x1000_5770"
			var_29_4.id = "enter"
			var_29_4.fullScreenState = 2

			table.insert(var_29_0, var_29_4)

			local var_29_5 = {}

			var_29_5.moduleName = "recruit"
			var_29_5.movieName = "recruitPremiumLoop_1648x1000_5130"
			var_29_5.id = "push"
			var_29_5.fullScreenState = 2

			table.insert(var_29_0, var_29_5)
		end
	end

	local var_29_6 = "Blue"
	local var_29_7 = var_0_6.Sound.RECRUIT_TUIJING_BLUE

	if self._highQuality == 2 then
		var_29_6 = "Violet"
		var_29_7 = var_0_6.Sound.RECRUIT_TUIJING_PURPLE
	elseif self._highQuality == 3 then
		var_29_6 = "Golden"
		var_29_7 = var_0_6.Sound.RECRUIT_TUIJING_ORANGE
	elseif self._highQuality == 4 then
		var_29_6 = "Colour"
	end

	local var_29_8 = {
		sound = var_29_7
	}

	var_29_8.moduleName = "recruit"
	var_29_8.movieName = "recruitPremiumOutcome" .. self._actionsParams.numStr .. var_29_6 .. "_1648x1000_5430"
	var_29_8.id = "show"
	var_29_8.canJump = not var_29_1
	var_29_8.autoRemove = false
	var_29_8.fullScreenState = 2
	var_29_8.events = {
		complete = {
			handler = handler(self, self._onPlayPassEffect)
		}
	}

	table.insert(var_29_0, var_29_8)

	return var_29_0
end

function RecruitArtifactSingleComp:_onUserClick(arg_30_1, arg_30_2)
	if not arg_30_1 then
		return
	end

	if arg_30_1[1].id == "loop" then
		arg_30_2:jump()
	end
end

function RecruitArtifactSingleComp:_onPlayPassEffect(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	self:_moviePlayEnd(arg_31_5)
end

function RecruitArtifactSingleComp:_moviePlayEnd(arg_32_1)
	if self._actionsParams then
		self._actionsParams = nil

		arg_32_1:setPlayEndNormal(true)

		if self._highQuality > 2 then
			arg_32_1:clearKeepCriSpites()
			self:_goToRewardLayer()
		else
			arg_32_1:clearKeepCriSpites()
			self:_goToRewardLayer()
		end
	end

	arg_32_1:playHide()
end

function RecruitArtifactSingleComp:_playSSRAction(arg_33_1)
	arg_33_1:clearKeepCriSpites()
end

function RecruitArtifactSingleComp:_goToRewardLayer()
	local var_34_0 = clone(self._content)

	var_34_0.callBack = handler(self, self.onLoad)
	var_34_0.cfg = self._cfg
	var_34_0.matchQuality = self._cfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_ARTIFACT_REWARD, var_34_0)
end

function RecruitArtifactSingleComp:_hideUpDetail()
	self.m_detailGroupComp:playHide(handler(self, self._hideUpDetailCtr))
end

function RecruitArtifactSingleComp:_hideUpDetailCtr()
	self.m_showUpDetailController:setSelectedIndex(0)
end

function RecruitArtifactSingleComp:_showDetail()
	self.m_showUpDetailController:setSelectedIndex(1)
	self.m_detailGroupComp:playShow()
end

function RecruitArtifactSingleComp:_syncWishInfo()
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
end

function RecruitArtifactSingleComp:onContinueRecruit(arg_39_1)
	if arg_39_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_39_1 == 10 then
		self:_onRecruitTenBtnClick()
	end
end

return RecruitArtifactSingleComp
