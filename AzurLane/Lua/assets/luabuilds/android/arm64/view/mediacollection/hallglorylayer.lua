local var_0_0 = class("HallGloryLayer", import(".WorldMediaCollectionSubLayer"))

var_0_0.type = 4

function var_0_0.getUIName(arg_1_0)
	return "HallGloryUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)

	arg_2_0.AD = arg_2_0._tf:Find("AD")
	arg_2_0.progress = arg_2_0.AD:Find("progress")
	arg_2_0.memoryGroupList = arg_2_0.AD:Find("ItemRect/Content"):GetComponent("LScrollRect")

	function arg_2_0.memoryGroupList.onInitItem(arg_3_0)
		arg_2_0:onInitMemoryGroup(arg_3_0)

		return
	end

	function arg_2_0.memoryGroupList.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:onUpdateMemoryGroup(arg_4_0 + 1, arg_4_1)

		return
	end

	arg_2_0.memoryGroups = _.map(pg.memory_group.all, function(arg_5_0)
		return pg.memory_group[arg_5_0]
	end)
	arg_2_0.memories = {}

	arg_2_0:MemoryFilter()

	arg_2_0.memoryItems = {}
	arg_2_0.loader = AutoLoader.New()

	setText(arg_2_0.AD:Find("progress/Text"), i18n("memory_filter_option_2"))

	return
end

function var_0_0.MemoryFilter(arg_6_0)
	table.clear(arg_6_0.memoryGroups)

	for iter_6_0, iter_6_1 in ipairs(pg.memory_group.all) do
		if pg.memory_group[iter_6_1].type == arg_6_0.type then
			table.insert(arg_6_0.memoryGroups, pg.memory_group[iter_6_1])
		end
	end

	arg_6_0.memories = _.map(arg_6_0.memoryGroups[1].memories, function(arg_7_0)
		return pg.memory_template[arg_7_0]
	end)
	arg_6_0.memoryGroupList.enabled = true

	arg_6_0.memoryGroupList:SetTotalCount(#arg_6_0.memories / 3, 0)

	arg_6_0.contextData.memoryGroup = arg_6_0.memoryGroups[1].id

	setText(arg_6_0.AD:Find("progress/num"), _.reduce(arg_6_0.memories, 0, function(arg_8_0, arg_8_1)
		if arg_8_1.is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(arg_8_1.unlock_pre, true) then
				arg_8_0 = arg_8_0 + 1
			end

			return arg_8_0
		end
	end) .. "/" .. #arg_6_0.memories)

	return
end

function var_0_0.onInitMemoryGroup(arg_9_0, arg_9_1)
	if arg_9_0.exited then
		return
	end

	for iter_9_0 = 1, 3 do
		local var_9_0 = tf(arg_9_1):Find("item_" .. iter_9_0)

		onButton(arg_9_0, var_9_0:Find("BG/play"), function()
			if arg_9_0.memoryItems[var_9_0] then
				if arg_9_0.memoryItems[var_9_0].is_open ~= 1 then
					if pg.NewStoryMgr.GetInstance():IsPlayed(arg_9_0.memoryItems[var_9_0].unlock_pre, true) then
						arg_9_0:PlayMemory(arg_9_0.memoryItems[var_9_0])
					end

					return
				end
			end
		end, SOUND_BACK)
	end

	return
end

function var_0_0.onUpdateMemoryGroup(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, 3 do
		local var_11_0 = tf(arg_11_2):Find("item_" .. iter_11_0)

		arg_11_0.memoryItems[var_11_0] = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0]

		local var_11_1 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].ship_group
		local var_11_3 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].title
		local var_11_4 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].condition
		local var_11_5 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].icon
		local var_11_6 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].year
		local var_11_7 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].is_open == 1 or pg.NewStoryMgr.GetInstance():IsPlayed(arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0].unlock_pre, true)
		local var_11_8 = ShipGroup.getDefaultShipConfig(var_11_1)

		setActive(var_11_0:Find("BG/lock"), not var_11_7)
		setActive(var_11_0:Find("BG/headline"), var_11_7)
		setActive(var_11_0:Find("BG/play"), var_11_7)

		if var_11_7 then
			setText(var_11_0:Find("name_bg/name"), var_11_8.name)
			setText(var_11_0:Find("BG/lock/Text"), var_11_4)
			setText(var_11_0:Find("wire/yer"), var_11_6)
			setText(var_11_0:Find("BG/headline/Text"), var_11_3)
		else
			setText(var_11_0:Find("name_bg/name"), var_11_8.name)
			setText(var_11_0:Find("BG/headline/Text"), var_11_3)
			setText(var_11_0:Find("wire/yer"), var_11_6)
		end

		setText(var_11_0:Find("BG/lock/Text"), var_11_4)
		LoadImageSpriteAsync("MemoryIcon/" .. var_11_5, var_11_0:Find("BG/bg/bg/icon"), true)
	end

	return
end

function var_0_0.SetStoryMask(arg_12_0, arg_12_1)
	arg_12_0.memoryMask = arg_12_1

	return
end

function var_0_0.PlayMemory(arg_13_0, arg_13_1)
	if arg_13_1.type == 1 then
		local var_13_0 = findTF(arg_13_0.memoryMask, "pic")

		if string.len(arg_13_1.mask) > 0 then
			setActive(var_13_0, true)

			var_13_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_13_1.mask)
		else
			setActive(var_13_0, false)
		end

		setActive(arg_13_0.memoryMask, true)
		pg.NewStoryMgr.GetInstance():Play(arg_13_1.story, function()
			setActive(arg_13_0.memoryMask, false)

			return
		end, true)
	elseif arg_13_1.type == 2 then
		local var_13_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_13_1.story)
		local var_13_2 = var_13_1 and var_13_1 ~= 0
		local var_13_3 = "Missing Story Stage ID: "
		local var_13_4 = arg_13_1.story or "NIL"

		assert(var_13_2, var_13_3 .. var_13_4)
		arg_13_0:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = var_13_1
		})
	end

	return
end

return var_0_0
