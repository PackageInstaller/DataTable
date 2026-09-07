local ShipDetailLogicPanel = class("ShipDetailLogicPanel", import("...base.BasePanel"))
local var_0_1 = {
	durability = AttributeType.Durability,
	armor = AttributeType.Armor,
	reload = AttributeType.Reload,
	cannon = AttributeType.Cannon,
	torpedo = AttributeType.Torpedo,
	motion = AttributeType.Dodge,
	antiaircraft = AttributeType.AntiAircraft,
	air = AttributeType.Air,
	hit = AttributeType.Hit,
	antisub = AttributeType.AntiSub,
	oxy_max = AttributeType.OxyMax,
	ammo = AttributeType.Ammo,
	hunting_range = AttributeType.HuntingRange,
	luck = AttributeType.Luck,
	consume = AttributeType.Expend,
	speed = AttributeType.Speed
}
local var_0_2 = {
	us = {
		prop_ignore = {
			luck = {
				134,
				-260,
				134,
				-260
			},
			consume = {
				417,
				-260,
				431,
				-260
			},
			hunting_range = {
				622,
				-260,
				639,
				-260
			}
		},
		sort_index = {
			"durability",
			"armor",
			"reload",
			"cannon",
			"torpedo",
			"motion",
			"antiaircraft",
			"air",
			"hit",
			"consume",
			"antisub",
			"oxy_max",
			"ammo",
			"speed",
			"hunting_range",
			"luck"
		},
		hide = {}
	},
	jp = {
		prop_ignore = {
			luck = {
				137,
				-260,
				151,
				-260
			},
			consume = {
				417,
				-260,
				431,
				-260
			},
			hunting_range = {
				622,
				-260,
				639,
				-260
			}
		},
		sort_index = {
			"durability",
			"armor",
			"reload",
			"cannon",
			"torpedo",
			"motion",
			"antiaircraft",
			"air",
			"hit",
			"consume",
			"antisub",
			"oxy_max",
			"ammo",
			"speed",
			"hunting_range",
			"luck"
		},
		hide = {}
	},
	kr = {
		prop_ignore = {
			luck = {
				137,
				-260,
				151,
				-260
			},
			consume = {
				417,
				-260,
				431,
				-260
			},
			hunting_range = {
				622,
				-260,
				639,
				-260
			}
		},
		sort_index = {
			"durability",
			"armor",
			"reload",
			"cannon",
			"torpedo",
			"motion",
			"antiaircraft",
			"air",
			"hit",
			"consume",
			"antisub",
			"oxy_max",
			"ammo",
			"speed",
			"hunting_range",
			"luck"
		},
		hide = {}
	},
	defaut = {
		prop_ignore = {
			luck = {
				137,
				-260,
				151,
				-260
			},
			consume = {
				417,
				-260,
				431,
				-260
			},
			hunting_range = {
				622,
				-260,
				639,
				-260
			}
		},
		sort_index = {
			"durability",
			"armor",
			"reload",
			"cannon",
			"torpedo",
			"motion",
			"antiaircraft",
			"air",
			"hit",
			"antisub",
			"oxy_max",
			"ammo",
			"speed",
			"hunting_range",
			"luck",
			"consume"
		},
		hide = {}
	}
}
local var_0_3
local var_0_4 = 0.5
local var_0_5 = Vector3(1, 1, 1)
local var_0_6 = Vector3(1.3, 1.3, 1.3)

ShipDetailLogicPanel.EQUIPMENT_ADDITION = 0
ShipDetailLogicPanel.TECHNOLOGY_ADDITION = 1
ShipDetailLogicPanel.CORE_ADDITION = 2

