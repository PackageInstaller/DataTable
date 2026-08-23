local var_0_0 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_1 = 30
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local ThemeThirdBossTalentLayer = class("ThemeThirdBossTalentLayer", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreeTalentLayer"), function()
	return fgui.GComponent:create({
		resName = "NewSlgSkillTreeTalentLayer",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	}, ...)
end)

function ThemeThirdBossTalentLayer:ctor(arg_2_1)
	self._clickId = 0
	self._skillData = g.core.model.User.newSlgSkillTreeData

	if arg_2_1 then
		self._curSkillType = arg_2_1.skillType or 1
	end

	self.m_topBarComp:setResInfoById(371)
	self:initView()
	self.m_enterTransition:play()
	g.core.model.User.newSlgData:saveMyOldFightValue()
end

function ThemeThirdBossTalentLayer:initView()
	self:addBg("bg/newSlg/bg_hzts_kejishu.jpg")
	self.m_eff:addEffectSpine({
		remove = false,
		name = "eff_ui_newSlgSkillTree_bgglow",
		isLoop = true
	})
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_attrBtn:addClickListener(handler(self, self._onClickAttrBtn))
	self.m_resetBtn:addClickListener(handler(self, self._onClickResetBtn))
	self.m_scrollComp:setNewSlgSkillTreeType(self._curSkillType)
	self.m_scrollComp:setNewSlgSkillTreeData(self._skillData)
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
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATE, handler(self, self._onActiveTalent), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATEONEKEY, handler(self, self._onActiveOneKeyTalent), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYRESET, handler(self, self._onResetTalent), self)
	var_0_2:addEventListener(var_0_3.SLG_TALENT_GUIDE_CLICK, handler(self, self.onGuideClickTalent), self)
	var_0_2:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, self.onCrossDayNotify, self)
end

function ThemeThirdBossTalentLayer:onCrossDayNotify()
	if g.core.common.ServerTime:getTime() >= g.core.model.User.newSlgData:getActEndTime() then
		g.core.module.ModuleManager:popComponent()

		return
	end
end

function ThemeThirdBossTalentLayer:onGuideClickTalent(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 then
		self:_showInfoComp({
			compWorldPosX = 0,
			id = arg_9_3:getId()
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end, 0.2)
	end
end

function ThemeThirdBossTalentLayer:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "NewSlgTalentScrollComp_scrollComp_show_info" then
		self:_showInfoComp(arg_11_2)

		return true
	end
end

function ThemeThirdBossTalentLayer:_showInfoComp(arg_12_1)
	self.m_infoComp:updateCompByStruct(self._skillData:getTalentById(arg_12_1.id, false, self._curSkillType), self._skillData, self._curSkillType)

	if not arg_12_1.compWorldPosX then
		return
	end

	self.m_isShowInfoController:setSelectedIndex(1)
end

function ThemeThirdBossTalentLayer:_onClickAttrBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.skillTree.NewSlgTalentAttrPop").new({
		type = self._curSkillType
	}))
end

function ThemeThirdBossTalentLayer:_onClickResetBtn()
	local var_14_0 = self._skillData:getAllActiveTalent(self._curSkillType)

	if table.nums(var_14_0) > 1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.skillTree.NewSlgTalentResetPop").new({
			isAll = true,
			skillData = self._skillData,
			talentDict = var_14_0
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405954))
	end
end

function ThemeThirdBossTalentLayer:_onActiveOneKeyTalent(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_infoComp:refreshComp()
	end

	self.m_scrollComp:updateScrollView()
	self.m_scrollComp:onS2CTalentActive(arg_15_4.activeIds)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_0.THEME_THIRD_TALENT_ACTIVE
		}
	})

	local var_15_0 = false

	for iter_15_0, iter_15_1 in ipairs(arg_15_4.activeIds) do
		local var_15_1 = self._skillData:getTalentById(iter_15_1, false, self._curSkillType)

		if var_15_1 and var_15_1:getInfo().talent_type == g.core.const.ConstMgr.NewSlgConst.ATTR.ATTR_FIGHT_VALUE then
			var_15_0 = true

			break
		end
	end

	if var_15_0 then
		local var_15_2 = g.core.model.User.newSlgData:getFightValueChange()

		if var_15_2 > 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				slgFightValueChange = var_15_2
			})
		end

		g.core.model.User.newSlgData:saveMyOldFightValue()
	end
end

function ThemeThirdBossTalentLayer:_onActiveTalent(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_infoComp:refreshComp()
	end

	self.m_scrollComp:updateScrollView()
	self.m_scrollComp:onS2CTalentActive({
		arg_16_4.id
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_0.THEME_THIRD_TALENT_ACTIVE
		}
	})

	local var_16_0 = self._skillData:getTalentById(arg_16_4.id, false, self._curSkillType)

	if var_16_0 and var_16_0:getInfo().talent_type == g.core.const.ConstMgr.NewSlgConst.ATTR.ATTR_FIGHT_VALUE then
		local var_16_1 = g.core.model.User.newSlgData:getFightValueChange()

		if var_16_1 > 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				slgFightValueChange = var_16_1
			})
		end

		g.core.model.User.newSlgData:saveMyOldFightValue()
	end
end

function ThemeThirdBossTalentLayer:_onResetTalent(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if not arg_17_4.talent_ids then
		-- block empty
	end

	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_infoComp:refreshComp()
	end

	self.m_scrollComp:updateScrollView()
end

function ThemeThirdBossTalentLayer:activeEffectEndPop(arg_18_1)
	local var_18_0 = {}

	var_18_0.hideContinue = true
	var_18_0.blackOpacity = 0.7
	var_18_0.withoutAni = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		talent = self._skillData:getTalentById(arg_18_1.id, false, self._curSkillType),
		title = g.core.lang:get(105026),
		showComp = fgui.UIPackage:createObject("echoLab", "EchoLabTreeActiveComp")
	}), var_18_0)
end

return ThemeThirdBossTalentLayer
