ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local PoolUtil = require("Mgr/Pool/PoolUtil")
local var_0_5 = singletonClass("BattleResourceManager")

ys.Battle.BattleResourceManager = var_0_5
var_0_5.__name = "BattleResourceManager"

function var_0_5.Ctor(arg_1_0)
	arg_1_0.rotateScriptMap = setmetatable({}, {
		__mode = "kv"
	})

	return
end

function var_0_5.Init(arg_2_0)
	arg_2_0._preloadList = {}
	arg_2_0._resCacheList = {}
	arg_2_0._allPool = {}
	arg_2_0._ob2Pool = {}

	local var_2_0 = GameObject()

	var_2_0:SetActive(false)

	var_2_0.name = "PoolRoot"
	var_2_0.transform.position = Vector3(-10000, -10000, 0)
	arg_2_0._poolRoot = var_2_0
	arg_2_0._bulletContainer = GameObject("BulletContainer")
	arg_2_0._battleCVList = {}

	return
end

function var_0_5:Clear()
	for iter_3_0, iter_3_1 in pairs(self._allPool) do
		iter_3_1:Dispose()
	end

	for iter_3_2, iter_3_3 in pairs(self._resCacheList) do
		if string.find(iter_3_2, "Char/") then
			var_0_5.ClearCharRes(iter_3_2, iter_3_3)
		elseif string.find(iter_3_2, "painting/") then
			var_0_5.ClearPaintingRes(iter_3_2, iter_3_3)
		else
			PoolUtil.Destroy(iter_3_3)
		end
	end

	self._resCacheList = {}
	self._ob2Pool = {}
	self._allPool = {}

	Object.Destroy(self._poolRoot)

	self._poolRoot = nil

	Object.Destroy(self._bulletContainer)

	self._bulletContainer = nil
	self.rotateScriptMap = setmetatable({}, {
		__mode = "kv"
	})

	for iter_3_4, iter_3_5 in pairs(self._battleCVList) do
		pg.CriMgr.UnloadCVBank(iter_3_5)
	end

	self._battleCVList = {}

	var_0_0.Battle.BattleDataFunction.ClearConvertedBarrage()

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
	local var_19_1 = string.find(arg_19_0, "%/")

	while var_19_1 do
		var_19_0 = string.sub(var_19_0, var_19_1 + 1)
		var_19_1 = string.find(var_19_0, "%/")
	end

	return var_19_0
end

function var_0_5.ClearCharRes(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:GetComponent("SkeletonRenderer").skeletonDataAsset

	if not PoolMgr.GetInstance():IsSpineSkelCached((var_0_5.GetResName(arg_20_0))) then
		UIUtil.ClearSharedMaterial(arg_20_1)
	end

	PoolUtil.Destroy(arg_20_1)

	return
end

function var_0_5.ClearPaintingRes(arg_21_0, arg_21_1)
	PoolMgr.GetInstance():ReturnPainting(var_0_5.GetPaintingName((var_0_5.GetResName(arg_21_0))), arg_21_1)

	return
end

function var_0_5:DestroyOb(arg_22_1)
	if arg_22_1 == nil or IsNil(arg_22_1) then
		return
	end

	local var_22_0 = self._ob2Pool[arg_22_1]

	self._ob2Pool[arg_22_1] = nil

	if var_22_0 then
		var_22_0:Recycle(arg_22_1)
	else
		PoolUtil.Destroy(arg_22_1)
	end

	return
end

function var_0_5:popPool(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:GetObject()

	if not arg_23_2 then
		var_23_0.transform.parent = nil
	end

	self._ob2Pool[var_23_0] = arg_23_1

	return var_23_0
end

function var_0_5:InstCharacter(arg_24_1, arg_24_2)
	local var_24_0 = self.GetCharacterPath(arg_24_1)
	local var_24_1 = self._allPool[var_24_0]

	if self._allPool[var_24_0] then
		arg_24_2((self:popPool(var_24_1)))
	elseif self._resCacheList[var_24_0] ~= nil then
		self:InitPool(var_24_0, self._resCacheList[var_24_0])

		var_24_1 = self._allPool[var_24_0]

		arg_24_2((self:popPool(self._allPool[var_24_0])))
	else
		self:LoadSpineAsset(arg_24_1, function(arg_25_0)
			if not self._poolRoot then
				var_0_5.ClearCharRes(var_24_0, arg_25_0)

				return
			end

			assert(arg_25_0, "角色资源加载失败：" .. arg_24_1)

			local var_25_0 = SpineAnim.AnimChar(arg_24_1, arg_25_0)

			var_25_0:SetActive(false)
			self:InitPool(var_24_0, var_25_0)

			var_24_1 = self._allPool[var_24_0]

			arg_24_2((self:popPool(var_24_1)))

			return
		end)
	end

	return
end

function var_0_5:LoadSpineAsset(arg_26_1, arg_26_2)
	if not PoolMgr.GetInstance():IsSpineSkelCached(arg_26_1) then
		ResourceMgr.Inst:getAssetAsync(self.GetCharacterPath(arg_26_1), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_27_0)
			arg_26_2(arg_27_0)

			return
		end), true, true)
	else
		PoolMgr.GetInstance():GetSpineSkel(arg_26_1, true, arg_26_2)
	end

	return
end

function var_0_5:InstAirCharacter(arg_28_1, arg_28_2)
	local var_28_0 = self.GetCharacterGoPath(arg_28_1)
	local var_28_1 = self._allPool[var_28_0]

	if self._allPool[var_28_0] then
		arg_28_2((self:popPool(var_28_1)))
	elseif self._resCacheList[var_28_0] ~= nil then
		self:InitPool(var_28_0, self._resCacheList[var_28_0])

		var_28_1 = self._allPool[var_28_0]

		arg_28_2((self:popPool(self._allPool[var_28_0])))
	else
		ResourceMgr.Inst:getAssetAsync(var_28_0, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_29_0)
			if not self._poolRoot then
				PoolUtil.Destroy(arg_29_0)

				return
			else
				assert(arg_29_0, "飞机资源加载失败：" .. arg_28_1)
				self:InitPool(var_28_0, arg_29_0)

				var_28_1 = self._allPool[var_28_0]

				arg_28_2((self:popPool(var_28_1)))
			end

			return
		end), true, true)
	end

	return
end