function ShipDetailLogicPanel:Ctor(arg_1_1)
	ShipDetailLogicPanel.super.Ctor(self, arg_1_1.gameObject)

	self.skillContainer = findTF(self._tf, "skills/content")
	self.skillContainerHz = self.skillContainer:GetComponent(typeof(HorizontalLayoutGroup))
	self.skillTpl = findTF(self.skillContainer, "skill_tpl")
	self.attrs = findTF(self._tf, "attrs/property")
	self.powerTxt = findTF(self.attrs, "power/value")
	self.levelTxt = findTF(self.attrs, "level_bg/level_label/Text")
	self.levelSlider = findTF(self.attrs, "level_bg/exp")
	self.expInfo = findTF(self.attrs, "level_bg/exp_info")
	self.outline = findTF(self.attrs, "level_bg/outline")
	self.levelTip = findTF(self.attrs, "level_bg/tip")
	self.levelBg = findTF(self.attrs, "level_bg")
	self.expTip = findTF(self.attrs, "level_bg/exp_tip")
	self.armorNameTxt = self.attrs:Find("icons"):GetChild(1):Find("name")
	var_0_3 = PLATFORM_CODE == PLATFORM_JP and var_0_2.jp or PLATFORM_CODE == PLATFORM_KR and var_0_2.kr or PLATFORM_CODE == PLATFORM_US and var_0_2.us or var_0_2.defaut

	local var_1_0 = var_0_3.sort_index

	for iter_1_0 = 1, #var_0_3.sort_index do
		local var_1_1 = findTF(self.attrs, "props/" .. var_1_0[iter_1_0])
		local var_1_2 = findTF(self.attrs, "icons/" .. var_1_0[iter_1_0])

		if pg.gametip["attr_" .. var_1_0[iter_1_0]].tip and string.len(pg.gametip["attr_" .. var_1_0[iter_1_0]].tip) > 0 and var_1_0[iter_1_0] ~= "armor" then
			setText(findTF(var_1_2, "name"), pg.gametip["attr_" .. var_1_0[iter_1_0]].tip)
		end

		var_1_1:SetSiblingIndex(iter_1_0 - 1)
		var_1_2:SetSiblingIndex(iter_1_0 - 1)
	end

	for iter_1_1 = 1, #var_0_3.hide do
		local var_1_3 = findTF(self.attrs, "icons/" .. var_0_3.hide[iter_1_1])

		setActive(findTF(self.attrs, "props/" .. var_0_3.hide[iter_1_1]), false)
		setActive(var_1_3, false)
	end

	for iter_1_2, iter_1_3 in pairs(var_0_3.prop_ignore) do
		local var_1_4 = findTF(self.attrs, "props/" .. iter_1_2)
		local var_1_5 = findTF(self.attrs, "icons/" .. iter_1_2)

		GetOrAddComponent(var_1_4, typeof(LayoutElement)).ignoreLayout = true
		GetOrAddComponent(var_1_5, typeof(LayoutElement)).ignoreLayout = true
		var_1_4.anchorMax = Vector2(0, 1)
		var_1_4.anchorMin = Vector2(0, 1)
		var_1_5.anchorMax = Vector2(0, 1)
		var_1_5.anchorMin = Vector2(0, 1)
		var_1_4.anchoredPosition = Vector2(iter_1_3[3], iter_1_3[4])
		var_1_5.anchoredPosition = Vector2(iter_1_3[1], iter_1_3[2])
	end

	return
end

function ShipDetailLogicPanel:attach(arg_2_1)
	ShipDetailLogicPanel.super.attach(self, arg_2_1)

	self.evalueToggle = self.attrs:Find("evalue_toggle")
	self.evalueIndex = ShipDetailLogicPanel.EQUIPMENT_ADDITION

	onToggle(self.viewComponent, self.evalueToggle, function()
		self.evalueIndex = 1 - self.evalueIndex

		self:updateEvalues()

		return
	end)

	return
end

function ShipDetailLogicPanel:enableEvent(arg_4_1)
	self:emit(ShipViewConst.SET_CLICK_ENABLE, arg_4_1)

	return
end

