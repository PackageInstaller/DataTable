class = var_0_10000

local var_0_0 = "AppreciateProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:initData()
	arg_1_0:checkPicFileState()
	arg_1_0:checkMusicFileState()

	return
end

function var_0_1.initData(arg_2_0)
	BundleWizard = var_1_10001

	local var_2_0 = var_1_10001.Inst

	arg_2_0.picManager = var_1.GetGroupMgr(var_2_0, "GALLERY_PIC")
	BundleWizard = var_1

	local var_2_1 = var_1.Inst

	arg_2_0.musicManager = var_1.GetGroupMgr(var_2_1, "GALLERY_BGM")
	PathMgr = var_1
	arg_2_0.reForVer = var_1.MD5Result
	arg_2_0.galleryPicUnLockIDLIst = {}
	arg_2_0.galleryPicExistStateTable = {}
	arg_2_0.galleryPicLikeIDList = {}
	arg_2_0.musicUnLockIDLIst = {}
	arg_2_0.musicExistStateTable = {}
	arg_2_0.musicLikeIDList = {}
	arg_2_0.mangaReadIDList = {}
	arg_2_0.mangaLikeIDList = {}

	local var_2_2 = {
		middleIndex = 1
	}

	GalleryConst = var_2_1
	var_2_2.dateValue = var_2_1.Data_All_Value
	GalleryConst = var_2
	var_2_2.sortValue = var_2.Sort_Order_Up
	GalleryConst = var_2
	var_2_2.likeValue = var_2.Filte_Normal_Value
	GalleryConst = var_2
	var_2_2.bgFilteValue = var_2.Loading_BG_NO_Filte
	arg_2_0.galleryRunData = var_2_2

	local var_2_3 = {
		middleIndex = 1
	}

	MusicCollectionConst = var_2
	var_2_3.sortValue = var_2.Sort_Order_Up
	MusicCollectionConst = var_2
	var_2_3.likeValue = var_2.Filte_Normal_Value
	arg_2_0.musicRunData = var_2_3

	return
end

function var_0_1.checkPicFileState(arg_3_0)
	local var_3_0
	local var_3_1

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10003(var_1_10004.gallery_config.all) do
		pg = var_1_10008

		local var_3_2 = var_1_10008.gallery_config[iter_3_1].illustration

		GalleryConst = var_1_10010

		local var_3_3 = var_1_10010.PIC_PATH_PREFIX .. var_3_2

		checkABExist = var_1_10010

		local var_3_4 = var_1_10010(var_3_3)

		GalleryConst = var_1_10010
		var_1_10010 = var_1_10010.GetGalleryPreviewPicPathByID(iter_3_1)

		if var_3_4 and var_1_10010 then
			::label_3_0::

			checkABExist = var_11
			var_3_4 = var_11(var_1_10010)
		end

		arg_3_0.galleryPicExistStateTable[iter_3_1] = var_3_4
	end

	return
end

function var_0_1.checkMusicFileState(arg_4_0)
	local var_4_0
	local var_4_1

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10003(var_1_10004.music_collect_config.all) do
		pg = var_1_10008

		local var_4_2 = var_1_10008.music_collect_config[iter_4_1].music

		MusicCollectionConst = var_1_10010

		local var_4_3 = var_1_10010.MUSIC_SONG_PATH_PREFIX .. var_4_2 .. ".b"

		checkABExist = var_1_10010
		var_1_10010[iter_4_1], var_1_10010 = var_1_10010(var_4_3), arg_4_0.musicExistStateTable
	end

	return
end

