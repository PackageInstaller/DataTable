ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig

class = var_0_10004

local var_0_4 = var_0_10004("BattleReferenceBoxMediator", var_0.MVC.Mediator)

var_0.Battle.BattleReferenceBoxMediator = var_0_4
var_0_4.__name = "BattleReferenceBoxMediator"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.Initialize(arg_2_0)
	var_0_4.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	local var_2_1 = arg_2_0._state

	arg_2_0._sceneMediator = var_1.GetSceneMediator(var_2_1)
	GameObject = var_1
	arg_2_0._boxContainer = var_1("BoxContainer")

	local var_2_2 = arg_2_0._state
	local var_2_3 = var_1.GetUI(var_2_2)._tf

	arg_2_0._detailContainer = var_1.Find(var_2_3, "CharacterDetailContainer").gameObject
	arg_2_0._unitBoxList = {}
	arg_2_0._bulletBoxList = {}
	arg_2_0._wallBoxList = {}
	arg_2_0._detailViewList = {}
	arg_2_0._unitBoxActive = false
	arg_2_0._bulletBoxActive = false
	arg_2_0._detailViewActive = false

	arg_2_0:initUnitEvent()

	return
end

function var_0_4.ActiveUnitBoxes(arg_3_0, arg_3_1)
	if arg_3_1 and not arg_3_0._unitBoxActive then
		arg_3_0._unitBoxActive = true

		arg_3_0:createExistBoxes()
	elseif not arg_3_1 and arg_3_0._unitBoxActive then
		arg_3_0._unitBoxActive = false

		arg_3_0:removeAllBoxes()
	end

	return
end

function var_0_4.ActiveBulletBoxes(arg_4_0, arg_4_1)
	if arg_4_1 and not arg_4_0._bulletBoxActive then
		arg_4_0:initBulletEvent()

		arg_4_0._bulletBoxActive = true
	elseif not arg_4_1 and arg_4_0._bulletBoxActive then
		arg_4_0:disInitBulletEvent()
		arg_4_0:removeAllBulletBoxes()

		arg_4_0._bulletBoxActive = false
	end

	return
end

function var_0_4.ActiveUnitDetail(arg_5_0, arg_5_1)
	SetActive = var_1_10002

	var_1_10002(arg_5_0._detailContainer, arg_5_1)

	if arg_5_1 and not arg_5_0._detailViewActive then
		ipairs = var_2

		local var_5_0 = arg_5_0._dataProxy

		for iter_5_0, iter_5_1 in var_2(var_3.GetFleetList(var_5_0)) do
			local var_5_1 = iter_5_1

			var_1_10007 = iter_5_1.GetUnitList(var_5_1)
			ipairs = var_5_1

			for iter_5_2, iter_5_3 in var_5_1(var_1_10007) do
				arg_5_0:createDetail(iter_5_3)
			end
		end

		pairs = var_2

		local var_5_2 = arg_5_0._dataProxy

		for iter_5_4, iter_5_5 in var_2(var_3.GetUnitList(var_5_2)) do
			table = var_1_10007

			if var_1_10007.contains(var_0.Battle.BattleUnitDetailView.EnemyMarkList, iter_5_5:GetTemplate().id) then
				local var_5_3 = arg_5_0

				var_1_10007 = arg_5_0.createDetail
				unit = var_9

				var_1_10007(var_5_3, var_9)
			end
		end

		arg_5_0._detailViewActive = true
	elseif not arg_5_1 and arg_5_0._detailViewActive then
		arg_5_0._detailViewActive = false

		arg_5_0:removeAllDetail()
	end

	return
end

function var_0_4.Update(arg_6_0)
	pairs = var_1_10001

	local var_6_0 = arg_6_0._dataProxy

	for iter_6_0, iter_6_1 in var_1_10001(var_2.GetUnitList(var_6_0)) do
		if arg_6_0._unitBoxList[iter_6_0] then
			var_6.transform.localPosition = iter_6_1:GetPosition()
		end
	end

	if arg_6_0._bulletBoxActive then
		pairs = var_1

		local var_6_1 = arg_6_0._dataProxy

		for iter_6_2, iter_6_3 in var_1(var_2.GetBulletList(var_6_1)) do
			local var_6_2

			if not arg_6_0._bulletBoxList[iter_6_2] then
				var_6_2 = arg_6_0:createBulletBox(iter_6_3)
			end

			var_6_2.transform.localPosition = iter_6_3:GetPosition()

			local var_6_3 = var_6_2.transform

			Vector3 = var_8
			var_6_3.localEulerAngles = var_8(0, -iter_6_3:GetYAngle(), 0)

			local var_6_4 = iter_6_3:GetBoxSize() * 2
			local var_6_5 = var_6_2.transform

			Vector3 = var_9
			var_6_5.localScale = var_9(var_6_4.x, var_6_4.y, var_6_4.z)
		end

		pairs = var_1

		local var_6_6 = arg_6_0._dataProxy

		for iter_6_4, iter_6_5 in var_1(var_2.GetWallList(var_6_6)) do
			local var_6_7

			if not arg_6_0._wallBoxList[iter_6_4] then
				var_6_7 = arg_6_0:createWallBox(iter_6_5)
			end

			var_6_7.transform.localPosition = iter_6_5:GetPosition()
		end
	end

	if arg_6_0._detailViewActive then
		pairs = var_1

		for iter_6_6, iter_6_7 in var_1(arg_6_0._detailViewList) do
			iter_6_7:Update()
		end
	end

	return
