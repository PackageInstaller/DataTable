local AppreciateProxy = class("AppreciateProxy", import(".NetProxy"))

function AppreciateProxy:register()
	self:initData()
	self:checkPicFileState()
	self:checkMusicFileState()

	return
end

function AppreciateProxy:initData()
	self.picManager = BundleWizard.Inst:GetGroupMgr("GALLERY_PIC")
	self.musicManager = BundleWizard.Inst:GetGroupMgr("GALLERY_BGM")
	self.reForVer = PathMgr.MD5Result
	self.galleryPicUnLockIDLIst = {}
	self.galleryPicExistStateTable = {}
	self.galleryPicLikeIDList = {}
	self.musicUnLockIDLIst = {}
	self.musicExistStateTable = {}
	self.musicLikeIDList = {}
	self.mangaReadIDList = {}
	self.mangaLikeIDList = {}
	self.galleryRunData = {
		middleIndex = 1,
		dateValue = GalleryConst.Data_All_Value,
		sortValue = GalleryConst.Sort_Order_Up,
		likeValue = GalleryConst.Filte_Normal_Value,
		bgFilteValue = GalleryConst.Loading_BG_NO_Filte
	}
	self.musicRunData = {
		middleIndex = 1,
		sortValue = MusicCollectionConst.Sort_Order_Up,
		likeValue = MusicCollectionConst.Filte_Normal_Value
	}

	return
end

function AppreciateProxy:checkPicFileState()
	for iter_3_0, iter_3_1 in ipairs(pg.gallery_config.all) do
		local var_3_2 = checkABExist(GalleryConst.PIC_PATH_PREFIX .. pg.gallery_config[iter_3_1].illustration)
		local var_3_3 = GalleryConst.GetGalleryPreviewPicPathByID(iter_3_1)

		var_3_2 = var_3_2 and var_3_3 and checkABExist(var_3_3)
		self.galleryPicExistStateTable[iter_3_1] = var_3_2
	end

	return
end

function AppreciateProxy:checkMusicFileState()
	for iter_4_0, iter_4_1 in ipairs(pg.music_collect_config.all) do
		self.musicExistStateTable[iter_4_1] = checkABExist(MusicCollectionConst.MUSIC_SONG_PATH_PREFIX .. pg.music_collect_config[iter_4_1].music .. ".b")
	end

	return
end

function AppreciateProxy:updatePicFileExistStateTable(arg_5_1, arg_5_2)
	self.galleryPicExistStateTable[arg_5_1] = arg_5_2

	return
end

function AppreciateProxy:updateMusicFileExistStateTable(arg_6_1, arg_6_2)
	self.musicExistStateTable[arg_6_1] = arg_6_2

	return
end

function AppreciateProxy:getPicExistStateByID(arg_7_1)
	if not arg_7_1 then
		assert("不能为空的picID:" .. tostring(arg_7_1))
	end

	return self.galleryPicExistStateTable[arg_7_1]
end

function AppreciateProxy:getMusicExistStateByID(arg_8_1)
	if not arg_8_1 then
		assert("不能为空的musicID:" .. tostring(arg_8_1))
	end

	return self.musicExistStateTable[arg_8_1]
end

function AppreciateProxy:getSinglePicConfigByID(arg_9_1)
	if pg.gallery_config[arg_9_1] then
		return pg.gallery_config[arg_9_1]
	else
		assert(false, "不存在的插画ID:" .. tostring(arg_9_1))
	end

	return
end

function AppreciateProxy:getSingleMusicConfigByID(arg_10_1)
	if pg.music_collect_config[arg_10_1] then
		return pg.music_collect_config[arg_10_1]
	else
		assert(false, "不存在的音乐ID:" .. tostring(arg_10_1))
	end

	return
end

