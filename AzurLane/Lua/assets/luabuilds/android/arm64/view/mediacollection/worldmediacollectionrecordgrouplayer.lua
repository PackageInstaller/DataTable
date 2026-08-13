class = var_0_10000

local var_0_0 = "WorldMediaCollectionRecordGroupLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WorldMediaCollectionTemplateLayer"))

function var_0_1.getUIName(arg_1_0)
	return "WorldMediaCollectionRecordGroupUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.scroll = var_1.Find(var_2_0, "ScrollRect")

	local var_2_1 = arg_2_0.scroll

	arg_2_0.scrollComp = var_1.GetComponent(var_2_1, "LScrollRect")
	setActive = var_1

	local var_2_2 = arg_2_0.scroll

	var_1(var_3.Find(var_2_2, "Item"), false)

	local var_2_3 = arg_2_0.scroll

	arg_2_0.content = var_1.Find(var_2_3, "Viewport/Content")

	local var_2_4 = arg_2_0.scroll

	arg_2_0.progressText = var_1.Find(var_2_4, "ProgressText")

	local var_2_5 = arg_2_0._tf

	arg_2_0.recordTogGroup = var_1.Find(var_2_5, "Toggles")

	local var_2_6 = {}
	local var_2_7 = arg_2_0.recordTogGroup

	var_2_6[1] = var_2.Find(var_2_7, "0")

	local var_2_8 = arg_2_0.recordTogGroup

	var_2_6[2] = var_2.Find(var_2_8, "1")

	local var_2_9 = arg_2_0.recordTogGroup

	var_2_6[3] = var_2.Find(var_2_9, "2")

	local var_2_10 = arg_2_0.recordTogGroup

	var_2_6[4] = var_2.Find(var_2_10, "3")
	arg_2_0.recordToggles = var_2_6
	arg_2_0.recordFilterIndex = {
		false,
		false,
		false
	}
	_ = var_1

	local var_2_11 = var_1.each

	pg = var_2_5

	var_2_11(var_2_5.world_collection_record_group.all, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.world_collection_record_group[arg_3_0]

		arg_2_0.recordFilterIndex[var_3_0.type] = true

		return
	end)

	local var_2_12 = #arg_2_0.recordFilterIndex
	local var_2_13

	for iter_2_0 = 1, #arg_2_0.recordFilterIndex do
		setActive = var_1_10007

		var_1_10007(arg_2_0.recordToggles[1 + iter_2_0], arg_2_0.recordFilterIndex[iter_2_0])

		if not arg_2_0.recordFilterIndex[iter_2_0] then
			var_2_12 = var_2_12 - 1
		else
			var_2_13 = var_2_13 or iter_2_0 + 1
		end
	end

	setActive = var_3

	var_3(arg_2_0.recordToggles[1], var_2_12 > 1)

	var_2_13 = var_2_12 <= 1 and var_2_13 or 1

	local var_2_14

	if not arg_2_0.contextData.toggle then
		var_2_14 = var_2_13
	end

	local var_2_15 = arg_2_0.contextData

	var_2_15.toggle = nil
	triggerToggle = var_2_15

	var_2_15(arg_2_0.recordToggles[var_2_14], true)
	arg_2_0:SwitchRecordFilter(var_2_14)

	ipairs = var_4

	for iter_2_1, iter_2_2 in var_4(arg_2_0.recordToggles) do
		onToggle = var_1_10009

		local var_2_16 = arg_2_0
		local var_2_17 = iter_2_2

		local function var_2_18(arg_4_0)
			if not arg_4_0 then
				return
			end

			local var_4_0 = arg_2_0

			var_1.SwitchRecordFilter(var_4_0, iter_2_1)

			local var_4_1 = arg_2_0

			var_1.RecordFilter(var_4_1)

			return
		end

		SFX_UI_TAG = var_1_10014

		var_1_10009(var_2_16, var_2_17, var_2_18, var_1_10014)
	end

	function arg_2_0.scrollComp.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.OnUpdateGroup(var_5_0, arg_5_0 + 1, arg_5_1)

		return
	end

	arg_2_0.recordGroups = {}

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.OverlayPanel
	local var_2_21 = arg_2_0.recordTogGroup
	local var_2_22 = {}

	LayerWeightConst = var_1_10009
	var_2_22.overlayType = var_1_10009.OVERLAY_UI_ADAPT

	var_2_20(var_2_19, var_2_21, var_2_22)

	AutoLoader = var_2_20
	arg_2_0.loader = var_2_20.New()
	setText = var_4

	local var_2_23 = arg_2_0.scroll
	local var_2_24 = var_6.Find(var_2_23, "ProgressDesc")

	i18n = var_2_21

	var_4(var_2_24, var_2_21("world_collection_3"))

	return
end

function var_0_1.Show(arg_6_0)
	var_0_1.super.Show(arg_6_0)

	setActive = var_1

	var_1(arg_6_0.recordTogGroup, true)

	return
end

function var_0_1.Hide(arg_7_0)
	LeanTween = var_1_10001

	local var_7_0 = var_1_10001.cancel

	go = var_1_10003

	var_7_0(var_1_10003(arg_7_0.content))

	local var_7_1 = arg_7_0.scrollComp

	var_1.SetDraggingStatus(var_7_1, false)

	local var_7_2 = arg_7_0.scrollComp

	var_1.StopMovement(var_7_2)

	arg_7_0.scrolling = false

	var_0_1.super.Hide(arg_7_0)

	setActive = var_1

	var_1(arg_7_0.recordTogGroup, false)
	var_0_1.super.Hide(arg_7_0)

	return