function var_0_5:InstBullet(arg_30_1, arg_30_2)
	local var_30_0 = self.GetBulletPath(arg_30_1)
	local var_30_1 = self._allPool[var_30_0]

	if self._allPool[var_30_0] then
		local var_30_2 = self:popPool(var_30_1, true)

		if string.find(arg_30_1, "_trail") then
			local var_30_3 = var_30_2:GetComponentInChildren(typeof(UnityEngine.TrailRenderer))

			if var_30_3 then
				var_30_3:Clear()
			end
		end

		arg_30_2(var_30_2)

		return true
	elseif self._resCacheList[var_30_0] ~= nil then
		self:InitPool(var_30_0, self._resCacheList[var_30_0])

		var_30_1 = self._allPool[var_30_0]

		local var_30_4 = self:popPool(self._allPool[var_30_0], true)

		if string.find(arg_30_1, "_trail") then
			local var_30_5 = var_30_4:GetComponentInChildren(typeof(UnityEngine.TrailRenderer))

			if var_30_5 then
				var_30_5:Clear()
			end
		end

		arg_30_2(var_30_4)

		return true
	else
		ResourceMgr.Inst:getAssetAsync(var_30_0, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_31_0)
			if not self._poolRoot then
				PoolUtil.Destroy(arg_31_0)

				return
			else
				assert(arg_31_0, "子弹资源加载失败：" .. arg_30_1)
				self:InitPool(var_30_0, arg_31_0)

				var_30_1 = self._allPool[var_30_0]

				arg_30_2((self:popPool(var_30_1, true)))
			end

			return
		end), true, true)

		return false
	end

	return
end

function var_0_5:InstFX(arg_32_1, arg_32_2)
	local var_32_0 = self.GetFXPath(arg_32_1)
	local var_32_1

	if self._allPool[var_32_0] then
		var_32_1 = self:popPool(self._allPool[var_32_0], arg_32_2)
	elseif self._resCacheList[var_32_0] ~= nil then
		self:InitPool(var_32_0, self._resCacheList[var_32_0])

		var_32_1 = self:popPool(self._allPool[var_32_0], arg_32_2)
	else
		ResourceMgr.Inst:getAssetAsync(var_32_0, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_33_0)
			if not self._poolRoot then
				PoolUtil.Destroy(arg_33_0)

				return
			else
				assert(arg_33_0, "特效资源加载失败：" .. arg_32_1)
				self:InitPool(var_32_0, arg_33_0)
			end

			return
		end), true, true)

		var_32_1 = GameObject(arg_32_1 .. "临时假obj")

		var_32_1:SetActive(false)

		self._resCacheList[var_32_0] = var_32_1
	end

	local var_32_2 = tf(var_32_1):Find("bullet")

	if var_32_2 and var_32_2:GetComponent(typeof(SpineAnim)) then
		local var_32_3 = var_32_2:GetComponent("SkeletonAnimation")

		var_32_2:GetComponent(typeof(SpineAnim)):SetAction((var_32_3 or nil) and SpineAnimUtil.GetCharAnimDirect(var_32_3, math.sign(var_32_2.localScale.x), "normal"), 0, false)
	end

	return var_32_1
end

function var_0_5:InstOrbit(arg_34_1)
	local var_34_0 = self.GetOrbitPath(arg_34_1)
	local var_34_1

	if self._allPool[var_34_0] then
		var_34_1 = self:popPool(self._allPool[var_34_0])
	elseif self._resCacheList[var_34_0] ~= nil then
		self:InitPool(var_34_0, self._resCacheList[var_34_0])

		var_34_1 = self:popPool(self._allPool[var_34_0])
	else
		ResourceMgr.Inst:getAssetAsync(var_34_0, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_35_0)
			if not self._poolRoot then
				PoolUtil.Destroy(arg_35_0)

				return
			else
				assert(arg_35_0, "特效资源加载失败：" .. arg_34_1)
				self:InitPool(var_34_0, arg_35_0)
			end

			return
		end), true, true)

		var_34_1 = GameObject(arg_34_1 .. "临时假obj")

		var_34_1:SetActive(false)

		self._resCacheList[var_34_0] = var_34_1
	end

	return var_34_1
end

function var_0_5:InstSkillPaintingUI()
	local var_36_0 = self._allPool["UI/SkillPainting"]:GetObject()

	self._ob2Pool[var_36_0] = self._allPool["UI/SkillPainting"]

	return var_36_0
end

function var_0_5:InstSkillPaintingDALUI()
	local var_37_0 = self._allPool["UI/SkillPaintingDAL"]:GetObject()

	self._ob2Pool[var_37_0] = self._allPool["UI/SkillPaintingDAL"]

	return var_37_0
end

function var_0_5:InstBossWarningUI()
	local var_38_0 = self._allPool["UI/MonsterAppearUI"]:GetObject()

	self._ob2Pool[var_38_0] = self._allPool["UI/MonsterAppearUI"]

	return var_38_0
end

function var_0_5:InstGridmanSkillUI()
	local var_39_0 = self._allPool["UI/combatgridmanskillfloat"]:GetObject()

	self._ob2Pool[var_39_0] = self._allPool["UI/combatgridmanskillfloat"]

	return var_39_0
end

function var_0_5:InstReisalinAPUI()
	local var_40_0 = self._allPool["UI/combatreisalinapui"]:GetObject()

	self._ob2Pool[var_40_0] = self._allPool["UI/combatreisalinapui"]

	return var_40_0
end

function var_0_5:InstYumiaManaUI()
	local var_41_0 = self._allPool["UI/combatyumiamanaui"]:GetObject()

	self._ob2Pool[var_41_0] = self._allPool["UI/combatyumiamanaui"]

	return var_41_0
end

function var_0_5:InstPainting(arg_42_1)
	local var_42_0 = self.GetPaintingPath(arg_42_1)
	local var_42_1

	if self._allPool[var_42_0] then
		var_42_1 = self._allPool[var_42_0]:GetObject()
		self._ob2Pool[var_42_1] = self._allPool[var_42_0]
	elseif self._resCacheList[var_42_0] ~= nil then
		var_42_1 = Object.Instantiate(self._resCacheList[var_42_0])

		var_42_1:SetActive(true)
	end

	return var_42_1
end

function var_0_5:InstMap(arg_43_1)
	local var_43_0 = self.GetMapPath(arg_43_1)
	local var_43_1

	if self._allPool[var_43_0] then
		var_43_1 = self._allPool[var_43_0]:GetObject()
		self._ob2Pool[var_43_1] = self._allPool[var_43_0]
	elseif self._resCacheList[var_43_0] ~= nil then
		var_43_1 = Object.Instantiate(self._resCacheList[var_43_0])
	else
		assert(false, "地图资源没有预加载：" .. arg_43_1)
	end

	var_43_1:SetActive(true)

	return var_43_1
end

function var_0_5:InstCardPuzzleCard()
	local var_44_0 = self._allPool["UI/CardTowerCardCombat"]:GetObject()

	self._ob2Pool[var_44_0] = self._allPool["UI/CardTowerCardCombat"]

	return var_44_0
end

function var_0_5:GetCharacterIcon(arg_45_1)
	return self._resCacheList[var_0_5.GetHrzIcon(arg_45_1)]
end

function var_0_5:GetCharacterSquareIcon(arg_46_1)
	return self._resCacheList[var_0_5.GetSquareIcon(arg_46_1)]
end

function var_0_5:GetCharacterQIcon(arg_47_1)
	return self._resCacheList[var_0_5.GetQIcon(arg_47_1)]
end

function var_0_5:GetAircraftIcon(arg_48_1)
	return self._resCacheList[var_0_5.GetAircraftIconPath(arg_48_1)]
end

