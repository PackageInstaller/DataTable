class = var_0_10000

local var_0_0 = var_0_10000("GuildMissionBattleView")

Vector3 = var_1

local var_0_1 = var_1(40, -3, 40)
local var_0_2 = 10
local var_0_3 = 1028

Vector3 = var_4

local var_0_4 = var_4(80, -3, 40)

local function var_0_5(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	ipairs = var_1_10003
	ys = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10003(var_1_10004.Battle.BattleConst.FXContainerIndex) do
		local var_1_2 = arg_1_0[iter_1_0]

		Vector3 = var_1_10009
		var_1_1[iter_1_0] = var_1_10009(var_1_2[1], var_1_2[2], var_1_2[3])
	end

	var_1_0._FXOffset = var_1_1
	GameObject = var_3
	var_1_0._FXAttachPoint = var_3()

	function var_1_0.GetFXOffsets(arg_2_0, arg_2_1)
		arg_2_1 = arg_2_1 or 1

		return arg_2_0._FXOffset[arg_2_1]
	end

	function var_1_0.GetAttachPoint(arg_3_0)
		return arg_3_0._FXAttachPoint
	end

	function var_1_0.GetGO(arg_4_0)
		return arg_4_0._go
	end

	function var_1_0.SetGo(arg_5_0, arg_5_1)
		assert = var_2_10002

		var_2_10002(arg_5_1)

		arg_5_0._go = arg_5_1

		local var_5_0 = arg_5_0._FXAttachPoint.transform

		var_2.SetParent(var_5_0, arg_5_1.transform, false)

		Vector3 = var_3
		var_2.localPosition = var_3.zero
		Vector3 = var_3
		var_2.localEulerAngles = var_3(330, 0, 0)

		return
	end

	function var_1_0.GetSpecificFXScale(arg_6_0)
		return {}
	end

	return var_1_0
end

function var_0_0.Ctor(arg_7_0, arg_7_1)
	arg_7_0.rawImage = arg_7_1
	setActive = var_1_10002

	var_1_10002(arg_7_0.rawImage, false)

	GameObject = var_1_10002
	arg_7_0.seaCameraGO = var_1_10002.Find("BarrageCamera")

	local var_7_0 = arg_7_0.seaCameraGO
	local var_7_1 = var_2.GetComponent

	typeof = var_4
	Camera = var_1_10005
	arg_7_0.seaCamera = var_7_1(var_7_0, var_4(var_1_10005))

	local var_7_2 = arg_7_0.rawImage.texture

	var_2.Release(var_7_2)

	var_2.width = 1920
	var_2.height = 1080

	var_2:Create()

	arg_7_0.seaCamera.targetTexture = var_2
	arg_7_0.seaCamera.enabled = true

	return
end

function var_0_0.configUI(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.nameTF = arg_8_2
	arg_8_0.healTF = arg_8_1
	setActive = var_1_10003

	var_1_10003(arg_8_0.healTF, false)

	local var_8_0 = arg_8_0.healTF
	local var_8_1 = var_3.GetComponent(var_8_0, "DftAniEvent")

	var_3.SetEndEvent(var_8_1, function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.healTF, false)

		setText = var_2_10000

		local var_9_0 = arg_8_0.healTF

		var_2_10000(var_1.Find(var_9_0, "text"), "")

		return
	end)

	return
end

function var_0_0.load(arg_10_0, arg_10_1, arg_10_2)
	ys = var_1_10003

	var_1_10003.Battle.BattleVariable.Init(true)

	ys = var_3

	local var_10_0 = var_3.Battle.BattleResourceManager.GetInstance()

	var_3.Init(var_10_0)
	var_3:AddPreloadResource(var_3.GetMapResource(arg_10_1))

	local function var_10_1()
		pg = var_2_10000

		local var_11_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_11_0)

		local var_11_1 = arg_10_0

		ys = var_11_0
		var_11_1.seaView = var_11_0.Battle.BattleMap.New(arg_10_1)
		setActive = var_11_1

		var_11_1(arg_10_0.rawImage, true)

		GameObject = var_11_1

		local var_11_2 = var_11_1.Find("scenes").transform

		Vector3 = var_2
		var_11_2.position = var_2(0, -26, 0)

		local var_11_3 = var_0

		var_1.Clear(var_11_3)

		if arg_10_2 then
			onNextTick = var_1

			var_1(arg_10_2)
		end

		return
	end

	var_3:StartPreload(var_10_1, nil)

	pg = var_5

	local var_10_2 = var_5.UIMgr.GetInstance()

	var_5.LoadingOn(var_10_2)

	return
end

