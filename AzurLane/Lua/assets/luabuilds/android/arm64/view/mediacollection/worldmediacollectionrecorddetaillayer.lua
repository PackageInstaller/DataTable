local var_0_0 = class("WorldMediaCollectionRecordDetailLayer", import(".WorldMediaCollectionSubLayer"))

var_0_0.TypeStory = 1
var_0_0.TypeBattle = 2

function var_0_0.getUIName(arg_1_0)
	return "WorldMediaCollectionMemoryDetailUI"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	assert(arg_2_0.viewParent, "Need assign ViewParent for " .. arg_2_0.__cname)
	setActive(arg_2_0._tf:Find("ItemRect/TitleRecord"), true)
	setActive(arg_2_0._tf:Find("ItemRect/TitleMemory"), false)

	arg_2_0.recordItemList = arg_2_0._tf:Find("ItemRect"):GetComponent("LScrollRect")

	function arg_2_0.recordItemList.onInitItem(arg_3_0)
		arg_2_0:OnInitRecordItem(arg_3_0)

		return
	end

	function arg_2_0.recordItemList.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateRecordItem(arg_4_0 + 1, arg_4_1)

		return
	end

	arg_2_0.recordItems = {}

	setActive(tf(arg_2_0.recordItemList):Find("Item"), false)

	arg_2_0.loader = AutoLoader.New()

	setText(arg_2_0._tf:Find("ItemRect/ProgressDesc"), i18n("world_collection_2"))

	return
end

function var_0_0.OnInitRecordItem(arg_5_0, arg_5_1)
	if arg_5_0.exited then
		return
	end

	onButton(arg_5_0, arg_5_1, function()
		local var_6_0 = nowWorld():GetCollectionProxy()

		if arg_5_0.recordItems[arg_5_1] and arg_5_0.CheckRecordIsUnlock(arg_5_0.recordItems[arg_5_1]) then
			arg_5_0:PlayMemory(arg_5_0.recordItems[arg_5_1])
		end

		return
	end, SOUND_BACK)

	return
end

function var_0_0.OnUpdateRecordItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.exited then
		return
	end

	local var_7_0 = arg_7_0.records

	if arg_7_0.records then
		var_7_0 = arg_7_0.records[arg_7_1]
	end

	local var_7_2 = arg_7_0.contextData.recordGroup or "NIL"

	var_7_1("Not Initialize RecordGroups ID: " .. var_7_2)

	arg_7_0.recordItems[arg_7_2] = var_7_0

	local var_7_3 = tf(arg_7_2)

	if arg_7_0.CheckRecordIsUnlock(var_7_0) then
		setActive(var_7_3:Find("normal"), true)
		setActive(var_7_3:Find("lock"), false)

		var_7_3:Find("normal/title"):GetComponent(typeof(Text)).text = var_7_0.name

		arg_7_0.loader:GetSpriteQuiet("memoryicon/" .. var_7_0.icon, "", var_7_3:Find("normal"))
		setText(var_7_3:Find("normal/id"), string.format("#%u", var_7_0.group_ID))
	else
		setActive(var_7_3:Find("normal"), false)
		setActive(var_7_3:Find("lock"), true)
		setText(var_7_3:Find("lock/condition"), var_7_0.condition)
	end

	onButton(arg_7_0, var_7_3, function()
		if not arg_7_0.CheckRecordIsUnlock(var_7_0) then
			return
		end

		arg_7_0:PlayMemory(var_7_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetStoryMask(arg_9_0, arg_9_1)
	arg_9_0.memoryMask = arg_9_1

	return
end

function var_0_0.PlayMemory(arg_10_0, arg_10_1)
	if arg_10_1.type == var_0_0.TypeBattle then
		arg_10_0:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_10_1.story)
		})
	else
		local var_10_0 = findTF(arg_10_0.memoryMask, "pic")

		if string.len(arg_10_1.mask) > 0 then
			setActive(var_10_0, true)

			var_10_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_10_1.mask)
		else
			setActive(var_10_0, false)
		end

		setActive(arg_10_0.memoryMask, true)
		pg.NewStoryMgr.GetInstance():Play(arg_10_1.story, function()
			setActive(arg_10_0.memoryMask, false)

			return
		end, true)
	end

	return
end

function var_0_0.ShowRecordGroup(arg_12_0, arg_12_1)
	arg_12_0.contextData.recordGroup = arg_12_1

	assert("Missing Record Group Config ID: " .. (arg_12_1 or "NIL"))

	arg_12_0.records = _.map(WorldCollectionProxy.GetCollectionRecordGroupTemplate(arg_12_1).child, function(arg_13_0)
		return WorldCollectionProxy.GetCollectionTemplate(arg_13_0)
	end)

	arg_12_0.recordItemList:SetTotalCount(#arg_12_0.records, 0)
	setText(arg_12_0._tf:Find("ItemRect/ProgressText"), _.reduce(arg_12_0.records, 0, function(arg_14_0, arg_14_1)
		if arg_12_0.CheckRecordIsUnlock(arg_14_1) then
			arg_14_0 = arg_14_0 + 1
		end

		return arg_14_0
	end) .. "/" .. #arg_12_0.records)

	return
end

function var_0_0.CheckRecordIsUnlock(arg_15_0)
	local var_15_0 = nowWorld():GetCollectionProxy():IsUnlock(arg_15_0.id)

	var_15_0 = var_15_0 or pg.NewStoryMgr.GetInstance():IsPlayed(arg_15_0.story, true)

	return var_15_0
end

function var_0_0.CleanList(arg_16_0)
	arg_16_0.records = nil

	arg_16_0.recordItemList:SetTotalCount(0)

	return
end

return var_0_0
