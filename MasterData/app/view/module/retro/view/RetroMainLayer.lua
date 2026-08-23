local var_0_0 = g.core.model.User.retroData
local var_0_1 = g.core.const.ConstMgr.RetroConst
local RetroMainLayer = class("RetroMainLayer", require("app.fairyGUI.retro.UI_RetroMainLayer"), function()
	return fgui.GComponent:create({
		resName = "RetroMainLayer",
		pkgPath = "ui/retro/retro",
		isFullScreen = true,
		pkgName = "retro"
	}, ...)
end)

function RetroMainLayer:ctor()
	self._actId = var_0_0:getRetroActId()

	self:_initListener()
	self:_initMainView()
end

function RetroMainLayer:_initMainView()
	self.m_topBarComp:setTitle(g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RETRO).name)
	self:addBg("bg/retro/bg_chenfengyiji.jpg")

	local var_3_0 = var_0_0:getRetroDisplayInfo()

	self.m_topBarComp:setResInfoById(var_3_0.interface_main)

	for iter_3_0 = 1, 3 do
		self["m_knight" .. iter_3_0]:updateInfo(var_3_0, iter_3_0)
	end

	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RETRO)
end

function RetroMainLayer:_initListener()
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))
end

function RetroMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRO_GETINFO, self._updateMainView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRO_BOXAWARD, self._onS2CRetroBoxAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRO_REFRESHBOX, self._onS2CRetroRefreshBox, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRO_TASKAWARD, self._onS2CRetroTaskAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._updateMainView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._onExchangeSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onBuyItemSuc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._updateMainView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._updateMainView), self)
	g.core.network.GameNetProxy:send_C2S_Retro_GetInfo({})
end

function RetroMainLayer:_onS2CRetroBoxAward(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.tp == 1 then
		self.m_poolComp:openBoxAwardEffect(arg_6_3.index)
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(arg_6_3.awards)

			if arg_6_3.guarantee_awards then
				g.core.module.ModuleManager:awardSummary(arg_6_3.guarantee_awards)
			end

			self:_updateMainView()
		end, 0.5)
	elseif arg_6_3.tp == 2 then
		g.core.module.ModuleManager:awardSummary(arg_6_3.awards)

		if arg_6_3.guarantee_awards then
			g.core.module.ModuleManager:awardSummary(arg_6_3.guarantee_awards)
		end

		self:playPoolCompRefresh()
	end
end

function RetroMainLayer:_onS2CRetroRefreshBox()
	self:playPoolCompRefresh()
end

function RetroMainLayer:playPoolCompRefresh()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.SEVEN_DAYS_ACTIVITY_OPEN)
	self.m_poolComp:playRefreshEffect()
	self:_updateMainView()
end

function RetroMainLayer:_onS2CRetroTaskAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
	self:_updateMainView()
end

function RetroMainLayer:_onExchangeSuc(arg_11_1, arg_11_2, arg_11_3)
	g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
		cost_idx = 0,
		shop_id = 1,
		info = {
			num = 1,
			id = var_0_1.REFRESH_COST_SHOP_ID
		}
	})
end

function RetroMainLayer:_onBuyItemSuc()
	self:_updateMainView()
end

function RetroMainLayer:_updateMainView()
	self.m_timeComp:updateTime()
	self.m_poolComp:updatePoolComp()
	self.m_stageComp:updateStageComp()
	self:_updateRefreshBtn()
	self:_updateGuaranteeInfo()
	self:_updateRedPoint()
end

function RetroMainLayer:_updateGuaranteeInfo()
	self.m_guaranteeNumTxt1:setText(g.core.lang:get(430305, {
		num = var_0_0:getBoxGuaranteeTimeByQuality(var_0_1.BOX_QUALITY.HIGHER),
		awardNum = var_0_0:getBoxCfgByQuality(var_0_1.BOX_QUALITY.HIGHER).guarantee_size
	}))
	self.m_guaranteeNumTxt:setText(g.core.lang:get(430306, {
		num = var_0_0:getBoxGuaranteeTimeByQuality(var_0_1.BOX_QUALITY.SUPER),
		awardNum = var_0_0:getBoxCfgByQuality(var_0_1.BOX_QUALITY.SUPER).guarantee_size
	}))
end

function RetroMainLayer:_updateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn,
		customData = {}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn,
		customData = {}
	})
end

function RetroMainLayer:_updateRefreshBtn()
	self.m_refreshBtn:updateBtn(false)
	self.m_refreshAllBtn:updateBtn(true)
end

function RetroMainLayer:_onClickShopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.RETRO_SHOP, self._actId)
end

function RetroMainLayer:_onClickTaskBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.retro.view.RetroActivityTaskPop").new(self._actId)))
end

function RetroMainLayer:_onClickGiftBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.recharge.view.RechargeRetroGiftPop").new(self._actId)))
end

function RetroMainLayer:_onCrossDay(arg_20_1, arg_20_2, arg_20_3)
	if not var_0_0:isActOpen() then
		self:replaceToHomeLayer()
	end
end

function RetroMainLayer:replaceToHomeLayer()
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.HOME)
end

return RetroMainLayer
