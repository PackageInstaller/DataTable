local var_0_0 = class("LoadingPicProxy", import(".NetProxy"))
local var_0_1 = false
local var_0_2 = "LoadingPicProxy"

local function var_0_3(...)
	if var_0_1 then
		print(var_0_2, ...)
	end

	return
end

function var_0_0.register(arg_2_0)
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.diyModeOpenFlag = false
	arg_3_0.galleryPicIDList = {}
	arg_3_0.mangaPicIDList = {}
	arg_3_0.galleryNewPicOpenList = {}
	arg_3_0.mangaNewPicOpenList = {}

	arg_3_0:initNewPicOpenList()

	return
end

function var_0_0.addListener(arg_4_0)
	arg_4_0:on(11003, function(arg_5_0)
		arg_4_0:updateDiyModeOpenFlag(arg_5_0.loading_pic_open_flag)
		arg_4_0:updateGalleryPicIDList(arg_5_0.loading_pic_id_list_1)
		arg_4_0:updateMangaPicIDList(arg_5_0.loading_pic_id_list_2)
		arg_4_0:checkExistCount()

		return
	end)

	return
end

function var_0_0.updateDiyModeOpenFlag(arg_6_0, arg_6_1)
	if type(arg_6_1) == "number" then
		if arg_6_1 == 1 then
			arg_6_1 = true
		elseif arg_6_1 == 0 then
			arg_6_1 = false
		end
	end

	arg_6_0.diyModeOpenFlag = tobool(arg_6_1)

	var_0_3("updateDiyModeOpenFlag", arg_6_1, tostring(arg_6_0.diyModeOpenFlag))

	return
end

function var_0_0.getDiyModeOpenFlag(arg_7_0)
	var_0_3("getDiyModeOpenFlag", tostring(arg_7_0.diyModeOpenFlag))

	return arg_7_0.diyModeOpenFlag
end

function var_0_0.updateGalleryPicIDList(arg_8_0, arg_8_1)
	arg_8_0.galleryPicIDList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		iter_8_1 = tonumber(iter_8_1)

		table.insert(arg_8_0.galleryPicIDList, iter_8_1)
	end

	var_0_3("updateGalleryPicIDList", table.concat(arg_8_0.galleryPicIDList, ","))

	return
end

function var_0_0.getGalleryPicIDList(arg_9_0, arg_9_1)
	var_0_3("getGalleryPicIDList", table.concat(arg_9_0.galleryPicIDList, ","))

	if arg_9_1 then
		return arg_9_0.galleryPicIDList or Clone(arg_9_0.galleryPicIDList)
	end
end

function var_0_0.updateMangaPicIDList(arg_10_0, arg_10_1)
	arg_10_0.mangaPicIDList = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		iter_10_1 = tonumber(iter_10_1)

		table.insert(arg_10_0.mangaPicIDList, iter_10_1)
	end

	var_0_3("updateMangaPicIDList", table.concat(arg_10_0.mangaPicIDList, ","))

	return
end

function var_0_0.getMangaPicIDList(arg_11_0, arg_11_1)
	var_0_3("getMangaPicIDList", table.concat(arg_11_0.mangaPicIDList, ","))

	if arg_11_1 then
		return arg_11_0.mangaPicIDList or Clone(arg_11_0.mangaPicIDList)
	end
end

function var_0_0.checkExistCount(arg_12_0)
	if #AppreciatePicConst.filterExistGalleryPicIDList(arg_12_0:getGalleryPicIDList(true)) + #AppreciatePicConst.filterExistMangaPicIDList(arg_12_0:getMangaPicIDList(true)) == 0 then
		arg_12_0:sendNotification(GAME.UPDATE_LOADING_PIC_DONE, {
			galleryPicIDList = AppreciatePicConst.getDefaultGalleryPicIDList()
		})
	end

	return
end

function var_0_0.initNewPicOpenList(arg_13_0)
	arg_13_0.galleryNewPicOpenList = {}
	arg_13_0.mangaNewPicOpenList = {}

	for iter_13_0, iter_13_1 in ipairs(PlayerPrefs.GetString("galleryNew_pic_open_list", ""):split(",")) do
		iter_13_1 = tonumber(iter_13_1)

		if not table.contains(arg_13_0.galleryNewPicOpenList, iter_13_1) then
			table.insert(arg_13_0.galleryNewPicOpenList, iter_13_1)
		end
	end

	for iter_13_2, iter_13_3 in ipairs(PlayerPrefs.GetString("mangaNew_pic_open_list", ""):split(",")) do
		iter_13_3 = tonumber(iter_13_3)

		if not table.contains(arg_13_0.mangaNewPicOpenList, iter_13_3) then
			table.insert(arg_13_0.mangaNewPicOpenList, iter_13_3)
		end
	end

	return
end

function var_0_0.addGalleryNewPicOpenList(arg_14_0, arg_14_1)
	if not table.contains(AppreciatePicConst.getGalleryConfigNewIDList(), arg_14_1) then
		return
	end

	if not table.contains(arg_14_0.galleryNewPicOpenList, arg_14_1) then
		table.insert(arg_14_0.galleryNewPicOpenList, arg_14_1)
	end

	arg_14_0:saveNewPicOpenList()

	return
end

function var_0_0.addMangaNewPicOpenList(arg_15_0, arg_15_1)
	if not table.contains(AppreciatePicConst.getMangaConfigNewIDList(), arg_15_1) then
		return
	end

	if not table.contains(arg_15_0.mangaNewPicOpenList, arg_15_1) then
		table.insert(arg_15_0.mangaNewPicOpenList, arg_15_1)
	end

	arg_15_0:saveNewPicOpenList()

	return
end

function var_0_0.saveNewPicOpenList(arg_16_0)
	PlayerPrefs.SetString("galleryNew_pic_open_list", table.concat(arg_16_0.galleryNewPicOpenList, ","))
	PlayerPrefs.SetString("mangaNew_pic_open_list", table.concat(arg_16_0.mangaNewPicOpenList, ","))
	PlayerPrefs.Save()

	return
end

function var_0_0.getGalleryNewPicOpenList(arg_17_0, arg_17_1)
	if arg_17_1 then
		return arg_17_0.galleryNewPicOpenList or Clone(arg_17_0.galleryNewPicOpenList)
	end
end

function var_0_0.getMangaNewPicOpenList(arg_18_0, arg_18_1)
	if arg_18_1 then
		return arg_18_0.mangaNewPicOpenList or Clone(arg_18_0.mangaNewPicOpenList)
	end
end

return var_0_0
