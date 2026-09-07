ys = ys or {}

local var_0_0 = singletonClass("BattleArrowManager")

ys.Battle.BattleArrowManager = var_0_0
var_0_0.__name = "BattleArrowManager"
var_0_0.ROOT_NAME = "EnemyArrowContainer"
var_0_0.ARROW_NAME = "EnemyArrow"

function var_0_0.Ctor(arg_1_0)
	return
end

local var_0_1 = Vector3(0, 10000, 0)

function var_0_0:HideBullet()
	self.transform.position = var_0_1

	return
end

function var_0_0.Init(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:Find(var_0_0.ARROW_NAME).gameObject

	var_3_0.transform.position = var_0_1

	var_3_0:SetActive(true)

	local var_3_1 = pg.Pool.New(arg_3_1, var_3_0, 5, 10, true, true)

	var_3_1:SetRecycleFuncs(var_0_0.HideBullet)
	var_3_1:InitSize()

	arg_3_0._arrowPool = var_3_1

	return
end

function var_0_0:Clear()
	self._arrowPool:Dispose()

	return
end

function var_0_0:GetArrow()
	return (self._arrowPool:GetObject())
end

function var_0_0:DestroyObj(arg_6_1)
	if arg_6_1 == nil then
		return
	end

	self._arrowPool:Recycle(arg_6_1)

	return
end

return
