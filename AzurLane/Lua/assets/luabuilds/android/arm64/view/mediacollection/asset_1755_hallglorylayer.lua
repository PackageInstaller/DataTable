class = var_0_10000

local var_0_0 = "HallGloryLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WorldMediaCollectionSubLayer"))

var_0_1.type = 4

function var_0_1.getUIName(arg_1_0)
	return "HallGloryUI"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.AD = var_1.Find(var_2_0, "AD")

	local var_2_1 = arg_2_0.AD

	arg_2_0.progress = var_1.Find(var_2_1, "progress")

	local var_2_2 = arg_2_0.AD
	local var_2_3 = var_1.Find(var_2_2, "ItemRect/Content")

	arg_2_0.memoryGroupList = var_1.GetComponent(var_2_3, "LScrollRect")

	function arg_2_0.memoryGroupList.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.onInitMemoryGroup(var_3_0, arg_3_0)

		return
	end

	local var_2_4 = arg_2_0.memoryGroupList

	function var_2_4.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onUpdateMemoryGroup(var_4_0, arg_4_0 + 1, arg_4_1)

		return
	end

	_ = var_2_4

	local var_2_5 = var_2_4.map

	pg = var_2_3
	arg_2_0.memoryGroups = var_2_5(var_2_3.memory_group.all, function(arg_5_0)
		pg = var_2_10001

		return var_2_10001.memory_group[arg_5_0]
	end)
	arg_2_0.memories = {}

	arg_2_0:MemoryFilter()

	arg_2_0.memoryItems = {}
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()
	setText = var_1

	local var_2_6 = arg_2_0.AD
	local var_2_7 = var_3.Find(var_2_6, "progress/Text")

	i18n = var_4

	var_1(var_2_7, var_4("memory_filter_option_2"))

	return
end

