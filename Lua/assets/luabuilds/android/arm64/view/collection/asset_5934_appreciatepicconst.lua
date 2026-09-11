AppreciatePicConst = {}

local var_0_0 = AppreciatePicConst

AppreciatePicConst.MAX_COUNT = 12
AppreciatePicConst.TYPE_GALLERY = 1
AppreciatePicConst.TYPE_MANGA = 2

function AppreciatePicConst.filterExistGalleryPicIDList(arg_1_0)
	local var_1_0 = {}

	if arg_1_0 and type(arg_1_0) == "table" then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			local var_1_1 = GalleryConst.GetGalleryPicPathByID(iter_1_1)

			if var_1_1 and checkABExist(var_1_1) then
				table.insert(var_1_0, iter_1_1)
			end
		end
	end

	return var_1_0
end

function AppreciatePicConst.filterExistMangaPicIDList(arg_2_0)
	local var_2_0 = {}

	if arg_2_0 and type(arg_2_0) == "table" then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			local var_2_1 = MangaConst.GetMangaPicPathByID(iter_2_1)

			if var_2_1 and checkABExist(var_2_1) then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	return var_2_0
end

function AppreciatePicConst.getDefaultGalleryPicIDList()
	local var_3_0 = {}

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
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function AppreciatePicConst.getOldLoadingPicIDList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(pg.gallery_config.all) do
		if iter_4_1 > 1000 then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function AppreciatePicConst.createPicInfo(arg_5_0, arg_5_1)
	local var_5_0 = {
		type = arg_5_0,
		id = arg_5_1
	}

	if arg_5_0 == var_0_0.TYPE_GALLERY then
		var_5_0.path = GalleryConst.GetGalleryPicPathByID(arg_5_1)
	elseif arg_5_0 == var_0_0.TYPE_MANGA then
		var_5_0.path = MangaConst.GetMangaPicPathByID(arg_5_1)
	end

	return var_5_0
end

function AppreciatePicConst.getRandomLoadingPic()
	local var_6_0 = getProxy(LoadingPicProxy)

	if not var_6_0 then
		return nil
	end

	if not var_6_0:getDiyModeOpenFlag() then
		return {
			type = var_0_0.TYPE_GALLERY,
			path = "loadingbg/bg_" .. math.random(1, var_0_0.MAX_COUNT)
		}
	end

	local var_6_1 = AppreciatePicConst.filterExistGalleryPicIDList((var_6_0:getGalleryPicIDList()))
	local var_6_2 = AppreciatePicConst.filterExistMangaPicIDList((var_6_0:getMangaPicIDList()))

	if #var_6_1 + #var_6_2 == 0 then
		var_6_1 = var_0_0.getDefaultGalleryPicIDList()
		var_6_2 = {}
	end

	local var_6_3 = #var_6_1 + #var_6_2

	assert(#var_6_1 + #var_6_2 > 0, "loading pic count should be greater than 0")

	local var_6_5 = math.random(1, var_6_3)

	return var_6_5 <= #var_6_1 and var_0_0.createPicInfo(var_0_0.TYPE_GALLERY, var_6_1[var_6_5]) or var_0_0.createPicInfo(var_0_0.TYPE_MANGA, var_6_2[var_6_5 - #var_6_1])
end

function AppreciatePicConst.checkDownloadMissingPic(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}

	if getProxy(LoadingPicProxy) then
		var_7_0 = getProxy(LoadingPicProxy):getGalleryPicIDList()
		var_7_1 = getProxy(LoadingPicProxy):getMangaPicIDList()
	end

	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs((AppreciatePicConst.getDefaultGalleryPicIDList())) do
		local var_7_3 = GalleryConst.GetGalleryPicPathByID(iter_7_1)

		if var_7_3 then
			table.insert(var_7_2, var_7_3)
			table.insert(var_7_2, var_7_3 .. "_hx")
		end
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		local var_7_4 = GalleryConst.GetGalleryPicPathByID(iter_7_3)

		if var_7_4 then
			table.insert(var_7_2, var_7_4)
			table.insert(var_7_2, var_7_4 .. "_hx")
		end
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_1) do
		local var_7_5 = MangaConst.GetMangaPicPathByID(iter_7_5)

		if var_7_5 then
			table.insert(var_7_2, var_7_5)
			table.insert(var_7_2, var_7_5 .. "_hx")
		end
	end

	if var_7_2 and #var_7_2 > 0 then
		local var_7_6 = {}

		var_7_6.isShowBox = false
		var_7_6.fileList = var_7_2
		var_7_6.finishFunc = arg_7_0

		function var_7_6.onNo()
			return
		end

		function var_7_6.onClose()
			return
		end

		DownloadConst.Download(var_7_6)
	elseif arg_7_0 then
		arg_7_0()
	end

	return
end

function AppreciatePicConst:isUsedPicInfo()
	local var_10_0 = false

	if self.type == var_0_0.TYPE_GALLERY then
		var_10_0 = table.contains(getProxy(LoadingPicProxy):getGalleryPicIDList(true), self.id)
	elseif self.type == var_0_0.TYPE_MANGA then
		var_10_0 = table.contains(getProxy(LoadingPicProxy):getMangaPicIDList(true), self.id)
	end

	return var_10_0
end

function AppreciatePicConst:isNewPicInfo()
	if self.type == var_0_0.TYPE_GALLERY then
		if not table.contains(var_0_0.getGalleryConfigNewIDList(), self.id) then
			return false
		end
	elseif self.type == var_0_0.TYPE_MANGA and not table.contains(var_0_0.getMangaConfigNewIDList(), self.id) then
		return false
	end

	if self.type == var_0_0.TYPE_GALLERY then
		if table.contains(getProxy(LoadingPicProxy):getGalleryNewPicOpenList(true), self.id) then
			return false
		end
	elseif self.type == var_0_0.TYPE_MANGA and table.contains(getProxy(LoadingPicProxy):getMangaNewPicOpenList(true), self.id) then
		return false
	end

	return true
end

function AppreciatePicConst:isPicInfoLiked()
	local var_12_0 = false

	if self.type == var_0_0.TYPE_GALLERY then
		var_12_0 = GalleryConst.isGalleryLikeByID(self.id)
	elseif self.type == var_0_0.TYPE_MANGA then
		var_12_0 = MangaConst.isMangaLikeByID(self.id)
	end

	return var_12_0
end

function AppreciatePicConst.getGalleryConfigNewIDList()
	local var_13_0 = pg.gameset.new_gallery_id_list.description

	if pg.gameset.new_gallery_id_list.description == nil or type(var_13_0) ~= "table" then
		var_13_0 = {}
	end

	return var_13_0
end

function AppreciatePicConst.getMangaConfigNewIDList()
	local var_14_0 = pg.gameset.new_manga_id_list.description

	if pg.gameset.new_manga_id_list.description == nil or type(var_14_0) ~= "table" then
		var_14_0 = {}
	end

	return var_14_0
end

return AppreciatePicConst
