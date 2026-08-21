ys = ys or {}

local var_0_0 = class("BattleEffectBulletUnit", ys.Battle.BattleBulletUnit)

ys.Battle.BattleEffectBulletUnit = var_0_0
var_0_0.__name = "BattleEffectBulletUnit"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	var_0_0.super.Update(arg_2_0, arg_2_1)

	if arg_2_0._flare then
		arg_2_0._flare:SetPosition(pg.Tool.FilterY(arg_2_0:GetPosition():Clone()))
	end

	return
end

function var_0_0.IsFlare(arg_3_0)
	return arg_3_0:GetTemplate().attach_buff[1].flare
end

function var_0_0.OutRange(arg_4_0)
	var_0_0.super.OutRange(arg_4_0)

	if arg_4_0._flare then
		arg_4_0._flare:SetActiveFlag(false)

		arg_4_0._flare = nil
	end

	return
end

function var_0_0.spawnArea(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetTemplate()
	local var_5_1 = var_5_0.attach_buff[1].buff_id
	local var_5_2

	if not var_5_0.attach_buff[1].buff_level then
		var_5_2 = 1
	end

	local function var_5_3(arg_6_0)
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			if iter_6_1.Active then
				arg_5_0._battleProxy:GetUnitList()[iter_6_1.UID]:AddBuff(var_0.Battle.BattleBuffUnit.New(var_5_1, var_5_2), true)
			end
		end

		return
	end

	time = var_5_0.hit_type.time

	local var_5_4 = var_5_0.extra_param.ellipse_range and arg_5_0._battleProxy:SpawnLastingEllipseArea(arg_5_0:GetEffectField(), arg_5_0:GetIFF(), pg.Tool.FilterY(arg_5_0:GetPosition():Clone()), var_5_0.hit_type.range, var_5_0.extra_param.ellipse_range, time, var_5_3, function(arg_7_0)
		if arg_7_0.Active then
			arg_5_0._battleProxy:GetUnitList()[arg_7_0.UID]:RemoveBuff(var_5_1, true)
		end

		return
	end, var_5_0.attach_buff[1].friendly, var_5_0.attach_buff[1].effect_id) or arg_5_0._battleProxy:SpawnLastingColumnArea(arg_5_0:GetEffectField(), arg_5_0:GetIFF(), pg.Tool.FilterY(arg_5_0:GetPosition():Clone()), var_5_0.hit_type.range, time, var_5_3, function(arg_7_0)
		if arg_7_0.Active then
			arg_5_0._battleProxy:GetUnitList()[arg_7_0.UID]:RemoveBuff(var_5_1, true)
		end

		return
	end, var_5_0.attach_buff[1].friendly, var_5_0.attach_buff[1].effect_id)

	if arg_5_1 then
		arg_5_0._flare = var_5_4
	end

	var_5_4:SetSource(var_5_4.SOURCE_BULLET_9)

	return var_5_4
end

function var_0_0.GetExplodePostion(arg_8_0)
	return arg_8_0._explodePos
end

function var_0_0.SetExplodePosition(arg_9_0, arg_9_1)
	arg_9_0._explodePos = arg_9_1

	return
end

return
