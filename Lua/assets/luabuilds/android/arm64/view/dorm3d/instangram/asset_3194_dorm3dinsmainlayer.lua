local Dorm3dInsMainLayer = class("Dorm3dInsMainLayer", import("...base.BaseUI"))

Dorm3dInsMainLayer.OPEN_INS = "Dorm3dInsMainLayer.OPEN_INS"
Dorm3dInsMainLayer.OPEN_CHAT = "Dorm3dInsMainLayer.OPEN_CHAT"
Dorm3dInsMainLayer.OPEN_PHONE = "Dorm3dInsMainLayer.OPEN_PHONE"
Dorm3dInsMainLayer.DOWNLOAD_ROOM = "Dorm3dInsMainLayer.DOWNLOAD_ROOM"
Dorm3dInsMainLayer.DELETE_ROOM = "Dorm3dInsMainLayer.DELETE_ROOM"
Dorm3dInsMainLayer.FLUSH_LEFT = "Dorm3dInsMainLayer.FLUSH_LEFT"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = "PAGE_INS"
local var_0_4 = "PAGE_CHAT"
local var_0_5 = "PAGE_PHONE"
local var_0_6 = "PAGE_MAIN"
local var_0_7 = 2
local var_0_8 = 1

function Dorm3dInsMainLayer:getUIName()
	return "Dorm3dInsMainUI"
end

function Dorm3dInsMainLayer:init()
	self.bg = self._tf:Find("bg")
	self.mainTf = self._tf:Find("main")
	self.mainPages = {
		[var_0_8] = Dorm3dInsPublicPage.New(self._tf:Find("main/public_page"), self.event),
		[var_0_7] = Dorm3dInsCharPage.New(self._tf:Find("main/char_page"), self.event)
	}
	self.roomListContainer = self._tf:Find("left/scroll/mask/list")
	self.roomItemList = UIItemList.New(self.roomListContainer, self.roomListContainer:Find("tpl"))

	self.roomItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdateRoomList(arg_3_1, arg_3_2)
		end

		return
	end)

	self.expandPanel = self._tf:Find("expand_panel")
	self.expandListContainer = self._tf:Find("expand_panel/scroll/mask/list")
	self.expandItemList = UIItemList.New(self.expandListContainer, self.expandListContainer:Find("tpl"))

	self.expandItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateRoomList(arg_4_1, arg_4_2)
		end

		return
	end)

	self.selectPanel = self._tf:Find("select_panel")
	self.selectListContainer = self._tf:Find("select_panel/list")
	self.selectItemList = UIItemList.New(self.selectListContainer, self.selectListContainer:Find("tpl"))

	self.selectItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			self:InitSelectItem(arg_5_1, arg_5_2)
		end

		return
	end)

	self.selectOpen = false
	self.downloadTf = self._tf:Find("main/download")
	self.download = self.downloadTf:Find("btns/download")
	self.downloading = self.downloadTf:Find("btns/downloading")
	self.delete = self.downloadTf:Find("btns/delete")
	self.downloadProgress = self.downloadTf:Find("progress")
	self.slider = self.downloadProgress:Find("slider")

	self:BlurPanel(self._tf)
	self:InitData()

	return
end

function Dorm3dInsMainLayer:InitData()
	self.roomDataDic = {}
	self.roomDataList = Clone(getProxy(Dorm3dInsProxy):GetRoomList())

	for iter_6_0, iter_6_1 in ipairs(self.roomDataList) do
		self.roomDataDic[iter_6_1.id] = iter_6_1
	end

	self.selectOptions = {}

	self:BuildSelectOptions()
	self:FilterRoomList(var_0_1)
	self:SortRoomList()

	return
end

function Dorm3dInsMainLayer:BuildSelectOptions()
	table.insert(self.selectOptions, {
		mode = var_0_1,
		label = i18n("dorm3d_privatechat_screen_all")
	})

	for iter_7_0, iter_7_1 in pairs(pg.dorm3d_rooms.get_id_list_by_in_map) do
		table.insert(self.selectOptions, {
			mode = var_0_2,
			arg = iter_7_0,
			label = i18n("dorm3d_privatechat_screen_" .. iter_7_0)
		})
	end

	return
