class = var_0_10000

local var_0_0 = "LoadingPicProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))
local var_0_2 = false
local var_0_3 = "LoadingPicProxy"

local function var_0_4(...)
	if var_0_2 then
		print = var_0

		var_0(var_0_3, ...)
	end

	return
end

function var_0_1.register(arg_2_0)
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	arg_3_0.diyModeOpenFlag = false
	arg_3_0.galleryPicIDList = {}
	arg_3_0.mangaPicIDList = {}
	arg_3_0.galleryNewPicOpenList = {}
	arg_3_0.mangaNewPicOpenList = {}

	arg_3_0:initNewPicOpenList()

	return
end

function var_0_1.addListener(arg_4_0)
	arg_4_0:on(11003, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.updateDiyModeOpenFlag(var_5_0, arg_5_0.loading_pic_open_flag)

		local var_5_1 = arg_4_0

		var_1.updateGalleryPicIDList(var_5_1, arg_5_0.loading_pic_id_list_1)

		local var_5_2 = arg_4_0

		var_1.updateMangaPicIDList(var_5_2, arg_5_0.loading_pic_id_list_2)

		local var_5_3 = arg_4_0

		var_1.checkExistCount(var_5_3)

		return
	end)

	return
end

function var_0_1.updateDiyModeOpenFlag(arg_6_0, arg_6_1)
	type = var_1_10002

	if var_1_10002(arg_6_1) == "number" then
		if arg_6_1 == 1 then
			arg_6_1 = true
		elseif arg_6_1 == 0 then
			arg_6_1 = false
		end
	end

	tobool = var_2
	arg_6_0.diyModeOpenFlag = var_2(arg_6_1)

	local var_6_0 = var_0_4
	local var_6_1 = "updateDiyModeOpenFlag"
	local var_6_2 = arg_6_1

	tostring = var_1_10005

	var_6_0(var_6_1, var_6_2, var_1_10005(arg_6_0.diyModeOpenFlag))

	return
end

function var_0_1.getDiyModeOpenFlag(arg_7_0)
	local var_7_0 = var_0_4
	local var_7_1 = "getDiyModeOpenFlag"

	tostring = var_1_10003

	var_7_0(var_7_1, var_1_10003(arg_7_0.diyModeOpenFlag))

	return arg_7_0.diyModeOpenFlag
end

function var_0_1.updateGalleryPicIDList(arg_8_0, arg_8_1)
	arg_8_0.galleryPicIDList = {}
	ipairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_1) do
		tonumber = var_1_10007
		iter_8_1 = var_1_10007(iter_8_1)
		table = var_1_10007

		var_1_10007.insert(arg_8_0.galleryPicIDList, iter_8_1)
	end

	local var_8_0 = var_0_4
	local var_8_1 = "updateGalleryPicIDList"

	table = var_4

	var_8_0(var_8_1, var_4.concat(arg_8_0.galleryPicIDList, ","))

	return
end

function var_0_1.getGalleryPicIDList(arg_9_0, arg_9_1)
	local var_9_0 = var_0_4
	local var_9_1 = "getGalleryPicIDList"

	table = var_1_10004

	var_9_0(var_9_1, var_1_10004.concat(arg_9_0.galleryPicIDList, ","))

	if not arg_9_1 or not arg_9_0.galleryPicIDList then
		Clone = var_9_0
		var_9_0 = var_9_0(arg_9_0.galleryPicIDList)
	end

	return var_9_0
end

function var_0_1.updateMangaPicIDList(arg_10_0, arg_10_1)
	arg_10_0.mangaPicIDList = {}
	ipairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_1) do
		tonumber = var_1_10007
		iter_10_1 = var_1_10007(iter_10_1)
		table = var_1_10007

		var_1_10007.insert(arg_10_0.mangaPicIDList, iter_10_1)
	end

	local var_10_0 = var_0_4
	local var_10_1 = "updateMangaPicIDList"

	table = var_4

	var_10_0(var_10_1, var_4.concat(arg_10_0.mangaPicIDList, ","))

	return
end

function var_0_1.getMangaPicIDList(arg_11_0, arg_11_1)
	local var_11_0 = var_0_4
	local var_11_1 = "getMangaPicIDList"

	table = var_1_10004

	var_11_0(var_11_1, var_1_10004.concat(arg_11_0.mangaPicIDList, ","))

	if not arg_11_1 or not arg_11_0.mangaPicIDList then
		Clone = var_11_0
		var_11_0 = var_11_0(arg_11_0.mangaPicIDList)
	end

	return var_11_0
end

