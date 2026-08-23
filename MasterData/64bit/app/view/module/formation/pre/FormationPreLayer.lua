local var_0_0 = g.core.const.ConstMgr.FormationConst
local var_0_1 = g.core.const.ConstMgr.ShareConst
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.model.User.formationData
local FormationPreLayer = class("FormationPreLayer", require("app.fairyGUI.formation.UI_FormationPreLayer"), function()
	return fgui.GComponent:create({
		resName = "FormationPreLayer",
		pkgName = "formation",
		isFullScreen = true,
		pkgPath = "ui/formation/formation"
	})
end)

function FormationPreLayer:ctor(arg_2_1)
	self._curFormationIndex = var_0_0.MAIN_FORMATION_INDEX
	self._maxFormationCount = var_0_4:getMaxFormationCount()
	self._isPlaying = false

	if arg_2_1 and arg_2_1.posHpList then
		self._posHpList = arg_2_1.posHpList
	end

	self:_initView(arg_2_1)
end

function FormationPreLayer:_initView(arg_3_1)
	self:addBg("bg/formation/pic_bz_beijing.jpg")
	self.m_topBar:setResInfoById(75)

	if arg_3_1 and arg_3_1.title then
		self.m_topBar:setTitle(arg_3_1.title)
	end

	if arg_3_1 then
		self.m_preComp:setBottomHideSuccuba(arg_3_1.hideSuccuba)
		self.m_mainComp:setBottomHideSuccuba(arg_3_1.hideSuccuba)
	end

	self.m_preComp:setSize(display.width, display.height)
	self.m_mainComp:setSize(display.width, display.height)
	self.m_leftBtn:addClickListener(handler(self, self._onLeftBtnClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightBtnClick))
	self.m_recommendBtn:addClickListener(handler(self, self._onRecommendBtnClick))
	self.m_shareComp:setVisibleEx(true)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
end

function FormationPreLayer:openUsageFormationPop()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.formation.pre.FormationPreUsagePop").new({
		type = var_0_0.POP_TYPE.PRESET,
		index = self._curFormationIndex
	})))
end

function FormationPreLayer:_onLeftBtnClick()
	if self._isPlaying then
		return
	end

	self._isPlaying = true

	self:checkFormationChange()
	self:playBack()

	self._curFormationIndex = self._curFormationIndex - 1

	if self._curFormationIndex < 0 then
		self._curFormationIndex = self._maxFormationCount
	end

	self:updateComp()
end

function FormationPreLayer:_onRightBtnClick()
	if self._isPlaying then
		return
	end

	self._isPlaying = true

	self:checkFormationChange()
	self:playBack()

	self._curFormationIndex = self._curFormationIndex + 1

	if self._curFormationIndex > self._maxFormationCount then
		self._curFormationIndex = 0
	end

	self:updateComp()
end

function FormationPreLayer:_onRecommendBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RECOMMEND_KNIGHT) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_RECOMMEND)
	end
end

function FormationPreLayer:playBack()
	if self:_isMainF() then
		self.m_mainComp.m_backTransition:play(handler(self, self.compBackAnimEnd))
	else
		self.m_preComp.m_backTransition:play(handler(self, self.compBackAnimEnd))
	end
end

function FormationPreLayer:compBackAnimEnd()
	if self:_isMainF() then
		self.m_mainComp.m_enterTransition:play(handler(self, self.compEnterAnimEnd))
	else
		self.m_preComp.m_enterTransition:play(handler(self, self.compEnterAnimEnd))
	end

	self:updateView(true)
end

function FormationPreLayer:updateComp()
	if self:_isMainF() then
		self.m_mainComp:updateView()

		if self._posHpList then
			self.m_mainComp:updateKnightHp(self._posHpList)
		end
	else
		self.m_preComp:updateView(self._curFormationIndex)
	end

	self:updatePreciousSuitBtn()
	self:updateSuccubaBtn()
end

function FormationPreLayer:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(70 + cc.Director:getInstance():getSafeAreaRect().x, 430)
		end

		self._preciousSuitBtn:setBtnFormationData((self:_isMainF() or nil) and (g.core.const.ConstMgr.LineUpConst.MulTeamType.MAIN or g.core.const.ConstMgr.LineUpConst.MulTeamType.PRE_FORMATION), self._curFormationIndex, var_0_0.PRESET_FORMATION_TYPE.MAIN)
	end
end

function FormationPreLayer:updateSuccubaBtn()
	return
end

function FormationPreLayer:_onS2CPreFormationFlush()
	if self:_isMainF() then
		self.m_mainComp:updateNameComp()
	else
		self.m_preComp:updateView(self._curFormationIndex)
	end
