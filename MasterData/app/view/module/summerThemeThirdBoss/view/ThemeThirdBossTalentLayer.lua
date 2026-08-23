local var_0_0 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_1 = 30
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.model.User.themeData
local var_0_5 = g.core.config.activity_theme_display_info
local ThemeThirdBossTalentLayer = class("ThemeThirdBossTalentLayer", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeThirdBossTalentLayer",
		pkgPath = "ui/summerThemeThirdBoss/summerThemeThirdBoss",
		isFullScreen = true,
		pkgName = "summerThemeThirdBoss"
	}, ...)
end)

function ThemeThirdBossTalentLayer:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1.themeValue
	self._clickId = 0
	self._bossData = var_0_4:getThemeData(self._activeThemeValue):getBossData()

	self:initView()
	self.m_enterTransition:play()
	self._bossData:saveTalentRedTodayRecord()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.THEME_THIRD_BOSS_TALENT)
end

function ThemeThirdBossTalentLayer:initView()
	self:addBg("bg/theme/bg_activity_tianfubg.jpg")
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_attrBtn:addClickListener(handler(self, self._onClickAttrBtn))
	self.m_resetBtn:addClickListener(handler(self, self._onClickResetBtn))

	self._displayInfo = var_0_5.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.talent_top_bar)
	self.m_scrollComp:setThemeBossData(self._bossData)
end

function ThemeThirdBossTalentLayer:_onTouchBegin(arg_4_1)
	local var_4_0 = arg_4_1:getInput():getTouch():getLocation()

	if self.m_infoComp:containPoint(var_4_0) then
		return
	end

	self._prevTouchPos = var_4_0
	self._isTouched = true
	self._clickId = self.m_scrollComp:checkCompIsClick(var_4_0, self.m_infoComp:getX())

	arg_4_1:captureTouch()
end

function ThemeThirdBossTalentLayer:_onTouchMove(arg_5_1)
	if not self._isTouched then
		return
	end

	if not self._isScroll then
		if math.abs(self._prevTouchPos.x - arg_5_1:getInput():getTouch():getLocation().x) >= var_0_1 then
			self._isScroll = true
		else
			return
		end
	end

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_isShowInfoController:setSelectedIndex(0)
	end
end

function ThemeThirdBossTalentLayer:_onTouchEnd(arg_6_1)
	if self._isScroll then
		self.m_scrollComp:resetScrollPane()
	elseif self._clickId > 0 then
		self.m_scrollComp:onClickIcon({
			id = self._clickId
		}, self.m_isShowInfoController:getSelectedIndex() == 1)
	elseif not self.m_infoComp:containPoint((arg_6_1:getInput():getTouch():getLocation())) then
		self.m_isShowInfoController:setSelectedIndex(0)
		self.m_scrollComp:resetScrollPane()
	end

	self._clickId = 0
	self._isScroll = false
end

function ThemeThirdBossTalentLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_NEW_DEMON_BOSS_ACTIVETALENT, handler(self, self._onActiveTalent), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_NEW_DEMON_BOSS_RESETTALENT, handler(self, self._onResetTalent), self)
end

function ThemeThirdBossTalentLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "ThemeThirdBossTalentScrollComp_scrollComp_show_info" then
		self:_showInfoComp(arg_8_2)

		return true
	elseif arg_8_1 == "ThemeThirdBossTalentComp_active_effect_end" then
		self:activeEffectEndPop(arg_8_2)

		return true
	end
end

function ThemeThirdBossTalentLayer:_showInfoComp(arg_9_1)
	self.m_infoComp:updateCompByStruct(self._bossData:getTalentById(arg_9_1.id), self._bossData)

	if not arg_9_1.compWorldPosX then
		return
	end

	self.m_isShowInfoController:setSelectedIndex(1)
end

function ThemeThirdBossTalentLayer:_onClickAttrBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.summerThemeThirdBoss.view.ThemeThirdBossTalentAttrPop").new({
		bossData = self._bossData
	}))
end

function ThemeThirdBossTalentLayer:_onClickResetBtn()
	local var_11_0 = self._bossData:getAllActiveTalent()

	if next(var_11_0) then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.summerThemeThirdBoss.view.ThemeThirdBossTalentResetPop").new({
			isAll = true,
			bossData = self._bossData,
			talentDict = var_11_0
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405954))
	end
end

function ThemeThirdBossTalentLayer:_onActiveTalent(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_4.talent_ids or {}

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_infoComp:refreshComp()
	end

	self.m_scrollComp:updateScrollView()
	self.m_scrollComp:onS2CTalentActive(var_12_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_0.THEME_THIRD_TALENT_ACTIVE
		}
	})
end

function ThemeThirdBossTalentLayer:_onResetTalent(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if not arg_13_4.talent_ids then
		-- block empty
	end

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_infoComp:refreshComp()
	end

	self.m_scrollComp:updateScrollView()
end

function ThemeThirdBossTalentLayer:activeEffectEndPop(arg_14_1)
	local var_14_0 = {}

	var_14_0.hideContinue = true
	var_14_0.blackOpacity = 0.7
	var_14_0.withoutAni = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		talent = self._bossData:getTalentById(arg_14_1.id),
		title = g.core.lang:get(105026),
		showComp = fgui.UIPackage:createObject("echoLab", "EchoLabTreeActiveComp")
	}), var_14_0)
end

return ThemeThirdBossTalentLayer
