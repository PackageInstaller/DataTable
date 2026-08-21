ys = ys or {}

local var_0_0 = ys.Battle.BattleEvent
local var_0_1 = ys.Battle.BattleConst
local var_0_3 = class("BattleReferenceBoxMediator", ys.MVC.Mediator)

ys.Battle.BattleReferenceBoxMediator = var_0_3
var_0_3.__name = "BattleReferenceBoxMediator"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Initialize(arg_2_0)
	var_0_3.super.Initialize(arg_2_0)

	arg_2_0._dataProxy = arg_2_0._state:GetProxyByName(var_0.Battle.BattleDataProxy.__name)
	arg_2_0._sceneMediator = arg_2_0._state:GetSceneMediator()
	arg_2_0._boxContainer = GameObject("BoxContainer")
	arg_2_0._detailContainer = arg_2_0._state:GetUI()._tf:Find("CharacterDetailContainer").gameObject
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

function var_0_3.ActiveUnitBoxes(arg_3_0, arg_3_1)
	if arg_3_1 and not arg_3_0._unitBoxActive then
		arg_3_0._unitBoxActive = true

		arg_3_0:createExistBoxes()
	elseif not arg_3_1 and arg_3_0._unitBoxActive then
		arg_3_0._unitBoxActive = false

		arg_3_0:removeAllBoxes()
	end

	return
end

function var_0_3.ActiveBulletBoxes(arg_4_0, arg_4_1)
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

function var_0_3.ActiveUnitDetail(arg_5_0, arg_5_1)
	SetActive(arg_5_0._detailContainer, arg_5_1)

	if arg_5_1 and not arg_5_0._detailViewActive then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._dataProxy:GetFleetList()) do
			for iter_5_2, iter_5_3 in ipairs((iter_5_1:GetUnitList())) do
				arg_5_0:createDetail(iter_5_3)
			end
		end

		for iter_5_4, iter_5_5 in pairs(arg_5_0._dataProxy:GetUnitList()) do
			if table.contains(var_0.Battle.BattleUnitDetailView.EnemyMarkList, iter_5_5:GetTemplate().id) then
				arg_5_0:createDetail(unit)
			end
		end

		arg_5_0._detailViewActive = true
	elseif not arg_5_1 and arg_5_0._detailViewActive then
		arg_5_0._detailViewActive = false

		arg_5_0:removeAllDetail()
	end

	return
end

function var_0_3.Update(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._dataProxy:GetUnitList()) do
		if arg_6_0._unitBoxList[iter_6_0] then
			arg_6_0._unitBoxList[iter_6_0].transform.localPosition = iter_6_1:GetPosition()
		end
	end

	if arg_6_0._bulletBoxActive then
		for iter_6_2, iter_6_3 in pairs(arg_6_0._dataProxy:GetBulletList()) do
			local var_6_0 = arg_6_0._bulletBoxList[iter_6_2] or arg_6_0:createBulletBox(iter_6_3)

			var_6_0.transform.localPosition = iter_6_3:GetPosition()
			var_6_0.transform.localEulerAngles = Vector3(0, -iter_6_3:GetYAngle(), 0)

			local var_6_1 = iter_6_3:GetBoxSize() * 2

			var_6_0.transform.localScale = Vector3(var_6_1.x, var_6_1.y, var_6_1.z)
		end

		for iter_6_4, iter_6_5 in pairs(arg_6_0._dataProxy:GetWallList()) do
			local var_6_2 = arg_6_0._wallBoxList[iter_6_4] or arg_6_0:createWallBox(iter_6_5)

			var_6_2.transform.localPosition = iter_6_5:GetPosition()
		end
	end

	if arg_6_0._detailViewActive then
		for iter_6_6, iter_6_7 in pairs(arg_6_0._detailViewList) do
			iter_6_7:Update()
		end
	end

	return
end

function var_0_3.initUnitEvent(arg_7_0)
	arg_7_0._dataProxy:RegisterEventListener(arg_7_0, var_0_0.ADD_UNIT, arg_7_0.onAddUnit)
	arg_7_0._dataProxy:RegisterEventListener(arg_7_0, var_0_0.REMOVE_UNIT, arg_7_0.onRemoveUnit)

	return
end

function var_0_3.disInitUnitEvent(arg_8_0)
	arg_8_0._dataProxy:UnregisterEventListener(arg_8_0, var_0_0.ADD_UNIT)
	arg_8_0._dataProxy:UnregisterEventListener(arg_8_0, var_0_0.REMOVE_UNIT)

	return
end

function var_0_3.onAddUnit(arg_9_0, arg_9_1)
	if arg_9_0._unitBoxActive then
		arg_9_0._unitBoxList[arg_9_1.Data.unit:GetUniqueID()] = arg_9_0:createBox(arg_9_1.Data.unit)
	end

	if arg_9_0._detailViewActive then
		if arg_9_1.Data.type == var_0_1.UnitType.PLAYER_UNIT then
			arg_9_0:createDetail(arg_9_1.Data.unit)
		elseif table.contains(var_0.Battle.BattleUnitDetailView.EnemyMarkList, arg_9_1.Data.unit:GetTemplate().id) then
			arg_9_0:createDetail(arg_9_1.Data.unit)
		end
	end

	return
end

