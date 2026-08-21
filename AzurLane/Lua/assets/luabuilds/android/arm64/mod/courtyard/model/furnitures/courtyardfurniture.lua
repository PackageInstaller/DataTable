local var_0_0 = class("CourtYardFurniture", import("..map.CourtYardDepthItem"))

var_0_0.STATE_IDLE = 1
var_0_0.STATE_DRAG = 2
var_0_0.STATE_INTERACT = 3
var_0_0.STATE_TOUCH_PREPARE = 4
var_0_0.STATE_TOUCH = 5
var_0_0.STATE_PLAY_MUSIC = 6
var_0_0.STATE_STOP_MUSIC = 7

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id
	arg_1_0.configId = arg_1_2.configId or arg_1_0.id
	arg_1_0.config = pg.furniture_data_template[arg_1_0.configId]

	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_0.id, arg_1_0.config.size[1], arg_1_0.config.size[2])

	arg_1_0.date = arg_1_2.date or 0
	arg_1_0.selectedFlag = false
	arg_1_0.slots = {}

	arg_1_0:InitSlots()

	arg_1_0.musicDatas = {}
	arg_1_0.musicData = nil

	arg_1_0:InitMusicData()

	arg_1_0.state = var_0_0.STATE_IDLE

	return
end

function var_0_0.InitSlots(arg_2_0)
	if arg_2_0:IsSpine() then
		table.insert(arg_2_0.slots, CourtYardFurnitureSpineSlot.New(1, arg_2_0.config.spine, arg_2_0.config.spine_combine_action_replace, arg_2_0.host))

		if type(arg_2_0.config.spine_extra) == "table" then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.config.spine_extra) do
				table.insert(arg_2_0.slots, CourtYardFurnitureSpineSlot.New(iter_2_0 + 1, {
					{},
					[3] = arg_2_0.config.spine[3],
					[4] = iter_2_1[1],
					[5] = iter_2_1[2],
					[6] = iter_2_1[3]
				}, arg_2_0.config.spine_combine_action_replace, arg_2_0.host))
			end
		end

		if type(arg_2_0.config.followBone) == "table" then
			if type(arg_2_0.config.followBone[1]) == "table" then
				for iter_2_2, iter_2_3 in ipairs(arg_2_0.config.followBone) do
					if arg_2_0.slots[iter_2_2] then
						arg_2_0.slots[iter_2_2]:SetFollower(iter_2_3)
					end
				end
			elseif type(arg_2_0.config.followBone[1]) == "string" then
				arg_2_0.slots[1]:SetFollower(arg_2_0.config.followBone)
			end
		elseif type(arg_2_0.config.animator) == "table" then
			for iter_2_4, iter_2_5 in ipairs(arg_2_0.slots) do
				iter_2_5:SetAnimators(arg_2_0.config.animator)
			end
		end

		if type(arg_2_0.config.spine_action_replace) == "table" then
			for iter_2_6, iter_2_7 in ipairs(arg_2_0.slots) do
				iter_2_7:SetSubstitute(arg_2_0.config.spine_action_replace)
			end
		end
	elseif type(arg_2_0.config.interAction) == "table" then
		for iter_2_8, iter_2_9 in ipairs(arg_2_0.config.interAction) do
			table.insert(arg_2_0.slots, CourtYardFurnitureSlot.New(iter_2_8, iter_2_9, arg_2_0.config.spine_combine_action_replace, arg_2_0.host))
		end
	end

	return
end

function var_0_0.GetLevel(arg_3_0)
	return arg_3_0.config.level
end

function var_0_0._InitMusicData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = type(arg_4_3) == "table" and arg_4_3 or {
		arg_4_3
	}

	for iter_4_0, iter_4_1 in ipairs(type(arg_4_2) == "table" and arg_4_2 or {
		arg_4_2
	}) do
		table.insert(arg_4_0.musicDatas, {
			voice = iter_4_1,
			voiceType = arg_4_1,
			action = var_4_0[iter_4_0],
			effect = arg_4_4
		})
	end

	return
end

