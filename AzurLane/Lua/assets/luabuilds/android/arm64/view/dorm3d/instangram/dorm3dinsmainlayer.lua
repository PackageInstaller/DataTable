local var_0_0 = class("Dorm3dInsMainLayer", import("...base.BaseUI"))

var_0_0.OPEN_INS = "Dorm3dInsMainLayer.OPEN_INS"
var_0_0.OPEN_CHAT = "Dorm3dInsMainLayer.OPEN_CHAT"
var_0_0.OPEN_PHONE = "Dorm3dInsMainLayer.OPEN_PHONE"
var_0_0.DOWNLOAD_ROOM = "Dorm3dInsMainLayer.DOWNLOAD_ROOM"
var_0_0.DELETE_ROOM = "Dorm3dInsMainLayer.DELETE_ROOM"
var_0_0.FLUSH_LEFT = "Dorm3dInsMainLayer.FLUSH_LEFT"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = "PAGE_INS"
local var_0_4 = "PAGE_CHAT"
local var_0_5 = "PAGE_PHONE"
local var_0_6 = "PAGE_MAIN"
local var_0_7 = 2
local var_0_8 = 1

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dInsMainUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.mainTf = arg_2_0._tf:Find("main")
	arg_2_0.mainPages = {
		[var_0_8] = Dorm3dInsPublicPage.New(arg_2_0._tf:Find("main/public_page"), arg_2_0.event),
		[var_0_7] = Dorm3dInsCharPage.New(arg_2_0._tf:Find("main/char_page"), arg_2_0.event)
	}
	arg_2_0.roomListContainer = arg_2_0._tf:Find("left/scroll/mask/list")
	arg_2_0.roomItemList = UIItemList.New(arg_2_0.roomListContainer, arg_2_0.roomListContainer:Find("tpl"))

	arg_2_0.roomItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateRoomList(arg_3_1, arg_3_2)
		end

		return
	end)

	arg_2_0.expandPanel = arg_2_0._tf:Find("expand_panel")
	arg_2_0.expandListContainer = arg_2_0._tf:Find("expand_panel/scroll/mask/list")
	arg_2_0.expandItemList = UIItemList.New(arg_2_0.expandListContainer, arg_2_0.expandListContainer:Find("tpl"))

	arg_2_0.expandItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateRoomList(arg_4_1, arg_4_2)
		end

		return
	end)

	arg_2_0.selectPanel = arg_2_0._tf:Find("select_panel")
	arg_2_0.selectListContainer = arg_2_0._tf:Find("select_panel/list")
	arg_2_0.selectItemList = UIItemList.New(arg_2_0.selectListContainer, arg_2_0.selectListContainer:Find("tpl"))

	arg_2_0.selectItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_2_0:InitSelectItem(arg_5_1, arg_5_2)
		end

		return
	end)

	arg_2_0.selectOpen = false
	arg_2_0.downloadTf = arg_2_0._tf:Find("main/download")
	arg_2_0.download = arg_2_0.downloadTf:Find("btns/download")
	arg_2_0.downloading = arg_2_0.downloadTf:Find("btns/downloading")
	arg_2_0.delete = arg_2_0.downloadTf:Find("btns/delete")
	arg_2_0.downloadProgress = arg_2_0.downloadTf:Find("progress")
	arg_2_0.slider = arg_2_0.downloadProgress:Find("slider")

	arg_2_0:BlurPanel(arg_2_0._tf)
	arg_2_0:InitData()

	return
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.roomDataDic = {}
	arg_6_0.roomDataList = Clone(getProxy(Dorm3dInsProxy):GetRoomList())

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.roomDataList) do
		arg_6_0.roomDataDic[iter_6_1.id] = iter_6_1
	end

	arg_6_0.selectOptions = {}

	arg_6_0:BuildSelectOptions()
	arg_6_0:FilterRoomList(var_0_1)
	arg_6_0:SortRoomList()

	return
end

function var_0_0.BuildSelectOptions(arg_7_0)
	table.insert(arg_7_0.selectOptions, {
		mode = var_0_1,
		label = i18n("dorm3d_privatechat_screen_all")
	})

	for iter_7_0, iter_7_1 in pairs(pg.dorm3d_rooms.get_id_list_by_in_map) do
		table.insert(arg_7_0.selectOptions, {
			mode = var_0_2,
			arg = iter_7_0,
			label = i18n("dorm3d_privatechat_screen_" .. iter_7_0)
		})
	end

	return
end

