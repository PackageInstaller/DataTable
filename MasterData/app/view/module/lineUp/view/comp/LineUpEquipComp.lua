local LineUpEquipComp = class("LineUpEquipComp", require("app.fairyGUI.lineUp.UI_LineUpEquipComp"))
local var_0_1 = g.core.model.User.equipmentData
local var_0_2 = g.core.model.User.treasureData
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_5 = g.core.common.Goods
local var_0_6 = {
	1,
	4,
	2,
	3,
	5,
	6
}

function LineUpEquipComp:ctor()
	self._isInit = false
	self._qualityEffectIcon = {
		{},
		{}
	}

	self:_initView()
end

function LineUpEquipComp:_initView()
	for iter_2_0 = 1, 4 do
		self["m_equipTouch" .. iter_2_0]:setName("EQUIP" .. iter_2_0)
		self["m_equipTouch" .. iter_2_0]:addClickListener(handler(self, self._onClickItem))
	end

	for iter_2_1 = 1, 2 do
		self["m_treasureTouch" .. iter_2_1]:setName("TREASURE" .. iter_2_1)
		self["m_treasureTouch" .. iter_2_1]:addClickListener(handler(self, self._onClickItem))
	end
end

function LineUpEquipComp:updateComp(arg_3_1, arg_3_2)
	self._knightIndex = arg_3_1
	self._knightSid = arg_3_2

	self:_hideTreasureEffect(1)
	self:_hideTreasureEffect(2)

	if not self._knightIndex then
		return
	end

	for iter_3_0 = 1, 4 do
		local var_3_0 = var_0_1:getEquipDataByKnightIndex(self._knightIndex, var_0_6[iter_3_0])

		self["m_equip" .. iter_3_0]:updateEquipIcon(var_3_0, iter_3_0)

		if var_3_0 then
			self["m_equip" .. iter_3_0 .. "QualityBg"]:setURL((var_0_3:getEquipEntranceQualityBg(var_3_0:getCfg().quality + 1)))
		else
			self["m_equip" .. iter_3_0 .. "QualityBg"]:setURL("")
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_equipRedComp,
		customData = {
			index = self._knightIndex
		}
	})

	local var_3_1 = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_LINEUP)

	if not var_3_1 then
		self.m_showTreasureController:setSelectedIndex(1)

		return
	else
		self.m_showTreasureController:setSelectedIndex(0)
	end

	for iter_3_1 = 1, 2 do
		local var_3_2 = self["m_treasure" .. iter_3_1 .. "Quality"]:getController("qualityBg")

		var_3_2:setSelectedIndex(0)

		local var_3_3 = var_0_2:getTreasureDataByPos((self._knightIndex - 1) * 2 + iter_3_1)

		self["m_treasure" .. iter_3_1 .. "Level"]:updateLevel(false)

		if var_3_3 then
			local var_3_4 = var_0_5:convert({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_3_3.base_id
			})

			self["m_treasure" .. iter_3_1]:setScale(0.9)
			self["m_treasure" .. iter_3_1]:setURL(var_3_4.icon)
			var_3_2:setSelectedIndex(var_3_4.quality or 0)

			if var_3_4.quality <= 1 then
				self["m_treasure" .. iter_3_1 .. "Level"]:updateLevel(true, var_3_3.level)
			else
				self["m_treasure" .. iter_3_1 .. "Level"]:updateLevel(true, var_3_3.level, var_3_3.refining_level)

				if var_3_4.quality >= var_0_4.UR and var_3_4.value > 0 then
					self:_playTreasureEffect(iter_3_1, var_3_4.value)
				end
			end
		else
			self["m_treasure" .. iter_3_1]:setScale(1)
			self["m_treasure" .. iter_3_1]:setURL((var_0_3:getEmptyTreasurePicIconById(true)))
		end
	end

	if not self._isInit then
		if var_3_1 then
			self.m_enter_0Transition:play()
		else
			self.m_enter_1Transition:play()
		end

		self._isInit = true
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_treasure1red,
		customData = {
			index = self._knightIndex
		}
	})
end

