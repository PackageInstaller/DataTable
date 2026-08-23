local GveHalidomBagPop = require("app.view.module.gve.view.gveBag.GveHalidomBagPop")
local var_0_1 = g.core.model.User.gveDataMgr:getGveTaskData()
local var_0_2 = g.core.model.User.gveDataMgr:getGveBagData()
local var_0_3 = g.core.model.User.gveDataMgr
local var_0_4 = g.core.const.ConstMgr.GuideConst
local var_0_5 = 7
local GveHalidomDevelopLayer = class("GveHalidomDevelopLayer", require("app.fairyGUI.gve.UI_GveHalidomDevelopLayer"), function()
	return fgui.GComponent:create({
		pkgName = "gve",
		isFullScreen = true,
		pkgPath = "ui/gve/gve",
		resName = "GveHalidomDevelopLayer"
	}, ...)
end)

function GveHalidomDevelopLayer:ctor(arg_2_1)
	var_0_2 = g.core.model.User.gveDataMgr:getGveBagData()
	var_0_1 = g.core.model.User.gveDataMgr:getGveTaskData()
	self._oriAttrList = {}
	self._oldFightValue = 0
	self._inited = false

	self.m_enterTransition:play(handler(self, self._onAnimationEnd))
	self:_initView()
end

function GveHalidomDevelopLayer:_onAnimationEnd()
	self:playCoreHalidomAnimation()
	self.m_effStandby:addEffectSpine({
		remove = false,
		anim = "play",
		name = "eff_ui_gveBag_standby",
		isLoop = true
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GveHalidomDevelopLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MENU_GVE_MENU)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP, self._onRecEquip, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP, handler(self, self._onRecLevelUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE, self._onRecMerge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION, self._onDecompose, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION, self._onDecompose, self)
	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_HALIDOM_ENTER)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._updatePushGiftBtn), self)
	self:_onRecHalidomInfo()

	if self._inited then
		self:playCoreHalidomAnimation()
	end

	self._inited = true
end

function GveHalidomDevelopLayer:playCoreHalidomAnimation()
	local var_5_0 = var_0_2:getCoreHalidomBranch()

	if var_5_0 == 0 then
		self.m_standby0Transition:play(-1, 0)
	elseif var_5_0 == 1 then
		self.m_standby1Transition:play(-1, 0)
	elseif var_5_0 == 2 then
		self.m_standby2Transition:play(-1, 0)
	elseif var_5_0 == 3 then
		self.m_standby3Transition:play(-1, 0)
	end
end

function GveHalidomDevelopLayer:_initView()
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_HALIDOM_LAYER)

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_HALIDOM_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_0_4.ENUM_TICK.GVE_FIRST_ENTER_HALIDOM
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_HALIDOM_ENTER)
	end

	self.m_bagBtn:addClickListener(handler(self, self._onClickBagBtn))
	self.m_switchBranchBtn:addClickListener(handler(self, self._onClickBranchBtn))
	self.m_showMoreAttrBtn:addClickListener(handler(self, self._onShowMoreAttr))
end

function GveHalidomDevelopLayer:_onRecHalidomInfo(arg_7_1, arg_7_2, arg_7_3)
	self:updateView()

	self._oriAttrList = var_0_2:getAttrList()
end

function GveHalidomDevelopLayer:_onRecEquip()
	self:updateView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shengwu_mosaic)
end

function GveHalidomDevelopLayer:_onRecLevelUp(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:updateView()

	local var_9_0 = var_0_2:getCoreHalidomBranch()

	if var_9_0 == 0 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shengwu_Moon_Core)
		self.m_effUp:addEffectSpine({
			isLoop = false,
			anim = "play",
			remove = true,
			name = "eff_ui_gveBag_yueliangUpgrade",
			eventHandler = handler(self, self._onUpgradeAniEnd)
		})
	elseif var_9_0 == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shengwu_Sun_Core)
		self.m_effUp:addEffectSpine({
			isLoop = false,
			anim = "play",
			remove = true,
			name = "eff_ui_gveBag_taiyangUpgrade",
			eventHandler = handler(self, self._onUpgradeAniEnd)
		})
	elseif var_9_0 == 2 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shengwu_Constellation_Core)
		self.m_effUp:addEffectSpine({
			isLoop = false,
			anim = "play",
			remove = true,
			name = "eff_ui_gveBag_xingzuoUpgrade",
			eventHandler = handler(self, self._onUpgradeAniEnd)
		})
	elseif var_9_0 == 3 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shengwu_Star_Core)
		self.m_effUp:addEffectSpine({
			isLoop = false,
			anim = "play",
			remove = true,
			name = "eff_ui_gveBag_xingxingUpgrade",
			eventHandler = handler(self, self._onUpgradeAniEnd)
		})
	end
end

function GveHalidomDevelopLayer:_onUpgradeAniEnd()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_In)
	g.core.module.ModuleManager:showFeedBackTipsPop({
		title = g.core.lang:get(300021),
		showComp = fgui.UIPackage:createObject("gve", "GveHalidomUpLevelTip")
	})
end

