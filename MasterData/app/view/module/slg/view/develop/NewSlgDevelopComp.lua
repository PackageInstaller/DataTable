local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.model.User.newSlgDevelopData
local var_0_2 = g.core.model.User.newSlgSkillTreeData
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum
local NewSlgDevelopComp = class("NewSlgDevelopComp", require("app.fairyGUI.newSlg.UI_NewSlgDevelopComp"))

function NewSlgDevelopComp:ctor()
	self._playSound = true

	self.m_commandBtn:setTitle(g.core.lang:get(429501))
	self.m_barrackBtn1:setTitle(g.core.lang:get(429502))
	self.m_barrackBtn2:setTitle(g.core.lang:get(429504))
	self.m_barrackBtn3:setTitle(g.core.lang:get(429503))
	self.m_supplyBtn:setTitle(g.core.lang:get(429505))

	if g.core.model.User.newSlgData:getSName() == "S2" then
		self.m_embryoBtn:getChild("redPointComp"):setId(931)
		self.m_isS2Controller:setSelectedIndex(1)
	else
		self.m_embryoBtn:getChild("redPointComp"):setId(843)
		self.m_isS2Controller:setSelectedIndex(0)
	end

	self:_initClickListener()
end

function NewSlgDevelopComp:_initClickListener()
	self._imgBarrackArr = {}
	self._btnBarrackArr = {}

	for iter_2_0 = 1, 3 do
		if self["m_imgBarrack" .. iter_2_0] then
			self["m_imgBarrack" .. iter_2_0]:addClickListener(handler(self, self._onClickBtnBarrack))
			table.insert(self._imgBarrackArr, self["m_imgBarrack" .. iter_2_0])
		end

		local var_2_0 = self["m_barrackBtn" .. iter_2_0]

		if self["m_barrackBtn" .. iter_2_0] then
			var_2_0:addClickListener(handler(self, self._onClickBtnBarrack))
			table.insert(self._btnBarrackArr, var_2_0)
		end
	end

	self.m_upgradeBtn:addClickListener(handler(self, self._onClickBtnUpgrade))
	self.m_embryoBtn:addClickListener(handler(self, self._onClickBtnEmbryo))
	self.m_supplyUpBtn:addClickListener(handler(self, self._onClickBtnSupplyUp))
	self.m_supplyGetBtn:addClickListener(handler(self, self._onClickBtnSupplyGet))
	self.m_imgCommand:addClickListener(handler(self, self._onClickImgCommand))
	self.m_imgSupply:addClickListener(handler(self, self._onClickImgSupply))
	self.m_isSupplySelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSupplySelChanged))
	self.m_isCommandSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCommandSelChanged))
	self.m_touchComp:addClickListener(handler(self, self._onClickTouchComp))
end

function NewSlgDevelopComp:_onClickTouchComp()
	self._playSound = false

	self.m_isCommandSelController:setSelectedIndex(0)
	self.m_isSupplySelController:setSelectedIndex(0)
end

function NewSlgDevelopComp:_onClickImgCommand()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RANKING_SWITCH_PAGE)
	self.m_isCommandSelController:setSelectedIndex(not (self.m_isCommandSelController:getSelectedIndex() == 1) and 1 or 0)
end

function NewSlgDevelopComp:_onClickImgSupply()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RANKING_SWITCH_PAGE)
	self.m_isSupplySelController:setSelectedIndex(not (self.m_isSupplySelController:getSelectedIndex() == 1) and 1 or 0)
end

function NewSlgDevelopComp:_onSupplySelChanged()
	self:_updateOpacity()

	if self._playSound then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RANKING_SWITCH_PAGE)
	end

	self._playSound = true
end

function NewSlgDevelopComp:_onCommandSelChanged()
	self:_updateOpacity()

	if self._playSound then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RANKING_SWITCH_PAGE)
	end

	self._playSound = true
end

function NewSlgDevelopComp:_updateOpacity()
	local var_8_0 = self.m_isSupplySelController:getSelectedIndex() == 1
	local var_8_1 = self.m_isCommandSelController:getSelectedIndex() == 1
	local var_8_2 = (var_8_0 or var_8_1) and 127.5 or 255

	for iter_8_0 = 1, 3 do
		if self["m_barrackBtn" .. iter_8_0] then
			self["m_barrackBtn" .. iter_8_0]:setOpacity(var_8_2)
		end
	end

	self.m_commandBtn:setOpacity((var_8_1 or not var_8_1 and not var_8_0) and 255 or 127.5)
	self.m_supplyBtn:setOpacity((var_8_0 or not var_8_1 and not var_8_0) and 255 or 127.5)
end

function NewSlgDevelopComp:onLoad()
	var_0_5:addEventListener(var_0_6.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY, handler(self, self._onRcvUpgradeMainCity), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_UPGRADESUPPLY, handler(self, self._onRcvUpgradeSupply), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_UPGRADEBARRACK, handler(self, self._onRcvUpgradeBarrack), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_STATIONMAINCITY, handler(self, self._onRcvStationMainCity), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_OBTAINSUPPLYAWARD, handler(self, self._onRcvGetAward), self)

	if g.core.model.User.newSlgData:isFarmOpen() then
		var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_GETUSERFARMINFO, handler(self, self._onRcvGetFarmInfo), self)
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserFarmInfo({})
	end

	self:updateView()
	self:_refreshAllRedPoint()