end

function var_0_4.initUnitEvent(arg_7_0)
	local var_7_0 = arg_7_0._dataProxy

	var_1.RegisterEventListener(var_7_0, arg_7_0, var_0_1.ADD_UNIT, arg_7_0.onAddUnit)

	local var_7_1 = arg_7_0._dataProxy

	var_1.RegisterEventListener(var_7_1, arg_7_0, var_0_1.REMOVE_UNIT, arg_7_0.onRemoveUnit)

	return
end

function var_0_4.disInitUnitEvent(arg_8_0)
	local var_8_0 = arg_8_0._dataProxy

	var_1.UnregisterEventListener(var_8_0, arg_8_0, var_0_1.ADD_UNIT)

	local var_8_1 = arg_8_0._dataProxy

	var_1.UnregisterEventListener(var_8_1, arg_8_0, var_0_1.REMOVE_UNIT)

	return
end

function var_0_4.onAddUnit(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.Data.type
	local var_9_1 = arg_9_1.Data.unit

	if arg_9_0._unitBoxActive then
		local var_9_2 = arg_9_0:createBox(var_9_1)

		arg_9_0._unitBoxList[var_9_1:GetUniqueID()] = var_9_2
	end

	if arg_9_0._detailViewActive then
		if var_9_0 == var_0_2.UnitType.PLAYER_UNIT then
			arg_9_0:createDetail(var_9_1)
		else
			table = var_4

			if var_4.contains(var_0.Battle.BattleUnitDetailView.EnemyMarkList, var_9_1:GetTemplate().id) then
				arg_9_0:createDetail(var_9_1)
			end
		end
	end

	return
end

function var_0_4.createBox(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1
	local var_10_2
	local var_10_3 = arg_10_1:GetIFF() == 1 and "_friendly" or "_foe"
	local var_10_6

	if arg_10_1:GetBoxSize().range then
		local var_10_4 = arg_10_0._sceneMediator

		var_10_0 = var_6.InstantiateCharacterComponent(var_10_4, "Cylinder" .. var_10_3)
	else
		local var_10_5 = arg_10_0._sceneMediator

		var_10_0 = var_6.InstantiateCharacterComponent(var_10_5, "Cube" .. var_10_3)
		var_10_6 = var_10_6 * 2
	end

	local var_10_7 = var_10_0.transform

	var_6.SetParent(var_10_7, arg_10_0._boxContainer.transform)

	LayerMask = var_6
	var_10_0.layer = var_6.NameToLayer("Default")

	local var_10_8

	if var_10_6.range then
		var_10_8 = var_10_0.transform
		Vector3 = var_7
		var_10_8.localScale = var_7(var_10_6.range * 2, var_10_6.tickness * 2, var_10_6.range * 2)
	else
		var_10_8 = var_10_0.transform
		Vector3 = var_7
		var_10_8.localScale = var_7(var_10_6.x, var_10_6.y, var_10_6.z)
	end

	SetActive = var_10_8

	var_10_8(var_10_0, true)

	return var_10_0
end

function var_0_4.createExistBoxes(arg_11_0)
	pairs = var_1_10001

	local var_11_0 = arg_11_0._dataProxy

	for iter_11_0, iter_11_1 in var_1_10001(var_2.GetUnitList(var_11_0)) do
		arg_11_0._unitBoxList[iter_11_0] = arg_11_0:createBox(iter_11_1)
	end

	return
end

function var_0_4.createDetail(arg_12_0, arg_12_1)
	local var_12_0 = var_0.Battle.BattleUnitDetailView.New()
	local var_12_1 = arg_12_1:GetIFF()
	local var_12_2 = arg_12_0._state
	local var_12_3 = var_4.GetUI(var_12_2)._tf
	local var_12_4 = var_4.Find(var_12_3, "CharacterDetailContainer/" .. arg_12_1:GetIFF())
	local var_12_5 = arg_12_0._sceneMediator
	local var_12_6 = var_5.InstantiateCharacterComponent(var_12_5, "CharacterDetailContainer/detailPanel").transform

	var_6.SetParent(var_12_6, var_12_4, true)
	var_12_0:ConfigSkin(var_5)
	var_12_0:SetUnit(arg_12_1)

	arg_12_0._detailViewList[arg_12_1:GetUniqueID()] = var_12_0

	return var_12_0
end

function var_0_4.onRemoveUnit(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.Data.type

	if arg_13_0._unitBoxActive then
		arg_13_0:removeBox(arg_13_1.Data.UID)
	end

	if arg_13_0._detailViewActive and (var_13_0 ~= var_0_2.UnitType.PLAYER_UNIT or var_13_0 ~= var_0_2.UnitType.ENEMY_UNIT or var_13_0 ~= var_0_2.UnitType.BOSS_UNIT) and arg_13_0._detailViewList[arg_13_1.Data.UID] then
		arg_13_0:removeDetail(arg_13_1.Data.UID)
	end

	return
end

function var_0_4.removeBox(arg_14_0, arg_14_1)
	GameObject = var_1_10002

	var_1_10002.Destroy(arg_14_0._unitBoxList[arg_14_1])

	arg_14_0._unitBoxList[arg_14_1] = nil

	return
end

function var_0_4.removeDetail(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._detailViewList[arg_15_1]

	var_2.Dispose(var_15_0)

	arg_15_0._detailViewList[arg_15_1] = nil

	return
end

function var_0_4.removeAllBoxes(arg_16_0)
	pairs = var_1_10001

	local var_16_0 = arg_16_0._dataProxy

	for iter_16_0, iter_16_1 in var_1_10001(var_2.GetUnitList(var_16_0)) do
		arg_16_0:removeBox(iter_16_0)
	end

	return
end

function var_0_4.removeAllDetail(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0._detailViewList) do
		arg_17_0:removeDetail(iter_17_0)
	end

	return
end

function var_0_4.initBulletEvent(arg_18_0)
	local var_18_0 = arg_18_0._dataProxy

	var_1.RegisterEventListener(var_18_0, arg_18_0, var_0_1.REMOVE_BULLET, arg_18_0.onRemoveBullet)

	return
end

function var_0_4.disInitBulletEvent(arg_19_0)
	local var_19_0 = arg_19_0._dataProxy

	var_1.UnregisterEventListener(var_19_0, arg_19_0, var_0_1.REMOVE_BULLET)

	return
end

function var_0_4.onRemoveBullet(arg_20_0, arg_20_1)
	arg_20_0:removeBulletBox(arg_20_1.Data.UID)

	return
end

function var_0_4.removeBulletBox(arg_21_0, arg_21_1)
	GameObject = var_1_10002

	var_1_10002.Destroy(arg_21_0._bulletBoxList[arg_21_1])

	arg_21_0._bulletBoxList[arg_21_1] = nil

	return
end

function var_0_4.removeAllBulletBoxes(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0._bulletBoxList) do
		arg_22_0:removeBulletBox(iter_22_0)
	end

	return
end

function var_0_4.createBulletBox(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_1:GetIFF() == 1 then
		local var_23_1 = arg_23_0._sceneMediator

		var_23_0 = var_3.InstantiateCharacterComponent(var_23_1, "Cube_friendly")
	else
		local var_23_2 = arg_23_0._sceneMediator

		var_23_0 = var_3.InstantiateCharacterComponent(var_23_2, "Cube_foe")
	end

	local var_23_3 = var_23_0.transform

	var_3.SetParent(var_23_3, arg_23_0._boxContainer.transform)

	LayerMask = var_3
	var_23_0.layer = var_3.NameToLayer("Default")

	local var_23_4 = arg_23_1:GetBoxSize() * 2
	local var_23_5 = var_23_0.transform

	Vector3 = var_5
	var_23_5.localScale = var_5(var_23_4.x, var_23_4.y, var_23_4.z)
	SetActive = var_23_5

	var_23_5(var_23_0, true)

	arg_23_0._bulletBoxList[arg_23_1:GetUniqueID()] = var_23_0

	return var_23_0
end

function var_0_4.createWallBox(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:createBox(arg_24_1)

	arg_24_0._wallBoxList[arg_24_1:GetUniqueID()] = var_24_0

	return var_24_0
end

function var_0_4.Dispose(arg_25_0)
	arg_25_0:disInitUnitEvent()

	pairs = var_1

	for iter_25_0, iter_25_1 in var_1(arg_25_0._unitBoxList) do
		GameObject = var_1_10006

		var_1_10006.Destroy(iter_25_1)
	end

	pairs = var_1

	for iter_25_2, iter_25_3 in var_1(arg_25_0._bulletBoxList) do
		GameObject = var_1_10006

		var_1_10006.Destroy(iter_25_3)
	end

	pairs = var_1

	for iter_25_4, iter_25_5 in var_1(arg_25_0._wallBoxList) do
		GameObject = var_1_10006

		var_1_10006.Destroy(iter_25_5)
	end

	arg_25_0._unitBoxList = nil
	arg_25_0._wallBoxList = nil
	arg_25_0._bulletBoxList = nil

	arg_25_0:removeAllDetail()

	arg_25_0._detailViewList = nil
	GameObject = var_1

	var_1.Destroy(arg_25_0._boxContainer)
	var_0_4.super.Dispose(arg_25_0)

	return
end

return
