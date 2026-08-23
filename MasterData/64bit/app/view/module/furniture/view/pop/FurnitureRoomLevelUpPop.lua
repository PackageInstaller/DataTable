local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local var_0_1 = g.core.model.User.hlTrainData
local var_0_2 = g.core.model.User.furnitureData
local FurnitureRoomLevelUpPop = class("FurnitureRoomLevelUpPop", require("app.fairyGUI.furniture.UI_FurnitureRoomLevelUpPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/furniture/furniture",
		resName = "FurnitureRoomLevelUpPop",
		pkgName = "furniture",
		isFullScreen = true
	}, ...)
end)

function FurnitureRoomLevelUpPop:ctor(arg_2_1)
	self._dormId = arg_2_1

	self.m_touchComp:addClickListener(handler(self, self._onClose))
	self.m_levelUpBtn:addClickListener(handler(self, self._onClickLevelUpBtn))
end

function FurnitureRoomLevelUpPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_UPGRADE, self._onS2CFurnitureRoomUpgrade, self)
	self:_updateView()
end

function FurnitureRoomLevelUpPop:_onS2CFurnitureRoomUpgrade()
	local var_4_0 = {
		"cutlevel",
		"txt1",
		"txt2",
		"txt3",
		"txt4"
	}
	local var_4_1 = self.m_levelupTransition

	if var_0_2:getRoomInfo(self._dormId):isMaxLevel() then
		var_4_1 = self.m_levelupmaxTransition
		var_4_0 = {
			"cutmax",
			"cutlevel",
			"txt1",
			"txt2",
			"txt3",
			"txt4"
		}
	end

	for iter_4_0 = 1, #var_4_0 do
		local var_4_2 = var_4_0[iter_4_0]

		var_4_1:setHook(var_4_0[iter_4_0], handler(self, function()
			self:_onAniFrameEvent(var_4_2)
		end))
	end

	var_4_1:play(handler(self, self._updateUpgradeConditions))
	self.m_effLevelUp:addEffectSpine({
		name = "eff_ui_furniture_levelup",
		remove = true,
		isLoop = false
	})
end

function FurnitureRoomLevelUpPop:_onAniFrameEvent(arg_6_1)
	local var_6_0 = var_0_2:getRoomInfo(self._dormId)
	local var_6_1 = var_6_0:getLevel()
	local var_6_2 = var_6_0:getComfortLimit()
	local var_6_3 = var_6_0:getMobilityRecoverBaseSpeed()
	local var_6_4 = var_6_0:getCheckInCountLimit()

	if var_6_0:isMaxLevel() then
		if arg_6_1 == "cutmax" then
			self.m_fullLevelController:setSelectedIndex(1)
		elseif arg_6_1 == "cutlevel" then
			self.m_curLevelTxt:setText(var_6_1)
			self.m_enCurLevelTxt:setText(g.core.lang:get(112538))
		elseif arg_6_1 == "txt1" then
			self.m_levelMaxTxt:setText(var_6_1)
		elseif arg_6_1 == "txt2" then
			self.m_comfortMaxTxt:setText(var_6_2)
		elseif arg_6_1 == "txt3" then
			self.m_recoverMaxTxt:setText(var_6_3)
		elseif arg_6_1 == "txt4" then
			self.m_checkInNumMaxTxt:setText(var_6_4)
		end
	else
		local var_6_5 = var_6_0:getNextLevel()

		if arg_6_1 == "cutlevel" then
			self.m_curLevelTxt:setText(var_6_1)
			self.m_enCurLevelTxt:setText(g.core.lang:get(112537, {
				level = string.format("%03d", var_6_1)
			}))
		elseif arg_6_1 == "txt1" then
			self.m_levelFromTxt:setText(var_6_1)
			self.m_levelToTxt:setText(var_6_5)
		elseif arg_6_1 == "txt2" then
			self.m_comfortFromTxt:setText(var_6_2)
			self.m_comfortToTxt:setText((var_6_0:getComfortLimit(var_6_5)))
		elseif arg_6_1 == "txt3" then
			self.m_recoverFromTxt:setText(var_6_3)
			self.m_recoverToTxt:setText((var_6_0:getMobilityRecoverBaseSpeed(var_6_5)))
		elseif arg_6_1 == "txt4" then
			self.m_checkInNumFromTxt:setText(var_6_4)
			self.m_checkInNumToTxt:setText((var_6_0:getCheckInCountLimit(var_6_5)))
		end
	end
