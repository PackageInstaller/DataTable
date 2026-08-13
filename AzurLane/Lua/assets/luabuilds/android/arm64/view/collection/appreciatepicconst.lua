local var_0_0 = {}

AppreciatePicConst = AppreciatePicConst
var_0.MAX_COUNT = 12
var_0.TYPE_GALLERY = 1
var_0.TYPE_MANGA = 2

function var_0.filterExistGalleryPicIDList(arg_1_0)
	local var_1_0 = {}

	if arg_1_0 then
		type = var_1_10002

		if var_1_10002(arg_1_0) == "table" then
			ipairs = var_2

			for iter_1_0, iter_1_1 in var_2(arg_1_0) do
				GalleryConst = var_1_10007

				if var_1_10007.GetGalleryPicPathByID(iter_1_1) then
					checkABExist = var_1_10008

					if var_1_10008(var_1_10007) then
						table = var_1_10008

						var_1_10008.insert(var_1_0, iter_1_1)
					end
				end
			end
		end
	end

	return var_1_0
end

function var_0.filterExistMangaPicIDList(arg_2_0)
	local var_2_0 = {}

	if arg_2_0 then
		type = var_1_10002

		if var_1_10002(arg_2_0) == "table" then
			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(arg_2_0) do
				MangaConst = var_1_10007

				if var_1_10007.GetMangaPicPathByID(iter_2_1) then
					checkABExist = var_1_10008

					if var_1_10008(var_1_10007) then
						table = var_1_10008

						var_1_10008.insert(var_2_0, iter_2_1)
					end
				end
			end
		end
	end

	return var_2_0
end

function var_0.getDefaultGalleryPicIDList()
	local var_3_0 = {
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
	}
	local var_3_1 = {}

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_3_0) do
		pg = var_1_10007

		if var_1_10007.gallery_config[iter_3_1] then
			table = var_1_10008

			var_1_10008.insert(var_3_1, iter_3_1)
		end
	end

	return var_3_1
end

function var_0.createPicInfo(arg_4_0, arg_4_1)
	local var_4_0 = {
		type = arg_4_0,
		id = arg_4_1
	}

	if arg_4_0 == var_0.TYPE_GALLERY then
		GalleryConst = var_3
		var_4_0.path = var_3.GetGalleryPicPathByID(arg_4_1)
	elseif arg_4_0 == var_0.TYPE_MANGA then
		MangaConst = var_3
		var_4_0.path = var_3.GetMangaPicPathByID(arg_4_1)
	end

	return var_4_0
end

