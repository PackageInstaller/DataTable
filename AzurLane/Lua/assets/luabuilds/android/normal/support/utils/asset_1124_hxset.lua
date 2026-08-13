local var_0_0 = {}

HXSet = HXSet
var_0.codeModeKey = "hx_code_mode"
PLATFORM_CODE = var_1
PLATFORM_CH = var_0_10002

if var_1 == var_0_10002 then
	var_0.codeMode = false
	var_0.antiSkinMode = true
else
	var_0.codeMode = true
	var_0.antiSkinMode = true
end

var_0.nameCodeMap = {}
var_0.nameEquipCodeMap = {}
var_0.nameCodeMap_EN = {
	IJN = "IRN"
}

function var_0.init()
	ipairs = var_1_10000
	pg = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10000(var_1_10001.name_code.all) do
		pg = var_1_10005
		var_1_10005 = var_1_10005.name_code[iter_1_1]

		local var_1_0

		if var_1_10005.type == 1 then
			var_1_0 = var_0.nameCodeMap
		elseif var_1_10005.type == 2 then
			var_1_0 = var_0.nameEquipCodeMap
		else
			assert = var_7

			var_7(false)
		end

		var_1_0[var_1_10005.name] = var_1_10005.code
	end

	pg = var_0

	local var_1_1, var_1_2

	if var_0.gameset.code_switch.key_value == 1 then
		PlayerPrefs = var_1_1

		if var_1_1.HasKey(var_0.codeModeKey) then
			var_1_1 = var_0
			PlayerPrefs = var_1_2
			var_1_2 = var_1_2.GetInt(var_0.codeModeKey) == 1
			var_1_1.codeMode = var_1_2
		end
	end

	PLATFORM_CODE = var_1_1
	PLATFORM_CH = var_1_2

	if var_1_1 == var_1_2 then
		local var_1_3

		IsUnityEditor = var_1_2

		if var_1_2 then
			PathMgr = var_1_2
			var_1_3 = var_1_2.getAssetBundle("../localization.txt")
		else
			Application = var_1_2
			var_1_3 = var_1_2.persistentDataPath .. "/localization.txt"
		end

		PathMgr = var_1_2

		local var_1_4

		if var_1_2.FileExists(var_1_3) then
			PathMgr = var_1_4
			var_1_4 = var_1_4.ReadAllLines(var_1_3)
			string = var_2

			if var_2.gsub(var_1_4[0], "%w+%s*=%s*", "") == "true" then
				var_0.codeMode = true
			end

			local var_1_5 = "Localization_skin = false"
			local var_1_6

			if var_1_4.Length <= 1 then
				var_1_6 = {
					var_1_4[0],
					var_1_5
				}
				System = var_4

				var_4.IO.File.WriteAllLines(var_1_3, var_1_6)
			else
				var_1_5 = var_1_4[1]
			end

			string = var_1_6

			if var_1_6.gsub(var_1_5, "[_%w]+%s*=%s*", "") == "true" then
				var_0.antiSkinMode = true
			end
		else
			System = var_1_4

			var_1_4.IO.File.WriteAllText(var_1_3, "Localization = false\nLocalization_skin = false")
		end
	end

	var_0.update()

	return
end

