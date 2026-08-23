local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.cultivateDataMgr
local var_0_3 = g.core.common.Path
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local CultivateWitchPackComp = class("CultivateWitchPackComp", require("app.fairyGUI.cultivate.UI_CultivateWitchPackComp"))

function CultivateWitchPackComp:ctor()
	self:setSize(display.width, display.height)
end

function CultivateWitchPackComp:setCurrentActId(arg_2_1)
	self._actId = arg_2_1
	self._actData = var_0_2:getCultivateData(self._actId)

	self:initMainView()
	self:initRedPoint()
end

function CultivateWitchPackComp:initMainView()
	local var_3_0 = self._actData:getActivityCfg()
	local var_3_1 = g.core.config.cultivate_activity_display_info.get(var_3_0.id)

	if var_3_1.have_gift ~= 1 then
		self.m_giftComp:setVisible(false)
	end

	self.m_giftComp:setBtnIcon(var_0_3:getCultivateImage("pic_mnzj_libao", var_0_2:getResDirId(var_3_0.id)))
	self.m_bgLoader:setURL(var_0_3:getCultivateImage("bg_mnzj_zjm_kuang", var_0_2:getResDirId(var_3_0.id)))
	self.m_upBgLoader:setURL(var_0_3:getCultivateImage("pic_mnzj_zjm_huawengkuang", var_0_2:getResDirId(var_3_0.id)))
	self.m_downBgLoader:setURL(var_0_3:getCultivateImage("pic_mnzj_zjm_huawengkuang", var_0_2:getResDirId(var_3_0.id)))
	self.m_titleBg:setURL(var_0_3:getCultivateImage("pic_mnzj_zjm_title_di", var_0_2:getResDirId(var_3_0.id)))
	self.m_titleTextIcon:setURL(var_0_3:getCultivateMulLangImage("txt_mnzj_zjm_title", var_0_2:getResDirId(var_3_0.id)))
	self.m_taskComp:setTitle(var_3_1.module_task)
	self.m_giftComp:setTitle(var_3_1.gift_name)
	self.m_passCardComp:setTitle(var_3_1.module_passcard)
	self.m_recruitComp:setTitle(var_3_1.module_recruit)
	self.m_shopComp:setTitle(var_3_1.module_shop)

	if var_3_0.cultivate_activity_passcard == 0 then
		self.m_passCardComp:setTitle(g.core.lang:get(302065))
	end

	self.m_shopComp:addClickListener(handler(self, self.onOpenShopClick))
	self.m_taskComp:addClickListener(handler(self, self.onOpenTaskClick))
	self.m_giftComp:addClickListener(handler(self, self.onOpenGiftClick))
	self.m_passCardComp:addClickListener(handler(self, self.onOpenPassCardClick))
	self.m_recruitComp:addClickListener(handler(self, self.onOpenRecruitClick))
	self:_addAssistant()
	self:_updateBtnState()
end

function CultivateWitchPackComp:_addAssistant()
	self.m_knightComp:removeChildren()

	local var_4_0 = self._actData:getActivityCfg().recruit_route
	local var_4_1 = {
		resId = var_4_0 > 0 and var_4_0 or 20700720,
		dir_res = var_4_0 > 0 and var_4_0 or 20700720
	}

	var_4_1.isShowBg = false
	var_4_1.isAlphaNode = true

	self.m_knightComp:addChild((DrawSuccuba.new(var_4_1)))
end

function CultivateWitchPackComp:initRedPoint()
	self.m_taskComp:setSelfRedPointId(769, self._actId)
	self.m_passCardComp:setSelfRedPointId(770, self._actId)
	self.m_giftComp:setSelfRedPointId(768, self._actId)
	self.m_recruitComp:setSelfRedPointId(890, self._actId)
end

function CultivateWitchPackComp:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO, handler(self, self._onCultivateActivityInfo), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = self._actId
		})
	end

	self:updateCurrentView()

	if not self._actData:isInActivityShowTime() then
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)
	end

	self.m_enterTransition:play()
	self.m_recruitComp:updateRedPoint()
	self.m_giftComp:updateRedPoint()
end

function CultivateWitchPackComp:_onCultivateActivityInfo()
	self:updateCurrentView()
end

function CultivateWitchPackComp:_onCrossDayUpdate()
	if not self._actData:isInActivityShowTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = self._actId
		})
	end
end

function CultivateWitchPackComp:updateCurrentView()
	self:updateActTime()
	self:_updateBtnState()
end

function CultivateWitchPackComp:_updateBtnState()
	if not self._actData:isInNormalOpenTime() then
		self.m_giftComp:setBtnState(2)
		self.m_passCardComp:setBtnState(0)
		self.m_taskComp:setBtnState(2)
		self.m_recruitComp:setBtnState(2)
	else
		self.m_giftComp:setBtnState(1)
		self.m_passCardComp:setBtnState(0)
		self.m_taskComp:setBtnState(1)
		self.m_recruitComp:setBtnState(1)
	end
end

function CultivateWitchPackComp:updateActTime()
	local var_12_0, var_12_1, var_12_2, var_12_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getExpireTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_12_0,
		hour = var_12_1
	}))
end

function CultivateWitchPackComp:onOpenShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_WITCH_SHOP, self._actId)
end

function CultivateWitchPackComp:onOpenTaskClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_WITCH_TASK, self._actId)
end

function CultivateWitchPackComp:onOpenPassCardClick()
	if self._actData:getActivityCfg().cultivate_activity_passcard == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(421416))

		return
	end

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	if self._actData:isPassCardOpen() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_WITCH_PASSCARD, self._actId)
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_WITCH_PASSCARD_PREVIEW, self._actId)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JianDing_Selected)
end

function CultivateWitchPackComp:onOpenRecruitClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	g.core.model.User.monopolyDataMgr:setCurOpenActId(self._actId)
	g.core.module.ModuleManager:pushModule(g.view.entrance.MONOPOLY_STAGE)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JianDing_Selected)
end

function CultivateWitchPackComp:onOpenGiftClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopCultivatePop.ShopCultivateGiftPop").new(self._actId)))
end

return CultivateWitchPackComp
