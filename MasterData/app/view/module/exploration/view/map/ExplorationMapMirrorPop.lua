local var_0_0 = g.core.model.User.explorationData
local ExplorationMapMirrorPop = class("ExplorationMapMirrorPop", require("app.fairyGUI.exploration.UI_ExplorationMapMirrorPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationMapMirrorPop",
		pkgPath = "ui/commanderWorld/exploration",
		pkgName = "exploration"
	}, ...)
end)

function ExplorationMapMirrorPop:ctor(arg_2_1)
	self:showAtCenter()

	self._rewardList = g.core.common.Drops:getGoodsArray(arg_2_1:getEventCfg().event_value)
	self._eventData = arg_2_1:getEventInfo()

	self:_initView()
	self.m_enterEffect:addEffectSpine({
		anim = "play",
		name = "eff_ui_explorationMirror_enter",
		remove = true,
		isLoop = false
	})
	self.m_enterTransition:play()
end

function ExplorationMapMirrorPop:_initView()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardBtnClicked))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseBtnClicked))
	self.m_mirrorIcon:setURL("icon/exploration/icon_slmj_jingzi_512.png")
end

function ExplorationMapMirrorPop:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, handler(self, self._onS2CExplorationEventProcess), self)
	self.m_awardList:setNumItems(#self._rewardList)

	if var_0_0:getMapData():canGetMirror() then
		self.m_canGetController:setSelectedIndex(1)
	else
		self.m_canGetController:setSelectedIndex(0)
	end
end

function ExplorationMapMirrorPop:_onAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._rewardList[arg_5_1 + 1])
end

function ExplorationMapMirrorPop:_onRewardBtnClicked()
	if var_0_0:getMapData():canGetMirror() then
		g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
			unique_id = self._eventData.unique_id
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420690))
	end
end

function ExplorationMapMirrorPop:_onCloseBtnClicked()
	self.m_backTransition:play(handler(self, self._closeComp))
end

function ExplorationMapMirrorPop:_closeComp()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationMapMirrorPop:_onS2CExplorationEventProcess(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.network.GameNetProxy:send_C2S_Exploration_GetBossBattleTeam({})
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards, nil, nil, nil, function()
		g.core.common.Scheduler:newScheduleOnce(function(arg_11_0)
			g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.map.ExplorationMapTipPop").new(g.core.lang:get(420695))))
		end, 0.5)
	end)
	self:_onCloseBtnClicked()
end

function ExplorationMapMirrorPop:onCancelCallback()
	self:_onCloseBtnClicked()
end

function ExplorationMapMirrorPop:onUnload()
	if g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE1) and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_GUIDE_CONTINUE)
	end
end

return ExplorationMapMirrorPop