end

function FormationPreLayer:compEnterAnimEnd()
	self._isPlaying = false
end

function FormationPreLayer:checkFormationChange()
	if not self:_isMainF() then
		self.m_preComp:checkFormationChange()
	end
end

function FormationPreLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_INHERIT, handler(self, self._onPreFormationInherit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_FLUSH, handler(self, self._onS2CPreFormationFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self._onFormationChange), self)
	self:updateView()

	self._waitEvent = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(handler(self, self.onAnimEnd))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function FormationPreLayer:onAnimEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function FormationPreLayer:_onPreFormationInherit(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self._curFormationIndex = var_0_0.MAIN_FORMATION_INDEX

	if arg_18_4.award then
		g.core.module.ModuleManager:awardSummary(arg_18_4.award, false, nil, g.core.lang:get(200014))
	end

	g.core.module.ModuleManager:tip(g.core.lang:get(200036))
	self:compBackAnimEnd()
	self:updateComp()
end

function FormationPreLayer:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "FormationKnightComp_GuildDropEnd" then
		self.m_mainComp:onGuildDropEnd(arg_19_2.index)

		return true
	elseif arg_19_1 == "FormationKnightComp_GuildDropCancel" then
		self.m_mainComp:onGuildDropCancel()

		return true
	elseif arg_19_1 == "FormationPreUsagePop_cell_editBtn_Select" then
		self._curFormationIndex = arg_19_2.index

		self:compBackAnimEnd()
		self:updateComp()

		return true
	elseif arg_19_1 == "Open_Formation_Usage_Pop" then
		self:checkFormationChange()
		self:openUsageFormationPop()

		return true
	elseif arg_19_1 == "Select_Interchange_Btn" then
		self.m_preComp:updateInterChangeBtn()

		return true
	end
end

function FormationPreLayer:updateView(arg_20_1)
	self.m_mainStateController:setSelectedIndex(self:_isMainF() and 0 or 1)

	if not arg_20_1 then
		self:updateComp()
	end

	self:updateIsUnlockPre()
end

function FormationPreLayer:_onFormationChange()
	if self.m_showPreStateController:getSelectedIndex() ~= 2 and var_0_3:isModuleUnlock(var_0_2.FORMATION_PRE) then
		self:updateIsUnlockPre()
		self.m_mainComp:updateNameComp()
	end
end

function FormationPreLayer:updateIsUnlockPre()
	if var_0_3:isModuleUnlock(var_0_2.FORMATION_PRE) then
		self.m_showPreStateController:setSelectedIndex(2)

		if not var_0_4:isGetPreFormationData() then
			g.core.network.GameNetProxy:send_C2S_PresetFormation_Flush({
				tp = var_0_0.PRESET_FORMATION_TYPE.MAIN
			})
		end
	elseif var_0_3:isModuleShow(var_0_2.FORMATION_PRE) then
		self.m_showPreStateController:setSelectedIndex(1)
	else
		self.m_showPreStateController:setSelectedIndex(0)
	end
end

function FormationPreLayer:_isMainF()
	return self._curFormationIndex == var_0_0.MAIN_FORMATION_INDEX
end

function FormationPreLayer:onUnload()
	if not self:_isMainF() then
		self:checkFormationChange()
	end

	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FormationPreLayer:_onShareClick()
	self.m_shareComp:setVisible(false)
	self.m_topBar:setVisible(false)
	self.m_leftBtn:setVisible(false)
	self.m_rightBtn:setVisible(false)

	if self:_isMainF() then
		self.m_mainComp.m_nameComp:setVisible(false)
		self.m_mainComp.m_bottomComp:setIsShare(true)
	else
		self.m_preComp.m_nameComp:setVisible(false)
		self.m_preComp.m_bottomComp:setIsShare(true)
	end

	local var_25_0 = cc.utils:captureNode(self)

	var_25_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_25_0:release()
	self.m_leftBtn:setVisible(true)
	self.m_rightBtn:setVisible(true)

	local var_25_1 = ""

	if self:_isMainF() then
		self.m_mainComp.m_nameComp:setVisible(true)
		self.m_mainComp.m_bottomComp:setIsShare(false)
	else
		self.m_preComp.m_nameComp:setVisible(true)
		self.m_preComp.m_bottomComp:setIsShare(false)

		var_25_1 = self.m_preComp:getFormationString()

		self.m_preComp:checkFormationChange()
	end

	self.m_shareComp:setVisible(true)
	self.m_topBar:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = var_0_1.SHARE_TYPE.TYPE_ID_8,
		preset_formation_info = var_25_1
	})
end

return FormationPreLayer