function var_0_0.LoadShip(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_1 then
		arg_12_4()

		return
	end

	if arg_12_0.shipVO then
		arg_12_4()

		return
	end

	arg_12_0.unitList = {}
	arg_12_0.bulletUnitList = {}
	arg_12_0.shipVO = arg_12_1
	arg_12_0.equipSkinId = 0
	arg_12_0.weaponIds = arg_12_2
	ys = var_5

	local var_12_0 = var_5.Battle.BattleFXPool.GetInstance()

	var_5.Init(var_12_0)

	ys = var_5
	arg_12_0._cldSystem = var_5.Battle.BattleCldSystem.New(arg_12_0)
	ys = var_5

	local var_12_1 = var_5.Battle.BattleResourceManager.GetInstance()

	var_5.Init(var_12_1)
	var_5:AddPreloadResource(var_5.GetDisplayCommonResource())

	if arg_12_0.equipSkinId > 0 then
		var_5:AddPreloadResource(var_5.GetEquipSkinPreviewRes(arg_12_0.equipSkinId))
	end

	pg = var_6

	local var_12_2 = var_6.enemy_data_statistics[var_0_2]

	var_5:AddPreloadResource(var_5.GetCharacterPath(var_12_2.prefab), false)

	pg = var_7

	local var_12_3 = var_7.enemy_data_statistics[var_0_3]

	var_5:AddPreloadResource(var_5.GetCharacterPath(var_12_3.prefab), false)
	var_5:AddPreloadResource(var_5.GetShipResource(arg_12_1.configId, arg_12_1.skinId), false)

	local var_12_4 = arg_12_1
	local var_12_5 = arg_12_1.getShipType(var_12_4)

	ShipType = var_12_4

	if var_12_5 ~= var_12_4.WeiXiu then
		ipairs = var_12_5

		for iter_12_0, iter_12_1 in var_12_5(arg_12_2) do
			if iter_12_1 ~= 0 then
				ys = var_1_10013
				var_1_10013 = var_1_10013.Battle.BattleDataFunction.GetWeaponDataFromID(iter_12_1).weapon_id
				ipairs = var_14

				for iter_12_2, iter_12_3 in var_14(var_1_10013) do
					var_5:AddPreloadResource(var_5.GetWeaponResource(iter_12_3))
				end
			end
		end
	end

	local function var_12_6()
		local function var_13_0(arg_14_0)
			arg_12_0.seaCharacter = arg_14_0

			local var_14_0 = arg_12_1
			local var_14_1 = var_1.getConfig(var_14_0, "scale") / 50
			local var_14_2 = arg_14_0.transform

			Vector3 = var_3
			var_14_2.localScale = var_3(var_14_1 - 0.4, var_14_1, var_14_1)

			local var_14_3 = arg_14_0.transform
			local var_14_4 = arg_12_0

			var_14_3.localPosition = var_3.GetCharacterOffset(var_14_4)

			local var_14_5 = arg_14_0.transform

			Vector3 = var_3
			var_14_5.localEulerAngles = var_3(30, 0, 0)

			local var_14_6 = arg_12_0
			local var_14_7 = arg_14_0.transform

			var_14_6.seaAnimator = var_3.GetComponent(var_14_7, "SpineAnim")

			local var_14_8 = arg_12_0

			ys = var_3
			var_14_8.characterAction = var_3.Battle.BattleConst.ActionName.MOVE

			local var_14_9 = arg_12_0.seaAnimator

			var_2.SetAction(var_14_9, arg_12_0.characterAction, 0, true)

			cloneTplTo = var_2

			local var_14_10 = var_2(arg_12_0.nameTF, arg_14_0)

			Vector3 = var_3
			var_14_10.localPosition = var_3(0, -0.35, -1)
			setText = var_3

			var_3(var_14_10:Find("Text"), arg_12_3)

			pg = var_3

			local var_14_11 = var_3.ship_skin_template[arg_12_1.skinId]
			local var_14_12 = var_0_5(var_14_11.fx_container)

			var_4.SetGo(var_14_12, arg_14_0)

			ys = var_5

			local var_14_13 = var_5.Battle.BattleFXPool.GetInstance()
			local var_14_14 = var_5.GetCharacterFX(var_14_13, "movewave", var_4)

			pg = var_14_13

			local var_14_15 = var_14_13.EffectMgr.GetInstance()
			local var_14_16 = var_7.PlayBattleEffect
			local var_14_17 = var_14_14

			Vector3 = var_3_10010

			var_14_16(var_14_15, var_14_17, var_3_10010(0, 0, 0), true)

			arg_12_0.seaFXPool = var_5

			local var_14_18 = arg_12_1
			local var_14_19 = var_7.getShipType(var_14_18)

			ShipType = var_14_18

			if var_14_19 ~= var_14_18.WeiXiu then
				var_14_19 = arg_12_0
				var_14_19.boneList = {}
				pg = var_14_19
				var_14_19 = var_14_19.ship_skin_template[arg_12_1.skinId]
				pairs = var_8

				for iter_14_0, iter_14_1 in var_8(var_14_19.bound_bone) do
					local var_14_20 = {}

					ipairs = var_3_10014

					for iter_14_2, iter_14_3 in var_3_10014(iter_14_1) do
						type = var_3_10019

						if var_3_10019(iter_14_3) == "table" then
							var_3_10019 = #var_14_20 + 1
							Vector3 = var_20
							var_14_20[var_3_10019] = var_20(iter_14_3[1], iter_14_3[2], iter_14_3[3])
						else
							var_3_10019 = #var_14_20 + 1
							Vector3 = var_20
							var_14_20[var_3_10019] = var_20.zero
						end
					end

					var_3_10014 = arg_12_0.boneList
					var_3_10014[iter_14_0] = var_14_20[1]
				end
			end

			LeanTween = var_14_19

			local var_14_21 = var_14_19.value(arg_14_0, -20, 0, 2)
			local var_14_22 = var_7.setOnUpdate

			System = var_9

			var_14_22(var_14_21, var_9.Action_float(function(arg_15_0)
				local var_15_0 = arg_14_0.transform

				Vector3 = var_4_10002
				var_15_0.position = var_4_10002(arg_15_0, arg_14_0.transform.position.y, arg_14_0.transform.position.z)

				return
			end))

			return
		end

		seriesAsync = var_2_10001

		var_2_10001({
			function(arg_16_0)
				local var_16_0 = var_0
				local var_16_1 = var_1.InstCharacter
				local var_16_2 = arg_12_1

				var_16_1(var_16_0, var_3.getPrefab(var_16_2), function(arg_17_0)
					var_13_0(arg_17_0)
					arg_16_0()

					return
				end)

				return
			end,
			function(arg_18_0)
				local var_18_0 = arg_12_0

				var_1.CreateMonster(var_18_0, arg_18_0)

				return
			end,
			function(arg_19_0)
				local var_19_0 = arg_12_0

				var_1.CreateItemBox(var_19_0, arg_19_0)

				return
			end
		}, function()
			local var_20_0 = arg_12_0

			var_20_0.loaded = true
			pg = var_20_0

			local var_20_1 = var_20_0.TimeMgr.GetInstance()

			var_0.ResumeBattleTimer(var_20_1)

			local var_20_2 = arg_12_1
			local var_20_3 = var_0.getShipType(var_20_2)

			ShipType = var_20_2

			if var_20_3 ~= var_20_2.WeiXiu then
				local var_20_4 = arg_12_0

				var_0.onWeaponUpdate(var_20_4)

				local var_20_5 = arg_12_0

				var_0.SeaUpdate(var_20_5)
			end

			if arg_12_4 then
				arg_12_4()
			end

			return
		end)

		return
	end

	var_5:StartPreload(var_12_6, nil)

	return
end

function var_0_0.StartMoveOtherShips(arg_21_0, arg_21_1)
	local function var_21_0(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.transform.localPosition

		math = var_2_10003

		local var_22_1 = var_2_10003.random(5, 8)

		math = var_4

		local var_22_2 = var_4.random(0, 5)

		LeanTween = var_5

		local var_22_3 = var_5.value(arg_22_0, var_22_0.x, 80, var_22_1)
		local var_22_4 = var_5.setOnUpdate

		System = var_7

		local var_22_5 = var_22_4(var_22_3, var_7.Action_float(function(arg_23_0)
			local var_23_0 = arg_22_0.transform

			Vector3 = var_3_10002
			var_23_0.localPosition = var_3_10002(arg_23_0, var_22_0.y, var_22_0.z)

			return
		end))
		local var_22_6 = var_5.setOnComplete

		System = var_7

		local var_22_7 = var_22_6(var_22_5, var_7.Action(arg_22_1))

		var_5.setDelay(var_22_7, var_22_2)

		return
	end

	local var_21_1 = {}

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(arg_21_0.otherShipGos) do
		table = var_1_10009

		var_1_10009.insert(var_21_1, function(arg_24_0)
			var_21_0(iter_21_1, arg_24_0)

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_21_1, arg_21_1)

	return
end

function var_0_0.PlayOtherShipAnim(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0.loaded then
		return
	end

	arg_25_0.otherShipGos = {}
	ys = var_3

	local var_25_0 = var_3.Battle.BattleResourceManager.GetInstance()

	var_3.Init(var_25_0)
	var_3:AddPreloadResource(var_3.GetDisplayCommonResource())

	local function var_25_1(arg_26_0, arg_26_1, arg_26_2)
		pg = var_2_10003

		local var_26_0 = var_2_10003.ship_data_statistics[arg_26_0.id].scale / 50
		local var_26_1 = arg_26_2.transform

		Vector3 = var_2_10006
		var_26_1.localScale = var_2_10006(var_26_0 - 0.4, var_26_0, var_26_0)

		local var_26_2 = arg_26_2.transform

		Vector3 = var_6
		var_26_2.localPosition = var_6(-20, 0, arg_26_1)

		local var_26_3 = arg_26_2.transform

		Vector3 = var_6
		var_26_3.localEulerAngles = var_6(30, 0, 0)

		local var_26_4 = arg_26_2.transform
		local var_26_5 = var_5.GetComponent(var_26_4, "SpineAnim")
		local var_26_6 = var_5.SetAction

		ys = var_8

		var_26_6(var_26_5, var_8.Battle.BattleConst.ActionName.MOVE, 0, true)

		cloneTplTo = var_26_6

		local var_26_7 = var_26_6(arg_25_0.nameTF, arg_26_2)

		Vector3 = var_7
		var_26_7.localPosition = var_7(0, -0.35, -1)
		setText = var_7

		var_7(var_26_7:Find("Text"), arg_26_0.name)

		pg = var_7

		local var_26_8 = var_7.ship_skin_template[arg_26_0.skin]
		local var_26_9 = var_0_5(var_26_8.fx_container)

		var_8.SetGo(var_26_9, arg_26_2)

		ys = var_9

		local var_26_10 = var_9.Battle.BattleFXPool.GetInstance()
		local var_26_11 = var_9.GetCharacterFX(var_26_10, "movewave", var_8)

		pg = var_26_10

		local var_26_12 = var_26_10.EffectMgr.GetInstance()
		local var_26_13 = var_11.PlayBattleEffect
		local var_26_14 = var_26_11

		Vector3 = var_2_10014

		var_26_13(var_26_12, var_26_14, var_2_10014(0, 0, 0), true)

		table = var_26_13

		var_26_13.insert(arg_25_0.otherShipGos, arg_26_2)

		return
	end

	local var_25_2 = {}
	local var_25_3 = {}

	math = var_1_10007
	var_25_3[1] = var_1_10007.random(43, 48)
	math = var_7
	var_25_3[2] = var_7.random(49, 53)
	ipairs = var_7

	for iter_25_0, iter_25_1 in var_7(arg_25_1) do
		var_3:AddPreloadResource(var_3.GetShipResource(iter_25_1.id, iter_25_1.skin), false)

		table = var_12

		var_12.insert(var_25_2, function(arg_27_0)
			pg = var_2_10001

			local var_27_0 = var_2_10001.ship_skin_template[iter_25_1.skin]

			assert = var_2

			var_2(var_27_0, iter_25_1.skin)

			local var_27_1 = var_0

			var_2.InstCharacter(var_27_1, var_27_0.prefab, function(arg_28_0)
				var_25_1(iter_25_1, var_25_3[iter_25_0], arg_28_0)
				arg_27_0()

				return
			end)

			return
		end)
	end

	local function var_25_4()
		ipairs = var_2_10000

		for iter_29_0, iter_29_1 in var_2_10000(arg_25_0.otherShipGos) do
			Destroy = var_2_10005

			var_2_10005(iter_29_1)
		end

		arg_25_0.otherShipGos = nil

		arg_25_2()

		return
	end

	local function var_25_5()
		seriesAsync = var_2_10000

		var_2_10000(var_25_2, function()
			local var_31_0 = arg_25_0

			var_0.StartMoveOtherShips(var_31_0, var_25_4)

			return
		end)

		return
	end

	var_3:StartPreload(var_25_5, nil)

	return
end

function var_0_0.PlayAttackAnim(arg_32_0)
	arg_32_0.isFinish = nil

	local function var_32_0()
		if not arg_32_0.animTimer then
			return
		end

		local var_33_0 = arg_32_0.animTimer

		var_0.Stop(var_33_0)

		arg_32_0.animTimer = nil

		return
	end

	local function var_32_1(arg_34_0)
		var_32_0()

		local var_34_0 = arg_32_0.seaEmenyAnimator

		var_1.SetAction(var_34_0, "move", 0, true)

		local var_34_1 = var_0_1

		Vector3 = var_34_0

		local var_34_2

		var_34_2.localPosition, var_34_2 = var_34_1 + var_34_0(40, 0, 0), arg_32_0.seaEmeny.transform
		setActive = var_3

		var_3(arg_32_0.seaEmeny, true)

		local var_34_3 = arg_32_0

		Timer = var_4
		var_34_3.animTimer = var_4.New(function()
			local var_35_0 = var_34_2

			Vector3 = var_3_10001

			local var_35_1 = var_3_10001.Lerp
			local var_35_2 = var_34_2.localPosition
			local var_35_3 = var_0_1

			Time = var_3_10004
			var_35_0.localPosition = var_35_1(var_35_2, var_35_3, var_3_10004.deltaTime * 3)
			Vector3 = var_35_0

			if var_35_0.Distance(var_0_1, var_34_2.localPosition) <= 1 then
				arg_34_0()
			end

			return
		end, 0.033, -1)

		local var_34_4 = arg_32_0.animTimer

		var_3.Start(var_34_4)

		return
	end

	local function var_32_2(arg_36_0)
		var_32_0()

		local var_36_0 = arg_32_0.shipVO
		local var_36_1 = var_1.getShipType(var_36_0)

		ShipType = var_36_0

		local var_36_2

		if var_36_1 ~= var_36_0.WeiXiu then
			var_36_2 = arg_32_0

			var_1.SeaFire(var_36_2)
		end

		local var_36_3 = arg_32_0

		Timer = var_36_2
		var_36_3.animTimer = var_36_2.New(arg_36_0, 3, 1)

		local var_36_4 = arg_32_0.animTimer

		var_1.Start(var_36_4)

		return
	end

	local function var_32_3(arg_37_0)
		var_32_0()

		if not arg_32_0.isFinish then
			local var_37_0 = arg_32_0

			var_1.HandleBulletHit(var_37_0, nil, arg_32_0.unitList[1])
		end

		local var_37_1 = arg_32_0.seaAnimator

		var_1.SetActionCallBack(var_37_1, function(arg_38_0)
			if arg_38_0 == "finish" then
				local var_38_0 = arg_32_0.seaAnimator

				var_1.SetAction(var_38_0, "move", 0, true)

				local var_38_1 = arg_32_0.seaAnimator

				var_1.SetActionCallBack(var_38_1, nil)
				arg_37_0()
			end

			return
		end)

		local var_37_2 = arg_32_0.seaAnimator

		var_1.SetAction(var_37_2, "victory", 0, true)

		return
	end

	seriesAsync = var_1_10005

	var_1_10005({
		var_32_1,
		var_32_2,
		var_32_3
	})

	return
end

function var_0_0.PlayItemAnim(arg_39_0)
	(function()
		if not arg_39_0.animTimer then
			return
		end

		local var_40_0 = arg_39_0.animTimer

		var_0.Stop(var_40_0)

		arg_39_0.animTimer = nil

		return
	end)()

	local function var_39_0(arg_41_0)
		local var_41_0 = arg_39_0.seaItemBoxAnimator

		var_1.SetAction(var_41_0, "move", 0, true)

		setActive = var_1

		var_1(arg_39_0.seaItemBox, true)

		local var_41_1 = arg_39_0.seaItemBox.transform

		var_41_1.localPosition = var_0_4

		local var_41_2 = arg_39_0

		Timer = var_3
		var_41_2.animTimer = var_3.New(function()
			local var_42_0 = var_41_1

			Vector3 = var_3_10001

			local var_42_1 = var_3_10001.Lerp
			local var_42_2 = var_41_1.localPosition
			local var_42_3 = var_0_1

			Time = var_3_10004
			var_42_0.localPosition = var_42_1(var_42_2, var_42_3, var_3_10004.deltaTime * 3)
			Vector3 = var_42_0

			if var_42_0.Distance(var_0_1, var_41_1.localPosition) <= 1 then
				arg_41_0()
			end

			return
		end, 0.033, -1)

		local var_41_3 = arg_39_0.animTimer

		var_2.Start(var_41_3)

		return
	end

	local function var_39_1(arg_43_0)
		var_0()

		local var_43_0 = arg_39_0.seaAnimator

		var_1.SetActionCallBack(var_43_0, function(arg_44_0)
			if arg_44_0 == "finish" then
				local var_44_0 = arg_39_0.seaAnimator

				var_1.SetAction(var_44_0, "move", 0, true)

				local var_44_1 = arg_39_0.seaAnimator

				var_1.SetActionCallBack(var_44_1, nil)
				arg_43_0()
			end

			return
		end)

		local var_43_1 = arg_39_0.seaAnimator

		var_1.SetAction(var_43_1, "victory", 0, true)

		return
	end

	seriesAsync = var_1_10004

	var_1_10004({
		var_39_0,
		var_39_1
	})

	return
end

function var_0_0.CreateMonster(arg_45_0, arg_45_1)
	local var_45_0 = 1

	ys = var_1_10003

	local var_45_1 = var_1_10003.Battle.BattleDataFunction.CreateBattleUnitData
	local var_45_2 = var_45_0

	ys = var_1_10005

	local var_45_3 = var_45_1(var_45_2, var_1_10005.Battle.BattleConst.UnitType.ENEMY_UNIT, -1, var_0_2, nil, {}, nil, nil, false, 1, 1, nil, nil, 1)

	var_3.SetPosition(var_45_3, var_0_1)
	var_3:ActiveCldBox()

	local var_45_4 = arg_45_0._cldSystem

	var_4.InitShipCld(var_45_4, var_3)

	local var_45_5 = var_0_5(var_3:GetTemplate().fx_container)

	ys = var_5

	local var_45_6 = var_5.Battle.BattleResourceManager.GetInstance()

	var_5.InstCharacter(var_45_6, var_3:GetTemplate().prefab, function(arg_46_0)
		local var_46_0 = var_45_5

		var_1.SetGo(var_46_0, arg_46_0)

		local var_46_1 = var_0
		local var_46_2 = var_1.GetTemplate(var_46_1).scale / 50
		local var_46_3 = arg_46_0.transform

		Vector3 = var_3
		var_46_3.localScale = var_3(var_46_2, var_46_2, var_46_2)
		arg_46_0.transform.localPosition = var_0_1

		local var_46_4 = arg_46_0.transform

		Vector3 = var_3
		var_46_4.localEulerAngles = var_3(30, 0, 0)

		local var_46_5 = var_0
		local var_46_6 = var_2.GetTemplate(var_46_5).wave_fx

		ys = var_46_5

		local var_46_7 = var_46_5.Battle.BattleFXPool.GetInstance()
		local var_46_8 = var_3.GetCharacterFX(var_46_7, var_46_6, var_45_5)

		pg = var_46_7

		local var_46_9 = var_46_7.EffectMgr.GetInstance()
		local var_46_10 = var_5.PlayBattleEffect
		local var_46_11 = var_46_8

		Vector3 = var_2_10008

		var_46_10(var_46_9, var_46_11, var_2_10008(0, 0, 0), true)

		arg_45_0.seaEmeny = arg_46_0

		local var_46_12 = arg_45_0
		local var_46_13 = arg_46_0.transform

		var_46_12.seaEmenyAnimator = var_6.GetComponent(var_46_13, "SpineAnim")
		setActive = var_46_12

		var_46_12(arg_46_0, false)
		arg_45_1()

		return
	end)

	arg_45_0.unitList[var_45_0] = var_3

	return
end

function var_0_0.CreateItemBox(arg_47_0, arg_47_1)
	pg = var_1_10002

	local var_47_0 = var_1_10002.enemy_data_statistics[var_0_3]

	ys = var_3

	local var_47_1 = var_3.Battle.BattleResourceManager.GetInstance()

	var_3.InstCharacter(var_47_1, var_47_0.prefab, function(arg_48_0)
		local var_48_0 = var_47_0.scale / 50
		local var_48_1 = arg_48_0.transform

		Vector3 = var_2_10003
		var_48_1.localScale = var_2_10003(var_48_0, var_48_0, var_48_0)
		arg_48_0.transform.localPosition = var_0_4

		local var_48_2 = arg_48_0.transform

		Vector3 = var_3
		var_48_2.localEulerAngles = var_3(30, 0, 0)
		arg_47_0.seaItemBox = arg_48_0

		local var_48_3 = arg_47_0
		local var_48_4 = arg_48_0.transform

		var_48_3.seaItemBoxAnimator = var_3.GetComponent(var_48_4, "SpineAnim")
		setActive = var_48_3

		var_48_3(arg_48_0, false)
		arg_47_1()

		return
	end)

	return
end

function var_0_0.playShipAnims(arg_49_0)
	if arg_49_0.loaded and arg_49_0.seaAnimator then
		local var_49_0 = {
			"attack",
			"victory",
			"dead"
		}

		local function var_49_1(arg_50_0)
			if arg_49_0.seaAnimator then
				local var_50_0 = arg_49_0.seaAnimator

				var_1.SetActionCallBack(var_50_0, nil)
			end

			local var_50_1 = arg_49_0.seaAnimator

			var_1.SetAction(var_50_1, var_49_0[arg_50_0], 0, false)

			local var_50_2 = arg_49_0.seaAnimator

			var_1.SetActionCallBack(var_50_2, function(arg_51_0)
				if arg_51_0 == "finish" then
					local var_51_0 = arg_49_0.seaAnimator

					var_1.SetActionCallBack(var_51_0, nil)

					local var_51_1 = arg_49_0.seaAnimator

					var_1.SetAction(var_51_1, "stand", 0, false)
				end

				return
			end)

			return
		end

		if arg_49_0.palyAnimTimer then
			local var_49_2 = arg_49_0.palyAnimTimer

			var_3.Stop(var_49_2)

			arg_49_0.palyAnimTimer = nil
		end

		Timer = var_3
		arg_49_0.palyAnimTimer = var_3.New(function()
			local var_52_0 = var_49_1

			math = var_2_10001

			var_52_0(var_2_10001.random(1, #var_49_0))

			return
		end, 5, -1)

		local var_49_3 = arg_49_0.palyAnimTimer

		var_3.Start(var_49_3)
		arg_49_0.palyAnimTimer.func()
	end

	return
end

function var_0_0.onWeaponUpdate(arg_53_0)
	if arg_53_0.loaded and arg_53_0.weaponIds then
		if arg_53_0.seaAnimator then
			local var_53_0 = arg_53_0.seaAnimator

			var_1.SetActionCallBack(var_53_0, nil)
		end

		local function var_53_1()
			pairs = var_2_10000

			local var_54_0

			if not arg_53_0.weaponList then
				var_54_0 = {}
			end

			for iter_54_0, iter_54_1 in var_2_10000(var_54_0) do
				pairs = var_2_10005

				local var_54_1

				if not iter_54_1.emitterList then
					var_54_1 = {}
				end

				for iter_54_2, iter_54_3 in var_2_10005(var_54_1) do
					iter_54_3:Destroy()
				end
			end

			ipairs = var_0

			local var_54_2

			if not arg_53_0.bulletList then
				var_54_2 = {}
			end

			for iter_54_4, iter_54_5 in var_0(var_54_2) do
				Object = var_2_10005

				var_2_10005.Destroy(iter_54_5._go)
			end

			pairs = var_0

			local var_54_3

			if not arg_53_0.aircraftList then
				var_54_3 = {}
			end

			for iter_54_6, iter_54_7 in var_0(var_54_3) do
				Object = var_2_10005

				var_2_10005.Destroy(iter_54_7.obj)
			end

			arg_53_0.bulletList = {}
			arg_53_0.aircraftList = {}

			return
		end

		if #arg_53_0.weaponIds == 0 and arg_53_0.playRandomAnims then
			if arg_53_0._fireTimer then
				local var_53_2 = arg_53_0._fireTimer

				var_2.Stop(var_53_2)
			end

			if arg_53_0._delayTimer then
				local var_53_3 = arg_53_0._delayTimer

				var_2.Stop(var_53_3)
			end

			local var_53_4 = arg_53_0.shipVO
			local var_53_5 = var_2.getShipType(var_53_4)

			ShipType = var_53_4

			if var_53_5 ~= var_53_4.WeiXiu then
				var_53_1()
			elseif arg_53_0.buffTimer then
				pg = var_2

				local var_53_6 = var_2.TimeMgr.GetInstance()

				var_2.RemoveBattleTimer(var_53_6, arg_53_0.buffTimer)

				arg_53_0.buffTimer = nil
			end

			arg_53_0:playShipAnims()
		else
			local var_53_7 = arg_53_0.shipVO
			local var_53_8 = var_2.getShipType(var_53_7)

			ShipType = var_53_7

			local var_53_9

			if var_53_8 ~= var_53_7.WeiXiu then
				var_53_1()

				var_53_9 = arg_53_0

				arg_53_0.MakeWeapon(var_53_9, arg_53_0.weaponIds)
			elseif arg_53_0.weaponIds[1] then
				Equipment = var_53_9

				local var_53_10 = var_53_9.getConfigData(var_2).skill_id[1]

				arg_53_0:MakeBuff(var_53_10)
			end
		end
	end

	return
end

function var_0_0.SeaFire(arg_55_0)
	local var_55_0 = 1
	local var_55_1

	;(function()
		if arg_55_0.weaponList[var_55_0] then
			local function var_56_0()
				local var_57_0 = 1
				local var_57_1 = 0

				ipairs = var_3_10002

				for iter_57_0, iter_57_1 in var_3_10002(var_0.emitterList) do
					iter_57_1:Ready()
				end

				ipairs = var_2

				for iter_57_2, iter_57_3 in var_2(var_0.emitterList) do
					iter_57_3:Fire(nil, var_57_0, var_57_1)
				end

				var_55_0 = var_55_0 + 1

				return
			end

			if var_0.tmpData.action_index ~= "" then
				var_2_10002 = arg_55_0
				var_2_10002.characterAction = var_0.tmpData.action_index
				var_2_10003 = arg_55_0.seaAnimator

				var_2_10002.SetAction(var_2_10003, arg_55_0.characterAction, 0, false)

				var_2_10003 = arg_55_0.seaAnimator

				var_2_10002.SetActionCallBack(var_2_10003, function(arg_58_0)
					if arg_58_0 == "action" then
						var_56_0()
					end

					return
				end)
			else
				var_56_0()
			end

			var_2_10002 = var_0.tmpData.type
			ys = var_2_10003

			if var_2_10002 == var_2_10003.Battle.BattleConst.EquipmentType.PREVIEW_ARICRAFT then
				var_2_10002 = arg_55_0
				Timer = var_3
				var_2_10002.timer = var_3.New(var_0, 1.5, 1)

				local var_56_1 = arg_55_0.timer

				var_2_10002.Start(var_56_1)
			end
		else
			local var_56_2 = arg_55_0.characterAction

			ys = var_2_10002

			if var_56_2 ~= var_2_10002.Battle.BattleConst.ActionName.MOVE then
				local var_56_3 = arg_55_0

				ys = var_2
				var_56_3.characterAction = var_2.Battle.BattleConst.ActionName.MOVE

				local var_56_4 = arg_55_0.seaAnimator

				var_1.SetAction(var_56_4, arg_55_0.characterAction, 0, true)

				var_55_0 = 1
			end
		end

		return
	end)()

	return
end

function var_0_0.MakeBuff(arg_59_0, arg_59_1)
	getSkillConfig = var_1_10002

	local var_59_0 = var_1_10002(arg_59_1).effect_list[1].arg_list.skill_id
	local var_59_1 = var_2.effect_list[1].arg_list.time

	pg = var_1_10005

	local var_59_2 = var_1_10005.skillCfg["skill_" .. var_59_0]

	if arg_59_0.buffTimer then
		pg = var_6

		local var_59_3 = var_6.TimeMgr.GetInstance()

		var_6.RemoveBattleTimer(var_59_3, arg_59_0.buffTimer)

		arg_59_0.buffTimer = nil
	end

	pg = var_6

	local var_59_4 = var_6.TimeMgr.GetInstance()

	arg_59_0.buffTimer = var_6.AddBattleTimer(var_59_4, "buffTimer", -1, var_59_1, function()
		setActive = var_2_10000

		var_2_10000(arg_59_0.healTF, true)

		setText = var_2_10000

		local var_60_0 = arg_59_0.healTF

		var_2_10000(var_1.Find(var_60_0, "text"), var_59_2.effect_list[1].arg_list.number)

		return
	end)

	return
end

function var_0_0.MakeWeapon(arg_61_0, arg_61_1)
	arg_61_0.weaponList = {}
	arg_61_0.bulletList = {}
	arg_61_0.aircraftList = {}

	local var_61_0 = 0

	ys = var_1_10003

	local var_61_1 = var_1_10003.Battle.BattleConst

	ipairs = var_1_10004

	for iter_61_0, iter_61_1 in var_1_10004(arg_61_1) do
		Equipment = var_1_10009
		var_1_10009 = var_1_10009.getConfigData(iter_61_1).weapon_id
		ipairs = var_10

		for iter_61_2, iter_61_3 in var_10(var_1_10009) do
			if iter_61_3 <= 0 then
				break
			end

			var_61_0 = var_61_0 + 1
			ys = var_15

			if var_15.Battle.BattleDataFunction.GetWeaponPropertyDataFromID(iter_61_3).type == var_61_1.EquipmentType.MAIN_CANNON or var_15.type == var_61_1.EquipmentType.SUB_CANNON or var_15.type == var_61_1.EquipmentType.TORPEDO or var_15.type == var_61_1.EquipmentType.MANUAL_TORPEDO or var_15.type == var_61_1.EquipmentType.POINT_HIT_AND_LOCK then
				type = var_16

				if var_16(var_15.barrage_ID) == "table" then
					local var_61_2 = arg_61_0.weaponList

					var_61_2[var_61_0] = {
						tmpData = var_15,
						emitterList = {}
					}
					ipairs = var_61_2

					for iter_61_4, iter_61_5 in var_61_2(var_15.barrage_ID) do
						local var_61_3 = arg_61_0:createEmitterCannon(iter_61_5, var_15.bullet_ID[iter_61_4], var_15.spawn_bound)

						arg_61_0.weaponList[var_61_0].emitterList[iter_61_4] = var_61_3
					end
				end
			elseif var_15.type == var_61_1.EquipmentType.PREVIEW_ARICRAFT then
				type = var_16

				if var_16(var_15.barrage_ID) == "table" then
					local var_61_4 = arg_61_0.weaponList

					var_61_4[var_61_0] = {
						tmpData = var_15,
						emitterList = {}
					}
					ipairs = var_61_4

					for iter_61_6, iter_61_7 in var_61_4(var_15.barrage_ID) do
						local var_61_5 = arg_61_0:createEmitterAir(iter_61_7, var_15.bullet_ID[iter_61_6], var_15.spawn_bound)

						arg_61_0.weaponList[var_61_0].emitterList[iter_61_6] = var_61_5
					end
				end
			end
		end
	end

	return
end

function var_0_0.createEmitterCannon(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	local function var_62_0(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
		ys = var_2_10005

		local var_63_0 = var_2_10005.Battle.BattlePlayerUnit.New
		local var_63_1 = 1

		ys = var_2_10007

		local var_63_2 = var_63_0(var_63_1, var_2_10007.Battle.BattleConfig.FRIENDLY_CODE)
		local var_63_3 = {
			speed = 0
		}

		var_63_2:SetSkinId(arg_62_0.shipVO.skinId)
		var_63_2:SetTemplate(arg_62_0.shipVO.configId, var_63_3)

		local var_63_4
		local var_63_5 = arg_62_0
		local var_63_6 = var_8.GetCharacterOffset(var_63_5)

		ys = var_63_5

		local var_63_7 = var_63_5.Battle.BattleDataFunction.CreateBattleBulletData
		local var_63_8 = arg_62_2
		local var_63_9 = arg_62_2
		local var_63_10 = var_63_2
		local var_63_11 = var_63_4

		Vector3 = var_2_10014

		local var_63_12, var_63_13 = var_63_7(var_63_8, var_63_9, var_63_10, var_63_11, var_63_6 + var_2_10014(40, 0, 0))

		if var_63_13 then
			local var_63_14 = arg_62_0._cldSystem

			var_11.InitBulletCld(var_63_14, var_63_12)
		end

		var_63_12:SetOffsetPriority(arg_63_3)
		var_63_12:SetShiftInfo(arg_63_0, arg_63_1)
		var_63_12:SetRotateInfo(nil, 0, arg_63_2)

		if arg_62_0.equipSkinId > 0 then
			pg = var_11

			local var_63_15 = var_11.equip_skin_template[arg_62_0.equipSkinId]

			ys = var_12

			local var_63_16, var_63_17, var_63_18, var_63_19 = var_12.Battle.BattleDataFunction.GetEquipSkin(arg_62_0.equipSkinId)
			local var_63_20 = var_63_12
			local var_63_21 = var_63_12.GetType(var_63_20)

			ys = var_63_20

			local var_63_22 = var_63_20.Battle.BattleConst.BulletType
			local var_63_23

			if var_63_21 == var_63_22.CANNON or var_63_21 == var_63_22.BOMB then
				local var_63_24 = {}

				EquipType = var_2_10020
				var_63_24[1] = var_2_10020.CannonQuZhu
				EquipType = var_20
				var_63_24[2] = var_20.CannonQingXun
				EquipType = var_20
				var_63_24[3] = var_20.CannonZhongXun
				EquipType = var_20
				var_63_24[4] = var_20.CannonZhanlie
				EquipType = var_20
				var_63_24[5] = var_20.CannonZhongXun2
				_ = var_20

				if var_20.any(var_63_24, function(arg_64_0)
					table = var_3_10001

					return var_3_10001.contains(var_63_15.equip_type, arg_64_0)
				end) then
					var_2_10021 = var_63_12

					var_63_12.SetModleID(var_2_10021, var_63_16)
				else
					if var_63_17 then
						local var_63_25 = #var_63_17

						if 0 < var_63_25 then
							var_2_10021 = var_63_12

							var_63_12.SetModleID(var_2_10021, var_63_17)

							goto label_63_0
						end
					end

					if var_63_19 then
						local var_63_26 = #var_63_19

						if 0 < var_63_26 then
							var_2_10021 = var_63_12

							var_63_12.SetModleID(var_2_10021, var_63_19)
						end
					end
				end
			elseif var_63_21 == var_63_22.TORPEDO then
				table = var_19

				local var_63_27 = var_19.contains
				local var_63_28 = var_63_15.equip_type

				EquipType = var_2_10021

				if var_63_27(var_63_28, var_2_10021.Torpedo) then
					var_63_12:SetModleID(var_63_16)
				elseif var_63_18 and #var_63_18 > 0 then
					var_63_12:SetModleID(var_63_18)
				end
			end

			::label_63_0::
		end

		local var_63_29 = var_63_12
		local var_63_30 = var_63_12.GetType(var_63_29)

		ys = var_63_29

		local var_63_31 = var_63_29.Battle.BattleConst.BulletType
		local var_63_32

		if var_63_30 == var_63_31.CANNON then
			ys = var_14
			var_63_32 = var_14.Battle.BattleCannonBullet.New()
		elseif var_63_30 == var_63_31.BOMB then
			ys = var_14
			var_63_32 = var_14.Battle.BattleBombBullet.New()
		elseif var_63_30 == var_63_31.TORPEDO then
			ys = var_14
			var_63_32 = var_14.Battle.BattleTorpedoBullet.New()
		else
			ys = var_14
			var_63_32 = var_14.Battle.BattleBullet.New()
		end

		var_63_32:SetBulletData(var_63_12)

		table = var_14

		var_14.insert(arg_62_0.bulletUnitList, var_63_12)

		local function var_63_33(arg_65_0)
			local var_65_0 = var_63_32

			var_1.SetGO(var_65_0, arg_65_0)

			local var_65_1 = var_63_32

			var_1.AddRotateScript(var_65_1)

			tf = var_1

			if var_1(arg_65_0).parent then
				tf = var_1
				var_1(arg_65_0).parent = nil
			end

			local var_65_2

			if not arg_62_0.boneList[arg_62_3] then
				Vector3 = var_65_2
				var_65_2 = var_65_2.zero
			end

			local var_65_3 = arg_62_0
			local var_65_4 = var_2.GetCharacterOffset(var_65_3)
			local var_65_5 = var_63_32

			var_3.SetSpawn(var_65_5, var_65_4 + var_65_2)

			if arg_62_0.bulletList then
				table = var_3

				var_3.insert(arg_62_0.bulletList, var_63_32)
			end

			return
		end

		ys = var_15

		local var_63_34 = var_15.Battle.BattleResourceManager.GetInstance()

		var_15.InstBullet(var_63_34, var_63_32:GetModleID(), function(arg_66_0)
			var_63_33(arg_66_0)

			return
		end)

		return
	end

	local function var_62_1()
		return
	end

	local var_62_2 = "BattleBulletEmitter"

	ys = var_1_10007

	return (var_1_10007.Battle[var_62_2].New(var_62_0, var_62_1, arg_62_1))
end

function var_0_0.createEmitterAir(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local function var_68_0(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
		local var_69_0 = {
			id = arg_68_2
		}

		pg = var_6
		var_69_0.tmpData = var_6.aircraft_template[arg_68_2]
		math = var_7

		local var_69_1 = var_7.deg2Rad * arg_69_2

		Vector3 = var_2_10008
		math = var_2_10009

		local var_69_2 = var_2_10009.cos(var_69_1)
		local var_69_3 = 0

		math = var_2_10011

		local var_69_4 = var_2_10008(var_69_2, var_69_3, var_2_10011.sin(var_69_1))

		local function var_69_5(arg_70_0)
			local var_70_0 = arg_68_0
			local var_70_1 = var_1.GetCharacterOffset(var_70_0)

			Vector3 = var_70_0

			local var_70_2 = var_70_1 + var_70_0(var_0.position_offset[1] + arg_69_0, var_0.position_offset[2], var_0.position_offset[3] + arg_69_1)

			arg_70_0.transform.localPosition = var_70_2

			local var_70_3 = arg_70_0.transform

			Vector3 = var_4
			var_70_3.localScale = var_4(0.1, 0.1, 0.1)
			var_69_0.obj = arg_70_0
			var_69_0.tf = arg_70_0.transform
			var_69_0.pos = var_70_2

			local var_70_4 = var_69_0

			ys = var_4
			var_70_4.baseVelocity = var_4.Battle.BattleFormulas.ConvertAircraftSpeed(var_69_0.tmpData.speed)
			var_69_0.speed = var_69_4 * var_69_0.baseVelocity

			local var_70_5 = var_69_0

			math = var_4
			var_70_5.speedZ = (var_4.random() - 0.5) * 0.5
			var_69_0.targetZ = var_70_1.z

			if arg_68_0.aircraftList then
				table = var_3

				var_3.insert(arg_68_0.aircraftList, var_69_0)
			end

			return
		end

		local var_69_6 = var_6.model_ID
		local var_69_7

		if arg_68_0.equipSkinId > 0 then
			pg = var_69_7
			var_69_7 = var_69_7.equip_skin_template[arg_68_0.equipSkinId]

			local var_69_8 = {}

			EquipType = var_2_10013
			var_69_8[1] = var_2_10013.FighterAircraft
			EquipType = var_13
			var_69_8[2] = var_13.TorpedoAircraft
			EquipType = var_13
			var_69_8[3] = var_13.BomberAircraft
			table = var_13

			if var_13.contains(var_69_7.equip_type, var_69_8[var_6.type]) then
				ys = var_13
				var_69_6 = var_13.Battle.BattleDataFunction.GetEquipSkin(arg_68_0.equipSkinId)
			end
		end

		ys = var_69_7

		local var_69_9 = var_69_7.Battle.BattleResourceManager.GetInstance()

		var_11.InstAirCharacter(var_69_9, var_69_6, function(arg_71_0)
			var_69_5(arg_71_0)

			return
		end)

		return
	end

	local function var_68_1()
		return
	end

	local var_68_2 = "BattleBulletEmitter"

	ys = var_1_10007

	return (var_1_10007.Battle[var_68_2].New(var_68_0, var_68_1, arg_68_1))
end

function var_0_0.RemoveBullet(arg_73_0, arg_73_1, arg_73_2)
	table = var_1_10003

	var_1_10003.remove(arg_73_0.bulletUnitList, arg_73_1)

	local var_73_0 = arg_73_0.bulletList[arg_73_1]

	Object = var_4

	var_4.Destroy(var_73_0._go)

	table = var_4

	var_4.remove(arg_73_0.bulletList, arg_73_1)

	if arg_73_2 and var_73_0:GetMissFXID() and var_4 ~= "" then
		local var_73_1 = arg_73_0.seaFXPool
		local var_73_2, var_73_3 = var_5.GetFX(var_73_1, var_4)

		pg = var_7

		local var_73_4 = var_7.EffectMgr.GetInstance()

		var_7.PlayBattleEffect(var_73_4, var_73_2, var_73_0:GetPosition() + var_73_3, true)
	end

	return
end

function var_0_0.SeaUpdate(arg_74_0)
	if not arg_74_0.bulletList then
		return
	end

	local var_74_0 = 0
	local var_74_1 = -20
	local var_74_2 = 60
	local var_74_3 = 0
	local var_74_4 = 60

	ys = var_1_10006

	local var_74_5 = var_1_10006.Battle.BattleConfig

	ys = var_1_10007

	local var_74_6 = var_1_10007.Battle.BattleConst

	local function var_74_7()
		for iter_75_0 = #arg_74_0.bulletUnitList, 1, -1 do
			local var_75_0 = arg_74_0.bulletUnitList[iter_75_0]
			local var_75_1 = arg_74_0._cldSystem

			var_5.UpdateBulletCld(var_75_1, var_75_0)
		end

		for iter_75_1 = #arg_74_0.bulletList, 1, -1 do
			local var_75_2 = arg_74_0.bulletList[iter_75_1]._bulletData
			local var_75_3 = var_5.GetSpeed(var_75_2)()

			if var_4:GetPosition().x > var_74_2 and var_75_3.x > 0 or var_6.z < var_74_3 and var_75_3.z < 0 then
				local var_75_4 = arg_74_0

				var_7.RemoveBullet(var_75_4, iter_75_1, false)

				goto label_75_0
			end

			if var_6.x < var_74_1 and var_75_3.x < 0 and var_4:GetType() ~= var_74_6.BulletType.BOMB then
				local var_75_5 = arg_74_0

				var_7.RemoveBullet(var_75_5, iter_75_1, false)

				goto label_75_0
			end

			pg = var_7

			local var_75_6 = var_7.TimeMgr.GetInstance()
			local var_75_7 = var_7.GetCombatTime(var_75_6)
			local var_75_8 = var_4._bulletData

			var_8.Update(var_75_8, var_75_7)
			var_4:Update(var_74_0)

			if not (var_6.z > var_74_4) or not (var_75_3.z > 0) then
				do
					local var_75_9 = var_4._bulletData

					if var_8.IsOutRange(var_75_9, var_74_0) then
						local var_75_10 = arg_74_0

						var_8.RemoveBullet(var_75_10, iter_75_1, true)
					end
				end

				::label_75_0::
			end
		end

		ipairs = var_0

		for iter_75_2, iter_75_3 in var_0(arg_74_0.aircraftList) do
			if (iter_75_3.pos + iter_75_3.speed).y < var_74_5.AircraftHeight + 5 then
				local var_75_11 = iter_75_3.speed

				math = var_7
				var_75_11.y = var_7.max(0.4, 1 - var_5.y / var_74_5.AircraftHeight)
				math = var_75_11

				local var_75_12 = var_75_11.min(1, var_5.y / var_74_5.AircraftHeight)
				local var_75_13 = iter_75_3.tf

				Vector3 = var_8
				var_75_13.localScale = var_8(var_75_12, var_75_12, var_75_12)
			end

			iter_75_3.speed.z = iter_75_3.baseVelocity * iter_75_3.speedZ

			if iter_75_3.targetZ - var_5.z > iter_75_3.baseVelocity then
				iter_75_3.speed.z = iter_75_3.baseVelocity * 0.5
			elseif var_6 < -iter_75_3.baseVelocity then
				iter_75_3.speed.z = -iter_75_3.baseVelocity * 0.5
			else
				local var_75_14 = arg_74_0
				local var_75_15 = var_7.GetCharacterOffset(var_75_14).z
				local var_75_16 = var_7.z

				math = var_2_10010
				iter_75_3.targetZ = var_75_15 + var_75_16 * (var_2_10010.random() - 0.5) * 0.6
			end

			if var_5.x > var_74_2 or var_5.x < var_74_1 then
				Object = var_7

				var_7.Destroy(iter_75_3.obj)

				table = var_7

				var_7.remove(arg_74_0.aircraftList, iter_75_2)
			else
				iter_75_3.tf.localPosition = var_5
				iter_75_3.pos = var_5
			end
		end

		var_74_0 = var_74_0 + 1

		return
	end

	pg = var_1_10009

	local var_74_8 = var_1_10009.TimeMgr.GetInstance()

	var_9.AddBattleTimer(var_74_8, "barrageUpdateTimer", -1, 0.033, var_74_7)

	return
end

function var_0_0.GetCharacterOffset(arg_76_0)
	Vector3 = var_1_10001

	return var_1_10001(0, -3, 40)
end

function var_0_0.GetTotalBounds(arg_77_0)
	local var_77_0 = ({
		-70,
		20,
		90,
		70
	})[1]
	local var_77_1 = var_1[1] + var_1[3]
	local var_77_2 = var_1[2] + var_1[4]
	local var_77_3 = var_1[2]

	return var_77_2, var_77_3, var_77_0, var_77_1
end

function var_0_0.HandleShipCrashDecelerate(arg_78_0)
	return
end

function var_0_0.HandleShipCrashDecelerate(arg_79_0)
	return
end

function var_0_0.HandleShipCrashDamageList(arg_80_0)
	return
end

function var_0_0.HandleBulletHit(arg_81_0, arg_81_1, arg_81_2)
	for iter_81_0 = #arg_81_0.bulletUnitList, 1, -1 do
		if arg_81_0.bulletUnitList[iter_81_0] == arg_81_1 then
			arg_81_0:RemoveBullet(iter_81_0, true)
		end
	end

	if not arg_81_0.isFinish then
		arg_81_0.isFinish = true
		setActive = var_3

		var_3(arg_81_0.seaEmeny, false)

		ys = var_3

		local var_81_0 = var_3.Battle.BattleFXPool.GetInstance()
		local var_81_1, var_81_2 = var_3.GetFX(var_81_0, "Bomb")

		pg = var_5

		local var_81_3 = var_5.EffectMgr.GetInstance()

		var_5.PlayBattleEffect(var_81_3, var_81_1, var_81_2:Add(arg_81_2:GetPosition()), true)
	end

	return
end

function var_0_0.HandleWallHitByBullet(arg_82_0)
	return
end

function var_0_0.GetUnitList(arg_83_0)
	return arg_83_0.unitList
end

function var_0_0.GetAircraftList(arg_84_0)
	return {}
end

function var_0_0.GetBulletList(arg_85_0)
	return arg_85_0.bulletUnitList
end

function var_0_0.GetAOEList(arg_86_0)
	return {}
end

function var_0_0.GetFriendlyCode(arg_87_0)
	return 1
end

function var_0_0.GetFoeCode(arg_88_0)
	return -1
end

function var_0_0.clear(arg_89_0)
	if arg_89_0.animTimer then
		local var_89_0 = arg_89_0.animTimer

		var_1.Stop(var_89_0)

		arg_89_0.animTimer = nil
	end

	if arg_89_0._cldSystem then
		local var_89_1 = arg_89_0._cldSystem

		var_1.Dispose(var_89_1)
	end

	if arg_89_0.timer then
		local var_89_2 = arg_89_0.timer

		var_1.Stop(var_89_2)

		arg_89_0.timer = nil
	end

	pg = var_1

	local var_89_3 = var_1.TimeMgr.GetInstance()

	var_1.RemoveAllBattleTimer(var_89_3)

	if arg_89_0.seaCharacter then
		Destroy = var_1

		var_1(arg_89_0.seaCharacter)

		arg_89_0.seaCharacter = nil
	end

	if arg_89_0.otherShipGos then
		ipairs = var_1

		for iter_89_0, iter_89_1 in var_1(arg_89_0.otherShipGos) do
			Destroy = var_1_10006

			var_1_10006(iter_89_1)
		end

		arg_89_0.otherShipGos = nil
	end

	if arg_89_0.aircraftList then
		ipairs = var_1

		for iter_89_2, iter_89_3 in var_1(arg_89_0.aircraftList) do
			Destroy = var_1_10006

			var_1_10006(iter_89_3.obj)
		end

		arg_89_0.aircraftList = nil
	end

	if arg_89_0.seaView then
		local var_89_4 = arg_89_0.seaView

		var_1.Dispose(var_89_4)

		arg_89_0.seaView = nil
	end

	if arg_89_0.weaponList then
		ipairs = var_1

		for iter_89_4, iter_89_5 in var_1(arg_89_0.weaponList) do
			ipairs = var_1_10006

			for iter_89_6, iter_89_7 in var_1_10006(iter_89_5.emitterList) do
				iter_89_7:Destroy()
			end
		end

		arg_89_0.weaponList = nil
	end

	if arg_89_0.bulletList then
		ipairs = var_1

		for iter_89_8, iter_89_9 in var_1(arg_89_0.bulletList) do
			Destroy = var_1_10006

			var_1_10006(iter_89_9._go)
		end

		arg_89_0.bulletList = nil
	end

	if arg_89_0.seaFXPool then
		local var_89_5 = arg_89_0.seaFXPool

		var_1.Clear(var_89_5)

		arg_89_0.seaFXPool = nil
	end

	if arg_89_0.seaEmeny then
		Destroy = var_1

		var_1(arg_89_0.seaEmeny)

		arg_89_0.seaEmeny = nil
	end

	if arg_89_0.seaItemBox then
		Destroy = var_1

		var_1(arg_89_0.seaItemBox)

		arg_89_0.seaItemBox = nil
	end

	if arg_89_0.seaFXContainersPool then
		local var_89_6 = arg_89_0.seaFXContainersPool

		var_1.Clear(var_89_6)

		arg_89_0.seaFXContainersPool = nil
	end

	ys = var_1

	local var_89_7 = var_1.Battle.BattleResourceManager.GetInstance()

	var_1.Clear(var_89_7)

	arg_89_0.seaCamera.enabled = false
	arg_89_0.seaCameraGO = nil
	arg_89_0.seaCamera = nil
	arg_89_0.loaded = false

	if arg_89_0.palyAnimTimer then
		local var_89_8 = arg_89_0.palyAnimTimer

		var_2.Stop(var_89_8)

		arg_89_0.palyAnimTimer = nil
	end

	return
end

return var_0_0
