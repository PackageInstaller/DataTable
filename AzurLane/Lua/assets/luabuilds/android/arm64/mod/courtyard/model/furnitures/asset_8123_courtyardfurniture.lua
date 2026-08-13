class = var_0_10000

local var_0_0 = "CourtYardFurniture"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..map.CourtYardDepthItem"))

var_0_1.STATE_IDLE = 1
var_0_1.STATE_DRAG = 2
var_0_1.STATE_INTERACT = 3
var_0_1.STATE_TOUCH_PREPARE = 4
var_0_1.STATE_TOUCH = 5
var_0_1.STATE_PLAY_MUSIC = 6
var_0_1.STATE_STOP_MUSIC = 7

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id

	local var_1_0

	if not arg_1_2.configId then
		var_1_0 = arg_1_0.id
	end

	arg_1_0.configId = var_1_0
	pg = var_1_0
	arg_1_0.config = var_1_0.furniture_data_template[arg_1_0.configId]

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_0.id, arg_1_0.config.size[1], arg_1_0.config.size[2])

	local var_1_1

	if not arg_1_2.date then
		var_1_1 = 0
	end

	arg_1_0.date = var_1_1
	arg_1_0.selectedFlag = false
	arg_1_0.slots = {}

	arg_1_0:InitSlots()

	arg_1_0.musicDatas = {}
	arg_1_0.musicData = nil

	arg_1_0:InitMusicData()

	arg_1_0.state = var_0_1.STATE_IDLE

	return
end

function var_0_1.InitSlots(arg_2_0)
	local var_2_0

	if arg_2_0:IsSpine() then
		table = var_2_0
		var_2_0 = var_2_0.insert

		local var_2_1 = arg_2_0.slots

		CourtYardFurnitureSpineSlot = var_1_10004

		var_2_0(var_2_1, var_1_10004.New(1, arg_2_0.config.spine, arg_2_0.config.spine_combine_action_replace, arg_2_0.host))

		type = var_2_0

		if var_2_0(arg_2_0.config.spine_extra) == "table" then
			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(arg_2_0.config.spine_extra) do
				var_1_10006 = {
					{},
					[3] = arg_2_0.config.spine[3],
					[4] = iter_2_1[1],
					[5] = iter_2_1[2],
					[6] = iter_2_1[3]
				}
				table = var_7

				local var_2_2 = var_7.insert

				var_1_10009 = arg_2_0.slots
				CourtYardFurnitureSpineSlot = var_1_10010

				var_2_2(var_1_10009, var_1_10010.New(iter_2_0 + 1, var_1_10006, arg_2_0.config.spine_combine_action_replace, arg_2_0.host))
			end
		end

		type = var_2_0

		if var_2_0(arg_2_0.config.followBone) == "table" then
			type = var_2_0

			if var_2_0(arg_2_0.config.followBone[1]) == "table" then
				ipairs = var_2_0

				for iter_2_2, iter_2_3 in var_2_0(arg_2_0.config.followBone) do
					if arg_2_0.slots[iter_2_2] then
						var_1_10009 = var_1_10006

						var_1_10006.SetFollower(var_1_10009, iter_2_3)
					end
				end
			else
				type = var_2_0

				if var_2_0(arg_2_0.config.followBone[1]) == "string" then
					local var_2_3 = arg_2_0.slots[1]

					var_2_0.SetFollower(var_2_3, arg_2_0.config.followBone)
				end
			end
		else
			type = var_2_0

			if var_2_0(arg_2_0.config.animator) == "table" then
				ipairs = var_2_0

				for iter_2_4, iter_2_5 in var_2_0(arg_2_0.slots) do
					iter_2_5:SetAnimators(arg_2_0.config.animator)
				end
			end
		end

		type = var_2_0

		if var_2_0(arg_2_0.config.spine_action_replace) == "table" then
			ipairs = var_2_0

			for iter_2_6, iter_2_7 in var_2_0(arg_2_0.slots) do
				iter_2_7:SetSubstitute(arg_2_0.config.spine_action_replace)
			end
		end
	else
		type = var_2_0

		if var_2_0(arg_2_0.config.interAction) == "table" then
			ipairs = var_1

			for iter_2_8, iter_2_9 in var_1(arg_2_0.config.interAction) do
				table = var_1_10006
				var_1_10006 = var_1_10006.insert

				local var_2_4 = arg_2_0.slots

				CourtYardFurnitureSlot = var_1_10009

				var_1_10006(var_2_4, var_1_10009.New(iter_2_8, iter_2_9, arg_2_0.config.spine_combine_action_replace, arg_2_0.host))
			end
		end
	end

	return
