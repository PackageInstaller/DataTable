local var_0_0 = {}
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5

local function var_0_6(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:Find("base")

	IsNil = var_1_10003

	if var_1_10003(var_1_0) then
		return
	end

	local var_1_1 = arg_1_1.name
	local var_1_2 = arg_1_1.value

	setActive = var_5

	var_5(var_1_0, var_1_2)

	if not var_1_2 then
		return
	end

	setText = var_5

	var_5(var_1_0:Find("name"), var_1_1)

	Canvas = var_5

	var_5.ForceUpdateCanvases()

	IsNil = var_5

	if not var_5(var_1_0:Find("value")) then
		setActive = var_5

		var_5(var_1_0:Find("value"), var_1_2)

		changeToScrollText = var_5

		var_5(var_1_0:Find("value/Text"), var_1_2)
	end

	IsNil = var_5

	if not var_5(var_1_0:Find("effect")) then
		setActive = var_5

		var_5(var_1_0:Find("effect"), false)
	end

	setActive = var_5

	local var_1_3 = var_1_0:Find("value/up")
	local var_1_4

	if arg_1_1.compare then
		var_1_4 = arg_1_1.compare > 0
	end

	var_5(var_1_3, var_1_4)

	setActive = var_5

	local var_1_5 = var_1_0:Find("value/down")
	local var_1_6

	if arg_1_1.compare then
		var_1_6 = arg_1_1.compare < 0
	end

	var_5(var_1_5, var_1_6)

	if not arg_1_1.lock_open and arg_1_1.sub then
		local var_1_7 = #arg_1_1.sub

		if 0 < var_1_7 then
			onToggle = var_1_7

			local var_1_8
			local var_1_9 = var_1_0

			local function var_1_10(arg_2_0)
				setActive = var_2_10001

				local var_2_0 = var_1_0

				var_2_10001(var_3.Find(var_2_0, "sub"), arg_2_0)

				return
			end

			SFX_PANEL = var_10

			var_1_7(var_1_8, var_1_9, var_1_10, var_10)

			triggerToggle = var_1_7

			var_1_7(var_1_0, arg_1_1.lock_open)

			GetComponent = var_1_7

			local var_1_11 = var_1_0

			typeof = var_8
			Toggle = var_10
			var_1_7(var_1_11, var_8(var_10)).enabled = true

			goto label_1_0
		end
	end

	do
		local var_1_12

		if arg_1_1.descTrigger ~= nil then
			var_1_12 = arg_1_0:Find("desc")
			onToggle = var_1_10006

			local var_1_13
			local var_1_14 = var_1_0

			local function var_1_15(arg_3_0)
				setActive = var_2_10001

				var_2_10001(var_1_12, arg_3_0)

				return
			end

			SFX_PANEL = var_1_10011

			var_1_10006(var_1_13, var_1_14, var_1_15, var_1_10011)

			onButton = var_1_10006

			local var_1_16
			local var_1_17 = var_1_12

			local function var_1_18()
				triggerToggle = var_2_10000

				var_2_10000(var_1_0, false)

				return
			end

			SFX_PANEL = var_1_10011

			var_1_10006(var_1_16, var_1_17, var_1_18, var_1_10011)

			triggerToggle = var_1_10006

			var_1_10006(var_1_0, arg_1_1.descTrigger)

			GetComponent = var_1_10006

			local var_1_19 = var_1_0

			typeof = var_9
			Toggle = var_1_10011
			var_1_10006(var_1_19, var_9(var_1_10011)).enabled = true
		else
			setActive = var_1_12

			var_1_12(var_1_0:Find("name/close"), false)

			setActive = var_1_12

			var_1_12(var_1_0:Find("name/open"), false)

			removeOnToggle = var_1_12

			var_1_12(var_1_0)

			GetComponent = var_1_12

			local var_1_20 = var_1_0

			typeof = var_8
			Toggle = var_10
			var_1_12(var_1_20, var_8(var_10)).enabled = false
		end
	end

	::label_1_0::

	return
end

local function var_0_7(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:Find("desc")

	IsNil = var_1_10003

	if var_1_10003(var_5_0) then
		return
	end

	if arg_5_1.descTrigger == nil then
		setActive = var_3

		var_3(var_5_0, arg_5_1.desc)
	end

	if not arg_5_1.desc then
		return
	end

	setText = var_3

	var_3(var_5_0:Find("Text"), arg_5_1.desc)

	return
end

local function var_0_8(arg_6_0, arg_6_1)
	var_0_6(arg_6_0, arg_6_1)
	var_0_7(arg_6_0, arg_6_1)

	return
end

local function var_0_9(arg_7_0, arg_7_1, arg_7_2)
	removeAllChildren = var_1_10003

	var_1_10003(arg_7_0)
	var_0_5(arg_7_0, arg_7_1, arg_7_2)

	return
end

function var_0_5(arg_8_0, arg_8_1, arg_8_2)
	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_2) do
		cloneTplTo = var_1_10008
		var_1_10008 = var_1_10008(arg_8_1, arg_8_0)

		var_0_8(var_1_10008, iter_8_1)
	end

	return
end

local function var_0_10(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:Find("attr_tpl")

	var_0_9(arg_9_0:Find("attrs"), var_9_0, arg_9_1.attrs)

	local var_9_1 = {}
	local var_9_2

	if arg_9_2[1].skillId > 0 then
		getSkillDesc = var_9_2
		var_9_2 = var_9_2(arg_9_2[1].skillId, arg_9_2[1].lv)

		if not arg_9_2[1].unlock then
			setColorStr = var_6
			i18n = var_8
			var_9_2 = var_6(var_8("spweapon_tip_skill_locked") .. var_9_2, "#a2a2a2")
		end

		table = var_6

		local var_9_3 = var_6.insert
		local var_9_4 = var_9_1
		local var_9_5 = {}

		i18n = var_1_10010
		var_9_5.name = var_1_10010("spweapon_attr_effect")
		setColorStr = var_1_10010
		getSkillName = var_12
		var_9_5.value = var_1_10010(var_12(arg_9_2[1].skillId), arg_9_2[1].unlock and "#FFDE00FF" or "#A2A2A2")
		var_9_5.desc = var_9_2
		defaultValue = var_1_10010
		var_9_5.descTrigger = var_1_10010(arg_9_2[1].descTrigger, arg_9_2[1].unlock)

		var_9_3(var_9_4, var_9_5)
	end

	ipairs = var_9_2

	for iter_9_0, iter_9_1 in var_9_2(arg_9_2[2]) do
		getSkillDesc = var_1_10010
		var_1_10010 = var_1_10010(iter_9_1.skillId, iter_9_1.lv)

		if not iter_9_1.unlock then
			setColorStr = var_11
			i18n = var_13
			var_1_10010 = var_11(var_13("spweapon_tip_skill_locked") .. var_1_10010, "#a2a2a2")
		end

		table = var_11

		local var_9_6 = var_11.insert
		local var_9_7 = var_9_1

		iter_9_5 = {}
		i18n = var_1_10015
		iter_9_5.name = var_1_10015("spweapon_attr_skillupgrade")
		setColorStr = var_1_10015
		getSkillName = var_17
		iter_9_5.value = var_1_10015(var_17(iter_9_1.skillId), iter_9_1.unlock and "#FFDE00FF" or "#A2A2A2")
		iter_9_5.desc = var_1_10010
		defaultValue = var_1_10015
		iter_9_5.descTrigger = var_1_10015(iter_9_1.descTrigger, iter_9_1.unlock)

		var_9_6(var_9_7, iter_9_5)
	end

	var_0_5(arg_9_0:Find("attrs"), var_9_0, var_9_1)

	cloneTplTo = var_5

	local var_9_8 = var_9_0
	local var_9_9 = arg_9_0
	local var_9_10 = var_5(var_9_8, arg_9_0.Find(var_9_9, "part"))

	var_5.SetSiblingIndex(var_9_10, 0)

	local var_9_11 = var_0_8
	local var_9_12 = var_5
	local var_9_13 = {
		value = ""
	}

	i18n = var_9_9
	var_9_13.name = var_9_9("equip_info_23")

	var_9_11(var_9_12, var_9_13)

	local var_9_14 = arg_9_0:Find("part/value")
	local var_9_15 = var_6.Find(var_9_14, "label")
	local var_9_16 = {}
	local var_9_17 = {}

	if #arg_9_1.part[1] == 0 and #arg_9_1.part[2] == 0 then
		setmetatable = var_10

		var_10(var_9_16, {
			__index = function(arg_10_0, arg_10_1)
				return true
			end
		})

		setmetatable = var_10

		var_10(var_9_17, {
			__index = function(arg_11_0, arg_11_1)
				return true
			end
		})
	else
		ipairs = var_10

		for iter_9_2, iter_9_5 in var_10(arg_9_1.part[1]) do
			var_9_16[iter_9_5] = true
		end

		ipairs = var_10

		for iter_9_4, iter_9_5 in var_10(arg_9_1.part[2]) do
			var_9_17[iter_9_5] = true
		end
	end

	ShipType = var_10

	local var_9_18 = var_10.MergeFengFanType

	ShipType = var_12

	local var_9_19 = var_12.FilterOverQuZhuType

	ShipType = iter_9_5

	local var_9_20 = var_9_18(var_9_19(iter_9_5.AllShipType), var_9_16, var_9_17)

	UIItemList = var_11

	var_11.StaticAlign(var_6, var_9_15, #var_9_20, function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_9_20[arg_12_1]

			GetImageSpriteFromAtlasAsync = var_2_10004

			local var_12_1 = "shiptype"

			ShipType = var_2_10007

			var_2_10004(var_12_1, var_2_10007.Type2CNLabel(var_12_0), arg_12_2)

			setActive = var_2_10004

			local var_12_2 = arg_12_2:Find("main")
			local var_12_3

			if var_9_16[var_12_0] then
				var_12_3 = not var_9_17[var_12_0]
			end

			var_2_10004(var_12_2, var_12_3)

			setActive = var_2_10004

			local var_12_4 = arg_12_2:Find("sub")
			local var_12_5

			if var_9_17[var_12_0] then
				var_12_5 = not var_9_16[var_12_0]
			end

			var_2_10004(var_12_4, var_12_5)

			setImageAlpha = var_2_10004

			var_2_10004(arg_12_2, not var_9_16[var_12_0] and not var_9_17[var_12_0] and 0.3 or 1)
		end

		return
	end)

	setActive = var_11

	var_11(var_9_0, false)

	return
end

local var_0_11 = updateSpWeaponInfo

function var_0_0.AlignAttrs(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_0 do
		if not arg_13_1[iter_13_0] or arg_13_0[iter_13_0].type ~= arg_13_1[iter_13_0].type then
			var_1_10006 = false

			for iter_13_1 = iter_13_0 + 1, #arg_13_1 do
				if arg_13_1[iter_13_0].type == arg_13_1[iter_13_1].type then
					table = var_11

					local var_13_0 = var_11.remove(arg_13_1, iter_13_1)

					table = var_12

					var_12.insert(arg_13_1, iter_13_0, var_13_0)

					var_1_10006 = true

					break
				end
			end

			if not var_1_10006 then
				table = var_7

				var_7.insert(arg_13_1, iter_13_0, {
					type = arg_13_0[iter_13_0].type
				})

				arg_13_1[iter_13_0].empty = true
			end
		end
	end

	for iter_13_2 = #arg_13_0 + 1, #arg_13_1 do
		table = var_1_10006

		var_1_10006.insert(arg_13_0, {
			type = arg_13_1[iter_13_2].type
		})

		var_1_10006 = arg_13_0[iter_13_2]
		var_1_10006.empty = true
	end

	return
end

function var_0_0.CompareInfo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.empty and 0 or arg_14_0.configAttr + arg_14_0.baseAttr

	arg_14_1.compare = (arg_14_1.empty and 0 or arg_14_1.configAttr + arg_14_1.baseAttr) - var_14_0

	return
end

function var_0_0.InsertAttrsCompare(arg_15_0, arg_15_1)
	var_0_0.AlignAttrs(arg_15_0, arg_15_1)

	for iter_15_0 = 1, #arg_15_0 do
		var_0_0.CompareInfo(arg_15_0[iter_15_0], arg_15_1[iter_15_0])
	end

	return
end

local function var_0_12(arg_16_0)
	local var_16_0 = arg_16_0:GetConfigAttributes()
	local var_16_1 = arg_16_0:GetBaseAttributes()

	return {
		{
			type = arg_16_0:getConfig("attribute_1"),
			configAttr = var_16_0[1],
			baseAttr = var_16_1[1]
		},
		{
			type = arg_16_0:getConfig("attribute_2"),
			configAttr = var_16_0[2],
			baseAttr = var_16_1[2]
		}
	}
end

local function var_0_13(arg_17_0, arg_17_1)
	local var_17_0 = {
		attrs = {}
	}

	for iter_17_0 = 1, #arg_17_0 do
		local var_17_1 = arg_17_0[iter_17_0]

		AttributeType = var_1_10008
		var_1_10008 = var_1_10008.Type2Name(var_17_1.type)

		local var_17_2

		if not var_17_1.empty then
			var_17_2 = var_17_1.configAttr .. " + " .. var_17_1.baseAttr

			if not arg_17_1:IsReal() then
				var_17_2 = var_17_2 .. "~" .. arg_17_1:GetAttributesRange()[iter_17_0]
			end
		else
			var_17_2 = 0
		end

		table = var_10

		var_10.insert(var_17_0.attrs, {
			name = var_1_10008,
			value = var_17_2,
			compare = var_17_1.compare
		})
	end

	local var_17_3 = arg_17_1:GetWearableShipTypes()

	var_17_0.part = {
		var_17_3,
		var_17_3
	}

	return var_17_0
end

function var_0_0.TransformNormalInfo(arg_18_0)
	local var_18_0 = var_0_12(arg_18_0)

	return var_0_13(var_18_0, arg_18_0)
end

function var_0_0.CompareNormalInfo(arg_19_0, arg_19_1)
	local var_19_0 = var_0_12(arg_19_0)
	local var_19_1 = var_0_12(arg_19_1)

	var_0_0.InsertAttrsCompare(var_19_0, var_19_1)

	local var_19_2 = var_0_13(var_19_0, arg_19_0)
	local var_19_3 = var_0_13(var_19_1, arg_19_1)
end

function var_0_0.TransformCompositeInfo(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = {
		arg_20_0:getConfig("attribute_1"),
		arg_20_0:getConfig("attribute_2")
	}
	local var_20_2 = arg_20_0:GetConfigAttributes()
	local var_20_3 = arg_20_0:GetAttributesRange()

	for iter_20_0 = 1, 2 do
		AttributeType = var_1_10009
		var_1_10009 = var_1_10009.Type2Name(var_20_1[iter_20_0])

		local var_20_4 = var_20_2[iter_20_0] .. " + 0~" .. var_20_3[iter_20_0]

		table = var_11

		var_11.insert(var_20_0, {
			name = var_1_10009,
			value = var_20_4
		})
	end

	return var_20_0
end

function var_0_0.TransformUpgradeInfo(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {
		arg_21_0:getConfig("attribute_1"),
		arg_21_0:getConfig("attribute_2")
	}
	local var_21_2 = arg_21_0:GetConfigAttributes()
	local var_21_3 = arg_21_1:GetConfigAttributes()
	local var_21_4 = arg_21_0:GetBaseAttributes()

	for iter_21_0 = 1, 2 do
		AttributeType = var_1_10011
		var_1_10011 = var_1_10011.Type2Name(var_21_1[iter_21_0])

		local var_21_5 = var_21_3[iter_21_0] .. " + " .. var_21_4[iter_21_0]

		if var_21_2[iter_21_0] ~= var_21_3[iter_21_0] then
			var_21_5 = var_21_2[iter_21_0] .. "   >   " .. var_21_5
		end

		table = var_13

		var_13.insert(var_21_0, {
			name = var_1_10011,
			value = var_21_5
		})
	end

	return var_21_0
end

return var_0_0
