local var_0_0 = {}
local var_0_5

local function var_0_6(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:Find("base")

	if IsNil(var_1_0) then
		return
	end

	local var_1_1 = arg_1_1.name

	setActive(var_1_0, arg_1_1.value)

	if not arg_1_1.value then
		return
	end

	setText(var_1_0:Find("name"), var_1_1)
	Canvas.ForceUpdateCanvases()

	if not IsNil(var_1_0:Find("value")) then
		setActive(var_1_0:Find("value"), arg_1_1.value)
		changeToScrollText(var_1_0:Find("value/Text"), arg_1_1.value)
	end

	if not IsNil(var_1_0:Find("effect")) then
		setActive(var_1_0:Find("effect"), false)
	end

	local var_1_3 = arg_1_1.compare and arg_1_1.compare > 0

	var_1_2(var_1_0:Find("value/up"), var_1_3)

	local var_1_4 = arg_1_1.compare and arg_1_1.compare < 0

	setActive(var_1_0:Find("value/down"), var_1_4)

	if not arg_1_1.lock_open and arg_1_1.sub and #arg_1_1.sub > 0 then
		onToggle(nil, var_1_0, function(arg_2_0)
			setActive(var_1_0:Find("sub"), arg_2_0)

			return
		end, SFX_PANEL)
		triggerToggle(var_1_0, arg_1_1.lock_open)

		GetComponent(var_1_0, typeof(Toggle)).enabled = true
	elseif arg_1_1.descTrigger ~= nil then
		local var_1_5 = arg_1_0:Find("desc")

		onToggle(nil, var_1_0, function(arg_3_0)
			setActive(var_1_5, arg_3_0)

			return
		end, SFX_PANEL)
		onButton(nil, arg_1_0:Find("desc"), function()
			triggerToggle(var_1_0, false)

			return
		end, SFX_PANEL)
		triggerToggle(var_1_0, arg_1_1.descTrigger)

		GetComponent(var_1_0, typeof(Toggle)).enabled = true
	else
		setActive(var_1_0:Find("name/close"), false)
		setActive(var_1_0:Find("name/open"), false)
		removeOnToggle(var_1_0)

		GetComponent(var_1_0, typeof(Toggle)).enabled = false
	end

	return
end

local function var_0_7(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:Find("desc")

	if IsNil(var_5_0) then
		return
	end

	if arg_5_1.descTrigger == nil then
		setActive(var_5_0, arg_5_1.desc)
	end

	if not arg_5_1.desc then
		return
	end

	setText(var_5_0:Find("Text"), arg_5_1.desc)

	return
end

local function var_0_8(arg_6_0, arg_6_1)
	var_0_6(arg_6_0, arg_6_1)
	var_0_7(arg_6_0, arg_6_1)

	return
end

local function var_0_9(arg_7_0, arg_7_1, arg_7_2)
	removeAllChildren(arg_7_0)
	var_0_5(arg_7_0, arg_7_1, arg_7_2)

	return
end

function var_0_5(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		var_0_8(cloneTplTo(arg_8_1, arg_8_0), iter_8_1)
	end

	return
end

function updateSpWeaponInfo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:Find("attr_tpl")

	var_0_9(arg_9_0:Find("attrs"), var_9_0, arg_9_1.attrs)

	local var_9_1 = {}

	if arg_9_2[1].skillId > 0 then
		local var_9_2 = getSkillDesc(arg_9_2[1].skillId, arg_9_2[1].lv)

		if not arg_9_2[1].unlock then
			var_9_2 = setColorStr(i18n("spweapon_tip_skill_locked") .. var_9_2, "#a2a2a2")
		end

		table.insert(var_9_1, {
			name = i18n("spweapon_attr_effect"),
			value = setColorStr(getSkillName(arg_9_2[1].skillId), arg_9_2[1].unlock and "#FFDE00FF" or "#A2A2A2"),
			desc = var_9_2,
			descTrigger = defaultValue(arg_9_2[1].descTrigger, arg_9_2[1].unlock)
		})
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_2[2]) do
		local var_9_3 = getSkillDesc(iter_9_1.skillId, iter_9_1.lv)

		if not iter_9_1.unlock then
			var_9_3 = setColorStr(i18n("spweapon_tip_skill_locked") .. var_9_3, "#a2a2a2")
		end

		table.insert(var_9_1, {
			name = i18n("spweapon_attr_skillupgrade"),
			value = setColorStr(getSkillName(iter_9_1.skillId), iter_9_1.unlock and "#FFDE00FF" or "#A2A2A2"),
			desc = var_9_3,
			descTrigger = defaultValue(iter_9_1.descTrigger, iter_9_1.unlock)
		})
	end

	var_0_5(arg_9_0:Find("attrs"), var_9_0, var_9_1)

	local var_9_4 = cloneTplTo(var_9_0, arg_9_0:Find("part"))

	var_9_4:SetSiblingIndex(0)
	var_0_8(var_9_4, {
		value = "",
		name = i18n("equip_info_23")
	})

	local var_9_5 = arg_9_0:Find("part/value")
	local var_9_6 = var_9_5:Find("label")
	local var_9_7 = {}
	local var_9_8 = {}

	if #arg_9_1.part[1] == 0 and #arg_9_1.part[2] == 0 then
		setmetatable(var_9_7, {
			__index = function(arg_10_0, arg_10_1)
				return true
			end
		})
		setmetatable(var_9_8, {
			__index = function(arg_11_0, arg_11_1)
				return true
			end
		})
	else
		for iter_9_2, iter_9_3 in ipairs(arg_9_1.part[1]) do
			var_9_7[iter_9_3] = true
		end

		for iter_9_4, iter_9_5 in ipairs(arg_9_1.part[2]) do
			var_9_8[iter_9_5] = true
		end
	end

	UIItemList.StaticAlign(var_9_5, var_9_6, #ShipType.MergeFengFanType(ShipType.FilterOverQuZhuType(ShipType.AllShipType), var_9_7, var_9_8), function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1

		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = var_0[arg_12_1]

			GetImageSpriteFromAtlasAsync("shiptype", ShipType.Type2CNLabel(var_0[arg_12_1]), arg_12_2)

			local var_12_1 = var_9_7[var_12_0] and not var_9_8[var_12_0]

			setActive(arg_12_2:Find("main"), var_12_1)

			local var_12_2 = var_9_8[var_12_0] and not var_9_7[var_12_0]

			setActive(arg_12_2:Find("sub"), var_12_2)
			setImageAlpha(arg_12_2, not var_9_7[var_12_0] and not var_9_8[var_12_0] and 0.3 or 1)
		end

		return
	end)
	setActive(var_9_0, false)

	return
end

;({}).AlignAttrs = function(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_0 do
		if not arg_13_1[iter_13_0] or arg_13_0[iter_13_0].type ~= arg_13_1[iter_13_0].type then
			local var_13_0 = false

			for iter_13_1 = iter_13_0 + 1, #arg_13_1 do
				if arg_13_1[iter_13_0].type == arg_13_1[iter_13_1].type then
					table.insert(arg_13_1, iter_13_0, (table.remove(arg_13_1, iter_13_1)))

					var_13_0 = true

					break
				end
			end

			if not var_13_0 then
				table.insert(arg_13_1, iter_13_0, {
					type = arg_13_0[iter_13_0].type
				})

				arg_13_1[iter_13_0].empty = true
			end
		end
	end

	for iter_13_2 = #arg_13_0 + 1, #arg_13_1 do
		table.insert(arg_13_0, {
			type = arg_13_1[iter_13_2].type
		})

		arg_13_0[iter_13_2].empty = true
	end

	return
end
;({}).CompareInfo = function(arg_14_0, arg_14_1)
	arg_14_1.compare = (arg_14_1.empty and 0 or arg_14_1.configAttr + arg_14_1.baseAttr) - (arg_14_0.empty and 0 or arg_14_0.configAttr + arg_14_0.baseAttr)

	return
end
;({}).InsertAttrsCompare = function(arg_15_0, arg_15_1)
	var_0_0.AlignAttrs(arg_15_0, arg_15_1)

	for iter_15_0 = 1, #arg_15_0 do
		var_0_0.CompareInfo(arg_15_0[iter_15_0], arg_15_1[iter_15_0])
	end

	return
end

local function var_0_10(arg_16_0)
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

local function var_0_11(arg_17_0, arg_17_1)
	for iter_17_0 = 1, #arg_17_0 do
		local var_17_0 = arg_17_0[iter_17_0]
		local var_17_1 = AttributeType.Type2Name(arg_17_0[iter_17_0].type)
		local var_17_2

		if not arg_17_0[iter_17_0].empty then
			var_17_2 = var_17_0.configAttr .. " + " .. var_17_0.baseAttr

			if not arg_17_1:IsReal() then
				var_17_2 = var_17_2 .. "~" .. arg_17_1:GetAttributesRange()[iter_17_0]
			end
		else
			var_17_2 = 0
		end

		table.insert(({
			attrs = {}
		}).attrs, {
			name = var_17_1,
			value = var_17_2,
			compare = var_17_0.compare
		})
	end

	local var_17_3 = arg_17_1:GetWearableShipTypes()

	;({
		attrs = {}
	}).part = {
		var_17_3,
		var_17_3
	}

	return {
		attrs = {}
	}
end

;({}).TransformNormalInfo = function(arg_18_0)
	return var_0_11(var_0_10(arg_18_0), arg_18_0)
end
;({}).CompareNormalInfo = function(arg_19_0, arg_19_1)
	local var_19_0 = var_0_10(arg_19_0)
	local var_19_1 = var_0_10(arg_19_1)

	var_0_0.InsertAttrsCompare(var_19_0, var_19_1)

	local var_19_2 = var_0_11(var_19_0, arg_19_0)
	local var_19_3 = var_0_11(var_19_1, arg_19_1)
end
;({}).TransformCompositeInfo = function(arg_20_0)
	local var_20_0 = {
		arg_20_0:getConfig("attribute_1"),
		arg_20_0:getConfig("attribute_2")
	}
	local var_20_1 = arg_20_0:GetConfigAttributes()
	local var_20_2 = arg_20_0:GetAttributesRange()

	for iter_20_0 = 1, 2 do
		table.insert({}, {
			name = AttributeType.Type2Name(var_20_0[iter_20_0]),
			value = var_20_1[iter_20_0] .. " + 0~" .. var_20_2[iter_20_0]
		})
	end

	return {}
end
;({}).TransformUpgradeInfo = function(arg_21_0, arg_21_1)
	local var_21_0 = {
		arg_21_0:getConfig("attribute_1"),
		arg_21_0:getConfig("attribute_2")
	}
	local var_21_1 = arg_21_0:GetConfigAttributes()
	local var_21_2 = arg_21_1:GetConfigAttributes()
	local var_21_3 = arg_21_0:GetBaseAttributes()

	for iter_21_0 = 1, 2 do
		local var_21_4 = AttributeType.Type2Name(var_21_0[iter_21_0])
		local var_21_5 = var_21_2[iter_21_0] .. " + " .. var_21_3[iter_21_0]

		if var_21_1[iter_21_0] ~= var_21_2[iter_21_0] then
			var_21_5 = var_21_1[iter_21_0] .. "   >   " .. var_21_5
		end

		table.insert({}, {
			name = var_21_4,
			value = var_21_5
		})
	end

	return {}
end

return {}
