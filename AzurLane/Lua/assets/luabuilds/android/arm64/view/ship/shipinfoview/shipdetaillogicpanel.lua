class = var_0_10000

local var_0_0 = "ShipDetailLogicPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BasePanel"))
local var_0_2 = {}

AttributeType = var_0_0
var_0_2.durability = var_0_0.Durability
AttributeType = var_2
var_0_2.armor = var_2.Armor
AttributeType = var_2
var_0_2.reload = var_2.Reload
AttributeType = var_2
var_0_2.cannon = var_2.Cannon
AttributeType = var_2
var_0_2.torpedo = var_2.Torpedo
AttributeType = var_2
var_0_2.motion = var_2.Dodge
AttributeType = var_2
var_0_2.antiaircraft = var_2.AntiAircraft
AttributeType = var_2
var_0_2.air = var_2.Air
AttributeType = var_2
var_0_2.hit = var_2.Hit
AttributeType = var_2
var_0_2.antisub = var_2.AntiSub
AttributeType = var_2
var_0_2.oxy_max = var_2.OxyMax
AttributeType = var_2
var_0_2.ammo = var_2.Ammo
AttributeType = var_2
var_0_2.hunting_range = var_2.HuntingRange
AttributeType = var_2
var_0_2.luck = var_2.Luck
AttributeType = var_2
var_0_2.consume = var_2.Expend
AttributeType = var_2
var_0_2.speed = var_2.Speed

local var_0_3 = {
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
local var_0_4
local var_0_5 = 0.5

Vector3 = var_5

local var_0_6 = var_5(1, 1, 1)

Vector3 = var_0_10006

local var_0_7 = var_0_10006(1.3, 1.3, 1.3)

var_0_1.EQUIPMENT_ADDITION = 0
var_0_1.TECHNOLOGY_ADDITION = 1
var_0_1.CORE_ADDITION = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1.gameObject)

	findTF = var_2
	arg_1_0.skillContainer = var_2(arg_1_0._tf, "skills/content")

	local var_1_0 = arg_1_0.skillContainer
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	HorizontalLayoutGroup = var_1_10007
	arg_1_0.skillContainerHz = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.skillTpl = var_2(arg_1_0.skillContainer, "skill_tpl")
	findTF = var_2
	arg_1_0.attrs = var_2(arg_1_0._tf, "attrs/property")
	findTF = var_2
	arg_1_0.powerTxt = var_2(arg_1_0.attrs, "power/value")
	findTF = var_2
	arg_1_0.levelTxt = var_2(arg_1_0.attrs, "level_bg/level_label/Text")
	findTF = var_2
	arg_1_0.levelSlider = var_2(arg_1_0.attrs, "level_bg/exp")
	findTF = var_2
	arg_1_0.expInfo = var_2(arg_1_0.attrs, "level_bg/exp_info")
	findTF = var_2
	arg_1_0.outline = var_2(arg_1_0.attrs, "level_bg/outline")
	findTF = var_2
	arg_1_0.levelTip = var_2(arg_1_0.attrs, "level_bg/tip")
	findTF = var_2
	arg_1_0.levelBg = var_2(arg_1_0.attrs, "level_bg")
	findTF = var_2
	arg_1_0.expTip = var_2(arg_1_0.attrs, "level_bg/exp_tip")

	local var_1_2 = arg_1_0.attrs
	local var_1_3 = var_2.Find(var_1_2, "icons")
	local var_1_4 = var_2.GetChild(var_1_3, 1)

	arg_1_0.armorNameTxt = var_2.Find(var_1_4, "name")
	PLATFORM_CODE = var_2
	PLATFORM_JP = var_1_10003

	if var_2 == var_1_10003 then
		var_0_4 = var_0_3.jp
	else
		PLATFORM_CODE = var_2
		PLATFORM_KR = var_1_10003

		if var_2 == var_1_10003 then
			var_0_4 = var_0_3.kr
		else
			PLATFORM_CODE = var_2
			PLATFORM_US = var_1_10003

			if var_2 == var_1_10003 then
				var_0_4 = var_0_3.us
			else
				var_0_4 = var_0_3.defaut
			end
		end
	end

	local var_1_5 = var_0_4.sort_index

	for iter_1_0 = 1, #var_1_5 do
		local var_1_6 = var_1_5[iter_1_0]

		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_1_0.attrs, "props/" .. var_1_6)
		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_1_0.attrs, "icons/" .. var_1_6)
		pg = var_1_10010

		if var_1_10010.gametip["attr_" .. var_1_6].tip then
			string = var_1_10011

			if var_1_10011.len(var_1_10010) > 0 and var_1_6 ~= "armor" then
				setText = var_1_10011
				findTF = var_13

				var_1_10011(var_13(var_1_10009, "name"), var_1_10010)
			end
		end

		var_1_10008:SetSiblingIndex(iter_1_0 - 1)
		var_1_10009:SetSiblingIndex(iter_1_0 - 1)
	end

	local var_1_7 = var_0_4.hide

	for iter_1_1 = 1, #var_1_7 do
		local var_1_8 = var_1_7[iter_1_1]

		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_1_0.attrs, "props/" .. var_1_8)
		findTF = var_1_10010
		var_1_10010 = var_1_10010(arg_1_0.attrs, "icons/" .. var_1_8)
		setActive = var_1_10011

		var_1_10011(var_1_10009, false)

		setActive = var_1_10011

		var_1_10011(var_1_10010, false)
	end

	local var_1_9 = var_0_4.prop_ignore

	pairs = var_5

	for iter_1_2, iter_1_3 in var_5(var_1_9) do
		findTF = var_1_10010
		var_1_10010 = var_1_10010(arg_1_0.attrs, "props/" .. iter_1_2)
		findTF = var_1_10011
		var_1_10011 = var_1_10011(arg_1_0.attrs, "icons/" .. iter_1_2)
		GetOrAddComponent = var_12

		local var_1_10 = var_1_10010

		typeof = var_15
		LayoutElement = var_1_10017

		local var_1_11 = var_12(var_1_10, var_15(var_1_10017))

		var_1_11.ignoreLayout = true
		GetOrAddComponent = var_1_11

		local var_1_12 = var_1_10011

		typeof = var_15
		LayoutElement = var_1_10017

		local var_1_13 = var_1_11(var_1_12, var_15(var_1_10017))

		var_1_13.ignoreLayout = true
		Vector2 = var_1_13
		var_1_10010.anchorMax = var_1_13(0, 1)
		Vector2 = var_12
		var_1_10010.anchorMin = var_12(0, 1)
		Vector2 = var_12
		var_1_10011.anchorMax = var_12(0, 1)
		Vector2 = var_12
		var_1_10011.anchorMin = var_12(0, 1)
		Vector2 = var_12
		var_1_10010.anchoredPosition = var_12(iter_1_3[3], iter_1_3[4])
		Vector2 = var_12
		var_1_10011.anchoredPosition = var_12(iter_1_3[1], iter_1_3[2])
	end

	return
