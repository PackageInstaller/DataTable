local var_0_0 = {}
local var_0_1 = cc.FileUtils:getInstance()
local download_url_conf = require("controller.filedownloader.download_url_conf")

function var_0_1:readJsonFile(arg_1_1)
	local var_1_0 = self:getDataFromFile(arg_1_1)

	assert(var_1_0, "ReadJsonFile Error")

	return json.decode(var_1_0)
end

local var_0_3
local var_0_4 = "filelist.json"
local var_0_5
local var_0_6 = "spinefilelist.json"
local var_0_7
local var_0_8 = "l2dfilelist.json"
local var_0_9
local var_0_10 = "tarfilelist.json"
local var_0_12 = require("controller.filedownloader.downloadedfiles").new()

local function var_0_13()
	var_0_3 = var_0_1:isFileExist(var_0_4) and var_0_1:readJsonFile(var_0_4) or {}

	return var_0_3
end

local function var_0_14()
	var_0_5 = var_0_1:isFileExist(var_0_6) and var_0_1:readJsonFile(var_0_6) or {}

	return var_0_5
end

local function var_0_15()
	var_0_7 = var_0_1:isFileExist(var_0_8) and var_0_1:readJsonFile(var_0_8) or {}

	return var_0_7
end

local function var_0_17()
	return var_0_12
end

local function var_0_19()
	return
end

local var_0_20 = {
	["role1/"] = "roleimage/",
	["emoji/"] = "ui/",
	["role/"] = "roleimage/"
}

