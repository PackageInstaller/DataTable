ys = ys or {}

local var_0_0 = ys
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleDataFunction
local BattleTeamVO = class("BattleTeamVO")

ys.Battle.BattleTeamVO = BattleTeamVO
BattleTeamVO.__name = "BattleTeamVO"

function BattleTeamVO:Ctor(arg_1_1)
	self._teamID = arg_1_1

	self:init()

	return
end

function BattleTeamVO:UpdateMotion()
	if self._motionReferenceUnit then
		self._motionVO:UpdatePos(self._motionReferenceUnit)
		self._motionVO:UpdateSpeed(self._motionReferenceUnit:GetSpeed())
	end

	return
end

function BattleTeamVO:IsFatalDamage()
	return self._count == 0
end

function BattleTeamVO:AppendUnit(arg_4_1)
	arg_4_1:SetMotion(self._motionVO)

	self._enemyList[#self._enemyList + 1] = arg_4_1
	self._count = self._count + 1

	self:refreshTeamFormation()
	arg_4_1:SetTeamVO(self)

	return
end

function BattleTeamVO:RemoveUnit(arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self._enemyList) do
		if iter_5_1 == arg_5_1 then
			var_5_0 = iter_5_0

			break
		end
	end

	table.remove(self._enemyList, var_5_0)

	self._count = self._count - 1

	arg_5_1:SetTeamVO(nil)
	self:refreshTeamFormation()

	return
end

function BattleTeamVO:init()
	self._enemyList = {}
	self._motionVO = var_0_0.Battle.BattleFleetMotionVO.New()
	self._count = 0

	return
end

function BattleTeamVO:refreshTeamFormation()
	local var_7_0 = {}

	while 1 <= #self._enemyList do
		var_7_0[#var_7_0 + 1] = 1
	end

	local var_7_2 = var_0_5.GetFormationTmpDataFromID(var_0_4.FORMATION_ID).pos_offset

	self._enemyList = var_0_5.SortFleetList(var_7_0, self._enemyList)

	for iter_7_0, iter_7_1 in ipairs(self._enemyList) do
		if iter_7_0 == 1 then
			self._motionReferenceUnit = iter_7_1

			iter_7_1:CancelFollowTeam()
		else
			iter_7_1:UpdateFormationOffset(Vector3(var_7_2[iter_7_0].x, var_7_2[iter_7_0].y, var_7_2[iter_7_0].z) + var_0_4.BornOffset * (iter_7_0 - 1))
		end
	end

	return
end

function BattleTeamVO:Dispose()
	self._enemyList = nil
	self._motionReferenceUnit = nil
	self._motionVO = nil

	return
end

return
