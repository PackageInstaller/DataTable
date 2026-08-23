local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.const.ConstMgr.PreciousConst
local PreciousDevCfg = require("app.view.module.precious.const.PreciousDevCfg")
local var_0_5 = 400
local PreciousDevelopLayer = class("PreciousDevelopLayer", require("app.fairyGUI.precious.UI_PreciousDevelopLayer"), function()
	return fgui.GComponent:create({
		resName = "PreciousDevelopLayer",
		pkgPath = "ui/precious/precious",
		isFullScreen = true,
		pkgName = "precious"
	}, ...)
end)

function PreciousDevelopLayer:ctor(arg_2_1)
	self:addBg("bg/precious/bg_gzp_guizhongpinbg.jpg", nil, nil, 1)

	self._suitPrecious = arg_2_1.suit
	self._advId = arg_2_1.advanceId
	self._devType = arg_2_1.devType or var_0_3.DevType.ADVANCE
	self._oldstage = 0
	self._canTouch = true
	self._suitCompX = self.m_suitComp:getX()

	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
	self.m_topBar:setResInfoById(var_0_3.PRECIOUS_HELP_ID)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_enterTransition:play()
end

function PreciousDevelopLayer:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_PRECIOUS_UPGRADE, handler(self, self._onS2CPreciousUpgrade), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_PRECIOUS_STARUP, handler(self, self._onS2CPreciousStarUp), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onS2CPreciousFragmentCompose), self)
	self:_updateMainView()
end

function PreciousDevelopLayer:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function PreciousDevelopLayer:_updateMainView()
	self._curPrecious = var_0_0:getPreciousByAdvId(self._advId)
	self._oldstage = self._curPrecious:getUpgradeInfo().stage

	self.m_suitComp:updateSuitComp({
		suit = self._suitPrecious,
		advanceId = self._advId
	})
	self:_updateDevPanel()

	self._suitList = var_0_0:getActivateSuitList()
	self._maxIdx = #self._suitList

	self.m_rightBtn:setVisible(#self._suitList > 1)
	self.m_leftBtn:setVisible(#self._suitList > 1)
end

function PreciousDevelopLayer:receiveCompEvent(arg_6_1)
	local var_6_0 = {
		...
	}

	if arg_6_1 == "BaseDevelopPanelComp_tab" then
		self._devType = var_6_0[1].tabType

		self.m_topBar:setResInfoById(var_6_0[1].tabData.resInfoId)
	elseif arg_6_1 == "PRECIOUS_UPDATE_RIGHTCOMP" then
		self._advId = var_6_0[1]:getAdvId()

		self:_updateDevPanel()
		self.m_suitComp:playRotateEff()
	end
end

function PreciousDevelopLayer:_updateDevPanel()
	self.m_devComp:updateDevPanel({
		tabData = PreciousDevCfg.DEV_ARR,
		initTabType = self._devType,
		data = {
			advId = self._advId
		},
		customData = {
			advId = self._advId
		}
	})
end

function PreciousDevelopLayer:_onS2CPreciousUpgrade(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.advance_id then
		if self._curPrecious:getUpgradeInfo().stage > self._oldstage then
			require("app.view.module.show.ShowFactory"):showPreciousNewStage(arg_8_4.advance_id)
		else
			local var_8_0 = {}
			local var_8_1 = {}

			var_8_1.type = g.core.const.ConstMgr.BaseShowTypeConst.PRECIOUS_ADVANCE
			var_8_0.baseShowPop = var_8_1

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, var_8_0)
		end

		self:_updateMainView()
	end
end

function PreciousDevelopLayer:_onS2CPreciousStarUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4.advance_id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PRECIOUS_STARUP_SUCCESS, {
			advance_id = arg_9_4.advance_id
		})
	end

	self:_updateMainView()
end

function PreciousDevelopLayer:_onS2CPreciousFragmentCompose(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = g.core.config.fragment_info.get(arg_10_4.id)

	if var_10_0 then
		local var_10_1 = {
			callBack = handler(self, self._updateMainView),
			awards = {
				{
					type = var_10_0.fragment_type,
					value = var_10_0.fragment_value,
					size = arg_10_4.num
				}
			}
		}

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.PreciousShowPop").new(var_10_1), var_10_1)
	end
end

function PreciousDevelopLayer:getOwnPreciousAdvId()
	for iter_11_0 = 1, var_0_3.PRECIOUS_INSUIT_MAXNUM do
		if self._suitPrecious:isPreciousOwnByIndex(iter_11_0) then
			return self._suitPrecious:getPreciousCfgByIndex(iter_11_0).advance_id
		end
	end

	return 0
end

function PreciousDevelopLayer:_onClickLeftBtn()
	local var_12_0 = var_0_0:getPreciousSuitIndex(self._suitPrecious)

	if not var_12_0 then
		return
	end

	self._suitPrecious = self._suitList[(var_12_0 - 1 < 1 or nil) and self._maxIdx]
	self._advId = self:getOwnPreciousAdvId()
	self._canTouch = true

	self:_updateMainView()
end

function PreciousDevelopLayer:_onClickRightBtn()
	local var_13_0 = var_0_0:getPreciousSuitIndex(self._suitPrecious)

	if not var_13_0 then
		return
	end

	self._suitPrecious = self._suitList[(var_13_0 + 1 > self._maxIdx or nil) and 1]
	self._advId = self:getOwnPreciousAdvId()
	self._canTouch = true

	self:_updateMainView()
end

function PreciousDevelopLayer:_onTouchBegin(arg_14_1)
	local var_14_0 = arg_14_1:getInput():getTouch():getLocation()

	if self._canTouch and self.m_suitComp:containPoint(var_14_0) then
		self._touchOffsetX = self._suitCompX - var_14_0.x

		arg_14_1:captureTouch()
	end
end

function PreciousDevelopLayer:_onTouchMove(arg_15_1)
	if not self._canTouch or not self._touchOffsetX then
		return
	end

	local var_15_0 = arg_15_1:getInput()

	self.m_suitComp:setX(var_15_0:getTouch():getLocation().x + self._touchOffsetX)
	self.m_suitComp:setAlpha(1 - math.min(math.abs(var_15_0.x + self._touchOffsetX - self._suitCompX), var_0_5) / var_0_5)
end

function PreciousDevelopLayer:_onTouchEnd(arg_16_1)
	if not self._canTouch or not self._touchOffsetX then
		return
	end

	self._canTouch = false

	local var_16_0 = arg_16_1:getInput():getTouch():getLocation().x + self._touchOffsetX - self._suitCompX

	if math.abs(var_16_0) >= var_0_5 and self._maxIdx > 1 then
		if var_16_0 > 0 then
			self:_onClickLeftBtn()
		else
			self:_onClickRightBtn()
		end

		self.m_suitComp:setX(self._suitCompX)
		self.m_suitComp:setAlpha(1)
	else
		self.m_suitComp:runAction((cc.Sequence:create(cc.Spawn:create(cc.EaseSineOut:create((cc.MoveBy:create(0.5, cc.p(-var_16_0, 0)))), (cc.FadeIn:create(0.3))), (cc.CallFunc:create(handler(self, function()
			self._canTouch = true
		end))))))
	end

	self._touchOffsetX = nil
end

return PreciousDevelopLayer
