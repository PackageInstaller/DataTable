ys = ys or {}

local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleDataFunction
local var_0_5 = class("BattleTeamVO")

ys.Battle.BattleTeamVO = var_0_5
var_0_5.__name = "BattleTeamVO"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	arg_1_0._teamID = arg_1_1

	arg_1_0:init()

	return
end

function var_0_5.UpdateMotion(arg_2_0)
	if arg_2_0._motionReferenceUnit then
		arg_2_0._motionVO:UpdatePos(arg_2_0._motionReferenceUnit)
		arg_2_0._motionVO:UpdateSpeed(arg_2_0._motionReferenceUnit:GetSpeed())
	end

	return
end

function var_0_5.IsFatalDamage(arg_3_0)
	return arg_3_0._count == 0
end

function var_0_5.AppendUnit(arg_4_0, arg_4_1)
	arg_4_1:SetMotion(arg_4_0._motionVO)

	arg_4_0._enemyList[#arg_4_0._enemyList + 1] = arg_4_1
	arg_4_0._count = arg_4_0._count + 1

	arg_4_0:refreshTeamFormation()
	arg_4_1:SetTeamVO(arg_4_0)

	return
end

function var_0_5.RemoveUnit(arg_5_0, arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._enemyList) do
		if iter_5_1 == arg_5_1 then
			var_5_0 = iter_5_0

			break
		end
	end

	table.remove(arg_5_0._enemyList, var_5_0)

	arg_5_0._count = arg_5_0._count - 1

	arg_5_1:SetTeamVO(nil)
	arg_5_0:refreshTeamFormation()

	return
end

function var_0_5.init(arg_6_0)
	arg_6_0._enemyList = {}
	arg_6_0._motionVO = var_0.Battle.BattleFleetMotionVO.New()
	arg_6_0._count = 0

	return
end

function var_0_5.refreshTeamFormation(arg_7_0)
	while 1 <= #arg_7_0._enemyList do
		({})[#{} + 1] = 1
	end

	local var_7_1 = var_0_4.GetFormationTmpDataFromID(var_0_3.FORMATION_ID).pos_offset

	arg_7_0._enemyList = var_0_4.SortFleetList({}, arg_7_0._enemyList)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._enemyList) do
		local var_7_2

		if iter_7_0 == 1 then
			arg_7_0._motionReferenceUnit = iter_7_1

			iter_7_1:CancelFollowTeam()

			goto label_7_0

			var_7_2 = iter_7_1
		end

		iter_7_1:UpdateFormationOffset(Vector3(var_7_1[iter_7_0].x, var_7_1[iter_7_0].y, var_7_1[iter_7_0].z) + var_0_3.BornOffset * (iter_7_0 - 1))

		::label_7_0::
	end

	return
end

function var_0_5.Dispose(arg_8_0)
	arg_8_0._enemyList = nil
	arg_8_0._motionReferenceUnit = nil
	arg_8_0._motionVO = nil

	return
end

return