function var_0.calcLocalizationUse()
	PLATFORM_CODE = var_1_10000
	PLATFORM_CH = var_1_10001

	if var_1_10000 == var_1_10001 then
		local var_2_0 = "localization_use"

		PlayerPrefs = var_1_10001

		if var_1_10001.HasKey(var_2_0) then
			PlayerPrefs = var_1

			var_1.DeleteKey(var_2_0)
		end

		pg = var_1

		local var_2_1 = var_1.TimeMgr.GetInstance()

		getProxy = var_2
		PlayerProxy = var_1_10003

		local var_2_2 = var_2(var_1_10003)
		local var_2_3 = var_2.getData(var_2_2).id
		local var_2_4 = "localization_time_1_" .. var_2_3

		PlayerPrefs = var_4

		local var_2_5 = var_4.GetInt(var_2_4, 0)

		if var_0.codeMode then
			local var_2_6 = var_2_1
			local var_2_7 = var_2_1.IsSameDay
			local var_2_8 = var_2_5
			local var_2_9 = var_2_1

			if not var_2_7(var_2_6, var_2_8, var_2_1.GetServerTime(var_2_9)) then
				pg = var_5

				local var_2_10 = var_5.m02
				local var_2_11 = var_5.sendNotification

				GAME = var_2_8

				local var_2_12 = var_2_8.CHEATER_MARK
				local var_2_13 = {}

				CC_TYPE_99 = var_2_9
				var_2_13.reason = var_2_9

				var_2_11(var_2_10, var_2_12, var_2_13)

				PlayerPrefs = var_2_11

				var_2_11.SetInt(var_2_4, var_2_1:GetServerTime())
			end
		end

		local var_2_14 = "localization_time_2_" .. var_2_3

		PlayerPrefs = var_6

		local var_2_15 = var_6.GetInt(var_2_14, 0)

		if var_0.antiSkinMode then
			local var_2_16 = var_2_1
			local var_2_17 = var_2_1.IsSameDay
			local var_2_18 = var_2_15
			local var_2_19 = var_2_1

			if not var_2_17(var_2_16, var_2_18, var_2_1.GetServerTime(var_2_19)) then
				pg = var_7

				local var_2_20 = var_7.m02
				local var_2_21 = var_7.sendNotification

				GAME = var_2_18

				local var_2_22 = var_2_18.CHEATER_MARK
				local var_2_23 = {}

				CC_TYPE_100 = var_2_19
				var_2_23.reason = var_2_19

				var_2_21(var_2_20, var_2_22, var_2_23)

				PlayerPrefs = var_2_21

				var_2_21.SetInt(var_2_14, var_2_1:GetServerTime())
			end
		end
	end

	return
end

function var_0.switchCodeMode()
	pg = var_1_10000

	if var_1_10000.gameset.code_switch.key_value == 1 or var_0.codeMode then
		local var_3_0 = var_0

		var_3_0.codeMode = not var_0.codeMode
		PlayerPrefs = var_3_0

		var_3_0.SetInt(var_0.codeModeKey, var_0.codeMode and 1 or 0)

		PlayerPrefs = var_0

		var_0.Save()
		var_0.update()

		originalPrint = var_0

		var_0("anti hx mode: " .. (var_0.codeMode and "on" or "off"))
	end

	return
end

function var_0.isHXNation(arg_4_0)
	local var_4_0 = var_0
	local var_4_1

	if not var_0.nationHX then
		var_4_1 = {}
		Nation = var_1_10003
		var_4_1[var_1_10003.US] = true
		Nation = var_3
		var_4_1[var_3.JP] = true
		Nation = var_3
		var_4_1[var_3.DE] = true
		Nation = var_3
		var_4_1[var_3.CN] = true
		Nation = var_3
		var_4_1[var_3.ITA] = true
		Nation = var_3
		var_4_1[var_3.SN] = true
		Nation = var_3
		var_4_1[var_3.MNF] = true
		Nation = var_3
		var_4_1[var_3.META] = true
	end

	var_4_0.nationHX = var_4_1

	return var_0.nationHX[arg_4_0]
end

