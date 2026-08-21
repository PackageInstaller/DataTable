HXSet = {}

local var_0_0 = HXSet

var_0_0.codeModeKey = "hx_code_mode"

if PLATFORM_CODE == PLATFORM_CH then
	var_0_0.codeMode = false
	var_0_0.antiSkinMode = true
else
	var_0_0.codeMode = true
	var_0_0.antiSkinMode = true
end

var_0_0.nameCodeMap = {}
var_0_0.nameEquipCodeMap = {}
var_0_0.nameCodeMap_EN = {
	IJN = "IRN"
}

function var_0_0.init()
	for iter_1_0, iter_1_1 in ipairs(pg.name_code.all) do
		local var_1_0 = pg.name_code[iter_1_1]
		local var_1_1

		if pg.name_code[iter_1_1].type == 1 then
			var_1_1 = var_0_0.nameCodeMap
		elseif var_1_0.type == 2 then
			var_1_1 = var_0_0.nameEquipCodeMap
		else
			assert(false)
		end

		var_1_1[var_1_0.name] = var_1_0.code
	end

	if pg.gameset.code_switch.key_value == 1 and PlayerPrefs.HasKey(var_0_0.codeModeKey) then
		var_0_0.codeMode = PlayerPrefs.GetInt(var_0_0.codeModeKey) == 1
	end

	if PLATFORM_CODE == PLATFORM_CH then
		local var_1_2 = IsUnityEditor and PathMgr.getAssetBundle("../localization.txt") or Application.persistentDataPath .. "/localization.txt"

		if PathMgr.FileExists(var_1_2) then
			local var_1_3 = PathMgr.ReadAllLines(var_1_2)

			if string.gsub(var_1_3[0], "%w+%s*=%s*", "") == "true" then
				var_0_0.codeMode = true
			end

			local var_1_4 = "Localization_skin = false"

			if var_1_3.Length <= 1 then
				System.IO.File.WriteAllLines(var_1_2, {
					var_1_3[0],
					var_1_4
				})
			else
				var_1_4 = var_1_3[1]
			end

			if string.gsub(var_1_4, "[_%w]+%s*=%s*", "") == "true" then
				var_0_0.antiSkinMode = true
			end
		else
			System.IO.File.WriteAllText(var_1_2, "Localization = false\nLocalization_skin = false")
		end
	end

	var_0_0.update()

	return
end

function var_0_0.calcLocalizationUse()
	if PLATFORM_CODE == PLATFORM_CH then
		if PlayerPrefs.HasKey("localization_use") then
			PlayerPrefs.DeleteKey("localization_use")
		end

		local var_2_0 = pg.TimeMgr.GetInstance()
		local var_2_1 = getProxy(PlayerProxy):getData().id

		if var_0_0.codeMode and not var_2_0:IsSameDay(PlayerPrefs.GetInt("localization_time_1_" .. var_2_1, 0), var_2_0:GetServerTime()) then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = CC_TYPE_99
			})
			PlayerPrefs.SetInt("localization_time_1_" .. var_2_1, var_2_0:GetServerTime())
		end

		local var_2_2 = "localization_time_2_" .. var_2_1

		if var_0_0.antiSkinMode and not var_2_0:IsSameDay(PlayerPrefs.GetInt("localization_time_2_" .. var_2_1, 0), var_2_0:GetServerTime()) then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = CC_TYPE_100
			})
			PlayerPrefs.SetInt(var_2_2, var_2_0:GetServerTime())
		end
	end

	return
end

function var_0_0.switchCodeMode()
	if pg.gameset.code_switch.key_value == 1 or var_0_0.codeMode then
		var_0_0.codeMode = not var_0_0.codeMode

		PlayerPrefs.SetInt(var_0_0.codeModeKey, var_0_0.codeMode and 1 or 0)
		PlayerPrefs.Save()
		var_0_0.update()
		originalPrint("anti hx mode: " .. (var_0_0.codeMode and "on" or "off"))
	end

	return
end

function var_0_0.isHXNation(arg_4_0)
	var_0_0.nationHX = var_0_0.nationHX or {
		[Nation.US] = true,
		[Nation.JP] = true,
		[Nation.DE] = true,
		[Nation.CN] = true,
		[Nation.ITA] = true,
		[Nation.SN] = true,
		[Nation.MNF] = true,
		[Nation.META] = true
	}

	return var_0_0.nationHX[arg_4_0]
