ys = ys or {}

local var_0_0 = singletonClass("BattleHPBarManager")

ys.Battle.BattleHPBarManager = var_0_0
var_0_0.__name = "BattleHPBarManager"
var_0_0.ROOT_NAME = "HPBarContainer"
var_0_0.HP_BAR_FRIENDLY = "heroBlood"
var_0_0.HP_BAR_FOE = "enemyBlood"
var_0_0.ORIGIN_BAR_WIDTH = {
	heroBlood = 70,
	enemyBlood = 154
}
var_0_0.ORIGIN_PROGRESS_WIDTH = {
	heroBlood = 66,
	enemyBlood = 153
}

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._allPool = {}
	arg_2_0._ob2Pool = {}
	arg_2_0._allPool[var_0_0.HP_BAR_FRIENDLY] = var_0_0.generateTempPool(var_0_0.HP_BAR_FRIENDLY, arg_2_2, arg_2_1, 3, 10)
	arg_2_0._allPool[var_0_0.HP_BAR_FOE] = var_0_0.generateTempPool(var_0_0.HP_BAR_FOE, arg_2_2, arg_2_1, 8, 10)

	return
end

function var_0_0.InitialPoolRoot(arg_3_0, arg_3_1)
	arg_3_0._allPool[var_0_0.HP_BAR_FRIENDLY]:ResetParent(arg_3_1)
	arg_3_0._allPool[var_0_0.HP_BAR_FOE]:ResetParent(arg_3_1)

	return
end

function var_0_0.Clear(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._allPool) do
		iter_4_1:Dispose()
	end

	arg_4_0._ob2Pool = {}
	arg_4_0._allPool = {}

	return
end

function var_0_0.GetHPBar(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._allPool[arg_5_1]:GetObject()

	arg_5_0._ob2Pool[var_5_0] = arg_5_0._allPool[arg_5_1]
	var_5_0.transform:Find("blood"):GetComponent(typeof(Image)).fillAmount = 1

	local var_5_1 = var_5_0.transform:Find("type")

	if var_5_1 then
		SetActive(var_5_1, false)
	end

	local var_5_2 = var_5_0.transform:Find("torpedoIcons")

	if var_5_2 then
		SetActive(var_5_2, false)
	end

	local var_5_3 = var_5_0.transform:Find("biasBar")

	if var_5_3 then
		SetActive(var_5_3, false)
	end

	return var_5_0
end

function var_0_0.DestroyObj(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	if arg_6_0._ob2Pool[arg_6_1] then
		var_6_0:Recycle(arg_6_1)
	else
		Object.Destroy(arg_6_1)
	end

	return
end

local var_0_1 = Vector3(0, 10000, 0)

function var_0_0.HideBullet(arg_7_0)
	arg_7_0.transform.position = var_0_1

	return
end

function var_0_0.generateTempPool(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_2.transform:Find(arg_8_0).gameObject

	var_8_0.transform.position = var_0_1

	var_8_0:SetActive(true)

	local var_8_1 = pg.Pool.New(arg_8_1, var_8_0, arg_8_3, arg_8_4, true, true)

	var_8_1:SetRecycleFuncs(var_0_0.HideBullet)
	var_8_1:InitSize()

	return var_8_1
end

return
