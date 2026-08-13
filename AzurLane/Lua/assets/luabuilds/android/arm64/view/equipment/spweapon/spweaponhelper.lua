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

	triggerToggle = var_5

	var_5(var_1_0, arg_1_1.lock_open)

	local var_1_8

	if not arg_1_1.lock_open and arg_1_1.sub and #arg_1_1.sub > 0 then
		GetComponent = var_1_8

		local var_1_7 = var_1_0

		typeof = var_8
		Toggle = var_10
		var_1_8 = var_1_8(var_1_7, var_8(var_10))
		var_1_8.enabled = true
	else
		setActive = var_1_8

		var_1_8(var_1_0:Find("name/close"), false)

		setActive = var_1_8

		var_1_8(var_1_0:Find("name/open"), false)

		GetComponent = var_1_8

		local var_1_9 = var_1_0

		typeof = var_8
		Toggle = var_10
		var_1_8(var_1_9, var_8(var_10)).enabled = false
	end

	return
end

local function var_0_7(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:Find("desc")

	IsNil = var_1_10003

	if var_1_10003(var_2_0) then
		return
	end

	setActive = var_3

	var_3(var_2_0, arg_2_1.desc)

	if not arg_2_1.desc then
		return
	end

	setText = var_3

	var_3(var_2_0:Find("Text"), arg_2_1.desc)

	return
end

local function var_0_8(arg_3_0, arg_3_1)
	var_0_6(arg_3_0, arg_3_1)
	var_0_7(arg_3_0, arg_3_1)

	return
end

local function var_0_9(arg_4_0, arg_4_1, arg_4_2)
	removeAllChildren = var_1_10003

	var_1_10003(arg_4_0)
	var_0_5(arg_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_5(arg_5_0, arg_5_1, arg_5_2)
	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_2) do
		cloneTplTo = var_1_10008
		var_1_10008 = var_1_10008(arg_5_1, arg_5_0)

		var_0_8(var_1_10008, iter_5_1)
	end

	return
end

local function var_0_10(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:Find("attr_tpl")

	var_0_9(arg_6_0:Find("attrs"), var_6_0, arg_6_1.attrs)

	local var_6_1 = {}
	local var_6_2

	if arg_6_2[1].skillId > 0 then
		getSkillDesc = var_6_2
		var_6_2 = var_6_2(arg_6_2[1].skillId, arg_6_2[1].lv)

		if not arg_6_2[1].unlock then
			setColorStr = var_6
			i18n = var_8
			var_6_2 = var_6(var_8("spweapon_tip_skill_locked") .. var_6_2, "#a2a2a2")
		end

		table = var_6

		local var_6_3 = var_6.insert
		local var_6_4 = var_6_1
		local var_6_5 = {}

		i18n = var_1_10010
		var_6_5.name = var_1_10010("spweapon_attr_effect")
		setColorStr = var_1_10010
		getSkillName = var_12
		var_6_5.value = var_1_10010(var_12(arg_6_2[1].skillId), arg_6_2[1].unlock and "#FFDE00FF" or "#A2A2A2")
		var_6_5.desc = var_6_2

		var_6_3(var_6_4, var_6_5)
	end

	ipairs = var_6_2

	for iter_6_0, iter_6_1 in var_6_2(arg_6_2[2]) do
		getSkillDesc = var_1_10010
		var_1_10010 = var_1_10010(iter_6_1.skillId, iter_6_1.lv)

		if not iter_6_1.unlock then
			setColorStr = var_11
			i18n = var_13
			var_1_10010 = var_11(var_13("spweapon_tip_skill_locked") .. var_1_10010, "#a2a2a2")
		end

		table = var_11

		local var_6_6 = var_11.insert
		local var_6_7 = var_6_1

		iter_6_5 = {}
		i18n = var_1_10015
		iter_6_5.name = var_1_10015("spweapon_attr_skillupgrade")
		setColorStr = var_1_10015
		getSkillName = var_17
		iter_6_5.value = var_1_10015(var_17(iter_6_1.skillId), iter_6_1.unlock and "#FFDE00FF" or "#A2A2A2")
		iter_6_5.desc = var_1_10010

		var_6_6(var_6_7, iter_6_5)
	end

	var_0_5(arg_6_0:Find("attrs"), var_6_0, var_6_1)

	cloneTplTo = var_5

	local var_6_8 = var_6_0
	local var_6_9 = arg_6_0
	local var_6_10 = var_5(var_6_8, arg_6_0.Find(var_6_9, "part"))

	var_5.SetSiblingIndex(var_6_10, 0)

	local var_6_11 = var_0_8
	local var_6_12 = var_5
	local var_6_13 = {
		value = ""
	}

	i18n = var_6_9
	var_6_13.name = var_6_9("equip_info_23")

	var_6_11(var_6_12, var_6_13)

	local var_6_14 = arg_6_0:Find("part/value")
	local var_6_15 = var_6.Find(var_6_14, "label")
	local var_6_16 = {}
	local var_6_17 = {}

	if #arg_6_1.part[1] == 0 and #arg_6_1.part[2] == 0 then
		setmetatable = var_10

		var_10(var_6_16, {
			__index = function(arg_7_0, arg_7_1)
				return true
			end
		})

		setmetatable = var_10

		var_10(var_6_17, {
			__index = function(arg_8_0, arg_8_1)
				return true
			end
		})
	else
		ipairs = var_10

		for iter_6_2, iter_6_5 in var_10(arg_6_1.part[1]) do
			var_6_16[iter_6_5] = true
		end

		ipairs = var_10

		for iter_6_4, iter_6_5 in var_10(arg_6_1.part[2]) do
			var_6_17[iter_6_5] = true
		end
	end

	ShipType = var_10

	local var_6_18 = var_10.MergeFengFanType

	ShipType = var_12

	local var_6_19 = var_12.FilterOverQuZhuType

	ShipType = iter_6_5

	local var_6_20 = var_6_18(var_6_19(iter_6_5.AllShipType), var_6_16, var_6_17)

	UIItemList = var_11

	var_11.StaticAlign(var_6, var_6_15, #var_6_20, function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_1 = arg_9_1 + 1
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = var_6_20[arg_9_1]

			GetImageSpriteFromAtlasAsync = var_2_10004

			local var_9_1 = "shiptype"

			ShipType = var_2_10007

			var_2_10004(var_9_1, var_2_10007.Type2CNLabel(var_9_0), arg_9_2)

			setActive = var_2_10004

			local var_9_2 = arg_9_2:Find("main")
			local var_9_3

			if var_6_16[var_9_0] then
				var_9_3 = not var_6_17[var_9_0]
			end

			var_2_10004(var_9_2, var_9_3)

			setActive = var_2_10004

			local var_9_4 = arg_9_2:Find("sub")
			local var_9_5

			if var_6_17[var_9_0] then
				var_9_5 = not var_6_16[var_9_0]
			end

			var_2_10004(var_9_4, var_9_5)

			setImageAlpha = var_2_10004

			var_2_10004(arg_9_2, not var_6_16[var_9_0] and not var_6_17[var_9_0] and 0.3 or 1)
		end

		return
	end)

	setActive = var_11

	var_11(var_6_0, false)

	return
end

local var_0_11 = updateSpWeaponInfo

function var_0_0.AlignAttrs(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0 do
		if not arg_10_1[iter_10_0] or arg_10_0[iter_10_0].type ~= arg_10_1[iter_10_0].type then
			var_1_10006 = false

			for iter_10_1 = iter_10_0 + 1, #arg_10_1 do
				if arg_10_1[iter_10_0].type == arg_10_1[iter_10_1].type then
					table = var_11

					local var_10_0 = var_11.remove(arg_10_1, iter_10_1)

					table = var_12

					var_12.insert(arg_10_1, iter_10_0, var_10_0)

					var_1_10006 = true

					break
				end
			end

			if not var_1_10006 then
				table = var_7

				var_7.insert(arg_10_1, iter_10_0, {
					type = arg_10_0[iter_10_0].type
				})

				arg_10_1[iter_10_0].empty = true
			end
		end
	end

	for iter_10_2 = #arg_10_0 + 1, #arg_10_1 do
		table = var_1_10006

		var_1_10006.insert(arg_10_0, {
			type = arg_10_1[iter_10_2].type
		})

		var_1_10006 = arg_10_0[iter_10_2]
		var_1_10006.empty = true
	end

	return
end

function var_0_0.CompareInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.empty and 0 or arg_11_0.configAttr + arg_11_0.baseAttr

	arg_11_1.compare = (arg_11_1.empty and 0 or arg_11_1.configAttr + arg_11_1.baseAttr) - var_11_0

	return
end

function var_0_0.InsertAttrsCompare(arg_12_0, arg_12_1)
	var_0_0.AlignAttrs(arg_12_0, arg_12_1)

	for iter_12_0 = 1, #arg_12_0 do
		var_0_0.CompareInfo(arg_12_0[iter_12_0], arg_12_1[iter_12_0])
	end

	return
end

local function var_0_12(arg_13_0)
	local var_13_0 = arg_13_0:GetConfigAttributes()
	local var_13_1 = arg_13_0:GetBaseAttributes()

	return {
		{
			type = arg_13_0:getConfig("attribute_1"),
			configAttr = var_13_0[1],
			baseAttr = var_13_1[1]
		},
		{
			type = arg_13_0:getConfig("attribute_2"),
			configAttr = var_13_0[2],
			baseAttr = var_13_1[2]
		}
	}
end

local function var_0_13(arg_14_0, arg_14_1)
	local var_14_0 = {
		attrs = {}
	}

	for iter_14_0 = 1, #arg_14_0 do
		local var_14_1 = arg_14_0[iter_14_0]

		AttributeType = var_1_10008
		var_1_10008 = var_1_10008.Type2Name(var_14_1.type)

		local var_14_2

		if not var_14_1.empty then
			var_14_2 = var_14_1.configAttr .. " + " .. var_14_1.baseAttr

			if not arg_14_1:IsReal() then
				var_14_2 = var_14_2 .. "~" .. arg_14_1:GetAttributesRange()[iter_14_0]
			end
		else
			var_14_2 = 0
		end

		table = var_10

		var_10.insert(var_14_0.attrs, {
			name = var_1_10008,
			value = var_14_2,
			compare = var_14_1.compare
		})
	end

	local var_14_3 = arg_14_1:GetWearableShipTypes()

	var_14_0.part = {
		var_14_3,
		var_14_3
	}

	return var_14_0
end

function var_0_0.TransformNormalInfo(arg_15_0)
	local var_15_0 = var_0_12(arg_15_0)

	return var_0_13(var_15_0, arg_15_0)
end

function var_0_0.CompareNormalInfo(arg_16_0, arg_16_1)
	local var_16_0 = var_0_12(arg_16_0)
	local var_16_1 = var_0_12(arg_16_1)

	var_0_0.InsertAttrsCompare(var_16_0, var_16_1)

	local var_16_2 = var_0_13(var_16_0, arg_16_0)
	local var_16_3 = var_0_13(var_16_1, arg_16_1)
end

function var_0_0.TransformCompositeInfo(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = {
		arg_17_0:getConfig("attribute_1"),
		arg_17_0:getConfig("attribute_2")
	}
	local var_17_2 = arg_17_0:GetConfigAttributes()
	local var_17_3 = arg_17_0:GetAttributesRange()

	for iter_17_0 = 1, 2 do
		AttributeType = var_1_10009
		var_1_10009 = var_1_10009.Type2Name(var_17_1[iter_17_0])

		local var_17_4 = var_17_2[iter_17_0] .. " + 0~" .. var_17_3[iter_17_0]

		table = var_11

		var_11.insert(var_17_0, {
			name = var_1_10009,
			value = var_17_4
		})
	end

	return var_17_0
end

function var_0_0.TransformUpgradeInfo(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {
		arg_18_0:getConfig("attribute_1"),
		arg_18_0:getConfig("attribute_2")
	}
	local var_18_2 = arg_18_0:GetConfigAttributes()
	local var_18_3 = arg_18_1:GetConfigAttributes()
	local var_18_4 = arg_18_0:GetBaseAttributes()

	for iter_18_0 = 1, 2 do
		AttributeType = var_1_10011
		var_1_10011 = var_1_10011.Type2Name(var_18_1[iter_18_0])

		local var_18_5 = var_18_3[iter_18_0] .. " + " .. var_18_4[iter_18_0]

		if var_18_2[iter_18_0] ~= var_18_3[iter_18_0] then
			var_18_5 = var_18_2[iter_18_0] .. "   >   " .. var_18_5
		end

		table = var_13

		var_13.insert(var_18_0, {
			name = var_1_10011,
			value = var_18_5
		})
	end

	return var_18_0
end

return var_0_0
