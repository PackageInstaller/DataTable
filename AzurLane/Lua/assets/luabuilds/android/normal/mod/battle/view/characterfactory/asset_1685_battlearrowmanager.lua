ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleArrowManager")

var_0.Battle.BattleArrowManager = var_0_1
var_0_1.__name = "BattleArrowManager"
var_0_1.ROOT_NAME = "EnemyArrowContainer"
var_0_1.ARROW_NAME = "EnemyArrow"

function var_0_1.Ctor(arg_1_0)
	return
end

Vector3 = var_2

local var_0_2 = var_2(0, 10000, 0)

function var_0_1.HideBullet(arg_2_0)
	arg_2_0.transform.position = var_0_2

	return
end

function var_0_1.Init(arg_3_0, arg_3_1)
	arg_3_1:Find(var_0_1.ARROW_NAME).gameObject.transform.position = var_0_2

	var_2:SetActive(true)

	pg = var_3

	local var_3_0 = var_3.Pool.New(arg_3_1, var_2, 5, 10, true, true)

	var_3.SetRecycleFuncs(var_3_0, var_0_1.HideBullet)
	var_3:InitSize()

	arg_3_0._arrowPool = var_3

	return
end

function var_0_1.Clear(arg_4_0)
	local var_4_0 = arg_4_0._arrowPool

	var_1.Dispose(var_4_0)

	return
end

function var_0_1.GetArrow(arg_5_0)
	local var_5_0 = arg_5_0._arrowPool

	return (var_1.GetObject(var_5_0))
end

function var_0_1.DestroyObj(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	local var_6_0 = arg_6_0._arrowPool

	var_2.Recycle(var_6_0, arg_6_1)

	return
end

return