function var_0_1.checkExistCount(arg_12_0)
	AppreciatePicConst = var_1_10001

	local var_12_0 = var_1_10001.filterExistGalleryPicIDList(arg_12_0:getGalleryPicIDList(true))

	AppreciatePicConst = var_2

	local var_12_1 = var_2.filterExistMangaPicIDList(arg_12_0:getMangaPicIDList(true))

	if #var_12_0 + #var_12_1 == 0 then
		AppreciatePicConst = var_4

		local var_12_2 = var_4.getDefaultGalleryPicIDList()
		local var_12_3 = {
			galleryPicIDList = var_12_2
		}
		local var_12_4 = arg_12_0
		local var_12_5 = arg_12_0.sendNotification

		GAME = var_1_10008

		var_12_5(var_12_4, var_1_10008.UPDATE_LOADING_PIC_DONE, var_12_3)
	end

	return
end

function var_0_1.initNewPicOpenList(arg_13_0)
	PlayerPrefs = var_1_10001

	local var_13_0 = var_1_10001.GetString("galleryNew_pic_open_list", "")

	PlayerPrefs = var_2

	local var_13_1 = var_2.GetString("mangaNew_pic_open_list", "")

	arg_13_0.galleryNewPicOpenList = {}
	arg_13_0.mangaNewPicOpenList = {}
	ipairs = var_3

	for iter_13_0, iter_13_1 in var_3(var_13_0:split(",")) do
		tonumber = var_1_10008
		iter_13_1 = var_1_10008(iter_13_1)
		table = var_1_10008

		if not var_1_10008.contains(arg_13_0.galleryNewPicOpenList, iter_13_1) then
			table = var_1_10008

			var_1_10008.insert(arg_13_0.galleryNewPicOpenList, iter_13_1)
		end
	end

	ipairs = var_3

	for iter_13_2, iter_13_3 in var_3(var_13_1:split(",")) do
		tonumber = var_1_10008
		iter_13_3 = var_1_10008(iter_13_3)
		table = var_1_10008

		if not var_1_10008.contains(arg_13_0.mangaNewPicOpenList, iter_13_3) then
			table = var_1_10008

			var_1_10008.insert(arg_13_0.mangaNewPicOpenList, iter_13_3)
		end
	end

	return
end

function var_0_1.addGalleryNewPicOpenList(arg_14_0, arg_14_1)
	AppreciatePicConst = var_1_10002

	local var_14_0 = var_1_10002.getGalleryConfigNewIDList()

	table = var_1_10003

	if not var_1_10003.contains(var_14_0, arg_14_1) then
		return
	end

	table = var_4

	if not var_4.contains(arg_14_0.galleryNewPicOpenList, arg_14_1) then
		table = var_4

		var_4.insert(arg_14_0.galleryNewPicOpenList, arg_14_1)
	end

	arg_14_0:saveNewPicOpenList()

	return
end

function var_0_1.addMangaNewPicOpenList(arg_15_0, arg_15_1)
	AppreciatePicConst = var_1_10002

	local var_15_0 = var_1_10002.getMangaConfigNewIDList()

	table = var_1_10003

	if not var_1_10003.contains(var_15_0, arg_15_1) then
		return
	end

	table = var_4

	if not var_4.contains(arg_15_0.mangaNewPicOpenList, arg_15_1) then
		table = var_4

		var_4.insert(arg_15_0.mangaNewPicOpenList, arg_15_1)
	end

	arg_15_0:saveNewPicOpenList()

	return
end

function var_0_1.saveNewPicOpenList(arg_16_0)
	PlayerPrefs = var_1_10001

	local var_16_0 = var_1_10001.SetString
	local var_16_1 = "galleryNew_pic_open_list"

	table = var_1_10003

	var_16_0(var_16_1, var_1_10003.concat(arg_16_0.galleryNewPicOpenList, ","))

	PlayerPrefs = var_16_0

	local var_16_2 = var_16_0.SetString
	local var_16_3 = "mangaNew_pic_open_list"

	table = var_3

	var_16_2(var_16_3, var_3.concat(arg_16_0.mangaNewPicOpenList, ","))

	PlayerPrefs = var_16_2

	var_16_2.Save()

	return
end

function var_0_1.getGalleryNewPicOpenList(arg_17_0, arg_17_1)
	if not arg_17_1 or not arg_17_0.galleryNewPicOpenList then
		Clone = var_1_10002
		var_1_10002 = var_1_10002(arg_17_0.galleryNewPicOpenList)
	end

	return var_1_10002
end

function var_0_1.getMangaNewPicOpenList(arg_18_0, arg_18_1)
	if not arg_18_1 or not arg_18_0.mangaNewPicOpenList then
		Clone = var_1_10002
		var_1_10002 = var_1_10002(arg_18_0.mangaNewPicOpenList)
	end

	return var_1_10002
end

return var_0_1