function ShipDetailLogicPanel:flush(arg_5_1)
	assert(arg_5_1, "shipVO can not be nil")

	self.shipDataTemplate = pg.ship_data_template[arg_5_1.configId]
	self.shipVO = arg_5_1

	self:updateShipAttrs()
	self:updateSKills()
	self:updateLevelInfo()

	local var_5_0 = arg_5_1:isMaxStar()

	if not var_5_0 and self.evalueIndex == ShipDetailLogicPanel.TECHNOLOGY_ADDITION then
		triggerToggle(self.evalueToggle, false)
	end

	setActive(self.evalueToggle, var_5_0)

	return
end

function ShipDetailLogicPanel:updateEvalues()
	if not self.additionValues then
		return
	end

	local var_6_0 = table.contains(ShipType.SubShipType, self.shipVO:getShipType())

	for iter_6_0, iter_6_1 in pairs(self.additionValues.transforms) do
		if iter_6_0 == AttributeType.Armor or iter_6_0 == AttributeType.Expend or iter_6_0 == AttributeType.HuntingRange and var_6_0 then
			setText(iter_6_1, "")
			setActive(iter_6_1, false)
		else
			local var_6_1 = self.additionValues[self.evalueIndex][iter_6_0] or 0
			local var_6_2

			if self.evalueIndex == ShipDetailLogicPanel.EQUIPMENT_ADDITION then
				var_6_2 = COLOR_GREEN or COLOR_YELLOW

				if self.evalueIndex == ShipDetailLogicPanel.TECHNOLOGY_ADDITION and var_6_1 ~= self.shipVO:getTechNationMaxAddition(iter_6_0) then
					var_6_2 = "#B4BFD5FF"
				end
			end

			setText(iter_6_1, var_6_1 == 0 and "" or setColorStr(" +" .. var_6_1, var_6_2))
			setActive(iter_6_1, var_6_1 ~= 0)
		end
	end

	return
end

function ShipDetailLogicPanel:updateShipAttrs()
	self.additionValues = {
		[ShipDetailLogicPanel.EQUIPMENT_ADDITION] = {},
		[ShipDetailLogicPanel.TECHNOLOGY_ADDITION] = {},
		transforms = {}
	}

	local var_7_0 = self.shipVO
	local var_7_1 = table.contains(ShipType.SubShipType, self.shipVO:getShipType())
	local var_7_3 = intProperties((self.shipVO:isBluePrintShip() or nil) and (var_7_0:getBluePrint():getShipProperties(var_7_0) or var_7_0:getShipProperties()))
	local var_7_4, var_7_5 = var_7_0:getEquipmentProperties()
	local var_7_6 = intProperties(var_7_4)
	local var_7_7 = intProperties(var_7_5)

	FormationUI.tweenNumText(self.powerTxt, (var_7_0:getShipCombatPower()))

	for iter_7_0, iter_7_1 in pairs(var_0_1) do
		local var_7_8 = findTF(self.attrs, "props/" .. iter_7_0)
		local var_7_9 = findTF(self.attrs, "icons/" .. iter_7_0)
		local var_7_10 = findTF(var_7_8, "value")
		local var_7_11 = findTF(var_7_8, "add")
		local var_7_12 = var_7_3[iter_7_1] or 0
		local var_7_13 = calcFloor(((var_7_6[iter_7_1] or 0) + var_7_12) * (var_7_7[iter_7_1] or 1)) - var_7_12

		setText(var_7_10, var_7_12)

		self.additionValues.transforms[iter_7_1] = var_7_11
		self.additionValues[0][iter_7_1] = var_7_13
		self.additionValues[1][iter_7_1] = var_7_0:getTechNationAddition(iter_7_1)

		if iter_7_1 == AttributeType.Armor then
			setActive(var_7_10, false)
			setActive(var_7_11, false)
			setText(self.armorNameTxt, var_7_0:getShipArmorName())
		elseif iter_7_1 == AttributeType.Expend then
			setText(findTF(var_7_8, "value"), var_7_0:getBattleTotalExpend())
			setActive(var_7_11, false)
		elseif iter_7_1 == AttributeType.HuntingRange then
			setActive(var_7_9, var_7_1)
			setActive(var_7_8, var_7_1)

			if var_7_1 then
				setActive(var_7_10, false)
				setActive(var_7_11, false)
			end
		elseif iter_7_1 == AttributeType.AntiSub then
			setActive(var_7_9, not var_7_1)
			setActive(var_7_8, not var_7_1)
		elseif iter_7_1 == AttributeType.OxyMax or iter_7_1 == AttributeType.Ammo then
			setActive(var_7_9, var_7_1)
			setActive(var_7_8, var_7_1)

			if iter_7_1 == AttributeType.Ammo then
				setText(var_7_10, var_7_0:getShipAmmo())
			end
		end
	end

	self:updateEvalues()

	return
