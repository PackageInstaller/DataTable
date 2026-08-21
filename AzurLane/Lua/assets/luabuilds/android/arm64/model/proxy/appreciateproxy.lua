local var_0_0 = class("AppreciateProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:initData()
	arg_1_0:checkPicFileState()
	arg_1_0:checkMusicFileState()

	return
end

function var_0_0.initData(arg_2_0)
	arg_2_0.picManager = BundleWizard.Inst:GetGroupMgr("GALLERY_PIC")
	arg_2_0.musicManager = BundleWizard.Inst:GetGroupMgr("GALLERY_BGM")
	arg_2_0.reForVer = PathMgr.MD5Result
	arg_2_0.galleryPicUnLockIDLIst = {}
	arg_2_0.galleryPicExistStateTable = {}
	arg_2_0.galleryPicLikeIDList = {}
	arg_2_0.musicUnLockIDLIst = {}
	arg_2_0.musicExistStateTable = {}
	arg_2_0.musicLikeIDList = {}
	arg_2_0.mangaReadIDList = {}
	arg_2_0.mangaLikeIDList = {}
	arg_2_0.galleryRunData = {
		middleIndex = 1,
		dateValue = GalleryConst.Data_All_Value,
		sortValue = GalleryConst.Sort_Order_Up,
		likeValue = GalleryConst.Filte_Normal_Value,
		bgFilteValue = GalleryConst.Loading_BG_NO_Filte
	}
	arg_2_0.musicRunData = {
		middleIndex = 1,
		sortValue = MusicCollectionConst.Sort_Order_Up,
		likeValue = MusicCollectionConst.Filte_Normal_Value
	}

	return
end

function var_0_0.checkPicFileState(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(pg.gallery_config.all) do
		local var_3_2 = checkABExist(GalleryConst.PIC_PATH_PREFIX .. pg.gallery_config[iter_3_1].illustration)
		local var_3_3 = GalleryConst.GetGalleryPreviewPicPathByID(iter_3_1)

		var_3_2 = var_3_2 and var_3_3 and checkABExist(var_3_3)
		arg_3_0.galleryPicExistStateTable[iter_3_1] = var_3_2
	end

	return
end

function var_0_0.checkMusicFileState(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(pg.music_collect_config.all) do
		arg_4_0.musicExistStateTable[iter_4_1] = checkABExist(MusicCollectionConst.MUSIC_SONG_PATH_PREFIX .. pg.music_collect_config[iter_4_1].music .. ".b")
	end

	return
end

function var_0_0.updatePicFileExistStateTable(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.galleryPicExistStateTable[arg_5_1] = arg_5_2

	return
end

function var_0_0.updateMusicFileExistStateTable(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.musicExistStateTable[arg_6_1] = arg_6_2

	return
end

function var_0_0.getPicExistStateByID(arg_7_0, arg_7_1)
	if not arg_7_1 then
		assert("不能为空的picID:" .. tostring(arg_7_1))
	end

	return arg_7_0.galleryPicExistStateTable[arg_7_1]
end

function var_0_0.getMusicExistStateByID(arg_8_0, arg_8_1)
	if not arg_8_1 then
		assert("不能为空的musicID:" .. tostring(arg_8_1))
	end

	return arg_8_0.musicExistStateTable[arg_8_1]
end

function var_0_0.getSinglePicConfigByID(arg_9_0, arg_9_1)
	if pg.gallery_config[arg_9_1] then
		return pg.gallery_config[arg_9_1]
	else
		assert(false, "不存在的插画ID:" .. tostring(arg_9_1))
	end

	return
end

function var_0_0.getSingleMusicConfigByID(arg_10_0, arg_10_1)
	if pg.music_collect_config[arg_10_1] then
		return pg.music_collect_config[arg_10_1]
	else
		assert(false, "不存在的音乐ID:" .. tostring(arg_10_1))
	end

	return
end

function var_0_0.updateGalleryRunData(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.galleryRunData.dateValue = arg_11_1 and arg_11_1 or arg_11_0.galleryRunData.dateValue
	arg_11_0.galleryRunData.sortValue = arg_11_2 and arg_11_2 or arg_11_0.galleryRunData.sortValue
	arg_11_0.galleryRunData.middleIndex = arg_11_3 and arg_11_3 or arg_11_0.galleryRunData.middleIndex
	arg_11_0.galleryRunData.likeValue = arg_11_4 and arg_11_4 or arg_11_0.galleryRunData.likeValue
	arg_11_0.galleryRunData.bgFilteValue = arg_11_5 and arg_11_5 or arg_11_0.galleryRunData.bgFilteValue

	return
end

function var_0_0.updateMusicRunData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.musicRunData.sortValue = arg_12_1 and arg_12_1 or arg_12_0.musicRunData.sortValue
	arg_12_0.musicRunData.middleIndex = arg_12_2 and arg_12_2 or arg_12_0.musicRunData.middleIndex
	arg_12_0.musicRunData.likeValue = arg_12_3 and arg_12_3 or arg_12_0.musicRunData.likeValue

	return
end

function var_0_0.getGalleryRunData(arg_13_0, arg_13_1)
	return arg_13_0.galleryRunData
end

function var_0_0.getMusicRunData(arg_14_0, arg_14_1)
	return arg_14_0.musicRunData
end

function var_0_0.isPicNeedUnlockByID(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getSinglePicConfigByID(arg_15_1)

	if var_15_0 then
		if var_15_0.unlock_level[1] == 1 and var_15_0.unlock_level[2] == 0 then
			if #arg_15_0:getPicUnlockMaterialByID(arg_15_1) == 0 then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		assert(false, "不存在的插画ID:" .. arg_15_1)
	end

	return
end

function var_0_0.isMusicNeedUnlockByID(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getSingleMusicConfigByID(arg_16_1)

	if var_16_0 then
		if var_16_0.unlock_level[1] == 1 and var_16_0.unlock_level[2] == 0 then
			if #arg_16_0:getMusicUnlockMaterialByID(arg_16_1) == 0 then
				return false
			else
				return true
			end
		else
			return true
		end
	else
		assert(false, "不存在的音乐ID:" .. arg_16_1)
	end

	return
end

function var_0_0.getPicUnlockMaterialByID(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getSinglePicConfigByID(arg_17_1)

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0.unlock_cost) do
			({})[#{} + 1] = {
				type = iter_17_1[1],
				id = iter_17_1[2],
				count = iter_17_1[3]
			}
		end

		return {}
	else
		assert(false, "不存在的插画ID:" .. arg_17_1)
	end

	return
end

function var_0_0.getMusicUnlockMaterialByID(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getSingleMusicConfigByID(arg_18_1)

	if var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_0.unlock_cost) do
			({})[#{} + 1] = {
				type = iter_18_1[1],
				id = iter_18_1[2],
				count = iter_18_1[3]
			}
		end

		return {}
	else
		assert(false, "不存在的音乐ID:" .. arg_18_1)
	end

	return
end

function var_0_0.isPicNeedUnlockMaterialByID(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getPicUnlockMaterialByID(arg_19_1)

	if #var_19_0 == 0 then
		return false
	else
		return var_19_0
	end

	return
end

function var_0_0.isMusicNeedUnlockMaterialByID(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getMusicUnlockMaterialByID(arg_20_1)

	if #var_20_0 == 0 then
		return false
	else
		return var_20_0
	end

	return
end

function var_0_0.getPicUnlockTipTextByID(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getSinglePicConfigByID(arg_21_1)

	if var_21_0 then
		return var_21_0.illustrate
	else
		assert(false, "不存在的插画ID:" .. arg_21_1)
	end

	return
end

function var_0_0.getMusicUnlockTipTextByID(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getSingleMusicConfigByID(arg_22_1)

	if var_22_0 then
		return var_22_0.illustrate
	else
		assert(false, "不存在的音乐ID:" .. arg_22_1)
	end

	return
end

function var_0_0.getResultForVer(arg_23_0)
	return arg_23_0.reForVer
end

function var_0_0.clearVer(arg_24_0)
	arg_24_0.reForVer = nil

	return
end

function var_0_0.addPicIDToUnlockList(arg_25_0, arg_25_1)
	if table.contains(arg_25_0.galleryPicUnLockIDLIst, arg_25_1) then
		print("already exist picID:" .. arg_25_1)
	else
		arg_25_0.galleryPicUnLockIDLIst[#arg_25_0.galleryPicUnLockIDLIst + 1] = arg_25_1
	end

	return
end

function var_0_0.addMusicIDToUnlockList(arg_26_0, arg_26_1)
	if table.contains(arg_26_0.musicUnLockIDLIst, arg_26_1) then
		print("already exist musicID:" .. arg_26_1)
	else
		arg_26_0.musicUnLockIDLIst[#arg_26_0.musicUnLockIDLIst + 1] = arg_26_1
	end

	return
end

function var_0_0.addMangaIDToReadList(arg_27_0, arg_27_1)
	if table.contains(arg_27_0.mangaReadIDList, arg_27_1) then
		print("already exist mangaID:" .. arg_27_1)
	else
		table.insert(arg_27_0.mangaReadIDList, arg_27_1)
	end

	return
end

function var_0_0.initMangaReadIDList(arg_28_0, arg_28_1)
	arg_28_0.mangaReadIDList = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		for iter_28_2 = 1, 32 do
			if bit.band(iter_28_1, bit.lshift(1, iter_28_2 - 1)) ~= 0 then
				arg_28_0:addMangaIDToReadList((iter_28_0 - 1) * 32 + iter_28_2)
			end
		end
	end

	MangaConst.setVersionAndNewCount()

	return
end

function var_0_0.getMangaReadIDList(arg_29_0)
	return arg_29_0.mangaReadIDList
end

function var_0_0.addMangaIDToLikeList(arg_30_0, arg_30_1)
	if table.contains(arg_30_0.mangaLikeIDList, arg_30_1) then
		print("already exist mangaID:" .. arg_30_1)
	else
		table.insert(arg_30_0.mangaLikeIDList, arg_30_1)
	end

	return
end

function var_0_0.removeMangaIDFromLikeList(arg_31_0, arg_31_1)
	if table.contains(arg_31_0.mangaLikeIDList, arg_31_1) then
		table.removebyvalue(arg_31_0.mangaLikeIDList, arg_31_1, true)
	else
		print("not exist mangaID:" .. arg_31_1)
	end

	return
end

function var_0_0.initMangaLikeIDList(arg_32_0, arg_32_1)
	arg_32_0.mangaLikeIDList = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		for iter_32_2 = 1, 32 do
			if bit.band(iter_32_1, bit.lshift(1, iter_32_2 - 1)) ~= 0 then
				arg_32_0:addMangaIDToLikeList((iter_32_0 - 1) * 32 + iter_32_2)
			end
		end
	end

	return
end

function var_0_0.getMangaLikeIDList(arg_33_0)
	return arg_33_0.mangaLikeIDList
end

function var_0_0.isPicUnlockedByID(arg_34_0, arg_34_1)
	if table.contains(arg_34_0.galleryPicUnLockIDLIst, arg_34_1) then
		return true
	else
		return false
	end

	return
end

function var_0_0.isMusicUnlockedByID(arg_35_0, arg_35_1)
	if table.contains(arg_35_0.musicUnLockIDLIst, arg_35_1) then
		return true
	else
		return false
	end

	return
end

function var_0_0.isPicUnlockableByID(arg_36_0, arg_36_1)
	local var_36_9000
	local var_36_0 = getProxy(PlayerProxy)
	local var_36_1 = var_36_0.getData(var_36_9000).level
	local var_36_2 = arg_36_0:getSinglePicConfigByID(arg_36_1)

	if var_36_0 then
		if var_36_2.unlock_level[1] <= var_36_1 then
			return true
		elseif var_36_2.unlock_level[2] == GalleryConst.Still_Show_On_Lock then
			return false, true
		else
			return false, false
		end
	end

	return
end

function var_0_0.isMusicUnlockableByID(arg_37_0, arg_37_1)
	local var_37_9000
	local var_37_0 = getProxy(PlayerProxy)
	local var_37_1 = var_37_0.getData(var_37_9000).level
	local var_37_2 = arg_37_0:getSingleMusicConfigByID(arg_37_1)

	if var_37_0 then
		if var_37_2.unlock_level[1] <= var_37_1 then
			return true
		elseif var_37_2.unlock_level[2] == MusicCollectionConst.Still_Show_On_Lock then
			return false, true
		else
			return false, false
		end
	end

	return
end

function var_0_0.addPicIDToLikeList(arg_38_0, arg_38_1)
	if table.contains(arg_38_0.galleryPicLikeIDList, arg_38_1) then
		print("already exist picID:" .. arg_38_1)
	else
		arg_38_0.galleryPicLikeIDList[#arg_38_0.galleryPicLikeIDList + 1] = arg_38_1
	end

	return
end

function var_0_0.removePicIDFromLikeList(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0.galleryPicLikeIDList) do
		if iter_39_1 == arg_39_1 then
			table.remove(arg_39_0.galleryPicLikeIDList, iter_39_0)

			return
		end
	end

	print("no exist picID:" .. arg_39_1)

	return
end

function var_0_0.isLikedByPicID(arg_40_0, arg_40_1)
	return table.contains(arg_40_0.galleryPicLikeIDList, arg_40_1)
end

function var_0_0.getGalleryLikeIDList(arg_41_0)
	return arg_41_0.galleryPicLikeIDList
end

function var_0_0.addMusicIDToLikeList(arg_42_0, arg_42_1)
	if table.contains(arg_42_0.musicLikeIDList, arg_42_1) then
		print("already exist picID:" .. arg_42_1)
	else
		arg_42_0.musicLikeIDList[#arg_42_0.musicLikeIDList + 1] = arg_42_1
	end

	return
end

function var_0_0.removeMusicIDFromLikeList(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.musicLikeIDList) do
		if iter_43_1 == arg_43_1 then
			table.remove(arg_43_0.musicLikeIDList, iter_43_0)

			return
		end
	end

	print("no exist musicID:" .. arg_43_1)

	return
end

function var_0_0.isLikedByMusicID(arg_44_0, arg_44_1)
	return table.contains(arg_44_0.musicLikeIDList, arg_44_1)
end

function var_0_0.setMainPlayMusicAlbum(arg_45_0, arg_45_1)
	arg_45_0.mainMarkMusicId = arg_45_1

	return
end

function var_0_0.getMainPlayerAlbumName(arg_46_0)
	if not arg_46_0.mainMarkMusicId or arg_46_0.mainMarkMusicId == 0 then
		return "none"
	elseif arg_46_0.mainMarkMusicId == 999 then
		return "favor"
	else
		return pg.music_album[pg.music_collect_config[arg_46_0.mainMarkMusicId].album_id].album_name
	end

	return
end

function var_0_0.setMusicPlayerLoopType(arg_47_0, arg_47_1)
	arg_47_0.musicPlayerLoopType = arg_47_1

	return
end

local var_0_1 = {
	[0] = "list",
	"random",
	"one"
}

function var_0_0.getMusicPlayerLoopType(arg_48_0)
	return var_0_1[arg_48_0.musicPlayerLoopType]
end

function var_0_0.getAlbumMusicList(arg_49_0, arg_49_1)
	if arg_49_1 == "favor" then
		return underscore.to_array(arg_49_0.musicLikeIDList)
	else
		local var_49_0 = pg.music_album.get_id_list_by_album_name[arg_49_1] or {
			0
		}
		local var_49_1 = pg.music_collect_config.get_id_list_by_album_id[var_49_0[1]] or {}

		return underscore.to_array(var_49_1)
	end

	return
end

function var_0_0.CanPlayMainMusicPlayer(arg_50_0)
	local var_50_0 = getProxy(AppreciateProxy):getMainPlayerAlbumName()

	return var_50_0 ~= "none" and #arg_50_0:getAlbumMusicList(var_50_0) > 0
end

function var_0_0.isGalleryHaveNewRes(arg_51_0)
	if PlayerPrefs.GetInt("galleryVersion", 0) < GalleryConst.Version then
		return true
	else
		return false
	end

	return
end

function var_0_0.isMusicHaveNewRes(arg_52_0)
	if PlayerPrefs.GetInt("musicVersion", 0) < MusicCollectionConst.Version then
		return true
	else
		return false
	end

	return
end

function var_0_0.isMangaHaveNewRes(arg_53_0)
	if PlayerPrefs.GetInt("mangaVersion", 0) < MangaConst.Version then
		return true
	else
		return false
	end

	return
end

return var_0_0
