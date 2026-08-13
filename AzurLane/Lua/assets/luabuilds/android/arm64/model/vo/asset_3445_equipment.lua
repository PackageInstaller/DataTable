class = var_0_10000

local var_0_0 = "Equipment"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.EQUIPMENT_STATE_LOCK = 1
var_0_1.EQUIPMENT_STATE_EMPTY = 0
var_0_1.EQUIPMENT_NORMAL = 1
var_0_1.EQUIPMENT_IMPORTANCE = 2
pg = var_1

local var_0_2 = var_1.equip_skin_template

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id

	local var_1_0

	if not arg_1_1.config_id then
		var_1_0 = arg_1_0.id
	end

	arg_1_0.configId = var_1_0

	arg_1_0:InitConfig()

	defaultValue = var_2
	arg_1_0.count = var_2(arg_1_1.count, 0)
	defaultValue = var_2
	arg_1_0.new = var_2(arg_1_1.new, 0)
	defaultValue = var_2
	arg_1_0.isSkin = var_2(arg_1_1.isSkin, false)

	local var_1_1

	if not arg_1_1.skinId then
		var_1_1 = 0
	end

	arg_1_0.skinId = var_1_1

	return
end

function var_0_1.getConfigData(arg_2_0)
	local var_2_0 = {}

	pg = var_1_10002
	var_2_0[1] = var_1_10002.equip_data_statistics
	pg = var_2
	var_2_0[2] = var_2.equip_data_template

	local var_2_1

	underscore = var_1_10003

	if var_1_10003.any(var_2_0, function(arg_3_0)
		return arg_3_0[arg_2_0] ~= nil
	end) then
		setmetatable = var_3

		if var_3({}, {
			__index = function(arg_4_0, arg_4_1)
				ipairs = var_2_10002

				for iter_4_0, iter_4_1 in var_2_10002(var_2_0) do
					if iter_4_1[arg_2_0] and iter_4_1[arg_2_0][arg_4_1] ~= nil then
						arg_4_0[arg_4_1] = iter_4_1[arg_2_0][arg_4_1]

						return arg_4_0[arg_4_1]
					end
				end

				return
			end
		}).weapon_id and #var_3 > 0 then
			pg = var_4

			local var_2_2 = var_4.weapon_property[var_3[1]]

			AttributeType = var_5
			var_2_1[var_5.CD] = var_2_2 and var_2_2.reload_max
		end
	end

	return var_2_1
end

function var_0_1.InitConfig(arg_5_0)
	arg_5_0.cfg = var_0_1.getConfigData(arg_5_0.configId)
	IsUnityEditor = var_1

	if not var_1 then
		arg_5_0.config = arg_5_0.cfg
	end

	assert = var_1

	local var_5_0 = arg_5_0.cfg

	string = var_1_10004

	var_1(var_5_0, var_1_10004.format("without equip config from id_%d", arg_5_0.id))

	return
end

function var_0_1.getConfigTable(arg_6_0)
	return arg_6_0.cfg
end

