class = var_0_10000

local var_0_0 = var_0_10000("WeaponPreviewer")

Vector3 = var_0_10001

local var_0_1 = var_0_10001(0, 1, 40)

Vector3 = var_2

local var_0_2 = var_2(40, 1, 40)

Vector3 = var_3

local var_0_3 = var_3(30, 0, 0)

Vector3 = var_4

local var_0_4 = var_4(0.1, 0.1, 0.1)

Vector3 = var_5

local var_0_5 = var_5(330, 0, 0)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rawImage = arg_1_1
	setActive = var_1_10002

	var_1_10002(arg_1_0.rawImage, false)

	GameObject = var_1_10002
	arg_1_0.seaCameraGO = var_1_10002.Find("BarrageCamera")

	local var_1_0 = arg_1_0.seaCameraGO
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Camera = var_1_10007
	arg_1_0.seaCamera = var_1_1(var_1_0, var_5(var_1_10007))
	arg_1_0.seaCamera.targetTexture = arg_1_0.rawImage.texture
	arg_1_0.seaCamera.enabled = true
	arg_1_0.displayFireFX = true
	arg_1_0.displayHitFX = false

	return
end

function var_0_0.configUI(arg_2_0, arg_2_1)
	arg_2_0.healTF = arg_2_1
	setActive = var_1_10002

	var_1_10002(arg_2_0.healTF, false)

	local var_2_0 = arg_2_0.healTF
	local var_2_1 = var_2.GetComponent(var_2_0, "DftAniEvent")

	var_2.SetEndEvent(var_2_1, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.healTF, false)

		setText = var_2_10000

		local var_3_0 = arg_2_0.healTF

		var_2_10000(var_2.Find(var_3_0, "text"), "")

		return
	end)

	return
end

