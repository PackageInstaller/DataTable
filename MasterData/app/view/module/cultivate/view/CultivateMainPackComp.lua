local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.cultivateDataMgr
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.const.ConstMgr.RecruitConst
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local CultivateMainPackComp = class("CultivateMainPackComp", require("app.fairyGUI.cultivate.UI_CultivateMainPackComp1"))

function CultivateMainPackComp:ctor()
	self:setSize(display.width, display.height)
end

function CultivateMainPackComp:setCurrentActId(arg_2_1)
	self._actId = arg_2_1
	self._giftRedId = 768
	self._actData = var_0_2:getCultivateData(arg_2_1)

	self:initMainView()
	self:initRedPoint()
end

function CultivateMainPackComp:onLoad()
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
	self.m_giftComp:updateRedPoint()
end

function CultivateMainPackComp:_onCultivateActivityInfo()
	self:updateCurrentView()
end

function CultivateMainPackComp:_onCrossDayUpdate()
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

function CultivateMainPackComp:initMainView()
	local var_7_0 = self._actData:getActivityCfg()
	local var_7_1 = g.core.config.cultivate_activity_display_info.get(var_7_0.id)

	if var_7_1.have_gift ~= 1 then
		self.m_giftComp:setVisible(false)
	end

	if var_7_0.type == CultivateConst.ACTIVITY_TYPE.PRECIOUS and g.core.model.User.recruitData:checkPreciousGiftIsOpen() then
		self._giftRedId = 782

		self.m_giftComp:setVisible(true)
	end

	self.m_giftComp:setBtnIcon(var_0_3:getCultivateImage("pic_libao", var_0_2:getResDirId(var_7_0.id)))
	self.m_bigImgLoader:setIcon(var_0_3:getCultivateImage("pic_main", var_0_2:getResDirId(var_7_0.id)))
	self.m_passCardComp:setBtnIcon(var_0_3:getCultivateImage("pic_rk4", var_0_2:getResDirId(var_7_0.id)))
	self.m_recruitComp:setBtnIcon(var_0_3:getCultivateImage("pic_rk1", var_0_2:getResDirId(var_7_0.id)))
	self.m_shopComp:setBtnIcon(var_0_3:getCultivateImage("pic_rk2", var_0_2:getResDirId(var_7_0.id)))
	self.m_taskComp:setBtnIcon(var_0_3:getCultivateImage("pic_rk3", var_0_2:getResDirId(var_7_0.id)))
	self.m_libaozcIcon:setIcon(var_0_3:getCultivateImage("pic_libaozs", var_0_2:getResDirId(var_7_0.id)))
	self.m_lineLoader:setIcon(var_0_3:getCultivateImage("pic_mainzs", var_0_2:getResDirId(var_7_0.id)))
	self.m_giftComp:updateTitleBg(var_0_3:getCultivateImage("pic_libaodi", var_0_2:getResDirId(var_7_0.id)))
	self.m_titleTextIcon:setURL(var_0_3:getCultivateMulLangImage("txt_main_gwcs", var_0_2:getResDirId(var_7_0.id)))
	self.m_taskComp:updateFinishIcon(var_0_3:getCultivateImage("pic_jieshu", var_0_2:getResDirId(var_7_0.id)))
	self.m_giftComp:updateFinishIcon(var_0_3:getCultivateImage("pic_jieshu", var_0_2:getResDirId(var_7_0.id)))
	self.m_passCardComp:updateFinishIcon(var_0_3:getCultivateImage("pic_jieshu", var_0_2:getResDirId(var_7_0.id)))
	self.m_recruitComp:updateFinishIcon(var_0_3:getCultivateImage("pic_jieshu", var_0_2:getResDirId(var_7_0.id)))
	self.m_shopComp:updateFinishIcon(var_0_3:getCultivateImage("pic_jieshu", var_0_2:getResDirId(var_7_0.id)))
	self.m_taskComp:setTitle(var_7_1.module_task)
	self.m_giftComp:setTitle(var_7_1.gift_name)
	self.m_passCardComp:setTitle(var_7_1.module_passcard)
	self.m_recruitComp:setTitle(var_7_1.module_recruit)
	self.m_shopComp:setTitle(var_7_1.module_shop)
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_7_1.color_time)))
	self.m_colorGraph1:setColor(cc.c3b(CultivateConst.hexToRgb(var_7_1.color_line)))
	self.m_colorGraph2:setColor(cc.c3b(CultivateConst.hexToRgb(var_7_1.color_line)))
	self.m_shopComp:addClickListener(handler(self, self.onOpenShopClick))
	self.m_taskComp:addClickListener(handler(self, self.onOpenTaskClick))
	self.m_giftComp:addClickListener(handler(self, self.onOpenGiftClick))
	self.m_passCardComp:addClickListener(handler(self, self.onOpenPassCardClick))
	self.m_recruitComp:addClickListener(handler(self, self.onOpenRecruitClick))
	self:updateBtnState()