function var_0.getRandomLoadingPic()
	getProxy = var_1_10000
	LoadingPicProxy = var_1_10002

	if not var_1_10000(var_1_10002) then
		return nil
	end

	getProxy = var_1_10001
	LoadingPicProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getGalleryPicIDList(var_5_0)

	getProxy = var_1_10002
	LoadingPicProxy = var_1_10004

	local var_5_2 = var_1_10002(var_1_10004)
	local var_5_3 = var_2.getMangaPicIDList(var_5_2)

	AppreciatePicConst = var_5_0

	local var_5_4 = var_5_0.filterExistGalleryPicIDList(var_5_1)

	AppreciatePicConst = var_5_2

	local var_5_5 = var_5_2.filterExistMangaPicIDList(var_5_3)

	getProxy = var_5
	LoadingPicProxy = var_1_10007

	local var_5_6 = var_5(var_1_10007)
	local var_5_7 = var_5.getDiyModeOpenFlag(var_5_6)
	local var_5_8 = #var_5_4 + #var_5_5

	if not var_5_7 or var_5_8 == 0 then
		var_5_4 = var_0.getDefaultGalleryPicIDList()
		var_5_5 = {}
	end

	local var_5_9 = #var_5_4 + #var_5_5

	assert = var_7

	var_7(var_5_9 > 0, "loading pic count should be greater than 0")

	local var_5_10

	math = var_8

	if var_8.random(1, var_5_9) <= #var_5_4 then
		local var_5_11 = var_5_4[var_8]

		var_5_10 = var_0.createPicInfo(var_0.TYPE_GALLERY, var_5_11)
	else
		local var_5_12 = var_5_5[var_8 - #var_5_4]

		var_5_10 = var_0.createPicInfo(var_0.TYPE_MANGA, var_5_12)
	end

	return var_5_10
end

function var_0.checkDownloadMissingPic(arg_6_0)
	AppreciatePicConst = var_1_10001

	local var_6_0 = var_1_10001.getDefaultGalleryPicIDList()
	local var_6_1 = {}
	local var_6_2 = {}

	getProxy = var_1_10004
	LoadingPicProxy = var_1_10006

	if var_1_10004(var_1_10006) then
		getProxy = var_1_10005
		LoadingPicProxy = var_1_10007

		local var_6_3 = var_1_10005(var_1_10007)

		var_6_1 = var_5.getGalleryPicIDList(var_6_3)
		getProxy = var_5
		LoadingPicProxy = var_6_3

		local var_6_4 = var_5(var_6_3)

		var_6_2 = var_5.getMangaPicIDList(var_6_4)
	end

	local var_6_5 = {}

	ipairs = var_1_10006

	for iter_6_0, iter_6_1 in var_1_10006(var_6_0) do
		GalleryConst = var_1_10011

		if var_1_10011.GetGalleryPicPathByID(iter_6_1) then
			table = var_1_10012

			var_1_10012.insert(var_6_5, var_1_10011)

			table = var_1_10012

			var_1_10012.insert(var_6_5, var_1_10011 .. "_hx")
		end
	end

	ipairs = var_6

	for iter_6_2, iter_6_3 in var_6(var_6_1) do
		GalleryConst = var_1_10011

		if var_1_10011.GetGalleryPicPathByID(iter_6_3) then
			table = var_1_10012

			var_1_10012.insert(var_6_5, var_1_10011)

			table = var_1_10012

			var_1_10012.insert(var_6_5, var_1_10011 .. "_hx")
		end
	end

	ipairs = var_6

	for iter_6_4, iter_6_5 in var_6(var_6_2) do
		MangaConst = var_1_10011

		if var_1_10011.GetMangaPicPathByID(iter_6_5) then
			table = var_1_10012

			var_1_10012.insert(var_6_5, var_1_10011)

			table = var_1_10012

			var_1_10012.insert(var_6_5, var_1_10011 .. "_hx")
		end
	end

	if var_6_5 and #var_6_5 > 0 then
		local var_6_6 = {}

		var_6_6.isShowBox = false
		var_6_6.fileList = var_6_5
		var_6_6.finishFunc = arg_6_0

		function var_6_6.onNo()
			return
		end

		function var_6_6.onClose()
			return
		end

		DownloadConst = var_7

		var_7.Download(var_6_6)
	elseif arg_6_0 then
		arg_6_0()
	end

	return
end

function var_0.isUsedPicInfo(arg_9_0)
	local var_9_0 = false

	if arg_9_0.type == var_0.TYPE_GALLERY then
		table = var_2

		local var_9_1 = var_2.contains

		getProxy = var_1_10004
		LoadingPicProxy = var_1_10006
		var_1_10006 = var_1_10004(var_1_10006)
		var_9_0 = var_9_1(var_1_10004.getGalleryPicIDList(var_1_10006, true), arg_9_0.id)
	elseif arg_9_0.type == var_0.TYPE_MANGA then
		table = var_2

		local var_9_2 = var_2.contains

		getProxy = var_1_10004
		LoadingPicProxy = var_1_10006

		local var_9_3 = var_1_10004(var_1_10006)

		var_9_0 = var_9_2(var_4.getMangaPicIDList(var_9_3, true), arg_9_0.id)
	end

	return var_9_0
end

function var_0.isNewPicInfo(arg_10_0)
	local var_10_0 = var_0.getGalleryConfigNewIDList()
	local var_10_1 = var_0.getMangaConfigNewIDList()

	if arg_10_0.type == var_0.TYPE_GALLERY then
		table = var_3

		if not var_3.contains(var_10_0, arg_10_0.id) then
			return false
		end
	elseif arg_10_0.type == var_0.TYPE_MANGA then
		table = var_3

		if not var_3.contains(var_10_1, arg_10_0.id) then
			return false
		end
	end

	getProxy = var_3
	LoadingPicProxy = var_1_10005

	local var_10_2 = var_3(var_1_10005)
	local var_10_3 = var_3.getGalleryNewPicOpenList(var_10_2, true)

	getProxy = var_4
	LoadingPicProxy = var_6

	local var_10_4 = var_4(var_6)
	local var_10_5 = var_4.getMangaNewPicOpenList(var_10_4, true)

	if arg_10_0.type == var_0.TYPE_GALLERY then
		table = var_5

		if var_5.contains(var_10_3, arg_10_0.id) then
			return false
		end
	elseif arg_10_0.type == var_0.TYPE_MANGA then
		table = var_5

		if var_5.contains(var_10_5, arg_10_0.id) then
			return false
		end
	end

	return true
end

function var_0.isPicInfoLiked(arg_11_0)
	local var_11_0 = false

	if arg_11_0.type == var_0.TYPE_GALLERY then
		GalleryConst = var_2
		var_11_0 = var_2.isGalleryLikeByID(arg_11_0.id)
	elseif arg_11_0.type == var_0.TYPE_MANGA then
		MangaConst = var_2
		var_11_0 = var_2.isMangaLikeByID(arg_11_0.id)
	end

	return var_11_0
end

function var_0.getGalleryConfigNewIDList()
	pg = var_1_10000

	if var_1_10000.gameset.new_gallery_id_list.description ~= nil then
		type = var_1_10001

		local var_12_0

		if var_1_10001(var_12_0) ~= "table" then
			var_12_0 = {}
		end

		return var_12_0
	end
end

function var_0.getMangaConfigNewIDList()
	pg = var_1_10000

	if var_1_10000.gameset.new_manga_id_list.description ~= nil then
		type = var_1_10001

		local var_13_0

		if var_1_10001(var_13_0) ~= "table" then
			var_13_0 = {}
		end

		return var_13_0
	end
end

return var_0
