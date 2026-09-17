local var_0_0 = {}
local file_check_manager = require("controller.filedownloader.file_check_manager")
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_6
local var_0_7 = {
	"aichou",
	"fanu",
	"haixiu",
	"kaixin",
	"zhengchang"
}

local function var_0_8(arg_1_0, arg_1_1)
	if file_check_manager:checkFileNeedDownload(ROLE_IMAGE_PATH .. model_data[arg_1_1].role_image .. ".png") then
		table.insert(arg_1_0, file_check_manager:getFileDownloadInfo(ROLE_IMAGE_PATH .. model_data[arg_1_1].role_image .. ".png"))
	end

	for iter_1_0, iter_1_1 in ipairs(var_0_7) do
		if model_data[arg_1_1][iter_1_1] then
			if file_check_manager:checkFileNeedDownload("expression/" .. model_data[arg_1_1][iter_1_1] .. ".png") then
				table.insert(arg_1_0, file_check_manager:getFileDownloadInfo("expression/" .. model_data[arg_1_1][iter_1_1] .. ".png"))
			end
		end
	end

	if model_data[arg_1_1].broken_role then
		if file_check_manager:checkFileNeedDownload(ROLE_IMAGE_PATH .. model_data[arg_1_1].broken_role .. ".png") then
			table.insert(arg_1_0, file_check_manager:getFileDownloadInfo(ROLE_IMAGE_PATH .. model_data[arg_1_1].broken_role .. ".png"))
		end
	end

	if file_check_manager:checkFileNeedDownload(PANEL_ROLE_IMAGE_PATH .. model_data[arg_1_1].role_image .. ".png") then
		table.insert(arg_1_0, file_check_manager:getFileDownloadInfo(PANEL_ROLE_IMAGE_PATH .. model_data[arg_1_1].role_image .. ".png"))
	end

	if file_check_manager:checkFileNeedDownload("roleimage/role/fight/" .. model_data[arg_1_1].role_image .. ".png") then
		table.insert(arg_1_0, file_check_manager:getFileDownloadInfo("roleimage/role/fight/" .. model_data[arg_1_1].role_image .. ".png"))
	end

	if model_data[arg_1_1].fanu then
		if file_check_manager:checkFileNeedDownload("expression/fight/" .. model_data[arg_1_1].fanu .. ".png") then
			table.insert(arg_1_0, file_check_manager:getFileDownloadInfo("expression/fight/" .. model_data[arg_1_1].fanu .. ".png"))
		end
	end

	if model_data[arg_1_1].cute_Q then
		if file_check_manager:checkFileNeedDownload(CUTE_ROLE_IMAGE_PATH .. model_data[arg_1_1].cute_Q .. ".png") then
			table.insert(arg_1_0, file_check_manager:getFileDownloadInfo(CUTE_ROLE_IMAGE_PATH .. model_data[arg_1_1].cute_Q .. ".png"))
		end
	end
end

local function var_0_9(arg_2_0, arg_2_1)
	if not model_data[arg_2_1].rolespine then
		return
	end

	local var_2_0, var_2_1 = file_check_manager:checkSpineFile(ROLE_SPINE_PATH .. model_data[arg_2_1].rolespine .. ".json")

	if var_2_0 then
		table.insertto(arg_2_0, var_2_1)
	end
end

local function var_0_10(arg_3_0, arg_3_1)
	if not model_data[arg_3_1].live2d or model_data[arg_3_1].origin then
		return
	end

	local var_3_0, var_3_1 = file_check_manager:checkL2DFile(model_data[arg_3_1].live2d)

	if var_3_0 then
		table.insertto(arg_3_0, var_3_1)
	end
end