end

function NewSlgDevelopComp:_refreshAllRedPoint()
	var_0_5:dispatchEvent(var_0_6.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_barrackBtn1,
		customData = {
			armyType = var_0_0.ARMY_TYPE.QI
		}
	})
	var_0_5:dispatchEvent(var_0_6.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_barrackBtn2,
		customData = {
			armyType = var_0_0.ARMY_TYPE.DUN
		}
	})
	var_0_5:dispatchEvent(var_0_6.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_barrackBtn3,
		customData = {
			armyType = var_0_0.ARMY_TYPE.GONG
		}
	})

	local var_10_0 = var_0_1:checkSupplyCanUpgrade()
	local var_10_1 = var_0_1:checkSupplyProductLimit()

	self.m_supplyUpBtn:getChild("redPointComp"):setShow(var_10_0)
	self.m_supplyGetBtn:getChild("redPointComp"):setShow(var_10_1)
	self.m_supplyBtn:getChild("redPointComp"):setShow(var_10_0 or var_10_1)

	local var_10_2 = var_0_1:checkMainCityCanUpgrade()
	local var_10_3 = false

	var_10_3 = g.core.model.User.newSlgData:getSName() == "S1" and var_0_1:checkEmbryoLineUpWithCustomData() or var_0_2:hasTalentRed()

	self.m_upgradeBtn:getChild("redPointComp"):setShow(var_10_2)
	self.m_embryoBtn:getChild("redPointComp"):setShow(var_10_3)
	self.m_commandBtn:getChild("redPointComp"):setShow(var_10_2 or var_10_3)
end

function NewSlgDevelopComp:_onRcvGetFarmInfo(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:updateBuildPic()
end

function NewSlgDevelopComp:_refreshEmbryoRedPoint()
	self.m_embryoBtn:getChild("redPointComp"):setShow(g.core.model.User.newSlgData:getSName() == "S" and var_0_1:checkEmbryoLineUpWithCustomData() or var_0_2:hasTalentRed())
end

function NewSlgDevelopComp:_refreshCommandUpRedPoint()
	self.m_upgradeBtn:getChild("redPointComp"):setShow((var_0_1:checkMainCityCanUpgrade()))
end

function NewSlgDevelopComp:_refreshSupplyUpRedPoint()
	self.m_supplyUpBtn:getChild("redPointComp"):setShow((var_0_1:checkSupplyCanUpgrade()))
end

function NewSlgDevelopComp:_refreshSupplyGetRedPoint()
	self.m_supplyGetBtn:getChild("redPointComp"):setShow((var_0_1:checkSupplyProductLimit()))
end

function NewSlgDevelopComp:_onModuleExit(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_3 and arg_16_3.params

	if not (arg_16_3 and arg_16_3.params) then
		return
	end

	local var_16_1 = var_16_0.tag

	if var_16_0.tag then
		if var_16_1 == g.core.const.ConstMgr.ShowConst.TAG.NEWS_SLG_SUPPLY then
			self:_playSupplyUpEffect()
		elseif var_16_1 == g.core.const.ConstMgr.ShowConst.TAG.NEWS_SLG_BARRACK then
			self:_playBarrackUpEffect()
		end
	end
end

function NewSlgDevelopComp:_onRcvStationMainCity()
	self:_refreshEmbryoRedPoint()
end

function NewSlgDevelopComp:_onRcvGetAward(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	var_0_3:awardSummary((g.core.common.GlobalFunc.mergeAwards(arg_18_4.awards)))
	self:_updateResGet()
	self:_refreshSupplyGetRedPoint()
end

function NewSlgDevelopComp:_onRcvUpgradeMainCity(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self:updateBuildPic()
	self:_refreshEmbryoRedPoint()
	self:_refreshRedPointAfterUpgrade()
end

function NewSlgDevelopComp:_onRcvUpgradeSupply(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	self:updateBuildPic()
	self:_updateResGet()
	self:_refreshRedPointAfterUpgrade()
end

function NewSlgDevelopComp:_onRcvUpgradeBarrack(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self._upBarrack = arg_21_4.tp

	self:updateBuildPic()
	self:_refreshRedPointAfterUpgrade()
end

function NewSlgDevelopComp:_refreshRedPointAfterUpgrade()
	self:_refreshCommandUpRedPoint()
	self:_refreshSupplyUpRedPoint()
	var_0_5:dispatchEvent(var_0_6.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_barrackBtn1,
		customData = {
			armyType = var_0_0.ARMY_TYPE.QI
		}
	})
	var_0_5:dispatchEvent(var_0_6.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_barrackBtn2,
		customData = {
			armyType = var_0_0.ARMY_TYPE.DUN
		}
	})
	var_0_5:dispatchEvent(var_0_6.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_barrackBtn3,
		customData = {
			armyType = var_0_0.ARMY_TYPE.GONG
		}
	})
end

function NewSlgDevelopComp:updateView()
	self:updateBuildPic()
	self:_updateResGet()
end

function NewSlgDevelopComp:_updateResGet()
	self.m_getComp:updateView(self._resPos)
	self:updateResVisible()
end

function NewSlgDevelopComp:updateResVisible()
	local var_25_0 = var_0_1:checkSupplyCanAwards()

	self.m_getComp:setVisible(var_25_0)

	if var_25_0 then
		self.m_getComp:playCanGetAnim()
	end
end

function NewSlgDevelopComp:updateBuildPic()
	local var_26_0 = var_0_1:getMainCityCfg()

	self.m_imgCommand:setURL(var_0_4:getNewSlgMainCityPic(var_26_0.res_id))
	self.m_commandSel:setURL(var_0_4:getMainCitySelect(var_26_0.res_id))

	local var_26_1 = var_0_1:getSupplyCfg()

	self.m_imgSupply:setURL(var_0_4:getNewSlgMainCityPic(var_26_1.res_id))
	self.m_supplySel:setURL(var_0_4:getMainCitySelect(var_26_1.res_id))

	for iter_26_0, iter_26_1 in pairs(var_0_1:getBarrackStructMap()) do
		if self._imgBarrackArr[iter_26_0] then
			self._imgBarrackArr[iter_26_0]:setURL(var_0_4:getNewSlgMainCityPic(iter_26_1:getPicResId()))
		end

		if self._btnBarrackArr[iter_26_0] then
			self._btnBarrackArr[iter_26_0]:updateView({
				level = iter_26_1:getLevel()
			})
		end
	end

	self.m_commandBtn:updateView({
		level = var_0_1:getMainCityLv()
	})
	self.m_supplyBtn:updateView({
		level = var_0_1:getSupplyLv()
	})
end

function NewSlgDevelopComp:_playBarrackUpEffect()
	local var_27_0 = self._imgBarrackArr[self._upBarrack]:getSize()

	self._imgBarrackArr[self._upBarrack]:addEffect({
		name = "effect_wdzy_zhucheng_jzsj",
		x = var_27_0.width / 2,
		y = var_27_0.height / 2
	})
end

function NewSlgDevelopComp:_playSupplyUpEffect()
	local var_28_0 = self._imgSupply:getSize()

	self._imgSupply:addEffect({
		name = "effect_wdzy_zhucheng_jzsj",
		x = var_28_0.width / 2,
		y = var_28_0.height / 2
	})
end

function NewSlgDevelopComp:_onClickBtnMain()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN_CITY_LAYER)
end

function NewSlgDevelopComp:_onClickBtnBurn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.BURN_MAIN_LAYER)
end

function NewSlgDevelopComp:_onClickBtnSupply()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SUPPLY_POP)
end

