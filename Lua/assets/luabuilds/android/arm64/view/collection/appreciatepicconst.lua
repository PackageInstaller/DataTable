AppreciatePicConst = {}

local var_0_0 = AppreciatePicConst

AppreciatePicConst.MAX_COUNT = 12
AppreciatePicConst.TYPE_GALLERY = 1
AppreciatePicConst.TYPE_MANGA = 2

function AppreciatePicConst.filterExistGalleryPicIDList(arg_1_0)
	if arg_1_0 and type(arg_1_0) == "table" then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			local var_1_0 = GalleryConst.GetGalleryPicPathByID(iter_1_1)

			if var_1_0 and checkABExist(var_1_0) then
				table.insert({}, iter_1_1)
			end
		end
	end

	return {}
end

function AppreciatePicConst.filterExistMangaPicIDList(arg_2_0)
	if arg_2_0 and type(arg_2_0) == "table" then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			local var_2_0 = MangaConst.GetMangaPicPathByID(iter_2_1)

			if var_2_0 and checkABExist(var_2_0) then
				table.insert({}, iter_2_1)
			end
		end
	end

	return {}
end

function AppreciatePicConst.getDefaultGalleryPicIDList()
	for iter_3_0, iter_3_1 in ipairs({
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012
	}) do
		if pg.gallery_config[iter_3_1] then
			table.insert({}, iter_3_1)
		end
	end

	return {}
end

function AppreciatePicConst.createPicInfo(arg_4_0, arg_4_1)
	if arg_4_0 == var_0_0.TYPE_GALLERY then
		({
			type = arg_4_0,
			id = arg_4_1
		}).path = GalleryConst.GetGalleryPicPathByID(arg_4_1)
	elseif arg_4_0 == var_0_0.TYPE_MANGA then
		({
			type = arg_4_0,
			id = arg_4_1
		}).path = MangaConst.GetMangaPicPathByID(arg_4_1)
	end

	return {
		type = arg_4_0,
		id = arg_4_1
	}
end

function AppreciatePicConst.getRandomLoadingPic()
	local var_5_9002
	local var_5_9001
	local var_5_9000

	if not getProxy(LoadingPicProxy) then
		return nil
	end

	local var_5_0 = getProxy(LoadingPicProxy)
	local var_5_1 = getProxy(LoadingPicProxy)
	local var_5_2 = AppreciatePicConst.filterExistGalleryPicIDList(var_5_9002)
	local var_5_3 = AppreciatePicConst.filterExistMangaPicIDList((var_5_1.getMangaPicIDList(var_5_9001)))

	if not getProxy(LoadingPicProxy).getDiyModeOpenFlag((var_5_0.getGalleryPicIDList(var_5_9000))) or #var_5_0 + #var_5_1 == 0 then
		var_5_2 = var_0_0.getDefaultGalleryPicIDList()
		var_5_3 = {}
	end

	local var_5_4 = #var_5_2 + #var_5_3

	assert(#var_5_2 + #var_5_3 > 0, "loading pic count should be greater than 0")

	local var_5_6 = math.random(1, var_5_4)

	return var_5_6 <= #var_5_2 and var_0_0.createPicInfo(var_0_0.TYPE_GALLERY, var_5_2[var_5_6]) or var_0_0.createPicInfo(var_0_0.TYPE_MANGA, var_5_3[var_5_6 - #var_5_2])
end

function AppreciatePicConst.checkDownloadMissingPic(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	if getProxy(LoadingPicProxy) then
		var_6_0 = getProxy(LoadingPicProxy):getGalleryPicIDList()
		var_6_1 = getProxy(LoadingPicProxy):getMangaPicIDList()
	end

	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs((AppreciatePicConst.getDefaultGalleryPicIDList())) do
		local var_6_3 = GalleryConst.GetGalleryPicPathByID(iter_6_1)

		if var_6_3 then
			table.insert(var_6_2, var_6_3)
			table.insert(var_6_2, var_6_3 .. "_hx")
		end
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		local var_6_4 = GalleryConst.GetGalleryPicPathByID(iter_6_3)

		if var_6_4 then
			table.insert(var_6_2, var_6_4)
			table.insert(var_6_2, var_6_4 .. "_hx")
		end
	end

	for iter_6_4, iter_6_5 in ipairs(var_6_1) do
		local var_6_5 = MangaConst.GetMangaPicPathByID(iter_6_5)

		if var_6_5 then
			table.insert(var_6_2, var_6_5)
			table.insert(var_6_2, var_6_5 .. "_hx")
		end
	end

	if var_6_2 and #var_6_2 > 0 then
		({}).isShowBox = false
		;({}).fileList = var_6_2
		;({}).finishFunc = arg_6_0
		;({}).onNo = function()
			return
		end
		;({}).onClose = function()
			return
		end

		DownloadConst.Download({})
	elseif arg_6_0 then
		arg_6_0()
	end

	return
end

function AppreciatePicConst.isUsedPicInfo(arg_9_0)
	local var_9_0 = false

	if arg_9_0.type == var_0_0.TYPE_GALLERY then
		var_9_0 = table.contains(getProxy(LoadingPicProxy):getGalleryPicIDList(true), arg_9_0.id)
	elseif arg_9_0.type == var_0_0.TYPE_MANGA then
		var_9_0 = table.contains(getProxy(LoadingPicProxy):getMangaPicIDList(true), arg_9_0.id)
	end

	return var_9_0
end

function AppreciatePicConst.isNewPicInfo(arg_10_0)
	if arg_10_0.type == var_0_0.TYPE_GALLERY then
		if not table.contains(var_0_0.getGalleryConfigNewIDList(), arg_10_0.id) then
			return false
		end
	elseif arg_10_0.type == var_0_0.TYPE_MANGA and not table.contains(var_0_0.getMangaConfigNewIDList(), arg_10_0.id) then
		return false
	end

	local var_10_0 = getProxy(LoadingPicProxy):getGalleryNewPicOpenList(true)

	if arg_10_0.type == var_0_0.TYPE_GALLERY then
		if table.contains(var_10_0, arg_10_0.id) then
			return false
		end
	elseif arg_10_0.type == var_0_0.TYPE_MANGA and table.contains(getProxy(LoadingPicProxy):getMangaNewPicOpenList(true), arg_10_0.id) then
		return false
	end

	return true
end

function AppreciatePicConst.isPicInfoLiked(arg_11_0)
	local var_11_0 = false

	if arg_11_0.type == var_0_0.TYPE_GALLERY then
		var_11_0 = GalleryConst.isGalleryLikeByID(arg_11_0.id)
	elseif arg_11_0.type == var_0_0.TYPE_MANGA then
		var_11_0 = MangaConst.isMangaLikeByID(arg_11_0.id)
	end

	return var_11_0
end

function AppreciatePicConst.getGalleryConfigNewIDList()
	local var_12_0 = pg.gameset.new_gallery_id_list.description

	if pg.gameset.new_gallery_id_list.description == nil or type(var_12_0) ~= "table" then
		var_12_0 = {}
	end

	return var_12_0
end

function AppreciatePicConst.getMangaConfigNewIDList()
	local var_13_0 = pg.gameset.new_manga_id_list.description

	if pg.gameset.new_manga_id_list.description == nil or type(var_13_0) ~= "table" then
		var_13_0 = {}
	end

	return var_13_0
end

return AppreciatePicConst
