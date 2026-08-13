ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
singletonClass = var_0_10001

local var_0_1 = var_0_10001("BattleHPBarManager")

var_0.Battle.BattleHPBarManager = var_0_1
var_0_1.__name = "BattleHPBarManager"
var_0_1.ROOT_NAME = "HPBarContainer"
var_0_1.HP_BAR_FRIENDLY = "heroBlood"
var_0_1.HP_BAR_FOE = "enemyBlood"
var_0_1.ORIGIN_BAR_WIDTH = {
	heroBlood = 70,
	enemyBlood = 154
}
var_0_1.ORIGIN_PROGRESS_WIDTH = {
	heroBlood = 66,
	enemyBlood = 153
}

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._allPool = {}
	arg_2_0._ob2Pool = {}
	arg_2_0._allPool[var_0_1.HP_BAR_FRIENDLY] = var_0_1.generateTempPool(var_0_1.HP_BAR_FRIENDLY, arg_2_2, arg_2_1, 3, 10)
	arg_2_0._allPool[var_0_1.HP_BAR_FOE] = var_0_1.generateTempPool(var_0_1.HP_BAR_FOE, arg_2_2, arg_2_1, 8, 10)

	return
end

function var_0_1.InitialPoolRoot(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._allPool[var_0_1.HP_BAR_FRIENDLY]

	var_2.ResetParent(var_3_0, arg_3_1)

	local var_3_1 = arg_3_0._allPool[var_0_1.HP_BAR_FOE]

	var_2.ResetParent(var_3_1, arg_3_1)

	return
end

function var_0_1.Clear(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0._allPool) do
		iter_4_1:Dispose()
	end

	arg_4_0._ob2Pool = {}
	arg_4_0._allPool = {}

	return
end

function var_0_1.GetHPBar(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._allPool[arg_5_1]
	local var_5_1 = var_2.GetObject(var_5_0)

	arg_5_0._ob2Pool[var_5_1] = var_2

	local var_5_2 = var_5_1.transform
	local var_5_3 = var_4.Find(var_5_2, "blood")
	local var_5_4 = var_5.GetComponent

	typeof = var_1_10008
	Image = var_1_10009
	var_5_4(var_5_3, var_1_10008(var_1_10009)).fillAmount = 1

	local var_5_5 = var_4

	if var_4.Find(var_5_5, "type") then
		SetActive = var_5_5

		var_5_5(var_6, false)
	end

	local var_5_6 = var_4

	if var_4.Find(var_5_6, "torpedoIcons") then
		SetActive = var_5_6

		var_5_6(var_7, false)
	end

	local var_5_7 = var_4

	if var_4.Find(var_5_7, "biasBar") then
		SetActive = var_5_7

		var_5_7(var_8, false)
	end

	return var_5_1
end

function var_0_1.DestroyObj(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	if arg_6_0._ob2Pool[arg_6_1] then
		var_2:Recycle(arg_6_1)
	else
		Object = var_1_10003

		var_1_10003.Destroy(arg_6_1)
	end

	return
end

Vector3 = var_2

local var_0_2 = var_2(0, 10000, 0)

function var_0_1.HideBullet(arg_7_0)
	arg_7_0.transform.position = var_0_2

	return
end

function var_0_1.generateTempPool(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_2.transform

	var_5.Find(var_8_0, arg_8_0).gameObject.transform.position = var_0_2

	var_6:SetActive(true)

	pg = var_7

	local var_8_1 = var_7.Pool.New(arg_8_1, var_6, arg_8_3, arg_8_4, true, true)

	var_7.SetRecycleFuncs(var_8_1, var_0_1.HideBullet)
	var_7:InitSize()

	return var_7
end

return