function LineUpEquipComp:updateOtherComp(arg_4_1, arg_4_2)
	self._knightIndex = arg_4_1
	self._knight = arg_4_2
	self._isOtherPlayer = true

	self:_hideTreasureEffect(1)
	self:_hideTreasureEffect(2)

	if not self._knightIndex then
		return
	end

	for iter_4_0 = 1, 4 do
		local var_4_0 = g.core.model.User.playerInfoData:getEquipmentByPos((self._knightIndex - 1) * 4 + var_0_6[iter_4_0])

		self["m_equip" .. iter_4_0]:updateOtherEquipIcon(var_4_0, iter_4_0)

		if var_4_0 then
			self["m_equip" .. iter_4_0 .. "QualityBg"]:setURL((var_0_3:getEquipEntranceQualityBg(var_4_0:getCfg().quality + 1)))
		else
			self["m_equip" .. iter_4_0 .. "QualityBg"]:setURL("")
		end
	end

	local var_4_1 = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_LINEUP) <= g.core.model.User.playerInfoData:getPlayerSnapShot().level

	if not var_4_1 then
		self.m_showTreasureController:setSelectedIndex(1)

		return
	else
		self.m_showTreasureController:setSelectedIndex(0)
	end

	for iter_4_1 = 1, 2 do
		local var_4_2 = self["m_treasure" .. iter_4_1 .. "Quality"]:getController("qualityBg")

		var_4_2:setSelectedIndex(0)

		local var_4_3 = g.core.model.User.playerInfoData:getTreasureByPos((self._knightIndex - 1) * 2 + iter_4_1)

		self["m_treasure" .. iter_4_1 .. "Level"]:updateLevel(false)

		if var_4_3 then
			local var_4_4 = var_0_5:convert({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_4_3.base_id
			})

			self["m_treasure" .. iter_4_1]:setScale(0.9)
			self["m_treasure" .. iter_4_1]:setURL(var_4_4.icon)
			var_4_2:setSelectedIndex(var_4_4.quality or 0)

			if var_4_4.quality <= 1 then
				self["m_treasure" .. iter_4_1 .. "Level"]:updateLevel(true, var_4_3.level)
			else
				self["m_treasure" .. iter_4_1 .. "Level"]:updateLevel(true, var_4_3.level, var_4_3.refining_level)

				if var_4_4.quality >= var_0_4.UR and var_4_4.value > 0 then
					self:_playTreasureEffect(iter_4_1, var_4_4.value)
				end
			end
		else
			self["m_treasure" .. iter_4_1]:setScale(1)
			self["m_treasure" .. iter_4_1]:setURL((var_0_3:getEmptyTreasurePicIconById(true)))
		end
	end

	if not self._isInit then
		if var_4_1 then
			self.m_enter_0Transition:play()
		else
			self.m_enter_1Transition:play()
		end

		self._isInit = true
	end
end

function LineUpEquipComp:_onClickItem(arg_5_1)
	local var_5_0 = arg_5_1:getSender():getName()
	local var_5_1 = 0

	var_5_1 = string.match(var_5_0, "EQUIP") and string.sub(var_5_0, 6) or string.sub(var_5_0, 9) + 4

	g.core.sound.SoundManager:playSound("UI_Click_Middle")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH, false, {
		finish = true
	})

	if not self._isOtherPlayer then
		g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_AND_TREASURE, {
			knightIndex = self._knightIndex,
			defaultPos = var_0_6[tonumber(var_5_1)]
		})
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.OTHER_EQUIP_AND_TREASURE, {
			knightIndex = self._knightIndex,
			defaultPos = var_0_6[tonumber(var_5_1)],
			knight = self._knight
		})
	end
end

function LineUpEquipComp:_playTreasureEffect(arg_6_1, arg_6_2)
	local var_6_0 = self[table.concat({
		"m_treasureEffectDown",
		arg_6_1
	}, "")]
	local var_6_1 = self[table.concat({
		"m_treasureEffect",
		arg_6_1
	}, "")]

	for iter_6_0, iter_6_1 in pairs(self._qualityEffectIcon[arg_6_1]) do
		iter_6_1:setVisible(false)
	end

	local var_6_2 = var_0_2:getTreasureDataByPos((self._knightIndex - 1) * 2 + arg_6_1)
	local var_6_3 = var_0_5:convert({
		type = g.core.common.Goods.TYPE_TREASURE,
		value = ((self._isOtherPlayer or nil) and g.core.model.User.playerInfoData:getTreasureByPos((self._knightIndex - 1) * 2 + arg_6_1)).base_id
	}).quality == var_0_4.UR and "eff_ui_treasure128_down" or "eff_ui_treasure128_downMR"

	self._qualityEffectIcon[arg_6_1][var_6_3] = self._qualityEffectIcon[arg_6_1][var_6_3] or var_6_0:addEffectSpine({
		anim = "play",
		scale = 0.8,
		isLoop = true,
		name = var_6_3
	})

	self._qualityEffectIcon[arg_6_1][var_6_3]:setVisible(true)
	var_6_0:setVisible(true)

	self._qualityEffectIcon[arg_6_1]["eff_ui_treasure128_" .. arg_6_2] = self._qualityEffectIcon[arg_6_1]["eff_ui_treasure128_" .. arg_6_2] or var_6_1:addEffectSpine({
		anim = "play",
		scale = 0.8,
		isLoop = true,
		name = "eff_ui_treasure128_" .. arg_6_2
	})

	self._qualityEffectIcon[arg_6_1]["eff_ui_treasure128_" .. arg_6_2]:setVisible(true)
	var_6_1:setVisible(true)
end

function LineUpEquipComp:_hideTreasureEffect(arg_7_1)
	self[table.concat({
		"m_treasureEffectDown",
		arg_7_1
	}, "")]:setVisible(false)
	self[table.concat({
		"m_treasureEffect",
		arg_7_1
	}, "")]:setVisible(false)
end

return LineUpEquipComp
