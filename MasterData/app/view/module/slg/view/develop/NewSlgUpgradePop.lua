local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.network.GameNetProxy
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum
local NewSlgUpgradePop = class("NewSlgUpgradePop", require("app.fairyGUI.newSlg.UI_NewSlgUpgradePop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgUpgradePop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	})
end)

function NewSlgUpgradePop:ctor(arg_2_1)
	self:showAtCenter()

	self._addList = {}
	self._costList = {}
	self._params = arg_2_1
	self._curCfg = nil
	self._nextCfg = nil
	self._upgradeState = 0
	self._needLv = 0
	self._cacheData = {}
	self._barrackStruct = nil

	self.m_upgradeList:setVirtual()
	self.m_upgradeList:setItemRenderer(handler(self, self._onRenderUpgradeList))
	self.m_costList:setVirtual()
	self.m_costList:setItemRenderer(handler(self, self._onRenderCostList))
	self.m_upgradeBtn:addClickListener(handler(self, self._onClickUpgradeBtn))
	self.m_btnClose:addClickListener(handler(self, self._onCLickBtnClose))
end

function NewSlgUpgradePop:onLoad()
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY, self._onRcvUpgradeMainCity, self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_UPGRADEBARRACK, self._onRcvUpgradeBarrack, self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_NEW_SLG_UPGRADESUPPLY, self._onRcvUpgradeSupply, self)
	self:_updateView()
	self.m_enterTransition:play()
end

function NewSlgUpgradePop:onUnload()
	self.m_backTransition:play()
end

function NewSlgUpgradePop:_getBuildCfg()
	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		self._curCfg = var_0_0:getMainCityCfg()
		self._nextCfg = var_0_0:getMainCityNextCfg()
	elseif self._params.buildType == var_0_1.SLG_BUILD_TYPE.SUPPLY then
		self._curCfg = var_0_0:getSupplyCfg()
		self._nextCfg = var_0_0:getSupplyNextCfg()
	else
		local var_5_0 = var_0_0:getBarrackStructByType(self._params.armyType)

		self._curCfg = var_5_0:getCfg()
		self._nextCfg = var_5_0:getNextCfg()
	end
end

function NewSlgUpgradePop:_updateView()
	self.m_buildTypeController:setSelectedIndex(self._params.buildType)
	self:_getBuildCfg()
	self.m_buildComp:updateView({
		title = var_0_0:getBuildNameByType(self._params.buildType, self._params.armyType),
		curLv = self._curCfg.level,
		nextLv = self._nextCfg.level,
		resURL = var_0_3:getNewSlgBuildPic(self._nextCfg.res_id)
	})
	self:_getUpgradeList()
	self.m_upgradeList:setNumItems(#self._addList)

	self._costList = self:_getCostList()

	self.m_costList:setNumItems(#self._costList)
	self:_updateUnlockStatus()
end

function NewSlgUpgradePop:_updateUnlockStatus()
	self.m_unlockTip:setVisible(false)

	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		self.m_mainCityTip:setText(g.core.lang:get(429580, {
			build = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.COMMAND),
			level = self._nextCfg.building_level_max
		}))

		self._upgradeState, self._needLv = var_0_0:getMainCityUpgradeState()

		if self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.CAN_UPGRADE then
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.CAN_UPGRADE)
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.MAX_LEVEL then
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.MAX)
		else
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.UNLOCK)
			self.m_unlockTip:setVisible(true)

			if self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.COST then
				self.m_unlockTip:setText(g.core.lang:get(109522))
			else
				self.m_unlockTip:setText(g.core.lang:get(429507, {
					level = self._needLv
				}))
			end
		end
	elseif self._params.buildType == var_0_1.SLG_BUILD_TYPE.SUPPLY then
		self._upgradeState, self._needLv = var_0_0:getSupplyUpgradeState()

		if self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.CAN_UPGRADE then
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.CAN_UPGRADE)
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.MAX_LEVEL then
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.MAX)
		else
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.UNLOCK)
			self.m_unlockTip:setVisible(true)

			if self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.COST then
				self.m_unlockTip:setText(g.core.lang:get(109522))
			else
				self.m_unlockTip:setText(g.core.lang:get(429529, {
					level = self._needLv,
					name1 = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.COMMAND),
					name2 = var_0_0:getBuildNameByType(self._params.buildType, self._params.armyType)
				}))
			end
		end
	else
		self._barrackStruct = var_0_0:getBarrackStructByType(self._params.armyType)
		self._upgradeState, self._needLv = self._barrackStruct:getBarrackUpgradeState()

		if self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.CAN_UPGRADE then
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.CAN_UPGRADE)
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.MAX_LEVEL then
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.MAX)
		else
			self.m_statusController:setSelectedIndex(var_0_1.SLG_DEVELOP_STATUS.UNLOCK)
			self.m_unlockTip:setVisible(true)

			if self._upgradeState == var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE.COST then
				self.m_unlockTip:setText(g.core.lang:get(109522))
			else
				self.m_unlockTip:setText(g.core.lang:get(429529, {
					level = self._needLv,
					name1 = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.COMMAND),
					name2 = var_0_0:getBuildNameByType(self._params.buildType, self._params.armyType)
				}))
			end
		end
	end

	self.m_upgradeBtn:setCtrlState("canUpgrade", {
		index = self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.CAN_UPGRADE and 1 or 0
	})

	if self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.MAX_LEVEL then
		self.m_upgradeBtn:setTitle(g.core.lang:get(429581))
	end
