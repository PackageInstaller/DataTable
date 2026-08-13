class = var_0_10000

local var_0_0 = "WorldMediaCollectionFileGroupLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WorldMediaCollectionSubLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionFileGroupUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.scroll = var_1.Find(var_2_0, "ScrollRect")

	local var_2_1 = arg_2_0.scroll

	arg_2_0.scrollComp = var_1.GetComponent(var_2_1, "LScrollRect")
	setActive = var_1

	local var_2_2 = arg_2_0.scroll

	var_1(var_2.Find(var_2_2, "Item"), false)

	local var_2_3 = arg_2_0.scroll

	arg_2_0.content = var_1.Find(var_2_3, "Viewport/Content")

	local var_2_4 = arg_2_0.scroll

	arg_2_0.progressText = var_1.Find(var_2_4, "ProgressText")

	local var_2_5 = arg_2_0._tf

	arg_2_0.emptyTip = var_1.Find(var_2_5, "EmptyTip")
	arg_2_0.fileGroups = {}

	function arg_2_0.scrollComp.onUpdateItem(arg_3_0, ...)
		local var_3_0 = arg_2_0

		var_1.OnUpdateFileGroup(var_3_0, arg_3_0 + 1, ...)

		return
	end

	arg_2_0.scrolling = false
	arg_2_0.blurFlag = nil
	setText = var_1

	local var_2_6 = arg_2_0.scroll
	local var_2_7 = var_2.Find(var_2_6, "ProgressDesc")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("world_collection_3"))

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.UpdateGroupList(arg_4_0)
	nowWorld = var_1_10001

	local var_4_0 = var_1_10001()
	local var_4_1 = var_1.GetCollectionProxy(var_4_0)

	table = var_4_0

	var_4_0.clear(arg_4_0.fileGroups)

	local var_4_2 = 0
	local var_4_3 = 0

	_ = var_1_10004

	local var_4_4 = var_1_10004.each

	pg = var_1_10005

	var_4_4(var_1_10005.world_collection_file_group.all, function(arg_5_0)
		pg = var_2_10001

		local var_5_0 = var_2_10001.world_collection_file_group[arg_5_0]

		_ = var_2_10002

		local var_5_1 = var_2_10002.reduce(var_5_0.child, 0, function(arg_6_0, arg_6_1)
			local var_6_0 = var_4_1

			if var_2.IsUnlock(var_6_0, arg_6_1) then
				arg_6_0 = arg_6_0 + 1
			end

			return arg_6_0
		end)

		if 0 < var_5_1 then
			table = var_3

			var_3.insert(arg_4_0.fileGroups, var_5_0)
		end

		var_4_2 = var_4_2 + #var_5_0.child
		var_4_3 = var_4_3 + var_5_1

		return
	end)

	local var_4_5 = #arg_4_0.fileGroups == 0

	setActive = var_5

	var_5(arg_4_0.emptyTip, var_4_5)

	if var_4_5 then
		arg_4_0:BlurTip()
	else
		arg_4_0:UnBlurTip()
	end

	setActive = var_5

	var_5(arg_4_0.scroll, not var_4_5)

	local var_4_6 = arg_4_0.scrollComp

	var_5.SetTotalCount(var_4_6, #arg_4_0.fileGroups)

	setText = var_5

	var_5(arg_4_0.progressText, var_4_3 .. "/" .. var_4_2)

	return
end

function var_0_1.BlurTip(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.OverlayPanel
	local var_7_2 = arg_7_0.emptyTip
	local var_7_3 = {
		groupDelta = -1
	}
	local var_7_4 = {}
	local var_7_5 = arg_7_0.emptyTip

	var_7_4[1] = var_6.Find(var_7_5, "EmptyTip")
	var_7_3.pbList = var_7_4

	var_7_1(var_7_0, var_7_2, var_7_3)

	local var_7_6 = arg_7_0.emptyTip

	var_1.SetSiblingIndex(var_7_6, 0)

	arg_7_0.blurFlag = true

	return
end

function var_0_1.UnBlurTip(arg_8_0)
	if arg_8_0.blurFlag then
		arg_8_0:UnOverlayPanel(arg_8_0.emptyTip, arg_8_0._tf)
	end

	arg_8_0.blurFlag = nil

	return
end

function var_0_1.Show(arg_9_0)
	var_0_1.super.Show(arg_9_0)

	if arg_9_0.blurFlag then
		arg_9_0:BlurTip()
	end

	return
end

function var_0_1.Hide(arg_10_0)
	LeanTween = var_1_10001

	local var_10_0 = var_1_10001.cancel

	go = var_1_10002

	var_10_0(var_1_10002(arg_10_0.content))

	local var_10_1 = arg_10_0.scrollComp

	var_1.SetDraggingStatus(var_10_1, false)

	local var_10_2 = arg_10_0.scrollComp

	var_1.StopMovement(var_10_2)

	arg_10_0.scrolling = false

	arg_10_0:UnBlurTip()
	var_0_1.super.Hide(arg_10_0)

	return
end

function var_0_1.OnUpdateFileGroup(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.exited then
		return
	end

	local var_11_0 = arg_11_0.fileGroups[arg_11_1]

	assert = var_1_10004

	var_1_10004(var_11_0, "Not Initialize FileGroup Index " .. arg_11_1)

	tf = var_1_10004

	local var_11_1 = var_1_10004(arg_11_2)

	setText = var_5

	var_5(var_11_1:Find("FileIndex"), var_11_0.id_2)

	local var_11_2 = arg_11_0.loader

	var_5.GetSprite(var_11_2, "ui/WorldMediaCollectionFileUI_atlas", var_11_0.type, var_11_1:Find("BG"))

	local var_11_3 = arg_11_0.loader

	var_5.GetSprite(var_11_3, "CollectionFileTitle/" .. var_11_0.name_abbreviate, "", var_11_1:Find("FileTitle"), true)

	nowWorld = var_5

	local var_11_4 = var_5()
	local var_11_5 = var_5.GetCollectionProxy(var_11_4)
	local var_11_6 = 0
	local var_11_7 = #var_11_0.child

	ipairs = var_8

	for iter_11_0, iter_11_1 in var_8(var_11_0.child) do
		if var_11_5:IsUnlock(iter_11_1) then
			var_11_6 = var_11_6 + 1
		end
	end

	setText = var_8

	var_8(var_11_1:Find("FileProgress"), var_11_6 .. "/" .. var_11_7)

	local var_11_8 = arg_11_0.scroll.rect.width
	local var_11_9 = arg_11_0.scroll
	local var_11_10 = var_9.Find(var_11_9, "Item").rect.width
	local var_11_11 = arg_11_0.content
	local var_11_12 = var_10.GetComponent

	typeof = var_12
	HorizontalLayoutGroup = var_1_10013

	local var_11_13 = var_11_12(var_11_11, var_12(var_1_10013)).padding.left
	local var_11_14 = var_10.spacing

	onButton = var_1_10013

	local var_11_15 = arg_11_0
	local var_11_16 = var_11_1

	local function var_11_17()
		local var_12_0 = arg_11_0.viewParent

		var_0.OpenDetailLayer(var_12_0, var_11_0.id, true)

		return
	end

	SFX_PANEL = var_1_10017

	var_1_10013(var_11_15, var_11_16, var_11_17, var_1_10017)

	return
end

return var_0_1