end

function var_0_0.update()
	local var_5_0 = var_0_0.codeMode and {} or var_0_0.nameCodeMap
	local var_5_1 = var_0_0.codeMode and {} or var_0_0.nameEquipCodeMap
	local var_5_2 = var_0_0.codeMode and {} or var_0_0.nameCodeMap_EN

	pg._ship_data_statistics = pg.ship_data_statistics
	pg.ship_data_statistics = setmetatable({}, {
		__index = function(arg_6_0, arg_6_1)
			if var_0[arg_6_1] == nil then
				return var_0[arg_6_1]
			elseif var_0[arg_6_1].name == nil then
				arg_6_0[arg_6_1] = var_0[arg_6_1]

				return arg_6_0[arg_6_1]
			end

			arg_6_0[arg_6_1] = {}

			if var_0_0.isHXNation(var_0[arg_6_1].nationality) and var_5_0[var_0[arg_6_1].name] then
				arg_6_0[arg_6_1].name = var_5_0[var_0[arg_6_1].name]
			end

			if var_0[arg_6_1].english_name and #var_0[arg_6_1].english_name > 0 then
				arg_6_0[arg_6_1].english_name = var_0[arg_6_1].english_name

				for iter_6_0, iter_6_1 in pairs(var_5_2) do
					local var_6_0 = arg_6_0[arg_6_1].english_name or ""

					arg_6_0[arg_6_1].english_name = string.gsub(var_6_0, iter_6_0, iter_6_1)
				end
			end

			setmetatable(arg_6_0[arg_6_1], {
				__index = var_0[arg_6_1]
			})

			return arg_6_0[arg_6_1]
		end
	})

	local var_5_3 = pg.fleet_tech_ship_class

	pg.fleet_tech_ship_class = setmetatable({}, {
		__index = function(arg_7_0, arg_7_1)
			local var_7_0 = var_5_3[arg_7_1]

			if var_5_3[arg_7_1] == nil then
				return var_7_0
			elseif var_7_0.name == nil then
				arg_7_0[arg_7_1] = var_7_0

				return arg_7_0[arg_7_1]
			end

			local var_7_1, var_7_2 = string.gsub(var_7_0.name, "级", "")

			arg_7_0[arg_7_1] = var_0_0.isHXNation(var_7_0.nation) and var_5_0[var_7_1] and setmetatable({
				name = var_5_0[var_7_1] .. (var_7_2 > 0 and "级" or "")
			}, {
				__index = var_7_0
			}) or var_7_0

			return arg_7_0[arg_7_1]
		end
	})

	local var_5_4 = pg.enemy_data_statistics

	pg.enemy_data_statistics = setmetatable({}, {
		__index = function(arg_8_0, arg_8_1)
			if var_5_4[arg_8_1] == nil then
				return var_5_4[arg_8_1]
			elseif var_5_4[arg_8_1].name == nil then
				arg_8_0[arg_8_1] = var_5_4[arg_8_1]

				return arg_8_0[arg_8_1]
			end

			arg_8_0[arg_8_1] = var_0_0.isHXNation(var_5_4[arg_8_1].nationality) and var_5_0[var_5_4[arg_8_1].name] and setmetatable({
				name = var_5_0[var_5_4[arg_8_1].name]
			}, {
				__index = var_5_4[arg_8_1]
			}) or var_5_4[arg_8_1]

			return arg_8_0[arg_8_1]
		end
	})
	pg._equip_data_statistics = pg.equip_data_statistics
	pg.equip_data_statistics = setmetatable({}, {
		__index = function(arg_9_0, arg_9_1)
			if var_0[arg_9_1] == nil then
				return var_0[arg_9_1]
			elseif var_0[arg_9_1].name == nil then
				arg_9_0[arg_9_1] = var_0[arg_9_1]

				return arg_9_0[arg_9_1]
			end

			arg_9_0[arg_9_1] = var_5_1[var_0[arg_9_1].name] and setmetatable({
				name = var_5_1[var_0[arg_9_1].name]
			}, {
				__index = var_0[arg_9_1]
			}) or var_0[arg_9_1]

			return arg_9_0[arg_9_1]
		end
	})

	local var_5_5 = pg.island_unit_character

	pg.island_unit_character = setmetatable({}, {
		__index = function(arg_10_0, arg_10_1)
			if var_5_5[arg_10_1] == nil then
				return var_5_5[arg_10_1]
			elseif var_5_5[arg_10_1].name == nil then
				arg_10_0[arg_10_1] = var_5_5[arg_10_1]

				return arg_10_0[arg_10_1]
			end

			arg_10_0[arg_10_1] = {}

			if var_5_0[var_5_5[arg_10_1].name] then
				arg_10_0[arg_10_1].name = var_5_0[var_5_5[arg_10_1].name]
			end

			setmetatable(arg_10_0[arg_10_1], {
				__index = var_5_5[arg_10_1]
			})

			return arg_10_0[arg_10_1]
		end
	})

	return