function var_0.update()
	local var_5_0

	if not var_0.codeMode or not {} then
		var_5_0 = var_0.nameCodeMap
	end

	local var_5_1

	if not var_0.codeMode or not {} then
		var_5_1 = var_0.nameEquipCodeMap
	end

	local var_5_2

	if not var_0.codeMode or not {} then
		var_5_2 = var_0.nameCodeMap_EN
	end

	pg = var_1_10003

	local var_5_3 = var_1_10003.ship_data_statistics

	pg = var_1_10004
	var_1_10004._ship_data_statistics = var_5_3
	pg = var_1_10004
	setmetatable = var_1_10005
	var_1_10004.ship_data_statistics = var_1_10005({}, {
		__index = function(arg_6_0, arg_6_1)
			if var_5_3[arg_6_1] == nil then
				return var_2
			elseif var_2.name == nil then
				arg_6_0[arg_6_1] = var_2

				return arg_6_0[arg_6_1]
			end

			arg_6_0[arg_6_1] = {}

			if var_0.isHXNation(var_2.nationality) and var_5_0[var_2.name] then
				arg_6_0[arg_6_1].name = var_5_0[var_2.name]
			end

			local var_6_0

			if var_2.english_name and #var_2.english_name > 0 then
				var_6_0 = arg_6_0[arg_6_1]
				var_6_0.english_name = var_2.english_name
				pairs = var_6_0

				for iter_6_0, iter_6_1 in var_6_0(var_5_2) do
					local var_6_1 = arg_6_0[arg_6_1]

					string = var_2_10009
					var_2_10009 = var_2_10009.gsub

					local var_6_2

					if not arg_6_0[arg_6_1].english_name then
						var_6_2 = ""
					end

					var_6_1.english_name = var_2_10009(var_6_2, iter_6_0, iter_6_1)
				end
			end

			setmetatable = var_6_0

			var_6_0(arg_6_0[arg_6_1], {
				__index = var_2
			})

			return arg_6_0[arg_6_1]
		end
	})
	pg = var_1_10004

	local var_5_4 = var_1_10004.fleet_tech_ship_class

	pg = var_5
	setmetatable = var_6
	var_5.fleet_tech_ship_class = var_6({}, {
		__index = function(arg_7_0, arg_7_1)
			if var_5_4[arg_7_1] == nil then
				return var_2
			elseif var_2.name == nil then
				arg_7_0[arg_7_1] = var_2

				return arg_7_0[arg_7_1]
			end

			string = var_2_10003

			local var_7_0, var_7_1 = var_2_10003.gsub(var_2.name, "级", "")

			if var_0.isHXNation(var_2.nation) and var_5_0[var_7_0] then
				setmetatable = var_5
				arg_7_0[arg_7_1] = var_5({
					name = var_5_0[var_7_0] .. (var_7_1 > 0 and "级" or "")
				}, {
					__index = var_2
				})
			else
				arg_7_0[arg_7_1] = var_2
			end

			return arg_7_0[arg_7_1]
		end
	})
	pg = var_5

	local var_5_5 = var_5.enemy_data_statistics

	pg = var_6
	setmetatable = var_7
	var_6.enemy_data_statistics = var_7({}, {
		__index = function(arg_8_0, arg_8_1)
			if var_5_5[arg_8_1] == nil then
				return var_2
			elseif var_2.name == nil then
				arg_8_0[arg_8_1] = var_2

				return arg_8_0[arg_8_1]
			end

			if var_0.isHXNation(var_2.nationality) and var_5_0[var_2.name] then
				setmetatable = var_3
				arg_8_0[arg_8_1] = var_3({
					name = var_5_0[var_2.name]
				}, {
					__index = var_2
				})
			else
				arg_8_0[arg_8_1] = var_2
			end

			return arg_8_0[arg_8_1]
		end
	})
	pg = var_6

	local var_5_6 = var_6.equip_data_statistics

	pg = var_7
	var_7._equip_data_statistics = var_5_6
	pg = var_7
	setmetatable = var_8
	var_7.equip_data_statistics = var_8({}, {
		__index = function(arg_9_0, arg_9_1)
			if var_5_6[arg_9_1] == nil then
				return var_2
			elseif var_2.name == nil then
				arg_9_0[arg_9_1] = var_2

				return arg_9_0[arg_9_1]
			end

			if var_5_1[var_2.name] then
				setmetatable = var_3
				arg_9_0[arg_9_1] = var_3({
					name = var_5_1[var_2.name]
				}, {
					__index = var_2
				})
			else
				arg_9_0[arg_9_1] = var_2
			end

			return arg_9_0[arg_9_1]
		end
	})
	pg = var_7

	local var_5_7 = var_7.island_unit_character

	pg = var_8
	setmetatable = var_9
	var_8.island_unit_character = var_9({}, {
		__index = function(arg_10_0, arg_10_1)
			if var_5_7[arg_10_1] == nil then
				return var_2
			elseif var_2.name == nil then
				arg_10_0[arg_10_1] = var_2

				return arg_10_0[arg_10_1]
			end

			arg_10_0[arg_10_1] = {}

			local var_10_0

			if var_5_0[var_2.name] then
				var_10_0 = arg_10_0[arg_10_1]
				var_10_0.name = var_5_0[var_2.name]
			end

			setmetatable = var_10_0

			var_10_0(arg_10_0[arg_10_1], {
				__index = var_2
			})

			return arg_10_0[arg_10_1]
		end
	})

	return
end

function var_0.hxLan(arg_11_0, arg_11_1)
	string = var_1_10002

	return var_1_10002.gsub(arg_11_0 or "", "{namecode:(%d+).-}", function(arg_12_0)
		pg = var_2_10001

		local var_12_0 = var_2_10001.name_code

		tonumber = var_2_10002

		local var_12_1

		if var_12_0[var_2_10002(arg_12_0)] and (not var_0.codeMode and not arg_11_1 or not var_1.name) then
			var_12_1 = var_1.code
		end

		return var_12_1
	end)
