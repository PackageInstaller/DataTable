local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.const.ConstMgr.LineUpConst
local GuideConst = require("app.view.module.guide.const.GuideConst")
local var_0_5 = g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX
local var_0_6 = g.core.model.User.knightsData
local var_0_7 = g.core.common.ModuleUnlock
local var_0_8 = g.core.event.EventManager
local var_0_9 = g.core.module.ModuleManager
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local LineUpMainLayer = class("LineUpMainLayer", require("app.fairyGUI.lineUp.UI_LineUpMainLayer"), function()
	return fgui.GComponent:create({
		resName = "LineUpMainLayer",
		pkgPath = "ui/lineUp/lineUp",
		isFullScreen = true,
		pkgName = "lineUp"
	}, ...)
end)

function LineUpMainLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._selectedIdxCpp = math.clamp(arg_2_1.index or 0, 0, var_0_5)
	self._waitStateCount = 0
	self._backFromCultivation = false
	self._firstIn = true
	self._lineupSSRKnight = false
	self._listPos = self.m_lineUpList:getPosition()
	self._knightSidArr = {}

	var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end, 1)
	self:_initView()
end

function LineUpMainLayer:_initView()
	self:_initTransParams()
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_topBar:setResInfoById(var_0_3.TopBarId)
	self.m_lineUpList:setVirtual()
	self.m_lineUpList:doFairyBatching(false)
	self.m_lineUpList:setItemRenderer(handler(self, self._onLineUpItemRenderer))
	self.m_lineUpList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickLineUpItem))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_gotoPetLineupBtn:addClickListener(handler(self, self._onClickGotoPetLineupBtn))
	self.m_recommendBtn:addClickListener(handler(self, self._onClickRecommendBtn))

	self._lineupSSRKnight = var_0_6:hasLineUpSSR()
end

function LineUpMainLayer:_initTransParams()
	local var_5_0 = {
		self._listPos.x - 40,
		self._listPos.y
	}
	local var_5_1 = {
		self._listPos.x,
		self._listPos.y
	}

	self.m_enterTransition:changeParams({
		startFlag = var_5_0,
		endFlag = var_5_1
	})
	self.m_backTransition:changeParams({
		startFlag = var_5_1,
		endFlag = var_5_0
	})
end

function LineUpMainLayer:onLoad()
	var_0_8:addEventListener(var_0_0.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onS2CChangeFormation, self)
	var_0_8:addEventListener(var_0_0.EVENT_NET_S2C_KNIGHT_INHERITFORMATION, self._onS2CInheritFormation, self)
	var_0_8:addEventListener(var_0_0.EVENT_SELECTED_KNIGHT_CHANGE, self._onSelectedIdxChanged, self)
	var_0_8:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_formationBtn
	})
	var_0_8:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_gotoPetLineupBtn
	})

	self._firstIn = true

	self.m_gotoPetLineupBtn:setVisible((var_0_7:isModuleUnlock(var_0_2.PET)))

	if not self._backFromCultivation then
		self:_updateData()
		self:_updateView(self._selectedIdxCpp, true)
		self:newScheduleOnce(handler(self, self._checkKnightWeakGuidance), 0.5)
	end
end

function LineUpMainLayer:onUnload()
	KnightVoiceCommon.stopVoice()

	if self._waitStateCount > 0 then
		for iter_7_0 = 1, self._waitStateCount do
			var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
		end

		self._waitStateCount = 0
	end

	var_0_8:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:cancelAllSchedule()
end

function LineUpMainLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "COMP_EVENT_ENTER_ANI_END" then
		self._waitStateCount = self._waitStateCount - 1

		var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	elseif arg_8_1 == "COMP_EVENT_ENTER_DEVELOP_LAYER" then
		self._backFromCultivation = true
	end
end

function LineUpMainLayer:_onSelectedIdxChanged(arg_9_1, arg_9_2)
	self:_updateView(arg_9_2, true)
end

function LineUpMainLayer:_onS2CChangeFormation(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.tp ~= g.core.network.proto.TYPE_KNIGHT then
		return
	end

	if self:_getSelectedSid() > 0 then
		var_0_9:tip(g.core.lang:get(200006))
	else
		var_0_9:tip(g.core.lang:get(200007))
	end

	if not self._lineupSSRKnight and var_0_6:hasLineUpSSR() then
		self._lineupSSRKnight = true

		var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = GuideConst.ENUM_TICK.FIRST_LINEUP_SSR
		})
	end

	var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_CHECK_PREDESTINATION_TICKED)
	KnightVoiceCommon.playVoice({
		voiceType = "inbattle_sound",
		knight = var_0_6:getKnight({
			id = arg_10_3.id
		})
	})
	self:_updateData()
	self:_updateView(arg_10_3.pos - 1, true)

	if self._knightSidArr[6] ~= 0 then
		self:newScheduleOnce(function()
			self:_checkKnightWeakGuidance()
		end, 0.5)
	end
end