function var_0_0.setDisplayWeapon(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.weaponIds = arg_4_1
	arg_4_0.equipSkinId = arg_4_2 or 0

	arg_4_0:onWeaponUpdate()

	return
end

function var_0_0.SetFXMode(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.displayFireFX = arg_5_1
	arg_5_0.displayHitFX = arg_5_2

	return
end

function var_0_0.load(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	assert = var_1_10005

	var_1_10005(not arg_6_0.loading and not arg_6_0.loaded, "load function can be called only once.")

	arg_6_0.loading = true
	arg_6_0.shipVO = arg_6_2
	ys = var_5

	var_5.Battle.BattleVariable.Init(true)

	ys = var_5

	local var_6_0 = var_5.Battle.BattleFXPool.GetInstance()

	var_5.Init(var_6_0)

	ys = var_5

	local var_6_1 = var_5.Battle.BattleResourceManager.GetInstance()

	var_5.Init(var_6_1)
	var_5:AddPreloadResource(var_5.GetMapResource(arg_6_1))
	var_5:AddPreloadResource(var_5.GetDisplayCommonResource())

	local var_6_2 = arg_6_0.equipSkinId

	if 0 < var_6_2 then
		var_5:AddPreloadResource(var_5.GetEquipSkinPreviewRes(arg_6_0.equipSkinId))
	end

	var_5:AddPreloadResource(var_5.GetShipResource(arg_6_2.configId, arg_6_2.skinId), false)

	local var_6_3 = arg_6_2:getShipType()

	ShipType = var_7

	if var_6_3 ~= var_7.WeiXiu then
		ipairs = var_6_3

		for iter_6_0, iter_6_1 in var_6_3(arg_6_3) do
			local var_6_4

			if iter_6_1 ~= 0 then
				ys = var_6_4
				var_6_4 = var_6_4.Battle.BattleDataFunction.GetWeaponDataFromID(iter_6_1).weapon_id
				ipairs = var_12

				for iter_6_2, iter_6_3 in var_12(var_6_4) do
					var_5:AddPreloadResource(var_5.GetWeaponResource(iter_6_3))
				end
			end
		end
	end

	local function var_6_5()
		local var_7_0 = arg_6_0

		ys = var_2_10001
		var_7_0.seaView = var_2_10001.Battle.BattleMap.New(arg_6_1)

		local function var_7_1(arg_8_0)
			arg_6_0.loading = false

			local var_8_0 = arg_6_0

			var_8_0.loaded = true
			pg = var_8_0

			local var_8_1 = var_8_0.UIMgr.GetInstance()

			var_1.LoadingOff(var_8_1)

			arg_6_0.seaCharacter = arg_8_0

			local var_8_2 = arg_6_2
			local var_8_3 = var_1.getConfig(var_8_2, "scale") / 50
			local var_8_4 = arg_8_0.transform

			Vector3 = var_8_2
			var_8_4.localScale = var_8_2(var_8_3, var_8_3, var_8_3)
			var_8_4.localPosition = var_0_1
			var_8_4.localEulerAngles = var_0_3
			arg_6_0.seaAnimator = var_8_4:GetComponent("SpineAnim")
			arg_6_0.skeletonAnimation = var_8_4:GetComponent("SkeletonAnimation")

			local var_8_5 = arg_6_0

			ys = var_4
			var_8_5.characterAction = var_4.Battle.BattleConst.ActionName.MOVE

			local var_8_6 = arg_6_0

			var_3.setSeaAction(var_8_6, arg_6_0.characterAction, 0, true)

			arg_6_0.seaFXList = {}

			local var_8_7 = arg_6_0

			GameObject = var_4
			var_8_7._FXAttachPoint = var_4()

			local var_8_8 = arg_6_0._FXAttachPoint.transform

			var_3.SetParent(var_8_8, var_8_4, false)

			Vector3 = var_4
			var_3.localPosition = var_4.zero
			var_3.localEulerAngles = var_0_5
			pg = var_4

			local var_8_9 = var_4.ship_skin_template[arg_6_2.skinId].fx_container
			local var_8_10 = {}

			ipairs = var_7
			ys = var_3_10009

			for iter_8_0, iter_8_1 in var_7(var_3_10009.Battle.BattleConst.FXContainerIndex) do
				local var_8_11 = var_8_9[iter_8_0]

				Vector3 = var_3_10013
				var_8_10[iter_8_0] = var_3_10013(var_8_11[1], var_8_11[2], var_8_11[3])
			end

			arg_6_0._FXOffset = var_8_10

			local var_8_12

			if arg_6_0.equipSkinId > 0 then
				var_8_12 = arg_6_0

				var_7.attachOrbit(var_8_12)
			end

			ys = var_7

			local var_8_13 = var_7.Battle.BattleFXPool.GetInstance()
			local var_8_14 = var_7.GetCharacterFX(var_8_13, "movewave", arg_6_0)

			pg = var_8_12

			local var_8_15 = var_8_12.EffectMgr.GetInstance()
			local var_8_16 = var_9.PlayBattleEffect
			local var_8_17 = var_8_14

			Vector3 = var_3_10013

			var_8_16(var_8_15, var_8_17, var_3_10013.zero, true)

			arg_6_0.seaFXPool = var_7

			local var_8_18 = arg_6_2
			local var_8_19 = var_9.getShipType(var_8_18)

			ShipType = var_8_13

			if var_8_19 ~= var_8_13.WeiXiu then
				var_8_19 = arg_6_0
				var_8_19.boneList = {}
				var_8_19 = var_8_4.localToWorldMatrix
				pg = var_10

				local var_8_20 = var_10.ship_skin_template[arg_6_2.skinId]

				pairs = var_11

				for iter_8_2, iter_8_3 in var_11(var_8_20.bound_bone) do
					local var_8_21 = {}

					ipairs = var_3_10017

					for iter_8_4, iter_8_5 in var_3_10017(iter_8_3) do
						type = var_3_10022

						if var_3_10022(iter_8_5) == "table" then
							var_3_10022 = #var_8_21 + 1
							Vector3 = var_3_10023
							var_8_21[var_3_10022] = var_3_10023(iter_8_5[1], iter_8_5[2], iter_8_5[3])
						else
							var_3_10022 = #var_8_21 + 1
							Vector3 = var_3_10023
							var_8_21[var_3_10022] = var_3_10023.zero
						end
					end

					var_3_10017 = arg_6_0.boneList
					var_3_10017[iter_8_2] = var_8_19:MultiplyPoint3x4(var_8_21[1])
				end

				local var_8_22 = arg_6_0

				var_11.SeaUpdate(var_8_22)
			end

			setActive = var_8_19

			var_8_19(arg_6_0.rawImage, true)

			pg = var_8_19

			local var_8_23 = var_8_19.TimeMgr.GetInstance()

			var_9.ResumeBattleTimer(var_8_23)

			local var_8_24 = arg_6_0

			var_9.onWeaponUpdate(var_8_24)
			arg_6_4()

			return
		end

		local var_7_2 = var_0
		local var_7_3 = var_1.InstCharacter
		local var_7_4 = arg_6_2

		var_7_3(var_7_2, var_4.getPrefab(var_7_4), function(arg_9_0)
			var_7_1(arg_9_0)

			return
		end)

		return
	end

	var_5:StartPreload(var_6_5, nil)

	pg = var_7

	local var_6_6 = var_7.UIMgr.GetInstance()

	var_7.LoadingOn(var_6_6)

	return
end

function var_0_0.attachOrbit(arg_10_0)
	pg = var_1_10001

	if var_1_10001.equip_skin_template[arg_10_0.equipSkinId].orbit_combat ~= "" then
		arg_10_0.orbitList = {}
		ys = var_2

		local var_10_0 = var_2.Battle.BattleResourceManager.GetOrbitPath(var_1.orbit_combat)

		ResourceMgr = var_1_10003

		local var_10_1 = var_1_10003.Inst
		local var_10_2 = var_3.getAssetAsync
		local var_10_3 = var_10_0
		local var_10_4 = ""

		UnityEngine = var_1_10008

		var_10_2(var_10_1, var_10_3, var_10_4, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
			if arg_10_0.seaCharacter then
				Object = var_1

				local var_11_0 = var_1.Instantiate(arg_11_0)

				table = var_2_10002

				var_2_10002.insert(arg_10_0.orbitList, var_11_0)

				local var_11_1 = var_0.orbit_combat_bound[1]
				local var_11_2 = var_0.orbit_combat_bound[2]
				local var_11_3 = var_11_0.transform

				Vector3 = var_5
				var_11_3.localPosition = var_5(var_11_2[1], var_11_2[2], var_11_2[3])
				SpineAnim = var_11_3

				local var_11_4 = var_11_3.AddFollower(var_11_1, arg_10_0.seaCharacter.transform, var_11_0.transform)
				local var_11_5 = var_4.GetComponent(var_11_4, "Spine.Unity.BoneFollower")

				if var_0.orbit_rotate then
					var_11_5.followBoneRotation = true

					local var_11_6 = var_11_0.transform.localEulerAngles
					local var_11_7 = var_11_0.transform

					Vector3 = var_7
					var_11_7.localEulerAngles = var_7(var_11_6.x, var_11_6.y, var_11_6.z - 90)
				else
					var_11_5.followBoneRotation = false
				end
			end

			return
		end), true, true)
	end

	return
end

function var_0_0.setSeaAction(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.seaAnimator then
		SpineAnimUtil = var_4

		local var_12_0 = var_4.GetCharAnimDirect(arg_12_0.skeletonAnimation, 1, arg_12_1)
		local var_12_1 = arg_12_0.seaAnimator

		var_5.SetAction(var_12_1, var_12_0, 0, arg_12_3)
	end

	return
end

function var_0_0.playShipAnims(arg_13_0)
	if arg_13_0.loaded and arg_13_0.seaAnimator then
		local var_13_0 = {
			"attack",
			"victory",
			"dead"
		}

		local function var_13_1(arg_14_0)
			if arg_13_0.seaAnimator then
				local var_14_0 = arg_13_0.seaAnimator

				var_1.SetActionCallBack(var_14_0, nil)
			end

			local var_14_1 = arg_13_0

			var_1.setSeaAction(var_14_1, var_13_0[arg_14_0], 0, false)

			local var_14_2 = arg_13_0.seaAnimator

			var_1.SetActionCallBack(var_14_2, function(arg_15_0)
				if arg_15_0 == "finish" then
					local var_15_0 = arg_13_0.seaAnimator

					var_1.SetActionCallBack(var_15_0, nil)

					local var_15_1 = arg_13_0

					var_1.setSeaAction(var_15_1, "stand", 0, false)
				end

				return
			end)

			return
		end

		if arg_13_0.palyAnimTimer then
			local var_13_2 = arg_13_0.palyAnimTimer

			var_3.Stop(var_13_2)

			arg_13_0.palyAnimTimer = nil
		end

		Timer = var_3
		arg_13_0.palyAnimTimer = var_3.New(function()
			local var_16_0 = var_13_1

			math = var_2_10002

			var_16_0(var_2_10002.random(1, #var_13_0))

			return
		end, 5, -1)

		local var_13_3 = arg_13_0.palyAnimTimer

		var_3.Start(var_13_3)
		arg_13_0.palyAnimTimer.func()
	end

	return
end

function var_0_0.onWeaponUpdate(arg_17_0)
	if arg_17_0.loaded and arg_17_0.weaponIds then
		if arg_17_0.seaAnimator then
			var_1_10003 = arg_17_0.seaAnimator

			var_1.SetActionCallBack(var_1_10003, nil)
		end

		local function var_17_0()
			pairs = var_2_10000

			local var_18_0

			if not arg_17_0.weaponList then
				var_18_0 = {}
			end

			for iter_18_0, iter_18_1 in var_2_10000(var_18_0) do
				pairs = var_2_10005

				local var_18_1

				if not iter_18_1.emitterList then
					var_18_1 = {}
				end

				for iter_18_2, iter_18_3 in var_2_10005(var_18_1) do
					iter_18_3:Destroy()
				end
			end

			ipairs = var_0

			local var_18_2

			if not arg_17_0.bulletList then
				var_18_2 = {}
			end

			for iter_18_4, iter_18_5 in var_0(var_18_2) do
				Object = var_2_10005

				var_2_10005.Destroy(iter_18_5._go)
			end

			pairs = var_0

			local var_18_3

			if not arg_17_0.aircraftList then
				var_18_3 = {}
			end

			for iter_18_6, iter_18_7 in var_0(var_18_3) do
				Object = var_2_10005

				var_2_10005.Destroy(iter_18_7.obj)
			end

			arg_17_0.bulletList = {}
			arg_17_0.aircraftList = {}
			arg_17_0.UpdateHandlers = {}

			return
		end

		if #arg_17_0.weaponIds == 0 and arg_17_0.playRandomAnims then
			if arg_17_0._fireTimer then
				local var_17_1 = arg_17_0._fireTimer

				var_2.Stop(var_17_1)
			end

			if arg_17_0._delayTimer then
				local var_17_2 = arg_17_0._delayTimer

				var_2.Stop(var_17_2)
			end

			local var_17_3 = arg_17_0.shipVO
			local var_17_4 = var_2.getShipType(var_17_3)

			ShipType = var_1_10003

			if var_17_4 ~= var_1_10003.WeiXiu then
				var_17_0()
			elseif arg_17_0.buffTimer then
				pg = var_2

				local var_17_5 = var_2.TimeMgr.GetInstance()

				var_2.RemoveBattleTimer(var_17_5, arg_17_0.buffTimer)

				arg_17_0.buffTimer = nil
			end

			arg_17_0:playShipAnims()
		else
			local var_17_6 = arg_17_0.shipVO
			local var_17_7 = var_2.getShipType(var_17_6)

			ShipType = var_1_10003

			if var_17_7 ~= var_1_10003.WeiXiu then
				var_17_0()
				arg_17_0:MakeWeapon(arg_17_0.weaponIds)
				arg_17_0:SeaFire()
			elseif arg_17_0.weaponIds[1] then
				Equipment = var_3

				local var_17_8 = var_3.getConfigData(var_2).skill_id[1] and var_3[1]

				arg_17_0:MakeBuff(var_17_8)
			end
		end
	end

	return
end

function var_0_0.SeaFire(arg_19_0)
	local var_19_0 = 1

	if arg_19_0._fireTimer then
		var_1_10004 = arg_19_0._delayTimer

		var_2.Stop(var_1_10004)

		var_1_10004 = arg_19_0._fireTimer

		var_2.Stop(var_1_10004)

		var_1_10004 = arg_19_0._fireTimer

		var_2.Start(var_1_10004)
	else
		local function var_19_1()
			if arg_19_0.weaponList[var_19_0] then
				local function var_20_0()
					local var_21_0 = 1
					local var_21_1 = 0

					ipairs = var_3_10002

					for iter_21_0, iter_21_1 in var_3_10002(var_0.emitterList) do
						iter_21_1:Ready()
					end

					ipairs = var_2

					for iter_21_2, iter_21_3 in var_2(var_0.emitterList) do
						iter_21_3:Fire(nil, var_21_0, var_21_1)
					end

					local var_21_2 = var_0.tmpData.fire_fx

					if arg_19_0.equipSkinId > 0 then
						ys = var_3

						local var_21_3, var_21_4, var_21_5, var_21_6, var_21_7, var_21_8 = var_3.Battle.BattleDataFunction.GetEquipSkin(arg_19_0.equipSkinId)

						if var_21_7 ~= "" then
							var_21_2 = var_21_7
						end
					end

					if var_21_2 and var_21_2 ~= "" and arg_19_0.displayFireFX then
						local var_21_9 = arg_19_0.seaFXPool

						var_3.GetCharacterFX(var_21_9, var_21_2, arg_19_0, true, function()
							return
						end)
					end

					var_19_0 = var_19_0 + 1

					return
				end

				if var_0.tmpData.action_index ~= "" then
					var_2_10002 = arg_19_0
					var_2_10002.characterAction = var_0.tmpData.action_index

					local var_20_1 = arg_19_0

					var_2_10002.setSeaAction(var_20_1, arg_19_0.characterAction, 0, false)

					local var_20_2 = arg_19_0.seaAnimator

					var_2_10002.SetActionCallBack(var_20_2, function(arg_23_0)
						if arg_23_0 == "action" then
							var_20_0()
						end

						return
					end)
				else
					var_20_0()
				end
			else
				local var_20_3 = arg_19_0.characterAction

				ys = var_2_10002

				if var_20_3 ~= var_2_10002.Battle.BattleConst.ActionName.MOVE then
					local var_20_4 = arg_19_0

					ys = var_2
					var_20_4.characterAction = var_2.Battle.BattleConst.ActionName.MOVE

					local var_20_5 = arg_19_0

					var_1.setSeaAction(var_20_5, arg_19_0.characterAction, 0, true)

					var_19_0 = 1

					local var_20_6 = arg_19_0._fireTimer

					var_1.Pause(var_20_6)

					local var_20_7 = arg_19_0._delayTimer

					var_1.Start(var_20_7)
				end
			end

			return
		end

		pg = var_1_10003

		local var_19_2 = var_1_10003.TimeMgr.GetInstance()

		arg_19_0._fireTimer = var_3.AddBattleTimer(var_19_2, "barrageFireTimer", -1, 1.5, var_19_1)

		local function var_19_3()
			local var_24_0 = arg_19_0._delayTimer

			var_0.Stop(var_24_0)

			local var_24_1 = arg_19_0._fireTimer

			var_0.Resume(var_24_1)

			return
		end

		pg = var_1_10004

		local var_19_4 = var_1_10004.TimeMgr.GetInstance()

		arg_19_0._delayTimer = var_4.AddBattleTimer(var_19_4, "", -1, 3, var_19_3, nil, true)
	end

	return
end

function var_0_0.MakeBuff(arg_25_0, arg_25_1)
	getSkillConfig = var_1_10002

	local var_25_0 = var_1_10002(arg_25_1).effect_list[1].arg_list.skill_id
	local var_25_1 = var_2.effect_list[1].arg_list.time

	pg = var_1_10005

	local var_25_2 = var_1_10005.skillCfg["skill_" .. var_25_0]

	if arg_25_0.buffTimer then
		pg = var_6

		local var_25_3 = var_6.TimeMgr.GetInstance()

		var_6.RemoveBattleTimer(var_25_3, arg_25_0.buffTimer)

		arg_25_0.buffTimer = nil
	end

	pg = var_6

	local var_25_4 = var_6.TimeMgr.GetInstance()

	arg_25_0.buffTimer = var_6.AddBattleTimer(var_25_4, "buffTimer", -1, var_25_1, function()
		setActive = var_2_10000

		var_2_10000(arg_25_0.healTF, true)

		setText = var_2_10000

		local var_26_0 = arg_25_0.healTF

		var_2_10000(var_2.Find(var_26_0, "text"), var_25_2.effect_list[1].arg_list.number)

		return
	end)

	return
end

function var_0_0.MakeWeapon(arg_27_0, arg_27_1)
	arg_27_0.weaponList = {}
	arg_27_0.bulletList = {}
	arg_27_0.aircraftList = {}

	local var_27_0 = 0

	ys = var_1_10003

	local var_27_1 = var_1_10003.Battle.BattleConst

	ipairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(arg_27_1) do
		Equipment = var_1_10009
		var_1_10009 = var_1_10009.getConfigData(iter_27_1).weapon_id
		ipairs = var_1_10010

		for iter_27_2, iter_27_3 in var_1_10010(var_1_10009) do
			if iter_27_3 <= 0 then
				break
			end

			var_27_0 = var_27_0 + 1
			ys = var_15

			if var_15.Battle.BattleDataFunction.GetWeaponPropertyDataFromID(iter_27_3).type == var_27_1.EquipmentType.MAIN_CANNON or var_15.type == var_27_1.EquipmentType.SUB_CANNON or var_15.type == var_27_1.EquipmentType.TORPEDO or var_15.type == var_27_1.EquipmentType.MANUAL_TORPEDO or var_15.type == var_27_1.EquipmentType.POINT_HIT_AND_LOCK then
				type = var_16

				if var_16(var_15.barrage_ID) == "table" then
					local var_27_2 = arg_27_0.weaponList

					var_27_2[var_27_0] = {
						tmpData = var_15,
						emitterList = {}
					}
					ipairs = var_27_2

					for iter_27_4, iter_27_5 in var_27_2(var_15.barrage_ID) do
						local var_27_3 = arg_27_0:createEmitterCannon(iter_27_5, var_15.bullet_ID[iter_27_4], var_15.spawn_bound)

						arg_27_0.weaponList[var_27_0].emitterList[iter_27_4] = var_27_3
					end
				end
			elseif var_15.type == var_27_1.EquipmentType.PREVIEW_ARICRAFT then
				type = var_16

				if var_16(var_15.barrage_ID) == "table" then
					local var_27_4 = arg_27_0.weaponList

					var_27_4[var_27_0] = {
						tmpData = var_15,
						emitterList = {}
					}
					ipairs = var_27_4

					for iter_27_6, iter_27_7 in var_27_4(var_15.barrage_ID) do
						local var_27_5 = arg_27_0:createEmitterAir(iter_27_7, var_15.bullet_ID[iter_27_6], var_15.spawn_bound)

						arg_27_0.weaponList[var_27_0].emitterList[iter_27_6] = var_27_5
					end
				end
			end
		end
	end

	return
end

function var_0_0.getEmitterHost(arg_28_0)
	if not arg_28_0._emitterHost then
		ys = var_1

		local var_28_0 = var_1.Battle.BattlePlayerUnit.New
		local var_28_1 = 1

		ys = var_1_10004
		arg_28_0._emitterHost = var_28_0(var_28_1, var_1_10004.Battle.BattleConfig.FRIENDLY_CODE)

		local var_28_2 = {
			speed = 0
		}
		local var_28_3 = arg_28_0._emitterHost

		var_2.SetSkinId(var_28_3, arg_28_0.shipVO.skinId)

		local var_28_4 = arg_28_0._emitterHost

		var_2.SetTemplate(var_28_4, arg_28_0.shipVO.configId, var_28_2)
	end

	return arg_28_0._emitterHost
end

function var_0_0.createEmitterCannon(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:getEmitterHost()

	local function var_29_1(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		local var_30_0

		ys = var_2_10006

		local var_30_1 = var_2_10006.Battle.BattleDataFunction.CreateBattleBulletData(arg_29_2, arg_29_2, var_29_0, var_30_0, var_0_2)

		var_6.SetOffsetPriority(var_30_1, arg_30_3)
		var_6:SetShiftInfo(arg_30_0, arg_30_1)
		var_6:SetRotateInfo(nil, 0, arg_30_2)

		local var_30_2 = arg_29_0.equipSkinId
		local var_30_4, var_30_7

		if 0 < var_30_2 then
			pg = var_30_2

			local var_30_3 = var_30_2.equip_skin_template[arg_29_0.equipSkinId]

			ys = var_30_4

			local var_30_5, var_30_6, var_30_8, var_30_9

			var_30_4, var_30_5, var_30_6, var_30_7, var_30_8, var_30_9 = var_30_4.Battle.BattleDataFunction.GetEquipSkin(arg_29_0.equipSkinId)

			local var_30_10 = var_6:GetType()

			ys = var_2_10015

			local var_30_11 = var_2_10015.Battle.BattleConst.BulletType
			local var_30_12

			if var_30_10 == var_30_11.CANNON or var_30_10 == var_30_11.BOMB then
				_ = var_17

				local var_30_13 = var_17.any

				EquipType = var_2_10019

				if var_30_13(var_2_10019.CannonEquipTypes, function(arg_31_0)
					table = var_3_10001

					return var_3_10001.contains(var_30_3.equip_type, arg_31_0)
				end) then
					var_6:SetModleID(var_30_4)
				elseif var_30_5 and #var_30_5 > 0 then
					var_6:SetModleID(var_30_5, nil, var_30_9)
				elseif var_30_7 and #var_30_7 > 0 then
					var_6:SetModleID(var_30_7, nil, var_30_9)
				end
			elseif var_30_10 == var_30_11.TORPEDO then
				table = var_17

				local var_30_14 = var_17.contains
				local var_30_15 = var_30_3.equip_type

				EquipType = var_2_10020

				if var_30_14(var_30_15, var_2_10020.Torpedo) then
					var_6:SetModleID(var_30_4)
				elseif var_30_6 and #var_30_6 > 0 then
					var_6:SetModleID(var_30_6, nil, var_30_9)
				end
			end
		end

		local var_30_16 = var_6:GetType()

		ys = var_30_4

		local var_30_17 = var_30_4.Battle.BattleConst.BulletType
		local var_30_18

		if var_30_16 == var_30_17.CANNON then
			ys = var_10
			var_30_18 = var_10.Battle.BattleCannonBullet.New()
		elseif var_30_16 == var_30_17.BOMB then
			ys = var_10
			var_30_18 = var_10.Battle.BattleBombBullet.New()
		elseif var_30_16 == var_30_17.TORPEDO then
			ys = var_10
			var_30_18 = var_10.Battle.BattleTorpedoBullet.New()
		else
			ys = var_10
			var_30_18 = var_10.Battle.BattleBullet.New()
		end

		var_30_18:SetBulletData(var_6)

		local function var_30_19(arg_32_0)
			local var_32_0 = var_30_18

			var_1.AddModel(var_32_0, arg_32_0)

			local var_32_1 = var_30_18

			var_1.AddRotateScript(var_32_1)

			tf = var_1

			if var_1(arg_32_0).parent then
				var_1.parent = nil
			end

			local var_32_2 = var_1

			if var_1.Find(var_32_2, "bullet_random") then
				local var_32_3 = var_2
				local var_32_4 = var_2.GetComponent

				typeof = var_3_10006
				SpineAnim = var_3_10008

				if var_32_4(var_32_3, var_3_10006(var_3_10008)) then
					local var_32_5 = var_2
					local var_32_6 = var_2.GetComponent

					typeof = var_6
					SpineAnim = var_3_10008

					local var_32_7 = var_32_6(var_32_5, var_6(var_3_10008))

					tostring = var_32_2
					math = var_6

					local var_32_8 = var_32_2(var_6.random(3))

					var_32_7:SetAction(var_32_8, 0, false)
				end
			end

			local var_32_9 = var_30_18

			var_3.SetSpawn(var_32_9, arg_29_0.boneList[arg_29_3])

			if arg_29_0.bulletList then
				table = var_3

				var_3.insert(arg_29_0.bulletList, var_30_18)

				if arg_29_0.equipSkinId > 0 then
					pg = var_3

					local var_32_10 = var_3.equip_skin_template[arg_29_0.equipSkinId]
					local var_32_11 = var_0
					local var_32_12 = var_4.GetType(var_32_11)

					ys = var_5

					if var_32_12 == var_5.Battle.BattleConst.BulletType.CANNON then
						_ = var_6

						local var_32_13 = var_6.any

						EquipType = var_3_10008

						if var_32_13(var_3_10008.CannonEquipTypes, function(arg_33_0)
							table = var_4_10001

							return var_4_10001.contains(var_32_10.equip_type, arg_33_0)
						end) and var_32_10.preview_hit_distance > 0 then
							local var_32_14 = arg_29_0

							var_6.AddSelfDestroyBullet(var_32_14, var_30_18, var_32_10.preview_hit_distance)
						end
					elseif var_32_12 == var_5.TORPEDO then
						table = var_6

						local var_32_15 = var_6.contains
						local var_32_16 = var_32_10.equip_type

						EquipType = var_3_10009

						if var_32_15(var_32_16, var_3_10009.Torpedo) and var_32_10.preview_hit_distance > 0 then
							local var_32_17 = arg_29_0

							var_6.AddSelfDestroyBullet(var_32_17, var_30_18, var_32_10.preview_hit_distance)
						end
					end
				end
			end

			return
		end

		ys = var_30_7

		local var_30_20 = var_30_7.Battle.BattleResourceManager.GetInstance()

		var_11.InstBullet(var_30_20, var_30_18:GetModleID(), function(arg_34_0)
			var_30_19(arg_34_0)

			return
		end)

		return
	end

	local function var_29_2()
		return
	end

	local var_29_3 = "BattleBulletEmitter"

	ys = var_1_10008

	return (var_1_10008.Battle[var_29_3].New(var_29_1, var_29_2, arg_29_1))
end

function var_0_0.createEmitterAir(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local function var_36_0(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		local var_37_0 = {
			id = arg_36_2
		}

		pg = var_6
		var_37_0.tmpData = var_6.aircraft_template[arg_36_2]
		math = var_7

		local var_37_1 = var_7.deg2Rad * arg_37_2

		Vector3 = var_2_10008
		math = var_2_10010

		local var_37_2 = var_2_10010.cos(var_37_1)
		local var_37_3 = 0

		math = var_12

		local var_37_4 = var_2_10008(var_37_2, var_37_3, var_12.sin(var_37_1))

		local function var_37_5(arg_38_0)
			local var_38_0 = var_0_1

			Vector3 = var_3_10002

			local var_38_1 = var_38_0 + var_3_10002(var_0.position_offset[1] + arg_37_0, var_0.position_offset[2], var_0.position_offset[3] + arg_37_1)

			arg_38_0.transform.localPosition = var_38_1
			arg_38_0.transform.localScale = var_0_4
			var_37_0.obj = arg_38_0
			var_37_0.tf = arg_38_0.transform
			var_37_0.pos = var_38_1

			local var_38_2 = var_37_0

			ys = var_3
			var_38_2.baseVelocity = var_3.Battle.BattleFormulas.ConvertAircraftSpeed(var_37_0.tmpData.speed)
			var_37_0.speed = var_37_4 * var_37_0.baseVelocity

			local var_38_3 = var_37_0

			math = var_3
			var_38_3.speedZ = (var_3.random() - 0.5) * 0.5
			var_37_0.targetZ = var_0_1.z

			if arg_36_0.aircraftList then
				table = var_2

				var_2.insert(arg_36_0.aircraftList, var_37_0)
			end

			return
		end

		local var_37_6 = var_6.model_ID
		local var_37_7

		if arg_36_0.equipSkinId > 0 then
			pg = var_37_7
			var_37_7 = var_37_7.equip_skin_template[arg_36_0.equipSkinId]
			table = var_12

			local var_37_8 = var_12.contains
			local var_37_9 = var_37_7.equip_type

			EquipType = var_2_10015

			if var_37_8(var_37_9, var_2_10015.AirProtoEquipTypes[var_6.type]) then
				ys = var_12
				var_37_6 = var_12.Battle.BattleDataFunction.GetEquipSkin(arg_36_0.equipSkinId)
			end
		end

		ys = var_37_7

		local var_37_10 = var_37_7.Battle.BattleResourceManager.GetInstance()

		var_11.InstAirCharacter(var_37_10, var_37_6, function(arg_39_0)
			var_37_5(arg_39_0)

			return
		end)

		return
	end

	local function var_36_1()
		return
	end

	local var_36_2 = "BattleBulletEmitter"

	ys = var_1_10007

	return (var_1_10007.Battle[var_36_2].New(var_36_0, var_36_1, arg_36_1))
end

function var_0_0.AddSelfDestroyBullet(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.displayHitFX then
		return
	end

	table = var_3

	var_3.insert(arg_41_0.UpdateHandlers, function(arg_42_0)
		table = var_2_10001

		if not var_2_10001.indexof(arg_41_0.bulletList, arg_41_1) then
			arg_42_0()

			return
		end

		local var_42_0 = arg_41_1
		local var_42_1 = var_2.GetBulletData(var_42_0)

		if var_2.GetCurrentDistance(var_42_1) < arg_41_2 then
			return
		end

		local var_42_2 = arg_41_0

		var_2.RemoveBullet(var_42_2, var_1, true)
		arg_42_0()

		return
	end)

	return
end

function var_0_0.RemoveBullet(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.bulletList[arg_43_1]

	Object = var_1_10004

	var_1_10004.Destroy(var_43_0._go)

	table = var_4

	var_4.remove(arg_43_0.bulletList, arg_43_1)

	if arg_43_2 then
		local var_43_1 = var_43_0:GetMissFXID()

		if arg_43_0.equipSkinId > 0 then
			pg = var_5

			if var_5.equip_skin_template[arg_43_0.equipSkinId].hit_fx_name ~= "" then
				var_43_1 = var_5.hit_fx_name
			end
		end

		if var_43_1 and var_43_1 ~= "" then
			local var_43_2 = arg_43_0.seaFXPool
			local var_43_3, var_43_4 = var_5.GetFX(var_43_2, var_43_1)

			pg = var_43_2

			local var_43_5 = var_43_2.EffectMgr.GetInstance()

			var_7.PlayBattleEffect(var_43_5, var_43_3, var_43_0:GetPosition() + var_43_4, true)
		end
	end

	return
end

function var_0_0.SeaUpdate(arg_44_0)
	local var_44_0 = 0
	local var_44_1 = -20
	local var_44_2 = 60
	local var_44_3 = 0
	local var_44_4 = 60

	ys = var_1_10006

	local var_44_5 = var_1_10006.Battle.BattleConfig

	ys = var_1_10007

	local var_44_6 = var_1_10007.Battle.BattleConst

	local function var_44_7()
		for iter_45_0 = #arg_44_0.bulletList, 1, -1 do
			local var_45_0 = arg_44_0.bulletList[iter_45_0]._bulletData
			local var_45_1 = var_5.GetSpeed(var_45_0)()

			if var_4:GetPosition().x > var_44_2 and var_45_1.x > 0 or var_6.z < var_44_3 and var_45_1.z < 0 then
				var_2_10009 = arg_44_0

				var_7.RemoveBullet(var_2_10009, iter_45_0, false)

				goto label_45_0
			end

			if var_6.x < var_44_1 and var_45_1.x < 0 then
				var_2_10009 = var_4

				if var_4.GetType(var_2_10009) ~= var_44_6.BulletType.BOMB then
					var_2_10009 = arg_44_0

					var_7.RemoveBullet(var_2_10009, iter_45_0, false)

					goto label_45_0
				end
			end

			pg = var_7
			var_2_10009 = var_7.TimeMgr.GetInstance()

			local var_45_2 = var_7.GetCombatTime(var_2_10009)
			local var_45_3 = var_4._bulletData

			var_8.Update(var_45_3, var_45_2)
			var_4:Update(var_44_0)

			local var_45_4 = var_6.z

			if var_44_4 < var_45_4 then
				local var_45_5 = var_45_1.z

				if not (0 < var_45_5) then
					do
						local var_45_6 = var_4._bulletData

						if var_8.IsOutRange(var_45_6, var_44_0) then
							local var_45_7 = arg_44_0

							var_8.RemoveBullet(var_45_7, iter_45_0, true)
						end
					end

					::label_45_0::
				end
			end
		end

		ipairs = var_0

		for iter_45_1, iter_45_2 in var_0(arg_44_0.aircraftList) do
			if (iter_45_2.pos + iter_45_2.speed).y < var_44_5.AircraftHeight + 5 then
				local var_45_8 = iter_45_2.speed

				math = var_7
				var_45_8.y = var_7.max(0.4, 1 - var_5.y / var_44_5.AircraftHeight)
				math = var_45_8

				local var_45_9 = var_45_8.min(1, var_5.y / var_44_5.AircraftHeight)
				local var_45_10 = iter_45_2.tf

				Vector3 = var_8
				var_45_10.localScale = var_8(var_45_9, var_45_9, var_45_9)
			end

			iter_45_2.speed.z = iter_45_2.baseVelocity * iter_45_2.speedZ

			if iter_45_2.targetZ - var_5.z > iter_45_2.baseVelocity then
				iter_45_2.speed.z = iter_45_2.baseVelocity * 0.5
			elseif var_6 < -iter_45_2.baseVelocity then
				iter_45_2.speed.z = -iter_45_2.baseVelocity * 0.5
			else
				local var_45_11 = var_0_1.z
				local var_45_12 = var_0_1.z

				math = var_2_10009
				iter_45_2.targetZ = var_45_11 + var_45_12 * (var_2_10009.random() - 0.5) * 0.6
			end

			if var_5.x > var_44_2 or var_5.x < var_44_1 then
				Object = var_7

				var_7.Destroy(iter_45_2.obj)

				table = var_7

				var_7.remove(arg_44_0.aircraftList, iter_45_1)
			else
				iter_45_2.tf.localPosition = var_5
				iter_45_2.pos = var_5
			end
		end

		for iter_45_3 = #arg_44_0.UpdateHandlers, 1, -1 do
			local var_45_13 = arg_44_0.UpdateHandlers[iter_45_3]

			local function var_45_14()
				table = var_3_10000

				var_3_10000.remove(arg_44_0.UpdateHandlers, iter_45_3)

				return
			end

			var_45_13(var_45_14)
		end

		var_44_0 = var_44_0 + 1

		return
	end

	pg = var_1_10009

	local var_44_8 = var_1_10009.TimeMgr.GetInstance()

	var_9.AddBattleTimer(var_44_8, "barrageUpdateTimer", -1, 0.033, var_44_7)

	return
end

function var_0_0.GetFXOffsets(arg_47_0, arg_47_1)
	arg_47_1 = arg_47_1 or 1

	return arg_47_0._FXOffset[arg_47_1]
end

function var_0_0.GetAttachPoint(arg_48_0)
	return arg_48_0._FXAttachPoint
end

function var_0_0.GetGO(arg_49_0)
	return arg_49_0.seaCharacter
end

function var_0_0.GetSpecificFXScale(arg_50_0)
	return {}
end

function var_0_0.clear(arg_51_0)
	pg = var_1_10001

	local var_51_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveAllBattleTimer(var_51_0)

	arg_51_0._emitterHost = nil

	if arg_51_0.seaCharacter then
		Destroy = var_1

		var_1(arg_51_0.seaCharacter)

		arg_51_0.seaCharacter = nil
	end

	if arg_51_0.aircraftList then
		ipairs = var_1

		for iter_51_0, iter_51_1 in var_1(arg_51_0.aircraftList) do
			Destroy = var_1_10006

			var_1_10006(iter_51_1.obj)
		end

		arg_51_0.aircraftList = nil
	end

	if arg_51_0.seaView then
		local var_51_1 = arg_51_0.seaView

		var_1.Dispose(var_51_1)

		arg_51_0.seaView = nil
	end

	if arg_51_0.weaponList then
		ipairs = var_1

		for iter_51_2, iter_51_3 in var_1(arg_51_0.weaponList) do
			ipairs = var_1_10006

			for iter_51_4, iter_51_5 in var_1_10006(iter_51_3.emitterList) do
				iter_51_5:Destroy()
			end
		end

		arg_51_0.weaponList = nil
	end

	if arg_51_0.bulletList then
		ipairs = var_1

		for iter_51_6, iter_51_7 in var_1(arg_51_0.bulletList) do
			Destroy = var_1_10006

			var_1_10006(iter_51_7._go)
		end

		arg_51_0.bulletList = nil
	end

	if arg_51_0.orbitList then
		ipairs = var_1

		for iter_51_8, iter_51_9 in var_1(arg_51_0.orbitList) do
			Destroy = var_1_10006

			var_1_10006(iter_51_9)
		end

		arg_51_0.orbitList = nil
	end

	if arg_51_0.seaFXPool then
		local var_51_2 = arg_51_0.seaFXPool

		var_1.Clear(var_51_2)

		arg_51_0.seaFXPool = nil
	end

	if arg_51_0.seaFXContainersPool then
		local var_51_3 = arg_51_0.seaFXContainersPool

		var_1.Clear(var_51_3)

		arg_51_0.seaFXContainersPool = nil
	end

	ys = var_1

	local var_51_4 = var_1.Battle.BattleResourceManager.GetInstance()

	var_1.Clear(var_51_4)

	arg_51_0.seaCamera.enabled = false
	arg_51_0.seaCameraGO = nil
	arg_51_0.seaCamera = nil
	arg_51_0.loading = false
	arg_51_0.loaded = false

	if arg_51_0.palyAnimTimer then
		local var_51_5 = arg_51_0.palyAnimTimer

		var_2.Stop(var_51_5)

		arg_51_0.palyAnimTimer = nil
	end

	return
end

return var_0_0