end

function var_0_0.hxLan(arg_11_0, arg_11_1)
	return string.gsub(arg_11_0 or "", "{namecode:(%d+).-}", function(arg_12_0)
		local var_12_0 = pg.name_code[tonumber(arg_12_0)]

		if var_12_0 then
			::label_12_0::

			if var_0_0.codeMode or arg_11_1 then
				return var_12_0.name or var_12_0.code
			end
		end
	end)
end

function var_0_0.isHx()
	return not var_0_0.codeMode
end

function var_0_0.isHxSkin()
	return not var_0_0.antiSkinMode
end

function var_0_0.isHxPropose()
	return not var_0_0.codeMode and PLATFORM_CODE == PLATFORM_CH and LOCK_PROPOSE_SHIP
end

function var_0_0.HxPath(arg_16_0)
	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		local var_16_0 = pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()
		local var_16_1 = arg_16_0 .. "_hx_ch" .. var_16_0

		return checkABExist(arg_16_0 .. "_hx_ch" .. var_16_0) and var_16_1 or arg_16_0
	else
		return arg_16_0
	end

	return
end

var_0_0.hxPathList = {
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
var_0_0.folderBundle = {
	"paintingface"
}

function var_0_0.needShift(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(var_0_0.hxPathList) do
		if string.find(arg_17_0, iter_17_1) then
			return true
		end
	end

	return false
end

function var_0_0.isFolderBundle(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(var_0_0.folderBundle) do
		if string.find(arg_18_0, iter_18_1) then
			return true
		end
	end

	return false
end

function var_0_0.autoHxShift(arg_19_0, arg_19_1)
	if var_0_0.isHx() then
		if string.find(arg_19_0, "live2d") then
			if checkABExist(arg_19_0 .. arg_19_1 .. "_hx") then
				return arg_19_0, arg_19_1 .. "_hx"
			elseif pg.l2dhx[arg_19_1] then
				return arg_19_0, arg_19_1 .. "_hx"
			end
		end

		if var_0_0.needShift(arg_19_0) and checkABExist((arg_19_0 .. arg_19_1) .. "_hx") then
			return arg_19_0, arg_19_1 .. "_hx"
		end
	end

	return arg_19_0, arg_19_1
end

function var_0_0.autoHxShiftPath(arg_20_0, arg_20_1, arg_20_2)
	if var_0_0.isHx() then
		if string.find(arg_20_0, "live2d") then
			if arg_20_2 then
				if pg.l2dhx[string.gsub(arg_20_0, "live2d/", "")] then
					return arg_20_0 .. "_hx"
				end
			elseif checkABExist(arg_20_0 .. "_hx") then
				return arg_20_0 .. "_hx"
			elseif pg.l2dhx[string.gsub(arg_20_0, "live2d/", "")] then
				return arg_20_0 .. "_hx"
			end
		end

		if var_0_0.needShift(arg_20_0) and checkABExist(arg_20_0 .. "_hx") then
			if var_0_0.isFolderBundle(arg_20_0) then
				return arg_20_0 .. "_hx", arg_20_1
			elseif arg_20_1 and #arg_20_1 > 0 then
				return arg_20_0 .. "_hx", arg_20_1 .. "_hx"
			else
				return arg_20_0 .. "_hx", arg_20_1
			end
		end
	end

	return arg_20_0, arg_20_1
end

var_0_0.init()

return