end

function var_0_1.GetLevel(arg_3_0)
	return arg_3_0.config.level
end

function var_0_1._InitMusicData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	type = var_1_10005

	local var_4_0 = var_1_10005(arg_4_2) == "table" and arg_4_2 or {
		arg_4_2
	}

	type = var_1_10006

	local var_4_1 = var_1_10006(arg_4_3) == "table" and arg_4_3 or {
		arg_4_3
	}

	ipairs = var_7

	for iter_4_0, iter_4_1 in var_7(var_4_0) do
		table = var_1_10012

		var_1_10012.insert(arg_4_0.musicDatas, {
			voice = iter_4_1,
			voiceType = arg_4_1,
			action = var_4_1[iter_4_0],
			effect = arg_4_4
		})
	end

	return
end

function var_0_1.InitMusicData(arg_5_0)
	if arg_5_0.config.can_trigger[1] == 3 then
		arg_5_0:_InitMusicData(1, var_1[2][1], var_1[2][2], var_1[2][3])
		arg_5_0:_InitMusicData(2, var_1[3][1], var_1[3][2], var_1[3][3])
	else
		arg_5_0:_InitMusicData(var_1[1], var_1[2], var_1[3], var_1[4])
	end

	return
end

function var_0_1.Init(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:SetPosition(arg_6_1)
	arg_6_0:SetDir(arg_6_2)

	return
end

function var_0_1.DisableRotation(arg_7_0)
	local var_7_1

	if arg_7_0.config.can_rotate == 0 then
		local var_7_0 = arg_7_0

		var_7_1 = arg_7_0.IsType
		Furniture = var_1_10004

		if not var_7_1(var_7_0, var_1_10004.TYPE_WALL) then
			local var_7_2 = arg_7_0

			var_7_1 = arg_7_0.IsType
			Furniture = var_4
			var_7_1 = var_7_1(var_7_2, var_4.TYPE_WALL_MAT)
		end

		if false then
			var_7_1 = false
		end
	else
		var_7_1 = true
	end

	return var_7_1
end

function var_0_1.IsType(arg_8_0, arg_8_1)
	return arg_8_0.config.type == arg_8_1
end

function var_0_1.IsMusicalInstruments(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.IsType

	Furniture = var_1_10004

	return var_9_1(var_9_0, var_1_10004.TYPE_LUTE)
end

function var_0_1.IsRandomSlotType(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.IsType

	Furniture = var_1_10004

	return var_10_1(var_10_0, var_1_10004.TYPE_RANDOM_SLOT)
end

function var_0_1.RawGetOffset(arg_11_0)
	local var_11_0 = arg_11_0.config.offset

	Vector3 = var_1_10002

	return var_1_10002(var_11_0[1], var_11_0[2], 0)
end

function var_0_1.SetPosition(arg_12_0, arg_12_1)
	var_0_1.super.SetPosition(arg_12_0, arg_12_1)

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.DispatchEvent

	CourtYardEvent = var_5

	var_12_1(var_12_0, var_5.FURNITURE_POSITION_CHANGE, arg_12_1, arg_12_0:GetOffset())

	return
end

function var_0_1.UpdateOpFlag(arg_13_0, arg_13_1)
	var_0_1.super.UpdateOpFlag(arg_13_0, arg_13_1)

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.DispatchEvent

	CourtYardEvent = var_5

	var_13_1(var_13_0, var_5.FURNITURE_OP_FLAG_CHANGE, arg_13_0.opFlag)

	return
end

function var_0_1.InActivityRange(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetHost()
	local var_14_1 = var_2.GetStorey(var_14_0)
	local var_14_2 = var_2.GetRange(var_14_1)

	return arg_14_1.x < var_14_2.x and arg_14_1.y < var_14_2.y and arg_14_1.x >= 0 and arg_14_1.y >= 0
end

function var_0_1.GetObjType(arg_15_0)
	CourtYardConst = var_1_10001

	return var_1_10001.OBJ_TYPE_COMMOM
end

function var_0_1.GetDeathType(arg_16_0)
	CourtYardConst = var_1_10001

	return var_1_10001.DEPTH_TYPE_FURNITURE
end

function var_0_1.GetType(arg_17_0)
	return arg_17_0.config.type
end

function var_0_1.GetPicture(arg_18_0)
	return arg_18_0.config.picture
end

function var_0_1.IsOverlap(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetArea()

	_ = var_1_10003

	return var_1_10003.any(var_19_0, function(arg_20_0)
		return arg_20_0 == arg_19_1
	end)
end

function var_0_1.Rotate(arg_21_0)
	local var_21_0 = arg_21_0.dir == 1 and 2 or 1

	var_0_1.super.SetDir(arg_21_0, var_21_0)

	local var_21_1 = arg_21_0
	local var_21_2 = arg_21_0.DispatchEvent

	CourtYardEvent = var_5

	var_21_2(var_21_1, var_5.ROTATE_FURNITURE, arg_21_0.dir)

	return
end

function var_0_1.GetSize(arg_22_0)
	return arg_22_0.sizeX, arg_22_0.sizeY
end

function var_0_1.GetArchMask(arg_23_0)
	return arg_23_0.config.picture .. "_using"
end

function var_0_1.HasDescription(arg_24_0)
	return #arg_24_0.config.can_trigger > 0 and var_1[1] > 0
end

function var_0_1.ExistVoice(arg_25_0)
	return arg_25_0.config.can_trigger[2] ~= nil, var_1[1]
end

function var_0_1.GetIcon(arg_26_0)
	return arg_26_0.config.icon
end

function var_0_1.GetName(arg_27_0)
	return arg_27_0.config.name
end

function var_0_1.GetAddDate(arg_28_0)
	if arg_28_0.date > 0 then
		pg = var_1

		local var_28_0 = var_1.TimeMgr.GetInstance()

		return var_1.STimeDescS(var_28_0, arg_28_0.date, "%Y/%m/%d")
	end

	return
end

function var_0_1.GetComfortable(arg_29_0)
	return arg_29_0.config.comfortable
end

function var_0_1.GetDescription(arg_30_0)
	return arg_30_0.config.describe
end

function var_0_1.GetAddMode(arg_31_0)
	return arg_31_0.config.gain_by
end

function var_0_1.GetGametipType(arg_32_0)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.GetType(var_32_0)
	local var_32_2 = {
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}

	i18n = var_32_0
	var_32_2[1] = var_32_0("word_wallpaper")
	i18n = var_3
	var_32_2[2] = var_3("word_furniture")
	i18n = var_3
	var_32_2[3] = var_3("word_decorate")
	i18n = var_3
	var_32_2[4] = var_3("word_floorpaper")
	i18n = var_3
	var_32_2[5] = var_3("word_mat")
	i18n = var_3
	var_32_2[6] = var_3("word_wall")
	i18n = var_3
	var_32_2[7] = var_3("word_collection")
	i18n = var_3
	var_32_2[15] = var_3("word_collection")

	return var_32_2[var_32_1]
end

function var_0_1.CanTouch(arg_33_0)
	local var_33_0

	if arg_33_0.config.spine and arg_33_0.config.spine[1] then
		var_33_0 = arg_33_0.config.spine[1][3] ~= nil
	end

	return var_33_0
end

function var_0_1.GetTouchAction(arg_34_0)
	local var_34_0 = arg_34_0

	if arg_34_0.CanTouch(var_34_0) then
		local var_34_1 = arg_34_0.config.spine
		local var_34_2 = {}

		table = var_34_0

		var_34_0.insert(var_34_2, var_34_1[1][3][1])

		ipairs = var_3

		local var_34_3

		if not var_34_1[1][3][3] then
			var_34_3 = {}
		end

		for iter_34_0, iter_34_1 in var_3(var_34_3) do
			table = var_1_10008

			var_1_10008.insert(var_34_2, iter_34_1)
		end

		math = var_3

		return var_34_2[var_3.random(1, #var_34_2)], var_34_1[1][3][2]
	end

	return
end

function var_0_1.GetTouchPrepareAction(arg_35_0)
	if arg_35_0:CanTouch() then
		return arg_35_0.config.spine[1][3][6]
	end

	return
end

function var_0_1.GetTouchBg(arg_36_0)
	if arg_36_0:CanTouch() then
		return arg_36_0.config.spine[1][3][7]
	end

	return
end

function var_0_1.TriggerTouchDefault(arg_37_0)
	if arg_37_0:CanTouch() and arg_37_0.config.spine[1][3][8] and arg_37_0.config.spine[1][3][8] > 0 then
		return true
	end

	return false
end

function var_0_1.GetTouchSound(arg_38_0)
	if arg_38_0:CanTouch() then
		local var_38_0 = arg_38_0.config.spine[1][3][4]

		type = var_1_10002

		if var_1_10002(var_38_0) == "table" then
			math = var_2

			return var_38_0[var_2.random(1, #var_38_0)]
		else
			return var_38_0
		end
	end

	return
end

function var_0_1.GetTouchEffect(arg_39_0)
	if arg_39_0:CanTouch() then
		return arg_39_0.config.spine[1][3][5]
	end

	return
end

function var_0_1.IsTouchState(arg_40_0)
	return arg_40_0.state == var_0_1.STATE_TOUCH or arg_40_0.state == var_0_1.STATE_TOUCH_PREPARE
end

function var_0_1.IsDragingState(arg_41_0)
	return arg_41_0.state == var_0_1.STATE_DRAG
end

function var_0_1.IsSpine(arg_42_0)
	type = var_1_10001

	return var_1_10001(arg_42_0.config.spine) == "table"
end

function var_0_1.GetFirstSlot(arg_43_0)
	return arg_43_0.slots[1]
end

function var_0_1.AnySlotIsLoop(arg_44_0)
	pairs = var_1_10001

	for iter_44_0, iter_44_1 in var_1_10001(arg_44_0.slots) do
		if iter_44_1.loop then
			return true
		end
	end

	return false
end

function var_0_1.GetMaskNames(arg_45_0)
	local var_45_0 = {}

	ipairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_0.slots) do
		if iter_45_1:GetMask() then
			var_45_0[iter_45_1.id] = var_7
		end
	end

	return var_45_0
end

function var_0_1.IsMultiMask(arg_46_0)
	local var_46_0 = arg_46_0:GetMaskNames()

	if not arg_46_0:IsSpine() then
		table = var_2

		local var_46_1

		if not (var_2.getCount(var_46_0) > 0) or not (arg_46_0:GetSlotCnt() > 1) then
			var_46_1 = false
		else
			var_46_1 = true
		end

		return var_46_1
	end
end

function var_0_1.GetBodyMasks(arg_47_0)
	local var_47_0 = {}

	ipairs = var_1_10002

	for iter_47_0, iter_47_1 in var_1_10002(arg_47_0.slots) do
		if iter_47_1:GetBodyMask() then
			var_47_0[iter_47_1.id] = var_7
		end
	end

	return var_47_0
end

function var_0_1.GetAnimators(arg_48_0)
	local var_48_0 = {}

	ipairs = var_1_10002

	for iter_48_0, iter_48_1 in var_1_10002(arg_48_0.slots) do
		pairs = var_1_10007

		for iter_48_2, iter_48_3 in var_1_10007(iter_48_1:GetAnimators()) do
			table = var_1_10012

			var_1_10012.insert(var_48_0, iter_48_3)
		end
	end

	return var_48_0
end

function var_0_1.GetAnimatorMask(arg_49_0)
	if not arg_49_0.config.animator then
		return nil
	end

	if arg_49_0.config.animator[3] then
		local var_49_0 = {}

		Vector2 = var_1_10003
		var_49_0.size = var_1_10003(var_1[1][1], var_1[1][2])
		Vector2 = var_3
		var_49_0.offset = var_3(var_1[2][1], var_1[2][2])

		return var_49_0
	end

	return
end

function var_0_1.CanInterAction(arg_50_0, arg_50_1)
	_ = var_1_10002

	if var_1_10002.any(arg_50_0.slots, function(arg_51_0)
		return arg_51_0:IsEmpty()
	end) then
		if not arg_50_0:IsPlayMusicState() then
			local var_50_0

			if #arg_50_0.config.interAction_group ~= 0 then
				_ = var_50_0
				var_50_0 = var_50_0.any(arg_50_0.config.interAction_group, function(arg_52_0)
					local var_52_0 = arg_50_1

					return var_1.GetGroupID(var_52_0) == arg_52_0
				end)

				if false then
					var_50_0 = false
				end
			else
				var_50_0 = true
			end

			return var_50_0
		end
	end
end

function var_0_1.IsPlayMusicState(arg_53_0)
	return arg_53_0.state == var_0_1.STATE_PLAY_MUSIC
end

function var_0_1.GetInteractionSlot(arg_54_0)
	local var_54_0

	if arg_54_0:IsRandomSlotType() then
		var_54_0 = {}
		ipairs = var_1_10002

		for iter_54_0, iter_54_1 in var_1_10002(arg_54_0.slots) do
			if iter_54_1:IsEmpty() then
				table = var_7

				var_7.insert(var_54_0, iter_54_1)
			end
		end

		math = var_2

		return var_54_0[var_2.random(1, #var_54_0)]
	else
		_ = var_54_0

		return var_54_0.detect(arg_54_0.slots, function(arg_55_0)
			return arg_55_0:IsEmpty()
		end)
	end

	return
end

function var_0_1._ChangeState(arg_56_0, arg_56_1)
	arg_56_0.state = arg_56_1

	local var_56_0 = arg_56_0
	local var_56_1 = arg_56_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_56_1(var_56_0, var_1_10005.FURNITURE_STATE_CHANGE, arg_56_1)

	return
end

function var_0_1.ChangeState(arg_57_0, arg_57_1)
	if arg_57_0:IsPlayMusicState() and arg_57_1 ~= var_0_1.STATE_STOP_MUSIC then
		return
	end

	if arg_57_0:IsInteractionState() then
		return
	end

	if arg_57_1 == var_0_1.STATE_TOUCH and arg_57_0:GetTouchPrepareAction() then
		arg_57_0:_ChangeState(var_0_1.STATE_TOUCH_PREPARE)
	elseif arg_57_1 == var_0_1.STATE_PLAY_MUSIC then
		_ = var_2

		if #var_2.select(arg_57_0.musicDatas, function(arg_58_0)
			return arg_58_0.voiceType == 2
		end) > 0 then
			math = var_3
			arg_57_0.musicData = var_2[var_3.random(1, #var_2)]

			arg_57_0:_ChangeState(arg_57_1)
		end
	elseif arg_57_1 == var_0_1.STATE_STOP_MUSIC then
		arg_57_0:_ChangeState(var_0_1.STATE_IDLE)

		arg_57_0.musicData = nil
	else
		arg_57_0:_ChangeState(arg_57_1)
	end

	return
end

function var_0_1.IsInteractionState(arg_59_0)
	return arg_59_0.state == var_0_1.STATE_INTERACT
end

function var_0_1.WillInteraction(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0
	local var_60_1 = arg_60_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_60_1(var_60_0, var_1_10005.FURNITURE_WILL_INTERACTION, arg_60_1)

	return
end

function var_0_1.StartInteraction(arg_61_0, arg_61_1)
	local var_61_0 = {}

	_ = var_1_10003

	var_1_10003.each(arg_61_0.slots, function(arg_62_0)
		if arg_62_0.id ~= arg_61_1.id and arg_62_0:IsUsing() then
			table = var_1

			var_1.insert(var_61_0, arg_62_0)

			local var_62_0 = arg_61_0
			local var_62_1 = var_1.DispatchEvent

			CourtYardEvent = var_4

			var_62_1(var_62_0, var_4.FURNITURE_STOP_INTERACTION, arg_62_0)
		end

		return
	end)

	if #var_61_0 > 0 then
		arg_61_0:_ChangeState(var_0_1.STATE_IDLE)
	end

	arg_61_0:_ChangeState(var_0_1.STATE_INTERACT)

	if #var_61_0 > 0 then
		arg_61_1:OnStart()
	end

	ipairs = var_3

	for iter_61_0, iter_61_1 in var_3(var_61_0) do
		iter_61_1:OnStart()

		local var_61_1 = arg_61_0
		local var_61_2 = arg_61_0.DispatchEvent

		CourtYardEvent = var_1_10011

		var_61_2(var_61_1, var_1_10011.FURNITURE_START_INTERACTION, iter_61_1)
	end

	local var_61_3 = arg_61_0
	local var_61_4 = arg_61_0.DispatchEvent

	CourtYardEvent = iter_61_0

	var_61_4(var_61_3, iter_61_0.FURNITURE_START_INTERACTION, arg_61_1)

	return
end

function var_0_1.OnPreheatActionEnd(arg_63_0)
	return
end

function var_0_1.UpdateInteraction(arg_64_0, ...)
	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.DispatchEvent

	CourtYardEvent = var_1_10004

	var_64_1(var_64_0, var_1_10004.FURNITURE_UPDATE_INTERACTION, ...)

	return
end

function var_0_1.AnySlotIsUsing(arg_65_0)
	_ = var_1_10001

	return var_1_10001.any(arg_65_0.slots, function(arg_66_0)
		return arg_66_0:IsUsing()
	end)
end

function var_0_1.ClearInteraction(arg_67_0, arg_67_1)
	_ = var_1_10002

	local var_67_0 = var_1_10002.select(arg_67_0.slots, function(arg_68_0)
		return arg_68_0.id ~= arg_67_1.id and arg_68_0:IsUsing()
	end)

	ipairs = var_1_10003

	for iter_67_0, iter_67_1 in var_1_10003(var_67_0) do
		iter_67_1:Reset()
	end

	if #var_67_0 <= 0 then
		arg_67_0:_ChangeState(var_0_1.STATE_IDLE)
	end

	onNextTick = var_3

	var_3(function()
		local var_69_0 = arg_67_0
		local var_69_1 = var_0.DispatchEvent

		CourtYardEvent = var_2_10003

		var_69_1(var_69_0, var_2_10003.FURNITURE_STOP_INTERACTION, arg_67_1)

		return
	end)

	return
end

function var_0_1.RefreshState(arg_70_0)
	_ = var_1_10001

	if #var_1_10001.select(arg_70_0.slots, function(arg_71_0)
		return arg_71_0:IsUsing()
	end) <= 0 then
		arg_70_0:_ChangeState(var_0_1.STATE_IDLE)
	else
		ipairs = var_2

		for iter_70_0, iter_70_1 in var_2(var_1) do
			iter_70_1:OnStart()
		end
	end

	return
end

function var_0_1.GetUsingSlots(arg_72_0)
	local var_72_0 = {}

	ipairs = var_1_10002

	for iter_72_0, iter_72_1 in var_1_10002(arg_72_0.slots) do
		if iter_72_1:IsUsing() then
			table = var_7

			var_7.insert(var_72_0, iter_72_1)
		end
	end

	return var_72_0
end

function var_0_1.GetSlotCnt(arg_73_0)
	return #arg_73_0.slots
end

function var_0_1.GetMusicData(arg_74_0)
	return arg_74_0.musicData
end

function var_0_1.GetInterActionBgm(arg_75_0)
	type = var_1_10001

	if var_1_10001(arg_75_0.config.interaction_bgm) == "string" then
		return arg_75_0.config.interaction_bgm, 0
	elseif var_1 == "table" then
		return arg_75_0.config.interaction_bgm[2], arg_75_0.config.interaction_bgm[1]
	else
		return nil
	end

	return
end

function var_0_1.CanClickWhenExitEditMode(arg_76_0)
	local var_76_0

	if not arg_76_0:HasDescription() then
		var_76_0 = arg_76_0:CanTouch()
	end

	return var_76_0
end

function var_0_1.Dispose(arg_77_0)
	var_0_1.super.Dispose(arg_77_0)

	ipairs = var_1

	for iter_77_0, iter_77_1 in var_1(arg_77_0:GetUsingSlots()) do
		iter_77_1:Stop()
	end

	return
end

function var_0_1.ToTable(arg_78_0)
	local var_78_0 = arg_78_0:GetPosition()
	local var_78_1 = {
		id = arg_78_0.id,
		configId = arg_78_0.configId,
		dir = arg_78_0.dir,
		position = var_78_0,
		x = var_78_0.x,
		y = var_78_0.y
	}
	local var_78_2

	if not arg_78_0.parent or not arg_78_0.parent.id then
		var_78_2 = 0
	end

	var_78_1.parent = var_78_2
	var_78_1.child = {}

	return var_78_1
end

return var_0_1