function var_0_0.InitMusicData(arg_5_0)
	if arg_5_0.config.can_trigger[1] == 3 then
		arg_5_0:_InitMusicData(1, arg_5_0.config.can_trigger[2][1], arg_5_0.config.can_trigger[2][2], arg_5_0.config.can_trigger[2][3])
		arg_5_0:_InitMusicData(2, arg_5_0.config.can_trigger[3][1], arg_5_0.config.can_trigger[3][2], arg_5_0.config.can_trigger[3][3])
	else
		arg_5_0:_InitMusicData(arg_5_0.config.can_trigger[1], arg_5_0.config.can_trigger[2], arg_5_0.config.can_trigger[3], arg_5_0.config.can_trigger[4])
	end

	return
end

function var_0_0.Init(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:SetPosition(arg_6_1)
	arg_6_0:SetDir(arg_6_2)

	return
end

function var_0_0.DisableRotation(arg_7_0)
	return arg_7_0.config.can_rotate ~= 0 or arg_7_0:IsType(Furniture.TYPE_WALL) or arg_7_0:IsType(Furniture.TYPE_WALL_MAT)
end

function var_0_0.IsType(arg_8_0, arg_8_1)
	return arg_8_0.config.type == arg_8_1
end

function var_0_0.IsMusicalInstruments(arg_9_0)
	return arg_9_0:IsType(Furniture.TYPE_LUTE)
end

function var_0_0.IsRandomSlotType(arg_10_0)
	return arg_10_0:IsType(Furniture.TYPE_RANDOM_SLOT)
end

function var_0_0.RawGetOffset(arg_11_0)
	return Vector3(arg_11_0.config.offset[1], arg_11_0.config.offset[2], 0)
end

function var_0_0.SetPosition(arg_12_0, arg_12_1)
	var_0_0.super.SetPosition(arg_12_0, arg_12_1)
	arg_12_0:DispatchEvent(CourtYardEvent.FURNITURE_POSITION_CHANGE, arg_12_1, arg_12_0:GetOffset())

	return
end

function var_0_0.UpdateOpFlag(arg_13_0, arg_13_1)
	var_0_0.super.UpdateOpFlag(arg_13_0, arg_13_1)
	arg_13_0:DispatchEvent(CourtYardEvent.FURNITURE_OP_FLAG_CHANGE, arg_13_0.opFlag)

	return
end

function var_0_0.InActivityRange(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetHost():GetStorey():GetRange()

	return arg_14_1.x < var_14_0.x and arg_14_1.y < var_14_0.y and arg_14_1.x >= 0 and arg_14_1.y >= 0
end

function var_0_0.GetObjType(arg_15_0)
	return CourtYardConst.OBJ_TYPE_COMMOM
end

function var_0_0.GetDeathType(arg_16_0)
	return CourtYardConst.DEPTH_TYPE_FURNITURE
end

function var_0_0.GetType(arg_17_0)
	return arg_17_0.config.type
end

function var_0_0.GetPicture(arg_18_0)
	return arg_18_0.config.picture
end

function var_0_0.IsOverlap(arg_19_0, arg_19_1)
	return _.any(arg_19_0:GetArea(), function(arg_20_0)
		return arg_20_0 == arg_19_1
	end)
end

function var_0_0.Rotate(arg_21_0)
	var_0_0.super.SetDir(arg_21_0, arg_21_0.dir == 1 and 2 or 1)
	arg_21_0:DispatchEvent(CourtYardEvent.ROTATE_FURNITURE, arg_21_0.dir)

	return
end

function var_0_0.GetSize(arg_22_0)
	return arg_22_0.sizeX, arg_22_0.sizeY
end

function var_0_0.GetArchMask(arg_23_0)
	return arg_23_0.config.picture .. "_using"
end

function var_0_0.HasDescription(arg_24_0)
	local var_24_0 = arg_24_0.config.can_trigger

	return #arg_24_0.config.can_trigger > 0 and var_24_0[1] > 0
end

function var_0_0.ExistVoice(arg_25_0)
	return arg_25_0.config.can_trigger[2] ~= nil, arg_25_0.config.can_trigger[1]
end

function var_0_0.GetIcon(arg_26_0)
	return arg_26_0.config.icon
end

function var_0_0.GetName(arg_27_0)
	return arg_27_0.config.name
end

function var_0_0.GetAddDate(arg_28_0)
	if arg_28_0.date > 0 then
		return pg.TimeMgr.GetInstance():STimeDescS(arg_28_0.date, "%Y/%m/%d")
	end

	return
end

function var_0_0.GetComfortable(arg_29_0)
	return arg_29_0.config.comfortable
end

function var_0_0.GetDescription(arg_30_0)
	return arg_30_0.config.describe
end

function var_0_0.GetAddMode(arg_31_0)
	return arg_31_0.config.gain_by
end

function var_0_0.GetGametipType(arg_32_0)
	return ({
		i18n("word_wallpaper"),
		i18n("word_furniture"),
		i18n("word_decorate"),
		i18n("word_floorpaper"),
		i18n("word_mat"),
		i18n("word_wall"),
		i18n("word_collection"),
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		i18n("word_collection")
	})[arg_32_0:GetType()]
end

function var_0_0.CanTouch(arg_33_0)
	return arg_33_0.config.spine and arg_33_0.config.spine[1] and arg_33_0.config.spine[1][3] ~= nil
end

function var_0_0.GetTouchAction(arg_34_0)
	if arg_34_0:CanTouch() then
		table.insert({}, arg_34_0.config.spine[1][3][1])

		local var_34_0 = arg_34_0.config.spine[1][3][3] or {}

		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			table.insert({}, iter_34_1)
		end

		return ({})[math.random(1, #{})], arg_34_0.config.spine[1][3][2]
	end

	return
end

function var_0_0.GetTouchPrepareAction(arg_35_0)
	if arg_35_0:CanTouch() then
		return arg_35_0.config.spine[1][3][6]
	end

	return
end

function var_0_0.GetTouchBg(arg_36_0)
	if arg_36_0:CanTouch() then
		return arg_36_0.config.spine[1][3][7]
	end

	return
end

function var_0_0.TriggerTouchDefault(arg_37_0)
	if arg_37_0:CanTouch() and arg_37_0.config.spine[1][3][8] and arg_37_0.config.spine[1][3][8] > 0 then
		return true
	end

	return false
end

function var_0_0.GetTouchSound(arg_38_0)
	if arg_38_0:CanTouch() then
		if type(arg_38_0.config.spine[1][3][4]) == "table" then
			return arg_38_0.config.spine[1][3][4][math.random(1, #arg_38_0.config.spine[1][3][4])]
		else
			return arg_38_0.config.spine[1][3][4]
		end
	end

	return
end

function var_0_0.GetTouchEffect(arg_39_0)
	if arg_39_0:CanTouch() then
		return arg_39_0.config.spine[1][3][5]
	end

	return
end

function var_0_0.IsTouchState(arg_40_0)
	return arg_40_0.state == var_0_0.STATE_TOUCH or arg_40_0.state == var_0_0.STATE_TOUCH_PREPARE
end

function var_0_0.IsDragingState(arg_41_0)
	return arg_41_0.state == var_0_0.STATE_DRAG
end

function var_0_0.IsSpine(arg_42_0)
	return type(arg_42_0.config.spine) == "table"
end

function var_0_0.GetFirstSlot(arg_43_0)
	return arg_43_0.slots[1]
end

function var_0_0.AnySlotIsLoop(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.slots) do
		if iter_44_1.loop then
			return true
		end
	end

	return false
end

function var_0_0.GetMaskNames(arg_45_0)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0.slots) do
		local var_45_0 = iter_45_1:GetMask()

		if var_45_0 then
			({})[iter_45_1.id] = var_45_0
		end
	end

	return {}
end

function var_0_0.IsMultiMask(arg_46_0)
	local var_46_0 = arg_46_0:GetMaskNames()

	return not arg_46_0:IsSpine() and table.getCount(var_46_0) > 0 and arg_46_0:GetSlotCnt() > 1
end

function var_0_0.GetBodyMasks(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0.slots) do
		local var_47_0 = iter_47_1:GetBodyMask()

		if var_47_0 then
			({})[iter_47_1.id] = var_47_0
		end
	end

	return {}
end

function var_0_0.GetAnimators(arg_48_0)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0.slots) do
		for iter_48_2, iter_48_3 in pairs(iter_48_1:GetAnimators()) do
			table.insert({}, iter_48_3)
		end
	end

	return {}
end

function var_0_0.GetAnimatorMask(arg_49_0)
	if not arg_49_0.config.animator then
		return nil
	end

	local var_49_0 = arg_49_0.config.animator[3]

	if arg_49_0.config.animator[3] then
		return {
			size = Vector2(var_49_0[1][1], var_49_0[1][2]),
			offset = Vector2(var_49_0[2][1], var_49_0[2][2])
		}
	end

	return
end

function var_0_0.CanInterAction(arg_50_0, arg_50_1)
	return _.any(arg_50_0.slots, function(arg_51_0)
		return arg_51_0:IsEmpty()
	end) and not arg_50_0:IsPlayMusicState() and (#arg_50_0.config.interAction_group == 0 or _.any(arg_50_0.config.interAction_group, function(arg_52_0)
		return arg_50_1:GetGroupID() == arg_52_0
	end))
end

function var_0_0.IsPlayMusicState(arg_53_0)
	return arg_53_0.state == var_0_0.STATE_PLAY_MUSIC
end

function var_0_0.GetInteractionSlot(arg_54_0)
	if arg_54_0:IsRandomSlotType() then
		for iter_54_0, iter_54_1 in ipairs(arg_54_0.slots) do
			if iter_54_1:IsEmpty() then
				table.insert({}, iter_54_1)
			end
		end

		return ({})[math.random(1, #{})]
	else
		return _.detect(arg_54_0.slots, function(arg_55_0)
			return arg_55_0:IsEmpty()
		end)
	end

	return
end

function var_0_0._ChangeState(arg_56_0, arg_56_1)
	arg_56_0.state = arg_56_1

	arg_56_0:DispatchEvent(CourtYardEvent.FURNITURE_STATE_CHANGE, arg_56_1)

	return
end

function var_0_0.ChangeState(arg_57_0, arg_57_1)
	if arg_57_0:IsPlayMusicState() and arg_57_1 ~= var_0_0.STATE_STOP_MUSIC then
		return
	end

	if arg_57_0:IsInteractionState() then
		return
	end

	if arg_57_1 == var_0_0.STATE_TOUCH and arg_57_0:GetTouchPrepareAction() then
		arg_57_0:_ChangeState(var_0_0.STATE_TOUCH_PREPARE)
	elseif arg_57_1 == var_0_0.STATE_PLAY_MUSIC then
		local var_57_0 = _.select(arg_57_0.musicDatas, function(arg_58_0)
			return arg_58_0.voiceType == 2
		end)

		if #var_57_0 > 0 then
			arg_57_0.musicData = var_57_0[math.random(1, #var_57_0)]

			arg_57_0:_ChangeState(arg_57_1)
		end
	elseif arg_57_1 == var_0_0.STATE_STOP_MUSIC then
		arg_57_0:_ChangeState(var_0_0.STATE_IDLE)

		arg_57_0.musicData = nil
	else
		arg_57_0:_ChangeState(arg_57_1)
	end

	return
end

function var_0_0.IsInteractionState(arg_59_0)
	return arg_59_0.state == var_0_0.STATE_INTERACT
end

function var_0_0.WillInteraction(arg_60_0, arg_60_1)
	arg_60_0:DispatchEvent(CourtYardEvent.FURNITURE_WILL_INTERACTION, arg_60_1)

	return
end

function var_0_0.StartInteraction(arg_61_0, arg_61_1)
	local var_61_0 = {}

	_.each(arg_61_0.slots, function(arg_62_0)
		if arg_62_0.id ~= arg_61_1.id and arg_62_0:IsUsing() then
			table.insert(var_61_0, arg_62_0)
			arg_61_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_62_0)
		end

		return
	end)

	if #{} > 0 then
		arg_61_0:_ChangeState(var_0_0.STATE_IDLE)
	end

	arg_61_0:_ChangeState(var_0_0.STATE_INTERACT)

	if #{} > 0 then
		arg_61_1:OnStart()
	end

	for iter_61_0, iter_61_1 in ipairs({}) do
		iter_61_1:OnStart()
		arg_61_0:DispatchEvent(CourtYardEvent.FURNITURE_START_INTERACTION, iter_61_1)
	end

	arg_61_0:DispatchEvent(CourtYardEvent.FURNITURE_START_INTERACTION, arg_61_1)

	return
end

function var_0_0.OnPreheatActionEnd(arg_63_0)
	return
end

function var_0_0.UpdateInteraction(arg_64_0, ...)
	arg_64_0:DispatchEvent(CourtYardEvent.FURNITURE_UPDATE_INTERACTION, ...)

	return
end

function var_0_0.AnySlotIsUsing(arg_65_0)
	return _.any(arg_65_0.slots, function(arg_66_0)
		return arg_66_0:IsUsing()
	end)
end

function var_0_0.ClearInteraction(arg_67_0, arg_67_1)
	local var_67_0 = _.select(arg_67_0.slots, function(arg_68_0)
		return arg_68_0.id ~= arg_67_1.id and arg_68_0:IsUsing()
	end)

	for iter_67_0, iter_67_1 in ipairs(var_67_0) do
		iter_67_1:Reset()
	end

	if #var_67_0 <= 0 then
		arg_67_0:_ChangeState(var_0_0.STATE_IDLE)
	end

	onNextTick(function()
		arg_67_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_67_1)

		return
	end)

	return
end

function var_0_0.RefreshState(arg_70_0)
	local var_70_0 = _.select(arg_70_0.slots, function(arg_71_0)
		return arg_71_0:IsUsing()
	end)

	if #var_70_0 <= 0 then
		arg_70_0:_ChangeState(var_0_0.STATE_IDLE)
	else
		for iter_70_0, iter_70_1 in ipairs(var_70_0) do
			iter_70_1:OnStart()
		end
	end

	return
end

function var_0_0.GetUsingSlots(arg_72_0)
	for iter_72_0, iter_72_1 in ipairs(arg_72_0.slots) do
		if iter_72_1:IsUsing() then
			table.insert({}, iter_72_1)
		end
	end

	return {}
end

function var_0_0.GetSlotCnt(arg_73_0)
	return #arg_73_0.slots
end

function var_0_0.GetMusicData(arg_74_0)
	return arg_74_0.musicData
end

function var_0_0.GetInterActionBgm(arg_75_0)
	local var_75_0 = type(arg_75_0.config.interaction_bgm)

	if var_75_0 == "string" then
		return arg_75_0.config.interaction_bgm, 0
	elseif var_75_0 == "table" then
		return arg_75_0.config.interaction_bgm[2], arg_75_0.config.interaction_bgm[1]
	else
		return nil
	end

	return
end

function var_0_0.CanClickWhenExitEditMode(arg_76_0)
	return arg_76_0:HasDescription() or arg_76_0:CanTouch()
end

function var_0_0.Dispose(arg_77_0)
	var_0_0.super.Dispose(arg_77_0)

	for iter_77_0, iter_77_1 in ipairs(arg_77_0:GetUsingSlots()) do
		iter_77_1:Stop()
	end

	return
end

function var_0_0.ToTable(arg_78_0)
	local var_78_0 = arg_78_0:GetPosition()
	local var_78_1 = {
		id = arg_78_0.id,
		configId = arg_78_0.configId,
		dir = arg_78_0.dir,
		position = var_78_0,
		x = var_78_0.x,
		y = var_78_0.y
	}

	if arg_78_0.parent then
		var_78_1.parent = arg_78_0.parent.id or 0
		var_78_1.child = {}

		return var_78_1
	end
end

return var_0_0
