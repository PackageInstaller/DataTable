local var_0_0 = g.core.model.User.echoLabData
local EchoLabTreeMainLayer = class("EchoLabTreeMainLayer", require("app.fairyGUI.echoLab.UI_EchoLabTreeMainLayer"), function()
	return fgui.GComponent:create({
		resName = "EchoLabTreeMainLayer",
		pkgPath = "ui/echoLab/echoLab",
		isFullScreen = true,
		pkgName = "echoLab"
	}, ...)
end)
local var_0_2 = 30

function EchoLabTreeMainLayer:ctor()
	self._clickId = 0

	self:initView()
	self.m_enterTransition:play()
end

function EchoLabTreeMainLayer:initView()
	self:addBg("bg/echoLab/bg_echo_shujishu.jpg")
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_attrBtn:addClickListener(handler(self, self._openAttrPop))
	self.m_topBar:setResInfoById(249)
end

function EchoLabTreeMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVEALTARNODE, handler(self, self._onS2CTalentActive), self)
	self:updateView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TREEENTER)
end

function EchoLabTreeMainLayer:_onTouchBegin(arg_5_1)
	local var_5_0 = arg_5_1:getInput():getTouch():getLocation()

	if self.m_infoComp:containPoint(var_5_0) then
		return
	end

	self._prevTouchPos = var_5_0
	self._isTouched = true
	self._clickId = self.m_scrollComp:checkCompIsClick(var_5_0, self.m_infoComp:getX())

	arg_5_1:captureTouch()
end

function EchoLabTreeMainLayer:_onTouchMove(arg_6_1)
	if not self._isTouched then
		return
	end

	if not self._isScroll then
		if math.abs(self._prevTouchPos.x - arg_6_1:getInput():getTouch():getLocation().x) >= var_0_2 then
			self._isScroll = true
		else
			return
		end
	end

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_isShowInfoController:setSelectedIndex(0)
	end
end

function EchoLabTreeMainLayer:_onTouchEnd(arg_7_1)
	if self._isScroll then
		self.m_scrollComp:resetScrollPane()
	elseif self._clickId > 0 then
		self.m_scrollComp:onClickIcon({
			id = self._clickId
		}, self.m_isShowInfoController:getSelectedIndex() == 1)
	else
		self.m_isShowInfoController:setSelectedIndex(0)
		self.m_scrollComp:resetScrollPane()
	end

	self._clickId = 0
	self._isScroll = false
end

function EchoLabTreeMainLayer:updateView()
	self.m_scrollComp:updateScrollView()
end

function EchoLabTreeMainLayer:_openAttrPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.dataTree.EchoLabTreeAttrPop").new())
end

function EchoLabTreeMainLayer:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "scrollComp_show_info" then
		self:_showInfoComp(arg_10_2)

		return true
	elseif arg_10_1 == "active_effect_end" then
		self:activeEffectEndPop(arg_10_2)

		return true
	elseif arg_10_1 == "active_comp_end" then
		self:autoMoveNext(arg_10_2)

		return true
	end
end

function EchoLabTreeMainLayer:_showInfoComp(arg_11_1)
	self.m_infoComp:updateCompByStruct(var_0_0:getTreeData():getTalentById(arg_11_1.id))

	if not arg_11_1.compWorldPosX then
		return
	end

	self.m_isShowInfoController:setSelectedIndex(1)
end

function EchoLabTreeMainLayer:_onS2CTalentActive(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_1 = var_0_0:getTreeData():getTalentById(arg_12_4.id or 0)

	if not var_12_1 then
		return
	end

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_infoComp:updateCompByStruct(var_12_1)
	end

	self.m_scrollComp:onS2CTalentActive(var_12_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TALENTUPGRADE)
end

function EchoLabTreeMainLayer:activeEffectEndPop(arg_13_1)
	local var_13_0 = {}

	var_13_0.talent = var_0_0:getTreeData():getTalentById(arg_13_1.id)
	var_13_0.title = g.core.lang:get(105026)
	var_13_0.showComp = fgui.UIPackage:createObject("echoLab", "EchoLabTreeActiveComp")

	local var_13_1 = {}

	var_13_1.hideContinue = true
	var_13_1.blackOpacity = 0.7
	var_13_1.withoutAni = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new(var_13_0), var_13_1)
end

function EchoLabTreeMainLayer:autoMoveNext(arg_14_1)
	if arg_14_1 then
		local var_14_0 = arg_14_1.id or 0

		if var_14_0 > 0 then
			local var_14_1 = self.m_isShowInfoController:getSelectedIndex() == 1
			local var_14_2 = var_0_0:getTreeData()
			local var_14_3 = var_14_2:getTalentById(var_14_0):getNextTalentList()

			if var_14_2[1] then
				for iter_14_0, iter_14_1 in ipairs((var_14_3[1]:getPreTalentList())) do
					if not iter_14_1:isActive() then
						self.m_scrollComp:onClickIcon({
							id = iter_14_1:getId()
						}, var_14_1)

						return
					end
				end
			end

			table.sort(var_14_3, function(arg_15_0, arg_15_1)
				return arg_15_0:getGridY() > arg_15_1:getGridY()
			end)

			for iter_14_2, iter_14_3 in ipairs(var_14_3) do
				if not iter_14_3:isActive() then
					self.m_scrollComp:onClickIcon({
						id = iter_14_3:getId()
					}, var_14_1)

					return
				end
			end
		end
	end
end

return EchoLabTreeMainLayer