function var_0_1.updatePicFileExistStateTable(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.galleryPicExistStateTable[arg_5_1] = arg_5_2

	return
end

function var_0_1.updateMusicFileExistStateTable(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.musicExistStateTable[arg_6_1] = arg_6_2

	return
end

function var_0_1.getPicExistStateByID(arg_7_0, arg_7_1)
	if not arg_7_1 then
		assert = var_1_10002

		local var_7_0 = "不能为空的picID:"

		tostring = var_1_10004

		var_1_10002(var_7_0 .. var_1_10004(arg_7_1))
	end

	return arg_7_0.galleryPicExistStateTable[arg_7_1]
end

function var_0_1.getMusicExistStateByID(arg_8_0, arg_8_1)
	if not arg_8_1 then
		assert = var_1_10002

		local var_8_0 = "不能为空的musicID:"

		tostring = var_1_10004

		var_1_10002(var_8_0 .. var_1_10004(arg_8_1))
	end

	return arg_8_0.musicExistStateTable[arg_8_1]
end

function var_0_1.getSinglePicConfigByID(arg_9_0, arg_9_1)
	pg = var_1_10002

	if var_1_10002.gallery_config[arg_9_1] then
		return var_2
	else
		assert = var_1_10003

		local var_9_0 = false
		local var_9_1 = "不存在的插画ID:"

		tostring = var_1_10006

		var_1_10003(var_9_0, var_9_1 .. var_1_10006(arg_9_1))
	end

	return
end

function var_0_1.getSingleMusicConfigByID(arg_10_0, arg_10_1)
	pg = var_1_10002

	if var_1_10002.music_collect_config[arg_10_1] then
		return var_2
	else
		assert = var_1_10003

		local var_10_0 = false
		local var_10_1 = "不存在的音乐ID:"

		tostring = var_1_10006

		var_1_10003(var_10_0, var_10_1 .. var_1_10006(arg_10_1))
	end

	return
end

function var_0_1.updateGalleryRunData(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.galleryRunData.dateValue = arg_11_1 and arg_11_1 or arg_11_0.galleryRunData.dateValue
	arg_11_0.galleryRunData.sortValue = arg_11_2 and arg_11_2 or arg_11_0.galleryRunData.sortValue
	arg_11_0.galleryRunData.middleIndex = arg_11_3 and arg_11_3 or arg_11_0.galleryRunData.middleIndex
	arg_11_0.galleryRunData.likeValue = arg_11_4 and arg_11_4 or arg_11_0.galleryRunData.likeValue
	arg_11_0.galleryRunData.bgFilteValue = arg_11_5 and arg_11_5 or arg_11_0.galleryRunData.bgFilteValue

	return
end

function var_0_1.updateMusicRunData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.musicRunData.sortValue = arg_12_1 and arg_12_1 or arg_12_0.musicRunData.sortValue
	arg_12_0.musicRunData.middleIndex = arg_12_2 and arg_12_2 or arg_12_0.musicRunData.middleIndex
	arg_12_0.musicRunData.likeValue = arg_12_3 and arg_12_3 or arg_12_0.musicRunData.likeValue

	return
end

function var_0_1.getGalleryRunData(arg_13_0, arg_13_1)
	return arg_13_0.galleryRunData
end

function var_0_1.getMusicRunData(arg_14_0, arg_14_1)
	return arg_14_0.musicRunData
end

function var_0_1.isPicNeedUnlockByID(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getPicUnlockMaterialByID(arg_15_1)
	local var_15_1 = arg_15_0

	if arg_15_0.getSinglePicConfigByID(var_15_1, arg_15_1) then
		if var_3.unlock_level[1] == 1 and var_15_1[2] == 0 then
			if #var_15_0 == 0 then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		assert = var_15_1

		var_15_1(false, "不存在的插画ID:" .. arg_15_1)
	end

	return
end

function var_0_1.isMusicNeedUnlockByID(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getMusicUnlockMaterialByID(arg_16_1)
	local var_16_1 = arg_16_0

	if arg_16_0.getSingleMusicConfigByID(var_16_1, arg_16_1) then
		if var_3.unlock_level[1] == 1 and var_16_1[2] == 0 then
			if #var_16_0 == 0 then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		assert = var_16_1

		var_16_1(false, "不存在的音乐ID:" .. arg_16_1)
	end

	return
end

function var_0_1.getPicUnlockMaterialByID(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0

	if arg_17_0.getSinglePicConfigByID(var_17_0, arg_17_1) then
		var_17_0 = var_2.unlock_cost

		local var_17_1 = {}

		ipairs = var_1_10005

		for iter_17_0, iter_17_1 in var_1_10005(var_17_0) do
			local var_17_2 = {
				type = iter_17_1[1],
				id = iter_17_1[2],
				count = iter_17_1[3]
			}

			var_17_1[#var_17_1 + 1] = var_17_2
		end

		return var_17_1
	else
		assert = var_17_0

		var_17_0(false, "不存在的插画ID:" .. arg_17_1)
	end

	return
end

function var_0_1.getMusicUnlockMaterialByID(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0

	if arg_18_0.getSingleMusicConfigByID(var_18_0, arg_18_1) then
		var_18_0 = var_2.unlock_cost

		local var_18_1 = {}

		ipairs = var_1_10005

		for iter_18_0, iter_18_1 in var_1_10005(var_18_0) do
			local var_18_2 = {
				type = iter_18_1[1],
				id = iter_18_1[2],
				count = iter_18_1[3]
			}

			var_18_1[#var_18_1 + 1] = var_18_2
		end

		return var_18_1
	else
		assert = var_18_0

		var_18_0(false, "不存在的音乐ID:" .. arg_18_1)
	end

	return
end

function var_0_1.isPicNeedUnlockMaterialByID(arg_19_0, arg_19_1)
	if #arg_19_0:getPicUnlockMaterialByID(arg_19_1) == 0 then
		return false
	else
		return var_2
	end

	return
end

function var_0_1.isMusicNeedUnlockMaterialByID(arg_20_0, arg_20_1)
	if #arg_20_0:getMusicUnlockMaterialByID(arg_20_1) == 0 then
		return false
	else
		return var_2
	end

	return
end

function var_0_1.getPicUnlockTipTextByID(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0

	if arg_21_0.getSinglePicConfigByID(var_21_0, arg_21_1) then
		return var_2.illustrate
	else
		assert = var_21_0

		var_21_0(false, "不存在的插画ID:" .. arg_21_1)
	end

	return
end

function var_0_1.getMusicUnlockTipTextByID(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0

	if arg_22_0.getSingleMusicConfigByID(var_22_0, arg_22_1) then
		return var_2.illustrate
	else
		assert = var_22_0

		var_22_0(false, "不存在的音乐ID:" .. arg_22_1)
	end

	return
end

function var_0_1.getResultForVer(arg_23_0)
	return arg_23_0.reForVer
end

function var_0_1.clearVer(arg_24_0)
	arg_24_0.reForVer = nil

	return
end

function var_0_1.addPicIDToUnlockList(arg_25_0, arg_25_1)
	table = var_1_10002

	if var_1_10002.contains(arg_25_0.galleryPicUnLockIDLIst, arg_25_1) then
		print = var_2

		var_2("already exist picID:" .. arg_25_1)
	else
		arg_25_0.galleryPicUnLockIDLIst[#arg_25_0.galleryPicUnLockIDLIst + 1] = arg_25_1
	end

	return
end

function var_0_1.addMusicIDToUnlockList(arg_26_0, arg_26_1)
	table = var_1_10002

	if var_1_10002.contains(arg_26_0.musicUnLockIDLIst, arg_26_1) then
		print = var_2

		var_2("already exist musicID:" .. arg_26_1)
	else
		arg_26_0.musicUnLockIDLIst[#arg_26_0.musicUnLockIDLIst + 1] = arg_26_1
	end

	return
end

function var_0_1.addMangaIDToReadList(arg_27_0, arg_27_1)
	table = var_1_10002

	if var_1_10002.contains(arg_27_0.mangaReadIDList, arg_27_1) then
		print = var_2

		var_2("already exist mangaID:" .. arg_27_1)
	else
		table = var_2

		var_2.insert(arg_27_0.mangaReadIDList, arg_27_1)
	end

	return
end

function var_0_1.initMangaReadIDList(arg_28_0, arg_28_1)
	arg_28_0.mangaReadIDList = {}
	ipairs = var_2

	for iter_28_0, iter_28_1 in var_2(arg_28_1) do
		for iter_28_2 = 1, 32 do
			bit = var_1_10011
			var_1_10011 = var_1_10011.band

			local var_28_0 = iter_28_1

			bit = var_1_10013
			var_1_10011 = var_1_10011(var_28_0, var_1_10013.lshift(1, iter_28_2 - 1)) ~= 0

			if var_1_10011 then
				local var_28_1 = (iter_28_0 - 1) * 32 + iter_28_2

				arg_28_0:addMangaIDToReadList(var_28_1)
			end
		end
	end

	MangaConst = var_2

	var_2.setVersionAndNewCount()

	return
end

function var_0_1.getMangaReadIDList(arg_29_0)
	return arg_29_0.mangaReadIDList
end

function var_0_1.addMangaIDToLikeList(arg_30_0, arg_30_1)
	table = var_1_10002

	if var_1_10002.contains(arg_30_0.mangaLikeIDList, arg_30_1) then
		print = var_2

		var_2("already exist mangaID:" .. arg_30_1)
	else
		table = var_2

		var_2.insert(arg_30_0.mangaLikeIDList, arg_30_1)
	end

	return
end

function var_0_1.removeMangaIDFromLikeList(arg_31_0, arg_31_1)
	table = var_1_10002

	if var_1_10002.contains(arg_31_0.mangaLikeIDList, arg_31_1) then
		table = var_2

		var_2.removebyvalue(arg_31_0.mangaLikeIDList, arg_31_1, true)
	else
		print = var_2

		var_2("not exist mangaID:" .. arg_31_1)
	end

	return
end

function var_0_1.initMangaLikeIDList(arg_32_0, arg_32_1)
	arg_32_0.mangaLikeIDList = {}
	ipairs = var_2

	for iter_32_0, iter_32_1 in var_2(arg_32_1) do
		for iter_32_2 = 1, 32 do
			bit = var_1_10011
			var_1_10011 = var_1_10011.band

			local var_32_0 = iter_32_1

			bit = var_1_10013
			var_1_10011 = var_1_10011(var_32_0, var_1_10013.lshift(1, iter_32_2 - 1)) ~= 0

			if var_1_10011 then
				local var_32_1 = (iter_32_0 - 1) * 32 + iter_32_2

				arg_32_0:addMangaIDToLikeList(var_32_1)
			end
		end
	end

	return
end

function var_0_1.getMangaLikeIDList(arg_33_0)
	return arg_33_0.mangaLikeIDList
end

function var_0_1.isPicUnlockedByID(arg_34_0, arg_34_1)
	table = var_1_10002

	if var_1_10002.contains(arg_34_0.galleryPicUnLockIDLIst, arg_34_1) then
		return true
	else
		return false
	end

	return
end

function var_0_1.isMusicUnlockedByID(arg_35_0, arg_35_1)
	table = var_1_10002

	if var_1_10002.contains(arg_35_0.musicUnLockIDLIst, arg_35_1) then
		return true
	else
		return false
	end

	return
end

function var_0_1.isPicUnlockableByID(arg_36_0, arg_36_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_36_0 = var_1_10002(var_1_10003)
	local var_36_1 = var_2.getData(var_36_0).level

	if arg_36_0:getSinglePicConfigByID(arg_36_1) then
		local var_36_2 = var_4.unlock_level[1]
		local var_36_3 = var_5[2]

		if var_36_2 <= var_36_1 then
			return true
		else
			GalleryConst = var_1_10008

			if var_36_3 == var_1_10008.Still_Show_On_Lock then
				return false, true
			else
				return false, false
			end
		end
	end

	return
end

function var_0_1.isMusicUnlockableByID(arg_37_0, arg_37_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_37_0 = var_1_10002(var_1_10003)
	local var_37_1 = var_2.getData(var_37_0).level

	if arg_37_0:getSingleMusicConfigByID(arg_37_1) then
		local var_37_2 = var_4.unlock_level[1]
		local var_37_3 = var_5[2]

		if var_37_2 <= var_37_1 then
			return true
		else
			MusicCollectionConst = var_1_10008

			if var_37_3 == var_1_10008.Still_Show_On_Lock then
				return false, true
			else
				return false, false
			end
		end
	end

	return
end

function var_0_1.addPicIDToLikeList(arg_38_0, arg_38_1)
	table = var_1_10002

	if var_1_10002.contains(arg_38_0.galleryPicLikeIDList, arg_38_1) then
		print = var_2

		var_2("already exist picID:" .. arg_38_1)
	else
		arg_38_0.galleryPicLikeIDList[#arg_38_0.galleryPicLikeIDList + 1] = arg_38_1
	end

	return
end

function var_0_1.removePicIDFromLikeList(arg_39_0, arg_39_1)
	ipairs = var_1_10002

	for iter_39_0, iter_39_1 in var_1_10002(arg_39_0.galleryPicLikeIDList) do
		if iter_39_1 == arg_39_1 then
			table = var_1_10007

			var_1_10007.remove(arg_39_0.galleryPicLikeIDList, iter_39_0)

			return
		end
	end

	print = var_2

	var_2("no exist picID:" .. arg_39_1)

	return
end

function var_0_1.isLikedByPicID(arg_40_0, arg_40_1)
	table = var_1_10002

	return var_1_10002.contains(arg_40_0.galleryPicLikeIDList, arg_40_1)
end

function var_0_1.getGalleryLikeIDList(arg_41_0)
	return arg_41_0.galleryPicLikeIDList
end

function var_0_1.addMusicIDToLikeList(arg_42_0, arg_42_1)
	table = var_1_10002

	if var_1_10002.contains(arg_42_0.musicLikeIDList, arg_42_1) then
		print = var_2

		var_2("already exist picID:" .. arg_42_1)
	else
		arg_42_0.musicLikeIDList[#arg_42_0.musicLikeIDList + 1] = arg_42_1
	end

	return
end

function var_0_1.removeMusicIDFromLikeList(arg_43_0, arg_43_1)
	ipairs = var_1_10002

	for iter_43_0, iter_43_1 in var_1_10002(arg_43_0.musicLikeIDList) do
		if iter_43_1 == arg_43_1 then
			table = var_1_10007

			var_1_10007.remove(arg_43_0.musicLikeIDList, iter_43_0)

			return
		end
	end

	print = var_2

	var_2("no exist musicID:" .. arg_43_1)

	return
end

function var_0_1.isLikedByMusicID(arg_44_0, arg_44_1)
	table = var_1_10002

	return var_1_10002.contains(arg_44_0.musicLikeIDList, arg_44_1)
end

function var_0_1.setMainPlayMusicAlbum(arg_45_0, arg_45_1)
	arg_45_0.mainMarkMusicId = arg_45_1

	return
end

function var_0_1.getMainPlayerAlbumName(arg_46_0)
	if not arg_46_0.mainMarkMusicId or arg_46_0.mainMarkMusicId == 0 then
		return "none"
	elseif arg_46_0.mainMarkMusicId == 999 then
		return "favor"
	else
		pg = var_1

		local var_46_0 = var_1.music_collect_config[arg_46_0.mainMarkMusicId].album_id

		pg = var_2

		return var_2.music_album[var_46_0].album_name
	end

	return
end

function var_0_1.setMusicPlayerLoopType(arg_47_0, arg_47_1)
	arg_47_0.musicPlayerLoopType = arg_47_1

	return
end

local var_0_2 = {
	[0] = "list",
	"random",
	"one"
}

function var_0_1.getMusicPlayerLoopType(arg_48_0)
	return var_0_2[arg_48_0.musicPlayerLoopType]
end

function var_0_1.getAlbumMusicList(arg_49_0, arg_49_1)
	if arg_49_1 == "favor" then
		underscore = var_1_10002

		return var_1_10002.to_array(arg_49_0.musicLikeIDList)
	else
		pg = var_1_10002

		local var_49_0

		if not var_1_10002.music_album.get_id_list_by_album_name[arg_49_1] then
			var_49_0 = {
				0
			}
		end

		local var_49_1 = var_49_0[1]

		underscore = var_1_10003

		local var_49_2 = var_1_10003.to_array

		pg = var_1_10004

		local var_49_3

		if not var_1_10004.music_collect_config.get_id_list_by_album_id[var_49_1] then
			var_49_3 = {}
		end

		return var_49_2(var_49_3)
	end

	return
end

function var_0_1.CanPlayMainMusicPlayer(arg_50_0)
	getProxy = var_1_10001
	AppreciateProxy = var_1_10002

	local var_50_0 = var_1_10001(var_1_10002)

	return var_1.getMainPlayerAlbumName(var_50_0) ~= "none" and #arg_50_0:getAlbumMusicList(var_1) > 0
end

function var_0_1.isGalleryHaveNewRes(arg_51_0)
	PlayerPrefs = var_1_10001

	local var_51_0 = var_1_10001.GetInt("galleryVersion", 0)

	GalleryConst = var_2

	if var_51_0 < var_2.Version then
		return true
	else
		return false
	end

	return
end

function var_0_1.isMusicHaveNewRes(arg_52_0)
	PlayerPrefs = var_1_10001

	local var_52_0 = var_1_10001.GetInt("musicVersion", 0)

	MusicCollectionConst = var_2

	if var_52_0 < var_2.Version then
		return true
	else
		return false
	end

	return
end

function var_0_1.isMangaHaveNewRes(arg_53_0)
	PlayerPrefs = var_1_10001

	local var_53_0 = var_1_10001.GetInt("mangaVersion", 0)

	MangaConst = var_2

	if var_53_0 < var_2.Version then
		return true
	else
		return false
	end

	return
end

return var_0_1
