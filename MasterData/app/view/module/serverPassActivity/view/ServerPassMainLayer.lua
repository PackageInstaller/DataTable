local var_0_0 = g.core.model.User.serverPassActivityData
local ServerPassMainLayer = class("ServerPassMainLayer", require("app.fairyGUI.serverPassActivity.UI_ServerPassMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ServerPassMainLayer",
		pkgPath = "ui/serverPassActivity/serverPassActivity",
		isFullScreen = true,
		pkgName = "serverPassActivity"
	}, ...)
end)

function ServerPassMainLayer:ctor()
	self._playListAnim = false

	self:_initLayer()
end

function ServerPassMainLayer:_initLayer()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SERVER_PASS_ACTIVITY)
	self.m_bgEffectComp:addEffectSpine({
		name = "eff_ui_serverPass_bgglow",
		scale = 1,
		isLoop = true
	})
	self.m_btnEffectComp:addEffectSpine({
		name = "eff_ui_serverPass_btnpass",
		scale = 1,
		isLoop = true
	})
	self:addBg("bg/serverPass/bg_mkjf_goumai.jpg", false, nil, 1)
	self.m_buyBtn:addClickListener(handler(self, self._onClickBuyBtn))
	self.m_detailBtn:addClickListener(handler(self, self._onClickDetailBtn))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardItemList))
	self.m_awardList:doFairyBatching(false)
	self.m_topBar:setResInfoById(388)
end

function ServerPassMainLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_INFO, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SERVER_PASS_BUY_LAYER_POP, self._onBuyLayerPop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_AWARD, self._onS2CServerPassAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_AWARDALL, self._onS2CServerPassAwardAll, self)
end

function ServerPassMainLayer:onLoad()
	self:_addCustomListener()
	self:updateView()
end

function ServerPassMainLayer:updateView()
	self.m_levelTxt:setText(g.core.model.User:getLevel())

	self._awardList = var_0_0:getAwardList()

	self.m_awardList:setNumItems(#self._awardList)

	if not self._playListAnim then
		self.m_awardList:transitionShowCells("enter_right", 0.03, 1)

		self._playListAnim = true
	end
end

function ServerPassMainLayer:_onRenderAwardItemList(arg_7_1, arg_7_2)
	arg_7_2:updateAwardItemComp(self._awardList[arg_7_1 + 1])
end

function ServerPassMainLayer:_onBuyLayerPop(arg_8_1, arg_8_2)
	if arg_8_2.needRefresh then
		self:newScheduleOnce(handler(self, self._doUnlockRefresh), 0.6)
	end
end

function ServerPassMainLayer:_doUnlockRefresh()
	for iter_9_0, iter_9_1 in ipairs((self.m_awardList:getChildren())) do
		iter_9_1:playUnlockAnim()
	end
end

function ServerPassMainLayer:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "getAward" then
		self:_onGetAllAward()

		return true
	end
end

function ServerPassMainLayer:_onClickBuyBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SERVER_PASS_BUY_LAYER)
end

function ServerPassMainLayer:_onClickDetailBtn()
	local var_12_0 = var_0_0:getTotalPrivilege()

	g.core.module.ModuleManager:pushPopup(require("app.view.module.serverPassActivity.view.ServerPassTipPop").new({
		value = (#var_12_0 > 0 or nil) and var_12_0[1].value
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function ServerPassMainLayer:_onGetAward(arg_13_1, arg_13_2)
	g.core.network.GameNetProxy:send_C2S_ServerPass_Award({
		level = arg_13_1,
		tier = arg_13_2
	})
end

function ServerPassMainLayer:_onGetAllAward()
	g.core.network.GameNetProxy:send_C2S_ServerPass_AwardAll({})
end

function ServerPassMainLayer:_onS2CServerPassAward(arg_15_1, arg_15_2, arg_15_3)
	g.core.module.ModuleManager:awardSummary(arg_15_3.awards, false, nil, g.core.lang:get(300001))
	self:updateView()
end

function ServerPassMainLayer:_onS2CServerPassAwardAll(arg_16_1, arg_16_2, arg_16_3)
	g.core.module.ModuleManager:awardSummary(arg_16_3.mergeAwards, false, nil, g.core.lang:get(300001))
	self:updateView()
end

return ServerPassMainLayer