function var_0_5:GetShipTypeIcon(arg_49_1)
	return self._resCacheList[var_0_5.GetShipTypeIconPath(arg_49_1)]
end

function var_0_5:GetCommanderHrzIcon(arg_50_1)
	return self._resCacheList[var_0_5.GetCommanderHrzIconPath(arg_50_1)]
end

function var_0_5:GetCommanderIcon(arg_51_1)
	return self._resCacheList[var_0_5.GetCommanderIconPath(arg_51_1)]
end

function var_0_5.GetShader(arg_52_0, arg_52_1)
	return (pg.ShaderMgr.GetInstance():GetShader(var_0_3.BATTLE_SHADER[arg_52_1]))
end

function var_0_5:AddPreloadResource(arg_53_1)
	if type(arg_53_1) == "string" then
		self._preloadList[arg_53_1] = false
	elseif type(arg_53_1) == "table" then
		for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
			self._preloadList[iter_53_1] = false
		end
	end

	return
end

function var_0_5:AddPreloadCV(arg_54_1)
	local var_54_0 = ShipWordHelper.RawGetCVKey(arg_54_1)

	if var_54_0 > 0 then
		self._battleCVList[var_54_0] = pg.CriMgr.GetBattleCVBankName(var_54_0)
	end

	return
end

