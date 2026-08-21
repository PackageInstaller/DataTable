local var_0_0 = class("ShipDetailLogicPanel", import("...base.BasePanel"))
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

var_0_0.EQUIPMENT_ADDITION = 0
var_0_0.TECHNOLOGY_ADDITION = 1
var_0_0.CORE_ADDITION = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1.gameObject)

	arg_1_0.skillContainer = findTF(arg_1_0._tf, "skills/content")
	arg_1_0.skillContainerHz = arg_1_0.skillContainer:GetComponent(typeof(HorizontalLayoutGroup))
	arg_1_0.skillTpl = findTF(arg_1_0.skillContainer, "skill_tpl")
	arg_1_0.attrs = findTF(arg_1_0._tf, "attrs/property")
	arg_1_0.powerTxt = findTF(arg_1_0.attrs, "power/value")
	arg_1_0.levelTxt = findTF(arg_1_0.attrs, "level_bg/level_label/Text")
	arg_1_0.levelSlider = findTF(arg_1_0.attrs, "level_bg/exp")
	arg_1_0.expInfo = findTF(arg_1_0.attrs, "level_bg/exp_info")
	arg_1_0.outline = findTF(arg_1_0.attrs, "level_bg/outline")
	arg_1_0.levelTip = findTF(arg_1_0.attrs, "level_bg/tip")
	arg_1_0.levelBg = findTF(arg_1_0.attrs, "level_bg")
	arg_1_0.expTip = findTF(arg_1_0.attrs, "level_bg/exp_tip")
	arg_1_0.armorNameTxt = arg_1_0.attrs:Find("icons"):GetChild(1):Find("name")
	var_0_3 = PLATFORM_CODE == PLATFORM_JP and var_0_2.jp or PLATFORM_CODE == PLATFORM_KR and var_0_2.kr or PLATFORM_CODE == PLATFORM_US and var_0_2.us or var_0_2.defaut

	local var_1_0 = var_0_3.sort_index

	for iter_1_0 = 1, #var_0_3.sort_index do
		local var_1_1 = findTF(arg_1_0.attrs, "props/" .. var_1_0[iter_1_0])
		local var_1_2 = findTF(arg_1_0.attrs, "icons/" .. var_1_0[iter_1_0])

		if pg.gametip["attr_" .. var_1_0[iter_1_0]].tip and string.len(pg.gametip["attr_" .. var_1_0[iter_1_0]].tip) > 0 and var_1_0[iter_1_0] ~= "armor" then
			setText(findTF(var_1_2, "name"), pg.gametip["attr_" .. var_1_0[iter_1_0]].tip)
		end

		var_1_1:SetSiblingIndex(iter_1_0 - 1)
		var_1_2:SetSiblingIndex(iter_1_0 - 1)
	end

	for iter_1_1 = 1, #var_0_3.hide do
		local var_1_3 = findTF(arg_1_0.attrs, "icons/" .. var_0_3.hide[iter_1_1])

		setActive(findTF(arg_1_0.attrs, "props/" .. var_0_3.hide[iter_1_1]), false)
		setActive(var_1_3, false)
	end

	for iter_1_2, iter_1_3 in pairs(var_0_3.prop_ignore) do
		local var_1_4 = findTF(arg_1_0.attrs, "props/" .. iter_1_2)
		local var_1_5 = findTF(arg_1_0.attrs, "icons/" .. iter_1_2)

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

function var_0_0.attach(arg_2_0, arg_2_1)
	var_0_0.super.attach(arg_2_0, arg_2_1)

	arg_2_0.evalueToggle = arg_2_0.attrs:Find("evalue_toggle")
	arg_2_0.evalueIndex = var_0_0.EQUIPMENT_ADDITION

	onToggle(arg_2_0.viewComponent, arg_2_0.evalueToggle, function()
		arg_2_0.evalueIndex = 1 - arg_2_0.evalueIndex

		arg_2_0:updateEvalues()

		return
	end)

	return
end

function var_0_0.enableEvent(arg_4_0, arg_4_1)
	arg_4_0:emit(ShipViewConst.SET_CLICK_ENABLE, arg_4_1)

	return
end

function var_0_0.flush(arg_5_0, arg_5_1)
	assert(arg_5_1, "shipVO can not be nil")

	arg_5_0.shipDataTemplate = pg.ship_data_template[arg_5_1.configId]
	arg_5_0.shipVO = arg_5_1

	arg_5_0:updateShipAttrs()
	arg_5_0:updateSKills()
	arg_5_0:updateLevelInfo()

	local var_5_0 = arg_5_1:isMaxStar()

	if not var_5_0 and arg_5_0.evalueIndex == var_0_0.TECHNOLOGY_ADDITION then
		triggerToggle(arg_5_0.evalueToggle, false)
	end

	setActive(arg_5_0.evalueToggle, var_5_0)

	return
