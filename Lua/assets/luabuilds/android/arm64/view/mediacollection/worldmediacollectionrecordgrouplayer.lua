local var_0_0 = class("WorldMediaCollectionRecordGroupLayer", import(".WorldMediaCollectionTemplateLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionRecordGroupUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.scroll = arg_2_0._tf:Find("ScrollRect")
	arg_2_0.scrollComp = arg_2_0.scroll:GetComponent("LScrollRect")

	setActive(arg_2_0.scroll:Find("Item"), false)

	arg_2_0.content = arg_2_0.scroll:Find("Viewport/Content")
	arg_2_0.progressText = arg_2_0.scroll:Find("ProgressText")
	arg_2_0.recordTogGroup = arg_2_0._tf:Find("Toggles")
	arg_2_0.recordToggles = {
		arg_2_0.recordTogGroup:Find("0"),
		arg_2_0.recordTogGroup:Find("1"),
		arg_2_0.recordTogGroup:Find("2"),
		arg_2_0.recordTogGroup:Find("3")
	}
	arg_2_0.recordFilterIndex = {
		false,
		false,
		false
	}

	_.each(pg.world_collection_record_group.all, function(arg_3_0)
		arg_2_0.recordFilterIndex[pg.world_collection_record_group[arg_3_0].type] = true

		return
	end)

	local var_2_0 = #arg_2_0.recordFilterIndex
	local var_2_1

	for iter_2_0 = 1, #arg_2_0.recordFilterIndex do
		setActive(arg_2_0.recordToggles[1 + iter_2_0], arg_2_0.recordFilterIndex[iter_2_0])

		if not arg_2_0.recordFilterIndex[iter_2_0] then
			var_2_0 = var_2_0 - 1
		else
			var_2_1 = var_2_1 or iter_2_0 + 1
		end
	end

	setActive(arg_2_0.recordToggles[1], var_2_0 > 1)

	var_2_1 = var_2_0 <= 1 and var_2_1 or 1

	local var_2_2 = arg_2_0.contextData.toggle or var_2_1

	arg_2_0.contextData.toggle = nil

	triggerToggle(arg_2_0.recordToggles[var_2_2], true)
	arg_2_0:SwitchRecordFilter(var_2_2)

	for iter_2_1, iter_2_2 in ipairs(arg_2_0.recordToggles) do
		onToggle(arg_2_0, iter_2_2, function(arg_4_0)
			if not arg_4_0 then
				return
			end

			arg_2_0:SwitchRecordFilter(iter_2_1)
			arg_2_0:RecordFilter()

			return
		end, SFX_UI_TAG)
	end

	function arg_2_0.scrollComp.onUpdateItem(arg_5_0, arg_5_1)
		arg_2_0:OnUpdateGroup(arg_5_0 + 1, arg_5_1)

		return
	end

	arg_2_0.recordGroups = {}

	arg_2_0:OverlayPanel(arg_2_0.recordTogGroup, {
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})

	arg_2_0.loader = AutoLoader.New()

	setText(arg_2_0.scroll:Find("ProgressDesc"), i18n("world_collection_3"))

	return
end

function var_0_0.Show(arg_6_0)
	var_0_0.super.Show(arg_6_0)
	setActive(arg_6_0.recordTogGroup, true)

	return
end

function var_0_0.Hide(arg_7_0)
	LeanTween.cancel(go(arg_7_0.content))
	arg_7_0.scrollComp:SetDraggingStatus(false)
	arg_7_0.scrollComp:StopMovement()

	arg_7_0.scrolling = false

	var_0_0.super.Hide(arg_7_0)
	setActive(arg_7_0.recordTogGroup, false)
	var_0_0.super.Hide(arg_7_0)

	return
end

local var_0_1 = {
	"img_zhuxian",
	"img_zhixian",
	"img_shoujijilu"
}

function var_0_0.OnUpdateGroup(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.exited then
		return
	end

	local var_8_0 = arg_8_0.recordGroups[arg_8_1]

	assert(arg_8_0.recordGroups[arg_8_1], "Not Initialize FileGroup Index " .. arg_8_1)

	local var_8_1 = tf(arg_8_2)

	setText(var_8_1:Find("FileIndex"), var_8_0.id)

	local var_8_2 = var_8_1:Find("NameRect/FileName1")
	local var_8_3 = GetPerceptualSize(var_8_0.name_abbreviate)
	local var_8_5 = var_8_2:GetComponent(typeof(Text))

	var_8_5.fontSize = var_8_3 <= 4 and 32 or var_8_3 <= 6 and 28 or 24
	var_8_5.text = var_8_0.name_abbreviate

	arg_8_0.loader:GetSprite("ui/WorldMediaCollectionRecordUI_atlas", var_0_1[var_8_0.type], var_8_1:Find("BG"))

	local var_8_6 = nowWorld():GetCollectionProxy()

	setText(var_8_1:Find("FileProgress"), _.reduce(var_8_0.child, 0, function(arg_9_0, arg_9_1)
		local var_9_0 = WorldCollectionProxy.GetCollectionTemplate(arg_9_1)

		if var_9_0 and WorldMediaCollectionRecordDetailLayer.CheckRecordIsUnlock(var_9_0) then
			arg_9_0 = arg_9_0 + 1
		end

		return arg_9_0
	end) .. "/" .. #var_8_0.child)

	local var_8_8 = arg_8_0.scroll:Find("Item").rect.width
	local var_8_9 = arg_8_0.content:GetComponent(typeof(HorizontalLayoutGroup))

	onButton(arg_8_0, var_8_1, function()
		arg_8_0.viewParent:ShowRecordGroup(var_8_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SwitchRecordFilter(arg_11_0, arg_11_1)
	if arg_11_1 == 1 then
		arg_11_0.recordFilterIndex = {
			true,
			true,
			true
		}
	else
		for iter_11_0 in ipairs(arg_11_0.recordFilterIndex) do
			arg_11_0.recordFilterIndex[iter_11_0] = arg_11_1 - 1 == iter_11_0
		end
	end

	return
end

function var_0_0.RecordFilter(arg_12_0)
	table.clear(arg_12_0.recordGroups)

	local var_12_0 = 0
	local var_12_1 = 0

	_.each(pg.world_collection_record_group.all, function(arg_13_0)
		var_12_0 = var_12_0 + #pg.world_collection_record_group[arg_13_0].child
		var_12_1 = var_12_1 + _.reduce(pg.world_collection_record_group[arg_13_0].child, 0, function(arg_14_0, arg_14_1)
			local var_14_0 = WorldCollectionProxy.GetCollectionTemplate(arg_14_1)

			if var_14_0 and WorldMediaCollectionRecordDetailLayer.CheckRecordIsUnlock(var_14_0) then
				arg_14_0 = arg_14_0 + 1
			end

			return arg_14_0
		end)

		if arg_12_0.recordFilterIndex[pg.world_collection_record_group[arg_13_0].type] then
			table.insert(arg_12_0.recordGroups, pg.world_collection_record_group[arg_13_0])
		end

		return
	end)
	setText(arg_12_0.progressText, 0 .. "/" .. 0)
	table.sort(arg_12_0.recordGroups, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)
	arg_12_0.scrollComp:SetTotalCount(#arg_12_0.recordGroups)

	return
end

return var_0_0
