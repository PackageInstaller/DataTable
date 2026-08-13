class = var_0_10000

local var_0_0 = "Dorm3dCollectionLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dCollectionUI"
end

function var_0_1.SetApartment(arg_2_0, arg_2_1)
	arg_2_0.contextData.apartment = arg_2_1

	return
end

function var_0_1.SetRoom(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ApartmentProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	arg_3_0.room = var_2.getRoom(var_3_0, arg_3_1)

	return
end

function var_0_1.init(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "bg")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_PANEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_1.Find(var_4_4, "window")

	eachChild = var_1_10002

	var_1_10002(var_4_5:Find("toggles"), function(arg_6_0)
		onToggle = var_2_10001

		local var_6_0 = arg_4_0
		local var_6_1 = arg_6_0

		local function var_6_2(arg_7_0)
			if arg_7_0 then
				local var_7_0 = arg_4_0

				var_1.SetPage(var_7_0, arg_6_0.name)
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_6_0, var_6_1, var_6_2, var_2_10006)

		return
	end)

	local var_4_6 = var_4_5:Find("content")

	Dorm3dMemorySubView = var_4_4
	arg_4_0.memoryView = var_4_4.New(var_4_6:Find("memory"), arg_4_0.event, arg_4_0.contextData)
	Dorm3dCollectionItemSubView = var_3
	arg_4_0.collectItemView = var_3.New(var_4_6:Find("item"), arg_4_0.event, arg_4_0.contextData)
	pg = var_3

	local var_4_7 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_4_7, arg_4_0._tf)

	return
end

function var_0_1.SetPage(arg_8_0, arg_8_1)
	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002({
		memory = arg_8_0.memoryView,
		item = arg_8_0.collectItemView
	}) do
		if iter_8_0 == arg_8_1 then
			iter_8_1:Show()
		else
			iter_8_1:Hide()
		end
	end

	return
end

function var_0_1.didEnter(arg_9_0)
	local var_9_0 = arg_9_0.room

	if var_1.isPersonalRoom(var_9_0) then
		triggerToggle = var_1

		local var_9_1 = arg_9_0._tf

		var_1(var_3.Find(var_9_1, "window/toggles/memory"), true)
	else
		triggerToggle = var_1

		local var_9_2 = arg_9_0._tf

		var_1(var_3.Find(var_9_2, "window/toggles/item"), true)

		setActive = var_1

		local var_9_3 = arg_9_0._tf

		var_1(var_3.Find(var_9_3, "window/toggles/memory"), false)
	end

	return
end

function var_0_1.onBackPressed(arg_10_0)
	var_0_1.super.onBackPressed(arg_10_0)

	return
end

function var_0_1.willExit(arg_11_0)
	local var_11_0 = arg_11_0.memoryView

	var_1.Dispose(var_11_0)

	local var_11_1 = arg_11_0.collectItemView

	var_1.Dispose(var_11_1)

	pg = var_1

	local var_11_2 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_2, arg_11_0._tf)

	return
end

return var_0_1