function var_0_5:StartPreload(arg_55_1, arg_55_2)
	local var_55_0 = 0
	local var_55_1 = 0

	for iter_55_0, iter_55_1 in pairs(self._preloadList) do
		var_55_1 = var_55_1 + 1
	end

	for iter_55_2, iter_55_3 in pairs(self._battleCVList) do
		var_55_1 = var_55_1 + 1
	end

	local function var_55_2()
		if not self._poolRoot then
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
			self._preloadList = nil

			arg_55_1()
		end

		return
	end

	for iter_55_4, iter_55_5 in pairs(self._battleCVList) do
		pg.CriMgr.GetInstance():LoadBattleCV(iter_55_4, var_55_2)
	end

	for iter_55_6, iter_55_7 in pairs(self._preloadList) do
		local var_55_3 = self.GetResName(iter_55_6)

		if var_55_3 == "" or self._resCacheList[iter_55_6] ~= nil then
			var_55_2()
		elseif string.find(iter_55_6, "herohrzicon/") or string.find(iter_55_6, "qicon/") or string.find(iter_55_6, "squareicon/") or string.find(iter_55_6, "commanderhrz/") or string.find(iter_55_6, "commandericon/") or string.find(iter_55_6, "AircraftIcon/") then
			local var_55_4, var_55_5 = HXSet.autoHxShiftPath(iter_55_6, var_55_3)

			ResourceMgr.Inst:getAssetAsync(var_55_4, "", typeof(Sprite), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_57_0)
				if arg_57_0 == nil then
					originalPrint("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
				else
					if not self._poolRoot then
						PoolUtil.Destroy(arg_57_0)

						return
					end

					if self._resCacheList then
						self._resCacheList[iter_55_6] = arg_57_0
					end
				end

				var_55_2()

				return
			end), true, true)
		elseif string.find(iter_55_6, "shiptype/") then
			GetSpriteFromAtlasAsync("shiptype", string.split(iter_55_6, "/")[2], function(arg_58_0)
				if arg_58_0 == nil then
					originalPrint("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
				else
					if not self._poolRoot then
						PoolUtil.Destroy(arg_58_0)

						return
					end

					if self._resCacheList then
						self._resCacheList[iter_55_6] = arg_58_0
					end
				end

				var_55_2()

				return
			end)
		elseif string.find(iter_55_6, "painting/") then
			PoolMgr.GetInstance():GetPainting(var_0_5.GetPaintingName(var_55_3), true, function(arg_59_0)
				if arg_59_0 == nil then
					originalPrint("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
				else
					if not self._poolRoot then
						var_0_5.ClearPaintingRes(iter_55_6, arg_59_0)

						return
					end

					ShipExpressionHelper.SetExpression(arg_59_0, var_55_3)
					arg_59_0:SetActive(false)

					if self._resCacheList then
						self._resCacheList[iter_55_6] = arg_59_0
					end
				end

				var_55_2()

				return
			end)
		elseif string.find(iter_55_6, "Char/") then
			self:LoadSpineAsset(var_55_3, function(arg_60_0)
				if arg_60_0 == nil then
					originalPrint("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
				else
					arg_60_0 = SpineAnim.AnimChar(var_55_3, arg_60_0)

					if not self._poolRoot then
						var_0_5.ClearCharRes(iter_55_6, arg_60_0)

						return
					end

					arg_60_0:SetActive(false)

					if self._resCacheList then
						self._resCacheList[iter_55_6] = arg_60_0
					end
				end

				self:InitPool(iter_55_6, arg_60_0)
				var_55_2()

				return
			end)
		elseif string.find(iter_55_6, "UI/") then
			LoadAndInstantiateAsync("UI", var_55_3, function(arg_61_0)
				if arg_61_0 == nil then
					originalPrint("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
				else
					if not self._poolRoot then
						PoolUtil.Destroy(arg_61_0)

						return
					end

					arg_61_0:SetActive(false)

					if self._resCacheList then
						self._resCacheList[iter_55_6] = arg_61_0
					end
				end

				self:InitPool(iter_55_6, arg_61_0)
				var_55_2()

				return
			end, true, true)
		else
			ResourceMgr.Inst:getAssetAsync(iter_55_6, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_62_0)
				if arg_62_0 == nil then
					originalPrint("资源预加载失败，检查以下目录：>>" .. iter_55_6 .. "<<")
				else
					if not self._poolRoot then
						PoolUtil.Destroy(arg_62_0)

						return
					end

					if self._resCacheList then
						self._resCacheList[iter_55_6] = arg_62_0
					end
				end

				self:InitPool(iter_55_6, arg_62_0)
				var_55_2()

				return
			end), true, true)
		end
	end

	return var_55_1
end

function var_0_5.GetPaintingName(arg_63_0)
	return arg_63_0 .. ((PlayerPrefs.GetInt(BATTLE_HIDE_BG, 1) > 0 and checkABExist("painting/" .. arg_63_0 .. "_n") or PlayerPrefs.GetInt("paint_hide_other_obj_" .. arg_63_0, 0) ~= 0 and checkABExist("painting/" .. arg_63_0 .. "_n")) and "_n" or "")
end

local var_0_6 = Vector3(0, 10000, 0)

function var_0_5:HideBullet()
	self.transform.position = var_0_6

	return
end

function var_0_5.InitParticleSystemCB(arg_65_0)
	pg.EffectMgr.GetInstance():CommonEffectEvent(arg_65_0)

	return
end

function var_0_5:InitPool(arg_66_1, arg_66_2)
	local var_66_0 = self._poolRoot.transform

	if string.find(arg_66_1, "Item/") then
		if arg_66_2:GetComponentInChildren(typeof(UnityEngine.TrailRenderer)) ~= nil or arg_66_2:GetComponentInChildren(typeof(ParticleSystem)) ~= nil then
			self._allPool[arg_66_1] = pg.Pool.New(self._bulletContainer.transform, arg_66_2, 15, 20, true, false):InitSize()
		else
			local var_66_1 = pg.Pool.New(self._bulletContainer.transform, arg_66_2, 20, 20, true, true)

			var_66_1:SetRecycleFuncs(var_0_5.HideBullet)
			var_66_1:InitSize()

			self._allPool[arg_66_1] = var_66_1
		end
	elseif string.find(arg_66_1, "Effect/") then
		if arg_66_2:GetComponent(typeof(UnityEngine.ParticleSystem)) then
			local var_66_2 = 5

			if string.find(arg_66_1, "smoke") and not string.find(arg_66_1, "smokeboom") then
				var_66_2 = 30
			elseif string.find(arg_66_1, "feijiyingzi") then
				var_66_2 = 1
			end

			local var_66_3 = pg.Pool.New(var_66_0, arg_66_2, var_66_2, 20, false, false)

			var_66_3:SetInitFuncs(var_0_5.InitParticleSystemCB)
			var_66_3:InitSize()

			self._allPool[arg_66_1] = var_66_3
		else
			local var_66_4 = 8

			var_66_4 = (string.find(arg_66_1, "AntiAirArea") or string.find(arg_66_1, "AntiSubArea")) and 1

			GetOrAddComponent(arg_66_2, typeof(ParticleSystemEvent))

			local var_66_5 = pg.Pool.New(var_66_0, arg_66_2, var_66_4, 20, false, false)

			var_66_5:InitSize()

			self._allPool[arg_66_1] = var_66_5
		end
	elseif string.find(arg_66_1, "Char/") then
		local var_66_7 = pg.Pool.New(var_66_0, arg_66_2, (string.find(arg_66_1, "danchuan") or nil) and 3, 20, false, false):InitSize()

		var_66_7:SetRecycleFuncs(var_0_5.ResetSpineAction)

		self._allPool[arg_66_1] = var_66_7
	elseif string.find(arg_66_1, "chargo/") then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 3, 20, false, false):InitSize()
	elseif string.find(arg_66_1, "orbit/") then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 2, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/SkillPainting" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 1, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/SkillPaintingDAL" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 1, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/MonsterAppearUI" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 1, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/CardTowerCardCombat" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 7, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/combatgridmanskillfloat" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 1, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/combatreisalinapui" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 1, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/combatyumiamanaui" then
		self._allPool[arg_66_1] = pg.Pool.New(var_66_0, arg_66_2, 1, 20, false, false):InitSize()
	elseif arg_66_1 == "UI/CombatHPBar" .. var_0_0.Battle.BattleState.GetCombatSkinKey() then
		var_0_0.Battle.BattleHPBarManager.GetInstance():Init(arg_66_2, var_66_0)
	elseif string.find(arg_66_1, "UI/CombatHPPop") then
		var_0_0.Battle.BattlePopNumManager.GetInstance():Init(arg_66_2, var_66_0)
	end

	return
end

function var_0_5:GetRotateScript(arg_67_1, arg_67_2)
	if self.rotateScriptMap[arg_67_1] then
		return self.rotateScriptMap[arg_67_1]
	end

	local var_67_0 = GetOrAddComponent(arg_67_1, "BulletRotation")

	self.rotateScriptMap[arg_67_1] = var_67_0

	return var_67_0
end

function var_0_5.GetCommonResource()
	return {
		var_0_5.GetMapPath("visionLine"),
		var_0_5.GetMapPath("exposeLine"),
		var_0_5.GetFXPath(var_0_0.Battle.BattleCharacterFactory.MOVE_WAVE_FX_NAME),
		var_0_5.GetFXPath(var_0_0.Battle.BattleCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath(var_0_0.Battle.BattleBossCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath(var_0_0.Battle.BattleAircraftCharacterFactory.BOMB_FX_NAME),
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
		var_0_5.GetUIPath("CombatHPBar" .. var_0_0.Battle.BattleState.GetCombatSkinKey()),
		var_0_5.GetUIPath("CombatHPPop" .. var_0_0.Battle.BattleState.GetCombatSkinKey())
	}
end

function var_0_5.GetDisplayCommonResource()
	return {
		var_0_5.GetFXPath(var_0_0.Battle.BattleCharacterFactory.MOVE_WAVE_FX_NAME),
		var_0_5.GetFXPath(var_0_0.Battle.BattleCharacterFactory.BOMB_FX_NAME),
		var_0_5.GetFXPath(var_0_0.Battle.BattleCharacterFactory.DANCHUAN_MOVE_WAVE_FX_NAME)
	}
end

function var_0_5.GetMapResource(arg_70_0)
	local var_70_0 = {}

	for iter_70_0, iter_70_1 in ipairs(var_0_0.Battle.BattleMap.LAYERS) do
		for iter_70_2, iter_70_3 in ipairs((var_0_0.Battle.BattleMap.GetMapResNames(arg_70_0, iter_70_1))) do
			var_70_0[#var_70_0 + 1] = var_0_5.GetMapPath(iter_70_3)
		end
	end

	return var_70_0
end

function var_0_5.GetBuffResource()
	local var_71_0 = {}

	for iter_71_0, iter_71_1 in ipairs((require("buffFXPreloadList"))) do
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

	if table.contains(var_0_3.MIRROR_QICON_SHIP_GROUP, var_72_2.ship_group) then
		var_72_0[#var_72_0 + 1] = var_0_5.GetQIcon(var_72_2.painting .. var_0_3.MIRROR_QICON_KEY)
	end

	var_72_0[#var_72_0 + 1] = var_0_5.GetSquareIcon(var_72_2.painting)

	if arg_72_2 and var_0_1.GetShipTypeTmp(var_72_1.type).team_type == TeamType.Main then
		var_72_0[#var_72_0 + 1] = var_0_5.GetPaintingPath(var_72_2.painting)
	end

	return var_72_0
end

function var_0_5.GetPlayerShipResource(arg_73_0, arg_73_1)
	local var_73_0 = {}
	local var_73_1 = {}

	for iter_73_0, iter_73_1 in ipairs(arg_73_0) do
		table.insert(var_73_1, iter_73_1.skinId)

		for iter_73_2, iter_73_3 in pairs((var_0_5.GetShipResource(iter_73_1.configId, iter_73_1.skinId, true))) do
			table.insert(var_73_0, iter_73_3)
		end

		local var_73_3 = var_0_1.GetPlayerShipTmpDataFromID(iter_73_1.configId)

		for iter_73_4, iter_73_5 in ipairs(iter_73_1:getActiveEquipments()) do
			local var_73_4
			local var_73_6 = 0

			if not iter_73_5 then
				var_73_4 = var_73_3.default_equip_list[iter_73_4]
			else
				var_73_4 = iter_73_5.configId
				var_73_6 = iter_73_5.skinId
			end

			if var_73_4 then
				local var_73_7 = var_0_1.GetWeaponDataFromID(var_73_4).weapon_id

				if #var_73_7 > 0 then
					for iter_73_6, iter_73_7 in ipairs(var_73_7) do
						for iter_73_8, iter_73_9 in pairs((var_0_5.GetWeaponResource(iter_73_7, var_73_6))) do
							table.insert(var_73_0, iter_73_9)
						end
					end
				else
					for iter_73_10, iter_73_11 in pairs((var_0_5.GetEquipResource(var_73_4, var_73_6, arg_73_1))) do
						table.insert(var_73_0, iter_73_11)
					end
				end
			end
		end

		local var_73_8 = {}

		for iter_73_12, iter_73_13 in ipairs(var_73_3.depth_charge_list) do
			for iter_73_14, iter_73_15 in ipairs(var_0_1.GetWeaponDataFromID(iter_73_13).weapon_id) do
				table.insert(var_73_8, iter_73_15)
			end
		end

		for iter_73_16, iter_73_17 in ipairs(var_73_3.fix_equip_list) do
			for iter_73_18, iter_73_19 in ipairs(var_0_1.GetWeaponDataFromID(iter_73_17).weapon_id) do
				table.insert(var_73_8, iter_73_19)
			end
		end

		for iter_73_20, iter_73_21 in ipairs(var_73_8) do
			for iter_73_22, iter_73_23 in pairs((var_0_5.GetWeaponResource(iter_73_21))) do
				table.insert(var_73_0, iter_73_23)
			end
		end

		local var_73_9 = iter_73_1.GetSpWeapon and iter_73_1:GetSpWeapon()

		if var_73_9 then
			for iter_73_24, iter_73_25 in pairs((var_0_5.GetSpWeaponResource(var_73_9:GetConfigID(), arg_73_1))) do
				table.insert(var_73_0, iter_73_25)
			end
		end

		for iter_73_26, iter_73_27 in pairs((var_0_1.GetBuffBulletRes(iter_73_1.configId, iter_73_1.skills, arg_73_1, iter_73_1.skinId, var_73_9))) do
			table.insert(var_73_0, iter_73_27)
		end

		if iter_73_1.buffs then
			for iter_73_28, iter_73_29 in pairs((var_0_1.GetBuffListRes(iter_73_1.buffs, arg_73_1, iter_73_1.skinId))) do
				table.insert(var_73_0, iter_73_29)
			end
		end
	end

	return var_73_0, var_73_1
end

function var_0_5:GetEnemyResource()
	local var_74_0 = {}
	local var_74_1 = self.bossData ~= nil
	local var_74_2 = self.buffList or {}
	local var_74_3 = self.phase or {}
	local var_74_4 = var_0_1.GetMonsterTmpDataFromID(self.monsterTemplateID)

	var_74_0[#var_74_0 + 1] = var_0_5.GetCharacterPath(var_74_4.prefab)
	var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(var_74_4.wave_fx)

	if var_74_4.fog_fx then
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(var_74_4.fog_fx)
	end

	for iter_74_0, iter_74_1 in ipairs(var_74_4.appear_fx) do
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(iter_74_1)
	end

	for iter_74_2, iter_74_3 in ipairs(var_74_4.smoke) do
		for iter_74_4, iter_74_5 in ipairs(iter_74_3[2]) do
			var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(iter_74_5[1])
		end
	end

	if self.deadFX then
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(self.deadFX)
	end

	if type(var_74_4.bubble_fx) == "table" then
		var_74_0[#var_74_0 + 1] = var_0_5.GetFXPath(var_74_4.bubble_fx[1])
	end

	local function var_74_5(arg_75_0)
		for iter_75_0, iter_75_1 in pairs(var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_75_0, 1).effect_list) do
			if iter_75_1.arg_list.skill_id then
				local var_75_0 = var_0_0.Battle.BattleDataFunction.GetSkillTemplate(iter_75_1.arg_list.skill_id).painting

				if var_75_0 == 1 then
					var_74_0[#var_74_0 + 1] = var_0_5.GetHrzIcon(var_74_4.icon)
					var_74_0[#var_74_0 + 1] = var_0_5.GetSquareIcon(var_74_4.icon)
				elseif type(var_75_0) == "string" then
					var_74_0[#var_74_0 + 1] = var_0_5.GetHrzIcon(var_75_0)
					var_74_0[#var_74_0 + 1] = var_0_5.GetSquareIcon(var_75_0)
				end
			end

			if iter_75_1.arg_list.buff_id then
				var_74_5(iter_75_1.arg_list.buff_id)
			end
		end

		return
	end

	for iter_74_6, iter_74_7 in ipairs(var_74_2) do
		var_74_5(iter_74_7)
	end

	for iter_74_8, iter_74_9 in ipairs(var_74_3) do
		if iter_74_9.addBuff then
			for iter_74_10, iter_74_11 in ipairs(iter_74_9.addBuff) do
				var_74_5(iter_74_11)
			end
		end
	end

	if var_74_1 then
		var_74_0[#var_74_0 + 1] = var_0_5.GetSquareIcon(var_74_4.icon)
	end

	return var_74_0
end

function var_0_5.GetWeaponResource(arg_76_0, arg_76_1)
	local var_76_0 = {}

	if arg_76_0 == -1 then
		return var_76_0
	end

	local var_76_1 = var_0_1.GetWeaponPropertyDataFromID(arg_76_0)

	if var_76_1.type == var_0_2.EquipmentType.MAIN_CANNON or var_76_1.type == var_0_2.EquipmentType.SUB_CANNON or var_76_1.type == var_0_2.EquipmentType.TORPEDO or var_76_1.type == var_0_2.EquipmentType.ANTI_AIR or var_76_1.type == var_0_2.EquipmentType.ANTI_SEA or var_76_1.type == var_0_2.EquipmentType.POINT_HIT_AND_LOCK or var_76_1.type == var_0_2.EquipmentType.MANUAL_METEOR or var_76_1.type == var_0_2.EquipmentType.BOMBER_PRE_CAST_ALERT or var_76_1.type == var_0_2.EquipmentType.DEPTH_CHARGE or var_76_1.type == var_0_2.EquipmentType.MANUAL_TORPEDO or var_76_1.type == var_0_2.EquipmentType.DISPOSABLE_TORPEDO or var_76_1.type == var_0_2.EquipmentType.MANUAL_AAMISSILE or var_76_1.type == var_0_2.EquipmentType.BEAM or var_76_1.type == var_0_2.EquipmentType.SPACE_LASER or var_76_1.type == var_0_2.EquipmentType.FLEET_RANGE_ANTI_AIR or var_76_1.type == var_0_2.EquipmentType.MANUAL_MISSILE or var_76_1.type == var_0_2.EquipmentType.AUTO_MISSILE or var_76_1.type == var_0_2.EquipmentType.MISSILE then
		for iter_76_0, iter_76_1 in ipairs(var_76_1.bullet_ID) do
			for iter_76_2, iter_76_3 in ipairs((var_0_5.GetBulletResource(iter_76_1, arg_76_1))) do
				var_76_0[#var_76_0 + 1] = iter_76_3
			end
		end
	elseif var_76_1.type == var_0_2.EquipmentType.INTERCEPT_AIRCRAFT or var_76_1.type == var_0_2.EquipmentType.STRIKE_AIRCRAFT then
		var_76_0 = var_0_5.GetAircraftResource(arg_76_0, nil, arg_76_1)
	elseif var_76_1.type == var_0_2.EquipmentType.PREVIEW_ARICRAFT then
		for iter_76_4, iter_76_5 in ipairs(var_76_1.bullet_ID) do
			var_76_0 = var_0_5.GetAircraftResource(iter_76_5, nil, arg_76_1)
		end
	end

	if var_76_1.type == var_0_2.EquipmentType.FLEET_RANGE_ANTI_AIR then
		for iter_76_6, iter_76_7 in ipairs((var_0_5.GetBulletResource(var_0_3.AntiAirConfig.RangeBulletID))) do
			var_76_0[#var_76_0 + 1] = iter_76_7
		end
	end

	local var_76_2

	if arg_76_1 and arg_76_1 ~= 0 then
		var_76_2 = var_0_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(arg_76_1)
	end

	var_76_0[#var_76_0 + 1] = var_76_2 and var_76_2.fire_fx_name ~= "" and var_0_5.GetFXPath(var_76_2.fire_fx_name) or var_0_5.GetFXPath(var_76_1.fire_fx)

	if var_76_1.precast_param.fx then
		var_76_0[#var_76_0 + 1] = var_0_5.GetFXPath(var_76_1.precast_param.fx)
	end

	if var_76_2 then
		if var_76_2.orbit_combat ~= "" then
			var_76_0[#var_76_0 + 1] = var_0_5.GetOrbitPath(var_76_2.orbit_combat)
		end
	end

	return var_76_0
end

function var_0_5.GetEquipResource(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = {}

	if arg_77_1 ~= 0 then
		local var_77_1 = var_0_0.Battle.BattleDataFunction.GetEquipSkinDataFromID(arg_77_1)

		if var_77_1.ship_skin_id ~= 0 then
			var_77_0[#var_77_0 + 1] = var_0_5.GetCharacterPath(var_0_0.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(var_77_1.ship_skin_id).prefab)
		end

		if var_77_1.orbit_combat ~= "" then
			var_77_0[#var_77_0 + 1] = var_0_5.GetOrbitPath(var_77_1.orbit_combat)
		end
	end

	local var_77_2 = var_0_0.Battle.BattleDataFunction.GetWeaponDataFromID(arg_77_0)

	for iter_77_0, iter_77_1 in ipairs(var_77_2.weapon_id) do
		for iter_77_2, iter_77_3 in ipairs((var_0_5.GetWeaponResource(iter_77_1))) do
			var_77_0[#var_77_0 + 1] = iter_77_3
		end
	end

	for iter_77_4, iter_77_5 in ipairs(var_77_2.skill_id) do
		for iter_77_6, iter_77_7 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(arg_77_2 and var_0_0.Battle.BattleDataFunction.SkillTranform(arg_77_2, iter_77_5[1]) or iter_77_5[1], (not iter_77_5[2] or nil) and 1, {}))) do
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
			var_78_0[#var_78_0 + 1] = var_0_5.GetBulletPath(var_78_3 .. var_0_0.Battle.BattleBulletUnit.MIRROR_RES)
		end
	else
		var_78_3 = var_78_2.modle_ID
	end

	var_78_0[#var_78_0 + 1] = (var_78_2.type == var_0_2.BulletType.BEAM or var_78_2.type == var_0_2.BulletType.SPACE_LASER or var_78_2.type == var_0_2.BulletType.MISSILE or var_78_2.type == var_0_2.BulletType.ELECTRIC_ARC) and var_0_5.GetFXPath(var_78_2.modle_ID) or var_0_5.GetBulletPath(var_78_3)

	if var_78_2.extra_param.mirror then
		var_78_0[#var_78_0 + 1] = var_0_5.GetBulletPath(var_78_3 .. var_0_0.Battle.BattleBulletUnit.MIRROR_RES)
	end

	var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_1 and var_78_1.hit_fx_name ~= "" and var_78_1.hit_fx_name or var_78_2.hit_fx)
	var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.miss_fx)
	var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.alert_fx)

	if var_78_2.extra_param.area_FX then
		var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(var_78_2.extra_param.area_FX)
	end

	if var_78_2.extra_param.shrapnel then
		for iter_78_0, iter_78_1 in ipairs(var_78_2.extra_param.shrapnel) do
			for iter_78_2, iter_78_3 in ipairs((var_0_5.GetBulletResource(iter_78_1.bullet_ID))) do
				var_78_0[#var_78_0 + 1] = iter_78_3
			end
		end
	end

	for iter_78_4, iter_78_5 in ipairs(var_78_2.attach_buff) do
		if iter_78_5.effect_id then
			var_78_0[#var_78_0 + 1] = var_0_5.GetFXPath(iter_78_5.effect_id)
		end

		if iter_78_5.buff_id then
			for iter_78_6, iter_78_7 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(iter_78_5.buff_id, 1, {}))) do
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

	if arg_79_2 ~= 0 then
		local var_79_5, var_79_6, var_79_7

		var_79_2, var_79_5, var_79_6, var_79_7 = var_0_1.GetEquipSkin(arg_79_2)

		if var_79_5 ~= "" then
			var_79_0[#var_79_0 + 1] = var_0_5.GetBulletPath(nil)
		end

		if var_79_6 ~= "" then
			var_79_0[#var_79_0 + 1] = var_0_5.GetBulletPath(var_79_6)
		end

		if var_79_7 ~= "" then
			var_79_0[#var_79_0 + 1] = var_0_5.GetBulletPath(var_79_7)
		end
	else
		var_79_2 = var_79_1.model_ID
	end

	var_79_0[#var_79_0 + 1] = var_0_5.GetCharacterGoPath(var_79_2)

	if arg_79_3 then
		var_79_0[#var_79_0 + 1] = var_0_5.GetAircraftIconPath(var_79_1.model_ID)
	end

	local var_79_8 = arg_79_1 or var_79_1.weapon_ID

	if type(arg_79_1 or var_79_1.weapon_ID) == "table" then
		for iter_79_0, iter_79_1 in ipairs(var_79_8) do
			for iter_79_2, iter_79_3 in ipairs((var_0_5.GetWeaponResource(iter_79_1))) do
				var_79_0[#var_79_0 + 1] = iter_79_3
			end
		end
	else
		for iter_79_4, iter_79_5 in ipairs((var_0_5.GetWeaponResource(var_79_8))) do
			var_79_0[#var_79_0 + 1] = iter_79_5
		end
	end

	return var_79_0
end

function var_0_5.GetCommanderBuffRes(arg_80_0)
	local var_80_0 = {}

	for iter_80_0, iter_80_1 in ipairs(arg_80_0) do
		for iter_80_2, iter_80_3 in ipairs((var_0_5.GetCommanderResource(iter_80_1))) do
			table.insert(var_80_0, iter_80_3)
		end
	end

	return var_80_0
end

function var_0_5:GetCommanderResource()
	local var_81_0 = {}

	var_81_0[#var_81_0 + 1] = var_0_5.GetCommanderHrzIconPath(self[1]:getPainting())
	var_81_0[#var_81_0 + 1] = var_0_5.GetCommanderIconPath(self[1]:getPainting())

	local var_81_1 = self[1]:getSkills()[1]:getLevel()

	for iter_81_0, iter_81_1 in ipairs(self[2]) do
		for iter_81_2, iter_81_3 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(iter_81_1, var_81_1, {}))) do
			var_81_0[#var_81_0 + 1] = iter_81_3
		end
	end

	return var_81_0
end

function var_0_5.GetResFromBuffIDList(arg_82_0)
	local var_82_0 = {}

	for iter_82_0, iter_82_1 in ipairs(arg_82_0) do
		for iter_82_2, iter_82_3 in ipairs((var_0_1.GetResFromBuff(iter_82_1, 1, {}))) do
			table.insert(var_82_0, iter_82_3)
		end
	end

	return var_82_0
end

function var_0_5.GetResFromBuffList(arg_83_0)
	local var_83_0 = {}

	for iter_83_0, iter_83_1 in ipairs(arg_83_0) do
		for iter_83_2, iter_83_3 in ipairs((var_0_1.GetResFromBuff(iter_83_1.id, iter_83_1.level, {}))) do
			table.insert(var_83_0, iter_83_3)
		end
	end

	return var_83_0
end

function var_0_5.GetStageResource(arg_84_0)
	local var_84_0 = {}
	local var_84_1 = {}

	for iter_84_0, iter_84_1 in ipairs(var_0_0.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_84_0).stages) do
		if iter_84_1.stageBuff then
			for iter_84_2, iter_84_3 in ipairs(iter_84_1.stageBuff) do
				for iter_84_4, iter_84_5 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(iter_84_3.id, iter_84_3.level, {}))) do
					var_84_0[#var_84_0 + 1] = iter_84_5
				end
			end
		end

		for iter_84_6, iter_84_7 in ipairs(iter_84_1.waves) do
			if iter_84_7.triggerType == var_0_0.Battle.BattleConst.WaveTriggerType.NORMAL then
				for iter_84_8, iter_84_9 in ipairs(iter_84_7.spawn) do
					for iter_84_10, iter_84_11 in ipairs((var_0_5.GetMonsterRes(iter_84_9))) do
						table.insert(var_84_0, iter_84_11)
					end
				end

				if iter_84_7.reinforcement then
					for iter_84_12, iter_84_13 in ipairs(iter_84_7.reinforcement) do
						for iter_84_14, iter_84_15 in ipairs((var_0_5.GetMonsterRes(iter_84_13))) do
							table.insert(var_84_0, iter_84_15)
						end
					end
				end
			elseif iter_84_7.triggerType == var_0_0.Battle.BattleConst.WaveTriggerType.AID then
				local function var_84_2(arg_85_0)
					for iter_85_0, iter_85_1 in ipairs((var_0_5.GetAidUnitsRes(arg_85_0))) do
						table.insert(var_84_0, iter_85_1)
					end

					for iter_85_2, iter_85_3 in ipairs(arg_85_0) do
						var_84_1[#var_84_1 + 1] = iter_85_3.skinId
					end

					return
				end

				if iter_84_7.triggerParams.vanguard_unitList then
					var_84_2(iter_84_7.triggerParams.vanguard_unitList)
				end

				if iter_84_7.triggerParams.main_unitList then
					var_84_2(iter_84_7.triggerParams.main_unitList)
				end

				if iter_84_7.triggerParams.sub_unitList then
					var_84_2(iter_84_7.triggerParams.sub_unitList)
				end
			elseif iter_84_7.triggerType == var_0_0.Battle.BattleConst.WaveTriggerType.ENVIRONMENT then
				for iter_84_16, iter_84_17 in ipairs(iter_84_7.spawn) do
					var_0_5.GetEnvironmentRes(var_84_0, iter_84_17)
				end
			elseif iter_84_7.triggerType == var_0_0.Battle.BattleConst.WaveTriggerType.CARD_PUZZLE then
				for iter_84_18, iter_84_19 in ipairs((var_0_0.Battle.BattleDataFunction.GetCardRes(iter_84_7.triggerParams.card_id))) do
					table.insert(var_84_0, iter_84_19)
				end
			end

			if iter_84_7.airFighter ~= nil then
				for iter_84_20, iter_84_21 in pairs(iter_84_7.airFighter) do
					for iter_84_22, iter_84_23 in ipairs((var_0_5.GetAircraftResource(iter_84_21.templateID, iter_84_21.weaponID, nil, true))) do
						var_84_0[#var_84_0 + 1] = iter_84_23
					end
				end
			end
		end
	end

	return var_84_0, var_84_1
end

function var_0_5.GetStageBGM(arg_86_0)
	local var_86_0 = {}

	for iter_86_0, iter_86_1 in ipairs(var_0_0.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_86_0).stages) do
		for iter_86_2, iter_86_3 in ipairs(iter_86_1.waves) do
			if iter_86_3.triggerType == var_0_0.Battle.BattleConst.WaveTriggerType.BGM then
				if iter_86_3.triggerParams.bgm then
					table.insert(var_86_0, "cue/bgm-" .. iter_86_3.triggerParams.bgm .. ".b")
				end
			end
		end
	end

	return var_86_0
end

function var_0_5.GetEnvironmentRes(arg_87_0, arg_87_1)
	table.insert(arg_87_0, arg_87_1.prefab and var_0_5.GetFXPath(arg_87_1.prefab))

	for iter_87_0, iter_87_1 in ipairs(var_0_0.Battle.BattleDataFunction.GetEnvironmentBehaviour(arg_87_1.behaviours).behaviour_list) do
		if iter_87_1.type == var_0_0.Battle.BattleConst.EnviroumentBehaviour.BUFF then
			for iter_87_2, iter_87_3 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(iter_87_1.buff_id, 1, {}))) do
				arg_87_0[#arg_87_0 + 1] = iter_87_3
			end
		elseif iter_87_1.type == var_0_0.Battle.BattleConst.EnviroumentBehaviour.SPAWN then
			local var_87_1 = iter_87_1.content and iter_87_1.content.alert and iter_87_1.content.alert.alert_fx

			table.insert(arg_87_0, var_87_1 and var_0_5.GetFXPath(var_87_1))

			local var_87_2 = iter_87_1.content and iter_87_1.content.child_prefab

			if var_87_2 then
				var_0_5.GetEnvironmentRes(arg_87_0, var_87_2)
			end
		elseif iter_87_1.type == var_0_0.Battle.BattleConst.EnviroumentBehaviour.PLAY_FX then
			arg_87_0[#arg_87_0 + 1] = var_0_5.GetFXPath(iter_87_1.FX_ID)
		end
	end

	return
end

function var_0_5:GetMonsterRes()
	local var_88_0 = {}

	for iter_88_0, iter_88_1 in ipairs((var_0_5.GetEnemyResource(self))) do
		var_88_0[#var_88_0 + 1] = iter_88_1
	end

	local var_88_1 = var_0_0.Battle.BattleDataFunction.GetMonsterTmpDataFromID(self.monsterTemplateID)
	local var_88_2 = Clone(var_88_1.equipment_list)
	local var_88_3 = Clone(self.buffList) or {}

	if self.phase then
		for iter_88_2, iter_88_3 in ipairs(self.phase) do
			if iter_88_3.addWeapon then
				for iter_88_4, iter_88_5 in ipairs(iter_88_3.addWeapon) do
					var_88_2[#var_88_2 + 1] = iter_88_5
				end
			end

			if iter_88_3.addRandomWeapon then
				for iter_88_6, iter_88_7 in ipairs(iter_88_3.addRandomWeapon) do
					for iter_88_8, iter_88_9 in ipairs(iter_88_7) do
						var_88_2[#var_88_2 + 1] = iter_88_9
					end
				end
			end

			if iter_88_3.addBuff then
				for iter_88_10, iter_88_11 in ipairs(iter_88_3.addBuff) do
					var_88_3[#var_88_3 + 1] = iter_88_11
				end
			end
		end
	end

	for iter_88_12, iter_88_13 in ipairs(var_88_1.buff_list) do
		for iter_88_14, iter_88_15 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(iter_88_13.ID, iter_88_13.LV, {}))) do
			var_88_0[#var_88_0 + 1] = iter_88_15
		end
	end

	for iter_88_16, iter_88_17 in ipairs(var_88_3) do
		for iter_88_18, iter_88_19 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(iter_88_17, 1, {}))) do
			var_88_0[#var_88_0 + 1] = iter_88_19
		end

		for iter_88_20, iter_88_21 in pairs(var_0_0.Battle.BattleDataFunction.GetBuffTemplate(iter_88_17, 1).effect_list) do
			if iter_88_21.arg_list.skill_id and var_0_0.Battle.BattleDataFunction.NeedSkillPainting(iter_88_21.arg_list.skill_id) then
				var_88_0[#var_88_0 + 1] = var_0_5.GetPaintingPath(var_0_1.GetMonsterTmpDataFromID(self.monsterTemplateID).icon)

				break
			end
		end
	end

	for iter_88_22, iter_88_23 in ipairs(var_88_2) do
		for iter_88_24, iter_88_25 in ipairs((var_0_5.GetWeaponResource(iter_88_23))) do
			var_88_0[#var_88_0 + 1] = iter_88_25
		end
	end

	return var_88_0
end

function var_0_5.GetEquipSkinPreviewRes(arg_89_0)
	local var_89_0 = {}
	local var_89_1 = var_0_1.GetEquipSkinDataFromID(arg_89_0)

	for iter_89_0, iter_89_1 in ipairs(var_89_1.weapon_ids) do
		for iter_89_2, iter_89_3 in ipairs((var_0_5.GetWeaponResource(iter_89_1))) do
			var_89_0[#var_89_0 + 1] = iter_89_3
		end
	end

	local function var_89_2(arg_90_0)
		if arg_90_0 ~= "" then
			var_89_0[#var_89_0 + 1] = var_0_5.GetBulletPath(arg_90_0)
		end

		return
	end

	local var_89_3, var_89_4, var_89_5, var_89_6, var_89_7, var_89_8 = var_0_1.GetEquipSkin(arg_89_0)

	var_89_0[#var_89_0 + 1] = _.any(EquipType.AirProtoEquipTypes, function(arg_91_0)
		return table.contains(var_89_1.equip_type, arg_91_0)
	end) and var_0_5.GetCharacterGoPath(var_89_3) or var_0_5.GetBulletPath(var_89_3)

	var_89_2(var_89_4)
	var_89_2(var_89_5)
	var_89_2(var_89_6)

	if var_89_7 and var_89_7 ~= "" then
		var_89_0[#var_89_0 + 1] = var_0_5.GetFXPath(var_89_7)
	end

	if var_89_8 and var_89_8 ~= "" then
		var_89_0[#var_89_0 + 1] = var_0_5.GetFXPath(var_89_8)
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

	local var_92_6 = false

	for iter_92_0, iter_92_1 in ipairs(var_0_1.GetEquipSkinDataFromID(arg_92_0).equip_type) do
		if table.contains(EquipType.AircraftSkinType, iter_92_1) then
			var_92_6 = true
		end
	end

	if var_92_6 then
		if var_92_1 ~= "" then
			var_92_0[#var_92_0 + 1] = var_0_5.GetCharacterGoPath(var_92_1)
		end
	else
		var_92_5(var_92_1)

		if var_0_1.GetEquipSkinDataFromID(arg_92_0).mirror == 1 then
			var_92_0[#var_92_0 + 1] = var_0_5.GetBulletPath(var_92_1 .. var_0_0.Battle.BattleBulletUnit.MIRROR_RES)
		end
	end

	var_92_5(var_92_2)
	var_92_5(var_92_3)
	var_92_5(var_92_4)

	return var_92_0
end

function var_0_5.GetAidUnitsRes(arg_94_0)
	local var_94_0 = {}

	for iter_94_0, iter_94_1 in ipairs(arg_94_0) do
		local var_94_1 = var_0_5.GetShipResource(iter_94_1.tmpID, nil, true)

		for iter_94_2, iter_94_3 in ipairs(iter_94_1.equipment) do
			if iter_94_3 ~= 0 then
				if iter_94_2 <= Ship.WEAPON_COUNT then
					for iter_94_4, iter_94_5 in ipairs(var_0_1.GetWeaponDataFromID(iter_94_3).weapon_id) do
						for iter_94_6, iter_94_7 in ipairs((var_0_5.GetWeaponResource(iter_94_5))) do
							table.insert(var_94_1, iter_94_7)
						end
					end
				else
					for iter_94_8, iter_94_9 in ipairs((var_0_5.GetEquipResource(iter_94_3))) do
						table.insert(var_94_1, iter_94_9)
					end
				end
			end
		end

		for iter_94_10, iter_94_11 in ipairs(var_94_1) do
			table.insert(var_94_0, iter_94_11)
		end
	end

	return var_94_0
end

function var_0_5.GetSpWeaponResource(arg_95_0, arg_95_1)
	local var_95_0 = {}
	local var_95_1 = var_0_0.Battle.BattleDataFunction.GetSpWeaponDataFromID(arg_95_0).effect_id

	if var_95_1 ~= 0 then
		if arg_95_1 and not var_0_0.Battle.BattleDataFunction.SkillTranform(arg_95_1, var_95_1) then
			-- block empty
		end

		for iter_95_0, iter_95_1 in ipairs((var_0_0.Battle.BattleDataFunction.GetResFromBuff(var_95_1, 1, {}))) do
			var_95_0[#var_95_0 + 1] = iter_95_1
		end
	end

	return var_95_0
end

return
