class = var_0_10000

local var_0_0 = "Dorm3dInsMainLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.OPEN_INS = "Dorm3dInsMainLayer.OPEN_INS"
var_0_1.OPEN_CHAT = "Dorm3dInsMainLayer.OPEN_CHAT"
var_0_1.OPEN_PHONE = "Dorm3dInsMainLayer.OPEN_PHONE"
var_0_1.DOWNLOAD_ROOM = "Dorm3dInsMainLayer.DOWNLOAD_ROOM"
var_0_1.DELETE_ROOM = "Dorm3dInsMainLayer.DELETE_ROOM"
var_0_1.FLUSH_LEFT = "Dorm3dInsMainLayer.FLUSH_LEFT"

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = "PAGE_INS"
local var_0_5 = "PAGE_CHAT"
local var_0_6 = "PAGE_PHONE"
local var_0_7 = "PAGE_MAIN"
local var_0_8 = 2
local var_0_9 = 1

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dInsMainUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.mainTf = var_1.Find(var_2_1, "main")

	local var_2_2 = {}
	local var_2_3 = var_0_9

	Dorm3dInsPublicPage = var_3

	local var_2_4 = var_3.New
	local var_2_5 = arg_2_0._tf

	var_2_2[var_2_3] = var_2_4(var_4.Find(var_2_5, "main/public_page"), arg_2_0.event)

	local var_2_6 = var_0_8

	Dorm3dInsCharPage = var_3

	local var_2_7 = var_3.New
	local var_2_8 = arg_2_0._tf

	var_2_2[var_2_6] = var_2_7(var_4.Find(var_2_8, "main/char_page"), arg_2_0.event)
	arg_2_0.mainPages = var_2_2

	local var_2_9 = arg_2_0._tf

	arg_2_0.roomListContainer = var_1.Find(var_2_9, "left/scroll/mask/list")
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0.roomListContainer
	local var_2_12 = arg_2_0.roomListContainer

	arg_2_0.roomItemList = var_2_10(var_2_11, var_3.Find(var_2_12, "tpl"))

	local var_2_13 = arg_2_0.roomItemList

	var_1.make(var_2_13, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0

			var_3.UpdateRoomList(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	local var_2_14 = arg_2_0._tf

	arg_2_0.expandPanel = var_1.Find(var_2_14, "expand_panel")

	local var_2_15 = arg_2_0._tf

	arg_2_0.expandListContainer = var_1.Find(var_2_15, "expand_panel/scroll/mask/list")
	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0.expandListContainer
	local var_2_18 = arg_2_0.expandListContainer

	arg_2_0.expandItemList = var_2_16(var_2_17, var_3.Find(var_2_18, "tpl"))

	local var_2_19 = arg_2_0.expandItemList

	var_1.make(var_2_19, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0

			var_3.UpdateRoomList(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	local var_2_20 = arg_2_0._tf

	arg_2_0.selectPanel = var_1.Find(var_2_20, "select_panel")

	local var_2_21 = arg_2_0._tf

	arg_2_0.selectListContainer = var_1.Find(var_2_21, "select_panel/list")
	UIItemList = var_1

	local var_2_22 = var_1.New
	local var_2_23 = arg_2_0.selectListContainer
	local var_2_24 = arg_2_0.selectListContainer

	arg_2_0.selectItemList = var_2_22(var_2_23, var_3.Find(var_2_24, "tpl"))

	local var_2_25 = arg_2_0.selectItemList

	var_1.make(var_2_25, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_2_0

			var_3.InitSelectItem(var_5_0, arg_5_1, arg_5_2)
		end

		return
	end)

	arg_2_0.selectOpen = false

	local var_2_26 = arg_2_0._tf

	arg_2_0.downloadTf = var_1.Find(var_2_26, "main/download")

	local var_2_27 = arg_2_0.downloadTf

	arg_2_0.download = var_1.Find(var_2_27, "btns/download")

	local var_2_28 = arg_2_0.downloadTf

	arg_2_0.downloading = var_1.Find(var_2_28, "btns/downloading")

	local var_2_29 = arg_2_0.downloadTf

	arg_2_0.delete = var_1.Find(var_2_29, "btns/delete")

	local var_2_30 = arg_2_0.downloadTf

	arg_2_0.downloadProgress = var_1.Find(var_2_30, "progress")

	local var_2_31 = arg_2_0.downloadProgress

	arg_2_0.slider = var_1.Find(var_2_31, "slider")

	arg_2_0:BlurPanel(arg_2_0._tf)
	arg_2_0:InitData()

	return
end

function var_0_1.InitData(arg_6_0)
	arg_6_0.roomDataDic = {}
	Clone = var_1
	getProxy = var_1_10002
	Dorm3dInsProxy = var_1_10003

	local var_6_0 = var_1_10002(var_1_10003)

	arg_6_0.roomDataList = var_1(var_2.GetRoomList(var_6_0))
	ipairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.roomDataList) do
		arg_6_0.roomDataDic[iter_6_1.id] = iter_6_1
	end

	arg_6_0.selectOptions = {}

	arg_6_0:BuildSelectOptions()
	arg_6_0:FilterRoomList(var_0_2)
	arg_6_0:SortRoomList()

	return
end

function var_0_1.BuildSelectOptions(arg_7_0)
	table = var_1_10001

	local var_7_0 = var_1_10001.insert
	local var_7_1 = arg_7_0.selectOptions
	local var_7_2 = {
		mode = var_0_2
	}

	i18n = var_4
	var_7_2.label = var_4("dorm3d_privatechat_screen_all")

	var_7_0(var_7_1, var_7_2)

	pairs = var_7_0
	pg = var_7_1

	for iter_7_0, iter_7_1 in var_7_0(var_7_1.dorm3d_rooms.get_id_list_by_in_map) do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_7_3 = arg_7_0.selectOptions
		local var_7_4 = {
			mode = var_0_3,
			arg = iter_7_0
		}

		i18n = var_9
		var_7_4.label = var_9("dorm3d_privatechat_screen_" .. iter_7_0)

		var_1_10006(var_7_3, var_7_4)
	end

	return
end

function var_0_1.FilterRoomList(arg_8_0, arg_8_1, arg_8_2)
	_ = var_1_10003

	local var_8_0 = var_1_10003.map

	_ = var_1_10004
	arg_8_0.roomIdList = var_8_0(var_1_10004.select(arg_8_0.roomDataList, function(arg_9_0)
		switch = var_2_10001

		return var_2_10001(arg_8_1, {
			[var_0_2] = function()
				return true
			end,
			[var_0_3] = function()
				local var_11_0 = arg_9_0

				return var_0.GetInMap(var_11_0) == arg_8_2
			end
		})
	end), function(arg_12_0)
		return arg_12_0.id
	end)

	return
end

function var_0_1.SortRoomList(arg_13_0)
	table = var_1_10001

	var_1_10001.sort(arg_13_0.roomIdList, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0.roomDataDic[arg_14_0]
		local var_14_1 = var_2.IsCare(var_14_0) and 1 or 0
		local var_14_2 = arg_13_0.roomDataDic[arg_14_1]

		if var_14_1 ~= (var_3.IsCare(var_14_2) and 1 or 0) then
			return var_3 < var_14_1
		end

		local var_14_3 = arg_13_0.roomDataDic[arg_14_0]
		local var_14_4 = var_4.GetType(var_14_3)
		local var_14_5 = arg_13_0.roomDataDic[arg_14_1]

		if var_14_4 ~= var_5.GetType(var_14_5) then
			return var_5 < var_14_4
		end

		return arg_14_0 < arg_14_1
	end)

	return
end

function var_0_1.ClosePrePage(arg_15_0)
	switch = var_1_10001

	var_1_10001(arg_15_0.curPage, {
		[var_0_4] = function()
			local var_16_0 = arg_15_0
			local var_16_1 = var_0.emit

			Dorm3dInsMainMediator = var_2_10002

			var_16_1(var_16_0, var_2_10002.CLOSE_JUUS)

			return
		end,
		[var_0_5] = function()
			local var_17_0 = arg_15_0
			local var_17_1 = var_0.emit

			Dorm3dInsMainMediator = var_2_10002

			var_17_1(var_17_0, var_2_10002.CLOSE_CHAT)

			return
		end,
		[var_0_6] = function()
			local var_18_0 = arg_15_0
			local var_18_1 = var_0.emit

			Dorm3dInsMainMediator = var_2_10002

			var_18_1(var_18_0, var_2_10002.CLOSE_PHONE)

			return
		end,
		[var_0_7] = function()
			setActive = var_2_10000

			var_2_10000(arg_15_0.mainTf, false)

			return
		end
	})

	arg_15_0.curPage = nil

	return
end

function var_0_1.didEnter(arg_20_0)
	onButton = var_1_10001

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.bg

	local function var_20_2()
		if arg_20_0.curPage then
			local var_21_0 = arg_20_0

			var_0.ClosePrePage(var_21_0)
		end

		local var_21_1 = arg_20_0

		var_0.closeView(var_21_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_20_0, var_20_1, var_20_2, var_1_10005)

	onButton = var_1_10001

	local var_20_3 = arg_20_0
	local var_20_4 = arg_20_0._tf

	var_1_10001(var_20_3, var_3.Find(var_20_4, "left/btn_select"), function()
		local var_22_0 = arg_20_0

		var_0.OpenOrCloseSelectPanel(var_22_0)

		return
	end)

	onButton = var_1_10001

	local var_20_5 = arg_20_0
	local var_20_6 = arg_20_0.selectPanel

	var_1_10001(var_20_5, var_3.Find(var_20_6, "back"), function()
		local var_23_0 = arg_20_0

		var_0.OpenOrCloseSelectPanel(var_23_0)

		return
	end)

	onButton = var_1_10001

	local var_20_7 = arg_20_0
	local var_20_8 = arg_20_0._tf

	var_1_10001(var_20_7, var_3.Find(var_20_8, "left/btn_expand"), function()
		setActive = var_2_10000

		var_2_10000(arg_20_0.expandPanel, true)

		local var_24_0 = arg_20_0.expandPanel

		var_0.SetAsLastSibling(var_24_0)

		return
	end)

	onButton = var_1_10001

	local var_20_9 = arg_20_0
	local var_20_10 = arg_20_0.expandPanel

	var_1_10001(var_20_9, var_3.Find(var_20_10, "btn_close"), function()
		setActive = var_2_10000

		var_2_10000(arg_20_0.expandPanel, false)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_20_0, arg_20_0.downloadTf, function()
		local var_26_0 = arg_20_0

		var_0.OnClickDownload(var_26_0, arg_20_0.selectedId)

		return
	end)

	local function var_20_11(arg_27_0)
		local var_27_0 = arg_20_0.roomDataDic[arg_20_0.selectedId]
		local var_27_2

		if not var_1.IsDownloaded(var_27_0) then
			pg = var_27_2

			local var_27_1 = var_27_2.TipsMgr.GetInstance()

			var_27_2 = var_27_2.ShowTips
			i18n = var_2_10003

			var_27_2(var_27_1, var_2_10003("dorm3d_privatechat_room_unlock"))
		else
			existCall = var_27_2

			var_27_2(arg_27_0)
		end

		return
	end

	arg_20_0:bind(var_0_1.OPEN_INS, function(arg_28_0)
		var_20_11(function()
			local var_29_0 = arg_20_0

			var_0.ClosePrePage(var_29_0)

			arg_20_0.curPage = var_0_4

			local var_29_1 = arg_20_0
			local var_29_2 = var_0.emit

			Dorm3dInsMainMediator = var_3_10002

			var_29_2(var_29_1, var_3_10002.OPEN_JUUS, arg_20_0.roomDataDic[arg_20_0.selectedId].groupId)

			return
		end)

		return
	end)
	arg_20_0:bind(var_0_1.OPEN_CHAT, function(arg_30_0)
		var_20_11(function()
			local var_31_0 = arg_20_0

			var_0.ClosePrePage(var_31_0)

			arg_20_0.curPage = var_0_5

			local var_31_1 = arg_20_0
			local var_31_2 = var_0.emit

			Dorm3dInsMainMediator = var_3_10002

			var_31_2(var_31_1, var_3_10002.OPEN_CHAT, arg_20_0.roomDataDic[arg_20_0.selectedId].groupId)

			return
		end)

		return
	end)
	arg_20_0:bind(var_0_1.OPEN_PHONE, function(arg_32_0)
		var_20_11(function()
			DORM_LOCK_INS_PHONE = var_3_10000

			if var_3_10000 then
				pg = var_3_10000

				local var_33_0 = var_3_10000.TipsMgr.GetInstance()
				local var_33_1 = var_0.ShowTips

				i18n = var_3_10002

				var_33_1(var_33_0, var_3_10002("dorm3d_privatechat_telephone"))

				return
			end

			local var_33_2 = arg_20_0

			var_0.ClosePrePage(var_33_2)

			arg_20_0.curPage = var_0_6

			local var_33_3 = arg_20_0
			local var_33_4 = var_0.emit

			Dorm3dInsMainMediator = var_3_10002

			var_33_4(var_33_3, var_3_10002.OPEN_PHONE, arg_20_0.roomDataDic[arg_20_0.selectedId].groupId)

			return
		end)

		return
	end)
	arg_20_0:bind(var_0_1.FLUSH_LEFT, function(arg_34_0)
		local var_34_0 = arg_20_0

		var_1.SortRoomList(var_34_0)

		local var_34_1 = arg_20_0.roomItemList

		var_1.align(var_34_1, #arg_20_0.roomIdList)

		return
	end)

	arg_20_0.selectedId = arg_20_0.roomIdList[1]

	local var_20_12 = arg_20_0.selectItemList

	var_2.align(var_20_12, #arg_20_0.selectOptions)

	arg_20_0.curPage = var_0_7

	arg_20_0:Flush()

	if arg_20_0.contextData.isPhone then
		-- block empty
	end

	return
end

function var_0_1.UpdateRoomList(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.roomDataDic[arg_35_0.roomIdList[arg_35_1 + 1]]

	setActive = var_4

	var_4(arg_35_2:Find("selected"), var_35_0.id == arg_35_0.selectedId)

	setActive = var_4

	var_4(arg_35_2:Find("like"), var_35_0:IsCare())

	GetImageSpriteFromAtlasAsync = var_4

	var_4(var_35_0:GetIcon(), "", arg_35_2:Find("mask/icon"), true)

	setActive = var_4

	var_4(arg_35_2:Find("tip"), var_35_0:ShouldTip())

	onButton = var_4

	var_4(arg_35_0, arg_35_2, function()
		arg_35_0.selectedId = var_35_0.id

		if arg_35_0.curPage ~= var_0_7 then
			local var_36_0 = arg_35_0

			var_0.OpenMain(var_36_0)
		end

		local var_36_1 = arg_35_0

		var_0.Flush(var_36_1)

		return
	end)

	return
end

function var_0_1.OpenMain(arg_37_0)
	arg_37_0:ClosePrePage()

	setActive = var_1

	var_1(arg_37_0.mainTf, true)
	arg_37_0:Flush()

	arg_37_0.curPage = var_0_7

	return
end

function var_0_1.Flush(arg_38_0)
	local function var_38_0(arg_39_0)
		return #arg_38_0.mainPages - arg_39_0 + 1
	end

	local var_38_1 = arg_38_0.roomDataDic[arg_38_0.selectedId]
	local var_38_2 = var_2.GetType(var_38_1)
	local var_38_3 = var_38_0(var_38_2)
	local var_38_4 = arg_38_0.mainPages[var_38_3]

	var_4.Hide(var_38_4)

	local var_38_5 = arg_38_0.mainPages[var_38_2]

	var_4.Show(var_38_5)

	local var_38_6 = arg_38_0.mainPages[var_38_2]

	var_4.Flush(var_38_6, arg_38_0.roomDataDic[arg_38_0.selectedId])

	local var_38_7 = arg_38_0.roomItemList

	var_4.align(var_38_7, #arg_38_0.roomIdList)

	local var_38_8 = arg_38_0.expandItemList

	var_4.align(var_38_8, #arg_38_0.roomIdList)
	arg_38_0:FlushDownload()

	return
end

function var_0_1.FlushLeft(arg_40_0)
	local var_40_0 = arg_40_0.roomItemList

	var_1.align(var_40_0, #arg_40_0.roomIdList)

	return
end

function var_0_1.InitSelectItem(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.selectOptions[arg_41_1 + 1]

	setText = var_4

	var_4(arg_41_2:Find("label"), var_41_0.label)

	onButton = var_4

	var_4(arg_41_0, arg_41_2, function()
		local var_42_0 = arg_41_0

		var_0.FilterRoomList(var_42_0, var_41_0.mode, var_41_0.arg)

		local var_42_1 = arg_41_0

		var_0.SortRoomList(var_42_1)

		local var_42_2 = arg_41_0.roomItemList

		var_0.align(var_42_2, #arg_41_0.roomIdList)

		local var_42_3 = arg_41_0.expandItemList

		var_0.align(var_42_3, #arg_41_0.roomIdList)

		return
	end)

	return
end

function var_0_1.OpenOrCloseSelectPanel(arg_43_0)
	arg_43_0.selectOpen = not arg_43_0.selectOpen
	setActive = var_1

	var_1(arg_43_0.selectPanel, arg_43_0.selectOpen)

	if arg_43_0.selectOpen then
		local var_43_0 = arg_43_0.selectPanel

		var_1.SetAsLastSibling(var_43_0)
	end

	return
end

local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3

function var_0_1.CheckCurrentDownloadState(arg_44_0, arg_44_1)
	DormGroupConst = var_1_10002

	if var_1_10002.DormDownloadLock then
		DormGroupConst = var_2

		if var_2.DormDownloadLock.roomId == arg_44_1 then
			return var_0_12
		end
	end

	local var_44_0 = arg_44_0.roomDataDic[arg_44_1]
	local var_44_1

	if not var_2.IsDownloaded(var_44_0) or not var_0_11 then
		var_44_1 = var_0_10
	end

	return var_44_1
end

function var_0_1.FlushDownload(arg_45_0, arg_45_1)
	arg_45_1 = arg_45_1 or arg_45_0:CheckCurrentDownloadState(arg_45_0.selectedId)
	setActive = var_1_10002

	var_1_10002(arg_45_0.download, arg_45_1 == var_0_10)

	setActive = var_1_10002

	var_1_10002(arg_45_0.delete, arg_45_1 == var_0_11)

	setActive = var_1_10002

	var_1_10002(arg_45_0.downloading, arg_45_1 == var_0_12)
	arg_45_0:FlushDownloadSlider(arg_45_1)

	return
end

function var_0_1.FlushDownloadSlider(arg_46_0, arg_46_1)
	setActive = var_1_10002

	var_1_10002(arg_46_0.downloadProgress, arg_46_1 == var_0_12)

	if arg_46_1 == var_0_12 then
		DormGroupConst = var_2

		local var_46_0 = var_2.DormDownloadLock

		setSlider = var_3

		var_3(arg_46_0.slider, 0, var_46_0.totalSize, var_46_0.curSize)
	end

	return
end

function var_0_1.DownloadUpdate(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 ~= arg_47_0.selectedId then
		return
	end

	switch = var_3

	var_3(arg_47_2, {
		start = function()
			local var_48_0 = arg_47_0

			var_0.FlushDownload(var_48_0, var_0_12)

			return
		end,
		loading = function()
			local var_49_0 = arg_47_0

			var_0.FlushDownloadSlider(var_49_0, var_0_12)

			return
		end,
		finish = function()
			local var_50_0 = arg_47_0

			var_0.FlushDownload(var_50_0, var_0_11)

			return
		end,
		delete = function()
			local var_51_0 = arg_47_0

			var_0.FlushDownload(var_51_0, var_0_10)

			return
		end
	})

	return
end

function var_0_1.OnClickDownload(arg_52_0, arg_52_1)
	getProxy = var_1_10002
	ApartmentProxy = var_1_10003

	local var_52_0 = var_1_10002(var_1_10003)

	if var_2.getRoom(var_52_0, 1) then
		pg = var_2

		local var_52_1 = var_2.NewStoryMgr.GetInstance()

		if not var_2.IsPlayed(var_52_1, "DORM3D_GUIDE_02") then
			pg = var_2

			local var_52_2 = var_2.TipsMgr.GetInstance()
			local var_52_3 = var_2.ShowTips

			i18n = var_4

			var_52_3(var_52_2, var_4("dorm3d_guide_tip"))

			return
		end

		local var_52_4 = arg_52_0
		local var_52_5 = arg_52_0.CheckCurrentDownloadState(var_52_4, arg_52_1)

		switch = var_52_4

		var_52_4(var_52_5, {
			[var_0_11] = function()
				local var_53_0 = arg_52_0

				var_0.DeleteRoom(var_53_0, arg_52_1)

				return
			end,
			[var_0_10] = function()
				getProxy = var_2_10000
				ApartmentProxy = var_2_10001

				local var_54_0 = var_2_10000(var_2_10001)

				if not var_0.getRoom(var_54_0, arg_52_1) then
					local var_54_1 = arg_52_0.roomDataDic[arg_52_1]

					if var_1.GetType(var_54_1) == 1 then
						local var_54_2 = arg_52_0
						local var_54_3 = var_1.emit

						Dorm3dInsMainMediator = var_2_10003

						var_54_3(var_54_2, var_2_10003.OPEN_ROOM_UNLOCK_WINDOW, arg_52_1)
					else
						local var_54_4 = arg_52_0.roomDataDic[arg_52_1]

						if var_1.GetType(var_54_4) == 2 then
							local var_54_5 = arg_52_0
							local var_54_6 = var_1.emit

							Dorm3dInsMainMediator = var_2_10003

							var_54_6(var_54_5, var_2_10003.ON_UNLOCK_DORM_ROOM, arg_52_1)
						end
					end
				else
					local var_54_7 = arg_52_0

					var_1.TryDownloadResource(var_54_7, {
						roomId = arg_52_1
					})
				end

				return
			end,
			[var_0_12] = function()
				pg = var_2_10000

				local var_55_0 = var_2_10000.TipsMgr.GetInstance()
				local var_55_1 = var_0.ShowTips

				i18n = var_2_10002

				var_55_1(var_55_0, var_2_10002("dorm3d_now_is_downloading"))

				return
			end
		})

		return
	end
end

function var_0_1.TryDownloadResource(arg_56_0, arg_56_1, arg_56_2)
	DormGroupConst = var_1_10003

	local var_56_0

	if var_1_10003.IsDownloading() then
		pg = var_56_0
		var_1_10004 = var_56_0.TipsMgr.GetInstance()
		var_56_0 = var_56_0.ShowTips
		i18n = var_1_10005

		var_56_0(var_1_10004, var_1_10005("dorm3d_now_is_downloading"))

		return
	end

	getProxy = var_56_0
	ApartmentProxy = var_1_10004

	local var_56_1 = var_56_0(var_1_10004)
	local var_56_2 = var_3.getRoom(var_56_1, arg_56_1.roomId)
	local var_56_3

	if #var_3.getDownloadNameList(var_56_2) > 0 then
		var_56_3 = {
			isShowBox = true,
			fileList = var_4,
			finishFunc = function(arg_57_0)
				if arg_57_0 then
					pg = var_2_10001

					local var_57_0 = var_2_10001.TipsMgr.GetInstance()
					local var_57_1 = var_1.ShowTips

					i18n = var_2_10003

					var_57_1(var_57_0, var_2_10003("dorm3d_resource_download_complete"))
				end

				return
			end,
			roomId = var_3.configId
		}
		DormGroupConst = var_6

		var_6.DormDownload(var_56_3)
	else
		existCall = var_56_3

		var_56_3(arg_56_2)
	end

	return
end

function var_0_1.DeleteRoom(arg_58_0, arg_58_1)
	arg_58_0:TryDownloadResource({
		roomId = arg_58_1
	}, function()
		getProxy = var_2_10000
		ApartmentProxy = var_2_10001

		local var_59_0 = var_2_10000(var_2_10001)
		local var_59_1 = var_0.getRoom(var_59_0, arg_58_1)
		local var_59_2 = var_0.getConfig(var_59_1, "room")

		if var_0:isPersonalRoom() then
			ShipGroup = var_2
			var_59_2 = var_2.getDefaultShipNameByGroupID(var_0:getPersonalGroupId())
		end

		local var_59_3
		local var_59_4 = var_0
		local var_59_5

		if var_0.isPersonalRoom(var_59_4) then
			DormGroupConst = var_59_5
			var_59_5 = var_59_5.GetDelRoomSize
			string = var_59_4
			var_59_4 = var_59_4.lower
			var_2_10006 = var_0
			var_59_3 = var_59_5(var_59_4(var_0.getConfig(var_2_10006, "resource_name")), {
				"room",
				"apartment"
			})
		else
			DormGroupConst = var_59_5
			var_59_5 = var_59_5.GetDelRoomSize
			string = var_59_4

			local var_59_6 = var_59_4.lower

			var_2_10006 = var_0
			var_59_3 = var_59_5(var_59_6(var_0.getConfig(var_2_10006, "resource_name")), {
				"room"
			})
		end

		pg = var_59_5

		local var_59_7 = var_59_5.MsgboxMgr.GetInstance()
		local var_59_8 = var_3.ShowMsgBox
		local var_59_9 = {}

		i18n = var_2_10006
		var_59_9.content = var_2_10006("dorm3d_role_assets_delete", var_59_2, var_59_3)

		function var_59_9.onYes()
			IsUnityEditor = var_3_10000

			if var_3_10000 then
				pg = var_3_10000

				local var_60_0 = var_3_10000.TipsMgr.GetInstance()
				local var_60_1 = var_0.ShowTips

				i18n = var_3_10002

				var_60_1(var_60_0, var_3_10002("common_no_open"))

				return
			end

			local var_60_2 = var_0
			local var_60_3

			if var_0.isPersonalRoom(var_60_2) then
				DormGroupConst = var_60_3
				var_60_3 = var_60_3.DelRoom
				string = var_60_2
				var_60_2 = var_60_2.lower

				local var_60_4 = var_0

				var_60_3(var_60_2(var_3_10002.getConfig(var_60_4, "resource_name")), {
					"room",
					"apartment"
				})
			else
				DormGroupConst = var_60_3
				var_60_3 = var_60_3.DelRoom
				string = var_60_2

				local var_60_5 = var_60_2.lower
				local var_60_6 = var_0

				var_60_3(var_60_5(var_3_10002.getConfig(var_60_6, "resource_name")), {
					"room"
				})
			end

			pg = var_60_3

			local var_60_7 = var_60_3.TipsMgr.GetInstance()
			local var_60_8 = var_0.ShowTips

			i18n = var_3_10002

			var_60_8(var_60_7, var_3_10002("dorm3d_delete_finish"))

			pg = var_60_8

			local var_60_9 = var_60_8.m02
			local var_60_10 = var_0.sendNotification

			GAME = var_2

			local var_60_11 = var_2.APARTMENT_TRACK

			Dorm3dTrackCommand = var_3

			var_60_10(var_60_9, var_60_11, var_3.BuildDataDownload(var_0.id, 3))

			local var_60_12 = arg_58_0
			local var_60_13 = var_0.emit

			Dorm3dInsMainMediator = var_60_11

			var_60_13(var_60_12, var_60_11.NotifyDormDelete, arg_58_1)

			return
		end

		var_59_8(var_59_7, var_59_9)

		return
	end)

	return
end

return var_0_1