end

function var_0_0.updateEvalues(arg_6_0)
	if not arg_6_0.additionValues then
		return
	end

	local var_6_0 = table.contains(ShipType.SubShipType, arg_6_0.shipVO:getShipType())

	for iter_6_0, iter_6_1 in pairs(arg_6_0.additionValues.transforms) do
		local var_6_1 = arg_6_0.additionValues[arg_6_0.evalueIndex][iter_6_0] or 0
		local var_6_2 = arg_6_0.shipVO:getTechNationMaxAddition(iter_6_0)

		if iter_6_0 == AttributeType.Armor or iter_6_0 == AttributeType.Expend or iter_6_0 == AttributeType.HuntingRange and var_6_0 then
			setText(iter_6_1, "")
			setActive(iter_6_1, false)

			goto label_6_0
		end

		::label_6_0::

		if arg_6_0.evalueIndex == var_0_0.EQUIPMENT_ADDITION then
			do
				local var_6_3 = COLOR_GREEN or COLOR_YELLOW

				if arg_6_0.evalueIndex == var_0_0.TECHNOLOGY_ADDITION and var_6_1 ~= var_6_2 then
					var_6_3 = "#B4BFD5FF"
				end

				setText(iter_6_1, var_6_1 == 0 and "" or setColorStr(" +" .. var_6_1, var_6_3))
				setActive(iter_6_1, var_6_1 ~= 0)
			end
		end
	end

	return
end

function var_0_0.updateShipAttrs(arg_7_0)
	arg_7_0.additionValues = {
		[var_0_0.EQUIPMENT_ADDITION] = {},
		[var_0_0.TECHNOLOGY_ADDITION] = {},
		transforms = {}
	}

	local var_7_0 = arg_7_0.shipVO
	local var_7_1 = table.contains(ShipType.SubShipType, arg_7_0.shipVO:getShipType())

	if arg_7_0.shipVO:isBluePrintShip() then
		local var_7_3 = var_7_0:getBluePrint():getShipProperties(var_7_0) or var_7_0:getShipProperties()
		local var_7_4 = var_7_2(var_7_3)
		local var_7_5, var_7_6 = var_7_0:getEquipmentProperties()
		local var_7_7 = intProperties(var_7_5)
		local var_7_8 = intProperties(var_7_6)

		FormationUI.tweenNumText(arg_7_0.powerTxt, (var_7_0:getShipCombatPower()))

		for iter_7_0, iter_7_1 in pairs(var_0_1) do
			local var_7_9 = findTF(arg_7_0.attrs, "props/" .. iter_7_0)
			local var_7_10 = findTF(arg_7_0.attrs, "icons/" .. iter_7_0)
			local var_7_11 = findTF(var_7_9, "value")
			local var_7_12 = findTF(var_7_9, "add")
			local var_7_13 = var_7_4[iter_7_1] or 0
			local var_7_14 = var_7_8[iter_7_1] or 1
			local var_7_16 = var_7_7[iter_7_1] or 0
			local var_7_17 = var_7_15((var_7_16 + var_7_13) * var_7_14) - var_7_13

			setText(var_7_11, var_7_13)

			arg_7_0.additionValues.transforms[iter_7_1] = var_7_12
			arg_7_0.additionValues[0][iter_7_1] = var_7_17
			arg_7_0.additionValues[1][iter_7_1] = var_7_0:getTechNationAddition(iter_7_1)

			if iter_7_1 == AttributeType.Armor then
				setActive(var_7_11, false)
				setActive(var_7_12, false)
				setText(arg_7_0.armorNameTxt, var_7_0:getShipArmorName())
			elseif iter_7_1 == AttributeType.Expend then
				setText(findTF(var_7_9, "value"), var_7_0:getBattleTotalExpend())
				setActive(var_7_12, false)
			elseif iter_7_1 == AttributeType.HuntingRange then
				setActive(var_7_10, var_7_1)
				setActive(var_7_9, var_7_1)

				if var_7_1 then
					setActive(var_7_11, false)
					setActive(var_7_12, false)
				end
			elseif iter_7_1 == AttributeType.AntiSub then
				setActive(var_7_10, not var_7_1)
				setActive(var_7_9, not var_7_1)
			elseif iter_7_1 == AttributeType.OxyMax or iter_7_1 == AttributeType.Ammo then
				setActive(var_7_10, var_7_1)
				setActive(var_7_9, var_7_1)

				if iter_7_1 == AttributeType.Ammo then
					setText(var_7_11, var_7_0:getShipAmmo())
				end
			end
		end

		arg_7_0:updateEvalues()

		return
	end