end

function CultivateMainPackComp:initRedPoint()
	self.m_taskComp:setSelfRedPointId(769, self._actId)
	self.m_passCardComp:setSelfRedPointId(770, self._actId)
	self.m_giftComp:setSelfRedPointId(self._giftRedId, self._actId)
end

function CultivateMainPackComp:updateBtnState()
	if not self._actData:isInNormalOpenTime() then
		self.m_giftComp:setBtnState(2)
		self.m_passCardComp:setBtnState(2)
		self.m_taskComp:setBtnState(2)
		self.m_recruitComp:setBtnState(2)
	else
		self.m_giftComp:setBtnState(1)
		self.m_passCardComp:setBtnState(1)
		self.m_taskComp:setBtnState(1)
		self.m_recruitComp:setBtnState(1)
	end
end

function CultivateMainPackComp:updateActTime()
	local var_10_0, var_10_1, var_10_2, var_10_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getExpireTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_10_0,
		hour = var_10_1
	}))
end

function CultivateMainPackComp:updateCurrentView()
	self:updateActTime()
	self:updateBtnState()
end

function CultivateMainPackComp:onOpenShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_SHOP, self._actId)
end

function CultivateMainPackComp:onOpenTaskClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_TASK, self._actId)
end

function CultivateMainPackComp:onOpenPassCardClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	if self._actData:isPassCardOpen() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_PASSCARD, self._actId)
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.CULTIVATE_PASSCARD_PREVIEW, self._actId)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JianDing_Selected)
end

function CultivateMainPackComp:onOpenRecruitClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	local var_15_0 = self._actData:getActivityCfg()

	if var_15_0.recruit_route ~= 0 then
		local var_15_1 = g.core.config.cultivate_activity_display_info.get(var_15_0.id)

		g.view.entrance.ModuleGotoProxy:gotoModule(var_15_0.recruit_route)
	else
		local var_15_2 = {
			route1 = var_0_4.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_TYPE
		}

		var_15_2.route2 = g.core.config.cultivate_activity_info.get(self._actId).activity_recruit

		g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT, var_15_2)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JianDing_Selected)
end

function CultivateMainPackComp:onOpenGiftClick()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(421412))

		return
	end

	if g.core.config.cultivate_activity_display_info.get(self._actId).have_gift ~= 1 then
		local var_16_0, var_16_1 = g.core.model.User.recruitData:checkPreciousGiftIsOpen()

		if self._actData:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.PRECIOUS and var_16_0 then
			local var_16_2 = var_16_1:getInfo().sub_activity_id
			local var_16_3 = var_16_2
			local var_16_4

			if not var_16_2 then
				var_16_3 = var_16_1:getActivityValue()
				var_16_4 = {
					title = g.core.lang:get(108476),
					activityValue = var_16_3
				}
			end

			var_16_4.shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT
			var_16_4.openCheckFunc = handler(self, function(arg_17_0)
				return var_16_1:getInfo().finish_time > g.core.common.ServerTime:getTime()
			end)

			g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.recruitPrecious.RecruitPreciousGiftPop").new(var_16_4)))
		end
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopCultivatePop.ShopCultivateGiftPop").new(self._actId)))
	end
end

return CultivateMainPackComp