end

function var_0.isHx()
	return not var_0.codeMode
end

function var_0.isHxSkin()
	return not var_0.antiSkinMode
end

function var_0.isHxPropose()
	if not var_0.codeMode then
		PLATFORM_CODE = var_15_0
		PLATFORM_CH = var_1_10001

		if var_15_0 == var_1_10001 then
			LOCK_PROPOSE_SHIP = var_15_0

			goto label_15_0
		end
	end

	local var_15_0 = false

	if false then
		var_15_0 = true
	end

	::label_15_0::

	return var_15_0
end

function var_0.HxPath(arg_16_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		HXSet = var_1_10001

		if var_1_10001.isHx() then
			pg = var_1

			local var_16_0 = var_1.SdkMgr.GetInstance()
			local var_16_1 = var_1.GetChannelUIDIncludeHarmony(var_16_0)
			local var_16_2 = arg_16_0 .. "_hx_ch" .. var_16_1

			checkABExist = var_3

			do return var_3(var_16_2) and var_16_2 or arg_16_0 end

			goto label_16_0
		end
	end

	do return arg_16_0 end

	::label_16_0::

	return
end

var_0.hxPathList = {
	"live2d",
	"painting",
	"shipYardIcon",
	"paintingface",
	"char",
	"shipmodels",
	"technologycard",
	"shipdesignicon",
	"herohrzicon",
	"skinunlockanim",
	"spinePainting"
}
var_0.folderBundle = {
	"paintingface"
}

function var_0.needShift(arg_17_0)
	ipairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(var_0.hxPathList) do
		string = var_1_10006

		if var_1_10006.find(arg_17_0, iter_17_1) then
			return true
		end
	end

	return false
end

function var_0.isFolderBundle(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(var_0.folderBundle) do
		string = var_1_10006

		if var_1_10006.find(arg_18_0, iter_18_1) then
			return true
		end
	end

	return false
end

function var_0.autoHxShift(arg_19_0, arg_19_1)
	if var_0.isHx() then
		string = var_2

		if var_2.find(arg_19_0, "live2d") then
			checkABExist = var_2

			if var_2(arg_19_0 .. arg_19_1 .. "_hx") then
				return arg_19_0, arg_19_1 .. "_hx"
			else
				pg = var_2

				if var_2.l2dhx[arg_19_1] then
					return arg_19_0, arg_19_1 .. "_hx"
				end
			end
		end

		if var_0.needShift(arg_19_0) then
			local var_19_0 = arg_19_0 .. arg_19_1

			checkABExist = var_3

			if var_3(var_19_0 .. "_hx") then
				return arg_19_0, arg_19_1 .. "_hx"
			end
		end
	end

	return arg_19_0, arg_19_1
end

function var_0.autoHxShiftPath(arg_20_0, arg_20_1, arg_20_2)
	if var_0.isHx() then
		string = var_3

		if var_3.find(arg_20_0, "live2d") then
			local var_20_0

			if arg_20_2 then
				string = var_20_0
				var_20_0 = var_20_0.gsub(arg_20_0, "live2d/", "")
				pg = var_4

				if var_4.l2dhx[var_20_0] then
					return arg_20_0 .. "_hx"
				end
			else
				checkABExist = var_20_0

				if var_20_0(arg_20_0 .. "_hx") then
					return arg_20_0 .. "_hx"
				else
					string = var_3

					local var_20_1 = var_3.gsub(arg_20_0, "live2d/", "")

					pg = var_4

					if var_4.l2dhx[var_20_1] then
						return arg_20_0 .. "_hx"
					end
				end
			end
		end

		if var_0.needShift(arg_20_0) then
			checkABExist = var_3

			if var_3(arg_20_0 .. "_hx") then
				if var_0.isFolderBundle(arg_20_0) then
					return arg_20_0 .. "_hx", arg_20_1
				elseif arg_20_1 and #arg_20_1 > 0 then
					return arg_20_0 .. "_hx", arg_20_1 .. "_hx"
				else
					return arg_20_0 .. "_hx", arg_20_1
				end
			end
		end
	end

	return arg_20_0, arg_20_1
end

var_0.init()

return