function AppreciateProxy:updateGalleryRunData(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self.galleryRunData.dateValue = arg_11_1 and arg_11_1 or self.galleryRunData.dateValue
	self.galleryRunData.sortValue = arg_11_2 and arg_11_2 or self.galleryRunData.sortValue
	self.galleryRunData.middleIndex = arg_11_3 and arg_11_3 or self.galleryRunData.middleIndex
	self.galleryRunData.likeValue = arg_11_4 and arg_11_4 or self.galleryRunData.likeValue
	self.galleryRunData.bgFilteValue = arg_11_5 and arg_11_5 or self.galleryRunData.bgFilteValue

	return
end

function AppreciateProxy:updateMusicRunData(arg_12_1, arg_12_2, arg_12_3)
	self.musicRunData.sortValue = arg_12_1 and arg_12_1 or self.musicRunData.sortValue
	self.musicRunData.middleIndex = arg_12_2 and arg_12_2 or self.musicRunData.middleIndex
	self.musicRunData.likeValue = arg_12_3 and arg_12_3 or self.musicRunData.likeValue

	return
end

function AppreciateProxy:getGalleryRunData(arg_13_1)
	return self.galleryRunData
end

function AppreciateProxy:getMusicRunData(arg_14_1)
	return self.musicRunData
end

function AppreciateProxy:isPicNeedUnlockByID(arg_15_1)
	local var_15_0 = self:getSinglePicConfigByID(arg_15_1)

	if var_15_0 then
		if var_15_0.unlock_level[1] == 1 and var_15_0.unlock_level[2] == 0 then
			if #self:getPicUnlockMaterialByID(arg_15_1) == 0 then
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

function AppreciateProxy:isMusicNeedUnlockByID(arg_16_1)
	local var_16_0 = self:getSingleMusicConfigByID(arg_16_1)

	if var_16_0 then
		if var_16_0.unlock_level[1] == 1 and var_16_0.unlock_level[2] == 0 then
			if #self:getMusicUnlockMaterialByID(arg_16_1) == 0 then
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

function AppreciateProxy:getPicUnlockMaterialByID(arg_17_1)
	local var_17_0 = self:getSinglePicConfigByID(arg_17_1)

	if var_17_0 then
		local var_17_1 = {}

		for iter_17_0, iter_17_1 in ipairs(var_17_0.unlock_cost) do
			var_17_1[#var_17_1 + 1] = {
				type = iter_17_1[1],
				id = iter_17_1[2],
				count = iter_17_1[3]
			}
		end

		return var_17_1
	else
		assert(false, "不存在的插画ID:" .. arg_17_1)
	end

	return
end

function AppreciateProxy:getMusicUnlockMaterialByID(arg_18_1)
	local var_18_0 = self:getSingleMusicConfigByID(arg_18_1)

	if var_18_0 then
		local var_18_1 = {}

		for iter_18_0, iter_18_1 in ipairs(var_18_0.unlock_cost) do
			var_18_1[#var_18_1 + 1] = {
				type = iter_18_1[1],
				id = iter_18_1[2],
				count = iter_18_1[3]
			}
		end

		return var_18_1
	else
		assert(false, "不存在的音乐ID:" .. arg_18_1)
	end

	return
end

function AppreciateProxy:isPicNeedUnlockMaterialByID(arg_19_1)
	local var_19_0 = self:getPicUnlockMaterialByID(arg_19_1)

	if #var_19_0 == 0 then
		return false
	else
		return var_19_0
	end

	return
end

function AppreciateProxy:isMusicNeedUnlockMaterialByID(arg_20_1)
	local var_20_0 = self:getMusicUnlockMaterialByID(arg_20_1)

	if #var_20_0 == 0 then
		return false
	else
		return var_20_0
	end

	return
end

function AppreciateProxy:getPicUnlockTipTextByID(arg_21_1)
	local var_21_0 = self:getSinglePicConfigByID(arg_21_1)

	if var_21_0 then
		return var_21_0.illustrate
	else
		assert(false, "不存在的插画ID:" .. arg_21_1)
	end

	return
end

function AppreciateProxy:getMusicUnlockTipTextByID(arg_22_1)
	local var_22_0 = self:getSingleMusicConfigByID(arg_22_1)

	if var_22_0 then
		return var_22_0.illustrate
	else
		assert(false, "不存在的音乐ID:" .. arg_22_1)
	end

	return
end

function AppreciateProxy:getResultForVer()
	return self.reForVer
end

function AppreciateProxy:clearVer()
	self.reForVer = nil

	return
end

function AppreciateProxy:addPicIDToUnlockList(arg_25_1)
	if table.contains(self.galleryPicUnLockIDLIst, arg_25_1) then
		print("already exist picID:" .. arg_25_1)
	else
		self.galleryPicUnLockIDLIst[#self.galleryPicUnLockIDLIst + 1] = arg_25_1
	end

	return
end

function AppreciateProxy:addMusicIDToUnlockList(arg_26_1)
	if table.contains(self.musicUnLockIDLIst, arg_26_1) then
		print("already exist musicID:" .. arg_26_1)
	else
		self.musicUnLockIDLIst[#self.musicUnLockIDLIst + 1] = arg_26_1
	end

	return
end

function AppreciateProxy:addMangaIDToReadList(arg_27_1)
	if table.contains(self.mangaReadIDList, arg_27_1) then
		print("already exist mangaID:" .. arg_27_1)
	else
		table.insert(self.mangaReadIDList, arg_27_1)
	end

	return
end

function AppreciateProxy:initMangaReadIDList(arg_28_1)
	self.mangaReadIDList = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		for iter_28_2 = 1, 32 do
			if bit.band(iter_28_1, bit.lshift(1, iter_28_2 - 1)) ~= 0 then
				self:addMangaIDToReadList((iter_28_0 - 1) * 32 + iter_28_2)
			end
		end
	end

	MangaConst.setVersionAndNewCount()

	return
end

function AppreciateProxy:getMangaReadIDList()
	return self.mangaReadIDList
end

function AppreciateProxy:addMangaIDToLikeList(arg_30_1)
	if table.contains(self.mangaLikeIDList, arg_30_1) then
		print("already exist mangaID:" .. arg_30_1)
	else
		table.insert(self.mangaLikeIDList, arg_30_1)
	end

	return
end

function AppreciateProxy:removeMangaIDFromLikeList(arg_31_1)
	if table.contains(self.mangaLikeIDList, arg_31_1) then
		table.removebyvalue(self.mangaLikeIDList, arg_31_1, true)
	else
		print("not exist mangaID:" .. arg_31_1)
	end

	return
end

function AppreciateProxy:initMangaLikeIDList(arg_32_1)
	self.mangaLikeIDList = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		for iter_32_2 = 1, 32 do
			if bit.band(iter_32_1, bit.lshift(1, iter_32_2 - 1)) ~= 0 then
				self:addMangaIDToLikeList((iter_32_0 - 1) * 32 + iter_32_2)
			end
		end
	end

	return
end

function AppreciateProxy:getMangaLikeIDList()
	return self.mangaLikeIDList
end

function AppreciateProxy:isPicUnlockedByID(arg_34_1)
	if table.contains(self.galleryPicUnLockIDLIst, arg_34_1) then
		return true
	else
		return false
	end

	return
end

function AppreciateProxy:isMusicUnlockedByID(arg_35_1)
	if table.contains(self.musicUnLockIDLIst, arg_35_1) then
		return true
	else
		return false
	end

	return
end

function AppreciateProxy:isPicUnlockableByID(arg_36_1)
	local var_36_0 = getProxy(PlayerProxy)

	if var_36_0 then
		if self:getSinglePicConfigByID(arg_36_1).unlock_level[1] <= var_36_0:getData().level then
			return true
		elseif self:getSinglePicConfigByID(arg_36_1).unlock_level[2] == GalleryConst.Still_Show_On_Lock then
			return false, true
		else
			return false, false
		end
	end

	return
end

function AppreciateProxy:isMusicUnlockableByID(arg_37_1)
	local var_37_0 = getProxy(PlayerProxy)

	if var_37_0 then
		if self:getSingleMusicConfigByID(arg_37_1).unlock_level[1] <= var_37_0:getData().level then
			return true
		elseif self:getSingleMusicConfigByID(arg_37_1).unlock_level[2] == MusicCollectionConst.Still_Show_On_Lock then
			return false, true
		else
			return false, false
		end
	end

	return
end

function AppreciateProxy:addPicIDToLikeList(arg_38_1)
	if table.contains(self.galleryPicLikeIDList, arg_38_1) then
		print("already exist picID:" .. arg_38_1)
	else
		self.galleryPicLikeIDList[#self.galleryPicLikeIDList + 1] = arg_38_1
	end

	return
end

function AppreciateProxy:removePicIDFromLikeList(arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(self.galleryPicLikeIDList) do
		if iter_39_1 == arg_39_1 then
			table.remove(self.galleryPicLikeIDList, iter_39_0)

			return
		end
	end

	print("no exist picID:" .. arg_39_1)

	return
end

function AppreciateProxy:isLikedByPicID(arg_40_1)
	return table.contains(self.galleryPicLikeIDList, arg_40_1)
end

function AppreciateProxy:getGalleryLikeIDList()
	return self.galleryPicLikeIDList
end

function AppreciateProxy:addMusicIDToLikeList(arg_42_1)
	if table.contains(self.musicLikeIDList, arg_42_1) then
		print("already exist picID:" .. arg_42_1)
	else
		self.musicLikeIDList[#self.musicLikeIDList + 1] = arg_42_1
	end

	return
end

function AppreciateProxy:removeMusicIDFromLikeList(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(self.musicLikeIDList) do
		if iter_43_1 == arg_43_1 then
			table.remove(self.musicLikeIDList, iter_43_0)

			return
		end
	end

	print("no exist musicID:" .. arg_43_1)

	return
end

function AppreciateProxy:isLikedByMusicID(arg_44_1)
	return table.contains(self.musicLikeIDList, arg_44_1)
end

function AppreciateProxy:setMainPlayMusicAlbum(arg_45_1)
	self.mainMarkMusicId = arg_45_1

	return
end

function AppreciateProxy:getMainPlayerAlbumName()
	if not self.mainMarkMusicId or self.mainMarkMusicId == 0 then
		return "none"
	elseif self.mainMarkMusicId == 999 then
		return "favor"
	else
		return pg.music_album[pg.music_collect_config[self.mainMarkMusicId].album_id].album_name
	end

	return
end

function AppreciateProxy:setMusicPlayerLoopType(arg_47_1)
	self.musicPlayerLoopType = arg_47_1

	return
end

local var_0_1 = {
	[0] = "list",
	"random",
	"one"
}

function AppreciateProxy:getMusicPlayerLoopType()
	return var_0_1[self.musicPlayerLoopType]
end

function AppreciateProxy:getAlbumMusicList(arg_49_1)
	if arg_49_1 == "favor" then
		return underscore.to_array(self.musicLikeIDList)
	else
		return underscore.to_array(pg.music_collect_config.get_id_list_by_album_id[(pg.music_album.get_id_list_by_album_name[arg_49_1] or {
			0
		})[1]] or {})
	end

	return
end

function AppreciateProxy:CanPlayMainMusicPlayer()
	local var_50_0 = getProxy(AppreciateProxy):getMainPlayerAlbumName()

	return var_50_0 ~= "none" and #self:getAlbumMusicList(var_50_0) > 0
end

function AppreciateProxy:isGalleryHaveNewRes()
	if PlayerPrefs.GetInt("galleryVersion", 0) < GalleryConst.Version then
		return true
	else
		return false
	end

	return
end

function AppreciateProxy:isMusicHaveNewRes()
	if PlayerPrefs.GetInt("musicVersion", 0) < MusicCollectionConst.Version then
		return true
	else
		return false
	end

	return
end

function AppreciateProxy:isMangaHaveNewRes()
	if PlayerPrefs.GetInt("mangaVersion", 0) < MangaConst.Version then
		return true
	else
		return false
	end

	return
end

return AppreciateProxy
