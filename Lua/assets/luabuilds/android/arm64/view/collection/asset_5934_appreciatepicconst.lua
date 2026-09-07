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

function AppreciatePicConst.createPicInfo(arg_4_0, arg_4_1)
	local var_4_0 = {
		type = arg_4_0,
		id = arg_4_1
	}

	if arg_4_0 == var_0_0.TYPE_GALLERY then
		var_4_0.path = GalleryConst.GetGalleryPicPathByID(arg_4_1)
	elseif arg_4_0 == var_0_0.TYPE_MANGA then
		var_4_0.path = MangaConst.GetMangaPicPathByID(arg_4_1)
	end

	return var_4_0
end

function AppreciatePicConst.getRandomLoadingPic()
	if not getProxy(LoadingPicProxy) then
		return nil
	end

	local var_5_0 = getProxy(LoadingPicProxy)
	local var_5_1 = getProxy(LoadingPicProxy)
	local var_5_2 = AppreciatePicConst:filterExistGalleryPicIDList()
	local var_5_3 = AppreciatePicConst.filterExistMangaPicIDList((var_5_1:getMangaPicIDList()))

	if not getProxy(LoadingPicProxy).getDiyModeOpenFlag((var_5_0:getGalleryPicIDList())) or #var_5_0 + #var_5_1 == 0 then
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
		local var_6_6 = {}

		var_6_6.isShowBox = false
		var_6_6.fileList = var_6_2
		var_6_6.finishFunc = arg_6_0

		function var_6_6.onNo()
			return
		end

		function var_6_6.onClose()
			return
		end

		DownloadConst.Download(var_6_6)
	elseif arg_6_0 then
		arg_6_0()
	end

	return
end

function AppreciatePicConst:isUsedPicInfo()
	local var_9_0 = false

	if self.type == var_0_0.TYPE_GALLERY then
		var_9_0 = table.contains(getProxy(LoadingPicProxy):getGalleryPicIDList(true), self.id)
	elseif self.type == var_0_0.TYPE_MANGA then
		var_9_0 = table.contains(getProxy(LoadingPicProxy):getMangaPicIDList(true), self.id)
	end

	return var_9_0
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
	local var_11_0 = false

	if self.type == var_0_0.TYPE_GALLERY then
		var_11_0 = GalleryConst.isGalleryLikeByID(self.id)
	elseif self.type == var_0_0.TYPE_MANGA then
		var_11_0 = MangaConst.isMangaLikeByID(self.id)
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