end

function var_0_1.attach(arg_2_0, arg_2_1)
	var_0_1.super.attach(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0.attrs

	arg_2_0.evalueToggle = var_2.Find(var_2_0, "evalue_toggle")
	arg_2_0.evalueIndex = var_0_1.EQUIPMENT_ADDITION
	onToggle = var_2

	var_2(arg_2_0.viewComponent, arg_2_0.evalueToggle, function()
		arg_2_0.evalueIndex = 1 - arg_2_0.evalueIndex

		local var_3_0 = arg_2_0

		var_0.updateEvalues(var_3_0)

		return
	end)

	return
end

function var_0_1.enableEvent(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.emit

	ShipViewConst = var_1_10005

	var_4_1(var_4_0, var_1_10005.SET_CLICK_ENABLE, arg_4_1)

	return
end

function var_0_1.flush(arg_5_0, arg_5_1)
	assert = var_1_10002

	var_1_10002(arg_5_1, "shipVO can not be nil")

	pg = var_1_10002
	arg_5_0.shipDataTemplate = var_1_10002.ship_data_template[arg_5_1.configId]
	arg_5_0.shipVO = arg_5_1

	arg_5_0:updateShipAttrs()
	arg_5_0:updateSKills()
	arg_5_0:updateLevelInfo()

	if not arg_5_1:isMaxStar() and arg_5_0.evalueIndex == var_0_1.TECHNOLOGY_ADDITION then
		triggerToggle = var_3

		var_3(arg_5_0.evalueToggle, false)
	end

	setActive = var_3

	var_3(arg_5_0.evalueToggle, var_2)

	return
end

function var_0_1.updateEvalues(arg_6_0)
	if not arg_6_0.additionValues then
		return
	end

	table = var_1

	local var_6_0 = var_1.contains

	ShipType = var_1_10003

	local var_6_1 = var_1_10003.SubShipType
	local var_6_2 = arg_6_0.shipVO
	local var_6_3 = var_6_0(var_6_1, var_4.getShipType(var_6_2))

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.additionValues.transforms) do
		AttributeType = var_1_10007

		if iter_6_0 ~= var_1_10007.Armor then
			AttributeType = var_1_10007

			if iter_6_0 ~= var_1_10007.Expend then
				AttributeType = var_1_10007

				if iter_6_0 == var_1_10007.HuntingRange and var_6_3 then
					setText = var_1_10007

					var_1_10007(iter_6_1, "")

					setActive = var_1_10007

					var_1_10007(iter_6_1, false)

					goto label_6_0
				end

				if not arg_6_0.additionValues[arg_6_0.evalueIndex][iter_6_0] then
					var_1_10007 = 0
				end

				local var_6_4 = arg_6_0.shipVO
				local var_6_5 = var_8.getTechNationMaxAddition(var_6_4, iter_6_0)

				if arg_6_0.evalueIndex == var_0_1.EQUIPMENT_ADDITION then
					COLOR_GREEN = var_6_6

					if not var_6_6 then
						COLOR_YELLOW = var_6_6
					end

					do
						local var_6_6

						if arg_6_0.evalueIndex == var_0_1.TECHNOLOGY_ADDITION and var_1_10007 ~= var_6_5 then
							var_6_6 = "#B4BFD5FF"
						end

						setText = var_10

						local var_6_7 = iter_6_1

						if var_1_10007 == 0 then
							var_1_10013 = ""
						else
							setColorStr = var_1_10013
							var_1_10013 = var_1_10013(" +" .. var_1_10007, var_6_6)
						end

						var_10(var_6_7, var_1_10013)

						setActive = var_10

						local var_6_8 = iter_6_1

						var_1_10013 = var_1_10007 ~= 0

						var_10(var_6_8, var_1_10013)
					end

					::label_6_0::
				end
			end
		end
	end

	return
end

function var_0_1.updateShipAttrs(arg_7_0)
	arg_7_0.additionValues = {
		[var_0_1.EQUIPMENT_ADDITION] = {},
		[var_0_1.TECHNOLOGY_ADDITION] = {},
		transforms = {}
	}

	local var_7_0 = arg_7_0.shipVO

	table = var_2

	local var_7_1 = var_2.contains

	ShipType = var_1_10004

	local var_7_2 = var_7_1(var_1_10004.SubShipType, var_7_0:getShipType())

	intProperties = var_3

	local var_7_3 = var_7_0

	if var_7_0.isBluePrintShip(var_7_3) then
		var_7_3 = var_7_0
		var_7_3 = var_7_0.getBluePrint(var_7_3)

		local var_7_4

		if not var_5.getShipProperties(var_7_3, var_7_0) then
			var_7_3 = var_7_0
			var_7_4 = var_7_0.getShipProperties(var_7_3)
		end

		local var_7_5 = var_3(var_7_4)
		local var_7_6 = var_7_0
		local var_7_7, var_7_8 = var_7_0.getEquipmentProperties(var_7_6)

		intProperties = var_7_6

		local var_7_9 = var_7_6(var_7_7)

		intProperties = var_6

		local var_7_10 = var_6(var_7_8)
		local var_7_11 = var_7_0:getShipCombatPower()

		FormationUI = var_7_3

		var_7_3.tweenNumText(arg_7_0.powerTxt, var_7_11)

		pairs = var_7

		for iter_7_0, iter_7_1 in var_7(var_0_2) do
			findTF = var_1_10012
			var_1_10012 = var_1_10012(arg_7_0.attrs, "props/" .. iter_7_0)
			findTF = var_1_10013
			var_1_10013 = var_1_10013(arg_7_0.attrs, "icons/" .. iter_7_0)
			findTF = var_14

			local var_7_12 = var_14(var_1_10012, "value")

			findTF = var_15

			local var_7_13 = var_15(var_1_10012, "add")
			local var_7_14

			if not var_7_5[iter_7_1] then
				var_7_14 = 0
			end

			local var_7_15

			if not var_7_10[iter_7_1] then
				var_7_15 = 1
			end

			calcFloor = var_18

			local var_7_16

			if not var_7_9[iter_7_1] then
				var_7_16 = 0
			end

			local var_7_17 = var_18((var_7_16 + var_7_14) * var_7_15) - var_7_14

			setText = var_1_10019

			var_1_10019(var_7_12, var_7_14)

			var_1_10019 = arg_7_0.additionValues.transforms
			var_1_10019[iter_7_1] = var_7_13
			var_1_10019 = arg_7_0.additionValues[0]
			var_1_10019[iter_7_1] = var_7_17
			var_1_10019 = arg_7_0.additionValues[1]
			var_1_10019[iter_7_1] = var_7_0:getTechNationAddition(iter_7_1)
			AttributeType = var_1_10019

			if iter_7_1 == var_1_10019.Armor then
				setActive = var_1_10019

				var_1_10019(var_7_12, false)

				setActive = var_1_10019

				var_1_10019(var_7_13, false)

				setText = var_1_10019

				var_1_10019(arg_7_0.armorNameTxt, var_7_0:getShipArmorName())

				goto label_7_0
			end

			AttributeType = var_1_10019

			if iter_7_1 == var_1_10019.Expend then
				setText = var_1_10019
				findTF = var_21

				var_1_10019(var_21(var_1_10012, "value"), var_7_0:getBattleTotalExpend())

				setActive = var_1_10019

				var_1_10019(var_7_13, false)

				goto label_7_0
			end

			AttributeType = var_1_10019

			if iter_7_1 == var_1_10019.HuntingRange then
				setActive = var_1_10019

				var_1_10019(var_1_10013, var_7_2)

				setActive = var_1_10019

				var_1_10019(var_1_10012, var_7_2)

				if var_7_2 then
					setActive = var_1_10019

					var_1_10019(var_7_12, false)

					setActive = var_1_10019

					var_1_10019(var_7_13, false)
				end

				goto label_7_0
			end

			AttributeType = var_1_10019

			if iter_7_1 == var_1_10019.AntiSub then
				setActive = var_1_10019

				var_1_10019(var_1_10013, not var_7_2)

				setActive = var_1_10019

				var_1_10019(var_1_10012, not var_7_2)

				goto label_7_0
			end

			AttributeType = var_1_10019

			if iter_7_1 ~= var_1_10019.OxyMax then
				AttributeType = var_1_10019

				if iter_7_1 == var_1_10019.Ammo then
					setActive = var_1_10019

					var_1_10019(var_1_10013, var_7_2)

					setActive = var_1_10019

					var_1_10019(var_1_10012, var_7_2)

					AttributeType = var_1_10019

					if iter_7_1 == var_1_10019.Ammo then
						setText = var_1_10019

						var_1_10019(var_7_12, var_7_0:getShipAmmo())
					end
				end

				::label_7_0::
			end
		end

		arg_7_0:updateEvalues()

		return
	end
end

function var_0_1.updateSKills(arg_8_0)
	local var_8_0 = arg_8_0.shipVO

	Clone = var_1_10002

	for iter_8_0 = #var_1_10002(arg_8_0.shipDataTemplate.buff_list_display) + 1, 3 do
		table = var_1_10007

		var_1_10007.insert(var_2, false)
	end

	setActive = var_3

	var_3(arg_8_0.skillTpl, false)

	UIItemList = var_3

	local var_8_1 = var_3.New(arg_8_0.skillContainer, arg_8_0.skillTpl)

	var_3.make(var_8_1, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			if var_0[arg_9_1 + 1] then
				local var_9_0 = var_8_0
				local var_9_1 = var_4.fateSkillChange(var_9_0, var_3)

				getSkillConfig = var_4

				local var_9_2 = var_8_0
				local var_9_3 = var_4(var_6.RemapSkillId(var_9_2, var_9_1))
				local var_9_4

				if var_8_0.skills[var_9_1] and var_9_4.id == 11720 and not var_8_0.transforms[3612] then
					var_9_4 = nil
				end

				if var_9_4 and var_9_4.id == 14900 and not var_8_0.transforms[16412] then
					var_9_4 = nil
				end

				local var_9_5 = arg_8_0

				var_6.updateSkillTF(var_9_5, arg_9_2, var_9_3, var_9_4)

				onButton = var_6

				local var_9_6 = arg_8_0
				local var_9_7 = arg_9_2

				local function var_9_8()
					local var_10_0 = arg_8_0
					local var_10_1 = var_0.emit

					ShipMainMediator = var_3_10003

					var_10_1(var_10_0, var_3_10003.ON_SKILL, var_9_3.id, var_9_4, arg_9_1 + 1)

					return
				end

				SFX_PANEL = var_11

				var_6(var_9_6, var_9_7, var_9_8, var_11)
			else
				local var_9_9 = arg_8_0

				var_4.updateSkillTF(var_9_9, arg_9_2)

				RemoveComponent = var_4

				var_4(arg_9_2, "Button")
			end
		end

		return
	end)
	var_3:align(#var_2)

	return
end

function var_0_1.updateSkillTF(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	findTF = var_1_10004

	local var_11_0 = var_1_10004(arg_11_1, "skill")

	findTF = var_1_10005

	local var_11_1 = var_1_10005(arg_11_1, "lock")

	findTF = var_6

	local var_11_2 = var_6(arg_11_1, "unknown")
	local var_11_4

	if arg_11_2 then
		setActive = var_11_4

		var_11_4(var_11_0, true)

		setActive = var_11_4

		var_11_4(var_11_2, false)

		setActive = var_11_4

		var_11_4(var_11_1, not arg_11_3)

		LoadImageSpriteAsync = var_11_4

		local var_11_3 = "skillicon/" .. arg_11_2.icon

		findTF = var_10

		var_11_4(var_11_3, var_10(var_11_0, "icon"))

		findTF = var_11_4
		var_11_4 = var_11_4(var_11_0, "mask/name")
		Vector2 = var_8
		var_11_4.anchoredPosition = var_8(0, 0)
		setScrollText = var_11_4
		findTF = var_9

		local var_11_5 = var_9(var_11_0, "mask/name")

		getSkillName = var_10

		var_11_4(var_11_5, var_10(arg_11_2.id))

		findTF = var_11_4
		var_11_4 = var_11_4(var_11_0, "level")
		setText = var_8

		local var_11_6 = var_11_4
		local var_11_7 = "LEVEL: "
		local var_11_8

		if not arg_11_3 or not arg_11_3.level then
			var_11_8 = "??"
		end

		var_8(var_11_6, var_11_7 .. var_11_8)
	else
		setActive = var_11_4

		var_11_4(var_11_0, false)

		setActive = var_11_4

		var_11_4(var_11_2, true)

		setActive = var_11_4

		var_11_4(var_11_1, false)
	end

	return
end

function var_0_1.updateLevelInfo(arg_12_0)
	local var_12_0 = arg_12_0.shipVO

	setText = var_1_10002

	var_1_10002(arg_12_0.levelTxt, var_12_0.level)

	local var_12_1 = var_12_0:getLevelExpConfig()

	if var_12_0.level ~= var_12_0:getMaxLevel() then
		setSlider = var_3

		var_3(arg_12_0.levelSlider, 0, var_12_1.exp_interval, var_12_0.exp)

		setText = var_3

		var_3(arg_12_0.expInfo, var_12_0.exp .. "/" .. var_12_1.exp_interval)
	else
		setSlider = var_3

		var_3(arg_12_0.levelSlider, 0, 1, 1)

		setText = var_3

		var_3(arg_12_0.expInfo, var_12_0.exp .. "/Max")
	end

	arg_12_0:updateMaxLevel(var_12_0)
	arg_12_0:UpdateExpTip(var_12_0)

	return
end

function var_0_1.UpdateExpTip(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:isReachNextMaxLevel()
	local var_13_1 = arg_13_1.level
	local var_13_2 = arg_13_1.maxLevel <= var_13_1

	setActive = var_4

	var_4(arg_13_0.expTip, not var_13_0 and not var_13_2)

	onButton = var_4

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.expTip

	local function var_13_5()
		local var_14_0 = {}
		local var_14_1 = arg_13_1

		if var_1.isActivityNpc(var_14_1) then
			table = var_1

			var_1.insert(var_14_0, function(arg_15_0)
				pg = var_3_10001

				local var_15_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_15_1 = var_1.ShowMsgBox
				local var_15_2 = {}

				i18n = var_3_10005
				var_15_2.content = var_3_10005("coures_exp_npc_tip")
				var_15_2.onYes = arg_15_0

				var_15_1(var_15_0, var_15_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_14_0, function()
			local var_16_0 = arg_13_0
			local var_16_1 = var_0.emit

			ShipViewConst = var_3_10003

			var_16_1(var_16_0, var_3_10003.SHOW_EXP_ITEM_USAGE, arg_13_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_13_3, var_13_4, var_13_5, var_1_10009)

	return
end

function var_0_1.updateMaxLevel(arg_17_0, arg_17_1)
	if arg_17_1:isReachNextMaxLevel() then
		SetActive = var_1_10003

		var_1_10003(arg_17_0.outline, true)

		setActive = var_1_10003

		var_1_10003(arg_17_0.levelTip, true)

		blinkAni = var_1_10003

		local var_17_0 = var_1_10003(arg_17_0.outline, 1.5, -1, 0.1)

		var_3.setFrom(var_17_0, 1)

		blinkAni = var_3

		local var_17_1 = var_3(arg_17_0.levelTip, 1.5, -1, 0.1)

		var_3.setFrom(var_17_1, 1)

		local var_17_2 = arg_17_1:getNextMaxLevelConsume()
		local var_17_3 = arg_17_1
		local var_17_4 = arg_17_1.getMaxLevel(var_17_3)
		local var_17_5 = arg_17_1:getNextMaxLevel()

		onButton = var_17_3

		local var_17_6 = arg_17_0
		local var_17_7 = arg_17_0.levelBg

		local function var_17_8()
			local var_18_0 = arg_17_1

			if var_0.isActivityNpc(var_18_0) then
				pg = var_0

				local var_18_1 = var_0.TipsMgr.GetInstance()
				local var_18_2 = var_0.ShowTips

				i18n = var_2_10003

				var_18_2(var_18_1, var_2_10003("npc_upgrade_max_level"))

				return
			end

			local var_18_3 = arg_17_0
			local var_18_4 = var_0.emit

			ShipViewConst = var_2_10003

			local var_18_5 = var_2_10003.SHOW_CUSTOM_MSG
			local var_18_6 = {}

			i18n = var_2_10005
			var_18_6.content = var_2_10005("upgrade_to_next_maxlevel_tip")
			var_18_6.content1 = var_17_4 .. "->" .. var_17_5
			var_18_6.items = var_17_2

			function var_18_6.onYes()
				local var_19_0 = arg_17_1
				local var_19_1, var_19_2 = var_0.canUpgradeMaxLevel(var_19_0)

				if var_19_1 then
					local var_19_3 = arg_17_0

					var_19_0 = var_19_0.emit
					ShipViewConst = var_3_10005

					var_19_0(var_19_3, var_3_10005.HIDE_CUSTOM_MSG)

					local var_19_4 = arg_17_0

					var_19_0 = var_19_0.emit
					ShipMainMediator = var_5

					var_19_0(var_19_4, var_5.ON_UPGRADE_MAX_LEVEL, arg_17_1.id)
				else
					pg = var_19_0

					local var_19_5 = var_19_0.TipsMgr.GetInstance()

					var_2.ShowTips(var_19_5, var_19_2)
				end

				return
			end

			var_18_4(var_18_3, var_18_5, var_18_6)

			return
		end

		SFX_PANEL = var_1_10011

		var_17_3(var_17_6, var_17_7, var_17_8, var_1_10011)
	else
		arg_17_0:removeLevelUpTip()
	end

	return
end

function var_0_1.removeLevelUpTip(arg_20_0)
	SetActive = var_1_10001

	var_1_10001(arg_20_0.outline, false)

	setActive = var_1_10001

	var_1_10001(arg_20_0.levelTip, false)

	LeanTween = var_1_10001

	local var_20_0 = var_1_10001.isTweening

	go = var_3

	local var_20_1

	if var_20_0(var_3(arg_20_0.outline)) then
		LeanTween = var_20_1
		var_20_1 = var_20_1.cancel
		go = var_3

		var_20_1(var_3(arg_20_0.outline))
	end

	LeanTween = var_20_1

	local var_20_2 = var_20_1.isTweening

	go = var_3

	local var_20_3

	if var_20_2(var_3(arg_20_0.levelTip)) then
		LeanTween = var_20_3
		var_20_3 = var_20_3.cancel
		go = var_3

		var_20_3(var_3(arg_20_0.levelTip))
	end

	removeOnButton = var_20_3

	var_20_3(arg_20_0.levelBg)

	return
end

function var_0_1.doLeveUpAnim(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0:removeLevelUpTip()
	arg_21_0:enableEvent(false)

	local var_21_0 = {}
	local var_21_1

	if arg_21_1.level < arg_21_2.level then
		var_21_1 = arg_21_2.level - arg_21_1.level

		local var_21_2 = arg_21_1:getLevelExpConfig()

		for iter_21_0 = 1, var_21_1 do
			table = var_1_10011

			var_1_10011.insert(var_21_0, function(arg_22_0)
				TweenValue = var_2_10001

				var_2_10001(arg_21_0.levelSlider, 0, var_21_2.exp_interval, var_0_5, 0, function(arg_23_0)
					setSlider = var_3_10001

					var_3_10001(arg_21_0.levelSlider, 0, var_21_2.exp_interval, arg_23_0)

					setText = var_3_10001

					local var_23_0 = arg_21_0.expInfo

					math = var_4

					var_3_10001(var_23_0, var_4.floor(arg_23_0) .. "/" .. var_21_2.exp_interval)

					return
				end, function()
					Clone = var_3_10000

					local var_24_0 = var_3_10000(arg_21_1)

					arg_21_1.level = arg_21_1.level + 1

					local var_24_1 = arg_21_1

					var_21_2 = var_1.getLevelExpConfig(var_24_1)

					local var_24_2 = arg_21_0

					var_1.scaleAnim(var_24_2, arg_21_0.levelTxt, var_0_6, var_0_7, var_0_5 / 2, function()
						if arg_21_1.level == arg_21_2.level then
							local var_25_0 = arg_21_0

							var_0.doAttrAnim(var_25_0, var_24_0, arg_21_2, function()
								TweenValue = var_5_10000

								var_5_10000(arg_21_0.levelSlider, 0, arg_21_2.exp, var_0_5, 0, function(arg_27_0)
									setSlider = var_6_10001

									var_6_10001(arg_21_0.levelSlider, 0, var_21_2.exp_interval, arg_27_0)

									setText = var_6_10001

									local var_27_0 = arg_21_0.expInfo

									math = var_4

									var_6_10001(var_27_0, var_4.floor(arg_27_0) .. "/" .. var_21_2.exp_interval)

									return
								end, arg_22_0)

								return
							end)
						else
							local var_25_1 = arg_21_0

							var_0.doAttrAnim(var_25_1, var_24_0, arg_21_1, arg_22_0)
						end

						return
					end, function()
						setText = var_4_10000

						var_4_10000(arg_21_0.levelTxt, arg_21_1.level)

						return
					end)

					return
				end)

				return
			end)
		end
	else
		var_21_1 = arg_21_2:getLevelExpConfig()

		if arg_21_2.exp > arg_21_1.exp then
			table = var_6

			var_6.insert(var_21_0, function(arg_29_0)
				TweenValue = var_2_10001

				var_2_10001(arg_21_0.levelSlider, arg_21_1.exp, arg_21_2.exp, var_0_5, 0, function(arg_30_0)
					setSlider = var_3_10001

					var_3_10001(arg_21_0.levelSlider, 0, var_21_1.exp_interval, arg_30_0)

					setText = var_3_10001

					local var_30_0 = arg_21_0.expInfo

					math = var_4

					var_3_10001(var_30_0, var_4.floor(arg_30_0) .. "/" .. var_21_1.exp_interval)

					return
				end, arg_29_0)

				return
			end)
		end
	end

	seriesAsync = var_21_1

	var_21_1(var_21_0, function()
		if arg_21_3 then
			arg_21_3()
		end

		local var_31_0 = arg_21_0

		var_0.enableEvent(var_31_0, true)

		return
	end)

	return
end

function var_0_1.doAttrAnim(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	intProperties = var_1_10004

	local var_32_0 = var_1_10004(arg_32_1:getShipProperties())
	local var_32_1 = arg_32_1
	local var_32_2, var_32_3 = arg_32_1.getEquipmentProperties(var_32_1)

	intProperties = var_32_1

	local var_32_4 = var_32_1(arg_32_2:getShipProperties())
	local var_32_5 = arg_32_2
	local var_32_6, var_32_7 = arg_32_2.getEquipmentProperties(var_32_5)

	intProperties = var_32_5

	local var_32_8 = var_32_5(var_32_2)

	intProperties = var_10

	local var_32_9 = var_10(var_32_3)

	intProperties = var_10

	local var_32_10 = var_10(var_32_6)

	intProperties = var_10

	local var_32_11 = var_10(var_32_7)
	local var_32_12 = {}
	local var_32_13 = arg_32_2
	local var_32_14 = arg_32_2.getShipCombatPower(var_32_13)

	if arg_32_1:getShipCombatPower() ~= var_32_14 then
		table = var_32_13

		var_32_13.insert(var_32_12, function(arg_33_0)
			TweenValue = var_2_10001

			var_2_10001(arg_32_0.powerTxt, var_0, var_32_14, var_0_5, 0, function(arg_34_0)
				setText = var_3_10001

				local var_34_0 = arg_32_0.powerTxt

				math = var_3_10004

				var_3_10001(var_34_0, var_3_10004.floor(arg_34_0))

				return
			end, arg_33_0)

			return
		end)
	end

	pairs = var_32_13

	for iter_32_0, iter_32_1 in var_32_13(var_0_2) do
		findTF = var_1_10018

		if not var_1_10018(arg_32_0.attrs, "props/" .. iter_32_0) then
			findTF = var_1_10018
			var_1_10018 = var_1_10018(arg_32_0.attrs, "prop_" .. iter_32_0)
		end

		findTF = var_1_10019

		if not var_1_10019(arg_32_0.attrs, "icons/" .. iter_32_0) then
			findTF = var_1_10019
			var_1_10019 = var_1_10019(arg_32_0.attrs, "icon_" .. iter_32_0)
		end

		findTF = var_20

		local var_32_15 = var_20(var_1_10018, "value")

		findTF = var_21

		local var_32_16 = var_21(var_1_10018, "add")
		local var_32_17

		if not var_32_0[iter_32_1] then
			var_32_17 = 0
		end

		local var_32_18

		if not var_32_9[iter_32_1] then
			var_32_18 = 1
		end

		local var_32_19

		if not var_32_4[iter_32_1] then
			var_32_19 = 0
		end

		local var_32_20

		if not var_32_11[iter_32_1] then
			var_32_20 = 1
		end

		local var_32_21
		local var_32_22

		if arg_32_0.evalueIndex == var_0_1.EQUIPMENT_ADDITION then
			calcFloor = var_28

			local var_32_23

			if not var_32_8[iter_32_1] then
				var_32_23 = 0
			end

			var_32_21 = var_28((var_32_23 + var_32_17) * var_32_18) - var_32_17
			calcFloor = var_28

			local var_32_24

			if not var_32_10[iter_32_1] then
				var_32_24 = 0
			end

			var_32_22 = var_28((var_32_24 + var_32_19) * var_32_20) - var_32_19
		elseif arg_32_0.evalueIndex == var_0_1.TECHNOLOGY_ADDITION then
			var_32_21 = arg_32_1:getTechNationAddition(iter_32_1)
			var_32_22 = arg_32_2:getTechNationAddition(iter_32_1)
		end

		if var_32_17 ~= 0 then
			table = var_28

			var_28.insert(var_32_12, function(arg_35_0)
				TweenValue = var_2_10001

				var_2_10001(var_32_15, var_32_17, var_32_19, var_0_5, 0, function(arg_36_0)
					setText = var_3_10001

					local var_36_0 = var_32_15

					math = var_3_10004

					var_3_10001(var_36_0, var_3_10004.floor(arg_36_0))

					return
				end, arg_35_0)

				local var_35_0 = arg_32_0

				var_1.scaleAnim(var_35_0, var_32_15, var_0_6, var_0_7, var_0_5 / 2)

				return
			end)
		end

		if var_32_21 < var_32_22 then
			if arg_32_0.evalueIndex == var_0_1.EQUIPMENT_ADDITION then
				COLOR_GREEN = var_28

				if not var_28 then
					COLOR_YELLOW = var_28
				end

				table = var_32_28

				var_32_28.insert(var_32_12, function(arg_37_0)
					TweenValue = var_2_10001

					var_2_10001(var_32_16, var_32_21, var_32_22, var_0_5, 0, function(arg_38_0)
						setText = var_3_10001

						local var_38_0 = var_32_16

						setColorStr = var_3_10004

						local var_38_1 = "+"

						math = var_3_10007

						var_3_10001(var_38_0, var_3_10004(var_38_1 .. var_3_10007.floor(arg_38_0), var_0))

						return
					end, arg_37_0)

					local var_37_0 = arg_32_0

					var_1.scaleAnim(var_37_0, var_32_16, var_0_6, var_0_7, var_0_5 / 2)

					return
				end)

				setActive = var_28

				var_28(var_32_16, var_32_22 ~= 0)

				AttributeType = var_28

				if iter_32_1 == var_28.Armor then
					setActive = var_28

					var_28(var_32_15, false)

					setActive = var_28

					var_28(var_32_16, false)

					setText = var_28

					var_28(arg_32_0.armorNameTxt, arg_32_2:getShipArmorName())

					goto label_32_0
				end

				AttributeType = var_28

				local var_32_25, var_32_26, var_32_28

				if iter_32_1 == var_28.Expend then
					var_32_25 = arg_32_2
					var_32_26 = arg_32_2.getBattleTotalExpend(var_32_25)

					local var_32_27 = arg_32_1

					var_32_28 = arg_32_1.getBattleTotalExpend(var_32_27)
					findTF = var_32_25
					var_32_25 = var_32_25(var_1_10018, "value")

					if var_32_28 ~= var_32_26 then
						table = var_32_27

						var_32_27.insert(var_32_12, function(arg_39_0)
							TweenValue = var_2_10001

							var_2_10001(var_32_25, var_32_28, var_32_26, var_0_5, 0, function(arg_40_0)
								setText = var_3_10001

								local var_40_0 = var_32_25

								math = var_3_10004

								var_3_10001(var_40_0, var_3_10004.floor(arg_40_0))

								return
							end, arg_39_0)

							local var_39_0 = arg_32_0

							var_1.scaleAnim(var_39_0, var_32_25, var_0_6, var_0_7, var_0_5 / 2)

							return
						end)
					end

					setActive = var_32_27

					var_32_27(var_32_16, false)

					goto label_32_0
				end

				AttributeType = var_32_26

				if iter_32_1 ~= var_32_26.OxyMax then
					AttributeType = var_28

					if iter_32_1 == var_28.Tactics then
						table = var_28

						local var_32_29 = var_28.contains

						ShipType = var_32_25

						local var_32_30 = var_32_29(var_32_25.SubShipType, arg_32_2:getShipType())

						setActive = var_32_28

						var_32_28(var_1_10019, var_32_30)

						setActive = var_32_28

						var_32_28(var_1_10018, var_32_30)

						if var_32_30 then
							AttributeType = var_32_28

							if iter_32_1 == var_32_28.Tactics then
								local var_32_31 = arg_32_2
								local var_32_32, var_32_33 = arg_32_2.getTactics(var_32_31)

								setActive = var_32_31

								var_32_31(var_32_15, false)

								setActive = var_32_31

								var_32_31(var_32_16, true)

								setText = var_32_31

								local var_32_34 = var_32_16

								i18n = var_34

								var_32_31(var_32_34, var_34(var_32_33))
							end
						end
					end

					::label_32_0::
				end
			end
		end
	end

	parallelAsync = var_13

	var_13(var_32_12, function()
		if arg_32_3 then
			arg_32_3()
		end

		return
	end)

	return
end

function var_0_1.scaleAnim(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	LeanTween = var_1_10007

	local var_42_0 = var_1_10007.scale

	go = var_1_10009

	local var_42_1 = var_42_0(var_1_10009(arg_42_1), arg_42_3, arg_42_4)
	local var_42_2 = var_7.setFrom(var_42_1, arg_42_2)
	local var_42_3 = var_7.setOnComplete

	System = var_10

	var_42_3(var_42_2, var_10.Action(function()
		if arg_42_6 then
			arg_42_6()
		end

		LeanTween = var_0

		local var_43_0 = var_0.scale

		go = var_2_10002

		local var_43_1 = var_43_0(var_2_10002(arg_42_1), arg_42_2, arg_42_4)
		local var_43_2 = var_0.setFrom(var_43_1, arg_42_3)
		local var_43_3 = var_0.setOnComplete

		System = var_3

		var_43_3(var_43_2, var_3.Action(arg_42_5))

		return
	end))

	return
end

function var_0_1.clear(arg_44_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_44_0.evalueToggle, false)

	LeanTween = var_1_10001

	local var_44_0 = var_1_10001.isTweening

	go = var_3

	local var_44_1

	if var_44_0(var_3(arg_44_0.levelSlider)) then
		LeanTween = var_44_1
		var_44_1 = var_44_1.cancel
		go = var_3

		var_44_1(var_3(arg_44_0.levelSlider))
	end

	LeanTween = var_44_1

	local var_44_2 = var_44_1.isTweening

	go = var_3

	local var_44_3

	if var_44_2(var_3(arg_44_0.powerTxt)) then
		LeanTween = var_44_3
		var_44_3 = var_44_3.cancel
		go = var_3

		var_44_3(var_3(arg_44_0.powerTxt))
	end

	LeanTween = var_44_3

	local var_44_4 = var_44_3.isTweening

	go = var_3

	if var_44_4(var_3(arg_44_0.expInfo)) then
		LeanTween = var_1

		local var_44_5 = var_1.cancel

		go = var_3

		var_44_5(var_3(arg_44_0.expInfo))
	end

	arg_44_0:removeLevelUpTip()

	arg_44_0.additionValues = nil

	return
end

return var_0_1
