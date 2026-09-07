local LoadingPicProxy = class("LoadingPicProxy", import(".NetProxy"))
local var_0_1 = false
local var_0_2 = "LoadingPicProxy"

local function var_0_3(...)
	if var_0_1 then
		print(var_0_2, ...)
	end

	return
end

function LoadingPicProxy:register()
	self:initData()
	self:addListener()

	return
end

function LoadingPicProxy:initData()
	self.diyModeOpenFlag = false
	self.galleryPicIDList = {}
	self.mangaPicIDList = {}
	self.galleryNewPicOpenList = {}
	self.mangaNewPicOpenList = {}

	self:initNewPicOpenList()

	return
end

function LoadingPicProxy:addListener()
	self:on(11003, function(arg_5_0)
		self:updateDiyModeOpenFlag(arg_5_0.loading_pic_open_flag)
		self:updateGalleryPicIDList(arg_5_0.loading_pic_id_list_1)
		self:updateMangaPicIDList(arg_5_0.loading_pic_id_list_2)
		self:checkExistCount()

		return
	end)

	return
end

function LoadingPicProxy:updateDiyModeOpenFlag(arg_6_1)
	if type(arg_6_1) == "number" then
		if arg_6_1 == 1 then
			arg_6_1 = true
		elseif arg_6_1 == 0 then
			arg_6_1 = false
		end
	end

	self.diyModeOpenFlag = tobool(arg_6_1)

	var_0_3("updateDiyModeOpenFlag", arg_6_1, tostring(self.diyModeOpenFlag))

	return
end

function LoadingPicProxy:getDiyModeOpenFlag()
	var_0_3("getDiyModeOpenFlag", tostring(self.diyModeOpenFlag))

	return self.diyModeOpenFlag
end

function LoadingPicProxy:updateGalleryPicIDList(arg_8_1)
	self.galleryPicIDList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		iter_8_1 = tonumber(iter_8_1)

		table.insert(self.galleryPicIDList, iter_8_1)
	end

	var_0_3("updateGalleryPicIDList", table.concat(self.galleryPicIDList, ","))

	return
end

function LoadingPicProxy:getGalleryPicIDList(arg_9_1)
	var_0_3("getGalleryPicIDList", table.concat(self.galleryPicIDList, ","))

	return (arg_9_1 or nil) and (self.galleryPicIDList or Clone(self.galleryPicIDList))
end

function LoadingPicProxy:updateMangaPicIDList(arg_10_1)
	self.mangaPicIDList = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		iter_10_1 = tonumber(iter_10_1)

		table.insert(self.mangaPicIDList, iter_10_1)
	end

	var_0_3("updateMangaPicIDList", table.concat(self.mangaPicIDList, ","))

	return
end

function LoadingPicProxy:getMangaPicIDList(arg_11_1)
	var_0_3("getMangaPicIDList", table.concat(self.mangaPicIDList, ","))

	return (arg_11_1 or nil) and (self.mangaPicIDList or Clone(self.mangaPicIDList))
end

function LoadingPicProxy:checkExistCount()
	if #AppreciatePicConst.filterExistGalleryPicIDList(self:getGalleryPicIDList(true)) + #AppreciatePicConst.filterExistMangaPicIDList(self:getMangaPicIDList(true)) == 0 then
		self:sendNotification(GAME.UPDATE_LOADING_PIC_DONE, {
			galleryPicIDList = AppreciatePicConst.getDefaultGalleryPicIDList()
		})
	end

	return
end

function LoadingPicProxy:initNewPicOpenList()
	self.galleryNewPicOpenList = {}
	self.mangaNewPicOpenList = {}

	for iter_13_0, iter_13_1 in ipairs(PlayerPrefs.GetString("galleryNew_pic_open_list", ""):split(",")) do
		iter_13_1 = tonumber(iter_13_1)

		if not table.contains(self.galleryNewPicOpenList, iter_13_1) then
			table.insert(self.galleryNewPicOpenList, iter_13_1)
		end
	end

	for iter_13_2, iter_13_3 in ipairs(PlayerPrefs.GetString("mangaNew_pic_open_list", ""):split(",")) do
		iter_13_3 = tonumber(iter_13_3)

		if not table.contains(self.mangaNewPicOpenList, iter_13_3) then
			table.insert(self.mangaNewPicOpenList, iter_13_3)
		end
	end

	return
end

function LoadingPicProxy:addGalleryNewPicOpenList(arg_14_1)
	if not table.contains(AppreciatePicConst.getGalleryConfigNewIDList(), arg_14_1) then
		return
	end

	if not table.contains(self.galleryNewPicOpenList, arg_14_1) then
		table.insert(self.galleryNewPicOpenList, arg_14_1)
	end

	self:saveNewPicOpenList()

	return
end

function LoadingPicProxy:addMangaNewPicOpenList(arg_15_1)
	if not table.contains(AppreciatePicConst.getMangaConfigNewIDList(), arg_15_1) then
		return
	end

	if not table.contains(self.mangaNewPicOpenList, arg_15_1) then
		table.insert(self.mangaNewPicOpenList, arg_15_1)
	end

	self:saveNewPicOpenList()

	return
end

function LoadingPicProxy:saveNewPicOpenList()
	PlayerPrefs.SetString("galleryNew_pic_open_list", table.concat(self.galleryNewPicOpenList, ","))
	PlayerPrefs.SetString("mangaNew_pic_open_list", table.concat(self.mangaNewPicOpenList, ","))
	PlayerPrefs.Save()

	return
end

function LoadingPicProxy:getGalleryNewPicOpenList(arg_17_1)
	return (arg_17_1 or nil) and (self.galleryNewPicOpenList or Clone(self.galleryNewPicOpenList))
end

function LoadingPicProxy:getMangaNewPicOpenList(arg_18_1)
	return (arg_18_1 or nil) and (self.mangaNewPicOpenList or Clone(self.mangaNewPicOpenList))
end

return LoadingPicProxy