end

local var_0_2 = {
	"img_zhuxian",
	"img_zhixian",
	"img_shoujijilu"
}

function var_0_1.OnUpdateGroup(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.exited then
		return
	end

	local var_8_0 = arg_8_0.recordGroups[arg_8_1]

	assert = var_1_10004

	var_1_10004(var_8_0, "Not Initialize FileGroup Index " .. arg_8_1)

	tf = var_1_10004

	local var_8_1 = var_1_10004(arg_8_2)

	setText = var_1_10005

	var_1_10005(var_8_1:Find("FileIndex"), var_8_0.id)

	local var_8_2 = var_8_1:Find("NameRect/FileName1")

	GetPerceptualSize = var_6

	local var_8_3 = var_6(var_8_0.name_abbreviate)
	local var_8_4
	local var_8_5 = var_8_3 <= 4 and 32 or var_8_3 <= 6 and 28 or 24
	local var_8_6 = var_8_2
	local var_8_7 = var_8_2.GetComponent

	typeof = var_1_10011
	Text = var_1_10013

	local var_8_8 = var_8_7(var_8_6, var_1_10011(var_1_10013))

	var_8_8.fontSize = var_8_5
	var_8_8.text = var_8_0.name_abbreviate

	local var_8_9 = arg_8_0.loader

	var_9.GetSprite(var_8_9, "ui/WorldMediaCollectionRecordUI_atlas", var_0_2[var_8_0.type], var_8_1:Find("BG"))

	nowWorld = var_9

	local var_8_10 = var_9()
	local var_8_11 = var_9.GetCollectionProxy(var_8_10)
	local var_8_12 = #var_8_0.child

	_ = var_8_10

	local var_8_13 = var_8_10.reduce(var_8_0.child, 0, function(arg_9_0, arg_9_1)
		WorldCollectionProxy = var_2_10002

		if var_2_10002.GetCollectionTemplate(arg_9_1) then
			WorldMediaCollectionRecordDetailLayer = var_2_10003

			if var_2_10003.CheckRecordIsUnlock(var_2) then
				arg_9_0 = arg_9_0 + 1
			end
		end

		return arg_9_0
	end)

	setText = var_12

	var_12(var_8_1:Find("FileProgress"), var_8_13 .. "/" .. var_8_12)

	local var_8_14 = arg_8_0.scroll.rect.width
	local var_8_15 = arg_8_0.scroll
	local var_8_16 = var_13.Find(var_8_15, "Item").rect.width
	local var_8_17 = arg_8_0.content
	local var_8_18 = var_14.GetComponent

	typeof = var_17
	HorizontalLayoutGroup = var_1_10019

	local var_8_19 = var_8_18(var_8_17, var_17(var_1_10019)).padding.left
	local var_8_20 = var_14.spacing

	onButton = var_17

	local var_8_21 = arg_8_0
	local var_8_22 = var_8_1

	local function var_8_23()
		local var_10_0 = arg_8_0.viewParent

		var_0.ShowRecordGroup(var_10_0, var_8_0.id)

		return
	end

	SFX_PANEL = var_1_10022

	var_17(var_8_21, var_8_22, var_8_23, var_1_10022)

	return
end

function var_0_1.SwitchRecordFilter(arg_11_0, arg_11_1)
	if arg_11_1 == 1 then
		arg_11_0.recordFilterIndex = {
			true,
			true,
			true
		}
	else
		ipairs = var_1_10002

		for iter_11_0 in var_1_10002(arg_11_0.recordFilterIndex) do
			arg_11_0.recordFilterIndex[iter_11_0] = arg_11_1 - 1 == iter_11_0
		end
	end

	return
end

function var_0_1.RecordFilter(arg_12_0)
	table = var_1_10001

	var_1_10001.clear(arg_12_0.recordGroups)

	local var_12_0 = 0
	local var_12_1 = 0

	_ = var_3

	local var_12_2 = var_3.each

	pg = var_1_10005

	var_12_2(var_1_10005.world_collection_record_group.all, function(arg_13_0)
		pg = var_2_10001

		local var_13_0 = var_2_10001.world_collection_record_group[arg_13_0]

		_ = var_2_10002

		local var_13_1 = var_2_10002.reduce(var_13_0.child, 0, function(arg_14_0, arg_14_1)
			WorldCollectionProxy = var_3_10002

			if var_3_10002.GetCollectionTemplate(arg_14_1) then
				WorldMediaCollectionRecordDetailLayer = var_3_10003

				if var_3_10003.CheckRecordIsUnlock(var_2) then
					arg_14_0 = arg_14_0 + 1
				end
			end

			return arg_14_0
		end)

		var_12_0 = var_12_0 + #var_13_0.child
		var_12_1 = var_12_1 + var_13_1

		if arg_12_0.recordFilterIndex[var_13_0.type] then
			table = var_3

			var_3.insert(arg_12_0.recordGroups, var_13_0)
		end

		return
	end)

	setText = var_12_2

	var_12_2(arg_12_0.progressText, var_12_1 .. "/" .. var_12_0)

	table = var_12_2

	var_12_2.sort(arg_12_0.recordGroups, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)

	local var_12_3 = arg_12_0.scrollComp

	var_3.SetTotalCount(var_12_3, #arg_12_0.recordGroups)

	return
end

return var_0_1
