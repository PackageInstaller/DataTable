local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_4 = g.core.common.Path
local CultivatePassCardLayer = class("CultivatePassCardLayer", require("app.fairyGUI.cultivate.UI_CultivatePassCardLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/cultivate/cultivate",
		resName = "CultivatePassCardLayer",
		pkgName = "cultivate",
		isFullScreen = true
	}, ...)
end)

function CultivatePassCardLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._actData = var_0_2:getCultivateData(self._actId)
	self._passCardData = self._actData:getPassCardData()

	self:addBg("bg/cultivate/" .. var_0_2:getResDirId(self._actId) .. "/bg_main.jpg")
	self.m_oneKeyBtn:updateOneKeyBtn(self._actId)

	self._passCardList = {}

	self:initPassCardMainView()
end

function CultivatePassCardLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATEPASSCARD, handler(self, self._onCultivateActivityUpdatePassCard), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_PASSCARDGIFT, handler(self, self._onCultivateActivityGetPassCardReward), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onCulRecharge), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	if not var_0_2:getCultivateData(self._actId):getPassCardData():isPassCardOpen() and var_0_2:getCultivateData(self._actId):getPassCardData():isCanActivePassCard() then
		self._isUnlock = true
	end

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end

	self.m_enterTransition:play(handler(self, self._onEnterFinish))

	if self._isUnlock then
		self._isUnlock = false

		self.m_eff:addEffectSpine({
			isLoop = false,
			remove = true,
			name = g.core.config.cultivate_activity_display_info.get(self._actId).effect
		})
	end
end

function CultivatePassCardLayer:_onEnterFinish()
	if not var_0_2:getCultivateData(self._actId):getPassCardData():isPassCardOpen() and var_0_2:getCultivateData(self._actId):getPassCardData():isCanActivePassCard() then
		local var_4_0 = {
			activity_id = self._actId
		}
		local var_4_1 = {}

		var_4_1[1] = self._actData:getPassCardData():getPassCardIdByLv(1)
		var_4_0.passcard_ids = var_4_1

		g.core.network.GameNetProxy:send_C2S_CultivateActivity_PasscardGift(var_4_0)
	end
end

function CultivatePassCardLayer:_onCrossDayUpdate()
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

function CultivatePassCardLayer:_onCulRecharge(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.cultivate_activity_passcard then
		g.core.module.ModuleManager:awardSummary(arg_6_4.cultivate_activity_passcard.awards or {})
	end

	self:updatePassCardView()
end

function CultivatePassCardLayer:initPassCardMainView()
	local var_7_0 = self._actData:getActivityCfg()
	local var_7_1 = g.core.config.cultivate_activity_display_info.get(var_7_0.id)

	self.m_topBarComp:setResInfoById(var_7_1.interface_passcard)
	self.m_topBarComp:setTitle(var_7_1.module_passcard)
	self.m_passCardList:setVirtual()
	self.m_passCardList:setItemRenderer(handler(self, self._onPassCardRenderer))
	self.m_passCardList:doFairyBatching(false)
	self.m_textLoader:setURL(var_0_4:getCultivateMulLangImage("txt_zl_tishi2", var_0_2:getResDirId(self._actId)))
	self.m_itemLoader:setIcon(var_0_4:getCultivateImage("pic_main", var_0_2:getResDirId(self._actId)))
	self.m_titleLoader:setURL(var_0_4:getCultivateMulLangImage("txt_zl_yxss", var_0_2:getResDirId(self._actId)))
	self.m_passCardBgLoader:setURL(var_0_4:getCultivateImage("pic_bg_zl", var_0_2:getResDirId(self._actId)))
	self.m_iconBgLoader:setURL(var_0_4:getCultivateImage("pic_zl_zs", var_0_2:getResDirId(self._actId)))
	self.m_lineLoader:setIcon(var_0_4:getCultivateImage("pic_mainzs", var_0_2:getResDirId(var_7_0.id)))
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_7_1.color_time)))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self:updatePassCardView()
end

function CultivatePassCardLayer:updatePassCardView()
	self:updateOneKeyState()
	self:updatePassCardTime()

	local var_8_0 = self._actData:getPassCardData()

	self._passCardList = var_8_0:getPassCardList()

	self.m_passCardList:setNumItems(#self._passCardList)
	self.m_passCardList:scrollToView(var_8_0:getLevel() - 1)
end

function CultivatePassCardLayer:updatePassCardTime()
	local var_9_0, var_9_1, var_9_2, var_9_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_9_0,
		hour = var_9_1
	}))
end

function CultivatePassCardLayer:updateOneKeyState()
	self.m_oneKeyBtn:setVisible(#self._actData:getPassCardData():getMulFreeRewards() >= 3)
end

function CultivatePassCardLayer:_onOneKeyClick()
	g.core.network.GameNetProxy:send_C2S_CultivateActivity_PasscardGift({
		activity_id = self._actId,
		passcard_ids = self._actData:getPassCardData():getMulFreeRewards()
	})
end

function CultivatePassCardLayer:_onPassCardRenderer(arg_12_1, arg_12_2)
	arg_12_2:updatePassCardCell(self._passCardData:getLevelRewards(self._passCardList[arg_12_1 + 1].level), arg_12_1 + 1, self._actId)
end

function CultivatePassCardLayer:_onCultivateActivityUpdatePassCard(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self:updatePassCardView()
end

function CultivatePassCardLayer:_onCultivateActivityGetPassCardReward(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	g.core.module.ModuleManager:awardSummary(arg_14_4.awards)
	self:updatePassCardView()
end

return CultivatePassCardLayer
