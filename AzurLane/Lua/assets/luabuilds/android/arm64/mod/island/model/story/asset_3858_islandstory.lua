class = var_0_10000

local var_0_0 = var_0_10000("IslandStory")

var_0_0.MODE_BUBBLE = 9
var_0_0.MODE_DIALOGUE = 10

function var_0_0.GetStoryStepCls(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = var_0_0.MODE_BUBBLE

	BubbleStep = var_1_10003
	var_1_0[var_1_1] = var_1_10003

	local var_1_2 = var_0_0.MODE_DIALOGUE

	Dialogue3DStep = var_1_10003
	var_1_0[var_1_2] = var_1_10003

	return var_1_0[arg_1_0]
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1.id
	arg_2_0.unitList = arg_2_2 or {}
	defaultValue = var_4
	arg_2_0.lockOp = var_4(arg_2_1.lockOp, false)

	local var_2_0

	if not arg_2_1.map then
		var_2_0 = {}
	end

	arg_2_0.unitMap = var_2_0

	local var_2_1

	if not arg_2_1.look_weight then
		var_2_1 = {}
	end

	arg_2_0.lookWeight = var_2_1
	assert = var_2_1

	var_2_1(arg_2_1.map, "请确保配置文件存在map字段" .. arg_2_1.id)

	defaultValue = var_2_1
	arg_2_0.useUISpace = var_2_1(arg_2_1.useUISpace, true)
	arg_2_0.steps = {}
	ipairs = var_4

	local var_2_2

	if not arg_2_1.scripts then
		var_2_2 = {}
	end

	for iter_2_0, iter_2_1 in var_4(var_2_2) do
		local var_2_3 = var_0_0.GetStoryStepCls(arg_2_3).New(iter_2_1, arg_2_0)

		table = var_1_10010

		var_1_10010.insert(arg_2_0.steps, var_2_3)
	end

	ipairs = var_4

	for iter_2_2, iter_2_3 in var_4(arg_2_0.steps) do
		local var_2_4, var_2_5 = arg_2_0:GetUnitIdFromCharaId(iter_2_3.characterId)

		iter_2_3.unitId = var_2_4
		iter_2_3.unitType = var_2_5
	end

	local var_2_7

	if not arg_2_1.speed then
		getProxy = var_2_7
		SettingsProxy = var_6

		local var_2_6 = var_2_7(var_6)

		if not var_2_7.GetStorySpeed(var_2_6) then
			var_2_7 = 0
		end
	end

	arg_2_0.speedData = var_2_7

	local var_2_8

	if not arg_2_1.fadeIn then
		var_2_8 = 0
	end

	arg_2_0.fadeIn = var_2_8

	local var_2_9

	if not arg_2_1.fadeOut then
		var_2_9 = 0
	end

	arg_2_0.fadeOut = var_2_9
	arg_2_0.branchCode = nil
	arg_2_0.isAuto = false
	arg_2_0.speed = 0
	arg_2_0.skipFlag = false
	arg_2_0.followOffset = arg_2_1.followOffset
	Vector3 = var_4
	arg_2_0.defultFollowOffset = var_4(0, 1, 5)
	defaultValue = var_4
	arg_2_0.soloCamDir = var_4(arg_2_1.cam_dir, 0) == 0

	return
end

function var_0_0.ContainerPlayer(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.steps) do
		if not iter_3_1.characterId or iter_3_1.characterId == 0 then
			return true
		end
	end

	return false
end

function var_0_0.IsFacingWhenSolo(arg_4_0)
	return arg_4_0.soloCamDir
end

function var_0_0.LastStepIsTimeline(arg_5_0)
	local var_5_0 = arg_5_0.steps[#arg_5_0.steps]

	isa = var_2

	local var_5_1 = var_5_0

	Dialogue3DStep = var_1_10005

	if var_2(var_5_1, var_1_10005) then
		return var_5_0:IsTimeline()
	else
		return false
	end

	return
end

function var_0_0.GetFadeInTime(arg_6_0)
	return arg_6_0.fadeIn
end

function var_0_0.GetFadeOutTime(arg_7_0)
	return arg_7_0.fadeOut
end

function var_0_0.GetDefultFollowOffset(arg_8_0)
	return arg_8_0.defultFollowOffset
end

function var_0_0.ShouldSetCamOffset(arg_9_0)
	return arg_9_0.followOffset ~= nil
end

function var_0_0.GetFollowOffset(arg_10_0)
	if not arg_10_0:ShouldSetCamOffset() then
		return nil
	end

	BuildVector3 = var_1

	return var_1(arg_10_0.followOffset)
end

function var_0_0.SetAutoPlay(arg_11_0)
	arg_11_0.isAuto = true

	arg_11_0:SetPlaySpeed(arg_11_0.speedData)

	return
end

function var_0_0.StopAutoPlay(arg_12_0)
	arg_12_0.isAuto = false

	arg_12_0:ResetSpeed()

	return
end

function var_0_0.GetAutoPlayFlag(arg_13_0)
	return arg_13_0.isAuto
end

function var_0_0.UpdatePlaySpeed(arg_14_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1

	if not var_1.GetStorySpeed(var_14_0) then
		var_14_1 = 0
	end

	arg_14_0:SetPlaySpeed(var_14_1)

	return
end

function var_0_0.GetPlaySpeed(arg_15_0)
	return arg_15_0.speed
end

function var_0_0.SetPlaySpeed(arg_16_0, arg_16_1)
	arg_16_0.speed = arg_16_1

	return
end

function var_0_0.ResetSpeed(arg_17_0)
	arg_17_0.speed = 0

	return
end

function var_0_0.GetTriggerDelayTime(arg_18_0)
	table = var_1_10001

	local var_18_0 = var_1_10001.indexof

	Story = var_1_10003

	if var_18_0(var_1_10003.STORY_AUTO_SPEED, arg_18_0.speed) then
		Story = var_1_10002

		local var_18_1

		if not var_1_10002.TRIGGER_DELAY_TIME[var_1] then
			var_18_1 = 0
		end

		return var_18_1
	end

	return 0
end

function var_0_0.IsSkipAll(arg_19_0)
	return arg_19_0.skipFlag == true
end

function var_0_0.MarkSkipAll(arg_20_0)
	arg_20_0.skipFlag = true

	return
end

function var_0_0.UnMarkSkipAll(arg_21_0)
	arg_21_0.skipFlag = false

	return
end

function var_0_0.GetStepByIndex(arg_22_0, arg_22_1)
	if not arg_22_0.steps[arg_22_1] or arg_22_0.branchCode and not var_2:IsSameBranch(arg_22_0.branchCode) then
		return nil
	end

	return var_2
end

function var_0_0.SetBranchCode(arg_23_0, arg_23_1)
	arg_23_0.branchCode = arg_23_1

	return
end

function var_0_0.IsUseUISpace(arg_24_0)
	return arg_24_0.useUISpace
end

function var_0_0.GetUnitIdFromCharaId(arg_25_0, arg_25_1)
	if not arg_25_1 or arg_25_1 == 0 then
		var_1_10002 = 0
		IslandConst = var_1_10003

		return var_1_10002, var_1_10003.UNIT_LIST_PLAYER
	end

	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.unitMap) do
		local var_25_0 = iter_25_1[1]
		local var_25_1 = iter_25_1[2]
		local var_25_2

		if not iter_25_1[3] then
			IslandConst = var_25_2
			var_25_2 = var_25_2.UNIT_LIST_OBJ
		end

		if var_25_0 == arg_25_1 then
			return var_25_1, var_25_2
		end
	end

	local var_25_3 = 0

	IslandConst = var_3

	return var_25_3, var_3.UNIT_LIST_PLAYER
end

function var_0_0.GetLookGroup(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = {}

	ipairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(arg_26_0.unitMap) do
		local var_26_3

		if not arg_26_0.lookWeight[iter_26_0] then
			var_26_3 = {}
		end

		local var_26_4 = arg_26_0
		local var_26_5 = arg_26_0.GetRole
		local var_26_6 = {
			id = iter_26_1[2]
		}
		local var_26_7

		if not iter_26_1[3] then
			IslandConst = var_26_7
			var_26_7 = var_26_7.UNIT_LIST_OBJ
		end

		var_26_6.type = var_26_7

		if var_26_5(var_26_4, var_26_6) then
			table = var_1_10011

			var_1_10011.insert(var_26_0, var_10)

			table = var_1_10011
			var_1_10011 = var_1_10011.insert

			local var_26_8 = var_26_1
			local var_26_9

			if not var_26_3[1] then
				var_26_9 = 1
			end

			var_1_10011(var_26_8, var_26_9)

			table = var_1_10011
			var_1_10011 = var_1_10011.insert

			local var_26_10 = var_26_2
			local var_26_11

			if not var_26_3[2] then
				var_26_11 = 0
			end

			var_1_10011(var_26_10, var_26_11)
		end
	end

	local var_26_12 = arg_26_0:GetPlayerRole()

	table = var_5

	if not var_5.contains(var_26_0, var_26_12) then
		table = var_5

		var_5.insert(var_26_0, var_26_12)

		local var_26_13

		if not arg_26_0.lookWeight[#arg_26_0.lookWeight] then
			var_26_13 = {}
		end

		table = var_6

		local var_26_14 = var_6.insert
		local var_26_15 = var_26_1
		local var_26_16

		if not var_26_13[1] then
			var_26_16 = 1
		end

		var_26_14(var_26_15, var_26_16)

		table = var_26_14

		local var_26_17 = var_26_14.insert
		local var_26_18 = var_26_2
		local var_26_19

		if not var_26_13[2] then
			var_26_19 = 0
		end

		var_26_17(var_26_18, var_26_19)
	end

	return var_26_0, var_26_1, var_26_2
end

function var_0_0.GetPlayerRole(arg_27_0)
	ipairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0.unitList) do
		isa = var_1_10006

		local var_27_0 = iter_27_1

		IslandPlayerUnit = var_1_10009

		if var_1_10006(var_27_0, var_1_10009) then
			return iter_27_1._go
		end
	end

	return nil
end

function var_0_0.GetRole(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.id
	local var_28_1 = arg_28_1.type

	if not var_28_0 or var_28_0 == 0 then
		return arg_28_0:GetPlayerRole()
	end

	ipairs = var_1_10004

	for iter_28_0, iter_28_1 in var_1_10004(arg_28_0.unitList) do
		if var_28_0 and iter_28_1.id == var_28_0 and iter_28_1.unitType == var_28_1 then
			return iter_28_1._go
		end
	end

	return nil
end

function var_0_0.GetUnitList(arg_29_0)
	return arg_29_0.unitList
end

function var_0_0.IsFreeOp(arg_30_0)
	return not arg_30_0.lockOp
end

return var_0_0
