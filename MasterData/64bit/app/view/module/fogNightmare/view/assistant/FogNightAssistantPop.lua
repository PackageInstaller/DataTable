local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local var_0_2 = g.core.model.User.fogNightmareData
local FogNightAssistantPop = class("FogNightAssistantPop", require("app.fairyGUI.fogNightmare.UI_FogNightAssistantPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightAssistantPop",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightAssistantPop:ctor()
	self._assistantData = var_0_2:getAssistantData()

	self:_initView()
	self.m_enterTransition:play()
end

function FogNightAssistantPop:_initView()
	self.m_topBarComp:setResInfoById(var_0_0.HelpConst.HELP_TYPE.FOG_NIGHTMARE)
	self.m_knightList:setIniter()
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onRendererKnightList))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickComp))
end

function FogNightAssistantPop:_onRendererKnightList(arg_4_1, arg_4_2)
	arg_4_2:updateComp(self._knightList[arg_4_1 + 1], arg_4_1 + 1)
end

function FogNightAssistantPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_SETKNIGHTS, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_SHOWSETKNIGHTS, self.updateView, self)

	if not self._assistantData:getIsInitProto() then
		g.core.network.GameNetProxy:send_C2S_FriendHelper_ShowSetKnights({
			play_type = 0
		})
	else
		self:updateView()
	end
end

function FogNightAssistantPop:_onClickComp(arg_6_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.assistant.FogNightAssistantLineUpPop").new(arg_6_1:getDataValue() + 1), {
		blackOpacity = 0.7,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function FogNightAssistantPop:updateView()
	self._knightList = self._assistantData:getSelfHelperKnights()

	self.m_knightList:setNumItems(var_0_1.MAX_HELPER_COUNT)
	self.m_knightNumText:setText(self._assistantData:getSelfUseHelperCount() .. "/")
	self.m_maxNumText:setText(var_0_1.MAX_HELPER_COUNT)
end

return FogNightAssistantPop