function var_0_3.createBox(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_2 = arg_10_1:GetIFF() == 1 and "_friendly" or "_foe"
	local var_10_3 = arg_10_1:GetBoxSize()

	if var_10_3.range then
		var_10_0 = arg_10_0._sceneMediator:InstantiateCharacterComponent("Cylinder" .. nil)
	else
		var_10_0 = arg_10_0._sceneMediator:InstantiateCharacterComponent("Cube" .. nil)
		var_10_3 = var_10_3 * 2
	end

	var_10_0.transform:SetParent(arg_10_0._boxContainer.transform)

	var_10_0.layer = LayerMask.NameToLayer("Default")
	var_10_0.transform.localScale = var_10_3.range and Vector3(var_10_3.range * 2, var_10_3.tickness * 2, var_10_3.range * 2) or Vector3(var_10_3.x, var_10_3.y, var_10_3.z)

	SetActive(var_10_0, true)

	return var_10_0
end

function var_0_3.createExistBoxes(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._dataProxy:GetUnitList()) do
		arg_11_0._unitBoxList[iter_11_0] = arg_11_0:createBox(iter_11_1)
	end

	return
end

function var_0_3.createDetail(arg_12_0, arg_12_1)
	local var_12_0 = var_0.Battle.BattleUnitDetailView.New()
	local var_12_1 = arg_12_1:GetIFF()
	local var_12_2 = arg_12_0._sceneMediator:InstantiateCharacterComponent("CharacterDetailContainer/detailPanel")

	var_12_2.transform:SetParent(arg_12_0._state:GetUI()._tf:Find("CharacterDetailContainer/" .. arg_12_1:GetIFF()), true)
	var_12_0:ConfigSkin(var_12_2)
	var_12_0:SetUnit(arg_12_1)

	arg_12_0._detailViewList[arg_12_1:GetUniqueID()] = var_12_0

	return var_12_0
end

function var_0_3.onRemoveUnit(arg_13_0, arg_13_1)
	if arg_13_0._unitBoxActive then
		arg_13_0:removeBox(arg_13_1.Data.UID)
	end

	if arg_13_0._detailViewActive and (arg_13_1.Data.type ~= var_0_1.UnitType.PLAYER_UNIT or arg_13_1.Data.type ~= var_0_1.UnitType.ENEMY_UNIT or arg_13_1.Data.type ~= var_0_1.UnitType.BOSS_UNIT) and arg_13_0._detailViewList[arg_13_1.Data.UID] then
		arg_13_0:removeDetail(arg_13_1.Data.UID)
	end

	return
end

function var_0_3.removeBox(arg_14_0, arg_14_1)
	GameObject.Destroy(arg_14_0._unitBoxList[arg_14_1])

	arg_14_0._unitBoxList[arg_14_1] = nil

	return
end

function var_0_3.removeDetail(arg_15_0, arg_15_1)
	arg_15_0._detailViewList[arg_15_1]:Dispose()

	arg_15_0._detailViewList[arg_15_1] = nil

	return
end

function var_0_3.removeAllBoxes(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._dataProxy:GetUnitList()) do
		arg_16_0:removeBox(iter_16_0)
	end

	return
end

function var_0_3.removeAllDetail(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._detailViewList) do
		arg_17_0:removeDetail(iter_17_0)
	end

	return
end

function var_0_3.initBulletEvent(arg_18_0)
	arg_18_0._dataProxy:RegisterEventListener(arg_18_0, var_0_0.REMOVE_BULLET, arg_18_0.onRemoveBullet)

	return
end

function var_0_3.disInitBulletEvent(arg_19_0)
	arg_19_0._dataProxy:UnregisterEventListener(arg_19_0, var_0_0.REMOVE_BULLET)

	return
end

function var_0_3.onRemoveBullet(arg_20_0, arg_20_1)
	arg_20_0:removeBulletBox(arg_20_1.Data.UID)

	return
end

function var_0_3.removeBulletBox(arg_21_0, arg_21_1)
	GameObject.Destroy(arg_21_0._bulletBoxList[arg_21_1])

	arg_21_0._bulletBoxList[arg_21_1] = nil

	return
end

function var_0_3.removeAllBulletBoxes(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._bulletBoxList) do
		arg_22_0:removeBulletBox(iter_22_0)
	end

	return
end

function var_0_3.createBulletBox(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:GetIFF() == 1 and arg_23_0._sceneMediator:InstantiateCharacterComponent("Cube_friendly") or arg_23_0._sceneMediator:InstantiateCharacterComponent("Cube_foe")

	var_23_0.transform:SetParent(arg_23_0._boxContainer.transform)

	var_23_0.layer = LayerMask.NameToLayer("Default")

	local var_23_1 = arg_23_1:GetBoxSize() * 2

	var_23_0.transform.localScale = Vector3(var_23_1.x, var_23_1.y, var_23_1.z)

	SetActive(var_23_0, true)

	arg_23_0._bulletBoxList[arg_23_1:GetUniqueID()] = var_23_0

	return var_23_0
end

function var_0_3.createWallBox(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:createBox(arg_24_1)

	arg_24_0._wallBoxList[arg_24_1:GetUniqueID()] = var_24_0

	return var_24_0
end

function var_0_3.Dispose(arg_25_0)
	arg_25_0:disInitUnitEvent()

	for iter_25_0, iter_25_1 in pairs(arg_25_0._unitBoxList) do
		GameObject.Destroy(iter_25_1)
	end

	for iter_25_2, iter_25_3 in pairs(arg_25_0._bulletBoxList) do
		GameObject.Destroy(iter_25_3)
	end

	for iter_25_4, iter_25_5 in pairs(arg_25_0._wallBoxList) do
		GameObject.Destroy(iter_25_5)
	end

	arg_25_0._unitBoxList = nil
	arg_25_0._wallBoxList = nil
	arg_25_0._bulletBoxList = nil

	arg_25_0:removeAllDetail()

	arg_25_0._detailViewList = nil

	GameObject.Destroy(arg_25_0._boxContainer)
	var_0_3.super.Dispose(arg_25_0)

	return
end

return