end

function NewSlgUpgradePop:_getUpgradeList()
	self._addList = {}
	self._cacheData = {}

	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		local var_8_0 = var_0_0:getMainCityRealUpgradeShowData()

		self._cacheData = var_8_0
		self._addList = clone(var_8_0.baseArr)

		for iter_8_0, iter_8_1 in ipairs(var_8_0.lineUpArr) do
			table.insert(self._addList, iter_8_1)
		end
	elseif self._params.buildType == var_0_1.SLG_BUILD_TYPE.SUPPLY then
		self._addList = var_0_0:getSupplyUpgradeShowData()
		self._cacheData = self._addList
	else
		self._addList = var_0_0:getBarrackStructByType(self._params.armyType):getUpgradeShowData()
		self._cacheData = self._addList
	end
end

function NewSlgUpgradePop:_onRenderUpgradeList(arg_9_1, arg_9_2)
	arg_9_2:updateUpgradeCell(self._addList[arg_9_1 + 1])
end

function NewSlgUpgradePop:_getCostList()
	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		return var_0_0:getMainCityUpgradeMaterials()
	elseif self._params.buildType == var_0_1.SLG_BUILD_TYPE.SUPPLY then
		return var_0_0:getSupplyUpgradeMaterials()
	end

	return var_0_0:getBarrackStructByType(self._params.armyType):getUpgradeMaterials()
end

function NewSlgUpgradePop:_onRenderCostList(arg_11_1, arg_11_2)
	arg_11_2:updateCostCell(self._costList[arg_11_1 + 1])
end

function NewSlgUpgradePop:_onClickUpgradeBtn()
	var_0_0:cacheUpgradeData(self._params.buildType, self._cacheData)

	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		if self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.MAX_LEVEL then
			-- block empty
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.BARRACK then
			var_0_2:tip(g.core.lang:get(429507, {
				level = self._needLv
			}))
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_COMMAND_UPGRADE_STATE.COST then
			var_0_2:tip(g.core.lang:get(109522))
		else
			var_0_4:send_C2S_NewSlg_UpgradeMainCity({
				level = self._curCfg.level
			})
		end
	elseif self._params.buildType == var_0_1.SLG_BUILD_TYPE.SUPPLY then
		if self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.MAX_LEVEL then
			-- block empty
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.COMMAND then
			var_0_2:tip(g.core.lang:get(429529, {
				level = self._needLv,
				name1 = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.COMMAND),
				name2 = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.SUPPLY)
			}))
		elseif self._upgradeState == var_0_1.SLG_DEVELOP_SUPPLY_UPGRADE_STATE.COST then
			var_0_2:tip(g.core.lang:get(109522))
		else
			var_0_4:send_C2S_NewSlg_UpgradeSupply({
				level = self._curCfg.level
			})
		end
	else
		local var_12_0 = var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE

		if self._upgradeState == var_0_1.SLG_DEVELOP_BARRACK_UPGRADE_STATE.MAX_LEVEL then
			-- block empty
		elseif self._upgradeState == var_12_0.COMMAND then
			var_0_2:tip(g.core.lang:get(429529, {
				level = self._needLv,
				name1 = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.COMMAND),
				name2 = var_0_0:getBuildNameByType(var_0_1.SLG_BUILD_TYPE.BARRACK, self._params.armyType)
			}))
		elseif self._upgradeState == var_12_0.COST then
			var_0_2:tip(g.core.lang:get(109522))
		else
			var_0_4:send_C2S_NewSlg_UpgradeBarrack({
				tp = self._curCfg.type,
				level = self._curCfg.level
			})
		end
	end
end

function NewSlgUpgradePop:_onRcvUpgradeMainCity(arg_13_1, arg_13_2, arg_13_3)
	var_0_2:pushPopup(require("app.view.module.slg.view.develop.NewSlgUpgradeSuccessPop").new({
		buildType = self._params.buildType,
		armyType = self._params.armyType,
		curCfg = self._curCfg,
		nextCfg = self._nextCfg
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
	self:_updateView()
end

function NewSlgUpgradePop:_onRcvUpgradeBarrack(arg_14_1, arg_14_2, arg_14_3)
	var_0_2:pushPopup(require("app.view.module.slg.view.develop.NewSlgUpgradeSuccessPop").new({
		buildType = self._params.buildType,
		armyType = self._params.armyType,
		curCfg = self._curCfg,
		nextCfg = self._nextCfg
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
	self:_updateView()
end

function NewSlgUpgradePop:_onRcvUpgradeSupply(arg_15_1, arg_15_2, arg_15_3)
	var_0_2:pushPopup(require("app.view.module.slg.view.develop.NewSlgUpgradeSuccessPop").new({
		buildType = self._params.buildType,
		armyType = self._params.armyType,
		curCfg = self._curCfg,
		nextCfg = self._nextCfg
	}), {
		touchDisappear = true,
		ignoreTouch = false
	})
	self:_updateView()
end

function NewSlgUpgradePop:_onCLickBtnClose()
	var_0_2:onlyPopSelfByDisplay(self)
end

return NewSlgUpgradePop
