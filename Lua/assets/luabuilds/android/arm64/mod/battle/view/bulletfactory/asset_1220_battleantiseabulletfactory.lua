ys = ys or {}
ys.Battle.BattleAntiSeaBulletFactory = singletonClass("BattleAntiSeaBulletFactory", ys.Battle.BattleBulletFactory)
ys.Battle.BattleAntiSeaBulletFactory.__name = "BattleAntiSeaBulletFactory"

local var_0_0 = ys.Battle.BattleAntiSeaBulletFactory

function ys.Battle.BattleAntiSeaBulletFactory.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0._tmpTimerList = {}

	return
end

function ys.Battle.BattleAntiSeaBulletFactory:NeutralizeBullet()
	for iter_2_0, iter_2_1 in pairs(self._tmpTimerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_2_1)

		self._tmpTimerList[iter_2_1] = nil
	end

	return
end

function ys.Battle.BattleAntiSeaBulletFactory:CreateBullet(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = self:GetDataProxy()
	local var_3_1 = arg_3_2:GetDirectHitUnit()

	if not var_3_1 then
		var_3_0:RemoveBulletUnit(arg_3_2:GetUniqueID())

		return
	end

	local var_3_2 = self:GetSceneMediator():GetCharacter((var_3_1:GetUniqueID()))

	if not var_3_2 then
		var_3_0:RemoveBulletUnit(arg_3_2:GetUniqueID())

		return
	end

	local var_3_3 = arg_3_2:GetTemplate().hit_type.range
	local var_3_4

	local function var_3_6()
		if var_3_4 then
			local var_4_0
			local var_4_1 = var_3_2:GetPosition():Clone()

			var_4_0 = var_3_1:IsAlive() and var_3_2 and var_4_1:Add(Vector3(math.random(var_3_3) - var_3_3 * 0.5, 0, math.random(var_3_3) - var_3_3 * 0.5)) or var_4_1

			local var_4_2, var_4_3 = self:GetFXPool():GetFX(arg_3_2:GetTemplate().hit_fx)

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_4_2, var_4_3:Add(var_4_0), true)
		end

		return
	end

	var_3_4 = pg.TimeMgr.GetInstance():AddBattleTimer("antiAirTimer", 0, 0.5, function()
		if var_3_1:IsAlive() then
			var_3_0:HandleDamage(arg_3_2, var_3_1)
			var_3_0:RemoveBulletUnit(arg_3_2:GetUniqueID())
		end

		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_3_4)

		self._tmpTimerList[var_3_4] = nil
		var_3_4 = nil

		return
	end, true)
	self._tmpTimerList[var_3_4] = var_3_4

	if arg_3_4 ~= nil then
		self:PlayFireFX(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, nil)

		local var_3_7 = pg.TimeMgr.GetInstance():AddBattleTimer("showHitFXTimer", -1, 0.1, var_3_6, true)

		self._tmpTimerList[nil] = nil

		var_3_6()
	else
		var_3_0:HandleDamage(arg_3_2, var_3_1)
		var_3_0:RemoveBulletUnit(arg_3_2:GetUniqueID())
	end

	return
end

return