local function var_0_11(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = file_check_manager:checkSoundSourceByServant(arg_4_1)

	if var_4_0 then
		table.insertto(arg_4_0, var_4_1)
	end
end

local function var_0_12(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = file_check_manager:checkSoundSourceByModel(arg_5_1)

	if var_5_0 then
		table.insertto(arg_5_0, var_5_1)
	end
end

local function var_0_13(arg_6_0, arg_6_1)
	local var_6_0 = file_check_manager:checkBattleSpineByModel(arg_6_1)

	if #var_6_0 > 0 then
		table.insertto(arg_6_0, var_6_0)
	end
end

local function var_0_14(arg_7_0, arg_7_1)
	var_0_8(arg_7_0, major_factor_data[servant_data[arg_7_1].major].model)
	var_0_9(arg_7_0, major_factor_data[servant_data[arg_7_1].major].model)
	var_0_10(arg_7_0, major_factor_data[servant_data[arg_7_1].major].model)
	var_0_12(arg_7_0, major_factor_data[servant_data[arg_7_1].major].model)

	local var_7_0, var_7_1 = file_check_manager:checkSpineByID(model_data[major_factor_data[servant_data[arg_7_1].major].model].spine_model)

	if var_7_0 then
		table.insertto(arg_7_0, var_7_1)
	end
end

local function var_0_15(arg_8_0, arg_8_1)
	if not model_data[arg_8_1].spine_model then
		return
	end

	local var_8_0, var_8_1 = file_check_manager:checkSpineByID(model_data[arg_8_1].spine_model)

	if var_8_0 then
		table.insertto(arg_8_0, var_8_1)
	end
end

local function var_0_16(arg_9_0, arg_9_1)
	var_0_8(arg_9_0, servant_data[arg_9_1].modelid)
	var_0_9(arg_9_0, servant_data[arg_9_1].modelid)
	var_0_10(arg_9_0, servant_data[arg_9_1].modelid)
	var_0_11(arg_9_0, arg_9_1)
	var_0_13(arg_9_0, servant_data[arg_9_1].modelid)
	var_0_14(arg_9_0, arg_9_1)
end

local function var_0_17(arg_10_0, arg_10_1)
	if not servant_data[arg_10_1].model_oc then
		return
	end

	var_0_8(arg_10_0, servant_data[arg_10_1].model_oc)
	var_0_9(arg_10_0, servant_data[arg_10_1].model_oc)
	var_0_10(arg_10_0, servant_data[arg_10_1].model_oc)
	var_0_12(arg_10_0, servant_data[arg_10_1].model_oc)
	var_0_13(arg_10_0, servant_data[arg_10_1].model_oc)
end

local function var_0_18(arg_11_0)
	local var_11_0

	while major_factor_data[item_data[arg_11_0].major]["item" .. 1] do
		if major_factor_data[item_data[arg_11_0].major]["item" .. 1] == arg_11_0 then
			var_11_0 = 1

			break
		end
	end

	return var_11_0
end

local function var_0_20(arg_13_0, arg_13_1)
	local var_13_0 = var_0_18(arg_13_1)

	if not var_13_0 then
		return
	end

	local var_13_1 = item_data[arg_13_1].model

	var_0_8(arg_13_0, item_data[arg_13_1].model)
	var_0_9(arg_13_0, var_13_1)
	var_0_10(arg_13_0, var_13_1)
	var_0_12(arg_13_0, var_13_1)
	var_0_15(arg_13_0, var_13_1)
	var_0_13(arg_13_0, servant_data[major_factor_data[item_data[arg_13_1].major].fight_model1]["modelid" .. var_13_0])

	if major_factor_data[item_data[arg_13_1].major].fight_model2 then
		var_0_13(arg_13_0, servant_data[major_factor_data[item_data[arg_13_1].major].fight_model2]["modelid" .. var_13_0])
	end

	if major_factor_data[item_data[arg_13_1].major].fight_model3 then
		var_0_13(arg_13_0, servant_data[major_factor_data[item_data[arg_13_1].major].fight_model3]["modelid" .. var_13_0])
	end
end

local function var_0_21(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(require("model.playermodel").haveServant) do
		if iter_14_1 then
			var_0_16(arg_14_0, iter_14_0)
			var_0_17(arg_14_0, iter_14_0)
		end
	end
end

local function var_0_22(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(require("model.playermodel").items) do
		if iter_15_1.itemtype == kITEM_SKIN then
			var_0_20(arg_15_0, iter_15_1.itemid)
		end
	end
end

local function var_0_23(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in ipairs((require("controller.level_manager").getAllMonsterList(arg_16_1, arg_16_2))) do
		var_0_13(arg_16_0, iter_16_1)
	end
end

local function var_0_24(arg_17_0, arg_17_1, arg_17_2)
	var_0_23(arg_17_0, arg_17_1, level)
end

local function var_0_25(arg_18_0, arg_18_1)
	local level_manager = require("controller.level_manager")

	if arg_18_1 >= level_manager:getModeTotalChapter(arg_18_0) then
		local var_18_1 = level_manager:getJumpNextMode(arg_18_0)

		if not var_18_1 then
			return nil, nil
		end

		return var_18_1, 1
	else
		return arg_18_0, arg_18_1 + 1
	end
end

local function var_0_26(arg_19_0)
	return tonumber((arg_19_0:match("^%d+")))
end

function var_0_0.generate_assets_on_passlevel(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}
	local var_20_1 = arg_20_1
	local var_20_2 = arg_20_2

	for iter_20_0 = 1, 3 do
		var_20_1, var_20_2 = var_0_25(var_20_1, var_20_2)

		if not var_20_1 then
			break
		end

		var_0_24(var_20_0, var_20_1, var_20_2)
	end

	return file_check_manager:mergeDownloadList(var_20_0)
end

function var_0_0.generate_assets_on_getrole(arg_21_0, arg_21_1)
	local var_21_0 = {}

	var_0_16(var_21_0, arg_21_1)
	var_0_17(var_21_0, arg_21_1)

	return file_check_manager:mergeDownloadList(var_21_0)
end

function var_0_0.generate_assets_on_entergame(arg_22_0)
	local var_22_0 = {}

	var_0_21(var_22_0)
	var_0_22(var_22_0)

	local playermodel = require("model.playermodel")
	local var_22_2 = playermodel.curMode
	local var_22_3 = var_0_26(playermodel.curLevel)

	for iter_22_0 = 1, 3 do
		var_22_2, var_22_3 = var_0_25(var_22_2, var_22_3)

		if not var_22_2 then
			break
		end

		var_0_24(var_22_0, var_22_2, var_22_3)
	end

	return file_check_manager:mergeDownloadList(var_22_0)
end

function var_0_0.generate_all_assets(arg_23_0)
	var_0_6 = file_check_manager:checkAllLackResource()
end

function var_0_0.get_assets_count(arg_24_0)
	return file_check_manager:getAllResourceCount()
end

function var_0_0.push_assets_to_downloadqueue(arg_25_0, arg_25_1)
	if not var_0_6 then
		return
	end

	for iter_25_0, iter_25_1 in pairs(var_0_6) do
		arg_25_1:add(iter_25_1)
	end
end

return var_0_0
