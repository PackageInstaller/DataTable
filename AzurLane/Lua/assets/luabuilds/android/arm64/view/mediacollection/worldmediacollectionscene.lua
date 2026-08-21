local var_0_0 = class("WorldMediaCollectionScene", require("view.base.BaseUI"))

var_0_0.PAGE_MEMORTY = 1
var_0_0.PAGE_FILE = 2
var_0_0.PAGE_RECORD = 3
var_0_0.PAGE_ALBUM = 4
var_0_0.PAGE_SHIP = 5

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionUI"
end

function var_0_0.getBGM(arg_2_0)
	arg_2_0.contextData.revertBgm = nil

	if arg_2_0.contextData.revertBgm then
		return arg_2_0.contextData.revertBgm
	else
		return var_0_0.super.getBGM(arg_2_0)
	end

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.top = arg_3_0._tf:Find("Top")
	arg_3_0.viewContainer = arg_3_0._tf:Find("Main")
	arg_3_0.subViews = {}

	arg_3_0:OverlayPanel(arg_3_0.top)

	return
end

local var_0_1 = {
	import(".WorldMediaCollectionMemoryLayer"),
	import(".WorldMediaCollectionRecordLayer"),
	import(".WorldMediaCollectionFileLayer"),
	import(".WorldMediaCollectionAlbumLayer"),
	import(".NewWorldMediaCollectionMemoryLayer")
}

function var_0_0.GetCurrentPage(arg_4_0)
	return arg_4_0.contextData.page and arg_4_0.subViews[arg_4_0.contextData.page]
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0.top:Find("blur_panel/adapt/top/option"), function()
		arg_5_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.top:Find("blur_panel/adapt/top/back_btn"), function()
		arg_5_0:Backward()

		return
	end, SFX_UI_CANCEL)

	local var_5_0 = arg_5_0.contextData.page or var_0_0.PAGE_MEMORTY

	arg_5_0.contextData.page = nil

	arg_5_0:EnterPage(var_5_0)
	arg_5_0:UpdateView()

	return
end

function var_0_0.EnterPage(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 == arg_8_0.contextData.page
	local var_8_1 = arg_8_0.subViews[arg_8_1]

	if not arg_8_0.subViews[arg_8_1] then
		if not var_0_1[arg_8_1] then
			return
		end

		local var_8_2 = arg_8_0.contextData

		var_8_2[var_0_1[arg_8_1]] = arg_8_0.contextData[var_0_1[arg_8_1]] or {}
		var_8_1 = var_0_1[arg_8_1].New(arg_8_0, arg_8_0.viewContainer, arg_8_0.event, arg_8_0.contextData)

		var_8_1:RegisterView(arg_8_0)
		var_8_1:Load()
	end

	if arg_8_0.contextData.page and arg_8_0.subViews[arg_8_0.contextData.page] and not var_8_0 then
		arg_8_0.subViews[arg_8_0.contextData.page].buffer:OnDeselected()
	end

	arg_8_0.contextData.page = arg_8_1
	arg_8_0.subViews[arg_8_1] = var_8_1

	if not var_8_0 then
		var_8_1.buffer:OnSelected()
	else
		var_8_1.buffer:OnReselected()
	end

	return
end

function var_0_0.WarpToRecord(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.contextData.recordGroup = arg_9_1
	arg_9_0.contextData.storyNodeID = arg_9_3

	arg_9_0:EnterPage(var_0_0.PAGE_FILE)

	return
end

function var_0_0.WarpToStoryNode(arg_10_0, arg_10_1)
	arg_10_0:EnterPage(var_0_0.PAGE_MEMORTY)
	arg_10_0.subViews[var_0_0.PAGE_MEMORTY]:WrapToStoryLine(arg_10_1)

	return
end

function var_0_0.Backward(arg_11_0)
	local var_11_0 = arg_11_0.subViews[arg_11_0.contextData.page] and arg_11_0.subViews[arg_11_0.contextData.page]:OnBackward()

	if var_11_0 then
		return var_11_0
	end

	arg_11_0:closeView()

	return
end

function var_0_0.onBackPressed(arg_12_0)
	arg_12_0:Backward()

	return
end

function var_0_0.WorldRecordLock()
	return LOCK_WORLD_COLLECTION or not (function()
		return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "WorldMediaCollectionRecordMediator")
	end)()
end

function var_0_0.UpdateView(arg_15_0)
	if not arg_15_0.subViews[arg_15_0.contextData.page] then
		return
	end

	arg_15_0.subViews[arg_15_0.contextData.page].buffer:UpdateView()

	return
end

function var_0_0.willExit(arg_16_0)
	local var_16_0 = arg_16_0:GetCurrentPage()

	if var_16_0 then
		var_16_0.buffer:Hide()
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0.subViews) do
		iter_16_1:Destroy()
	end

	table.clear(arg_16_0.subViews)
	arg_16_0:UnOverlayPanel(arg_16_0.top, arg_16_0._tf)

	return
end

return var_0_0