end

function Dorm3dInsMainLayer:FilterRoomList(arg_8_1, arg_8_2)
	self.roomIdList = _.map(_.select(self.roomDataList, function(arg_9_0)
		return switch(arg_8_1, {
			[var_0_1] = function()
				return true
			end,
			[var_0_2] = function()
				return arg_9_0:GetInMap() == arg_8_2
			end
		})
	end), function(arg_12_0)
		return arg_12_0.id
	end)

	return
end

function Dorm3dInsMainLayer:SortRoomList()
	table.sort(self.roomIdList, function(arg_14_0, arg_14_1)
		local var_14_0 = self.roomDataDic[arg_14_0]:IsCare() and 1 or 0
		local var_14_1 = self.roomDataDic[arg_14_1]:IsCare() and 1 or 0

		if var_14_0 ~= var_14_1 then
			return var_14_1 < var_14_0
		end

		local var_14_2 = self.roomDataDic[arg_14_0]:GetType()
		local var_14_3 = self.roomDataDic[arg_14_1]:GetType()

		if var_14_2 ~= var_14_3 then
			return var_14_3 < var_14_2
		end

		return arg_14_0 < arg_14_1
	end)

	return
end

function Dorm3dInsMainLayer:ClosePrePage()
	switch(self.curPage, {
		[var_0_3] = function()
			self:emit(Dorm3dInsMainMediator.CLOSE_JUUS)

			return
		end,
		[var_0_4] = function()
			self:emit(Dorm3dInsMainMediator.CLOSE_CHAT)

			return
		end,
		[var_0_5] = function()
			self:emit(Dorm3dInsMainMediator.CLOSE_PHONE)

			return
		end,
		[var_0_6] = function()
			setActive(self.mainTf, false)

			return
		end
	})

	self.curPage = nil

	return
end

