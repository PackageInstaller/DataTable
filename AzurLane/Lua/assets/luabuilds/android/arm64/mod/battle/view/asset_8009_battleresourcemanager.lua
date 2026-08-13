ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig

require = var_0_10004

local var_0_4 = var_0_10004("Mgr/Pool/PoolUtil")

singletonClass = var_0_10005

local var_0_5 = var_0_10005("BattleResourceManager")

var_0.Battle.BattleResourceManager = var_0_5
var_0_5.__name = "BattleResourceManager"

function var_0_5.Ctor(arg_1_0)
	setmetatable = var_1_10001
	arg_1_0.rotateScriptMap = var_1_10001({}, {
		__mode = "kv"
	})

	return
end

function var_0_5.Init(arg_2_0)
	arg_2_0._preloadList = {}
	arg_2_0._resCacheList = {}
	arg_2_0._allPool = {}
	arg_2_0._ob2Pool = {}
	GameObject = var_1

	local var_2_0 = var_1()

	var_1.SetActive(var_2_0, false)

	var_1.name = "PoolRoot"

	local var_2_1 = var_1.transform

	Vector3 = var_1_10003
	var_2_1.position = var_1_10003(-10000, -10000, 0)
	arg_2_0._poolRoot = var_1
	GameObject = var_2_1
	arg_2_0._bulletContainer = var_2_1("BulletContainer")
	arg_2_0._battleCVList = {}

	return
end

function var_0_5.Clear(arg_3_0)
	pairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._allPool) do
		iter_3_1:Dispose()
	end

	pairs = var_1

	for iter_3_2, iter_3_3 in var_1(arg_3_0._resCacheList) do
		string = var_1_10006

		if var_1_10006.find(iter_3_2, "Char/") then
			var_0_5.ClearCharRes(iter_3_2, iter_3_3)
		else
			string = var_1_10006

			if var_1_10006.find(iter_3_2, "painting/") then
				var_0_5.ClearPaintingRes(iter_3_2, iter_3_3)
			else
				var_0_4.Destroy(iter_3_3)
			end
		end
	end

	arg_3_0._resCacheList = {}
	arg_3_0._ob2Pool = {}
	arg_3_0._allPool = {}
	Object = var_1

	var_1.Destroy(arg_3_0._poolRoot)

	arg_3_0._poolRoot = nil
	Object = var_1

	var_1.Destroy(arg_3_0._bulletContainer)

	arg_3_0._bulletContainer = nil
	setmetatable = var_1
	arg_3_0.rotateScriptMap = var_1({}, {
		__mode = "kv"
	})
	pairs = var_1

	for iter_3_4, iter_3_5 in var_1(arg_3_0._battleCVList) do
		pg = var_1_10006

		var_1_10006.CriMgr.UnloadCVBank(iter_3_5)
	end

	arg_3_0._battleCVList = {}

	var_0.Battle.BattleDataFunction.ClearConvertedBarrage()

	return
end

function var_0_5.GetBulletPath(arg_4_0)
	return "Item/" .. arg_4_0
end

function var_0_5.GetOrbitPath(arg_5_0)
	return "orbit/" .. arg_5_0
end

function var_0_5.GetCharacterPath(arg_6_0)
	return "Char/" .. arg_6_0
end

function var_0_5.GetCharacterGoPath(arg_7_0)
	return "chargo/" .. arg_7_0
end

function var_0_5.GetAircraftIconPath(arg_8_0)
	return "AircraftIcon/" .. arg_8_0
end

function var_0_5.GetFXPath(arg_9_0)
	return "Effect/" .. arg_9_0
end

function var_0_5.GetPaintingPath(arg_10_0)
	return "painting/" .. arg_10_0
end

function var_0_5.GetHrzIcon(arg_11_0)
	return "herohrzicon/" .. arg_11_0
end

function var_0_5.GetSquareIcon(arg_12_0)
	return "squareicon/" .. arg_12_0
end

function var_0_5.GetQIcon(arg_13_0)
	return "qicon/" .. arg_13_0
end

function var_0_5.GetCommanderHrzIconPath(arg_14_0)
	return "commanderhrz/" .. arg_14_0
end

function var_0_5.GetCommanderIconPath(arg_15_0)
	return "commandericon/" .. arg_15_0
end

function var_0_5.GetShipTypeIconPath(arg_16_0)
	return "shiptype/" .. arg_16_0
end

function var_0_5.GetMapPath(arg_17_0)
	return "Map/" .. arg_17_0
end

function var_0_5.GetUIPath(arg_18_0)
	return "UI/" .. arg_18_0
end

function var_0_5.GetResName(arg_19_0)
	local var_19_0 = arg_19_0

	string = var_1_10002

	local var_19_1 = var_1_10002.find(var_19_0, "%/")

	while var_19_1 do
		string = var_1_10003
		var_19_0 = var_1_10003.sub(var_19_0, var_19_1 + 1)
		string = var_1_10003
		var_19_1 = var_1_10003.find(var_19_0, "%/")
	end

	return var_19_0
end

function var_0_5.ClearCharRes(arg_20_0, arg_20_1)
	local var_20_0 = var_0_5.GetResName(arg_20_0)
	local var_20_1 = arg_20_1:GetComponent("SkeletonRenderer").skeletonDataAsset

	PoolMgr = var_4

	local var_20_2 = var_4.GetInstance()

	if not var_4.IsSpineSkelCached(var_20_2, var_20_0) then
		UIUtil = var_4

		var_4.ClearSharedMaterial(arg_20_1)
	end

	var_0_4.Destroy(arg_20_1)

	return
end

function var_0_5.ClearPaintingRes(arg_21_0, arg_21_1)
	local var_21_0 = var_0_5.GetResName(arg_21_0)

	PoolMgr = var_1_10003

	local var_21_1 = var_1_10003.GetInstance()

	var_3.ReturnPainting(var_21_1, var_0_5.GetPaintingName(var_21_0), arg_21_1)

	return
end

function var_0_5.DestroyOb(arg_22_0, arg_22_1)
	if arg_22_1 ~= nil then
		IsNil = var_1_10002

		if var_1_10002(arg_22_1) then
			return
		end

		local var_22_0 = arg_22_0._ob2Pool[arg_22_1]

		arg_22_0._ob2Pool[arg_22_1] = nil

		if var_22_0 then
			var_22_0:Recycle(arg_22_1)
		else
			var_0_4.Destroy(arg_22_1)
		end

		return
	end
end

