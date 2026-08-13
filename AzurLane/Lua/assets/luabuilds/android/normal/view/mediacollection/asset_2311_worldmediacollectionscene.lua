class = var_0_10000

local var_0_0 = "WorldMediaCollectionScene"

require = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.PAGE_MEMORTY = 1
var_0_1.PAGE_FILE = 2
var_0_1.PAGE_RECORD = 3
var_0_1.PAGE_ALBUM = 4
var_0_1.PAGE_SHIP = 5

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionUI"
end

function var_0_1.getBGM(arg_2_0)
	local var_2_0 = arg_2_0.contextData.revertBgm

	arg_2_0.contextData.revertBgm = nil

	if var_2_0 then
		return var_2_0
	else
		return var_0_1.super.getBGM(arg_2_0)
	end

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.top = var_1.Find(var_3_0, "Top")

	local var_3_1 = arg_3_0._tf

	arg_3_0.viewContainer = var_1.Find(var_3_1, "Main")
	arg_3_0.subViews = {}

	arg_3_0:OverlayPanel(arg_3_0.top)

	return
end

local var_0_2 = {}

import = var_2
var_0_2[1] = var_2(".WorldMediaCollectionMemoryLayer")
import = var_2
var_0_2[2] = var_2(".WorldMediaCollectionRecordLayer")
import = var_2
var_0_2[3] = var_2(".WorldMediaCollectionFileLayer")
import = var_2
var_0_2[4] = var_2(".WorldMediaCollectionAlbumLayer")
import = var_2
var_0_2[5] = var_2(".NewWorldMediaCollectionMemoryLayer")

function var_0_1.GetCurrentPage(arg_4_0)
	local var_4_0

	if arg_4_0.contextData.page then
		var_4_0 = arg_4_0.subViews[arg_4_0.contextData.page]
	end

	return var_4_0
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.top
	local var_5_2 = var_3.Find(var_5_1, "blur_panel/adapt/top/option")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.quickExitFunc(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.top
	local var_5_6 = var_3.Find(var_5_5, "blur_panel/adapt/top/back_btn")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.Backward(var_7_0)

		return
	end

	SFX_UI_CANCEL = var_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5)

	local var_5_8

	if not arg_5_0.contextData.page then
		var_5_8 = var_0_1.PAGE_MEMORTY
	end

	arg_5_0.contextData.page = nil

	arg_5_0:EnterPage(var_5_8)
	arg_5_0:UpdateView()

	return
end

function var_0_1.EnterPage(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 == arg_8_0.contextData.page

	if not arg_8_0.subViews[arg_8_1] then
		if not var_0_2[arg_8_1] then
			return
		end

		local var_8_1 = arg_8_0.contextData
		local var_8_2

		if not arg_8_0.contextData[var_4] then
			var_8_2 = {}
		end

		var_8_1[var_4] = var_8_2

		local var_8_3 = var_4.New(arg_8_0, arg_8_0.viewContainer, arg_8_0.event, arg_8_0.contextData)

		var_3.RegisterView(var_8_3, arg_8_0)
		var_3:Load()
	end

	if arg_8_0.contextData.page and arg_8_0.subViews[arg_8_0.contextData.page] and not var_8_0 then
		local var_8_4 = arg_8_0.subViews[arg_8_0.contextData.page].buffer

		var_4.OnDeselected(var_8_4)
	end

	arg_8_0.contextData.page = arg_8_1
	arg_8_0.subViews[arg_8_1] = var_3

	if not var_8_0 then
		local var_8_5 = var_3.buffer

		var_4.OnSelected(var_8_5)
	else
		local var_8_6 = var_3.buffer

		var_4.OnReselected(var_8_6)
	end

	return
end

function var_0_1.WarpToRecord(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.contextData.recordGroup = arg_9_1
	arg_9_0.contextData.storyNodeID = arg_9_3

	arg_9_0:EnterPage(var_0_1.PAGE_FILE)

	return
end

function var_0_1.WarpToStoryNode(arg_10_0, arg_10_1)
	arg_10_0:EnterPage(var_0_1.PAGE_MEMORTY)

	local var_10_0 = arg_10_0.subViews[var_0_1.PAGE_MEMORTY]

	var_2.WrapToStoryLine(var_10_0, arg_10_1)

	return
end

function var_0_1.Backward(arg_11_0)
	if arg_11_0.subViews[arg_11_0.contextData.page] and var_1:OnBackward() then
		return var_2
	end

	arg_11_0:closeView()

	return
end

function var_0_1.onBackPressed(arg_12_0)
	arg_12_0:Backward()

	return
end

function var_0_1.WorldRecordLock()
	local function var_13_0()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_14_0 = var_2_10000(var_2_10001)
		local var_14_1 = var_0.getRawData(var_14_0).level

		pg = var_14_0

		local var_14_2 = var_14_0.SystemOpenMgr.GetInstance()

		return var_1.isOpenSystem(var_14_2, var_14_1, "WorldMediaCollectionRecordMediator")
	end

	LOCK_WORLD_COLLECTION = var_1_10001
	var_1_10001 = var_1_10001 or not var_13_0()

	return var_1_10001
end

function var_0_1.UpdateView(arg_15_0)
	if not arg_15_0.subViews[arg_15_0.contextData.page] then
		return
	end

	local var_15_0 = var_1.buffer

	var_2.UpdateView(var_15_0)

	return
end

function var_0_1.willExit(arg_16_0)
	local var_16_0 = arg_16_0

	if arg_16_0.GetCurrentPage(var_16_0) then
		local var_16_1 = var_1.buffer

		var_16_0.Hide(var_16_1)
	end

	pairs = var_16_0

	for iter_16_0, iter_16_1 in var_16_0(arg_16_0.subViews) do
		iter_16_1:Destroy()
	end

	table = var_2

	var_2.clear(arg_16_0.subViews)
	arg_16_0:UnOverlayPanel(arg_16_0.top, arg_16_0._tf)

	return
end

return var_0_1