function var_0_1.MemoryFilter(arg_6_0)
	table = var_1_10001

	var_1_10001.clear(arg_6_0.memoryGroups)

	ipairs = var_1
	pg = var_3

	for iter_6_0, iter_6_1 in var_1(var_3.memory_group.all) do
		pg = var_1_10006

		if var_1_10006.memory_group[iter_6_1].type == arg_6_0.type then
			table = var_7

			var_7.insert(arg_6_0.memoryGroups, var_1_10006)
		end
	end

	_ = var_1
	arg_6_0.memories = var_1.map(arg_6_0.memoryGroups[1].memories, function(arg_7_0)
		pg = var_2_10001

		return var_2_10001.memory_template[arg_7_0]
	end)
	arg_6_0.memoryGroupList.enabled = true

	local var_6_0 = arg_6_0.memoryGroupList

	var_1.SetTotalCount(var_6_0, #arg_6_0.memories / 3, 0)

	local var_6_1 = #arg_6_0.memories

	_ = var_2

	local var_6_2 = var_2.reduce(arg_6_0.memories, 0, function(arg_8_0, arg_8_1)
		if arg_8_1.is_open ~= 1 then
			pg = var_2

			local var_8_0 = var_2.NewStoryMgr.GetInstance()

			if var_2.IsPlayed(var_8_0, arg_8_1.unlock_pre, true) then
				arg_8_0 = arg_8_0 + 1
			end

			return arg_8_0
		end
	end)
	local var_6_3 = arg_6_0.contextData

	var_6_3.memoryGroup = arg_6_0.memoryGroups[1].id
	setText = var_6_3

	local var_6_4 = arg_6_0.AD

	var_6_3(var_5.Find(var_6_4, "progress/num"), var_6_2 .. "/" .. var_6_1)

	return
end

function var_0_1.onInitMemoryGroup(arg_9_0, arg_9_1)
	if arg_9_0.exited then
		return
	end

	for iter_9_0 = 1, 3 do
		tf = var_1_10006

		local var_9_0 = var_1_10006(arg_9_1)

		var_1_10006 = var_1_10006.Find(var_9_0, "item_" .. iter_9_0)
		onButton = var_1_10007

		local var_9_1 = arg_9_0
		local var_9_2 = var_1_10006
		local var_9_3 = var_1_10006.Find(var_9_2, "BG/play")

		local function var_9_4()
			if arg_9_0.memoryItems[var_1_10006] then
				if var_0.is_open ~= 1 then
					pg = var_1

					local var_10_0 = var_1.NewStoryMgr.GetInstance()

					if var_1.IsPlayed(var_10_0, var_0.unlock_pre, true) then
						local var_10_1 = arg_9_0

						var_1.PlayMemory(var_10_1, var_0)
					end

					return
				end
			end
		end

		SOUND_BACK = var_9_2

		var_1_10007(var_9_1, var_9_3, var_9_4, var_9_2)
	end

	return
end

function var_0_1.onUpdateMemoryGroup(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, 3 do
		local var_11_0 = arg_11_0.memories[(arg_11_1 - 1) * 3 + iter_11_0]

		tf = var_8

		local var_11_1 = var_8(arg_11_2)
		local var_11_2 = var_8.Find(var_11_1, "item_" .. iter_11_0)

		arg_11_0.memoryItems[var_11_2] = var_11_0

		local var_11_3 = var_11_0.ship_group
		local var_11_4 = var_11_0.title
		local var_11_5 = var_11_0.title
		local var_11_6 = var_11_0.condition
		local var_11_7 = var_11_0.icon
		local var_11_8 = var_11_0.year
		local var_11_9

		if var_11_0.is_open ~= 1 then
			pg = var_15
			var_1_10017 = var_15.NewStoryMgr.GetInstance()
			var_11_9 = var_15.IsPlayed(var_1_10017, var_11_0.unlock_pre, true)

			if false then
				var_11_9 = false
			end
		else
			var_11_9 = true
		end

		ShipGroup = var_1_10016
		var_1_10016 = var_1_10016.getDefaultShipConfig(var_11_3)
		setActive = var_1_10017

		var_1_10017(var_11_2:Find("BG/lock"), not var_11_9)

		setActive = var_1_10017

		var_1_10017(var_11_2:Find("BG/headline"), var_11_9)

		setActive = var_1_10017

		var_1_10017(var_11_2:Find("BG/play"), var_11_9)

		if var_11_9 then
			setText = var_1_10017

			var_1_10017(var_11_2:Find("name_bg/name"), var_1_10016.name)

			setText = var_1_10017

			var_1_10017(var_11_2:Find("BG/lock/Text"), var_11_6)

			setText = var_1_10017

			var_1_10017(var_11_2:Find("wire/yer"), var_11_8)

			setText = var_1_10017

			var_1_10017(var_11_2:Find("BG/headline/Text"), var_11_5)
		else
			setText = var_1_10017

			var_1_10017(var_11_2:Find("name_bg/name"), var_1_10016.name)

			setText = var_1_10017

			var_1_10017(var_11_2:Find("BG/headline/Text"), var_11_5)

			setText = var_1_10017

			var_1_10017(var_11_2:Find("wire/yer"), var_11_8)
		end

		setText = var_1_10017

		var_1_10017(var_11_2:Find("BG/lock/Text"), var_11_6)

		LoadImageSpriteAsync = var_1_10017

		var_1_10017("MemoryIcon/" .. var_11_7, var_11_2:Find("BG/bg/bg/icon"), true)
	end

	return
end

function var_0_1.SetStoryMask(arg_12_0, arg_12_1)
	arg_12_0.memoryMask = arg_12_1

	return
end

function var_0_1.PlayMemory(arg_13_0, arg_13_1)
	if arg_13_1.type == 1 then
		findTF = var_2

		local var_13_0 = var_2(arg_13_0.memoryMask, "pic")

		string = var_1_10003
		var_1_10003 = var_1_10003.len(arg_13_1.mask)

		if 0 < var_1_10003 then
			setActive = var_1_10003

			var_1_10003(var_13_0, true)

			local var_13_1 = var_13_0

			var_1_10003 = var_13_0.GetComponent
			typeof = var_6
			Image = var_1_10008
			var_1_10003 = var_1_10003(var_13_1, var_6(var_1_10008))
			LoadSprite = var_4
			var_1_10003.sprite = var_4(arg_13_1.mask)
		else
			setActive = var_1_10003

			var_1_10003(var_13_0, false)
		end

		setActive = var_1_10003

		var_1_10003(arg_13_0.memoryMask, true)

		pg = var_1_10003

		local var_13_2 = var_1_10003.NewStoryMgr.GetInstance()

		var_1_10003.Play(var_13_2, arg_13_1.story, function()
			setActive = var_2_10000

			var_2_10000(arg_13_0.memoryMask, false)

			return
		end, true)
	elseif arg_13_1.type == 2 then
		pg = var_2

		local var_13_3 = var_2.NewStoryMgr.GetInstance()
		local var_13_4 = var_2.StoryName2StoryId(var_13_3, arg_13_1.story)

		assert = var_1_10003

		local var_13_5 = var_13_4 and var_13_4 ~= 0
		local var_13_6 = "Missing Story Stage ID: "
		local var_13_7

		if not arg_13_1.story then
			var_13_7 = "NIL"
		end

		var_1_10003(var_13_5, var_13_6 .. var_13_7)

		local var_13_8 = arg_13_0
		local var_13_9 = arg_13_0.emit

		WorldMediaCollectionMediator = var_6

		local var_13_10 = var_6.BEGIN_STAGE
		local var_13_11 = {
			memory = true
		}

		SYSTEM_PERFORM = var_1_10008
		var_13_11.system = var_1_10008
		var_13_11.stageId = var_13_4

		var_13_9(var_13_8, var_13_10, var_13_11)
	end

	return
end

return var_0_1