end

function FurnitureRoomLevelUpPop:_updateView()
	self.m_floorTxt:setText(g.core.lang:get(112536, {
		num = g.core.lang:get(100 + self._dormId)
	}))

	local var_7_0 = var_0_2:getRoomInfo(self._dormId)
	local var_7_1 = var_7_0:getLevel()

	self.m_curLevelTxt:setText(var_7_1)

	local var_7_2 = var_7_0:getComfortLimit()
	local var_7_3 = var_7_0:getMobilityRecoverBaseSpeed()
	local var_7_4 = var_7_0:getCheckInCountLimit()

	if var_7_0:isMaxLevel() then
		self.m_enCurLevelTxt:setText(g.core.lang:get(112538))
		self.m_levelMaxTxt:setText(var_7_1)
		self.m_comfortMaxTxt:setText(var_7_2)
		self.m_recoverMaxTxt:setText(var_7_3)
		self.m_checkInNumMaxTxt:setText(var_7_4)
		self.m_fullLevelController:setSelectedIndex(1)
	else
		local var_7_5 = {}

		var_7_5.level = string.format("%03d", var_7_1)

		self.m_enCurLevelTxt:setText(g.core.lang:get(112537, var_7_5))

		local var_7_6 = var_7_0:getNextLevel()

		self.m_levelFromTxt:setText(var_7_1)
		self.m_levelToTxt:setText(var_7_6)
		self.m_comfortFromTxt:setText(var_7_2)
		self.m_comfortToTxt:setText((var_7_0:getComfortLimit(var_7_6)))
		self.m_recoverFromTxt:setText(var_7_3)
		self.m_recoverToTxt:setText((var_7_0:getMobilityRecoverBaseSpeed(var_7_6)))
		self.m_checkInNumFromTxt:setText(var_7_4)
		self.m_checkInNumToTxt:setText((var_7_0:getCheckInCountLimit(var_7_6)))
		self:_updateUpgradeConditions()
		self.m_fullLevelController:setSelectedIndex(0)
	end
end

function FurnitureRoomLevelUpPop:_onClose()
	self:dispatchCompEvent("EVENT_CLOSE_LEVEL_UP_POP")
	g.core.module.ModuleManager:popModule()
end

function FurnitureRoomLevelUpPop:_onClickLevelUpBtn()
	local var_9_0 = var_0_2:getRoomInfo(self._dormId)

	if var_9_0:isEnoughItemLevelUpNeed() then
		local var_9_1, var_9_2 = var_9_0:isCanLevelUp()

		if var_9_1 then
			g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Upgrade({
				room_id = self._dormId
			})
		elseif var_9_2 and #var_9_2 > 0 then
			g.core.module.ModuleManager:tip(var_9_2)
		end
	else
		local var_9_3 = var_9_0:getUpUpgradeInfo()

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_9_3.upgrade_cost_type,
			value = var_9_3.upgrade_cost_value
		})
	end
end

function FurnitureRoomLevelUpPop:_updateUpgradeConditions()
	local var_10_0 = var_0_2:getRoomInfo(self._dormId):getUpUpgradeInfo()

	if var_10_0 and var_10_0.update_type == var_0_0.LEVEL_UP_COND_TYPE.HL_TRAIN_ROOM_LEVEL then
		local var_10_1 = var_0_1:getRoomStruct(var_10_0.update_value_1)
		local var_10_2 = var_10_1.refCfgBaseInfo.name
		local var_10_3

		if var_10_1:isUnlocked() then
			var_10_3 = var_10_1.curLevel or 0
		end

		local var_10_4 = var_10_0.update_value_2

		self.m_conditionTxt:setText(g.core.lang:get(112539, {
			name = var_10_2,
			num = var_10_0.update_value_2
		}))
		self.m_conditionProgressTxt:setText(g.core.lang:get(112540, {
			cur = var_10_3,
			target = var_10_4
		}))
		self.m_levelUpGroup:setVisible(true)
	else
		self.m_levelUpGroup:setVisible(false)
	end

	self.m_resNumComp:updateByTVS({
		type = var_10_0.upgrade_cost_type,
		value = var_10_0.upgrade_cost_value,
		size = var_10_0.upgrade_cost_size
	})
end

return FurnitureRoomLevelUpPop