end

function ShipDetailLogicPanel:updateSKills()
	local var_8_0 = self.shipVO
	local var_8_1 = Clone(self.shipDataTemplate.buff_list_display)

	for iter_8_0 = #var_8_1 + 1, 3 do
		table.insert(var_8_1, false)
	end

	setActive(self.skillTpl, false)

	local var_8_2 = UIItemList.New(self.skillContainer, self.skillTpl)

	var_8_2:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			if var_8_1[arg_9_1 + 1] then
				local var_9_0 = var_8_0:fateSkillChange(var_8_1[arg_9_1 + 1])
				local var_9_1 = getSkillConfig(var_8_0:RemapSkillId(var_9_0))
				local var_9_2 = var_8_0.skills[var_9_0]

				if var_8_0.skills[var_9_0] and var_9_2.id == 11720 and not var_8_0.transforms[3612] then
					var_9_2 = nil
				end

				if var_9_2 and var_9_2.id == 14900 and not var_8_0.transforms[16412] then
					var_9_2 = nil
				end

				self:updateSkillTF(arg_9_2, var_9_1, var_9_2)
				onButton(self, arg_9_2, function()
					self:emit(ShipMainMediator.ON_SKILL, var_9_1.id, var_9_2, arg_9_1 + 1)

					return
				end, SFX_PANEL)
			else
				self:updateSkillTF(arg_9_2)
				RemoveComponent(arg_9_2, "Button")
			end
		end

		return
	end)
	var_8_2:align(#var_8_1)

	return
end

function ShipDetailLogicPanel:updateSkillTF(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = findTF(arg_11_1, "skill")
	local var_11_1 = findTF(arg_11_1, "lock")
	local var_11_2 = findTF(arg_11_1, "unknown")

	if arg_11_2 then
		setActive(var_11_0, true)
		setActive(var_11_2, false)
		setActive(var_11_1, not arg_11_3)
		LoadImageSpriteAsync("skillicon/" .. arg_11_2.icon, findTF(var_11_0, "icon"))

		findTF(var_11_0, "mask/name").anchoredPosition = Vector2(0, 0)

		setScrollText(findTF(var_11_0, "mask/name"), getSkillName(arg_11_2.id))
		setText(findTF(var_11_0, "level"), "LEVEL: " .. ((arg_11_3 or nil) and (arg_11_3.level or "??")))
	else
		setActive(var_11_0, false)
		setActive(var_11_2, true)
		setActive(var_11_1, false)
	end

	return
end

function ShipDetailLogicPanel:updateLevelInfo()
	setText(self.levelTxt, self.shipVO.level)

	local var_12_0 = self.shipVO:getLevelExpConfig()

	if self.shipVO.level ~= self.shipVO:getMaxLevel() then
		setSlider(self.levelSlider, 0, var_12_0.exp_interval, self.shipVO.exp)
		setText(self.expInfo, self.shipVO.exp .. "/" .. var_12_0.exp_interval)
	else
		setSlider(self.levelSlider, 0, 1, 1)
		setText(self.expInfo, self.shipVO.exp .. "/Max")
	end

	self:updateMaxLevel(self.shipVO)
	self:UpdateExpTip(self.shipVO)

	return
end

function ShipDetailLogicPanel:UpdateExpTip(arg_13_1)
	setActive(self.expTip, not arg_13_1:isReachNextMaxLevel() and not (arg_13_1.level >= arg_13_1.maxLevel))
	onButton(self, self.expTip, function()
		local var_14_0 = {}

		if arg_13_1:isActivityNpc() then
			table.insert(var_14_0, function(arg_15_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("coures_exp_npc_tip"),
					onYes = arg_15_0
				})

				return
			end)
		end

		seriesAsync(var_14_0, function()
			self:emit(ShipViewConst.SHOW_EXP_ITEM_USAGE, arg_13_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function ShipDetailLogicPanel:updateMaxLevel(arg_17_1)
	if arg_17_1:isReachNextMaxLevel() then
		SetActive(self.outline, true)
		setActive(self.levelTip, true)
		blinkAni(self.outline, 1.5, -1, 0.1):setFrom(1)
		blinkAni(self.levelTip, 1.5, -1, 0.1):setFrom(1)

		local var_17_0 = arg_17_1:getNextMaxLevelConsume()
		local var_17_1 = arg_17_1:getMaxLevel()
		local var_17_2 = arg_17_1:getNextMaxLevel()

		onButton(self, self.levelBg, function()
			if arg_17_1:isActivityNpc() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("npc_upgrade_max_level"))

				return
			end

			self:emit(ShipViewConst.SHOW_CUSTOM_MSG, {
				content = i18n("upgrade_to_next_maxlevel_tip"),
				content1 = var_17_1 .. "->" .. var_17_2,
				items = var_17_0,
				onYes = function()
					local var_19_0, var_19_1 = arg_17_1:canUpgradeMaxLevel()

					if var_19_0 then
						self:emit(ShipViewConst.HIDE_CUSTOM_MSG)
						self:emit(ShipMainMediator.ON_UPGRADE_MAX_LEVEL, arg_17_1.id)
					else
						pg.TipsMgr.GetInstance():ShowTips(var_19_1)
					end

					return
				end
			})

			return
		end, SFX_PANEL)
	else
		self:removeLevelUpTip()
	end

	return
end

function ShipDetailLogicPanel:removeLevelUpTip()
	SetActive(self.outline, false)
	setActive(self.levelTip, false)

	if LeanTween.isTweening(go(self.outline)) then
		LeanTween.cancel(go(self.outline))
	end

	if LeanTween.isTweening(go(self.levelTip)) then
		LeanTween.cancel(go(self.levelTip))
	end

	removeOnButton(self.levelBg)

	return
end

function ShipDetailLogicPanel:doLeveUpAnim(arg_21_1, arg_21_2, arg_21_3)
	self:removeLevelUpTip()
	self:enableEvent(false)

	local var_21_0 = {}

	if arg_21_1.level < arg_21_2.level then
		local var_21_1 = arg_21_1:getLevelExpConfig()

		for iter_21_0 = 1, arg_21_2.level - arg_21_1.level do
			table.insert(var_21_0, function(arg_22_0)
				TweenValue(self.levelSlider, 0, var_21_1.exp_interval, var_0_4, 0, function(arg_23_0)
					setSlider(self.levelSlider, 0, var_21_1.exp_interval, arg_23_0)
					setText(self.expInfo, math.floor(arg_23_0) .. "/" .. var_21_1.exp_interval)

					return
				end, function()
					local var_24_0 = Clone(arg_21_1)

					arg_21_1.level = arg_21_1.level + 1
					var_21_1 = arg_21_1:getLevelExpConfig()

					self:scaleAnim(self.levelTxt, var_0_5, var_0_6, var_0_4 / 2, function()
						if arg_21_1.level == arg_21_2.level then
							self:doAttrAnim(var_24_0, arg_21_2, function()
								TweenValue(self.levelSlider, 0, arg_21_2.exp, var_0_4, 0, function(arg_27_0)
									setSlider(self.levelSlider, 0, var_21_1.exp_interval, arg_27_0)
									setText(self.expInfo, math.floor(arg_27_0) .. "/" .. var_21_1.exp_interval)

									return
								end, arg_22_0)

								return
							end)
						else
							self:doAttrAnim(var_24_0, arg_21_1, arg_22_0)
						end

						return
					end, function()
						setText(self.levelTxt, arg_21_1.level)

						return
					end)

					return
				end)

				return
			end)
		end
	else
		local var_21_2 = arg_21_2:getLevelExpConfig()

		if arg_21_2.exp > arg_21_1.exp then
			table.insert(var_21_0, function(arg_29_0)
				TweenValue(self.levelSlider, arg_21_1.exp, arg_21_2.exp, var_0_4, 0, function(arg_30_0)
					setSlider(self.levelSlider, 0, var_21_2.exp_interval, arg_30_0)
					setText(self.expInfo, math.floor(arg_30_0) .. "/" .. var_21_2.exp_interval)

					return
				end, arg_29_0)

				return
			end)
		end
	end

	seriesAsync(var_21_0, function()
		if arg_21_3 then
			arg_21_3()
		end

		self:enableEvent(true)

		return
	end)

	return
end

function ShipDetailLogicPanel:doAttrAnim(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = intProperties(arg_32_1:getShipProperties())
	local var_32_1, var_32_2 = arg_32_1:getEquipmentProperties()
	local var_32_3 = intProperties(arg_32_2:getShipProperties())
	local var_32_4, var_32_5 = arg_32_2:getEquipmentProperties()
	local var_32_6 = intProperties(var_32_1)
	local var_32_7 = intProperties(var_32_2)
	local var_32_8 = intProperties(var_32_4)
	local var_32_9 = intProperties(var_32_5)
	local var_32_10 = {}
	local var_32_11 = arg_32_2:getShipCombatPower()
	local var_32_12 = arg_32_1:getShipCombatPower()

	if var_32_12 ~= var_32_11 then
		table.insert(var_32_10, function(arg_33_0)
			TweenValue(self.powerTxt, var_32_12, var_32_11, var_0_4, 0, function(arg_34_0)
				setText(self.powerTxt, math.floor(arg_34_0))

				return
			end, arg_33_0)

			return
		end)
	end

	for iter_32_0, iter_32_1 in pairs(var_0_1) do
		local var_32_13 = findTF(self.attrs, "props/" .. iter_32_0) or findTF(self.attrs, "prop_" .. iter_32_0)
		local var_32_14 = findTF(self.attrs, "icons/" .. iter_32_0) or findTF(self.attrs, "icon_" .. iter_32_0)
		local var_32_15 = findTF(var_32_13, "value")
		local var_32_16 = findTF(var_32_13, "add")
		local var_32_17 = var_32_0[iter_32_1] or 0
		local var_32_18 = var_32_3[iter_32_1] or 0
		local var_32_19
		local var_32_20

		if self.evalueIndex == ShipDetailLogicPanel.EQUIPMENT_ADDITION then
			var_32_19 = calcFloor(((var_32_6[iter_32_1] or 0) + var_32_17) * (var_32_7[iter_32_1] or 1)) - var_32_17
			var_32_20 = calcFloor(((var_32_8[iter_32_1] or 0) + var_32_18) * (var_32_9[iter_32_1] or 1)) - var_32_18
		elseif self.evalueIndex == ShipDetailLogicPanel.TECHNOLOGY_ADDITION then
			var_32_19 = arg_32_1:getTechNationAddition(iter_32_1)
			var_32_20 = arg_32_2:getTechNationAddition(iter_32_1)
		end

		if var_32_17 ~= 0 then
			table.insert(var_32_10, function(arg_35_0)
				TweenValue(var_32_15, var_32_17, var_32_18, var_0_4, 0, function(arg_36_0)
					setText(var_32_15, math.floor(arg_36_0))

					return
				end, arg_35_0)
				self:scaleAnim(var_32_15, var_0_5, var_0_6, var_0_4 / 2)

				return
			end)
		end

		if var_32_19 < var_32_20 then
			if self.evalueIndex == ShipDetailLogicPanel.EQUIPMENT_ADDITION then
				local var_32_22 = COLOR_GREEN or COLOR_YELLOW
			end

			table.insert(var_32_10, function(arg_37_0)
				TweenValue(var_32_16, var_32_19, var_32_20, var_0_4, 0, function(arg_38_0)
					setText(var_32_16, setColorStr("+" .. math.floor(arg_38_0), var_32_22))

					return
				end, arg_37_0)
				self:scaleAnim(var_32_16, var_0_5, var_0_6, var_0_4 / 2)

				return
			end)
		end

		setActive(var_32_16, var_32_20 ~= 0)

		if iter_32_1 == AttributeType.Armor then
			setActive(var_32_15, false)
			setActive(var_32_16, false)
			setText(self.armorNameTxt, arg_32_2:getShipArmorName())
		elseif iter_32_1 == AttributeType.Expend then
			local var_32_23 = arg_32_2:getBattleTotalExpend()
			local var_32_24 = arg_32_1:getBattleTotalExpend()
			local var_32_25 = findTF(var_32_13, "value")

			if var_32_24 ~= var_32_23 then
				table.insert(var_32_10, function(arg_39_0)
					TweenValue(var_32_25, var_32_24, var_32_23, var_0_4, 0, function(arg_40_0)
						setText(var_32_25, math.floor(arg_40_0))

						return
					end, arg_39_0)
					self:scaleAnim(var_32_25, var_0_5, var_0_6, var_0_4 / 2)

					return
				end)
			end

			setActive(var_32_16, false)
		elseif iter_32_1 == AttributeType.OxyMax or iter_32_1 == AttributeType.Tactics then
			local var_32_26 = table.contains(ShipType.SubShipType, arg_32_2:getShipType())

			setActive(var_32_14, var_32_26)
			setActive(var_32_13, var_32_26)

			if var_32_26 and iter_32_1 == AttributeType.Tactics then
				local var_32_27, var_32_28 = arg_32_2:getTactics()

				setActive(var_32_15, false)
				setActive(var_32_16, true)
				setText(var_32_16, i18n(var_32_28))
			end
		end
	end

	parallelAsync(var_32_10, function()
		if arg_32_3 then
			arg_32_3()
		end

		return
	end)

	return
end

function ShipDetailLogicPanel:scaleAnim(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	LeanTween.scale(go(arg_42_1), arg_42_3, arg_42_4):setFrom(arg_42_2):setOnComplete(System.Action(function()
		if arg_42_6 then
			arg_42_6()
		end

		LeanTween.scale(go(arg_42_1), arg_42_2, arg_42_4):setFrom(arg_42_3):setOnComplete(System.Action(arg_42_5))

		return
	end))

	return
end

function ShipDetailLogicPanel:clear()
	triggerToggle(self.evalueToggle, false)

	if LeanTween.isTweening(go(self.levelSlider)) then
		LeanTween.cancel(go(self.levelSlider))
	end

	if LeanTween.isTweening(go(self.powerTxt)) then
		LeanTween.cancel(go(self.powerTxt))
	end

	if LeanTween.isTweening(go(self.expInfo)) then
		LeanTween.cancel(go(self.expInfo))
	end

	self:removeLevelUpTip()

	self.additionValues = nil

	return
end

return ShipDetailLogicPanel
