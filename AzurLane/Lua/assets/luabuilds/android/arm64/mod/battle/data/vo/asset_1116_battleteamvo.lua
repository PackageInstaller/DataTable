ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleConfig
local var_0_5 = var_0.Battle.BattleDataFunction

class = var_0_10006

local var_0_6 = var_0_10006("BattleTeamVO")

var_0.Battle.BattleTeamVO = var_0_6
var_0_6.__name = "BattleTeamVO"

function var_0_6.Ctor(arg_1_0, arg_1_1)
	arg_1_0._teamID = arg_1_1

	arg_1_0:init()

	return
end

function var_0_6.UpdateMotion(arg_2_0)
	if arg_2_0._motionReferenceUnit then
		local var_2_0 = arg_2_0._motionVO

		var_1.UpdatePos(var_2_0, arg_2_0._motionReferenceUnit)

		local var_2_1 = arg_2_0._motionVO
		local var_2_2 = var_1.UpdateSpeed
		local var_2_3 = arg_2_0._motionReferenceUnit

		var_2_2(var_2_1, var_4.GetSpeed(var_2_3))
	end

	return
end

function var_0_6.IsFatalDamage(arg_3_0)
	return arg_3_0._count == 0
end

function var_0_6.AppendUnit(arg_4_0, arg_4_1)
	arg_4_1:SetMotion(arg_4_0._motionVO)

	arg_4_0._enemyList[#arg_4_0._enemyList + 1] = arg_4_1
	arg_4_0._count = arg_4_0._count + 1

	arg_4_0:refreshTeamFormation()
	arg_4_1:SetTeamVO(arg_4_0)

	return
end

function var_0_6.RemoveUnit(arg_5_0, arg_5_1)
	local var_5_0 = 0

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_0._enemyList) do
		if iter_5_1 == arg_5_1 then
			var_5_0 = iter_5_0

			break
		end
	end

	table = var_3

	var_3.remove(arg_5_0._enemyList, var_5_0)

	arg_5_0._count = arg_5_0._count - 1

	arg_5_1:SetTeamVO(nil)
	arg_5_0:refreshTeamFormation()

	return
end

function var_0_6.init(arg_6_0)
	arg_6_0._enemyList = {}
	arg_6_0._motionVO = var_0.Battle.BattleFleetMotionVO.New()
	arg_6_0._count = 0

	return
end

function var_0_6.refreshTeamFormation(arg_7_0)
	local var_7_0 = 1
	local var_7_1 = #arg_7_0._enemyList
	local var_7_2 = {}

	while var_7_0 <= var_7_1 do
		var_7_2[#var_7_2 + 1] = var_7_0
		var_7_0 = var_7_0 + 1
	end

	local var_7_3 = var_0_5.GetFormationTmpDataFromID(var_0_4.FORMATION_ID).pos_offset

	arg_7_0._enemyList = var_0_5.SortFleetList(var_7_2, arg_7_0._enemyList)

	local var_7_4 = var_0_4.BornOffset

	ipairs = var_6

	for iter_7_0, iter_7_1 in var_6(arg_7_0._enemyList) do
		if iter_7_0 == 1 then
			arg_7_0._motionReferenceUnit = iter_7_1

			iter_7_1:CancelFollowTeam()
		else
			local var_7_5 = var_7_3[iter_7_0]
			local var_7_6 = iter_7_1
			local var_7_7 = iter_7_1.UpdateFormationOffset

			Vector3 = var_1_10015

			var_7_7(var_7_6, var_1_10015(var_7_5.x, var_7_5.y, var_7_5.z) + var_7_4 * (iter_7_0 - 1))
		end
	end

	return
end

function var_0_6.Dispose(arg_8_0)
	arg_8_0._enemyList = nil
	arg_8_0._motionReferenceUnit = nil
	arg_8_0._motionVO = nil

	return
end

return