function LineUpMainLayer:_onS2CInheritFormation(arg_12_1, arg_12_2, arg_12_3)
	var_0_9:tip(g.core.lang:get(200013))
	self:_updateData()
	self:_updateView(arg_12_3.pos - 1, true)

	if not self._lineupSSRKnight and var_0_6:hasLineUpSSR() then
		var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = GuideConst.ENUM_TICK.FIRST_LINEUP_SSR
		})
	end

	var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_CHECK_PREDESTINATION_TICKED)
	KnightVoiceCommon.playVoice({
		voiceType = "inbattle_sound",
		knight = var_0_6:getKnight({
			id = self:_getSelectedSid()
		})
	})

	if arg_12_3.award then
		var_0_9:awardSummary(arg_12_3.award, false, nil, g.core.lang:get(200014))
	end
end

function LineUpMainLayer:_onLineUpItemRenderer(arg_13_1, arg_13_2)
	arg_13_2:updateCell({
		pos = arg_13_1 + 1,
		sid = self._knightSidArr[arg_13_1 + 1]
	})
end

function LineUpMainLayer:_onClickLineUpItem(arg_14_1)
	local var_14_0 = self.m_lineUpList:getSelectedIndex()

	if var_14_0 == self._selectedIdxCpp then
		if (self._knightSidArr[var_14_0 + 1] or 0) == 0 then
			self.m_lineUpComp:onClickAddBtn()
		end

		return
	end

	var_0_8:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)

	local var_14_2 = self:_getLineupFuncId(var_14_0 + 1)

	if var_0_7:isModuleUnlock(var_14_2) then
		KnightVoiceCommon.stopVoice()
		self:_updateView(var_14_0, false)
	else
		self.m_lineUpList:setSelectedIndex(self._selectedIdxCpp)
		var_0_9:tip(var_0_7:getUnlockTxt(var_14_2))
	end
end

function LineUpMainLayer:_onFormationBtnClick()
	var_0_9:pushModule(g.view.entrance.FORMATION)
end

function LineUpMainLayer:_onClickGotoPetLineupBtn()
	var_0_9:replaceModule(g.view.entrance.LINE_UP_PET)
end

function LineUpMainLayer:_onClickRecommendBtn()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RECOMMEND_KNIGHT) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_RECOMMEND)
	end
end

function LineUpMainLayer:_checkKnightWeakGuidance()
	if (self._knightSidArr[5] or 0) == 0 and (self._knightSidArr[4] or 0) > 0 then
		if var_0_7:isModuleUnlock(var_0_2.KNIGHT_LINE_UP_5) then
			var_0_8:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "LINE_POS_5",
				targetBtn = self.m_lineUpList:getChildAt(4)
			})
		end
	elseif var_0_7:isModuleUnlock(var_0_2.KNIGHT_PARTNER_1) then
		if var_0_6:getLineupKnightCount() >= var_0_5 and #var_0_6:getOwnerAllList() > var_0_5 then
			local var_18_1 = false

			for iter_18_0 = 1, var_0_1.KNIGHT_CONST.SHOW_PARTNER_NUM do
				if self._knightSidArr[var_0_5 + iter_18_0] ~= 0 then
					var_18_1 = true

					break
				end
			end

			if not var_18_1 then
				var_0_8:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "FATE_STEP_0",
					targetBtn = self.m_formationBtn
				})
			end
		end
	end
end

function LineUpMainLayer:_updateData()
	self._knightSidArr = var_0_6:getFormationKnights()
end

function LineUpMainLayer:_updateView(arg_20_1, arg_20_2)
	self._selectedIdxCpp = arg_20_1

	if arg_20_2 then
		self.m_lineUpList:setNumItems(var_0_5)
		self.m_lineUpList:setSelectedIndex(arg_20_1)
		self.m_lineUpList:transitionShowCells("enter", 0.06)
	end

	self:_updateMainComp(arg_20_1)
end

function LineUpMainLayer:_updateMainComp(arg_21_1)
	self.m_lineUpComp:updateComp(arg_21_1 + 1, self._knightSidArr[arg_21_1 + 1])

	if self._waitStateCount > 0 then
		for iter_21_0 = 1, self._waitStateCount do
			var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
		end

		self._waitStateCount = 0
	end

	var_0_8:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)

	self._waitStateCount = self._waitStateCount + 1

	if self._firstIn then
		self._firstIn = false

		if self._backFromCultivation then
			self._backFromCultivation = false

			self.m_lineUpComp:playEnterAni(var_0_3.EnterAniType.ENTER_FROM_CULTIVATE)
		else
			self.m_lineUpComp:playEnterAni(var_0_3.EnterAniType.ENTER)
		end
	else
		self.m_lineUpComp:playEnterAni(var_0_3.EnterAniType.SWITCH)
	end
end

function LineUpMainLayer:_getLineupFuncId(arg_22_1)
	return var_0_2[var_0_3.KNIGHT_LINE_UP_FUNC_ID_PRE_KEY .. arg_22_1]
end

function LineUpMainLayer:_getSelectedSid()
	return self._knightSidArr[self._selectedIdxCpp + 1] or 0
end

return LineUpMainLayer