function var_0_0.FilterRoomList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.roomIdList = _.map(_.select(arg_8_0.roomDataList, function(arg_9_0)
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

function var_0_0.SortRoomList(arg_13_0)
	table.sort(arg_13_0.roomIdList, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0.roomDataDic[arg_14_0]:IsCare() and 1 or 0
		local var_14_1 = arg_13_0.roomDataDic[arg_14_1]:IsCare() and 1 or 0

		if var_14_0 ~= var_14_1 then
			return var_14_1 < var_14_0
		end

		local var_14_2 = arg_13_0.roomDataDic[arg_14_0]:GetType()
		local var_14_3 = arg_13_0.roomDataDic[arg_14_1]:GetType()

		if var_14_2 ~= var_14_3 then
			return var_14_3 < var_14_2
		end

		return arg_14_0 < arg_14_1
	end)

	return
end

function var_0_0.ClosePrePage(arg_15_0)
	switch(arg_15_0.curPage, {
		[var_0_3] = function()
			arg_15_0:emit(Dorm3dInsMainMediator.CLOSE_JUUS)

			return
		end,
		[var_0_4] = function()
			arg_15_0:emit(Dorm3dInsMainMediator.CLOSE_CHAT)

			return
		end,
		[var_0_5] = function()
			arg_15_0:emit(Dorm3dInsMainMediator.CLOSE_PHONE)

			return
		end,
		[var_0_6] = function()
			setActive(arg_15_0.mainTf, false)

			return
		end
	})

	arg_15_0.curPage = nil

	return
end

function var_0_0.didEnter(arg_20_0)
	onButton(arg_20_0, arg_20_0.bg, function()
		if arg_20_0.curPage then
			arg_20_0:ClosePrePage()
		end

		arg_20_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_0._tf:Find("left/btn_select"), function()
		arg_20_0:OpenOrCloseSelectPanel()

		return
	end)
	onButton(arg_20_0, arg_20_0.selectPanel:Find("back"), function()
		arg_20_0:OpenOrCloseSelectPanel()

		return
	end)
	onButton(arg_20_0, arg_20_0._tf:Find("left/btn_expand"), function()
		setActive(arg_20_0.expandPanel, true)
		arg_20_0.expandPanel:SetAsLastSibling()

		return
	end)
	onButton(arg_20_0, arg_20_0.expandPanel:Find("btn_close"), function()
		setActive(arg_20_0.expandPanel, false)

		return
	end)
	onButton(arg_20_0, arg_20_0.downloadTf, function()
		arg_20_0:OnClickDownload(arg_20_0.selectedId)

		return
	end)

	local function var_20_0(arg_27_0)
		if not arg_20_0.roomDataDic[arg_20_0.selectedId]:IsDownloaded() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_room_unlock"))
		else
			existCall(arg_27_0)
		end

		return
	end

	arg_20_0:bind(var_0_0.OPEN_INS, function(arg_28_0)
		var_20_0(function()
			arg_20_0:ClosePrePage()

			arg_20_0.curPage = var_0_3

			arg_20_0:emit(Dorm3dInsMainMediator.OPEN_JUUS, arg_20_0.roomDataDic[arg_20_0.selectedId].groupId)

			return
		end)

		return
	end)
	arg_20_0:bind(var_0_0.OPEN_CHAT, function(arg_30_0)
		var_20_0(function()
			arg_20_0:ClosePrePage()

			arg_20_0.curPage = var_0_4

			arg_20_0:emit(Dorm3dInsMainMediator.OPEN_CHAT, arg_20_0.roomDataDic[arg_20_0.selectedId].groupId)

			return
		end)

		return
	end)
	arg_20_0:bind(var_0_0.OPEN_PHONE, function(arg_32_0)
		var_20_0(function()
			if DORM_LOCK_INS_PHONE then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_telephone"))

				return
			end

			arg_20_0:ClosePrePage()

			arg_20_0.curPage = var_0_5

			arg_20_0:emit(Dorm3dInsMainMediator.OPEN_PHONE, arg_20_0.roomDataDic[arg_20_0.selectedId].groupId)

			return
		end)

		return
	end)
	arg_20_0:bind(var_0_0.FLUSH_LEFT, function(arg_34_0)
		arg_20_0:SortRoomList()
		arg_20_0.roomItemList:align(#arg_20_0.roomIdList)

		return
	end)

	arg_20_0.selectedId = arg_20_0.roomIdList[1]

	arg_20_0.selectItemList:align(#arg_20_0.selectOptions)

	arg_20_0.curPage = var_0_6

	arg_20_0:Flush()

	if arg_20_0.contextData.isPhone then
		-- block empty
	end

	return
end

function var_0_0.UpdateRoomList(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.roomDataDic[arg_35_0.roomIdList[arg_35_1 + 1]]

	setActive(arg_35_2:Find("selected"), arg_35_0.roomDataDic[arg_35_0.roomIdList[arg_35_1 + 1]].id == arg_35_0.selectedId)
	setActive(arg_35_2:Find("like"), var_35_0:IsCare())
	GetImageSpriteFromAtlasAsync(var_35_0:GetIcon(), "", arg_35_2:Find("mask/icon"), true)
	setActive(arg_35_2:Find("tip"), var_35_0:ShouldTip())
	onButton(arg_35_0, arg_35_2, function()
		arg_35_0.selectedId = var_35_0.id

		if arg_35_0.curPage ~= var_0_6 then
			arg_35_0:OpenMain()
		end

		arg_35_0:Flush()

		return
	end)

	return
end

function var_0_0.OpenMain(arg_37_0)
	arg_37_0:ClosePrePage()
	setActive(arg_37_0.mainTf, true)
	arg_37_0:Flush()

	arg_37_0.curPage = var_0_6

	return
end

function var_0_0.Flush(arg_38_0)
	local var_38_0 = arg_38_0.roomDataDic[arg_38_0.selectedId]:GetType()

	arg_38_0.mainPages[(function(arg_39_0)
		return #arg_38_0.mainPages - arg_39_0 + 1
	end)(var_38_0)]:Hide()
	arg_38_0.mainPages[var_38_0]:Show()
	arg_38_0.mainPages[var_38_0]:Flush(arg_38_0.roomDataDic[arg_38_0.selectedId])
	arg_38_0.roomItemList:align(#arg_38_0.roomIdList)
	arg_38_0.expandItemList:align(#arg_38_0.roomIdList)
	arg_38_0:FlushDownload()

	return
end

function var_0_0.FlushLeft(arg_40_0)
	arg_40_0.roomItemList:align(#arg_40_0.roomIdList)

	return
end

function var_0_0.InitSelectItem(arg_41_0, arg_41_1, arg_41_2)
	setText(arg_41_2:Find("label"), arg_41_0.selectOptions[arg_41_1 + 1].label)
	onButton(arg_41_0, arg_41_2, function()
		arg_41_0:FilterRoomList(var_0.mode, var_0.arg)
		arg_41_0:SortRoomList()
		arg_41_0.roomItemList:align(#arg_41_0.roomIdList)
		arg_41_0.expandItemList:align(#arg_41_0.roomIdList)

		return
	end)

	return
end

function var_0_0.OpenOrCloseSelectPanel(arg_43_0)
	arg_43_0.selectOpen = not arg_43_0.selectOpen

	setActive(arg_43_0.selectPanel, arg_43_0.selectOpen)

	if arg_43_0.selectOpen then
		arg_43_0.selectPanel:SetAsLastSibling()
	end

	return
end

local var_0_9 = 1
local var_0_10 = 2
local var_0_11 = 3

function var_0_0.CheckCurrentDownloadState(arg_44_0, arg_44_1)
	if DormGroupConst.DormDownloadLock and DormGroupConst.DormDownloadLock.roomId == arg_44_1 then
		return var_0_11
	end

	if arg_44_0.roomDataDic[arg_44_1]:IsDownloaded() then
		return var_0_10 or var_0_9
	end
end

function var_0_0.FlushDownload(arg_45_0, arg_45_1)
	arg_45_1 = arg_45_1 or arg_45_0:CheckCurrentDownloadState(arg_45_0.selectedId)

	setActive(arg_45_0.download, arg_45_1 == var_0_9)
	setActive(arg_45_0.delete, arg_45_1 == var_0_10)
	setActive(arg_45_0.downloading, arg_45_1 == var_0_11)
	arg_45_0:FlushDownloadSlider(arg_45_1)

	return
end

function var_0_0.FlushDownloadSlider(arg_46_0, arg_46_1)
	setActive(arg_46_0.downloadProgress, arg_46_1 == var_0_11)

	if arg_46_1 == var_0_11 then
		setSlider(arg_46_0.slider, 0, DormGroupConst.DormDownloadLock.totalSize, DormGroupConst.DormDownloadLock.curSize)
	end

	return
end

function var_0_0.DownloadUpdate(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 ~= arg_47_0.selectedId then
		return
	end

	switch(arg_47_2, {
		start = function()
			arg_47_0:FlushDownload(var_0_11)

			return
		end,
		loading = function()
			arg_47_0:FlushDownloadSlider(var_0_11)

			return
		end,
		finish = function()
			arg_47_0:FlushDownload(var_0_10)

			return
		end,
		delete = function()
			arg_47_0:FlushDownload(var_0_9)

			return
		end
	})

	return
end

function var_0_0.OnClickDownload(arg_52_0, arg_52_1)
	if getProxy(ApartmentProxy):getRoom(1) then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("DORM3D_GUIDE_02") then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_tip"))

			return
		end

		switch(arg_52_0:CheckCurrentDownloadState(arg_52_1), {
			[var_0_10] = function()
				arg_52_0:DeleteRoom(arg_52_1)

				return
			end,
			[var_0_9] = function()
				if not getProxy(ApartmentProxy):getRoom(arg_52_1) then
					if arg_52_0.roomDataDic[arg_52_1]:GetType() == 1 then
						arg_52_0:emit(Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_52_1)
					elseif arg_52_0.roomDataDic[arg_52_1]:GetType() == 2 then
						arg_52_0:emit(Dorm3dInsMainMediator.ON_UNLOCK_DORM_ROOM, arg_52_1)
					end
				else
					arg_52_0:TryDownloadResource({
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
end

function var_0_0.TryDownloadResource(arg_56_0, arg_56_1, arg_56_2)
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

function var_0_0.DeleteRoom(arg_58_0, arg_58_1)
	arg_58_0:TryDownloadResource({
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
				arg_58_0:emit(Dorm3dInsMainMediator.NotifyDormDelete, arg_58_1)

				return
			end
		})

		return
	end)

	return
end

return var_0_0