local function var_0_21(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(var_0_20) do
		if arg_9_0:find("^" .. iter_9_0) then
			return iter_9_1 .. arg_9_0
		end
	end

	return arg_9_0
end

local function var_0_22(arg_10_0)
	return string.format("%s/res/%s", download_url_conf:getDownloadURL(), arg_10_0)
end

local function var_0_23(arg_11_0)
	return string.format("%s/zip/%s", download_url_conf:getDownloadURL(), arg_11_0)
end

local function var_0_24(arg_12_0)
	if not var_0_3 then
		error("Need Init FileConfList!!!!!!!")
	end

	if not var_0_3[arg_12_0] then
		return nil
	end

	return var_0_22(var_0_3[arg_12_0].file)
end

local function var_0_26(arg_14_0)
	if not var_0_3 then
		error("Need Init FileConfList!!!!!!")
	end

	return var_0_3[var_0_21(arg_14_0)] ~= nil
end

local function var_0_27(arg_15_0)
	if not var_0_3 then
		error("Need Init FileConfList!!!!!")
	end

	local var_15_0

	if not var_0_3[arg_15_0] then
		do return nil end

		var_15_0 = {
			url = var_0_22(var_0_3[arg_15_0].file),
			filename = var_0_3[arg_15_0].file,
			dst = arg_15_0
		}
	end

	var_15_0.size = var_0_3[arg_15_0].size

	return var_15_0
end

local function var_0_28(arg_16_0)
	return var_0_27(var_0_21(arg_16_0))
end

local var_0_29 = {}

local function var_0_30(arg_17_0)
	local var_17_0 = var_0_21(arg_17_0)

	if var_0_12:isFileExist(var_17_0) then
		return true
	end

	if var_0_29[var_17_0] then
		return false
	end

	if not var_0_1:isFileExist(arg_17_0) then
		var_0_29[var_17_0] = true

		return false
	else
		return true
	end
end

local function var_0_31(arg_18_0)
	var_0_29[var_0_21(arg_18_0)] = nil
end

local function var_0_32(arg_19_0)
	if not var_0_5 then
		error("Need Init SpineFileConfList!!!!!")
	end

	return var_0_5[arg_19_0]
end

local function var_0_33(arg_20_0)
	if not var_0_7 then
		error("Need Init L2DFileConfList!!!!")
	end

	return var_0_7[arg_20_0]
end

var_0_0._fileconflist = nil
var_0_0._spineconflist = nil
var_0_0._l2dconflist = nil
var_0_0._downloadedfilelist = nil

function var_0_0.init(arg_21_0)
	arg_21_0._fileconflist = var_0_13()
	arg_21_0._spineconflist = var_0_14()
	arg_21_0._l2dconflist = var_0_15()
	arg_21_0._downloadedfilelist = var_0_17()
end

function var_0_0:getAllFileList()
	return self._fileconflist
end

function var_0_0:getAllL2dConfList()
	return self._l2dconflist
end

function var_0_0.getFullIndexPathForFile(arg_24_0, arg_24_1)
	return var_0_21(arg_24_1)
end

function var_0_0.getFullDownloadURL(arg_25_0, arg_25_1)
	return var_0_22(arg_25_1)
end

function var_0_0.getFileDownloadInfo(arg_26_0, arg_26_1)
	return var_0_28(arg_26_1)
end

function var_0_0.getZipFileDownloadInfo(arg_27_0, arg_27_1)
	return {
		url = var_0_23(arg_27_1.file),
		filename = arg_27_1.file,
		dst = arg_27_1.file,
		size = arg_27_1.size,
		filelist = arg_27_1.filelist
	}
end

function var_0_0.isFileExist(arg_28_0, arg_28_1)
	return var_0_30(arg_28_1)
end

function var_0_0:onFileDownloadComplete(arg_29_1)
	var_0_31(arg_29_1)
	self._downloadedfilelist:add(var_0_21(arg_29_1))
end

function var_0_0.checkFileNeedDownload(arg_30_0, arg_30_1)
	if var_0_30(arg_30_1) then
		return false
	end

	return var_0_26(arg_30_1)
end

function var_0_0.isFileHaveDownloadInfo(arg_31_0, arg_31_1)
	return var_0_26(arg_31_1)
end

function var_0_0.saveDownloadedFileList(arg_32_0)
	var_0_19()
end

function var_0_0.mergeDownloadList(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		if not var_33_1[iter_33_1.url] then
			table.insert(var_33_0, iter_33_1)

			var_33_1[iter_33_1.url] = true
		end
	end

	return var_33_0
end

function var_0_0:checkFileNeedDownloadByList(arg_34_1)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		if self:checkFileNeedDownload(iter_34_1) then
			table.insert(var_34_0, self:getFileDownloadInfo(iter_34_1))
		end
	end

	if #var_34_0 > 0 then
		return true, self:mergeDownloadList(var_34_0)
	else
		return false
	end
end

function var_0_0:checkSpineFile(arg_35_1)
	local var_35_0 = io.pathinfo(arg_35_1)
	local var_35_1 = {}
	local var_35_2 = var_0_32(var_35_0.dirname:gsub("/", "") .. var_35_0.basename)

	if not var_35_2 then
		return false
	end

	for iter_35_0, iter_35_1 in ipairs(var_35_2) do
		if self:checkFileNeedDownload(iter_35_1) then
			table.insert(var_35_1, self:getFileDownloadInfo(iter_35_1))
		end
	end

	if #var_35_1 > 0 then
		return true, self:mergeDownloadList(var_35_1)
	else
		return false
	end
end

function var_0_0:checkSpineByID(arg_36_1)
	local var_36_0 = {}
	local var_36_1 = var_0_32("spinetest" .. arg_36_1)

	if not var_36_1 then
		return false
	end

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		if self:checkFileNeedDownload(iter_36_1) then
			table.insert(var_36_0, self:getFileDownloadInfo(iter_36_1))
		end
	end

	if #var_36_0 > 0 then
		return true, self:mergeDownloadList(var_36_0)
	else
		return false
	end
end

function var_0_0:checkSpineByIDList(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		local var_37_1 = var_0_32("spinetest" .. iter_37_1)

		if var_37_1 then
			for iter_37_2, iter_37_3 in ipairs(var_37_1) do
				if self:checkFileNeedDownload(iter_37_3) then
					table.insert(var_37_0, self:getFileDownloadInfo(iter_37_3))
				end
			end
		end
	end

	if #var_37_0 > 0 then
		return true, self:mergeDownloadList(var_37_0)
	else
		return false
	end
end

function var_0_0:checkL2DFile(arg_38_1)
	local var_38_0 = {}
	local var_38_1 = var_0_33("l2d" .. arg_38_1)

	if not var_38_1 then
		return false
	end

	for iter_38_0, iter_38_1 in ipairs(var_38_1) do
		if self:checkFileNeedDownload(iter_38_1) then
			table.insert(var_38_0, self:getFileDownloadInfo(iter_38_1))
		end
	end

	if #var_38_0 > 0 then
		return true, self:mergeDownloadList(var_38_0)
	else
		return false
	end
end

local function var_0_34(arg_39_0)
	local var_39_0 = {}
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in pairs((require("fight.spine." .. require("data.model_data")[arg_39_0].spinecfg))) do
		if iter_39_1.exe_tbl then
			for iter_39_2, iter_39_3 in ipairs(iter_39_1.exe_tbl) do
				if iter_39_3.effect then
					for iter_39_4, iter_39_5 in ipairs(iter_39_3.effect) do
						var_39_0[iter_39_5.name] = true
					end
				end

				if iter_39_3.sound then
					local var_39_2 = type(iter_39_3.sound)

					if var_39_2 == "string" then
						var_39_1[iter_39_3.sound] = true
					elseif var_39_2 == "table" then
						var_39_1[iter_39_3.sound[1]] = true
					end
				end
			end
		end
	end

	local var_39_3 = {}

	for iter_39_6, iter_39_7 in pairs(var_39_0) do
		table.insert(var_39_3, iter_39_6)
	end

	local var_39_4 = {}

	for iter_39_8, iter_39_9 in pairs(var_39_1) do
		table.insert(var_39_4, "sound/" .. iter_39_8 .. ".ogg")
	end

	return var_39_3, var_39_4
end

local function var_0_35(arg_40_0)
	local var_40_0 = require("fight.spine." .. require("data.model_data")[arg_40_0].spinecfg)
	local var_40_1 = {}
	local var_40_2 = {}

	if not var_40_0.extra then
		return
	end

	for iter_40_0, iter_40_1 in pairs(var_40_0.extra) do
		var_40_1[iter_40_1.filename] = true

		if iter_40_1.attack and iter_40_1.attack.exe_tbl then
			for iter_40_2, iter_40_3 in ipairs(iter_40_1.attack.exe_tbl) do
				if iter_40_3.effect then
					for iter_40_4, iter_40_5 in ipairs(iter_40_3.effect) do
						var_40_1[iter_40_5.name] = true
					end
				end

				if iter_40_3.sound then
					local var_40_3 = type(iter_40_3.sound)

					if var_40_3 == "string" then
						var_40_2[iter_40_3.sound] = true
					elseif var_40_3 == "table" then
						var_40_2[iter_40_3.sound[1]] = true
					end
				end
			end
		end
	end

	local var_40_4 = {}

	for iter_40_6, iter_40_7 in pairs(var_40_1) do
		table.insert(var_40_4, iter_40_6)
	end

	local var_40_5 = {}

	for iter_40_8, iter_40_9 in pairs(var_40_2) do
		table.insert(var_40_5, "sound/" .. iter_40_8 .. ".ogg")
	end

	return var_40_4, var_40_5
end

local function var_0_36(arg_41_0)
	local var_41_0 = require("fight.spine." .. require("data.model_data")[arg_41_0].spinecfg)

	if not var_41_0.xpeffect then
		return
	end

	local var_41_1 = {}
	local var_41_2 = {}

	for iter_41_0, iter_41_1 in pairs(var_41_0.xpeffect) do
		var_41_1[iter_41_1.bgfile] = true

		if iter_41_1.inserteffect then
			for iter_41_2, iter_41_3 in ipairs(iter_41_1.inserteffect) do
				if iter_41_3.sound then
					var_41_2[iter_41_3.sound[1]] = true
				end
			end
		end
	end

	local var_41_3 = {}

	for iter_41_4, iter_41_5 in pairs(var_41_1) do
		table.insert(var_41_3, iter_41_4)
	end

	local var_41_4 = {}

	for iter_41_6, iter_41_7 in pairs(var_41_2) do
		table.insert(var_41_4, "sound/" .. iter_41_6 .. ".ogg")
	end

	return var_41_3, var_41_4
end

function var_0_0:checkBattleSpineByModel(arg_42_1)
	local var_42_0 = {}
	local var_42_1 = require("data.model_data")[arg_42_1]
	local var_42_2, var_42_3 = self:checkSpineByID(var_42_1.spine_model)

	if var_42_2 then
		table.insertto(var_42_0, var_42_3, 0)
	end

	local var_42_4, var_42_5 = var_0_34(arg_42_1)

	if var_42_4 then
		for iter_42_0, iter_42_1 in pairs(var_42_4) do
			local var_42_6, var_42_7 = self:checkSpineByID(iter_42_1)

			if var_42_6 then
				table.insertto(var_42_0, var_42_7, 0)
			end
		end
	end

	if var_42_5 then
		local var_42_8, var_42_9 = self:checkFileNeedDownloadByList(var_42_5)

		if var_42_8 then
			table.insertto(var_42_0, var_42_9)
		end
	end

	local var_42_10, var_42_11 = var_0_35(arg_42_1)

	if var_42_10 then
		for iter_42_2, iter_42_3 in pairs(var_42_10) do
			local var_42_12, var_42_13 = self:checkSpineByID(iter_42_3)

			if var_42_12 then
				table.insertto(var_42_0, var_42_13, 0)
			end
		end
	end

	if var_42_11 then
		local var_42_14, var_42_15 = self:checkFileNeedDownloadByList(var_42_11)

		if var_42_14 then
			table.insertto(var_42_0, var_42_15)
		end
	end

	local var_42_16, var_42_17 = var_0_36(arg_42_1)

	if var_42_16 then
		for iter_42_4, iter_42_5 in pairs(var_42_16) do
			local var_42_18, var_42_19 = self:checkSpineByID(iter_42_5)

			if var_42_18 then
				table.insertto(var_42_0, var_42_19, 0)
			end
		end
	end

	if var_42_17 then
		local var_42_20, var_42_21 = self:checkFileNeedDownloadByList(var_42_17)

		if var_42_20 then
			table.insertto(var_42_0, var_42_21)
		end
	end

	if var_42_1.role_image then
		if self:checkFileNeedDownload(ROLE_IMAGE_PATH .. var_42_1.role_image .. ".png") then
			table.insert(var_42_0, self:getFileDownloadInfo(ROLE_IMAGE_PATH .. var_42_1.role_image .. ".png"))
		end
	end

	return self:mergeDownloadList(var_42_0)
end

function var_0_0:checkBattleSpineResource(arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = {}
	local var_43_1, var_43_2 = self:checkSpineFile(arg_43_1)

	if var_43_1 then
		table.insertto(var_43_0, var_43_2, 0)
	end

	if arg_43_2 then
		if self:checkFileNeedDownload(arg_43_2 .. ".atlas") then
			table.insert(var_43_0, self:getFileDownloadInfo(arg_43_2 .. ".atlas"))
		end

		if self:checkFileNeedDownload(arg_43_2 .. ".png") then
			table.insert(var_43_0, self:getFileDownloadInfo(arg_43_2 .. ".png"))
		end
	end

	if arg_43_3 and self:checkFileNeedDownload(arg_43_3) then
		table.insert(var_43_0, self:getFileDownloadInfo(arg_43_3))
	end

	if #var_43_0 > 0 then
		return true, self:mergeDownloadList(var_43_0)
	else
		return false
	end
end

local var_0_37 = {
	ROLE_CONVERSATION_TYPE.home,
	ROLE_CONVERSATION_TYPE.changeShowgilr,
	ROLE_CONVERSATION_TYPE.mainTouch,
	ROLE_CONVERSATION_TYPE.fight,
	ROLE_CONVERSATION_TYPE.passlevel,
	ROLE_CONVERSATION_TYPE.lose,
	ROLE_CONVERSATION_TYPE.dormTouch,
	ROLE_CONVERSATION_TYPE.favorUpgrade,
	ROLE_CONVERSATION_TYPE.gift,
	ROLE_CONVERSATION_TYPE.changeDress,
	ROLE_CONVERSATION_TYPE.angry,
	ROLE_CONVERSATION_TYPE.win,
	ROLE_CONVERSATION_TYPE.dormDaily,
	ROLE_CONVERSATION_TYPE.dormFirst,
	ROLE_CONVERSATION_TYPE.xp,
	ROLE_CONVERSATION_TYPE.marry
}

function var_0_0:checkSoundSourceByServant(arg_44_1)
	local servant_data = require("data.servant_data")
	local var_44_1 = {}
	local role_conversation_index_data = require("data.role_conversation_index_data")
	local role_conversation_data = require("data.role_conversation_data")

	if role_conversation_index_data[tostring(servant_data[arg_44_1].major)] then
		local var_44_4 = {}

		for iter_44_0, iter_44_1 in pairs(role_conversation_index_data[tostring(servant_data[arg_44_1].major)]) do
			var_44_4[iter_44_1] = true
		end

		if role_conversation_index_data[servant_data[arg_44_1].modelid] then
			for iter_44_2, iter_44_3 in pairs(role_conversation_index_data[servant_data[arg_44_1].modelid]) do
				var_44_4[iter_44_3] = true
			end
		end

		for iter_44_4, iter_44_5 in pairs(role_conversation_data) do
			if var_44_4[iter_44_5.classification] and iter_44_5.sound then
				if self:checkFileNeedDownload("sound/role_voice/" .. iter_44_5.sound .. ".ogg") then
					table.insert(var_44_1, self:getFileDownloadInfo("sound/role_voice/" .. iter_44_5.sound .. ".ogg"))
				end
			end
		end
	else
		for iter_44_6, iter_44_7 in pairs(var_0_37) do
			local var_44_5 = GenerateRoleConversationClass(servant_data[arg_44_1].modelid, iter_44_7)

			for iter_44_8, iter_44_9 in pairs(role_conversation_data) do
				if iter_44_9.classification == var_44_5 and iter_44_9.sound then
					if self:checkFileNeedDownload("sound/role_voice/" .. iter_44_9.sound .. ".ogg") then
						table.insert(var_44_1, self:getFileDownloadInfo("sound/role_voice/" .. iter_44_9.sound .. ".ogg"))
					end
				end
			end
		end
	end

	if #var_44_1 > 0 then
		return true, self:mergeDownloadList(var_44_1)
	else
		return false
	end
end

function var_0_0:checkSoundSourceByModel(arg_45_1)
	local var_45_0 = {}
	local role_conversation_index_data = require("data.role_conversation_index_data")

	if not role_conversation_index_data[arg_45_1] then
		return false
	end

	local var_45_2 = {}

	for iter_45_0, iter_45_1 in pairs(role_conversation_index_data[arg_45_1]) do
		var_45_2[iter_45_1] = true
	end

	for iter_45_2, iter_45_3 in pairs((require("data.role_conversation_data"))) do
		if var_45_2[iter_45_3.classification] and iter_45_3.sound then
			if self:checkFileNeedDownload("sound/role_voice/" .. iter_45_3.sound .. ".ogg") then
				table.insert(var_45_0, self:getFileDownloadInfo("sound/role_voice/" .. iter_45_3.sound .. ".ogg"))
			end
		end
	end

	if #var_45_0 > 0 then
		return true, self:mergeDownloadList(var_45_0)
	else
		return false
	end
end

function var_0_0.checkAllLackResource(arg_47_0)
	return {}
end

var_0_0:init()

return var_0_0
