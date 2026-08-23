local RecycleCultivateConst = require("app.view.module.recycleCultivate.const.RecycleCultivateConst")
local RecycleCultivateLayer = class("RecycleCultivateLayer", require("app.fairyGUI.recycleCultivate.UI_RecycleCultivateLayer"), function()
	return fgui.GComponent:create({
		resName = "RecycleCultivateLayer",
		pkgPath = "ui/recycleCultivate/recycleCultivate",
		isFullScreen = true,
		pkgName = "recycleCultivate"
	}, ...)
end)

function RecycleCultivateLayer:ctor(arg_2_1)
	self:_initView()

	self._comps = {
		self.m_exchangeComp,
		self.m_increaseComp
	}
	self._devShowFunc = {}
	self._tabType = 1

	if arg_2_1 and arg_2_1.route1 then
		if arg_2_1.route1 == 1 then
			self._tabType = 1
		elseif arg_2_1.route1 == 2 then
			self._tabType = 2
		end
	end

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RECYCLE_CULTIVATE)
end

function RecycleCultivateLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_GETINFO, self._onRecvGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self.reqCrossDay, self)
	self.m_enterTransition:play()
	self.m_effBg:addEffectSpine({
		anim = "play",
		name = "eff_ui_recycleCultivate_bg",
		isLoop = true
	})
	g.core.network.GameNetProxy:send_C2S_RecycleCultivate_GetInfo({})
end

function RecycleCultivateLayer:reqCrossDay()
	g.core.network.GameNetProxy:send_C2S_RecycleCultivate_GetInfo({})
end

function RecycleCultivateLayer:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "BaseDevelopPanelComp_tab" then
		self._tabType = arg_5_2.tabType

		if self._devShowFunc[arg_5_2.tabType] then
			self.m_pageController:setSelectedIndex(self._devShowFunc[arg_5_2.tabType].selIndex)

			if self._comps[self._devShowFunc[arg_5_2.tabType].selIndex + 1] and self._comps[self._devShowFunc[arg_5_2.tabType].selIndex + 1].updateComp then
				self._comps[self._devShowFunc[arg_5_2.tabType].selIndex + 1]:updateComp()
			end

			self.m_topBarComp:setResInfoById(self._devShowFunc[arg_5_2.tabType].topBar)
		end
	end
end

function RecycleCultivateLayer:_initView(arg_6_1)
	self.m_bg:setURL("bg/recycleCultivate/bg_shuijingjiexi.jpg")
	self.m_rightPanel:updateDevPanel({
		initTabType = 1,
		tabData = RecycleCultivateConst.DEV_LIST
	})
	self.m_increaseComp:updateComp()
	self.m_exchangeComp:updateComp()
end

function RecycleCultivateLayer:_onRecvGetInfo(arg_7_1, arg_7_2)
	self.m_increaseComp:updateComp()
	self.m_exchangeComp:updateComp()
	self.m_rightPanel:updateDevPanel({
		tabData = RecycleCultivateConst.DEV_LIST,
		initTabType = self._tabType
	})

	self._devShowFunc = {}

	for iter_7_0, iter_7_1 in ipairs(RecycleCultivateConst.DEV_LIST) do
		if iter_7_1.show() then
			table.insert(self._devShowFunc, iter_7_1)
		end
	end

	self.m_topBarComp:setResInfoById(self._devShowFunc[self._tabType].topBar)
	self.m_pageController:setSelectedIndex(self._devShowFunc[self._tabType].selIndex)
end

return RecycleCultivateLayer