function var_0_1.GetAttributes(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, 3 do
		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.getConfig(var_7_1, "attribute_" .. iter_7_0)
		local var_7_3 = arg_7_0
		local var_7_4 = arg_7_0.getConfig(var_7_3, "value_" .. iter_7_0)

		if var_7_2 ~= nil then
			var_7_1 = {
				type = var_7_2
			}
			string = var_7_3

			if var_7_3.match(var_7_4, "^[%d|\\.]+$") then
				tonumber = var_9

				local var_7_5

				if not var_9(var_7_4) then
					var_7_5 = var_7_4
				end

				var_7_1.value = var_7_5
				var_7_1.auxBoost = arg_7_0:isDevice()

				if not var_7_1 then
					var_7_1 = false
				end

				var_7_0[iter_7_0] = var_7_1
			end
		end
	end

	return var_7_0
end

function var_0_1.GetPropertyRate(arg_8_0)
	return arg_8_0:getConfig("property_rate")
end

function var_0_1.CanInBag(arg_9_0)
	tobool = var_1_10001
	pg = var_1_10003

	return var_1_10001(var_1_10003.equip_data_template[arg_9_0])
end

function var_0_1.vertify(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.equip_data_statistics[arg_10_0.configId]

	pg = var_2

	local var_10_1 = var_2.equip_data_template[arg_10_0.configId]

	if arg_10_0:getConfig("value_1") ~= var_10_0.value_1 or arg_10_0:getConfig("value_2") ~= var_10_0.value_2 then
		return false
	end

	return true
end

function var_0_1.CalcWeanponCD(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0 or 0
	local var_11_1

	if not arg_11_1 or not arg_11_1:getProperties().reload then
		var_11_1 = 100
	end

	string = var_1_10004

	local var_11_2 = var_1_10004.format
	local var_11_3 = "%0.2f"

	ys = var_1_10007

	return var_11_2(var_11_3, var_1_10007.Battle.BattleFormulas.CalculateReloadTime(var_11_0, var_11_1))
end

local var_0_3 = {
	equip_info_34 = "equip_info_33",
	attribute_cd = "cd_normal"
}
local var_0_4

local function var_0_5(arg_12_0)
	if not var_0_4 then
		var_0_4 = {}
		pairs = var_1

		for iter_12_0, iter_12_1 in var_1(var_0_3) do
			local var_12_0 = var_0_4

			i18n = var_1_10007
			var_1_10007 = var_1_10007(iter_12_0)
			i18n = var_1_10008
			var_12_0[var_1_10007] = var_1_10008(iter_12_1)
		end
	end

	return var_0_4[arg_12_0]
end

function var_0_1.GetInfoTrans(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.name
	local var_13_1 = arg_13_0.value
	local var_13_2 = arg_13_0.auxBoost
	local var_13_3 = arg_13_0.type

	AttributeType = var_1_10006

	local var_13_4

	if var_13_3 == var_1_10006.CD then
		var_13_3 = var_0_1.CalcWeanponCD(var_13_1, arg_13_1)
		var_13_4 = "s"
		pg = var_7
		var_13_1 = var_13_3 .. var_13_4 .. var_7.equip_data_code.WAVE.text
	else
		var_13_3 = arg_13_0.type
		AttributeType = var_13_4

		if var_13_3 == var_13_4.AirDurability then
			if not arg_13_1 or not arg_13_1.level then
				var_13_3 = 100
			end

			math = var_6
			var_13_1 = var_6.floor(var_13_1[1] + var_13_1[2] * (var_13_3 - 1) / 1000)
		else
			var_13_3 = arg_13_0.type
			AttributeType = var_6

			if var_13_3 == var_6.AntiSiren then
				math = var_13_3
				var_13_1 = var_13_3.floor(var_13_1 / 100)
				var_13_3 = 0 < var_13_1 and "+" or var_13_1 < 0 and "-" or ""
				var_13_1 = var_13_3 .. var_13_1 .. "%"
			end
		end
	end

	if not var_13_0 then
		AttributeType = var_13_3
		var_13_0 = var_13_3.Type2Name(arg_13_0.type)
	end

	if not arg_13_1 then
		defaultValue = var_13_3
		var_13_0 = var_13_3(var_0_5(var_13_0), var_13_0)
	end

	var_13_1 = var_13_1 or ""

	if var_13_2 and arg_13_1 then
		::label_13_0::

		table = var_13_3

		local var_13_5 = var_13_3.contains
		local var_13_6 = arg_13_1:getSpecificType()

		ShipType = var_1_10008
		var_13_2 = var_13_5(var_13_6, var_1_10008.SpecificTypeTable.auxiliary)
	end

	return var_13_0, var_13_1, var_13_2
end

local function var_0_6(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.equip_data_code.WAVE.text

	string = var_1_10002

	if var_1_10002.match(arg_14_0, var_14_0) then
		string = var_2
		arg_14_0 = var_2.gsub(arg_14_0, var_14_0, "")
	end

	string = var_2
	arg_14_0 = var_2.gsub(arg_14_0, " ", "")

	local var_14_1 = {}

	string = var_1_10003
	var_14_1[1] = var_1_10003.match(arg_14_0, "~(%d+)")

	local var_14_2 = #var_14_1

	if 0 < var_14_2 then
		string = var_14_2
		arg_14_0 = var_14_2.gsub(arg_14_0, "~" .. var_14_1[1], "")
	end

	local var_14_3 = {}

	string = var_4
	var_14_3[1] = var_4.match(arg_14_0, "(%d+)x(%d+)")

	local var_14_4 = var_14_3

	while #var_14_4 > 0 do
		local var_14_5 = var_14_4[1]
		local var_14_6 = var_14_4[2]

		string = var_14_7
		arg_14_0 = var_14_7.gsub(arg_14_0, var_14_5 .. "x" .. var_14_6, var_14_5 * var_14_6, 1)

		local var_14_7 = {}

		string = var_6
		var_14_7[1] = var_6.match(arg_14_0, "(%d+)x(%d+)")
		var_14_4 = var_14_7
	end

	tonumber = var_14_5

	return var_14_5(arg_14_0)
end

function var_0_1.AlignAttrs(arg_15_0, arg_15_1)
	for iter_15_0 = 1, #arg_15_0 do
		if not arg_15_1[iter_15_0] or arg_15_0[iter_15_0].type ~= arg_15_1[iter_15_0].type then
			table = var_1_10006
			var_1_10006 = var_1_10006.insert

			local var_15_0 = arg_15_1

			iter_15_1 = iter_15_0
			Clone = var_1_10010

			var_1_10006(var_15_0, iter_15_1, var_1_10010(arg_15_0[iter_15_0]))

			var_1_10006 = arg_15_1[iter_15_0]
			var_1_10006.value = 0

			for iter_15_1 = iter_15_0 + 1, #arg_15_1 do
				if arg_15_1[iter_15_0].type == arg_15_1[iter_15_1].type then
					var_1_10010 = arg_15_1[iter_15_0]
					var_1_10010.value = arg_15_1[iter_15_1].value
					table = var_1_10010

					var_1_10010.remove(arg_15_1, iter_15_1)

					break
				end
			end
		end
	end

	for iter_15_2 = #arg_15_0 + 1, #arg_15_1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_15_1 = arg_15_0

		Clone = iter_15_1

		var_1_10006(var_15_1, iter_15_1(arg_15_1[iter_15_2]))

		var_1_10006 = arg_15_0[iter_15_2]
		var_1_10006.value = 0
	end

	return
end

function var_0_1.CompareInfo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.type

	AttributeType = var_1_10004

	if var_16_0 == var_1_10004.Damage then
		local var_16_1 = var_0_6(arg_16_0.value)

		arg_16_1.compare = var_0_6(arg_16_1.value) - var_16_1
	else
		local var_16_2 = arg_16_0.type

		AttributeType = var_4

		if var_16_2 == var_4.CD then
			local var_16_3 = var_0_1.CalcWeanponCD(arg_16_0.value, arg_16_2)

			arg_16_1.compare = -(var_0_1.CalcWeanponCD(arg_16_1.value, arg_16_2) - var_16_3)
		else
			arg_16_1.compare = arg_16_1.value - arg_16_0.value
		end
	end

	return
end

function var_0_1.InsertAttrsUpgrade(arg_17_0, arg_17_1, arg_17_2)
	var_0_1.AlignAttrs(arg_17_0, arg_17_1)

	for iter_17_0 = #arg_17_0, 1, -1 do
		if arg_17_0[iter_17_0].value == arg_17_1[iter_17_0].value then
			if not arg_17_2 then
				table = var_7

				var_7.remove(arg_17_0, iter_17_0)

				table = var_7

				var_7.remove(arg_17_1, iter_17_0)
			end
		else
			arg_17_0[iter_17_0].nextValue = arg_17_1[iter_17_0].value
		end
	end

	return
end

function var_0_1.InsertAttrsCompare(arg_18_0, arg_18_1, arg_18_2)
	var_0_1.AlignAttrs(arg_18_0, arg_18_1)

	for iter_18_0 = 1, #arg_18_0 do
		var_0_1.CompareInfo(arg_18_0[iter_18_0], arg_18_1[iter_18_0], arg_18_2)
	end

	return
end

function var_0_1.GetPropertiesInfo(arg_19_0)
	local var_19_0 = {
		attrs = {}
	}
	local var_19_1 = arg_19_0
	local var_19_2 = arg_19_0.getConfig

	AttributeType = var_1_10005

	local var_19_5

	if var_19_2(var_19_1, var_1_10005.Damage) then
		table = var_2

		local var_19_3 = var_2.insert
		local var_19_4 = var_19_0.attrs

		var_19_5 = {}
		AttributeType = var_1_10006
		var_19_5.type = var_1_10006.Damage
		var_1_10008 = arg_19_0
		var_1_10006 = arg_19_0.getConfig
		AttributeType = var_1_10009
		var_19_5.value = var_1_10006(var_1_10008, var_1_10009.Damage)

		var_19_3(var_19_4, var_19_5)
	end

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_0.getConfig

	AttributeType = var_19_5

	local var_19_8

	if var_19_7(var_19_6, var_19_5.CD) then
		var_19_8 = {}
		AttributeType = var_1_10003
		var_19_8.type = var_1_10003.CD

		local var_19_9 = arg_19_0
		local var_19_10 = arg_19_0.getConfig

		AttributeType = var_1_10006
		var_19_8.value = var_19_10(var_19_9, var_1_10006.CD)
		table = var_3

		var_3.insert(var_19_0.attrs, var_19_8)

		if arg_19_0:isAircraftExtend() and arg_19_0:getConfig("weapon_id") then
			var_19_8.sub = {}
			ipairs = var_3
			iter_19_1 = arg_19_0

			for iter_19_0, iter_19_1 in var_3(arg_19_0.getConfig(iter_19_1, "weapon_id")) do
				pg = var_1_10008

				if var_1_10008.weapon_property[iter_19_1].type == 11 then
					table = var_1_10008
					var_1_10008 = var_1_10008.insert

					local var_19_11 = var_19_8.sub
					local var_19_12 = {}

					i18n = var_1_10012
					var_19_12.name = var_1_10012("equip_info_34")
					AttributeType = var_1_10012
					var_19_12.type = var_1_10012.CD
					pg = var_1_10012
					var_19_12.value = var_1_10012.weapon_property[iter_19_1].reload_max

					var_1_10008(var_19_11, var_19_12)
				end
			end
		end
	end

	ipairs = var_19_8

	for iter_19_2, iter_19_3 in var_19_8(arg_19_0:GetAttributes()) do
		if iter_19_3 then
			iter_19_1 = iter_19_3.type
			AttributeType = var_1_10008

			if iter_19_1 ~= var_1_10008.OxyRaidDistance then
				table = iter_19_1

				iter_19_1.insert(var_19_0.attrs, iter_19_3)
			end
		end
	end

	if arg_19_0:GetAntiSirenPower() then
		table = var_2

		local var_19_13 = var_2.insert
		local var_19_14 = var_19_0.attrs
		local var_19_15 = {}

		AttributeType = iter_19_3
		var_19_15.type = iter_19_3.AntiSiren
		var_19_15.value = arg_19_0:GetAntiSirenPower()

		var_19_13(var_19_14, var_19_15)
	end

	local var_19_16 = arg_19_0

	if arg_19_0.GetSonarProperty(var_19_16) then
		table = var_3

		local var_19_17 = var_3.insert
		local var_19_18 = var_19_0.attrs
		local var_19_19 = {}

		AttributeType = iter_19_1
		var_19_19.type = iter_19_1.SonarRange
		AttributeType = var_7
		var_19_19.value = var_2[var_7.SonarRange]

		var_19_17(var_19_18, var_19_19)
	end

	local var_19_20 = {
		lock_open = true
	}

	i18n = var_19_16
	var_19_20.name = var_19_16(arg_19_0:isAircraftExtend() and "equip_info_24" or "equip_info_5")
	var_19_20.sub = {}
	var_19_0.weapon = var_19_20
	ipairs = var_19_20

	for iter_19_4, iter_19_5 in var_19_20(arg_19_0:getConfig("ammo_info")) do
		table = var_8

		var_8.insert(var_19_0.weapon.sub, arg_19_0:GetWeaponPageInfo(iter_19_5[1], iter_19_5[2]))
	end

	local var_19_21 = {}

	i18n = var_4
	var_19_21.name = var_4("equip_info_14")
	var_19_21.sub = {}
	var_19_0.equipInfo = var_19_21
	ipairs = var_19_21

	for iter_19_6, iter_19_7 in var_19_21(arg_19_0:getConfig("equip_info")) do
		table = var_8

		var_8.insert(var_19_0.equipInfo.sub, arg_19_0:GetEquipAttrPageInfo(iter_19_7))
	end

	var_19_0.part = {
		arg_19_0:getConfig("part_main"),
		arg_19_0:getConfig("part_sub")
	}
	var_19_0.equipmentType = arg_19_0:getConfig("type")

	return var_19_0
end

function var_0_1.GetWeaponPageInfo(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	pg = var_1_10004

	local var_20_1 = var_1_10004.equip_bullet_type[arg_20_1].exhibition_type == 2

	ipairs = var_1_10006

	for iter_20_0, iter_20_1 in var_1_10006(var_4.exhibition_list) do
		if not var_20_0 then
			var_20_0 = arg_20_0:GetWeaponInfo(iter_20_1, arg_20_2, var_20_1)
			var_20_0.sub = {}
		else
			table = var_1_10011

			var_1_10011.insert(var_20_0.sub, arg_20_0:GetWeaponInfo(iter_20_1, arg_20_2, var_20_1))
		end
	end

	return var_20_0
end

function var_0_1.GetWeaponInfo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_3 then
		pg = var_1_10004

		local var_21_0

		if not var_1_10004.weapon_property[arg_21_2].bullet_ID[1] then
			var_21_0 = arg_21_2
		end

		switch = var_1_10005

		return var_1_10005(arg_21_1, {
			function()
				local var_22_0 = {}

				i18n = var_2_10001

				local var_22_1 = "equip_ammo_type_"
				local var_22_2 = arg_21_0
				local var_22_3 = var_4.getConfig

				AttributeType = var_2_10007
				var_22_0.name = var_2_10001(var_22_1 .. var_22_3(var_22_2, var_2_10007.Ammo))

				return var_22_0
			end,
			function()
				local var_23_0 = {}

				pg = var_2_10001
				var_23_0.name = var_2_10001.weapon_name[arg_21_2].name

				return var_23_0
			end,
			function()
				local var_24_0 = {}

				AttributeType = var_2_10001
				var_24_0.type = var_2_10001.Damage
				pg = var_1
				var_24_0.value = var_1.weapon_property[arg_21_2].damage

				return var_24_0
			end,
			function()
				local var_25_0 = {}

				i18n = var_2_10001
				var_25_0.name = var_2_10001("equip_info_6")
				pg = var_1
				var_25_0.value = var_1.bullet_template[var_21_0].velocity

				return var_25_0
			end,
			function()
				local var_26_0 = {}

				i18n = var_2_10001
				var_26_0.name = var_2_10001("equip_info_7")
				pg = var_1
				var_26_0.value = var_1.bullet_template[var_21_0].velocity

				return var_26_0
			end,
			function()
				pg = var_2_10000

				local var_27_0 = var_2_10000.bullet_template[var_21_0].damage_type
				local var_27_1 = {}

				i18n = var_2_10002
				var_27_1.name = var_2_10002("equip_info_8")
				var_27_1.value = var_27_0[1] * 100 .. "-" .. var_27_0[2] * 100 .. "-" .. var_27_0[3] * 100

				return var_27_1
			end,
			function()
				local var_28_0 = {}

				i18n = var_2_10001
				var_28_0.name = var_2_10001("equip_info_9")
				pg = var_1
				var_28_0.value = var_1.bullet_template[var_21_0].hit_type.range

				return var_28_0
			end,
			function()
				local var_29_0 = {}

				i18n = var_2_10001
				var_29_0.name = var_2_10001("equip_info_10")
				pg = var_1
				var_29_0.value = var_1.weapon_property[arg_21_2].range

				return var_29_0
			end,
			function()
				local var_30_0 = {}

				i18n = var_2_10001
				var_30_0.name = var_2_10001("equip_info_11")
				pg = var_1
				var_30_0.value = var_1.weapon_property[arg_21_2].angle

				return var_30_0
			end,
			function()
				local var_31_0 = {}

				i18n = var_2_10001
				var_31_0.name = var_2_10001("equip_info_12")
				pg = var_1

				local var_31_1

				if not var_1.bullet_template[var_21_0].extra_param.randomOffsetX then
					var_31_1 = "0"
				end

				local var_31_2 = "*"

				pg = var_3

				local var_31_3

				if not var_3.bullet_template[var_21_0].extra_param.randomOffsetZ then
					var_31_3 = "0"
				end

				var_31_0.value = var_31_1 .. var_31_2 .. var_31_3

				return var_31_0
			end,
			function()
				local var_32_0 = {}

				i18n = var_2_10001
				var_32_0.name = var_2_10001("equip_info_13")

				local var_32_1 = arg_21_0
				local var_32_2 = var_1.getConfig

				AttributeType = var_2_10004
				var_32_0.value = var_32_2(var_32_1, var_2_10004.Speciality)

				return var_32_0
			end,
			function()
				local var_33_0 = {}

				AttributeType = var_2_10001
				var_33_0.type = var_2_10001.CD
				pg = var_1
				var_33_0.value = var_1.weapon_property[arg_21_2].reload_max

				return var_33_0
			end,
			function()
				local var_34_0 = {}

				i18n = var_2_10001
				var_34_0.name = var_2_10001("attribute_max_distance_damage")
				pg = var_1
				var_34_0.value = (1 - var_1.bullet_template[var_21_0].hit_type.decay) * 100 .. "%"

				return var_34_0
			end
		})
	end
end

local var_0_7 = {
	true,
	true,
	true,
	13,
	true,
	[nil] = nil
}

function var_0_1.GetEquipAttrPageInfo(arg_35_0, arg_35_1)
	local var_35_0
	local var_35_1

	type = var_1_10004

	local var_35_2

	if var_1_10004(arg_35_1) == "table" then
		var_35_2 = arg_35_1[1]
		var_35_1 = arg_35_1[2]
		var_35_0 = var_35_2
	else
		var_35_2 = arg_35_1
		var_1_10007 = arg_35_0
		var_35_1 = arg_35_0.getConfig(var_1_10007, "weapon_id")[1]
		var_35_0 = var_35_2
	end

	assert = var_35_2
	tobool = var_6

	local var_35_3 = var_6(var_0_7[var_35_0])

	type = var_1_10007

	var_35_2(var_35_3 == (var_1_10007(arg_35_1) == "table"), "equip attr sid type error from equip:" .. arg_35_0.id)

	return arg_35_0:GetEquipAttrInfo(var_35_0, var_35_1)
end

function var_0_1.GetEquipAttrInfo(arg_36_0, arg_36_1, arg_36_2)
	switch = var_1_10003

	return var_1_10003(arg_36_1, {
		function()
			pg = var_2_10000

			local var_37_0 = var_2_10000.weapon_property[arg_36_2]
			local var_37_1 = {}

			i18n = var_2_10002
			var_37_1.name = var_2_10002("equip_info_15")

			local var_37_2

			if var_37_0.min_range ~= 0 or not var_37_0.range then
				var_37_2 = var_37_0.min_range .. "-" .. var_37_0.range
			end

			var_37_1.value = var_37_2

			return var_37_1
		end,
		function()
			local var_38_0 = {}

			i18n = var_2_10001
			var_38_0.name = var_2_10001("equip_info_16")
			pg = var_1
			var_38_0.value = var_1.weapon_property[arg_36_2].angle

			return var_38_0
		end,
		function()
			pg = var_2_10000

			local var_39_0 = var_2_10000.bullet_template[arg_36_2]
			local var_39_1 = {}

			i18n = var_2_10002
			var_39_1.name = var_2_10002("equip_info_17")
			var_39_1.value = var_39_0.range - var_39_0.range_offset .. "-" .. var_39_0.range + var_39_0.range_offset

			return var_39_1
		end,
		function()
			pg = var_2_10000

			local var_40_0 = var_2_10000.barrage_template[arg_36_2]
			local var_40_1 = {}

			i18n = var_2_10002
			var_40_1.name = var_2_10002("equip_info_18")

			local var_40_2

			if not var_40_0.random_angle or not var_40_0.angle then
				math = var_40_2
				var_40_2 = var_40_2.abs(var_40_0.delta_angle) * var_40_0.primal_repeat
			end

			var_40_1.value = var_40_2

			return var_40_1
		end,
		function()
			local var_41_0 = {}

			i18n = var_2_10001
			var_41_0.name = var_2_10001("attribute_scatter")
			pg = var_1
			var_41_0.value = var_1.bullet_template[arg_36_2].extra_param.randomOffsetX

			return var_41_0
		end,
		function()
			local var_42_0 = {}

			i18n = var_2_10001
			var_42_0.name = var_2_10001("equip_info_19")
			Nation = var_1

			local var_42_1 = var_1.Nation2Name
			local var_42_2 = arg_36_0

			var_42_0.value = var_42_1(var_3.getConfig(var_42_2, "nationality"))

			return var_42_0
		end,
		function()
			pg = var_2_10000

			local var_43_0 = var_2_10000.aircraft_template[arg_36_0.id]
			local var_43_1 = {}

			i18n = var_2_10002
			var_43_1.name = var_2_10002("equip_info_20")
			var_43_1.value = var_43_0.speed

			return var_43_1
		end,
		function()
			pg = var_2_10000

			local var_44_0 = var_2_10000.aircraft_template[arg_36_0.id]
			local var_44_1 = {}

			i18n = var_2_10002
			var_44_1.name = var_2_10002("equip_info_21")
			AttributeType = var_2
			var_44_1.type = var_2.AirDurability
			var_44_1.value = {
				var_44_0.max_hp,
				var_44_0.hp_growth
			}

			return var_44_1
		end,
		function()
			pg = var_2_10000

			local var_45_0 = var_2_10000.aircraft_template[arg_36_0.id]
			local var_45_1 = {}

			i18n = var_2_10002
			var_45_1.name = var_2_10002("equip_info_22")
			var_45_1.value = var_45_0.dodge_limit

			return var_45_1
		end,
		function()
			PLATFORM_CODE = var_2_10000
			PLATFORM_JP = var_2_10001

			if var_2_10000 ~= var_2_10001 then
				PLATFORM_CODE = var_2_10000
				PLATFORM_US = var_2_10001

				if var_2_10000 == var_2_10001 then
					local var_46_0 = {}

					i18n = var_2_10001
					var_46_0.name = var_2_10001("equip_info_28")
					AttributeType = var_2_10001
					var_46_0.type = var_2_10001.Corrected
					EquipmentRarity = var_2_10001
					var_2_10001 = var_2_10001.Rarity2CorrectedLevel

					local var_46_1 = arg_36_0
					local var_46_2 = var_3.getConfig(var_46_1, "rarity")
					local var_46_3 = arg_36_0

					var_46_0.value = var_2_10001(var_46_2, var_4.getConfig(var_46_3, "level"))

					return var_46_0
				else
					local var_46_4 = {}

					i18n = var_2_10001
					var_46_4.name = var_2_10001("equip_info_28")
					AttributeType = var_1
					var_46_4.type = var_1.Corrected
					pg = var_1
					var_46_4.value = var_1.weapon_property[arg_36_2].corrected .. "%"

					return var_46_4
				end

				return
			end
		end,
		function()
			PLATFORM_CODE = var_2_10000
			PLATFORM_JP = var_2_10001

			if var_2_10000 ~= var_2_10001 then
				PLATFORM_CODE = var_2_10000
				PLATFORM_US = var_2_10001

				if var_2_10000 == var_2_10001 then
					return nil
				else
					local var_47_0 = {}

					AttributeType = var_2_10001
					var_47_0[1] = var_2_10001.Cannon
					AttributeType = var_1
					var_47_0[2] = var_1.Torpedo
					AttributeType = var_1
					var_47_0[3] = var_1.AntiAircraft
					AttributeType = var_1
					var_47_0[4] = var_1.Air
					AttributeType = var_1
					var_47_0[5] = var_1.AntiSub

					local var_47_1 = {}

					i18n = var_2_10002
					var_47_1.name = var_2_10002("equip_info_29")
					AttributeType = var_2

					local var_47_2 = var_2.Type2Name

					pg = var_4
					var_47_1.value = var_47_2(var_47_0[var_4.weapon_property[arg_36_2].attack_attribute])

					return var_47_1
				end

				return
			end
		end,
		function()
			PLATFORM_CODE = var_2_10000
			PLATFORM_JP = var_2_10001

			if var_2_10000 ~= var_2_10001 then
				PLATFORM_CODE = var_2_10000
				PLATFORM_US = var_2_10001

				if var_2_10000 == var_2_10001 then
					return nil
				else
					local var_48_0 = {}

					i18n = var_2_10001
					var_48_0.name = var_2_10001("equip_info_30")
					pg = var_1
					var_48_0.value = var_1.weapon_property[arg_36_2].attack_attribute_ratio .. "%"

					return var_48_0
				end

				return
			end
		end,
		function()
			pg = var_2_10000

			local var_49_0 = var_2_10000.bullet_template[arg_36_2]
			local var_49_1 = {}

			i18n = var_2_10002
			var_49_1.name = var_2_10002("equip_info_32")
			math = var_2
			var_49_1.value = var_2.abs(var_49_0.extra_param.aim_offset)

			return var_49_1
		end
	})
end

function var_0_1.GetGearScore(arg_50_0)
	local var_50_0 = arg_50_0
	local var_50_1 = arg_50_0.getConfig(var_50_0, "rarity")
	local var_50_2 = arg_50_0:getConfig("level")

	assert = var_50_0
	pg = var_5

	var_50_0(var_5.equip_data_by_quality[var_50_1], "equip_data_by_quality not exist: " .. var_50_1)

	pg = var_50_0

	return var_50_0.equip_data_by_quality[var_50_1].gear_score + var_50_2 * var_3.gear_score_addition
end

function var_0_1.GetSkill(arg_51_0)
	local var_51_0
	local var_51_1

	if arg_51_0:getConfig("skill_id")[1] then
		var_51_1 = arg_51_0:getConfig("skill_id")[1][1]
	end

	if var_51_1 then
		getSkillConfig = var_1_10003
		var_51_0 = var_1_10003(var_51_1)
	end

	return var_51_0
end

function var_0_1.GetWeaponID(arg_52_0)
	return arg_52_0:getConfig("weapon_id")
end

function var_0_1.GetSonarProperty(arg_53_0)
	if arg_53_0:getConfig("equip_parameters").range then
		local var_53_0 = {}

		AttributeType = var_4
		var_53_0[var_4.SonarRange] = var_2

		return var_53_0
	else
		return nil
	end

	return
end

function var_0_1.GetAntiSirenPower(arg_54_0)
	return arg_54_0:getConfig("anti_siren")
end

function var_0_1.canUpgrade(arg_55_0)
	return var_0_1.getConfigData(arg_55_0).next ~= 0
end

function var_0_1.hasPrevLevel(arg_56_0)
	return arg_56_0:getConfig("prev") ~= 0
end

function var_0_1.getRevertAwards(arg_57_0)
	local var_57_0 = {}
	local var_57_1 = 0
	local var_57_2 = arg_57_0

	while var_57_2:hasPrevLevel() do
		Equipment = var_4
		var_57_2 = var_4.New({
			id = var_57_2:getConfig("prev")
		})
		ipairs = var_4

		for iter_57_0, iter_57_1 in var_4(var_57_2:getConfig("trans_use_item")) do
			table = var_57_3

			local var_57_3 = var_57_3.insert
			local var_57_4 = var_57_0

			Drop = var_1_10012
			var_1_10012 = var_1_10012.New

			local var_57_5 = {}

			DROP_TYPE_ITEM = var_1_10015
			var_57_5.type = var_1_10015
			var_57_5.id = iter_57_1[1]
			var_57_5.count = iter_57_1[2]

			var_57_3(var_57_4, var_1_10012(var_57_5))
		end

		var_57_1 = var_57_1 + var_57_2:getConfig("trans_use_gold")
	end

	PlayerConst = var_4

	local var_57_6 = var_4.MergeSameDrops(var_57_0)

	if 0 < var_57_1 then
		table = var_4

		local var_57_7 = var_4.insert
		local var_57_8 = var_57_6

		Drop = iter_57_0

		local var_57_9 = iter_57_0.New
		local var_57_10 = {}

		DROP_TYPE_RESOURCE = var_1_10010
		var_57_10.type = var_1_10010
		PlayerConst = var_1_10010
		var_57_10.id = var_1_10010.ResGold
		var_57_10.count = var_57_1

		var_57_7(var_57_8, var_57_9(var_57_10))
	end

	return var_57_6
end

function var_0_1.canEquipSkin(arg_58_0)
	local var_58_0 = arg_58_0:getConfig("type")

	pg = var_1_10002

	return var_1_10002.equip_data_by_type[var_58_0].equip_skin == 1
end

function var_0_1.getType(arg_59_0)
	return arg_59_0:getConfig("type")
end

function var_0_1.hasSkin(arg_60_0)
	local var_60_0

	if arg_60_0.skinId then
		var_60_0 = arg_60_0.skinId ~= 0
	end

	return var_60_0
end

function var_0_1.setSkinId(arg_61_0, arg_61_1)
	arg_61_0.skinId = arg_61_1

	return
end

function var_0_1.getSkinId(arg_62_0)
	return arg_62_0.skinId
end

function var_0_1.hasSkinOrbit(arg_63_0)
	if not arg_63_0:hasSkin() then
		return false
	end

	return var_0_1.IsOrbitSkin(arg_63_0.skinId)
end

function var_0_1.IsOrbitSkin(arg_64_0)
	if var_0_2[arg_64_0].orbit_combat ~= "" or var_1.orbit_ui ~= "" then
		return true
	else
		return false
	end

	return
end

function var_0_1.isImportance(arg_65_0)
	return arg_65_0:getConfig("important") == var_0_1.EQUIPMENT_IMPORTANCE
end

function var_0_1.isUnique(arg_66_0)
	return arg_66_0:getConfig("equip_limit") ~= 0
end

function var_0_1.isDevice(arg_67_0)
	local var_67_0 = arg_67_0:getConfig("type")

	underscore = var_1_10002

	local var_67_1 = var_1_10002.any

	EquipType = var_4

	return var_67_1(var_4.DeviceEquipTypes, function(arg_68_0)
		return arg_68_0 == var_67_0
	end)
end

function var_0_1.isAircraft(arg_69_0)
	local var_69_0 = arg_69_0:getConfig("type")

	underscore = var_1_10002

	local var_69_1 = var_1_10002.any

	EquipType = var_4

	return var_69_1(var_4.AirEquipTypes, function(arg_70_0)
		return arg_70_0 == var_69_0
	end)
end

function var_0_1.isAircraftExtend(arg_71_0)
	local var_71_0 = arg_71_0:getConfig("type")

	underscore = var_1_10002

	local var_71_1 = var_1_10002.any

	EquipType = var_4

	return var_71_1(var_4.AirExtendEquipTypes, function(arg_72_0)
		return arg_72_0 == var_71_0
	end)
end

function var_0_1.MigrateTo(arg_73_0, arg_73_1)
	assert = var_1_10002

	var_1_10002(not arg_73_0.isSkin)

	Equipment = var_1_10002

	return var_1_10002.New({
		id = arg_73_1,
		config_id = arg_73_1,
		count = arg_73_0.count
	})
end

function var_0_1.GetRootEquipment(arg_74_0)
	local var_74_0 = var_0_1.getConfigData(arg_74_0.configId)

	while var_74_0.prev > 0 do
		var_74_0 = var_0_1.getConfigData(var_74_0.prev)
	end

	local var_74_1 = arg_74_0:MigrateTo(var_74_0.id)

	var_74_1.count = 1

	return var_74_1
end

function var_0_1.getNation(arg_75_0)
	return arg_75_0:getConfig("nationality")
end

function var_0_1.GetEquipRootStatic(arg_76_0)
	local var_76_0 = var_0_1.getConfigData(arg_76_0)

	while var_76_0.prev > 0 do
		var_76_0 = var_0_1.getConfigData(var_76_0.prev)
	end

	return var_76_0.id
end

function var_0_1.GetRevertRewardsStatic(arg_77_0)
	local var_77_0 = {}
	local var_77_1 = var_0_1.getConfigData(arg_77_0)

	while var_77_1.prev > 0 do
		var_77_1 = var_0_1.getConfigData(var_77_1.prev)
		ipairs = var_3

		for iter_77_0, iter_77_1 in var_3(var_77_1.trans_use_item) do
			local var_77_2 = iter_77_1[1]
			local var_77_3

			if not var_77_0[iter_77_1[1]] then
				var_77_3 = 0
			end

			var_77_0[var_77_2] = var_77_3 + iter_77_1[2]
		end

		local var_77_4

		if not var_77_0.gold then
			var_77_4 = 0
		end

		var_77_0.gold = var_77_4 + var_77_1.trans_use_gold
	end

	return var_77_0
end

function var_0_1.GetEquipReloadStatic(arg_78_0)
	if var_0_1.getConfigData(arg_78_0).weapon_id and #var_2 > 0 then
		pg = var_3

		if var_3.weapon_property[var_2[1]] then
			return var_3.reload_max
		end
	end

	return
end

function var_0_1.GetEquipComposeCfgStatic(arg_79_0)
	pg = var_1_10001

	local var_79_0 = var_1_10001.compose_data_template

	ipairs = var_1_10002

	for iter_79_0, iter_79_1 in var_1_10002(var_79_0.all) do
		local var_79_1 = var_79_0[iter_79_1]
		local var_79_2 = true

		pairs = var_1_10009

		for iter_79_2, iter_79_3 in var_1_10009(arg_79_0) do
			var_79_2 = var_79_2 and var_79_1[iter_79_2] == iter_79_3
		end

		if var_79_2 then
			return var_79_1
		end
	end

	return
end

function var_0_1.IsMatchKey(arg_80_0, arg_80_1)
	pg = var_1_10002

	local var_80_0 = var_1_10002._equip_data_statistics[arg_80_0.configId].name
	local var_80_1 = {
		arg_80_0:getConfig("name"),
		var_80_0
	}

	EquipmentTools = var_4

	return var_4.IsMatchKey(var_80_1, arg_80_1)
end

return var_0_1