function NewSlgDevelopComp:_onClickBtnBarrack(arg_32_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RANKING_SWITCH_PAGE)

	local var_32_0 = arg_32_1:getSender()
	local var_32_1 = var_0_0.SLG_BUILD_TYPE.BARRACK
	local var_32_2 = 0

	if var_32_0 == self.m_barrackBtn1 or var_32_0 == self._imgBarrackArr[1] then
		var_32_2 = var_0_0.ARMY_TYPE.QI
	elseif var_32_0 == self.m_barrackBtn2 or var_32_0 == self._imgBarrackArr[2] then
		var_32_2 = var_0_0.ARMY_TYPE.DUN
	elseif var_32_0 == self.m_barrackBtn3 or var_32_0 == self._imgBarrackArr[3] then
		var_32_2 = var_0_0.ARMY_TYPE.GONG
	end

	var_0_3:pushPopup(require("app.view.module.slg.view.develop.NewSlgUpgradePop").new({
		buildType = var_32_1,
		armyType = var_32_2
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function NewSlgDevelopComp:_onClickBtnUpgrade()
	self.m_isCommandSelController:setSelectedIndex(0)
	var_0_3:pushPopup(require("app.view.module.slg.view.develop.NewSlgUpgradePop").new({
		buildType = var_0_0.SLG_BUILD_TYPE.COMMAND
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function NewSlgDevelopComp:_onClickBtnEmbryo()
	self.m_isCommandSelController:setSelectedIndex(0)

	if g.core.model.User.newSlgData:getSName() == "S2" then
		var_0_3:pushModule(g.view.entrance.NEW_SLG_SKILL_TREE, {
			skillType = 1
		})
	else
		var_0_3:pushModule(g.view.entrance.NEW_SLG_EMBRYO_LINEUP_POP)
	end
end

function NewSlgDevelopComp:_onClickBtnSupplyUp()
	self.m_isSupplySelController:setSelectedIndex(0)
	var_0_3:pushPopup(require("app.view.module.slg.view.develop.NewSlgUpgradePop").new({
		buildType = var_0_0.SLG_BUILD_TYPE.SUPPLY
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function NewSlgDevelopComp:_onClickBtnSupplyGet()
	self.m_isSupplySelController:setSelectedIndex(0)
	var_0_3:pushPopup(require("app.view.module.slg.view.develop.NewSlgSupplyPop").new({}), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

return NewSlgDevelopComp
