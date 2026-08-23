local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local var_0_5 = g.core.common.Path
local CultivateWitchPassCardLayer = class("CultivateWitchPassCardLayer", require("app.fairyGUI.cultivate.UI_CultivateWitchPassCardLayer"), function()
	return fgui.GComponent:create({
		resName = "CultivateWitchPassCardLayer",
		pkgPath = "ui/cultivate/cultivate",
		isFullScreen = true,
		pkgName = "cultivate"
	}, ...)
end)

function CultivateWitchPassCardLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._actData = var_0_2:getCultivateData(self._actId)
	self._passCardData = self._actData:getPassCardData()

	self:addBg("bg/cultivate/" .. var_0_2:getResDirId(self._actId) .. "/bg_mnzj_zjm.jpg")
	self.m_oneKeyBtn:updateOneKeyBtn(self._actId)

	self._passCardList = {}

	self:initPassCardMainView()
end

function CultivateWitchPassCardLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATEPASSCARD, handler(self, self._onCultivateActivityUpdatePassCard), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_PASSCARDGIFT, handler(self, self._onCultivateActivityGetPassCardReward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onCulRecharge), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	local var_3_0 = var_0_2:getCultivateData(self._actId)
	local var_3_1 = var_3_0:getPassCardData()

	if not var_0_2:getCultivateData(self._actId).getPassCardData(var_3_1).isPassCardOpen(var_3_0) and var_3_1:isCanActivePassCard() then
		self._isUnlock = true
	end

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end

	self.m_enterTransition:play(handler(self, self._onEnterFinish))

	if self._isUnlock then
		self._isUnlock = false

		self.m_eff:addEffectSpine({
			remove = true,
			isLoop = false,
			name = g.core.config.cultivate_activity_display_info.get(self._actId).effect
		})
	end
end

function CultivateWitchPassCardLayer:_onEnterFinish()
	local var_4_0 = var_0_2:getCultivateData(self._actId)
	local var_4_1 = var_4_0:getPassCardData()

	if not var_0_2:getCultivateData(self._actId).getPassCardData(var_4_1).isPassCardOpen(var_4_0) and var_4_1:isCanActivePassCard() then
		local var_4_2 = {
			activity_id = self._actId
		}
		local var_4_3 = {}

		var_4_3[1] = self._actData:getPassCardData():getPassCardIdByLv(1)
		var_4_2.passcard_ids = var_4_3

		g.core.network.GameNetProxy:send_C2S_CultivateActivity_PasscardGift(var_4_2)
	end
end

function CultivateWitchPassCardLayer:_onCrossDayUpdate()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = self._actId
		})
	end
end

function CultivateWitchPassCardLayer:_onCulRecharge(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.cultivate_activity_passcard then
		g.core.module.ModuleManager:awardSummary(arg_6_4.cultivate_activity_passcard.awards or {})
	end

	self:updatePassCardView()
end

function CultivateWitchPassCardLayer:initPassCardMainView()
	local var_7_0 = g.core.config.cultivate_activity_display_info.get(self._actData:getActivityCfg().id)

	self.m_topBarComp:setResInfoById(var_7_0.interface_passcard)
	self.m_topBarComp:setTitle(var_7_0.module_passcard)
	self.m_passCardList:setVirtual()
	self.m_passCardList:setItemRenderer(handler(self, self._onPassCardRenderer))
	self.m_passCardList:doFairyBatching(false)
	self.m_textLoader:setURL(var_0_5:getCultivateMulLangImage("txt_mnzj_tishi2", var_0_2:getResDirId(self._actId)))
	self.m_passCardBgLoader:setURL(var_0_5:getCultivateImage("pic_bg_mnzj_zhanlingdikuang", var_0_2:getResDirId(self._actId)))
	self.m_passTitleBg:setURL(var_0_5:getCultivateImage("pic_bg_mnzj_zhanlingtitledi", var_0_2:getResDirId(self._actId)))
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_7_0.color_time)))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self:_addAssistant()
	self:updatePassCardView()
end

function CultivateWitchPassCardLayer:_addAssistant()
	self.m_knightComp:removeChildren()

	local var_8_0 = self._actData:getActivityCfg().recruit_route
	local var_8_1 = {
		resId = var_8_0 > 0 and var_8_0 or 20700720,
		dir_res = var_8_0 > 0 and var_8_0 or 20700720
	}

	var_8_1.isShowBg = false
	var_8_1.isAlphaNode = true

	self.m_knightComp:addChild((DrawSuccuba.new(var_8_1)))
end

function CultivateWitchPassCardLayer:updatePassCardView()
	self:updateOneKeyState()
	self:updatePassCardTime()

	local var_9_0 = self._actData:getPassCardData()

	self._passCardList = var_9_0:getPassCardList()

	self.m_passCardList:setNumItems(#self._passCardList)
	self.m_passCardList:scrollToView(var_9_0:getLevel() - 1)
end

function CultivateWitchPassCardLayer:updatePassCardTime()
	local var_10_0, var_10_1, var_10_2, var_10_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_10_0,
		hour = var_10_1
	}))
end

function CultivateWitchPassCardLayer:updateOneKeyState()
	self.m_oneKeyBtn:setVisible(#self._actData:getPassCardData():getMulFreeRewards() >= 3)
end

function CultivateWitchPassCardLayer:_onOneKeyClick()
	g.core.network.GameNetProxy:send_C2S_CultivateActivity_PasscardGift({
		activity_id = self._actId,
		passcard_ids = self._actData:getPassCardData():getMulFreeRewards()
	})
end

function CultivateWitchPassCardLayer:_onPassCardRenderer(arg_13_1, arg_13_2)
	arg_13_2:updatePassCardCell(self._passCardData:getLevelRewards(self._passCardList[arg_13_1 + 1].level), arg_13_1 + 1, self._actId)
end

function CultivateWitchPassCardLayer:_onCultivateActivityUpdatePassCard(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:updatePassCardView()
end

function CultivateWitchPassCardLayer:_onCultivateActivityGetPassCardReward(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	g.core.module.ModuleManager:awardSummary(arg_15_4.awards)
	self:updatePassCardView()
end

return CultivateWitchPassCardLayer
