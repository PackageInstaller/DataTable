ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleMissileFactory", var_0.Battle.BattleBombBulletFactory)

var_0_1.__name = "BattleMissileFactory"
var_0.Battle.BattleMissileFactory = var_0_1

function var_0_1.MakeModel(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1:GetBulletData()
	local var_1_1 = arg_1_0:GetBulletPool()

	if var_4.InstFX(var_1_1, arg_1_1:GetModleID()) then
		arg_1_1:AddModel(var_4)
	else
		local var_1_2 = arg_1_1
		local var_1_3 = arg_1_1.AddTempModel
		local var_1_4 = arg_1_0:GetTempGOPool()

		var_1_3(var_1_2, var_8.GetObject(var_1_4))
	end

	arg_1_1:SetSpawn(arg_1_2)
	arg_1_1:SetFXFunc(arg_1_0.onBulletHitFunc, arg_1_0.onBulletHitFunc)

	local var_1_5 = arg_1_0:GetSceneMediator()

	var_5.AddBullet(var_1_5, arg_1_1)

	return
end

function var_0_1.CreateBulletAlert(arg_2_0)
	local var_2_0 = arg_2_0:GetTemplate()
	local var_2_1 = arg_2_0:GetIFF()
	local var_2_2 = var_0_1.GetDataProxy()

	if var_2_1 == var_3.GetFriendlyCode(var_2_2) then
		return
	end

	if #var_2_0.alert_fx <= 0 then
		return
	end

	local var_2_3 = var_2_0.hit_type.range
	local var_2_4 = var_2_0.alert_fx
	local var_2_5 = var_0.Battle.BattleFXPool.GetInstance()
	local var_2_6 = var_4.GetFX(var_2_5, var_2_4).transform
	local var_2_7 = 0

	pg = var_7

	if var_7.effect_offset[var_2_4] and var_7[var_2_4].y_scale == true then
		var_2_7 = var_2_3
	end

	Vector3 = var_8
	var_2_6.localScale = var_8(var_2_3, var_2_7, var_2_3)
	pg = var_8

	local var_2_8 = var_8.EffectMgr.GetInstance()

	var_8.PlayBattleEffect(var_2_8, var_4, arg_2_0:GetExplodePostion())

	return
end

return