function var_0_5.popPool(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:GetObject()

	if not arg_23_2 then
		var_23_0.transform.parent = nil
	end

	arg_23_0._ob2Pool[var_23_0] = arg_23_1

	return var_23_0
end

function var_0_5.InstCharacter(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.GetCharacterPath(arg_24_1)
	local var_24_2

	if arg_24_0._allPool[var_24_0] then
		local var_24_1 = arg_24_0:popPool(var_24_2)

		arg_24_2(var_24_1)
	elseif arg_24_0._resCacheList[var_24_0] ~= nil then
		arg_24_0:InitPool(var_24_0, arg_24_0._resCacheList[var_24_0])

		var_24_2 = arg_24_0._allPool[var_24_0]

		local var_24_3 = arg_24_0:popPool(var_24_2)

		arg_24_2(var_24_3)
	else
		arg_24_0:LoadSpineAsset(arg_24_1, function(arg_25_0)
			if not arg_24_0._poolRoot then
				var_0_5.ClearCharRes(var_24_0, arg_25_0)

				return
			end

			assert = var_1

			var_1(arg_25_0, "角色资源加载失败：" .. arg_24_1)

			SpineAnim = var_1

			local var_25_0 = var_1.AnimChar(arg_24_1, arg_25_0)

			var_1.SetActive(var_25_0, false)

			local var_25_1 = arg_24_0

			var_2.InitPool(var_25_1, var_24_0, var_1)

			var_24_2 = arg_24_0._allPool[var_24_0]

			local var_25_2 = arg_24_0
			local var_25_3 = var_2.popPool(var_25_2, var_24_2)

			arg_24_2(var_25_3)

			return
		end)
	end

	return
end

function var_0_5.LoadSpineAsset(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.GetCharacterPath(arg_26_1)

	PoolMgr = var_1_10004

	local var_26_1 = var_1_10004.GetInstance()
	local var_26_3

	if not var_4.IsSpineSkelCached(var_26_1, arg_26_1) then
		ResourceMgr = var_26_3

		local var_26_2 = var_26_3.Inst

		var_26_3 = var_26_3.getAssetAsync

		local var_26_4 = var_26_0
		local var_26_5 = ""

		UnityEngine = var_1_10009

		var_26_3(var_26_2, var_26_4, var_26_5, var_1_10009.Events.UnityAction_UnityEngine_Object(function(arg_27_0)
			arg_26_2(arg_27_0)

			return
		end), true, true)
	else
		PoolMgr = var_26_3

		local var_26_6 = var_26_3.GetInstance()

		var_4.GetSpineSkel(var_26_6, arg_26_1, true, arg_26_2)
	end

	return
end

function var_0_5.InstAirCharacter(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.GetCharacterGoPath(arg_28_1)
	local var_28_2

	if arg_28_0._allPool[var_28_0] then
		local var_28_1 = arg_28_0:popPool(var_28_2)

		arg_28_2(var_28_1)
	else
		local var_28_3

		if arg_28_0._resCacheList[var_28_0] ~= nil then
			arg_28_0:InitPool(var_28_0, arg_28_0._resCacheList[var_28_0])

			var_28_2 = arg_28_0._allPool[var_28_0]
			var_28_3 = arg_28_0:popPool(var_28_2)

			arg_28_2(var_28_3)
		else
			ResourceMgr = var_28_3

			local var_28_4 = var_28_3.Inst
			local var_28_5 = var_5.getAssetAsync
			local var_28_6 = var_28_0
			local var_28_7 = ""

			UnityEngine = var_1_10010

			var_28_5(var_28_4, var_28_6, var_28_7, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_29_0)
				if not arg_28_0._poolRoot then
					var_0_4.Destroy(arg_29_0)

					return
				else
					assert = var_1

					var_1(arg_29_0, "飞机资源加载失败：" .. arg_28_1)

					local var_29_0 = arg_28_0

					var_1.InitPool(var_29_0, var_28_0, arg_29_0)

					var_28_2 = arg_28_0._allPool[var_28_0]

					local var_29_1 = arg_28_0
					local var_29_2 = var_1.popPool(var_29_1, var_28_2)

					arg_28_2(var_29_2)
				end

				return
			end), true, true)
		end
	end

	return
end

function var_0_5.InstBullet(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.GetBulletPath(arg_30_1)

	if arg_30_0._allPool[var_30_0] then
		local var_30_1 = arg_30_0:popPool(var_30_3, true)

		string = var_1_10006

		if var_1_10006.find(arg_30_1, "_trail") then
			local var_30_2 = var_30_1

			var_1_10006 = var_30_1.GetComponentInChildren
			typeof = var_9
			UnityEngine = var_1_10011

			if var_1_10006(var_30_2, var_9(var_1_10011.TrailRenderer)) then
				var_1_10006:Clear()
			end
		end

		arg_30_2(var_30_1)

		return true
	else
		local var_30_3, var_30_4

		if arg_30_0._resCacheList[var_30_0] ~= nil then
			arg_30_0:InitPool(var_30_0, arg_30_0._resCacheList[var_30_0])

			var_30_3 = arg_30_0._allPool[var_30_0]
			var_30_4 = arg_30_0:popPool(var_30_3, true)
			string = var_1_10006

			if var_1_10006.find(arg_30_1, "_trail") then
				local var_30_5 = var_30_4
				local var_30_6 = var_30_4.GetComponentInChildren

				typeof = var_9
				UnityEngine = var_1_10011

				if var_30_6(var_30_5, var_9(var_1_10011.TrailRenderer)) then
					var_6:Clear()
				end
			end

			arg_30_2(var_30_4)

			return true
		else
			ResourceMgr = var_30_4

			local var_30_7 = var_30_4.Inst
			local var_30_8 = var_5.getAssetAsync
			local var_30_9 = var_30_0
			local var_30_10 = ""

			UnityEngine = var_1_10010

			var_30_8(var_30_7, var_30_9, var_30_10, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_31_0)
				if not arg_30_0._poolRoot then
					var_0_4.Destroy(arg_31_0)

					return
				else
					assert = var_1

					var_1(arg_31_0, "子弹资源加载失败：" .. arg_30_1)

					local var_31_0 = arg_30_0

					var_1.InitPool(var_31_0, var_30_0, arg_31_0)

					var_30_3 = arg_30_0._allPool[var_30_0]

					local var_31_1 = arg_30_0
					local var_31_2 = var_1.popPool(var_31_1, var_30_3, true)

					arg_30_2(var_31_2)
				end

				return
			end), true, true)

			return false
		end
	end

	return
end

function var_0_5.InstFX(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.GetFXPath(arg_32_1)
	local var_32_1

	if arg_32_0._allPool[var_32_0] then
		var_32_1 = arg_32_0:popPool(var_5, arg_32_2)
	elseif arg_32_0._resCacheList[var_32_0] ~= nil then
		arg_32_0:InitPool(var_32_0, arg_32_0._resCacheList[var_32_0])

		local var_32_2 = arg_32_0._allPool[var_32_0]

		var_32_1 = arg_32_0:popPool(var_32_2, arg_32_2)
	else
		ResourceMgr = var_1_10006

		local var_32_3 = var_1_10006.Inst

		var_1_10006 = var_1_10006.getAssetAsync

		local var_32_4 = var_32_0

		var_1_10010 = ""
		UnityEngine = var_1_10011

		var_1_10006(var_32_3, var_32_4, var_1_10010, var_1_10011.Events.UnityAction_UnityEngine_Object(function(arg_33_0)
			if not arg_32_0._poolRoot then
				var_0_4.Destroy(arg_33_0)

				return
			else
				assert = var_1

				var_1(arg_33_0, "特效资源加载失败：" .. arg_32_1)

				local var_33_0 = arg_32_0

				var_1.InitPool(var_33_0, var_32_0, arg_33_0)
			end

			return
		end), true, true)

		GameObject = var_1_10006

		local var_32_5 = var_1_10006(arg_32_1 .. "临时假obj")

		var_32_1.SetActive(var_32_5, false)

		var_1_10006 = arg_32_0._resCacheList
		var_1_10006[var_32_0] = var_32_1
	end

	tf = var_1_10006

	local var_32_6 = var_1_10006(var_32_1)

	if var_6.Find(var_32_6, "bullet") then
		local var_32_7 = var_6
		local var_32_8 = var_6.GetComponent

		typeof = var_1_10010
		SpineAnim = var_1_10012

		if var_32_8(var_32_7, var_1_10010(var_1_10012)) then
			local var_32_9 = var_6
			local var_32_10 = var_6.GetComponent

			typeof = var_10
			SpineAnim = var_1_10012

			local var_32_11 = var_32_10(var_32_9, var_10(var_1_10012))
			local var_32_12 = var_6
			local var_32_13 = var_6.GetComponent(var_32_12, "SkeletonAnimation")
			local var_32_14 = "normal"

			if var_32_13 then
				SpineAnimUtil = var_32_12

				local var_32_15 = var_32_12.GetCharAnimDirect
				local var_32_16 = var_32_13

				math = var_1_10013
				var_32_14 = var_32_15(var_32_16, var_1_10013.sign(var_6.localScale.x), "normal")
			end

			var_32_11:SetAction(var_32_14, 0, false)
		end
	end

	return var_32_1
end

function var_0_5.InstOrbit(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.GetOrbitPath(arg_34_1)
	local var_34_1

	if arg_34_0._allPool[var_34_0] then
		var_34_1 = arg_34_0:popPool(var_4)
	elseif arg_34_0._resCacheList[var_34_0] ~= nil then
		arg_34_0:InitPool(var_34_0, arg_34_0._resCacheList[var_34_0])

		local var_34_2 = arg_34_0._allPool[var_34_0]

		var_34_1 = arg_34_0:popPool(var_34_2)
	else
		ResourceMgr = var_5

		local var_34_3 = var_5.Inst
		local var_34_4 = var_5.getAssetAsync
		local var_34_5 = var_34_0
		local var_34_6 = ""

		UnityEngine = var_1_10010

		var_34_4(var_34_3, var_34_5, var_34_6, var_1_10010.Events.UnityAction_UnityEngine_Object(function(arg_35_0)
			if not arg_34_0._poolRoot then
				var_0_4.Destroy(arg_35_0)

				return
			else
				assert = var_1

				var_1(arg_35_0, "特效资源加载失败：" .. arg_34_1)

				local var_35_0 = arg_34_0

				var_1.InitPool(var_35_0, var_34_0, arg_35_0)
			end

			return
		end), true, true)

		GameObject = var_34_4

		local var_34_7 = var_34_4(arg_34_1 .. "临时假obj")

		var_34_1.SetActive(var_34_7, false)

		arg_34_0._resCacheList[var_34_0] = var_34_1
	end

	return var_34_1
end

function var_0_5.InstSkillPaintingUI(arg_36_0)
	local var_36_0 = arg_36_0._allPool["UI/SkillPainting"]
	local var_36_1 = var_1.GetObject(var_36_0)

	arg_36_0._ob2Pool[var_36_1] = var_1

	return var_36_1
end

function var_0_5.InstSkillPaintingDALUI(arg_37_0)
	local var_37_0 = arg_37_0._allPool["UI/SkillPaintingDAL"]
	local var_37_1 = var_1.GetObject(var_37_0)

	arg_37_0._ob2Pool[var_37_1] = var_1

	return var_37_1
end

function var_0_5.InstBossWarningUI(arg_38_0)
	local var_38_0 = arg_38_0._allPool["UI/MonsterAppearUI"]
	local var_38_1 = var_1.GetObject(var_38_0)

	arg_38_0._ob2Pool[var_38_1] = var_1

	return var_38_1
end

function var_0_5.InstGridmanSkillUI(arg_39_0)
	local var_39_0 = arg_39_0._allPool["UI/combatgridmanskillfloat"]
	local var_39_1 = var_1.GetObject(var_39_0)

	arg_39_0._ob2Pool[var_39_1] = var_1

	return var_39_1
end

function var_0_5.InstReisalinAPUI(arg_40_0)
	local var_40_0 = arg_40_0._allPool["UI/combatreisalinapui"]
	local var_40_1 = var_1.GetObject(var_40_0)

	arg_40_0._ob2Pool[var_40_1] = var_1

	return var_40_1
end

function var_0_5.InstYumiaManaUI(arg_41_0)
	local var_41_0 = arg_41_0._allPool["UI/combatyumiamanaui"]
	local var_41_1 = var_1.GetObject(var_41_0)

	arg_41_0._ob2Pool[var_41_1] = var_1

	return var_41_1
end

function var_0_5.InstPainting(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.GetPaintingPath(arg_42_1)
	local var_42_1

	if arg_42_0._allPool[var_42_0] then
		var_42_1 = var_4:GetObject()
		arg_42_0._ob2Pool[var_42_1] = var_4
	elseif arg_42_0._resCacheList[var_42_0] ~= nil then
		Object = var_5

		local var_42_2 = var_5.Instantiate(arg_42_0._resCacheList[var_42_0])

		var_42_1.SetActive(var_42_2, true)
	end

	return var_42_1
end

function var_0_5.InstMap(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.GetMapPath(arg_43_1)
	local var_43_1

	if arg_43_0._allPool[var_43_0] then
		var_43_1 = var_4:GetObject()
		arg_43_0._ob2Pool[var_43_1] = var_4
	elseif arg_43_0._resCacheList[var_43_0] ~= nil then
		Object = var_5
		var_43_1 = var_5.Instantiate(arg_43_0._resCacheList[var_43_0])
	else
		assert = var_5

		var_5(false, "地图资源没有预加载：" .. arg_43_1)
	end

	var_43_1:SetActive(true)

	return var_43_1
end

function var_0_5.InstCardPuzzleCard(arg_44_0)
	local var_44_0 = arg_44_0._allPool["UI/CardTowerCardCombat"]
	local var_44_1 = var_1.GetObject(var_44_0)

	arg_44_0._ob2Pool[var_44_1] = var_1

	return var_44_1
end

function var_0_5.GetCharacterIcon(arg_45_0, arg_45_1)
	return arg_45_0._resCacheList[var_0_5.GetHrzIcon(arg_45_1)]
end

function var_0_5.GetCharacterSquareIcon(arg_46_0, arg_46_1)
	return arg_46_0._resCacheList[var_0_5.GetSquareIcon(arg_46_1)]
end

function var_0_5.GetCharacterQIcon(arg_47_0, arg_47_1)
	return arg_47_0._resCacheList[var_0_5.GetQIcon(arg_47_1)]
end

function var_0_5.GetAircraftIcon(arg_48_0, arg_48_1)
	return arg_48_0._resCacheList[var_0_5.GetAircraftIconPath(arg_48_1)]
end

function var_0_5.GetShipTypeIcon(arg_49_0, arg_49_1)
	return arg_49_0._resCacheList[var_0_5.GetShipTypeIconPath(arg_49_1)]
end

function var_0_5.GetCommanderHrzIcon(arg_50_0, arg_50_1)
	return arg_50_0._resCacheList[var_0_5.GetCommanderHrzIconPath(arg_50_1)]
end

function var_0_5.GetCommanderIcon(arg_51_0, arg_51_1)
	return arg_51_0._resCacheList[var_0_5.GetCommanderIconPath(arg_51_1)]
end

function var_0_5.GetShader(arg_52_0, arg_52_1)
	pg = var_1_10002

	local var_52_0 = var_1_10002.ShaderMgr.GetInstance()

	return (var_2.GetShader(var_52_0, var_0_3.BATTLE_SHADER[arg_52_1]))
end

function var_0_5.AddPreloadResource(arg_53_0, arg_53_1)
	type = var_1_10002

	local var_53_0

	if var_1_10002(arg_53_1) == "string" then
		var_53_0 = arg_53_0._preloadList
		var_53_0[arg_53_1] = false
	else
		type = var_53_0

		if var_53_0(arg_53_1) == "table" then
			ipairs = var_2

			for iter_53_0, iter_53_1 in var_2(arg_53_1) do
				arg_53_0._preloadList[iter_53_1] = false
			end
		end
	end

	return
end

function var_0_5.AddPreloadCV(arg_54_0, arg_54_1)
	ShipWordHelper = var_1_10002

	if var_1_10002.RawGetCVKey(arg_54_1) > 0 then
		local var_54_0 = arg_54_0._battleCVList

		pg = var_4
		var_54_0[var_2] = var_4.CriMgr.GetBattleCVBankName(var_2)
	end

	return
end

function var_0_5.StartPreload(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = 0
	local var_55_1 = 0

	pairs = var_1_10005

	for iter_55_0, iter_55_1 in var_1_10005(arg_55_0._preloadList) do
		var_55_1 = var_55_1 + 1
	end

	pairs = var_5

	for iter_55_2, iter_55_3 in var_5(arg_55_0._battleCVList) do
		var_55_1 = var_55_1 + 1
	end

	local function var_55_2()
		if not arg_55_0._poolRoot then
			return
		end

		var_55_0 = var_55_0 + 1

		if var_55_0 > var_55_1 then
			return
		end

		if arg_55_2 then
			arg_55_2(var_55_0)
		end

		if var_55_0 == var_55_1 then
			arg_55_0._preloadList = nil

			arg_55_1()
		end

		return
	end

	pairs = var_6

	for iter_55_4, iter_55_5 in var_6(arg_55_0._battleCVList) do
		pg = var_1_10011

		local var_55_3 = var_1_10011.CriMgr.GetInstance()

		var_1_10011.LoadBattleCV(var_55_3, iter_55_4, var_55_2)
	end

	pairs = var_6

	for iter_55_6, iter_55_7 in var_6(arg_55_0._preloadList) do
		if arg_55_0.GetResName(iter_55_6) == "" or arg_55_0._resCacheList[iter_55_6] ~= nil then
			var_55_2()

			goto label_55_0
		end

		string = var_1_10012

		if not var_1_10012.find(iter_55_6, "herohrzicon/") then
			string = var_1_10012

			if not var_1_10012.find(iter_55_6, "qicon/") then
				string = var_1_10012

				if not var_1_10012.find(iter_55_6, "squareicon/") then
					string = var_1_10012

					if not var_1_10012.find(iter_55_6, "commanderhrz/") then
						string = var_1_10012

						if not var_1_10012.find(iter_55_6, "commandericon/") then
							string = var_1_10012

							do
								local var_55_4

								if var_1_10012.find(iter_55_6, "AircraftIcon/") then
									HXSet = var_1_10012
									var_1_10012, var_55_4 = var_1_10012.autoHxShiftPath(iter_55_6, var_11)
									ResourceMgr = var_14

									local var_55_5 = var_14.Inst
									local var_55_6 = var_14.getAssetAsync

									var_1_10017 = var_1_10012

									local var_55_7 = ""

									typeof = var_1_10019
									Sprite = var_1_10021
									var_1_10019 = var_1_10019(var_1_10021)
									UnityEngine = var_1_10020

									var_55_6(var_55_5, var_1_10017, var_55_7, var_1_10019, var_1_10020.Events.UnityAction_UnityEngine_Object(function(arg_57_0)
										if arg_57_0 == nil then
											originalPrint = var_2_10001

											var_2_10001("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
										else
											if not arg_55_0._poolRoot then
												var_0_4.Destroy(arg_57_0)

												return
											end

											if arg_55_0._resCacheList then
												arg_55_0._resCacheList[iter_55_6] = arg_57_0
											end
										end

										var_55_2()

										return
									end), true, true)
								else
									string = var_1_10012

									if var_1_10012.find(iter_55_6, "shiptype/") then
										string = var_1_10012
										var_1_10012 = var_1_10012.split(iter_55_6, "/")[2]
										GetSpriteFromAtlasAsync = var_55_4

										var_55_4("shiptype", var_1_10012, function(arg_58_0)
											if arg_58_0 == nil then
												originalPrint = var_2_10001

												var_2_10001("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
											else
												if not arg_55_0._poolRoot then
													var_0_4.Destroy(arg_58_0)

													return
												end

												if arg_55_0._resCacheList then
													arg_55_0._resCacheList[iter_55_6] = arg_58_0
												end
											end

											var_55_2()

											return
										end)
									else
										string = var_1_10012

										if var_1_10012.find(iter_55_6, "painting/") then
											PoolMgr = var_1_10012

											local var_55_8 = var_1_10012.GetInstance()

											var_1_10012.GetPainting(var_55_8, var_0_5.GetPaintingName(var_11), true, function(arg_59_0)
												if arg_59_0 == nil then
													originalPrint = var_2_10001

													var_2_10001("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
												else
													if not arg_55_0._poolRoot then
														var_0_5.ClearPaintingRes(iter_55_6, arg_59_0)

														return
													end

													ShipExpressionHelper = var_1

													var_1.SetExpression(arg_59_0, var_0)
													arg_59_0:SetActive(false)

													if arg_55_0._resCacheList then
														arg_55_0._resCacheList[iter_55_6] = arg_59_0
													end
												end

												var_55_2()

												return
											end)
										else
											string = var_1_10012

											if var_1_10012.find(iter_55_6, "Char/") then
												arg_55_0:LoadSpineAsset(var_11, function(arg_60_0)
													if arg_60_0 == nil then
														originalPrint = var_2_10001

														var_2_10001("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
													else
														SpineAnim = var_2_10001
														arg_60_0 = var_2_10001.AnimChar(var_0, arg_60_0)

														if not arg_55_0._poolRoot then
															var_0_5.ClearCharRes(iter_55_6, arg_60_0)

															return
														end

														arg_60_0:SetActive(false)

														if arg_55_0._resCacheList then
															arg_55_0._resCacheList[iter_55_6] = arg_60_0
														end
													end

													local var_60_0 = arg_55_0

													var_1.InitPool(var_60_0, iter_55_6, arg_60_0)
													var_55_2()

													return
												end)
											else
												string = var_1_10012

												if var_1_10012.find(iter_55_6, "UI/") then
													LoadAndInstantiateAsync = var_1_10012

													var_1_10012("UI", var_11, function(arg_61_0)
														if arg_61_0 == nil then
															originalPrint = var_2_10001

															var_2_10001("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
														else
															if not arg_55_0._poolRoot then
																var_0_4.Destroy(arg_61_0)

																return
															end

															arg_61_0:SetActive(false)

															if arg_55_0._resCacheList then
																arg_55_0._resCacheList[iter_55_6] = arg_61_0
															end
														end

														local var_61_0 = arg_55_0

														var_1.InitPool(var_61_0, iter_55_6, arg_61_0)
														var_55_2()

														return
													end, true, true)
												else
													ResourceMgr = var_1_10012

													local var_55_9 = var_1_10012.Inst

													var_1_10012 = var_1_10012.getAssetAsync

													local var_55_10 = iter_55_6
													local var_55_11 = ""

													UnityEngine = var_1_10017

													var_1_10012(var_55_9, var_55_10, var_55_11, var_1_10017.Events.UnityAction_UnityEngine_Object(function(arg_62_0)
														if arg_62_0 == nil then
															originalPrint = var_2_10001

															var_2_10001("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
														else
															if not arg_55_0._poolRoot then
																var_0_4.Destroy(arg_62_0)

																return
															end

															if arg_55_0._resCacheList then
																arg_55_0._resCacheList[iter_55_6] = arg_62_0
															end
														end

														local var_62_0 = arg_55_0

														var_1.InitPool(var_62_0, iter_55_6, arg_62_0)
														var_55_2()

														return
													end), true, true)
												end
											end
										end
									end
								end
							end

							::label_55_0::
						end
					end
				end
			end
		end
	end

	return var_55_1
end

function var_0_5.GetPaintingName(arg_63_0)
	local var_63_0 = false

	PlayerPrefs = var_1_10002

	local var_63_1 = var_1_10002.GetInt

	BATTLE_HIDE_BG = var_1_10004

	if var_63_1(var_1_10004, 1) > 0 then
		checkABExist = var_2
		var_63_0 = var_2("painting/" .. arg_63_0 .. "_n")
	else
		PlayerPrefs = var_2

		if var_2.GetInt("paint_hide_other_obj_" .. arg_63_0, 0) ~= 0 then
			checkABExist = var_2
			var_63_0 = var_2("painting/" .. arg_63_0 .. "_n")
		else
			var_63_0 = false
		end
	end

	if false then
		var_63_0 = true
	end

	return arg_63_0 .. (var_63_0 and "_n" or "")
end

Vector3 = var_6

local var_0_6 = var_6(0, 10000, 0)

function var_0_5.HideBullet(arg_64_0)
	arg_64_0.transform.position = var_0_6

	return
end

function var_0_5.InitParticleSystemCB(arg_65_0)
	pg = var_1_10001

	local var_65_0 = var_1_10001.EffectMgr.GetInstance()

	var_1.CommonEffectEvent(var_65_0, arg_65_0)

	return
end

function var_0_5.InitPool(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_0._poolRoot.transform

	string = var_1_10004

	if var_1_10004.find(arg_66_1, "Item/") then
		local var_66_1 = arg_66_2
		local var_66_2 = arg_66_2.GetComponentInChildren

		typeof = var_7
		UnityEngine = var_1_10009

		if var_66_2(var_66_1, var_7(var_1_10009.TrailRenderer)) == nil then
			local var_66_3 = arg_66_2

			var_66_2 = arg_66_2.GetComponentInChildren
			typeof = var_7
			ParticleSystem = var_1_10009

			if var_66_2(var_66_3, var_7(var_1_10009)) ~= nil then
				var_66_2 = arg_66_0._allPool
				pg = var_1_10005

				local var_66_4 = var_1_10005.Pool.New(arg_66_0._bulletContainer.transform, arg_66_2, 15, 20, true, false)

				var_66_2[arg_66_1] = var_1_10005.InitSize(var_66_4)
			else
				pg = var_66_2

				local var_66_5 = var_66_2.Pool.New(arg_66_0._bulletContainer.transform, arg_66_2, 20, 20, true, true)

				var_66_2.SetRecycleFuncs(var_66_5, var_0_5.HideBullet)
				var_66_2:InitSize()

				var_1_10005 = arg_66_0._allPool
				var_1_10005[arg_66_1] = var_66_2
			end

			goto label_66_1

			string = var_66_2

			if var_66_2.find(arg_66_1, "Effect/") then
				local var_66_6 = arg_66_2
				local var_66_7 = arg_66_2.GetComponent

				typeof = var_7
				UnityEngine = var_1_10009

				if var_66_7(var_66_6, var_7(var_1_10009.ParticleSystem)) then
					var_66_7 = 5
					string = var_1_10005

					if var_1_10005.find(arg_66_1, "smoke") then
						string = var_1_10005

						if not var_1_10005.find(arg_66_1, "smokeboom") then
							var_66_7 = 30

							goto label_66_0
						end
					end

					string = var_1_10005

					if var_1_10005.find(arg_66_1, "feijiyingzi") then
						var_66_7 = 1
					end

					::label_66_0::

					pg = var_1_10005

					local var_66_8 = var_1_10005.Pool.New(var_66_0, arg_66_2, var_66_7, 20, false, false)

					var_1_10005.SetInitFuncs(var_66_8, var_0_5.InitParticleSystemCB)
					var_1_10005:InitSize()

					arg_66_0._allPool[arg_66_1] = var_1_10005

					goto label_66_1
				end

				var_66_7 = 8
				string = var_1_10005

				if not var_1_10005.find(arg_66_1, "AntiAirArea") then
					string = var_1_10005

					if var_1_10005.find(arg_66_1, "AntiSubArea") then
						var_66_7 = 1
					end

					GetOrAddComponent = var_1_10005

					do
						local var_66_9 = arg_66_2

						typeof = var_8
						ParticleSystemEvent = var_1_10010

						var_1_10005(var_66_9, var_8(var_1_10010))

						pg = var_1_10005

						local var_66_10 = var_1_10005.Pool.New(var_66_0, arg_66_2, var_66_7, 20, false, false)

						var_1_10005.InitSize(var_66_10)

						arg_66_0._allPool[arg_66_1] = var_1_10005

						if false then
							string = var_66_7

							local var_66_11

							if var_66_7.find(arg_66_1, "Char/") then
								var_66_11 = 1
								string = var_1_10005

								if var_1_10005.find(arg_66_1, "danchuan") then
									var_66_11 = 3
								end

								pg = var_1_10005

								local var_66_12 = var_1_10005.Pool.New(var_66_0, arg_66_2, var_66_11, 20, false, false)
								local var_66_13 = var_1_10005.InitSize(var_66_12)

								var_1_10005.SetRecycleFuncs(var_66_13, var_0_5.ResetSpineAction)

								arg_66_0._allPool[arg_66_1] = var_1_10005
							else
								string = var_66_11

								local var_66_14

								if var_66_11.find(arg_66_1, "chargo/") then
									var_66_14 = arg_66_0._allPool
									pg = var_1_10005

									local var_66_15 = var_1_10005.Pool.New(var_66_0, arg_66_2, 3, 20, false, false)

									var_66_14[arg_66_1] = var_1_10005.InitSize(var_66_15)
								else
									string = var_66_14

									if var_66_14.find(arg_66_1, "orbit/") then
										local var_66_16 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_17 = var_1_10005.Pool.New(var_66_0, arg_66_2, 2, 20, false, false)

										var_66_16[arg_66_1] = var_1_10005.InitSize(var_66_17)
									elseif arg_66_1 == "UI/SkillPainting" then
										local var_66_18 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_19 = var_1_10005.Pool.New(var_66_0, arg_66_2, 1, 20, false, false)

										var_66_18[arg_66_1] = var_1_10005.InitSize(var_66_19)
									elseif arg_66_1 == "UI/SkillPaintingDAL" then
										local var_66_20 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_21 = var_1_10005.Pool.New(var_66_0, arg_66_2, 1, 20, false, false)

										var_66_20[arg_66_1] = var_1_10005.InitSize(var_66_21)
									elseif arg_66_1 == "UI/MonsterAppearUI" then
										local var_66_22 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_23 = var_1_10005.Pool.New(var_66_0, arg_66_2, 1, 20, false, false)

										var_66_22[arg_66_1] = var_1_10005.InitSize(var_66_23)
									elseif arg_66_1 == "UI/CardTowerCardCombat" then
										local var_66_24 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_25 = var_1_10005.Pool.New(var_66_0, arg_66_2, 7, 20, false, false)

										var_66_24[arg_66_1] = var_1_10005.InitSize(var_66_25)
									elseif arg_66_1 == "UI/combatgridmanskillfloat" then
										local var_66_26 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_27 = var_1_10005.Pool.New(var_66_0, arg_66_2, 1, 20, false, false)

										var_66_26[arg_66_1] = var_1_10005.InitSize(var_66_27)
									elseif arg_66_1 == "UI/combatreisalinapui" then
										local var_66_28 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_29 = var_1_10005.Pool.New(var_66_0, arg_66_2, 1, 20, false, false)

										var_66_28[arg_66_1] = var_1_10005.InitSize(var_66_29)
									elseif arg_66_1 == "UI/combatyumiamanaui" then
										local var_66_30 = arg_66_0._allPool

										pg = var_1_10005

										local var_66_31 = var_1_10005.Pool.New(var_66_0, arg_66_2, 1, 20, false, false)

										var_66_30[arg_66_1] = var_5.InitSize(var_66_31)
									elseif arg_66_1 == "UI/CombatHPBar" .. var_0.Battle.BattleState.GetCombatSkinKey() then
										local var_66_32 = var_0.Battle.BattleHPBarManager.GetInstance()

										var_4.Init(var_66_32, arg_66_2, var_66_0)
									else
										string = var_4

										if var_4.find(arg_66_1, "UI/CombatHPPop") then
											local var_66_33 = var_0.Battle.BattlePopNumManager.GetInstance()

											var_4.Init(var_66_33, arg_66_2, var_66_0)
										end
									end
								end
							end
						end
					end

					::label_66_1::

					return
				end
			end
		end
	end
end

function var_0_5.GetRotateScript(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_0.rotateScriptMap[arg_67_1] then
		return var_3[arg_67_1]
	end

	GetOrAddComponent = var_4
	var_3[arg_67_1] = var_4(arg_67_1, "BulletRotation")

	return var_4
end

function var_0_5.GetCommonResource()
	return {
		var_0_5.GetMapPath("visionLine"),
		var_0_5.GetMapPath("exposeLine"),
		var_0_5.GetFXPath(var_0.Battle.BattleCharacterFactory.MOVE_WAVE_FX_NAME),
		var_0_5.GetFXPath(var_0.Battle.BattleCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath(var_0.Battle.BattleBossCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath(var_0.Battle.BattleAircraftCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath("AlertArea"),
		var_0_5.GetFXPath("TorAlert"),
		var_0_5.GetFXPath("SquareAlert"),
		var_0_5.GetFXPath("AntiAirArea"),
		var_0_5.GetFXPath("AntiSubArea"),
		var_0_5.GetFXPath("AimBiasArea"),
		var_0_5.GetFXPath("shock"),
		var_0_5.GetFXPath("qianting_chushui"),
		var_0_5.GetFXPath(var_0_3.PLAYER_SUB_BUBBLE_FX),
		var_0_5.GetFXPath("weaponrange"),
		var_0_5.GetUIPath("SkillPainting"),
		var_0_5.GetUIPath("MonsterAppearUI"),
		var_0_5.GetUIPath("combatreisalinapui"),
		var_0_5.GetUIPath("combatyumiamanaui"),
		var_0_5.GetUIPath("CombatHPBar" .. var_0.Battle.BattleState.GetCombatSkinKey()),
		var_0_5.GetUIPath("CombatHPPop" .. var_0.Battle.BattleState.GetCombatSkinKey())
	}
end

function var_0_5.GetDisplayCommonResource()
	return {
		var_0_5.GetFXPath(var_0.Battle.BattleCharacterFactory.MOVE_WAVE_FX_NAME),
		var_0_5.GetFXPath(var_0.Battle.BattleCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath(var_0.Battle.BattleCharacterFactory.DANCHUAN_MOVE_WAVE_FX_NAME)
	}
end

function var_0_5.GetMapResource(arg_70_0)
	local var_70_0 = {}
	local var_70_1 = var_0.Battle.BattleMap

	ipairs = var_1_10003

	for iter_70_0, iter_70_1 in var_1_10003(var_70_1.LAYERS) do
		local var_70_2 = var_70_1.GetMapResNames(arg_70_0, iter_70_1)

		ipairs = var_1_10009

		for iter_70_2, iter_70_3 in var_1_10009(var_70_2) do
			var_70_0[#var_70_0 + 1] = var_0_5.GetMapPath(iter_70_3)
		end
	end

	return var_70_0
end

function var_0_5.GetBuffResource()
	local var_71_0 = {}

	require = var_1_10001

	local var_71_1 = var_1_10001("buffFXPreloadList")

	ipairs = var_1_10002

	for iter_71_0, iter_71_1 in var_1_10002(var_71_1) do
		var_71_0[#var_71_0 + 1] = var_0_5.GetFXPath(iter_71_1)
	end

	return var_71_0
end

function var_0_5.GetShipResource(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = {}
	local var_72_1 = var_0_1.GetPlayerShipTmpDataFromID(arg_72_0)

	if arg_72_1 == nil or arg_72_1 == 0 then
		arg_72_1 = var_72_1.skin_id
	end

	local var_72_2 = var_0_1.GetPlayerShipSkinDataFromID(arg_72_1)

	var_72_0[#var_72_0 + 1] = var_0_5.GetCharacterPath(var_72_2.prefab)
	var_72_0[#var_72_0 + 1] = var_0_5.GetHrzIcon(var_72_2.painting)
	var_72_0[#var_72_0 + 1] = var_0_5.GetQIcon(var_72_2.painting)
	table = var_6

	if var_6.contains(var_0_3.MIRROR_QICON_SHIP_GROUP, var_72_2.ship_group) then
		var_72_0[#var_72_0 + 1] = var_0_5.GetQIcon(var_72_2.painting .. var_0_3.MIRROR_QICON_KEY)
	end

	var_72_0[#var_72_0 + 1] = var_0_5.GetSquareIcon(var_72_2.painting)

	if arg_72_2 then
		local var_72_3 = var_0_1.GetShipTypeTmp(var_72_1.type).team_type

		TeamType = var_7

		if var_72_3 == var_7.Main then
			var_72_0[#var_72_0 + 1] = var_0_5.GetPaintingPath(var_72_2.painting)
		end
	end

	return var_72_0
end

function var_0_5.GetPlayerShipResource(arg_73_0, arg_73_1)
	local var_73_0 = {}
	local var_73_1 = {}
	local var_73_2

	ipairs = var_1_10005

	for iter_73_0, iter_73_1 in var_1_10005(arg_73_0) do
		local var_73_3 = iter_73_1.configId

		table = var_1_10011

		var_1_10011.insert(var_73_1, iter_73_1.skinId)

		local var_73_4 = var_0_5.GetShipResource(var_73_3, iter_73_1.skinId, true)

		pairs = var_1_10011

		for iter_73_2, iter_73_3 in var_1_10011(var_73_4) do
			table = iter_73_20

			iter_73_20.insert(var_73_0, iter_73_3)
		end

		var_1_10011 = var_0_1.GetPlayerShipTmpDataFromID(var_73_3)
		ipairs = var_12
		iter_73_20 = iter_73_1

		for iter_73_4, iter_73_20 in var_12(iter_73_1.getActiveEquipments(iter_73_20)) do
			local var_73_5
			local var_73_6

			var_1_10019 = 0

			if not iter_73_20 then
				var_73_5 = var_1_10011.default_equip_list[iter_73_4]
			else
				var_73_5 = iter_73_20.configId
				var_1_10019 = iter_73_20.skinId
			end

			if var_73_5 then
				if #var_0_1.GetWeaponDataFromID(var_73_5).weapon_id > 0 then
					ipairs = var_21

					for iter_73_10, iter_73_7 in var_21(var_20) do
						local var_73_7 = var_0_5.GetWeaponResource(iter_73_7, var_1_10019)

						pairs = var_1_10026

						for iter_73_8, iter_73_9 in var_1_10026(var_73_7) do
							table = var_1_10031

							var_1_10031.insert(var_73_0, iter_73_9)
						end
					end
				else
					local var_73_8 = var_0_5.GetEquipResource(var_73_5, var_1_10019, arg_73_1)

					pairs = var_21

					for iter_73_10, iter_73_11 in var_21(var_73_8) do
						table = var_1_10026

						var_1_10026.insert(var_73_0, iter_73_11)
					end
				end
			end
		end

		local var_73_9 = {}

		ipairs = var_13

		for iter_73_20, iter_73_13 in var_13(var_1_10011.depth_charge_list) do
			local var_73_10 = var_0_1.GetWeaponDataFromID(iter_73_13).weapon_id

			ipairs = var_1_10019

			for iter_73_14, iter_73_19 in var_1_10019(var_73_10) do
				table = iter_73_10

				iter_73_10.insert(var_73_9, iter_73_19)
			end
		end

		ipairs = var_13

		for iter_73_20, iter_73_17 in var_13(var_1_10011.fix_equip_list) do
			local var_73_11 = var_0_1.GetWeaponDataFromID(iter_73_17).weapon_id

			ipairs = var_1_10019

			for iter_73_18, iter_73_19 in var_1_10019(var_73_11) do
				table = iter_73_10

				iter_73_10.insert(var_73_9, iter_73_19)
			end
		end

		ipairs = var_13

		for iter_73_20, iter_73_21 in var_13(var_73_9) do
			local var_73_12 = var_0_5.GetWeaponResource(iter_73_21)

			pairs = var_18

			for iter_73_22, iter_73_23 in var_18(var_73_12) do
				table = iter_73_19

				iter_73_19.insert(var_73_0, iter_73_23)
			end
		end

		local var_73_13

		if iter_73_1.GetSpWeapon then
			var_73_13 = iter_73_1:GetSpWeapon()
		end

		if var_73_13 then
			local var_73_14 = var_0_5.GetSpWeaponResource(var_73_13:GetConfigID(), arg_73_1)

			pairs = var_14

			for iter_73_24, iter_73_25 in var_14(var_73_14) do
				table = var_1_10019

				var_1_10019.insert(var_73_0, iter_73_25)
			end
		end

		local var_73_15 = var_0_1.GetBuffBulletRes(var_73_3, iter_73_1.skills, arg_73_1, iter_73_1.skinId, var_73_13)

		pairs = var_14

		for iter_73_26, iter_73_27 in var_14(var_73_15) do
			table = var_1_10019

			var_1_10019.insert(var_73_0, iter_73_27)
		end

		if iter_73_1.buffs then
			local var_73_16 = var_0_1.GetBuffListRes(iter_73_1.buffs, arg_73_1, iter_73_1.skinId)

			pairs = var_14

			for iter_73_28, iter_73_29 in var_14(var_73_16) do
				table = var_1_10019

				var_1_10019.insert(var_73_0, iter_73_29)
			end
		end
	end

	return var_73_0, var_73_1
end

function var_0_5.GetEnemyResource(arg_74_0)
	local var_74_0 = {}
	local var_74_1 = arg_74_0.monsterTemplateID
	local var_74_2 = arg_74_0.bossData ~= nil
	local var_74_3

	if not arg_74_0.buffList then
		var_74_3 = {}
	end

	local var_74_4

	if not arg_74_0.phase then
		var_74_4 = {}
	end

	local var_74_5 = var_0_1.GetMonsterTmpDataFromID(var_74_1)

	var_74_0[#var_74_0 + 1] = var_0_5.GetCharacterPath(var_74_5.prefab)
	var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(var_74_5.wave_fx)

	if var_74_5.fog_fx then
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(var_74_5.fog_fx)
	end

	ipairs = var_7

	for iter_74_0, iter_74_1 in var_7(var_74_5.appear_fx) do
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(iter_74_1)
	end

	ipairs = var_7

	for iter_74_2, iter_74_3 in var_7(var_74_5.smoke) do
		local var_74_6 = iter_74_3[2]

		ipairs = var_1_10013

		for iter_74_4, iter_74_5 in var_1_10013(var_74_6) do
			var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(iter_74_5[1])
		end
	end

	if arg_74_0.deadFX then
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(arg_74_0.deadFX)
	end

	type = var_7

	if var_7(var_74_5.bubble_fx) == "table" then
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(var_74_5.bubble_fx[1])
	end

	local function var_74_7(arg_75_0)
		local var_75_0 = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_75_0, 1)

		pairs = var_2_10002

		for iter_75_0, iter_75_1 in var_2_10002(var_75_0.effect_list) do
			if iter_75_1.arg_list.skill_id then
				local var_75_1

				if var_0.Battle.BattleDataFunction.GetSkillTemplate(var_7).painting == 1 then
					var_75_1 = var_74_0
					var_75_1[#var_74_0 + 1] = var_0_5.GetHrzIcon(var_74_5.icon)
					var_75_1 = var_74_0
					var_75_1[#var_74_0 + 1] = var_0_5.GetSquareIcon(var_74_5.icon)
				else
					type = var_75_1

					if var_75_1(var_9) == "string" then
						var_74_0[#var_74_0 + 1] = var_0_5.GetHrzIcon(var_9)
						var_74_0[#var_74_0 + 1] = var_0_5.GetSquareIcon(var_9)
					end
				end
			end

			if iter_75_1.arg_list.buff_id then
				var_74_7(var_8)
			end
		end

		return
	end

	ipairs = var_8

	for iter_74_6, iter_74_7 in var_8(var_74_3) do
		var_74_7(iter_74_7)
	end

	ipairs = var_8

	for iter_74_8, iter_74_9 in var_8(var_74_4) do
		if iter_74_9.addBuff then
			ipairs = var_13

			for iter_74_10, iter_74_11 in var_13(iter_74_9.addBuff) do
				var_74_7(iter_74_11)
			end
		end
	end

	if var_74_2 then
		var_74_0[#var_74_0 + 1] = var_0_5.GetSquareIcon(var_74_5.icon)
	end

	return var_74_0
end

function var_0_5.GetWeaponResource(arg_76_0, arg_76_1)
	local var_76_0 = {}

	if arg_76_0 == -1 then
		return var_76_0
	end

	if var_0_1.GetWeaponPropertyDataFromID(arg_76_0).type == var_0_2.EquipmentType.MAIN_CANNON or var_3.type == var_0_2.EquipmentType.SUB_CANNON or var_3.type == var_0_2.EquipmentType.TORPEDO or var_3.type == var_0_2.EquipmentType.ANTI_AIR or var_3.type == var_0_2.EquipmentType.ANTI_SEA or var_3.type == var_0_2.EquipmentType.POINT_HIT_AND_LOCK or var_3.type == var_0_2.EquipmentType.MANUAL_METEOR or var_3.type == var_0_2.EquipmentType.BOMBER_PRE_CAST_ALERT or var_3.type == var_0_2.EquipmentType.DEPTH_CHARGE or var_3.type == var_0_2.EquipmentType.MANUAL_TORPEDO or var_3.type == var_0_2.EquipmentType.DISPOSABLE_TORPEDO or var_3.type == var_0_2.EquipmentType.MANUAL_AAMISSILE or var_3.type == var_0_2.EquipmentType.BEAM or var_3.type == var_0_2.EquipmentType.SPACE_LASER or var_3.type == var_0_2.EquipmentType.FLEET_RANGE_ANTI_AIR or var_3.type == var_0_2.EquipmentType.MANUAL_MISSILE or var_3.type == var_0_2.EquipmentType.AUTO_MISSILE or var_3.type == var_0_2.EquipmentType.MISSILE then
		ipairs = var_4

		for iter_76_0, iter_76_1 in var_4(var_3.bullet_ID) do
			local var_76_1 = var_0_5.GetBulletResource(iter_76_1, arg_76_1)

			ipairs = var_1_10010

			for iter_76_2, iter_76_3 in var_1_10010(var_76_1) do
				var_76_0[#var_76_0 + 1] = iter_76_3
			end
		end
	elseif var_3.type == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or var_3.type == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
		var_76_0 = var_0_5.GetAircraftResource(arg_76_0, nil, arg_76_1)
	elseif var_3.type == var_0_2.EquipmentType.PREVIEW_ARICRAFT then
		ipairs = var_4

		for iter_76_4, iter_76_5 in var_4(var_3.bullet_ID) do
			var_76_0 = var_0_5.GetAircraftResource(iter_76_5, nil, arg_76_1)
		end
	end

	if var_3.type == var_0_2.EquipmentType.FLEET_RANGE_ANTI_AIR then
		local var_76_2 = var_0_5.GetBulletResource(var_0_3.AntiAirConfig.RangeBulletID)

		ipairs = var_5

		for iter_76_6, iter_76_7 in var_5(var_76_2) do
			var_76_0[#var_76_0 + 1] = iter_76_7
		end
	end

	local var_76_3

	if arg_76_1 and arg_76_1 ~= 0 then
		var_76_3 = var_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(arg_76_1)
	end

	if var_76_3 and var_76_3.fire_fx_name ~= "" then
		var_76_0[#var_76_0 + 1] = var_0_5.GetFXPath(var_76_3.fire_fx_name)
	else
		var_76_0[#var_76_0 + 1] = var_0_5.GetFXPath(var_3.fire_fx)
	end

	if var_3.precast_param.fx then
		var_76_0[#var_76_0 + 1] = var_0_5.GetFXPath(var_3.precast_param.fx)
	end

	if var_76_3 and var_76_3.orbit_combat ~= "" then
		var_76_0[#var_76_0 + 1] = var_0_5.GetOrbitPath(var_5)
	end

	return var_76_0
end

function var_0_5.GetEquipResource(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = {}

	if arg_77_1 ~= 0 then
		if var_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(arg_77_1).ship_skin_id ~= 0 then
			local var_77_1 = var_0.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(var_5)

			var_77_0[#var_77_0 + 1] = var_0_5.GetCharacterPath(var_77_1.prefab)
		end

		if var_4.orbit_combat ~= "" then
			var_77_0[#var_77_0 + 1] = var_0_5.GetOrbitPath(var_6)
		end
	end

	local var_77_2 = var_0.Battle.BattleDataFunction.GetWeaponDataFromID(arg_77_0).weapon_id

	ipairs = var_6

	for iter_77_0, iter_77_1 in var_6(var_77_2) do
		local var_77_3 = var_0_5.GetWeaponResource(iter_77_1)

		ipairs = var_1_10012

		for iter_77_2, iter_77_3 in var_1_10012(var_77_3) do
			var_77_0[#var_77_0 + 1] = iter_77_3
		end
	end

	local var_77_4 = var_4.skill_id

	ipairs = var_7

	for iter_77_4, iter_77_5 in var_7(var_77_4) do
		local var_77_5

		if not arg_77_2 or not var_0.Battle.BattleDataFunction.SkillTranform(arg_77_2, iter_77_5[1]) then
			var_77_5 = iter_77_5[1]
		end

		local var_77_6

		if not iter_77_5[2] then
			var_77_6 = 1
		end

		local var_77_7 = var_0.Battle.BattleDataFunction.GetResFromBuff(var_77_5, var_77_6, {})

		ipairs = iter_77_2

		for iter_77_6, iter_77_7 in iter_77_2(var_77_7) do
			var_77_0[#var_77_0 + 1] = iter_77_7
		end
	end

	return var_77_0
end

function var_0_5.GetBulletResource(arg_78_0, arg_78_1)
	local var_78_0 = {}
	local var_78_1

	if arg_78_1 ~= nil and arg_78_1 ~= 0 then
		var_78_1 = var_0_1.GetEquipSkinDataFromID(arg_78_1)
	end

	local var_78_2 = var_0_1.GetBulletTmpDataFromID(arg_78_0)
	local var_78_3

	if var_78_1 then
		var_78_3 = var_78_1.bullet_name

		if var_78_1.mirror == 1 then
			var_78_0[#var_78_0 + 1] = var_0_5.GetBulletPath(var_78_3 .. var_0.Battle.BattleBulletUnit.MIRROR_RES)
		end
	else
		var_78_3 = var_78_2.modle_ID
	end

	if var_78_2.type == var_0_2.BulletType.BEAM or var_78_2.type == var_0_2.BulletType.SPACE_LASER or var_78_2.type == var_0_2.BulletType.MISSILE or var_78_2.type == var_0_2.BulletType.ELECTRIC_ARC then
		var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.modle_ID)
	else
		var_78_0[#var_78_0 + 1] = var_0_5.GetBulletPath(var_78_3)
	end

	if var_78_2.extra_param.mirror then
		var_78_0[#var_78_0 + 1] = var_0_5.GetBulletPath(var_78_3 .. var_0.Battle.BattleBulletUnit.MIRROR_RES)
	end

	local var_78_4

	if var_78_1 and var_78_1.hit_fx_name ~= "" then
		var_78_4 = var_78_1.hit_fx_name
	else
		var_78_4 = var_78_2.hit_fx
	end

	var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_4)
	var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.miss_fx)
	var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.alert_fx)

	if var_78_2.extra_param.area_FX then
		var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.extra_param.area_FX)
	end

	if var_78_2.extra_param.shrapnel then
		ipairs = var_7

		for iter_78_0, iter_78_1 in var_7(var_78_2.extra_param.shrapnel) do
			local var_78_5 = var_0_5.GetBulletResource(iter_78_1.bullet_ID)

			ipairs = var_1_10013

			for iter_78_2, iter_78_3 in var_1_10013(var_78_5) do
				var_78_0[#var_78_0 + 1] = iter_78_3
			end
		end
	end

	ipairs = var_7

	for iter_78_4, iter_78_5 in var_7(var_78_2.attach_buff) do
		if iter_78_5.effect_id then
			var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(iter_78_5.effect_id)
		end

		if iter_78_5.buff_id then
			local var_78_6 = var_0.Battle.BattleDataFunction.GetResFromBuff(iter_78_5.buff_id, 1, {})

			ipairs = var_1_10013

			for iter_78_6, iter_78_7 in var_1_10013(var_78_6) do
				var_78_0[#var_78_0 + 1] = iter_78_7
			end
		end
	end

	return var_78_0
end

function var_0_5.GetAircraftResource(arg_79_0, arg_79_1, arg_79_2, arg_79_3)
	local var_79_0 = {}

	arg_79_2 = arg_79_2 or 0

	local var_79_1 = var_0_1.GetAircraftTmpDataFromID(arg_79_0)
	local var_79_2
	local var_79_3
	local var_79_4
	local var_79_5

	if arg_79_2 ~= 0 then
		local var_79_6, var_79_7, var_79_8

		var_79_6, var_79_7, var_1_10012, var_79_8 = var_0_1.GetEquipSkin(arg_79_2)

		local var_79_9 = var_79_8
		local var_79_10 = var_1_10012
		local var_79_11 = var_79_7

		var_79_2 = var_79_6

		if var_79_11 ~= "" then
			var_79_0[#var_79_0 + 1] = var_0_5.GetBulletPath(var_79_11)
		end

		if var_79_10 ~= "" then
			var_79_0[#var_79_0 + 1] = var_0_5.GetBulletPath(var_79_10)
		end

		if var_79_9 ~= "" then
			var_79_0[#var_79_0 + 1] = var_0_5.GetBulletPath(var_79_9)
		end
	else
		var_79_2 = var_79_1.model_ID
	end

	var_79_0[#var_79_0 + 1] = var_0_5.GetCharacterGoPath(var_79_2)

	if arg_79_3 then
		var_79_0[#var_79_0 + 1] = var_0_5.GetAircraftIconPath(var_79_1.model_ID)
	end

	local var_79_12 = arg_79_1 or var_79_1.weapon_ID

	type = var_11

	if var_11(var_79_12) == "table" then
		ipairs = var_11

		for iter_79_0, iter_79_1 in var_11(var_79_12) do
			local var_79_13 = var_0_5.GetWeaponResource(iter_79_1)

			ipairs = var_1_10017

			for iter_79_2, iter_79_3 in var_1_10017(var_79_13) do
				var_79_0[#var_79_0 + 1] = iter_79_3
			end
		end
	else
		local var_79_14 = var_0_5.GetWeaponResource(var_79_12)

		ipairs = var_1_10012

		for iter_79_4, iter_79_5 in var_1_10012(var_79_14) do
			var_79_0[#var_79_0 + 1] = iter_79_5
		end
	end

	return var_79_0
end

function var_0_5.GetCommanderBuffRes(arg_80_0)
	local var_80_0 = {}

	ipairs = var_1_10002

	for iter_80_0, iter_80_1 in var_1_10002(arg_80_0) do
		local var_80_1 = var_0_5.GetCommanderResource(iter_80_1)

		ipairs = var_1_10008

		for iter_80_2, iter_80_3 in var_1_10008(var_80_1) do
			table = var_1_10013

			var_1_10013.insert(var_80_0, iter_80_3)
		end
	end

	return var_80_0
end

function var_0_5.GetCommanderResource(arg_81_0)
	local var_81_0 = {}
	local var_81_1 = arg_81_0[1]

	var_81_0[#var_81_0 + 1] = var_0_5.GetCommanderHrzIconPath(var_81_1:getPainting())
	var_81_0[#var_81_0 + 1] = var_0_5.GetCommanderIconPath(var_81_1:getPainting())

	local var_81_2 = var_81_1:getSkills()[1]
	local var_81_3 = var_3.getLevel(var_81_2)

	ipairs = var_4

	for iter_81_0, iter_81_1 in var_4(arg_81_0[2]) do
		local var_81_4 = var_0.Battle.BattleDataFunction.GetResFromBuff(iter_81_1, var_81_3, {})

		ipairs = var_1_10010

		for iter_81_2, iter_81_3 in var_1_10010(var_81_4) do
			var_81_0[#var_81_0 + 1] = iter_81_3
		end
	end

	return var_81_0
end

function var_0_5.GetResFromBuffIDList(arg_82_0)
	local var_82_0 = {}

	ipairs = var_1_10002

	for iter_82_0, iter_82_1 in var_1_10002(arg_82_0) do
		local var_82_1 = var_0_1.GetResFromBuff(iter_82_1, 1, {})

		ipairs = var_1_10008

		for iter_82_2, iter_82_3 in var_1_10008(var_82_1) do
			table = var_1_10013

			var_1_10013.insert(var_82_0, iter_82_3)
		end
	end

	return var_82_0
end

function var_0_5.GetResFromBuffList(arg_83_0)
	local var_83_0 = {}

	ipairs = var_1_10002

	for iter_83_0, iter_83_1 in var_1_10002(arg_83_0) do
		local var_83_1 = var_0_1.GetResFromBuff(iter_83_1.id, iter_83_1.level, {})

		ipairs = var_1_10008

		for iter_83_2, iter_83_3 in var_1_10008(var_83_1) do
			table = var_1_10013

			var_1_10013.insert(var_83_0, iter_83_3)
		end
	end

	return var_83_0
end

function var_0_5.GetStageResource(arg_84_0)
	local var_84_0 = var_0.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_84_0)
	local var_84_1 = {}
	local var_84_2 = {}

	ipairs = var_1_10004

	for iter_84_0, iter_84_1 in var_1_10004(var_84_0.stages) do
		if iter_84_1.stageBuff then
			ipairs = var_9

			for iter_84_2, iter_84_3 in var_9(iter_84_1.stageBuff) do
				local var_84_3 = var_0.Battle.BattleDataFunction.GetResFromBuff(iter_84_3.id, iter_84_3.level, {})

				ipairs = var_1_10015

				for iter_84_4, iter_84_5 in var_1_10015(var_84_3) do
					var_84_1[#var_84_1 + 1] = iter_84_5
				end
			end
		end

		ipairs = var_9

		for iter_84_6, iter_84_7 in var_9(iter_84_1.waves) do
			if iter_84_7.triggerType == var_0.Battle.BattleConst.WaveTriggerType.NORMAL then
				ipairs = var_14

				for iter_84_8, iter_84_9 in var_14(iter_84_7.spawn) do
					local var_84_4 = var_0_5.GetMonsterRes(iter_84_9)

					ipairs = var_1_10020

					for iter_84_10, iter_84_11 in var_1_10020(var_84_4) do
						table = var_1_10025

						var_1_10025.insert(var_84_1, iter_84_11)
					end
				end

				if iter_84_7.reinforcement then
					ipairs = var_14

					for iter_84_12, iter_84_13 in var_14(iter_84_7.reinforcement) do
						local var_84_5 = var_0_5.GetMonsterRes(iter_84_13)

						ipairs = var_1_10020

						for iter_84_14, iter_84_15 in var_1_10020(var_84_5) do
							table = var_1_10025

							var_1_10025.insert(var_84_1, iter_84_15)
						end
					end
				end
			elseif iter_84_7.triggerType == var_0.Battle.BattleConst.WaveTriggerType.AID then
				local var_84_6 = iter_84_7.triggerParams.vanguard_unitList

				var_1_10015 = iter_84_7.triggerParams.main_unitList

				local var_84_7 = iter_84_7.triggerParams.sub_unitList

				local function var_84_8(arg_85_0)
					local var_85_0 = var_0_5.GetAidUnitsRes(arg_85_0)

					ipairs = var_2_10002

					for iter_85_0, iter_85_1 in var_2_10002(var_85_0) do
						table = var_2_10007

						var_2_10007.insert(var_84_1, iter_85_1)
					end

					ipairs = var_2

					for iter_85_2, iter_85_3 in var_2(arg_85_0) do
						var_84_2[#var_84_2 + 1] = iter_85_3.skinId
					end

					return
				end

				if var_84_6 then
					var_84_8(var_84_6)
				end

				if var_1_10015 then
					var_84_8(var_1_10015)
				end

				if var_84_7 then
					var_84_8(var_84_7)
				end
			elseif iter_84_7.triggerType == var_0.Battle.BattleConst.WaveTriggerType.ENVIRONMENT then
				ipairs = var_14

				for iter_84_16, iter_84_17 in var_14(iter_84_7.spawn) do
					var_0_5.GetEnvironmentRes(var_84_1, iter_84_17)
				end
			elseif iter_84_7.triggerType == var_0.Battle.BattleConst.WaveTriggerType.CARD_PUZZLE then
				local var_84_9 = var_0.Battle.BattleDataFunction.GetCardRes(iter_84_7.triggerParams.card_id)

				ipairs = var_1_10015

				for iter_84_18, iter_84_19 in var_1_10015(var_84_9) do
					table = var_1_10020

					var_1_10020.insert(var_84_1, iter_84_19)
				end
			end

			if iter_84_7.airFighter ~= nil then
				pairs = var_14

				for iter_84_20, iter_84_21 in var_14(iter_84_7.airFighter) do
					local var_84_10 = var_0_5.GetAircraftResource(iter_84_21.templateID, iter_84_21.weaponID, nil, true)

					ipairs = var_1_10020

					for iter_84_22, iter_84_23 in var_1_10020(var_84_10) do
						var_84_1[#var_84_1 + 1] = iter_84_23
					end
				end
			end
		end
	end

	return var_84_1, var_84_2
end

function var_0_5.GetStageBGM(arg_86_0)
	local var_86_0 = var_0.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_86_0)
	local var_86_1 = {}

	ipairs = var_3

	for iter_86_0, iter_86_1 in var_3(var_86_0.stages) do
		ipairs = var_1_10008

		for iter_86_2, iter_86_3 in var_1_10008(iter_86_1.waves) do
			if iter_86_3.triggerType == var_0.Battle.BattleConst.WaveTriggerType.BGM and iter_86_3.triggerParams.bgm then
				table = var_14

				var_14.insert(var_86_1, "cue/bgm-" .. var_13 .. ".b")
			end
		end
	end

	return var_86_1
end

function var_0_5.GetEnvironmentRes(arg_87_0, arg_87_1)
	table = var_1_10002

	local var_87_0 = var_1_10002.insert
	local var_87_1 = arg_87_0
	local var_87_2

	if arg_87_1.prefab then
		var_87_2 = var_0_5.GetFXPath(arg_87_1.prefab)
	end

	var_87_0(var_87_1, var_87_2)

	local var_87_3 = arg_87_1.behaviours
	local var_87_4 = var_0.Battle.BattleDataFunction.GetEnvironmentBehaviour(var_87_3).behaviour_list

	ipairs = var_87_1

	for iter_87_0, iter_87_1 in var_87_1(var_87_4) do
		if iter_87_1.type == var_0.Battle.BattleConst.EnviroumentBehaviour.BUFF then
			local var_87_5 = var_0.Battle.BattleDataFunction.GetResFromBuff(iter_87_1.buff_id, 1, {})

			ipairs = var_1_10011

			for iter_87_2, iter_87_3 in var_1_10011(var_87_5) do
				arg_87_0[#arg_87_0 + 1] = iter_87_3
			end
		elseif var_9 == var_0.Battle.BattleConst.EnviroumentBehaviour.SPAWN then
			local var_87_6

			if iter_87_1.content and iter_87_1.content.alert then
				var_87_6 = iter_87_1.content.alert.alert_fx
			end

			table = var_1_10011

			var_1_10011.insert(arg_87_0, var_87_6 and var_0_5.GetFXPath(var_87_6))

			if iter_87_1.content then
				var_1_10011 = iter_87_1.content.child_prefab
			end

			if var_1_10011 then
				var_0_5.GetEnvironmentRes(arg_87_0, var_1_10011)
			end
		elseif var_9 == var_0.Battle.BattleConst.EnviroumentBehaviour.PLAY_FX then
			arg_87_0[#arg_87_0 + 1] = var_0_5.GetFXPath(iter_87_1.FX_ID)
		end
	end

	return
end

function var_0_5.GetMonsterRes(arg_88_0)
	local var_88_0 = {}
	local var_88_1 = var_0_5.GetEnemyResource(arg_88_0)

	ipairs = var_1_10003

	for iter_88_0, iter_88_1 in var_1_10003(var_88_1) do
		var_88_0[#var_88_0 + 1] = iter_88_1
	end

	local var_88_2 = var_0.Battle.BattleDataFunction.GetMonsterTmpDataFromID(arg_88_0.monsterTemplateID)

	Clone = var_4

	local var_88_3 = var_4(var_88_2.equipment_list)
	local var_88_4 = var_88_2.buff_list

	Clone = var_6

	local var_88_5

	if not var_6(arg_88_0.buffList) then
		var_88_5 = {}
	end

	if arg_88_0.phase then
		ipairs = var_7

		for iter_88_2, iter_88_3 in var_7(arg_88_0.phase) do
			if iter_88_3.addWeapon then
				ipairs = var_12

				for iter_88_4, iter_88_5 in var_12(iter_88_3.addWeapon) do
					var_88_3[#var_88_3 + 1] = iter_88_5
				end
			end

			if iter_88_3.addRandomWeapon then
				ipairs = var_12

				for iter_88_6, iter_88_7 in var_12(iter_88_3.addRandomWeapon) do
					ipairs = var_1_10017

					for iter_88_8, iter_88_9 in var_1_10017(iter_88_7) do
						var_88_3[#var_88_3 + 1] = iter_88_9
					end
				end
			end

			if iter_88_3.addBuff then
				ipairs = var_12

				for iter_88_10, iter_88_11 in var_12(iter_88_3.addBuff) do
					var_88_5[#var_88_5 + 1] = iter_88_11
				end
			end
		end
	end

	ipairs = var_7

	for iter_88_12, iter_88_13 in var_7(var_88_4) do
		local var_88_6 = var_0.Battle.BattleDataFunction.GetResFromBuff(iter_88_13.ID, iter_88_13.LV, {})

		ipairs = var_1_10013

		for iter_88_14, iter_88_15 in var_1_10013(var_88_6) do
			var_88_0[#var_88_0 + 1] = iter_88_15
		end
	end

	ipairs = var_7

	for iter_88_16, iter_88_17 in var_7(var_88_5) do
		local var_88_7 = var_0.Battle.BattleDataFunction.GetResFromBuff(iter_88_17, 1, {})

		ipairs = var_1_10013

		for iter_88_18, iter_88_19 in var_1_10013(var_88_7) do
			var_88_0[#var_88_0 + 1] = iter_88_19
		end

		var_1_10013 = var_0.Battle.BattleDataFunction.GetBuffTemplate(iter_88_17, 1)
		pairs = var_14

		for iter_88_20, iter_88_21 in var_14(var_1_10013.effect_list) do
			if iter_88_21.arg_list.skill_id and var_0.Battle.BattleDataFunction.NeedSkillPainting(var_19) then
				var_88_0[#var_88_0 + 1] = var_0_5.GetPaintingPath(var_0_1.GetMonsterTmpDataFromID(arg_88_0.monsterTemplateID).icon)

				break
			end
		end
	end

	ipairs = var_7

	for iter_88_22, iter_88_23 in var_7(var_88_3) do
		local var_88_8 = var_0_5.GetWeaponResource(iter_88_23)

		ipairs = var_1_10013

		for iter_88_24, iter_88_25 in var_1_10013(var_88_8) do
			var_88_0[#var_88_0 + 1] = iter_88_25
		end
	end

	return var_88_0
end

function var_0_5.GetEquipSkinPreviewRes(arg_89_0)
	local var_89_0 = {}
	local var_89_1 = var_0_1.GetEquipSkinDataFromID(arg_89_0)

	ipairs = var_1_10003

	for iter_89_0, iter_89_1 in var_1_10003(var_89_1.weapon_ids) do
		local var_89_2 = var_0_5.GetWeaponResource(iter_89_1)

		ipairs = var_1_10009

		for iter_89_2, iter_89_3 in var_1_10009(var_89_2) do
			var_89_0[#var_89_0 + 1] = iter_89_3
		end
	end

	local function var_89_3(arg_90_0)
		if arg_90_0 ~= "" then
			var_89_0[#var_89_0 + 1] = var_0_5.GetBulletPath(arg_90_0)
		end

		return
	end

	local var_89_4, var_89_5, var_89_6, var_89_7, var_89_8, var_89_9 = var_0_1.GetEquipSkin(arg_89_0)

	_ = var_1_10010

	local var_89_10 = var_1_10010.any

	EquipType = iter_89_2

	if var_89_10(iter_89_2.AirProtoEquipTypes, function(arg_91_0)
		table = var_2_10001

		return var_2_10001.contains(var_89_1.equip_type, arg_91_0)
	end) then
		var_89_0[#var_89_0 + 1] = var_0_5.GetCharacterGoPath(var_89_4)
	else
		var_89_0[#var_89_0 + 1] = var_0_5.GetBulletPath(var_89_4)
	end

	var_89_3(var_89_5)
	var_89_3(var_89_6)
	var_89_3(var_89_7)

	if var_89_8 and var_89_8 ~= "" then
		var_89_0[#var_89_0 + 1] = var_0_5.GetFXPath(var_89_8)
	end

	if var_89_9 and var_89_9 ~= "" then
		var_89_0[#var_89_0 + 1] = var_0_5.GetFXPath(var_89_9)
	end

	return var_89_0
end

function var_0_5.GetEquipSkinBulletRes(arg_92_0)
	local var_92_0 = {}
	local var_92_1, var_92_2, var_92_3, var_92_4 = var_0_1.GetEquipSkin(arg_92_0)

	local function var_92_5(arg_93_0)
		if arg_93_0 ~= "" then
			var_92_0[#var_92_0 + 1] = var_0_5.GetBulletPath(arg_93_0)
		end

		return
	end

	local var_92_6 = var_0_1.GetEquipSkinDataFromID(arg_92_0)
	local var_92_7 = false

	ipairs = var_9

	for iter_92_0, iter_92_1 in var_9(var_92_6.equip_type) do
		table = var_1_10014
		var_1_10014 = var_1_10014.contains
		EquipType = var_1_10016

		if var_1_10014(var_1_10016.AircraftSkinType, iter_92_1) then
			var_92_7 = true
		end
	end

	if var_92_7 then
		if var_92_1 ~= "" then
			var_92_0[#var_92_0 + 1] = var_0_5.GetCharacterGoPath(var_92_1)
		end
	else
		var_92_5(var_92_1)

		if var_0_1.GetEquipSkinDataFromID(arg_92_0).mirror == 1 then
			var_92_0[#var_92_0 + 1] = var_0_5.GetBulletPath(var_92_1 .. var_0.Battle.BattleBulletUnit.MIRROR_RES)
		end
	end

	var_92_5(var_92_2)
	var_92_5(var_92_3)
	var_92_5(var_92_4)

	return var_92_0
end

function var_0_5.GetAidUnitsRes(arg_94_0)
	local var_94_0 = {}

	ipairs = var_1_10002

	for iter_94_0, iter_94_1 in var_1_10002(arg_94_0) do
		local var_94_1 = var_0_5.GetShipResource(iter_94_1.tmpID, nil, true)

		ipairs = var_1_10008

		for iter_94_2, iter_94_3 in var_1_10008(iter_94_1.equipment) do
			if iter_94_3 ~= 0 then
				Ship = var_1_10013

				if iter_94_2 <= var_1_10013.WEAPON_COUNT then
					var_1_10013 = var_0_1.GetWeaponDataFromID(iter_94_3).weapon_id
					ipairs = var_1_10014

					for iter_94_4, iter_94_5 in var_1_10014(var_1_10013) do
						var_1_10019 = var_0_5.GetWeaponResource(iter_94_5)
						ipairs = var_1_10020

						for iter_94_6, iter_94_7 in var_1_10020(var_1_10019) do
							table = var_1_10025

							var_1_10025.insert(var_94_1, iter_94_7)
						end
					end
				else
					var_1_10013 = var_0_5.GetEquipResource(iter_94_3)
					ipairs = var_1_10014

					for iter_94_8, iter_94_9 in var_1_10014(var_1_10013) do
						table = var_1_10019

						var_1_10019.insert(var_94_1, iter_94_9)
					end
				end
			end
		end

		ipairs = var_1_10008

		for iter_94_10, iter_94_11 in var_1_10008(var_94_1) do
			table = var_1_10013

			var_1_10013.insert(var_94_0, iter_94_11)
		end
	end

	return var_94_0
end

function var_0_5.GetSpWeaponResource(arg_95_0, arg_95_1)
	local var_95_0 = {}

	if var_0.Battle.BattleDataFunction.GetSpWeaponDataFromID(arg_95_0).effect_id ~= 0 then
		local var_95_1 = arg_95_1 and var_0.Battle.BattleDataFunction.SkillTranform(arg_95_1, var_95_1) or var_95_1
		local var_95_2 = var_0.Battle.BattleDataFunction.GetResFromBuff(var_95_1, 1, {})

		ipairs = var_1_10006

		for iter_95_0, iter_95_1 in var_1_10006(var_95_2) do
			var_95_0[#var_95_0 + 1] = iter_95_1
		end
	end

	return var_95_0
end

return