end

function var_0_0.updateSKills(arg_8_0)
	local var_8_0 = arg_8_0.shipVO
	local var_8_1 = Clone(arg_8_0.shipDataTemplate.buff_list_display)

	for iter_8_0 = #var_8_1 + 1, 3 do
		table.insert(var_8_1, false)
	end

	setActive(arg_8_0.skillTpl, false)

	local var_8_2 = UIItemList.New(arg_8_0.skillContainer, arg_8_0.skillTpl)

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

				arg_8_0:updateSkillTF(arg_9_2, getSkillConfig(var_8_0:RemapSkillId(var_9_0)), var_9_2)
				onButton(arg_8_0, arg_9_2, function()
					arg_8_0:emit(ShipMainMediator.ON_SKILL, var_9_1.id, var_9_2, arg_9_1 + 1)

					return
				end, SFX_PANEL)
			else
				arg_8_0:updateSkillTF(arg_9_2)
				RemoveComponent(arg_9_2, "Button")
			end
		end

		return
	end)
	var_8_2:align(#var_8_1)

	return
end

function var_0_0.updateSkillTF(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
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

		local var_11_4 = findTF(var_11_0, "level")
		local var_11_5 = "LEVEL: "

		if arg_11_3 then
			local var_11_6 = arg_11_3.level or "??"

			var_11_3(var_11_4, var_11_5 .. var_11_6)

			if false then
				setActive(var_11_0, false)
				setActive(var_11_2, true)
				setActive(var_11_1, false)
			end

			return
		end
	end
end

function var_0_0.updateLevelInfo(arg_12_0)
	setText(arg_12_0.levelTxt, arg_12_0.shipVO.level)

	local var_12_0 = arg_12_0.shipVO:getLevelExpConfig()

	if arg_12_0.shipVO.level ~= arg_12_0.shipVO:getMaxLevel() then
		setSlider(arg_12_0.levelSlider, 0, var_12_0.exp_interval, arg_12_0.shipVO.exp)
		setText(arg_12_0.expInfo, arg_12_0.shipVO.exp .. "/" .. var_12_0.exp_interval)
	else
		setSlider(arg_12_0.levelSlider, 0, 1, 1)
		setText(arg_12_0.expInfo, arg_12_0.shipVO.exp .. "/Max")
	end

	arg_12_0:updateMaxLevel(arg_12_0.shipVO)
	arg_12_0:UpdateExpTip(arg_12_0.shipVO)

	return
end

function var_0_0.UpdateExpTip(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.level >= arg_13_1.maxLevel

	setActive(arg_13_0.expTip, not arg_13_1:isReachNextMaxLevel() and not var_13_0)
	onButton(arg_13_0, arg_13_0.expTip, function()
		if arg_13_1:isActivityNpc() then
			table.insert({}, function(arg_15_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("coures_exp_npc_tip"),
					onYes = arg_15_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_13_0:emit(ShipViewConst.SHOW_EXP_ITEM_USAGE, arg_13_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateMaxLevel(arg_17_0, arg_17_1)
	if arg_17_1:isReachNextMaxLevel() then
		SetActive(arg_17_0.outline, true)
		setActive(arg_17_0.levelTip, true)
		blinkAni(arg_17_0.outline, 1.5, -1, 0.1):setFrom(1)
		blinkAni(arg_17_0.levelTip, 1.5, -1, 0.1):setFrom(1)

		local var_17_0 = arg_17_1:getNextMaxLevelConsume()
		local var_17_1 = arg_17_1:getMaxLevel()
		local var_17_2 = arg_17_1:getNextMaxLevel()

		onButton(arg_17_0, arg_17_0.levelBg, function()
			if arg_17_1:isActivityNpc() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("npc_upgrade_max_level"))

				return
			end

			arg_17_0:emit(ShipViewConst.SHOW_CUSTOM_MSG, {
				content = i18n("upgrade_to_next_maxlevel_tip"),
				content1 = var_17_1 .. "->" .. var_17_2,
				items = var_17_0,
				onYes = function()
					local var_19_0, var_19_1 = arg_17_1:canUpgradeMaxLevel()

					if var_19_0 then
						arg_17_0:emit(ShipViewConst.HIDE_CUSTOM_MSG)
						arg_17_0:emit(ShipMainMediator.ON_UPGRADE_MAX_LEVEL, arg_17_1.id)
					else
						pg.TipsMgr.GetInstance():ShowTips(var_19_1)
					end

					return
				end
			})

			return
		end, SFX_PANEL)
	else
		arg_17_0:removeLevelUpTip()
	end

	return
end

function var_0_0.removeLevelUpTip(arg_20_0)
	SetActive(arg_20_0.outline, false)
	setActive(arg_20_0.levelTip, false)

	if LeanTween.isTweening(go(arg_20_0.outline)) then
		LeanTween.cancel(go(arg_20_0.outline))
	end

	if LeanTween.isTweening(go(arg_20_0.levelTip)) then
		LeanTween.cancel(go(arg_20_0.levelTip))
	end

	removeOnButton(arg_20_0.levelBg)

	return
end

function var_0_0.doLeveUpAnim(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0:removeLevelUpTip()
	arg_21_0:enableEvent(false)

	local var_21_0 = {}

	if arg_21_1.level < arg_21_2.level then
		local var_21_1 = arg_21_1:getLevelExpConfig()

		for iter_21_0 = 1, arg_21_2.level - arg_21_1.level do
			table.insert(var_21_0, function(arg_22_0)
				TweenValue(arg_21_0.levelSlider, 0, var_21_1.exp_interval, var_0_4, 0, function(arg_23_0)
					setSlider(arg_21_0.levelSlider, 0, var_21_1.exp_interval, arg_23_0)
					setText(arg_21_0.expInfo, math.floor(arg_23_0) .. "/" .. var_21_1.exp_interval)

					return
				end, function()
					local var_24_0 = Clone(arg_21_1)

					arg_21_1.level = arg_21_1.level + 1
					var_21_1 = arg_21_1:getLevelExpConfig()

					arg_21_0:scaleAnim(arg_21_0.levelTxt, var_0_5, var_0_6, var_0_4 / 2, function()
						if arg_21_1.level == arg_21_2.level then
							arg_21_0:doAttrAnim(var_24_0, arg_21_2, function()
								TweenValue(arg_21_0.levelSlider, 0, arg_21_2.exp, var_0_4, 0, function(arg_27_0)
									setSlider(arg_21_0.levelSlider, 0, var_21_1.exp_interval, arg_27_0)
									setText(arg_21_0.expInfo, math.floor(arg_27_0) .. "/" .. var_21_1.exp_interval)

									return
								end, arg_22_0)

								return
							end)
						else
							arg_21_0:doAttrAnim(var_24_0, arg_21_1, arg_22_0)
						end

						return
					end, function()
						setText(arg_21_0.levelTxt, arg_21_1.level)

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
				TweenValue(arg_21_0.levelSlider, arg_21_1.exp, arg_21_2.exp, var_0_4, 0, function(arg_30_0)
					setSlider(arg_21_0.levelSlider, 0, var_21_2.exp_interval, arg_30_0)
					setText(arg_21_0.expInfo, math.floor(arg_30_0) .. "/" .. var_21_2.exp_interval)

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

		arg_21_0:enableEvent(true)

		return
	end)

	return
end

function var_0_0.doAttrAnim(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = intProperties(arg_32_1:getShipProperties())
	local var_32_1, var_32_2 = arg_32_1:getEquipmentProperties()
	local var_32_3 = intProperties(arg_32_2:getShipProperties())
	local var_32_4, var_32_5 = arg_32_2:getEquipmentProperties()
	local var_32_6 = intProperties(var_32_1)
	local var_32_7 = intProperties(var_32_2)
	local var_32_8 = intProperties(var_32_4)
	local var_32_9 = intProperties(var_32_5)
	local var_32_10 = {}

	if arg_32_1:getShipCombatPower() ~= arg_32_2:getShipCombatPower() then
		table.insert(var_32_10, function(arg_33_0)
			TweenValue(arg_32_0.powerTxt, var_0, var_0, var_0_4, 0, function(arg_34_0)
				setText(arg_32_0.powerTxt, math.floor(arg_34_0))

				return
			end, arg_33_0)

			return
		end)
	end

	for iter_32_0, iter_32_1 in pairs(var_0_1) do
		local var_32_11 = findTF(arg_32_0.attrs, "props/" .. iter_32_0) or findTF(arg_32_0.attrs, "prop_" .. iter_32_0)
		local var_32_12 = findTF(arg_32_0.attrs, "icons/" .. iter_32_0) or findTF(arg_32_0.attrs, "icon_" .. iter_32_0)
		local var_32_13 = findTF(var_32_11, "value")
		local var_32_14 = findTF(var_32_11, "add")
		local var_32_15 = var_32_0[iter_32_1] or 0
		local var_32_16 = var_32_7[iter_32_1] or 1
		local var_32_17 = var_32_3[iter_32_1] or 0
		local var_32_18 = var_32_9[iter_32_1] or 1
		local var_32_19
		local var_32_20

		if arg_32_0.evalueIndex == var_0_0.EQUIPMENT_ADDITION then
			local var_32_21 = var_32_6[iter_32_1] or 0

			var_32_19 = calcFloor((var_32_21 + var_32_15) * var_32_16) - var_32_15

			local var_32_22 = var_32_8[iter_32_1] or 0

			var_32_20 = calcFloor((var_32_22 + var_32_17) * var_32_18) - var_32_17
		elseif arg_32_0.evalueIndex == var_0_0.TECHNOLOGY_ADDITION then
			var_32_19 = arg_32_1:getTechNationAddition(iter_32_1)
			var_32_20 = arg_32_2:getTechNationAddition(iter_32_1)
		end

		if var_32_15 ~= 0 then
			table.insert(var_32_10, function(arg_35_0)
				TweenValue(var_32_13, var_32_15, var_32_17, var_0_4, 0, function(arg_36_0)
					setText(var_32_13, math.floor(arg_36_0))

					return
				end, arg_35_0)
				arg_32_0:scaleAnim(var_32_13, var_0_5, var_0_6, var_0_4 / 2)

				return
			end)
		end

		if var_32_19 < var_32_20 then
			local var_32_23 = arg_32_0.evalueIndex == var_0_0.EQUIPMENT_ADDITION and COLOR_GREEN or COLOR_YELLOW

			table.insert(var_32_10, function(arg_37_0)
				TweenValue(var_32_14, var_32_19, var_32_20, var_0_4, 0, function(arg_38_0)
					setText(var_32_14, setColorStr("+" .. math.floor(arg_38_0), var_32_23))

					return
				end, arg_37_0)
				arg_32_0:scaleAnim(var_32_14, var_0_5, var_0_6, var_0_4 / 2)

				return
			end)
		end

		setActive(var_32_14, var_32_20 ~= 0)

		if iter_32_1 == AttributeType.Armor then
			setActive(var_32_13, false)
			setActive(var_32_14, false)
			setText(arg_32_0.armorNameTxt, arg_32_2:getShipArmorName())
		elseif iter_32_1 == AttributeType.Expend then
			local var_32_24 = findTF(var_32_11, "value")

			if arg_32_1:getBattleTotalExpend() ~= arg_32_2:getBattleTotalExpend() then
				table.insert(var_32_10, function(arg_39_0)
					TweenValue(var_32_24, var_0, var_0, var_0_4, 0, function(arg_40_0)
						setText(var_32_24, math.floor(arg_40_0))

						return
					end, arg_39_0)
					arg_32_0:scaleAnim(var_32_24, var_0_5, var_0_6, var_0_4 / 2)

					return
				end)
			end

			setActive(var_32_14, false)
		elseif iter_32_1 == AttributeType.OxyMax or iter_32_1 == AttributeType.Tactics then
			local var_32_25 = table.contains(ShipType.SubShipType, arg_32_2:getShipType())

			setActive(var_32_12, var_32_25)
			setActive(var_32_11, var_32_25)

			if var_32_25 and iter_32_1 == AttributeType.Tactics then
				local var_32_26, var_32_27 = arg_32_2:getTactics()

				setActive(var_32_13, false)
				setActive(var_32_14, true)
				setText(var_32_14, i18n(var_32_27))
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

function var_0_0.scaleAnim(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	LeanTween.scale(go(arg_42_1), arg_42_3, arg_42_4):setFrom(arg_42_2):setOnComplete(System.Action(function()
		if arg_42_6 then
			arg_42_6()
		end

		LeanTween.scale(go(arg_42_1), arg_42_2, arg_42_4):setFrom(arg_42_3):setOnComplete(System.Action(arg_42_5))

		return
	end))

	return
end

function var_0_0.clear(arg_44_0)
	triggerToggle(arg_44_0.evalueToggle, false)

	if LeanTween.isTweening(go(arg_44_0.levelSlider)) then
		LeanTween.cancel(go(arg_44_0.levelSlider))
	end

	if LeanTween.isTweening(go(arg_44_0.powerTxt)) then
		LeanTween.cancel(go(arg_44_0.powerTxt))
	end

	if LeanTween.isTweening(go(arg_44_0.expInfo)) then
		LeanTween.cancel(go(arg_44_0.expInfo))
	end

	arg_44_0:removeLevelUpTip()

	arg_44_0.additionValues = nil

	return
end

return var_0_0
