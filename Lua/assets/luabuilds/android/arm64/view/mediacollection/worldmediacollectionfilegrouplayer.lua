local var_0_0 = class("WorldMediaCollectionFileGroupLayer", import(".WorldMediaCollectionSubLayer"))

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionFileGroupUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.scroll = arg_2_0._tf:Find("ScrollRect")
	arg_2_0.scrollComp = arg_2_0.scroll:GetComponent("LScrollRect")

	setActive(arg_2_0.scroll:Find("Item"), false)

	arg_2_0.content = arg_2_0.scroll:Find("Viewport/Content")
	arg_2_0.progressText = arg_2_0.scroll:Find("ProgressText")
	arg_2_0.emptyTip = arg_2_0._tf:Find("EmptyTip")
	arg_2_0.fileGroups = {}

	function arg_2_0.scrollComp.onUpdateItem(arg_3_0, ...)
		arg_2_0:OnUpdateFileGroup(arg_3_0 + 1, ...)

		return
	end

	arg_2_0.scrolling = false
	arg_2_0.blurFlag = nil

	setText(arg_2_0.scroll:Find("ProgressDesc"), i18n("world_collection_3"))

	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.UpdateGroupList(arg_4_0)
	local var_4_0 = nowWorld():GetCollectionProxy()

	table.clear(arg_4_0.fileGroups)

	local var_4_1 = 0
	local var_4_2 = 0

	_.each(pg.world_collection_file_group.all, function(arg_5_0)
		local var_5_0 = _.reduce(pg.world_collection_file_group[arg_5_0].child, 0, function(arg_6_0, arg_6_1)
			if var_4_0:IsUnlock(arg_6_1) then
				arg_6_0 = arg_6_0 + 1
			end

			return arg_6_0
		end)

		if var_5_0 > 0 then
			table.insert(arg_4_0.fileGroups, pg.world_collection_file_group[arg_5_0])
		end

		var_4_1 = var_4_1 + #pg.world_collection_file_group[arg_5_0].child
		var_4_2 = var_4_2 + var_5_0

		return
	end)

	local var_4_3 = #arg_4_0.fileGroups == 0

	setActive(arg_4_0.emptyTip, #arg_4_0.fileGroups == 0)

	if var_4_3 then
		arg_4_0:BlurTip()
	else
		arg_4_0:UnBlurTip()
	end

	setActive(arg_4_0.scroll, not var_4_3)
	arg_4_0.scrollComp:SetTotalCount(#arg_4_0.fileGroups)
	setText(arg_4_0.progressText, var_4_2 .. "/" .. var_4_1)

	return
end

function var_0_0.BlurTip(arg_7_0)
	arg_7_0:OverlayPanel(arg_7_0.emptyTip, {
		groupDelta = -1,
		pbList = {
			arg_7_0.emptyTip:Find("EmptyTip")
		}
	})
	arg_7_0.emptyTip:SetSiblingIndex(0)

	arg_7_0.blurFlag = true

	return
end

function var_0_0.UnBlurTip(arg_8_0)
	if arg_8_0.blurFlag then
		arg_8_0:UnOverlayPanel(arg_8_0.emptyTip, arg_8_0._tf)
	end

	arg_8_0.blurFlag = nil

	return
end

function var_0_0.Show(arg_9_0)
	var_0_0.super.Show(arg_9_0)

	if arg_9_0.blurFlag then
		arg_9_0:BlurTip()
	end

	return
end

function var_0_0.Hide(arg_10_0)
	LeanTween.cancel(go(arg_10_0.content))
	arg_10_0.scrollComp:SetDraggingStatus(false)
	arg_10_0.scrollComp:StopMovement()

	arg_10_0.scrolling = false

	arg_10_0:UnBlurTip()
	var_0_0.super.Hide(arg_10_0)

	return
end

function var_0_0.OnUpdateFileGroup(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.exited then
		return
	end

	local var_11_0 = arg_11_0.fileGroups[arg_11_1]

	assert(arg_11_0.fileGroups[arg_11_1], "Not Initialize FileGroup Index " .. arg_11_1)

	local var_11_1 = tf(arg_11_2)

	setText(var_11_1:Find("FileIndex"), var_11_0.id_2)
	arg_11_0.loader:GetSprite("ui/WorldMediaCollectionFileUI_atlas", var_11_0.type, var_11_1:Find("BG"))
	arg_11_0.loader:GetSprite("CollectionFileTitle/" .. var_11_0.name_abbreviate, "", var_11_1:Find("FileTitle"), true)

	local var_11_2 = nowWorld():GetCollectionProxy()
	local var_11_3 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0.child) do
		if var_11_2:IsUnlock(iter_11_1) then
			var_11_3 = var_11_3 + 1
		end
	end

	setText(var_11_1:Find("FileProgress"), var_11_3 .. "/" .. #var_11_0.child)

	local var_11_5 = arg_11_0.scroll:Find("Item").rect.width
	local var_11_6 = arg_11_0.content:GetComponent(typeof(HorizontalLayoutGroup))

	onButton(arg_11_0, var_11_1, function()
		arg_11_0.viewParent:OpenDetailLayer(var_11_0.id, true)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