function GveHalidomDevelopLayer:_onRecMerge()
	self:updateView()
end

function GveHalidomDevelopLayer:_onDecompose()
	self:updateView()
end

function GveHalidomDevelopLayer:updateView()
	local var_13_0 = var_0_2:getEquipHalidomByPosition(0)
	local var_13_1 = var_0_2:getCoreHalidomBranch()

	if var_13_1 == 0 then
		self.m_bg:setURL("bg/gve/bg_pshc_hexin_yueliang.jpg")
		self.m_branchStatusController:setSelectedIndex(0)
	elseif var_13_1 == 1 then
		self.m_bg:setURL("bg/gve/bg_pshc_hexin_taiyang.jpg")
		self.m_branchStatusController:setSelectedIndex(1)
	elseif var_13_1 == 2 then
		self.m_bg:setURL("bg/gve/bg_pshc_hexin_xingzuo.jpg")
		self.m_branchStatusController:setSelectedIndex(2)
	elseif var_13_1 == 3 then
		self.m_bg:setURL("bg/gve/bg_pshc_hexin_xingxing.jpg")
		self.m_branchStatusController:setSelectedIndex(3)
	end

	local var_13_2 = var_0_2:getFightValue()

	self.m_fightValueText:setText(var_13_2)

	if self._oldFightValue ~= var_13_2 then
		self.m_fightValueText:runChangeAni(self._oldFightValue, var_13_2, false)

		self._oldFightValue = var_13_2
	end

	local var_13_3 = var_0_1:getPrivilegeLevel()
	local var_13_4 = var_13_0:getNeedTaskLevel()

	if not var_0_2:isFullLevel() and var_0_2:canCoreHalidomLevelUp() then
		if var_13_4 <= var_13_3 then
			self.m_upLevelStatusController:setSelectedIndex(0)
		else
			self.m_upLevelStatusController:setSelectedIndex(1)
			self.m_halidomUpLevelText:setText(g.core.lang:get(309173, {
				level = var_13_4
			}))
		end
	else
		self.m_upLevelStatusController:setSelectedIndex(0)
	end

	local var_13_5 = var_13_0:getCfg()

	if var_13_5.main_skill_type_1 ~= 0 then
		for iter_13_0 = 1, 3 do
			self["m_skillIcon" .. iter_13_0]:updateView({
				skillId = var_13_5["main_skill_type_" .. iter_13_0]
			})
		end

		self.m_skillStatusController:setSelectedIndex(1)
	else
		self.m_skillStatusController:setSelectedIndex(0)
		self.m_skillLimiteText:setText(g.core.lang:get(309166, {
			level = var_0_2:getAfterSelectBranchLevel()
		}))
	end

	local var_13_6 = var_0_2:getAttrList()
	local var_13_7 = math.min(4, #var_13_6)

	for iter_13_1 = 1, var_13_7 do
		self["m_attrComp" .. iter_13_1]:setVisible(true)
		self["m_attrComp" .. iter_13_1]:updateAttr(var_13_6[iter_13_1])
		self["m_attrBg" .. iter_13_1]:setVisible(true)
	end

	for iter_13_2 = var_13_7 + 1, 4 do
		self["m_attrComp" .. iter_13_2]:setVisible(false)
		self["m_attrBg" .. iter_13_2]:setVisible(false)
	end

	if #var_13_6 > 4 then
		self.m_showMoreAttrBtn:setVisible(true)
	else
		self.m_showMoreAttrBtn:setVisible(false)
	end

	for iter_13_3 = 1, var_0_5 do
		self["m_halidomIcon" .. iter_13_3 - 1]:updateView(iter_13_3 - 1, true)
	end

	if var_0_2:getCoreHalidomBranch() ~= 0 then
		self.m_switchBranchBtn:updateView()
		self.m_switchBranchBtn:setTouchable(true)
	else
		self.m_switchBranchBtn:updateView()
		self.m_switchBranchBtn:setTouchable(false)
	end
end

function GveHalidomDevelopLayer:_updatePushGiftBtn()
	self:checkCanLvUpGuide()
end

function GveHalidomDevelopLayer:checkCanLvUpGuide()
	local var_15_0 = g.core.module.ModuleManager:getCurModule()

	if not var_15_0 then
		return
	end

	if var_15_0.display:getName() == "GveHalidomDevelopLayer" then
		if var_0_3:getGveBagData():checkOneHalidomAllEquip() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "GUIDE_GVE_HALIDOM_LE_UP",
				targetBtn = self.m_halidomIcon0
			})
		end
	end
end

function GveHalidomDevelopLayer:receiveCompEvent(arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or {}
end

function GveHalidomDevelopLayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function GveHalidomDevelopLayer:_onClickBagBtn()
	g.core.module.ModuleManager:pushPopup(GveHalidomBagPop.new())
end

function GveHalidomDevelopLayer:_onClickBranchBtn()
	if var_0_2:getCoreHalidomBranch() ~= 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_BRANCH, {
			levelUp = false
		})
	end
end

function GveHalidomDevelopLayer:_onShowMoreAttr()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveBag.GveAttrPop").new())
end

return GveHalidomDevelopLayer
