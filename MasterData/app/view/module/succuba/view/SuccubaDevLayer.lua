local var_0_0 = g.core.const.ConstMgr.SuccubaConst
local var_0_1 = g.core.model.User.succubaData
local SuccubaDevLayer = class("SuccubaDevLayer", require("app.fairyGUI.succuba.UI_SuccubaDevLayer"), function()
	return fgui.GComponent:create({
		resName = "SuccubaDevLayer",
		pkgPath = "ui/succuba/succuba",
		isFullScreen = true,
		pkgName = "succuba"
	}, ...)
end)

function SuccubaDevLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._devType = arg_2_1.devType or var_0_0.DEV_TYPE.INFO
	self._showIndex = 1
	self._advId = 0

	if arg_2_1.showIndex then
		self._showIndex = arg_2_1.showIndex
	elseif arg_2_1.advId then
		self._showAdvId = arg_2_1.advId
	end

	self._isShowSpine = false

	self:_initView()
	self:_initBtn()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA)
end

function SuccubaDevLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO, handler(self, self._onRecvGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_LEVELUP, handler(self, self._onRecvLevelUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_STARUP, handler(self, self._onRecvStarUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_STAGEUP, handler(self, self._onRecvStageUp), self)
	self.m_enterTransition:play()
	g.core.network.GameNetProxy:send_C2S_Succuba_GetInfo({})
end

function SuccubaDevLayer:_initView(arg_4_1)
	self:addBg("bg/common/pic_yht_beijing.jpg")
	self.m_topBarComp:setResInfoById(357)
end

function SuccubaDevLayer:_initBtn()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
end

function SuccubaDevLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "BaseDevelopPanelComp_tab" then
		self._devType = arg_6_2.tabType

		self.m_topBarComp:setResInfoById(arg_6_2.tabData.resInfoId)
	elseif arg_6_1 == "SUCCUBA_DEV_LEFT_BTN_CLICK" then
		self:_updateShowIndex(-1)
	elseif arg_6_1 == "SUCCUBA_DEV_RIGHT_BTN_CLICK" then
		self:_updateShowIndex(1)
	elseif arg_6_1 == "SUCCUBA_DEV_SHOW_BTN_CLICK" then
		self._isShowSpine = true

		self.m_showSpineController:setSelectedIndex(1)
	end
end

function SuccubaDevLayer:_updateShowIndex(arg_7_1)
	self._showIndex = self._showIndex + arg_7_1

	local var_7_0 = var_0_1:getSuccubaList()

	if self._showIndex > #var_7_0 then
		self._showIndex = 1
	elseif self._showIndex < 1 then
		self._showIndex = #var_7_0
	end

	self:_updateSpineComp()
	self:_updateDevComp()
end

function SuccubaDevLayer:_updateSpineComp()
	local var_8_0 = var_0_1:getSuccubaList()

	if self._showAdvId then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if iter_8_1:getAdvanceId() == self._showAdvId then
				self._showIndex = iter_8_0

				break
			end
		end

		self._showAdvId = nil
	end

	local var_8_1 = var_8_0[self._showIndex]

	self._advId = var_8_0[self._showIndex]:getAdvanceId()
	self._sid = var_8_1:getSid()

	self.m_spineComp:updateComp({
		advId = self._advId
	})
end

function SuccubaDevLayer:_updateDevComp()
	self.m_devComp:updateDevPanel({
		tabData = var_0_0.DEV_ARR,
		initTabType = self._devType,
		data = {
			advId = self._advId
		},
		customData = {
			advId = self._advId,
			sid = self._sid
		}
	})
end

function SuccubaDevLayer:_onClick(arg_10_1)
	if self._isShowSpine then
		self._isShowSpine = false

		self.m_showSpineController:setSelectedIndex(0)
	end
end

function SuccubaDevLayer:_onRecvGetInfo(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:_updateSpineComp()
	self:_updateDevComp()
end

function SuccubaDevLayer:_onRecvStageUp(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:_updateSpineComp()
end

function SuccubaDevLayer:_onRecvLevelUp(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.SUCCUBA_LV_UP
		}
	})
	self:_updateSpineComp()
	self:_updateDevComp()
end

function SuccubaDevLayer:_onRecvStarUp(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "succubaStarUp",
				func = function()
					return g.core.module.ModuleManager:pushPopup(require("app.view.module.succuba.view.SuccubaStarUpSuccessPop").new({
						advId = self._advId
					}), {
						withoutAni = true,
						touchDisappear = true
					})
				end
			}
		}
	})
	self:_updateSpineComp()
	self:_updateDevComp()
end

return SuccubaDevLayer