function Dorm3dInsMainLayer:didEnter()
	onButton(self, self.bg, function()
		if self.curPage then
			self:ClosePrePage()
		end

		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("left/btn_select"), function()
		self:OpenOrCloseSelectPanel()

		return
	end)
	onButton(self, self.selectPanel:Find("back"), function()
		self:OpenOrCloseSelectPanel()

		return
	end)
	onButton(self, self._tf:Find("left/btn_expand"), function()
		setActive(self.expandPanel, true)
		self.expandPanel:SetAsLastSibling()

		return
	end)
	onButton(self, self.expandPanel:Find("btn_close"), function()
		setActive(self.expandPanel, false)

		return
	end)
	onButton(self, self.downloadTf, function()
		self:OnClickDownload(self.selectedId)

		return
	end)

	local function var_20_0(arg_27_0)
		if not self.roomDataDic[self.selectedId]:IsDownloaded() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_room_unlock"))
		else
			existCall(arg_27_0)
		end

		return
	end

	self:bind(Dorm3dInsMainLayer.OPEN_INS, function(arg_28_0)
		var_20_0(function()
			self:ClosePrePage()

			self.curPage = var_0_3

			self:emit(Dorm3dInsMainMediator.OPEN_JUUS, self.roomDataDic[self.selectedId].groupId)

			return
		end)

		return
	end)
	self:bind(Dorm3dInsMainLayer.OPEN_CHAT, function(arg_30_0)
		var_20_0(function()
			self:ClosePrePage()

			self.curPage = var_0_4

			self:emit(Dorm3dInsMainMediator.OPEN_CHAT, self.roomDataDic[self.selectedId].groupId)

			return
		end)

		return
	end)
	self:bind(Dorm3dInsMainLayer.OPEN_PHONE, function(arg_32_0)
		var_20_0(function()
			if DORM_LOCK_INS_PHONE then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_telephone"))

				return
			end

			self:ClosePrePage()

			self.curPage = var_0_5

			self:emit(Dorm3dInsMainMediator.OPEN_PHONE, self.roomDataDic[self.selectedId].groupId)

			return
		end)

		return
	end)
	self:bind(Dorm3dInsMainLayer.FLUSH_LEFT, function(arg_34_0)
		self:SortRoomList()
		self.roomItemList:align(#self.roomIdList)

		return
	end)

	self.selectedId = self.roomIdList[1]

	self.selectItemList:align(#self.selectOptions)

	self.curPage = var_0_6

	self:Flush()

	if self.contextData.isPhone then
		-- block empty
	end

	return
end

function Dorm3dInsMainLayer:UpdateRoomList(arg_35_1, arg_35_2)
	local var_35_0 = self.roomDataDic[self.roomIdList[arg_35_1 + 1]]

	setActive(arg_35_2:Find("selected"), self.roomDataDic[self.roomIdList[arg_35_1 + 1]].id == self.selectedId)
	setActive(arg_35_2:Find("like"), var_35_0:IsCare())
	GetImageSpriteFromAtlasAsync(var_35_0:GetIcon(), "", arg_35_2:Find("mask/icon"), true)
	setActive(arg_35_2:Find("tip"), var_35_0:ShouldTip())
	onButton(self, arg_35_2, function()
		self.selectedId = var_35_0.id

		if self.curPage ~= var_0_6 then
			self:OpenMain()
		end

		self:Flush()

		return
	end)

	return
end

function Dorm3dInsMainLayer:OpenMain()
	self:ClosePrePage()
	setActive(self.mainTf, true)
	self:Flush()

	self.curPage = var_0_6

	return
end

function Dorm3dInsMainLayer:Flush()
	local var_38_0 = self.roomDataDic[self.selectedId]:GetType()

	self.mainPages[(function(arg_39_0)
		return #self.mainPages - arg_39_0 + 1
	end)(var_38_0)]:Hide()
	self.mainPages[var_38_0]:Show()
	self.mainPages[var_38_0]:Flush(self.roomDataDic[self.selectedId])
	self.roomItemList:align(#self.roomIdList)
	self.expandItemList:align(#self.roomIdList)
	self:FlushDownload()

	return
end

function Dorm3dInsMainLayer:FlushLeft()
	self.roomItemList:align(#self.roomIdList)

	return
end

function Dorm3dInsMainLayer:InitSelectItem(arg_41_1, arg_41_2)
	local var_41_0 = self.selectOptions[arg_41_1 + 1]

	setText(arg_41_2:Find("label"), self.selectOptions[arg_41_1 + 1].label)
	onButton(self, arg_41_2, function()
		self:FilterRoomList(var_41_0.mode, var_41_0.arg)
		self:SortRoomList()
		self.roomItemList:align(#self.roomIdList)
		self.expandItemList:align(#self.roomIdList)

		return
	end)

	return
end

function Dorm3dInsMainLayer:OpenOrCloseSelectPanel()
	self.selectOpen = not self.selectOpen

	setActive(self.selectPanel, self.selectOpen)

	if self.selectOpen then
		self.selectPanel:SetAsLastSibling()
	end

	return
end

local var_0_9 = 1
local var_0_10 = 2
local var_0_11 = 3

function Dorm3dInsMainLayer:CheckCurrentDownloadState(arg_44_1)
	if DormGroupConst.DormDownloadLock and DormGroupConst.DormDownloadLock.roomId == arg_44_1 then
		return var_0_11
	end

	return (self.roomDataDic[arg_44_1]:IsDownloaded() or nil) and (var_0_10 or var_0_9)
end

function Dorm3dInsMainLayer:FlushDownload(arg_45_1)
	arg_45_1 = arg_45_1 or self:CheckCurrentDownloadState(self.selectedId)

	setActive(self.download, arg_45_1 == var_0_9)
	setActive(self.delete, arg_45_1 == var_0_10)
	setActive(self.downloading, arg_45_1 == var_0_11)
	self:FlushDownloadSlider(arg_45_1)

	return
end

function Dorm3dInsMainLayer:FlushDownloadSlider(arg_46_1)
	setActive(self.downloadProgress, arg_46_1 == var_0_11)

	if arg_46_1 == var_0_11 then
		setSlider(self.slider, 0, DormGroupConst.DormDownloadLock.totalSize, DormGroupConst.DormDownloadLock.curSize)
	end

	return
end

function Dorm3dInsMainLayer:DownloadUpdate(arg_47_1, arg_47_2)
	if arg_47_1 ~= self.selectedId then
		return
	end

	switch(arg_47_2, {
		start = function()
			self:FlushDownload(var_0_11)

			return
		end,
		loading = function()
			self:FlushDownloadSlider(var_0_11)

			return
		end,
		finish = function()
			self:FlushDownload(var_0_10)

			return
		end,
		delete = function()
			self:FlushDownload(var_0_9)

			return
		end
	})

	return
end

function Dorm3dInsMainLayer:OnClickDownload(arg_52_1)
	if getProxy(ApartmentProxy):getRoom(1) then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("DORM3D_GUIDE_02") then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_tip"))

			return
		end
	end

	switch(self:CheckCurrentDownloadState(arg_52_1), {
		[var_0_10] = function()
			self:DeleteRoom(arg_52_1)

			return
		end,
		[var_0_9] = function()
			if not getProxy(ApartmentProxy):getRoom(arg_52_1) then
				if self.roomDataDic[arg_52_1]:GetType() == 1 then
					self:emit(Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_52_1)
				elseif self.roomDataDic[arg_52_1]:GetType() == 2 then
					self:emit(Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM, arg_52_1)
				end
			else
				self:TryDownloadResource({
					roomId = arg_52_1
				})
			end

			return
		end,
		[var_0_11] = function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_now_is_downloading"))

			return
		end
	})

	return
end

function Dorm3dInsMainLayer:TryDownloadResource(arg_56_1, arg_56_2)
	if DormGroupConst.IsDownloading() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_now_is_downloading"))

		return
	end

	local var_56_0 = getProxy(ApartmentProxy):getRoom(arg_56_1.roomId)
	local var_56_1 = var_56_0:getDownloadNameList()

	if #var_56_1 > 0 then
		DormGroupConst.DormDownload({
			isShowBox = true,
			fileList = var_56_1,
			finishFunc = function(arg_57_0)
				if arg_57_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_resource_download_complete"))
				end

				return
			end,
			roomId = var_56_0.configId
		})
	else
		existCall(arg_56_2)
	end

	return
end

function Dorm3dInsMainLayer:DeleteRoom(arg_58_1)
	self:TryDownloadResource({
		roomId = arg_58_1
	}, function()
		local var_59_0 = getProxy(ApartmentProxy):getRoom(arg_58_1)
		local var_59_1 = var_59_0:getConfig("room")

		if var_59_0:isPersonalRoom() then
			var_59_1 = ShipGroup.getDefaultShipNameByGroupID(var_59_0:getPersonalGroupId())
		end

		local var_59_2 = var_59_0:isPersonalRoom() and DormGroupConst.GetDelRoomSize(string.lower(var_59_0:getConfig("resource_name")), {
			"room",
			"apartment"
		}) or DormGroupConst.GetDelRoomSize(string.lower(var_59_0:getConfig("resource_name")), {
			"room"
		})

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("dorm3d_role_assets_delete", var_59_1, var_59_2),
			onYes = function()
				if IsUnityEditor then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_open"))

					return
				end

				if var_59_0:isPersonalRoom() then
					DormGroupConst.DelRoom(string.lower(var_59_0:getConfig("resource_name")), {
						"room",
						"apartment"
					})
				else
					DormGroupConst.DelRoom(string.lower(var_59_0:getConfig("resource_name")), {
						"room"
					})
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_delete_finish"))
				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataDownload(var_59_0.id, 3))
				self:emit(Dorm3dInsMainMediator.NotifyDormDelete, arg_58_1)

				return
			end
		})

		return
	end)

	return
end

return Dorm3dInsMainLayer
